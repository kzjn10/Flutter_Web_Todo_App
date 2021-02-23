import 'package:flutter/material.dart';

/// Spacing widget help quick define space between 2 widgets
class SpacingWidget extends StatelessWidget {
  final double verticalSpacing; // Vertical spacing value

  final double horizontalSpacing; // Horizontal spacing value

  SpacingWidget({this.verticalSpacing = 0, this.horizontalSpacing = 0})
      : assert(verticalSpacing >= 0, 'Vertical spacing >=0'),
        assert(horizontalSpacing >= 0, 'Horizontal spacing >=0');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: horizontalSpacing,
      height: verticalSpacing,
    );
  }
}
