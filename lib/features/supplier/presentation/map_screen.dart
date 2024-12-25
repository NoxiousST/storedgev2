import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:go_router/go_router.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:storedgev2/core/constants/constants.dart';

class MapScreen extends StatefulWidget {
  final LatLng? point;

  const MapScreen({super.key, this.point});

  @override
  State<StatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  static const double pointSize = 8;
  static const double pointY = 290;

  late AlignOnUpdate _alignPosOnUpdate;
  late final StreamController<double?> _alignPositionStreamController;

  late final _animatedMapController = AnimatedMapController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
    cancelPreviousAnimations: true,
  );
  final _pointController = TextEditingController();
  final _addressController = TextEditingController();

  late final bool isEditing;
  LatLng? latLng;
  Timer? timer;
  bool isMoving = false;
  double? renderedHeight = 0;
  final Debouncer debouncer = Debouncer(const Duration(milliseconds: 50));

  @override
  void initState() {
    super.initState();
    isEditing = widget.point != null;
    WidgetsBinding.instance.addPostFrameCallback((_) => updatePoint(context));
    _alignPosOnUpdate =
        widget.point == null ? AlignOnUpdate.once : AlignOnUpdate.never;
    _alignPositionStreamController = StreamController<double?>();
  }

  @override
  void dispose() {
    _animatedMapController.dispose();
    _alignPositionStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: screenHeight - pointY,
            child: FlutterMap(
              mapController: _animatedMapController.mapController,
              options: MapOptions(
                interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.pinchZoom |
                        InteractiveFlag.doubleTapZoom |
                        InteractiveFlag.drag |
                        InteractiveFlag.doubleTapDragZoom),
                onPositionChanged: (MapCamera camera, bool hasGesture) {
                  if (!hasGesture && isMoving) return;

                  locationChanged();
                },
                initialCenter: widget.point ?? LatLng(0, 0),
                initialZoom: 17,
                minZoom: 5,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://api.mapbox.com/styles/v1/mapbox/dark-v11/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoibm94aW91c3N0IiwiYSI6ImNsY3VsbmFnYTA2amczdW83cDEyNW10a3MifQ.MyxSDj1DbhKZ7IvDm76G8w',
                  tileProvider: CancellableNetworkTileProvider(),
                ),
                CurrentLocationLayer(
                  alignPositionStream: _alignPositionStreamController.stream,
                  alignPositionOnUpdate: _alignPosOnUpdate,
                  alignPositionAnimationCurve: Curves.easeInOutCubic,
                  alignPositionAnimationDuration: Duration(milliseconds: 500),
                  style: LocationMarkerStyle(
                    marker: const DefaultLocationMarker(
                      child: Icon(
                        Icons.navigation_rounded,
                        color: Colors.white,
                      ),
                    ),
                    markerSize: const Size(40, 40),
                    markerDirection: MarkerDirection.heading,
                  ),
                ),
                if (latLng != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: pointSize,
                        height: pointSize,
                        point: latLng!,
                        child: Icon(
                          Icons.circle,
                          size: 10,
                          color: surfaceColor.withAlpha(140),
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
          Positioned(
            top: pointY - pointSize / 2,
            left: _getPointX(context) - pointSize / 2 - 1,
            child: IgnorePointer(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1,
                    color: primaryColor
                  )
                ),
                child: Icon(
                  Icons.circle,
                  size: pointSize,
                  color: surfaceColor,
                ),
              ),
            ),
          ),
          MarkerWidget(
            pointY: pointY,
            isMoving: isMoving,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Flex(
                        spacing: defaultPadding,
                        mainAxisAlignment: MainAxisAlignment.end,
                        direction: _isKeyboardOpen(context) ? Axis.horizontal : Axis.vertical,
                        children: [
                          if (widget.point != null)
                            MaterialButton(
                              height: 60,
                              padding: EdgeInsets.all(16),
                              shape: CircleBorder(),
                              color: surfaceColor,
                              onPressed: () {
                                _animatedMapController.animateTo(
                                    dest: widget.point, zoom: 17);
                              },
                              child: Icon(
                                Icons.person_pin_circle_rounded,
                                size: 24,
                              ),
                            ),
                          MaterialButton(
                            height: 60,
                            padding: EdgeInsets.all(16),
                            shape: CircleBorder(),
                            color: surfaceColor,
                            onPressed: () {
                              setState(
                                  () => _alignPosOnUpdate = AlignOnUpdate.once);
                              _alignPositionStreamController.add(17);

                              locationChanged();
                            },
                            child: Icon(
                              Icons.my_location_rounded,
                              size: 24,
                            ),
                          ),
                          SizedBox(
                            height: defaultPadding / 2,
                          )
                        ],
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(defaultBorderRadious * 2),
                              topRight:
                                  Radius.circular(defaultBorderRadious * 2))),
                      margin: EdgeInsets.zero,
                      color: surfaceColor,
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Text(
                              "Detail Lokasi",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Column(
                              children: [
                                Skeletonizer(
                                  enableSwitchAnimation: true,
                                  enabled: isMoving,
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: TextField(
                                      readOnly: true,
                                      controller: _pointController,
                                      decoration: InputDecoration(
                                          label: Text("Koordinat")),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Skeletonizer(
                                  enableSwitchAnimation: true,
                                  justifyMultiLineText: false,
                                  enabled: isMoving,
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: TextField(
                                      controller: _addressController,
                                      maxLines: 2,
                                      decoration: InputDecoration(
                                          label: Text("Alamat")),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                if (!isMoving)
                                  FilledButton(
                                    onPressed: () {
                                      context.pop({
                                        'point': latLng,
                                        'address': _addressController.text
                                      });
                                    },
                                    child: const Text('Simpan'),
                                  ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void locationChanged() {
    setState(() {
      if (!isMoving) isMoving = true;
    });

    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 750), () async {
      try {
        updatePoint(context);
        await updateAddress();
      } catch (e) {
        debugPrint('Error during geocoding: $e');
      } finally {
        setState(() => isMoving = false);
      }
    });
  }

  void updatePoint(BuildContext context) {
    setState(() {
      latLng = _animatedMapController.mapController.camera
          .pointToLatLng(Point(_getPointX(context), pointY));
    });
    _pointController.text =
        '(${latLng?.latitude.toStringAsFixed(5)},${latLng?.longitude.toStringAsFixed(5)})';
  }

  Future<void> updateAddress() async {
    const String googelApiKey = 'AIzaSyCw8usxp2OtymTOp81T-4nI_wJ8mANFXao';
    final api = GoogleGeocodingApi(googelApiKey);

    final reversedSearchResults = await api.reverse(
      '${latLng!.latitude}, ${latLng!.longitude}',
      language: 'id',
    );

    _addressController.text =
        reversedSearchResults.results.first.formattedAddress;
  }

  double _getPointX(BuildContext context) =>
      MediaQuery.sizeOf(context).width / 2;

  bool _isKeyboardOpen(BuildContext context) =>
      MediaQuery.of(context).viewInsets.bottom > 0;
}

class MarkerWidget extends StatefulWidget {
  final double pointY;
  final bool isMoving;

  const MarkerWidget({super.key, required this.pointY, required this.isMoving});

  @override
  State<StatefulWidget> createState() => _MarkerWidgetState();
}

class _MarkerWidgetState extends State<MarkerWidget> {
  static const duration = Duration(milliseconds: 300);
  static const double markerSize = 48;
  static const double pinSize = 32;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: duration,
          curve: Curves.easeInOut,
          top: widget.isMoving
              ? widget.pointY - markerSize / 2 - 42 - 16
              : widget.pointY - markerSize / 2 - 42,
          left: 0,
          right: 0,
          child: Container(
            width: markerSize,
            height: markerSize,
            decoration: BoxDecoration(
              color: surfaceColor,
              shape: BoxShape.circle,
              border: Border.all(color: primaryColor, width: 4),
            ),
            child: Stack(children: [
              if (widget.isMoving)
                Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: markerSize - 15,
                      width: markerSize - 15,
                      child: Center(
                          child: CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                        strokeWidth: 2,
                      )),
                    )),
              Align(
                  alignment: Alignment.center,
                  child: const Icon(Icons.arrow_upward))
            ]),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          top: widget.isMoving
              ? widget.pointY - pinSize / 2 - 28
              : widget.pointY - pinSize / 2 - 12,
          left: 0,
          right: 0,
          child: IgnorePointer(
            child: Align(
              alignment: Alignment.topCenter,
              child: RotatedBox(
                quarterTurns: 2,
                child: Icon(
                  Icons.navigation_rounded,
                  size: pinSize,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer(this.delay);

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}
