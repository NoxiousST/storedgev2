import 'package:entry/entry.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:storedgev2/core/config/router/route_enum.dart';
import 'package:storedgev2/features/item/application/item_provider.dart';
import 'package:storedgev2/features/supplier/application/supplier_provider.dart';
import 'package:storedgev2/features/transaction/presentation/widgets/transaction_card.dart';

import '../../../core/constants/constants.dart';
import '../../transaction/application/transaction_provider.dart';
import '../data/item_service.dart';
import 'widgets/item_info.dart';

class ItemDetailsScreen extends ConsumerStatefulWidget {
  final String id;

  const ItemDetailsScreen({super.key, required this.id});

  @override
  ConsumerState<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends ConsumerState<ItemDetailsScreen> {
  bool deleted = false;

  final _controller = CarouselController(initialItem: 0);
  int _currentPage = 0;

  final List<bool> _isVisible = List.filled(7, false);

  bool isSupplier = false;

  void _showWidgetsWithDelays() {
    for (int i = 0; i < _isVisible.length; i++) {
      Future.delayed(Duration(milliseconds: 200 + widgetDelay * i), () {
        setState(() {
          _isVisible[i] = true;
        });
      });
    }
  }

  @override
  void initState() {
    _showWidgetsWithDelays();
    _controller.addListener(() {
      final newPage =
          (_controller.offset / _controller.position.viewportDimension).round();
      if (_currentPage != newPage) {
        setState(() {
          _currentPage = newPage;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemStream = ref.watch(itemProvider(widget.id));
    final transactionStream = ref.watch(itemTransactionsProvider(widget.id));
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: itemStream.when(
        data: (item) {
          final supplierStream = ref.watch(supplierDocProvider(item.supplierId!));

          return SafeArea(
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
                      color: Colors.red,
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      children: [
                        CarouselView(
                          controller: _controller,
                          backgroundColor: surfaceContainer,
                          itemSnapping: true,
                          itemExtent: double.infinity,
                          onTap: null,
                          enableSplash: false,
                          children: item.image.map((image) {
                            return ExtendedImage.network(
                              image,
                              fit: BoxFit.cover,
                              loadStateChanged: imageLoad,
                              initGestureConfigHandler:
                                  (ExtendedImageState state) {
                                return GestureConfig(
                                  //you must set inPageView true if you want to use ExtendedImageGesturePageView
                                  inPageView: true,
                                  initialScale: 1.0,
                                  maxScale: 5.0,
                                  animationMaxScale: 6.0,
                                  initialAlignment: InitialAlignment.center,
                                );
                              },
                            );
                          }).toList(),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: IntrinsicWidth(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: surfaceColor.withAlpha(160),
                                borderRadius:
                                    BorderRadius.circular(defaultBorderRadious),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  item.image.length,
                                  (i) => Row(
                                    children: [
                                      Icon(
                                        Icons.fiber_manual_record,
                                        size: 12,
                                        color: _currentPage == i
                                            ? primaryColor
                                            : primaryColor.withAlpha(100),
                                      ),
                                      if (i < item.image.length - 1)
                                        const SizedBox(
                                            width: defaultPadding / 4),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ItemInfo(
                  title: item.name,
                  description: item.description,
                  price: item.price,
                  category: item.category,
                  stock: item.stock,
                  isVisible: _isVisible,
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding, top: defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Entry.all(
                      visible: _isVisible[5],
                      duration: Duration(milliseconds: widgetDuration),
                      scale: 1,
                      child: supplierStream.when(
                        data: (supplier) {
                          if (supplier == null) {
                            return Text('Supplier not found');
                          }
                          return Text('Supplier Name: ${supplier.name}');
                        },
                        loading: () => CircularProgressIndicator(),
                        error: (error, stack) => Text('Error: $error'),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: Entry.all(
                      visible: _isVisible[5],
                      duration: Duration(milliseconds: widgetDuration),
                      scale: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Riwayat Transaksi",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.normal),
                          ),
                          MaterialButton(
                            height: 24,
                            minWidth: 24,
                            shape: CircleBorder(),
                            onPressed: () => context.pushNamed(
                              AppRoutes.addTransaction.routeName,
                              queryParameters: {
                                'itemId': widget.id,
                                'supplierId': item.supplierId,
                              },
                            ),
                            child: Icon(
                              Icons.add,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                transactionStream.when(
                  data: (transactions) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Entry.all(
                          visible: _isVisible[6],
                          duration: Duration(milliseconds: widgetDuration),
                          scale: 1,
                          child:
                              TransactionCard(transaction: transactions[index]),
                        ),
                        childCount: transactions.length,
                      ),
                    );
                  },
                  loading: () => const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator())),
                  error: (error, stack) => SliverFillRemaining(
                      child: Center(child: Text('Error: $error'))),
                ),
                SliverPadding(padding: EdgeInsets.symmetric(vertical: 50)),
              ],
            ),
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Entry.all(
        visible: _isVisible[5],
        duration: Duration(milliseconds: widgetDuration),
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
                    AppRoutes.updateItem.routeName,
                    pathParameters: {'id': widget.id},
                  ),
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultBorderRadious),
                    ),
                  ),
                  child: Text(
                    "Update Item",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: onPrimaryColor,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteItem() async {
    deleted = true;
    final firestoreService = ref.read(itemServiceProvider.notifier);
    firestoreService.deleteItem(widget.id);
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
                context.pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget? imageLoad(ExtendedImageState state) {
    if (state.extendedImageLoadState == LoadState.loading) {
      final ImageChunkEvent? loadingProgress = state.loadingProgress;
      final double? progress = loadingProgress?.expectedTotalBytes != null
          ? loadingProgress!.cumulativeBytesLoaded /
              loadingProgress.expectedTotalBytes!
          : null;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 150.0,
              child: LinearProgressIndicator(
                value: progress,
              ),
            ),
          ],
        ),
      );
    }
    return null;
  }
}
