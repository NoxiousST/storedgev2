import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:group_button/group_button.dart';
import 'package:storedgev2/core/constants/constants.dart';
import 'package:storedgev2/features/item/application/item_provider.dart';
import 'package:storedgev2/features/transaction/data/transaction_service.dart';
import 'package:storedgev2/models/item/item.dart';
import 'package:storedgev2/models/transaction/transaction.dart';

class TransactionFormScreen extends ConsumerStatefulWidget {
  final String itemId;

  const TransactionFormScreen({super.key, required this.itemId});

  @override
  ConsumerState<TransactionFormScreen> createState() =>
      _TransactionFormScreenState();
}

class _TransactionFormScreenState extends ConsumerState<TransactionFormScreen> {
  final _gap = 10.0;

  final _radioButton = ["In", "Out"];
  final _formKey = GlobalKey<FormState>();
  final _typeController = GroupButtonController(selectedIndex: 0);
  final _quantityController = TextEditingController();
  final _dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  final _formatter = CurrencyTextInputFormatter.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 0,
  );

  final _qtyFormatter = CurrencyTextInputFormatter.currency(
    locale: 'id_ID',
    symbol: "",
    decimalDigits: 0,
  );

  late Item item;
  BuildContext? _progressIndicatorContext;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final transaksi = Transaksi(
        itemId: widget.itemId,
        type: _typeController.selectedIndex!,
        quantity: _qtyFormatter.getUnformattedValue().toInt(),
        date: selectedDate,
      );

      final transactionService = ref.read(transactionServiceProvider.notifier);
      await transactionService.addTransaction(
          transaction: transaksi, item: item);
    }
  }

  @override
  void dispose() {
    _typeController.dispose();
    _quantityController.dispose();
    _dateController.dispose();

    if (_progressIndicatorContext != null &&
        _progressIndicatorContext!.mounted) {
      Navigator.of(_progressIndicatorContext!).pop();
      _progressIndicatorContext = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemAndSupplierAsync = ref.watch(itemDocProvider(widget.itemId));
    ref.listen(transactionServiceProvider, (prev, state) async {
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
        SnackBar(content: Text('Transaction added successfully!')),
      );
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Transaction'),
        ),
        body: itemAndSupplierAsync.when(
          data: (item) {
            if (item.stock <= 0) _typeController.disableIndexes([1]);

            setState(() {
              this.item = item;
            });

            return SafeArea(
              child: CustomScrollView(slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverToBoxAdapter(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(defaultBorderRadious),
                                child: Image.network(item.image.first)),
                            title: Text(item.name),
                            subtitle: Text(_formatter.formatDouble(item.price)),
                          ),
                          SizedBox(height: _gap * 2),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GroupButton(
                              options: GroupButtonOptions(
                                  mainGroupAlignment: MainGroupAlignment.start,
                                  buttonHeight: 45,
                                  buttonWidth: 100,
                                  borderRadius: BorderRadius.circular(8),
                                  selectedColor: primaryColor,
                                  selectedTextStyle:
                                      TextStyle(color: onPrimaryColor),
                                  unselectedColor: surfaceContainerHigh,
                                  unselectedTextStyle:
                                      TextStyle(color: onSurfaceVariant)),
                              isRadio: true,
                              controller: _typeController,
                              buttons: _radioButton,
                            ),
                          ),
                          SizedBox(height: _gap),
                          TextFormField(
                              controller: _quantityController,
                              inputFormatters: [_qtyFormatter],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.exposure_plus_1_rounded),
                                  labelText: 'Quantity'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Quantity is required';
                                }
                                final quantity = int.tryParse(value);
                                if (quantity == null) {
                                  return 'Quantity must be a valid number';
                                }
                                if (quantity > item.stock &&
                                    _typeController.selectedIndex == 1) {
                                  return 'Quantity should not exceed available stock of ${item.stock}';
                                }
                                return null;
                              }),
                          SizedBox(height: _gap),
                          TextFormField(
                            controller: _dateController,
                            onTap: () => _selectDate(context),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.calendar_month_rounded),
                              labelText: 'Date',
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Date is required'
                                : null,
                          ),
                          SizedBox(height: _gap * 4),
                          FilledButton(
                            onPressed: _submitForm,
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      _dateController.text = selectedDate.toLocal().toString().split(' ')[0];
    }
  }
}
