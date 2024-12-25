import 'dart:async';

import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:storedgev2/core/config/router/route_enum.dart';
import 'package:storedgev2/features/supplier/application/supplier_provider.dart';
import 'package:storedgev2/features/supplier/data/supplier_service.dart';

import '../../../core/constants/constants.dart';

class SupplierDatailsScreen extends ConsumerStatefulWidget {
  final String id;

  const SupplierDatailsScreen({super.key, required this.id});

  @override
  ConsumerState<SupplierDatailsScreen> createState() =>
      _SupplierDatailsScreenState();
}

class _SupplierDatailsScreenState extends ConsumerState<SupplierDatailsScreen>
    with TickerProviderStateMixin {
  final _duration = 750;
  final _delay = 150;

  late final _animatedMapController = AnimatedMapController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
    cancelPreviousAnimations: true,
  );

  Future<void> _deleteItem() async {
    final firestoreService = ref.read(supplierServiceProvider.notifier);
    firestoreService.deleteSupplier(widget.id);
  }

  final List<bool> _isVisible = List.filled(7, false);

  void _showWidgetsWithDelays() {
    for (int i = 0; i < _isVisible.length; i++) {
      Future.delayed(Duration(milliseconds: 200 + _delay * i), () {
        setState(() {
          _isVisible[i] = true;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _showWidgetsWithDelays();
  }

  @override
  void dispose() {
    _animatedMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final supplierStream = ref.watch(supplierProvider(widget.id));
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: supplierStream.when(
          data: (supplier) => SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    floating: true,
                    actions: [
                      IconButton(
                          onPressed: () async {
                            final bool shouldPop =
                                await _dialogBuilder(context) ?? false;
                            if (context.mounted && shouldPop) {
                              Navigator.pop(context);
                            }
                          },
                          icon: const Icon(Icons.delete),
                          color: Colors.red)
                    ]),
                SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: primaryColor,
                          child: Text(
                            supplier.name[0].toUpperCase(),
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        SizedBox(
                          height: defaultPadding,
                        ),
                        Text(
                          supplier.name,
                          style: textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: defaultPadding,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact",
                          style: textTheme.titleLarge,
                        ),
                        Text(
                          supplier.contact,
                          style: textTheme.titleMedium
                              ?.copyWith(color: onSurfaceColor.withAlpha(192)),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding / 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Address",
                          style: textTheme.titleLarge,
                        ),
                        Text(
                          supplier.location.address,
                          style: textTheme.titleMedium
                              ?.copyWith(color: onSurfaceColor.withAlpha(192)),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: InkWell(
                      onTap: () {
                        showMap(
                            point: LatLng(supplier.location.latitude,
                                supplier.location.longitude));
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            color: surfaceContainer,
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadious)),
                        child: Row(children: [
                          Image.network(
                            "https://api.mapbox.com/styles/v1/mapbox/dark-v11/static/pin-l-${supplier.name[0].toLowerCase()}+FFF(${supplier.location.longitude},${supplier.location.latitude})/${supplier.location.longitude},${supplier.location.latitude},17/500x500?access_token=pk.eyJ1Ijoibm94aW91c3N0IiwiYSI6ImNsY3VsbmFnYTA2amczdW83cDEyNW10a3MifQ.MyxSDj1DbhKZ7IvDm76G8w",
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "View on Map",
                                    style: textTheme.titleLarge,
                                  ),
                                  SizedBox(
                                    height: defaultPadding / 2,
                                  ),
                                  Text(
                                    "${supplier.location.latitude}",
                                    style: textTheme.bodyMedium?.copyWith(
                                        color: onSurfaceVariant.withAlpha(160)),
                                  ),
                                  Text("${supplier.location.longitude}",
                                      style: textTheme.bodyMedium?.copyWith(
                                          color:
                                              onSurfaceVariant.withAlpha(160))),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Icon(
                              Icons.pin_drop_rounded,
                              size: 36,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Entry.all(
          visible: _isVisible[5],
          duration: Duration(milliseconds: _duration),
          scale: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 36, right: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: FilledButton(
                    onPressed: () => context.pushNamed(
                        AppRoutes.updateSupplier.routeName,
                        pathParameters: {'id': widget.id}),
                    style: FilledButton.styleFrom(
                      fixedSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadious),
                      ),
                    ),
                    child: Text("Update Supplier",
                        style: textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: onPrimaryColor)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<bool?> _dialogBuilder(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
            'Do you really want to delete this item? This processs cannot be undone.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () {
                _deleteItem();
                Navigator.pop(context, true);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMap({required LatLng point}) {
    final alignPositionStreamController = StreamController<double?>();
    const double markerSize = 48;
    const double pinSize = 36;
    const double dotSize = 10;

    return showModalBottomSheet<void>(
      backgroundColor: surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(defaultBorderRadious * 2)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      showDragHandle: true,
      enableDrag: true,
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        AlignOnUpdate alignPositionOnUpdate = AlignOnUpdate.never;

        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Stack(children: [
            FlutterMap(
                mapController: _animatedMapController.mapController,
                options: MapOptions(
                  backgroundColor: surfaceContainer,
                  interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.pinchZoom |
                          InteractiveFlag.doubleTapZoom |
                          InteractiveFlag.drag |
                          InteractiveFlag.doubleTapDragZoom),
                  initialCenter: point,
                  initialZoom: 15,
                  minZoom: 5,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://api.mapbox.com/styles/v1/mapbox/dark-v11/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoibm94aW91c3N0IiwiYSI6ImNsY3VsbmFnYTA2amczdW83cDEyNW10a3MifQ.MyxSDj1DbhKZ7IvDm76G8w',
                    tileProvider: CancellableNetworkTileProvider(),
                  ),
                  CurrentLocationLayer(
                    alignPositionStream: alignPositionStreamController.stream,
                    alignPositionOnUpdate: alignPositionOnUpdate,
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
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: dotSize,
                        height: dotSize,
                        point: point,
                        child: Icon(
                          Icons.circle,
                          size: dotSize,
                          color: surfaceColor,
                        ),
                      ),
                      Marker(
                          width: markerSize,
                          height: markerSize * 3,
                          point: point,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: pinSize * 2.75 - dotSize,
                                child: Container(
                                  width: markerSize,
                                  height: markerSize,
                                  decoration: BoxDecoration(
                                    color: surfaceColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: primaryColor, width: 4),
                                  ),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: const Icon(Icons.arrow_downward)),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: pinSize - dotSize,
                                child: Align(
                                  alignment: Alignment.center,
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
                            ],
                          )),
                    ],
                  ),
                ]),
            Align(
              alignment: Alignment.bottomRight,
              child: IntrinsicHeight(
                child: Column(
                  spacing: defaultPadding,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      height: 60,
                      onPressed: () {
                        setState(
                          () {
                            alignPositionOnUpdate = AlignOnUpdate.once;
                          }
                        );
                        alignPositionStreamController.add(17);
                      },
                      color: surfaceContainer,
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                      child: Icon(
                        Icons.my_location,
                        size: 24,
                      ),
                    ),
                    MaterialButton(
                      height: 60,
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                      color: surfaceContainer,
                      onPressed: () {
                        _animatedMapController.animateTo(dest: point, zoom: 17);
                      },
                      child: Icon(
                        Icons.person_pin_circle_rounded,
                        size: 24,
                      ),
                    ),
                    SizedBox(height: defaultPadding / 2)
                  ],
                ),
              ),
            ),
          ]);
        });
      },
    ).whenComplete(() {
      alignPositionStreamController.close();
    });
  }
}
