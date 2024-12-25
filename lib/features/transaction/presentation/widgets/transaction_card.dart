import 'package:flutter/material.dart';
import 'package:storedgev2/core/constants/constants.dart';
import 'package:storedgev2/models/transaction/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaksi transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(defaultPadding / 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultBorderRadious)),
            child: Icon(
                transaction.type == 0
                    ? Icons.moving_rounded
                    : Icons.trending_down_rounded,
                size: 36,
                color: transaction.type == 0 ? Colors.teal : Colors.red),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.date.toLocal().toString().split(' ')[0],
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(letterSpacing: 1, color: onSurfaceVariant),
              ),
              Text(transaction.type == 0 ? 'Masuk' : 'Keluar',
                  style: Theme.of(context).textTheme.bodyLarge)
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(defaultPadding / 2),
                  decoration: BoxDecoration(
                      color: surfaceContainerHigh,
                      borderRadius:
                          BorderRadius.circular(defaultBorderRadious / 2)),
                  child: Text(
                    "${transaction.quantity}",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .apply(color: onSurfaceVariant),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
