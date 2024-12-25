import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:storedgev2/core/constants/constants.dart';

class ItemInfo extends StatefulWidget {
  const ItemInfo(
      {super.key,
      required this.title,
      required this.description,
      required this.price,
      required this.category,
      required this.stock,
      required this.isVisible});

  final String title, description, category;
  final double price;
  final int stock;
  final List<bool> isVisible;

  @override
  State<ItemInfo> createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {
  final _duration = 800;
  final _delay = 150;

  final _formatter = CurrencyTextInputFormatter.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(defaultPadding),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Entry.all(
                visible: widget.isVisible[0],
                duration: Duration(milliseconds: _duration),
                scale: 1,
                child: Text(
                  _formatter.formatDouble(widget.price),
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Entry.all(
                visible: widget.isVisible[0],
                duration: Duration(milliseconds: _duration),
                scale: 1,
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(defaultBorderRadious / 2),
                              topRight:
                                  Radius.circular(defaultBorderRadious / 2)),
                        ),
                        child: Text(
                          widget.stock.toString(),
                          textAlign: TextAlign.center, // Center text if needed
                          style: Theme.of(context).textTheme.titleMedium!.apply(
                              color: onPrimaryColor),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 4),
                        decoration:  BoxDecoration(
                          color: primaryColor.withAlpha(220),
                          borderRadius: BorderRadius.only(
                              bottomLeft:
                                  Radius.circular(defaultBorderRadious / 2),
                              bottomRight:
                                  Radius.circular(defaultBorderRadious / 2)),
                        ),
                        child: Text(
                          "qty",
                          textAlign: TextAlign.center, // Center text if needed
                          style: Theme.of(context).textTheme.labelLarge!.apply(
                              color: onPrimaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
            const SizedBox(height: defaultPadding / 2),
            Entry.all(
              visible: widget.isVisible[1],
              duration: Duration(milliseconds: _duration),
              scale: 1,
              child: Text(
                widget.title,

                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w300),
              ),
            ),
            const SizedBox(height: defaultPadding / 8),
            Entry.all(
              visible: widget.isVisible[2],
              delay: Duration(milliseconds: _delay * 4),
              duration: Duration(milliseconds: _duration),
              scale: 1,
              child: Text(
                widget.category,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: onSurfaceColor.withAlpha(192),
                    fontWeight: FontWeight.w300),
              ),
            ),
            const SizedBox(height: defaultPadding),
            Entry.all(
              visible: widget.isVisible[3],
              delay: Duration(milliseconds: _delay * 4),
              duration: Duration(milliseconds: _duration),
              scale: 1,
              child: Text(
                "Item info",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            Entry.all(
              visible: widget.isVisible[4],
              duration: Duration(milliseconds: _duration),
              scale: 1,
              child: Text(
                widget.description,
                style: const TextStyle(height: 1.4, fontSize: 13),
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
          ],
        ),
      ),
    );
  }
}
