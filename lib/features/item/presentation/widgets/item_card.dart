import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:storedgev2/core/constants/constants.dart';

class ItemCard extends StatelessWidget {
  ItemCard(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      required this.stock,
      required this.category,
      required this.onTap});

  final String image, name, category;
  final double price;
  final int stock;
  final VoidCallback onTap;

  final _formatter = CurrencyTextInputFormatter.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: InkWell(
        splashFactory: InkSparkle.splashFactory,
        onTap: onTap,
        child: Column(
          children: [
            AspectRatio(
                aspectRatio: 1,
                child: ExtendedImage.network(
                  image,
                  fit: BoxFit.cover,
                )),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(defaultPadding / 2),
                child: Column(
                  spacing: 2,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 13
                        )),
                    Text(
                      _formatter.formatDouble(price),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Text(category,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(
                                  defaultBorderRadious / 2)),
                          padding: const EdgeInsets.all(4),
                          child: Text(stock.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary)),
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
    );
  }
}
