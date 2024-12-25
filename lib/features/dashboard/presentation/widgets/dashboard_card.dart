import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constants/constants.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard(
      {super.key, required this.onTap,
      required this.icon,
      required this.title,
      required this.description,
      required this.count,
      required this.type});

  final Function() onTap;
  final IconData icon;
  final String title;
  final String description;
  final String count;
  final String type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashFactory: InkSparkle.splashFactory,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                spacing: defaultPadding,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadious),
                        color: surfaceContainerHigh),
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding / 1.5,
                        vertical: defaultPadding * 1.5),
                    child: Icon(
                      icon,
                      size: 48,
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 24),
                        ),
                        Text(description,
                            style: textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: onSurfaceVariant.withAlpha(192),
                                ),
                            softWrap: true,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(count,
                          style: textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 36)),
                      Text(type,
                          style: textTheme
                              .labelMedium
                              ?.copyWith(
                                  fontSize: 12,
                                  color: onSurfaceVariant.withAlpha(192))),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FakerDashboardCard extends StatelessWidget {
  const FakerDashboardCard({super.key});

  @override
  Widget build(BuildContext context) {
    final faker = Faker();
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Skeletonizer(
      enabled: true,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                spacing: defaultPadding,
                children: [
                  Container(
                    height: 48 + defaultPadding * 1.5,
                    width: 48 + defaultPadding / 1.5,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(defaultBorderRadious),
                        color: surfaceContainerHigh),
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding / 1.5,
                        vertical: defaultPadding * 1.5),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          faker.internet.userName(),
                          style: textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 24),
                        ),
                        Text(faker.lorem.sentences(2).join(),
                            style: textTheme
                                .labelMedium
                                ?.copyWith(
                              color: onSurfaceVariant.withAlpha(192),
                            ),
                            softWrap: true,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text("00",
                          style: textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 36)),
                      Text("Testing",
                          style: textTheme
                              .labelMedium
                              ?.copyWith(
                              fontSize: 12,
                              color: onSurfaceVariant.withAlpha(192))),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}