import 'dart:developer';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:insta_assets_picker/insta_assets_picker.dart';
import 'package:storedgev2/core/constants/constants.dart';
import 'package:storedgev2/features/item/presentation/widgets/insta_picker_interface.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import '../../../../models/item/item.dart';

class ImageInput extends StatefulWidget with InstaPickerInterface {
  final Function(List<TempImage>?) onImageSelected;
  final List<String>? storageUrls;

  const ImageInput(
      {super.key, required this.onImageSelected, this.storageUrls});

  @override
  State<ImageInput> createState() => _ImageInputState();

  @override
  PickerDescription get description => const PickerDescription(
        icon: '📸',
        label: 'WeChat Camera Picker',
        description: 'Picker with a camera button.\n'
            'The camera logic is handled by the `wechat_camera_picker` package.',
      );
}

class _ImageInputState extends State<ImageInput> {
  Stream<InstaAssetsExportDetails>? cropStream;
  InstaAssetsExportDetails? result;

  List<InstaAssetsExportData?> get data => result?.data ?? [];

  List<AssetEntity> get selectedAssets => result?.selectedAssets ?? [];

  bool isEditing = false;
  late List<TempImage> tempImages;

  Future<void> _pickFromWeChatCamera(BuildContext context) async {
    Feedback.forTap(context);
    final AssetEntity? entity = await CameraPicker.pickFromCamera(
      context,
      locale: Localizations.maybeLocaleOf(context),
      pickerConfig: CameraPickerConfig(
        theme: Theme.of(context),
        enableRecording: true,
      ),
    );
    if (entity == null) return;

    if (context.mounted) {
      await InstaAssetPicker.refreshAndSelectEntity(context, entity);
    }
  }

  @override
  void initState() {
    super.initState();
    // Initial state setup based on the initial widget.storageUrls
    _updateImages(widget.storageUrls);
  }

  @override
  void didUpdateWidget(covariant ImageInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if storageUrls has changed
    if (widget.storageUrls != oldWidget.storageUrls) {
      _updateImages(widget.storageUrls);
    }
  }

  void _updateImages(List<String>? storageUrls) {
    isEditing = storageUrls != null;
    tempImages = isEditing
        ? storageUrls!
            .map((url) =>
                TempImage(exportData: null, imageUrl: url, isFile: false))
            .toList()
        : [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      dashPattern: const [6, 3],
      color: primaryColor,
      radius: const Radius.circular(defaultBorderRadious / 2),
      child: _buildImageContent(),
    );
  }

