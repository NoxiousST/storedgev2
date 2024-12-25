import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:storedgev2/core/config/router/route_enum.dart';
import 'package:storedgev2/features/supplier/application/supplier_provider.dart';
import 'package:storedgev2/features/supplier/data/supplier_service.dart';
import 'package:storedgev2/models/location/location.dart';
import 'package:storedgev2/models/supplier/supplier.dart';

import '../../../core/constants/constants.dart';

class SupplierFormScreen extends ConsumerStatefulWidget {
  final String? id;

  const SupplierFormScreen({super.key, this.id});

  @override
  ConsumerState<SupplierFormScreen> createState() => _SupplierFormScreenState();
}

class _SupplierFormScreenState extends ConsumerState<SupplierFormScreen> {
  final _gap = 10.0;

  late final bool isEditing;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  LatLng? point;
  String? address;

  BuildContext? _progressIndicatorContext;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final location = Location(
        address: address!,
        longitude: point!.longitude,
        latitude: point!.latitude,
      );

      final supplier = Supplier(
        name: _nameController.text,
        location: location,
        contact: _contactController.text,
      );

      final firestoreService = ref.read(supplierServiceProvider.notifier);

      if (!isEditing) {
        await firestoreService.addSupplier(supplier: supplier);
      } else {
        await firestoreService.updateSupplier(supplier: supplier.copyWith(id: widget.id));
      }

      _formKey.currentState!.reset();
    }
  }

  @override
  void initState() {
    isEditing = widget.id != null;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();

    if (_progressIndicatorContext != null &&
        _progressIndicatorContext!.mounted) {
      Navigator.of(_progressIndicatorContext!).pop();
      _progressIndicatorContext = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(supplierServiceProvider, (prev, state) async {
      if (state.isLoading) {
        await showDialog(
          context: context,
          builder: (ctx) {
            _progressIndicatorContext = ctx;
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
        return;
      }

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (_progressIndicatorContext != null &&
            _progressIndicatorContext!.mounted) {
          Navigator.of(_progressIndicatorContext!).pop();
          _progressIndicatorContext = null;
        }
      });

      if (state.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Error: ${state.error}'),
          ),
        );
        return;
      }

      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(isEditing
                ? 'Supplier updated successfully!'
                : 'Supplier added successfully!')),
      );
    });

    if (isEditing) {
      final supplierAsyncValue = ref.watch(SupplierDocProvider(widget.id!));

      supplierAsyncValue.when(
        data: (supplier) {
          _nameController.text = supplier!.name;
          _contactController.text = supplier.contact;
          setState(() {
            if (address == null) {
              address = supplier.location.address;
              point = LatLng(
                  supplier.location.latitude, supplier.location.longitude);
            }
          });
        },
        loading: () => const CircularProgressIndicator(),
        error: (e, stack) => Text('Error: $e'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Supplier'),
      ),
      body: CustomScrollView(slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Name is required'
                        : null,
                  ),
                  SizedBox(height: _gap),
                  TextFormField(
                    controller: _contactController,
                    decoration: const InputDecoration(labelText: 'Contact'),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Contact is required'
                        : null,
                  ),
                  SizedBox(height: _gap * 4),
                  address == null
                      ? Card(
                          child: InkWell(
                            onTap: () async {
                              Map<String, dynamic>? result = await context
                                  .pushNamed(AppRoutes.map.routeName);

                              if (result != null) {
                                setState(() {
                                  point = result['point'];
                                  address = result['address'];
                                });
                              }
                            },
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(defaultPadding * 2),
                                child: Text(
                                  "Pin an address",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                          color:
                                              onSurfaceVariant.withAlpha(128),
                                          fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding / 2),
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundColor: primaryColor,
                                  child: Icon(
                                    Icons.pin_drop_rounded,
                                    color: surfaceColor,
                                  )),
                              title: Text("Address"),
                              subtitle: Text(address ?? ''),
                              onTap: () async {
                                Map<String, dynamic>? result = await context
                                    .pushNamed(AppRoutes.map.routeName,
                                        queryParameters: {
                                      'latitude': point?.latitude.toString(),
                                      'longitude': point?.longitude.toString()
                                    });

                                if (result != null) {
                                  setState(() {
                                    point = result['point'];
                                    address = result['address'];
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                  SizedBox(height: _gap * 4),
                  FilledButton(
                    onPressed: _submitForm,
                    child: const Text('Simpan'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
