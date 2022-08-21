import 'package:flutter/material.dart';

import '../../shared/styles/my_colors.dart';

class DefaultLoadingIndicator extends StatelessWidget {
  final Color color;

  const DefaultLoadingIndicator({
    Key? key,
    this.color = MyColors.myPrimaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
