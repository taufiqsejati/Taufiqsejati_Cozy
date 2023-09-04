import 'package:flutter/material.dart';
import 'package:taufiqsejati_cozy/models/tips.dart';
import 'package:taufiqsejati_cozy/theme.dart';

class TipsCard extends StatelessWidget {
  final Tips tips;

  TipsCard(this.tips);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          tips.imageUrl.toString(),
          width: 80,
        ),
        SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tips.title.toString(),
              style: blackTextStyle.copyWith(fontSize: 18),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'Updated ${tips.updatedAt}',
              style: greyTextStyle,
            )
          ],
        ),
        Spacer(),
        IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right))
      ],
    );
  }
}
