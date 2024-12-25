import 'dart:collection';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:storedgev2/features/item/application/item_provider.dart';
import 'package:storedgev2/features/item/data/item_service.dart';
import 'package:storedgev2/features/supplier/application/supplier_provider.dart';
import 'package:storedgev2/models/item/item.dart';

import 'widgets/image_input.dart';

const List<String> listCategory = <String>[
  'Graphics Card',
  'Processor',
  'Motherboard',
  'Memory'
];

class ItemFormScreen extends ConsumerStatefulWidget {
  final String? id;

  const ItemFormScreen({super.key, this.id});

  @override
  ConsumerState<ItemFormScreen> createState() => _ItemFormState();
}

typedef MenuEntry = DropdownMenuItem<String>;

class _ItemFormState extends ConsumerState<ItemFormScreen> {
  final _gap = 15.0;
  final _duration = 750;
  final _delay = 125;

  late final bool isEditing;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  final _formatter = CurrencyTextInputFormatter.currency(
      locale: "id_ID", symbol: "", decimalDigits: 0);

  BuildContext? _progressIndicatorContext;

  List<String>? _storageUrls;
  List<TempImage>? _tempImages;
  String? selectedSupplier;

  static final List<MenuEntry> categoryEntries =
  UnmodifiableListView<MenuEntry>(
    listCategory.map<MenuEntry>(
            (String name) => MenuEntry(value: name, child: Text(name))),
  );
  String? categoryValue;
  String? supplierIdValue;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final item = Item(
          image: _storageUrls ?? [''],
          name: _nameController.text,
          description: _descriptionController.text,
          category: categoryValue!,
          price: _formatter.getDouble(),
          supplierId: supplierIdValue!);

      final firestoreService = ref.read(itemServiceProvider.notifier);

      if (!isEditing) {
        await firestoreService.addItem(item: item, files: _tempImages!);
      } else {
        await firestoreService.updateItem(item: item.copyWith(id: widget.id), files: _tempImages!);
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
    _descriptionController.dispose();
    _priceController.dispose();

    if (_progressIndicatorContext != null &&
        _progressIndicatorContext!.mounted) {
      Navigator.of(_progressIndicatorContext!).pop();
      _progressIndicatorContext = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(itemServiceProvider, (prev, state) async {
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
                ? 'Item updated successfully!'
                : 'Item added successfully!')),
      );
    });

    final supplierAsyncValue = ref.watch(suppliersCollProvider);
    if (widget.id != null) {
      final itemAsyncValue = ref.watch(itemDocProvider(widget.id!));
      itemAsyncValue.when(
          data: (item) {
            if (_nameController.text.isEmpty) {
              _nameController.text = item.name;
              _descriptionController.text = item.description;
              _priceController.text = _formatter.formatDouble(item.price);
              setState(() {
                _storageUrls = item.image;
                categoryValue = item.category;
                supplierIdValue = item.supplierId;
                _tempImages = item.image.map((image) {
                  return TempImage(imageUrl: image, isFile: false);
                }).toList();

              });
            }

          },
          loading: () => const CircularProgressIndicator(),
          error: (e, stack) => Text('Error: $e'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
      body: CustomScrollView(slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Entry.all(
                    scale: 1,
                    duration: Duration(milliseconds: _duration),
                    child: ImageInput(
                      storageUrls: _storageUrls,
                      onImageSelected: (List<TempImage>? images) {
                        setState(() {
                          _tempImages = images ?? [];
                        });
                      },
                    ),
                  ),
                  SizedBox(height: _gap),
                  Entry.all(
                    scale: 1,
                    delay: Duration(milliseconds: _delay),
                    duration: Duration(milliseconds: _duration),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.abc_rounded)),
                      validator: (value) =>
                      value == null || value.isEmpty
                          ? 'Name is required'
                          : null,
                    ),
                  ),
                  SizedBox(height: _gap),
                  Entry.all(
                    scale: 1,
                    delay: Duration(milliseconds: _delay * 2),
                    duration: Duration(milliseconds: _duration),
                    child: TextFormField(
                      controller: _descriptionController,
                      minLines: 1,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        prefixIcon: Icon(Icons.list_alt_rounded),),
                      validator: (value) =>
                      value == null || value.isEmpty
                          ? 'Description is required'
                          : null,
                    ),
                  ),
                  SizedBox(height: _gap * 1.2),
                  Entry.all(
                      scale: 1,
                      delay: Duration(milliseconds: _delay * 3),
                      duration: Duration(milliseconds: _duration),
                      child: DropdownButtonFormField2(
                        decoration: InputDecoration(
                          labelText: "Category",
                          prefixIcon: Icon(Icons.category_rounded),
                          filled: true,
                        ),
                        isExpanded: true,
                        value: categoryValue,
                        onChanged: (String? value) {
                          setState(() {
                            categoryValue = value!;
                          });
                        },
                        items: categoryEntries,
                        validator: (value) =>
                        value == null || value.isEmpty
                            ? 'Please select a category'
                            : null,
                      )),
                  SizedBox(height: _gap),
                  Entry.all(
                    scale: 1,
                    delay: Duration(milliseconds: _delay * 4),
                    duration: Duration(milliseconds: _duration),
                    child: TextFormField(
                      inputFormatters: [_formatter],
                      controller: _priceController,
                      decoration: const InputDecoration(
                          labelText: 'Price',
                          prefixText: "Rp ",
                          prefixIcon: Icon(Icons.attach_money_rounded)),
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                      value == null || value.isEmpty
                          ? 'Price is required'
                          : null,
                    ),
                  ),
                  SizedBox(height: _gap * 1.2),
                  supplierAsyncValue.when(
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stack) {
                      return Text('Error: $error');
                    },
                    data: (suppliers) {
                      final activeSuppliers = suppliers.where((s) => !s.deleted).toList();
                      if (activeSuppliers.isEmpty) {
                        return const Center(child: Text('No items found.'));
                      }

                      return Entry.all(
                          scale: 1,
                          delay: Duration(milliseconds: _delay * 3),
                          duration: Duration(milliseconds: _duration),
                          child: DropdownButtonFormField2<String>(
                            decoration: InputDecoration(
                              labelText: "Supplier",
                              prefixIcon: Icon(Icons.inventory_2_rounded),
                              filled: true,
                            ),
                            value: suppliers.any((supplier) => supplier.id == supplierIdValue) ? supplierIdValue : null,
                            onChanged: (String? value) {
                              setState(() {
                                supplierIdValue = value!;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a supplier';
                              }
                              return null;
                            },
                            items: activeSuppliers
                                .map<DropdownMenuItem<String>>((supplier) {
                              return DropdownMenuItem<String>(
                                value: supplier.id!,
                                child: Text(supplier
                                    .name),
                              );
                            }).toList(),
                          ));
                    },
                  ),
                  SizedBox(height: _gap * 3),
                  Entry.all(
                    scale: 1,
                    delay: Duration(milliseconds: _delay * 5),
                    duration: Duration(milliseconds: _duration),
                    child: FilledButton(
                      onPressed: _submitForm,
                      child: const Text('Simpan'),
                    ),
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