  Future<void> pickImage() async {
    await InstaAssetPicker.pickAssets(
      context,
      selectedAssets: selectedAssets,
      pickerConfig: InstaAssetPickerConfig(
        title: "Select Image",
        pickerTheme: widget.getPickerTheme(context),
        actionsBuilder: (
          BuildContext context,
          ThemeData? pickerTheme,
          double height,
          VoidCallback unselectAll,
        ) =>
            [
          InstaPickerCircleIconButton.unselectAll(
            onTap: unselectAll,
            theme: pickerTheme,
            size: height,
          ),
        ],
        specialItemBuilder: (context, _, __) {
          // return a button that open the camera
          return ElevatedButton(
            onPressed: () => _pickFromWeChatCamera(context),
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(),
              backgroundColor: Colors.transparent,
            ),
            child: FittedBox(
                fit: BoxFit.cover,
                child: Icon(
                  Icons.camera_rounded,
                  color: onSurfaceVariant.withAlpha(128),
                  size: 36,
                )),
          );
        },
        specialItemPosition: SpecialItemPosition.prepend,
      ),
      maxAssets: isEditing ? maxFiles - tempImages.length : maxFiles,
      onCompleted: (exportStream) {
        setState(() {
          cropStream = exportStream;
        });
        context.pop();
      },
    );
  }

  Widget _buildImageContent() {
    if (cropStream != null) {
      return _buildStreamContent();
    } else if (isEditing) {
      return _buildCroppedAssetsListView();
    } else {
      return _buildNoImageSelectedContent();
    }
  }

  Widget _buildStreamContent() {
    return StreamBuilder<InstaAssetsExportDetails>(
      stream: cropStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.hasData) {
          _processStreamData(snapshot.data!);
          return _buildCroppedAssetsListView();
        }
        return const Center(child: Text('No image selected'));
      },
    );
  }

  void _processStreamData(InstaAssetsExportDetails details) {
    result = details;

    final files = data
        .where((file) => file?.croppedFile != null)
        .map((file) => TempImage(
              exportData: file,
              imageUrl: null,
              isFile: true,
            ))
        .toList();

    for (var file in files) {
      if (!tempImages.any((image) =>
          image.exportData?.selectedData.asset.id ==
              file.exportData?.selectedData.asset.id &&
          tempImages.length <= maxFiles)) {
        tempImages.add(file);
      }
    }

    //log("${tempImages.length}");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onImageSelected(tempImages);
    });
  }

  Widget _buildNoImageSelectedContent() {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: InkWell(
        splashFactory: InkSparkle.splashFactory,
        onTap: pickImage,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: defaultPadding,
          children: [
            Icon(
              Icons.camera_rounded,
              color: onSurfaceColor.withAlpha(128),
            ),
            Text(
              "No image selected",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: onSurfaceColor.withAlpha(128),
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double elevation = lerpDouble(1, 6, animValue)!;
        final double scale = lerpDouble(1, 1.02, animValue)!;
        return Transform.scale(
          scale: scale,
          child: Card(
            elevation: elevation,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  Widget _buildCroppedAssetsListView() {
    //final double progress = result!.progress;

    return SizedBox(
      height: 100,
      width: double.infinity,
      child: Stack(alignment: Alignment.center, children: [
        ReorderableListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          scrollDirection: Axis.horizontal,
          proxyDecorator: proxyDecorator,
          footer: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AspectRatio(
              aspectRatio: 1,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: surfaceContainerHigh,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(defaultBorderRadious / 2),
                    )),
                onPressed: pickImage,
                child: Icon(
                  Icons.add_rounded,
                  color: onSurfaceVariant,
                  size: 36,
                ),
              ),
            ),
          ),
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              if (!isEditing) {
                reorderList(data, oldIndex, newIndex);
                reorderList(selectedAssets, oldIndex, newIndex);
              }
              reorderList(tempImages, oldIndex, newIndex);
              widget.onImageSelected(tempImages);
            });
          },
          itemBuilder: (context, index) {
            return Container(
              key: Key('$index'), // Key helps maintain state
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(defaultBorderRadious / 2),
                  child: tempImages[index].isFile
                      ? Image.file(tempImages[index].exportData!.croppedFile!)
                      : Image.network(tempImages[index].imageUrl!),
                ),
                Positioned(
                  right: -30,
                  top: -15 + 5,
                  child: MaterialButton(
                    height: 30,
                    shape: const CircleBorder(),
                    color: surfaceContainer,
                    onPressed: () {
                      setState(() {
                        if (cropStream != null && tempImages[index].isFile) {
                          final idx = tempToDataIndex(index);
                          data.removeAt(idx!);
                          selectedAssets.removeAt(idx);
                        }
                        tempImages.removeAt(index);
                        widget.onImageSelected(tempImages);
                      });
                    },
                    child: const Icon(
                      Icons.close_rounded,
                      size: 16,
                    ),
                  ),
                ),
              ]),
            );
          },
          itemCount: tempImages.length,
        ),
        /*if (progress < 1.0)
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
              ),
            ),
          ),
        if (progress < 1.0)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: SizedBox(
                height: 6,
                child: LinearProgressIndicator(
                  value: progress,
                  semanticsLabel: '${progress * 100}%',
                ),
              ),
            ),
          ),*/
      ]),
    );
  }

  void reorderList<T>(List<T> list, int oldIndex, int newIndex) {
    final T item = list.removeAt(oldIndex);
    list.insert(newIndex, item);
  }

  int? tempToDataIndex(int index) {
    final id = tempImages[index].exportData?.selectedData.asset.id;
    final dataId = data.indexWhere((d) => d?.selectedData.asset.id == id);
    log("dataId: $dataId");
    return dataId;
  }
}
