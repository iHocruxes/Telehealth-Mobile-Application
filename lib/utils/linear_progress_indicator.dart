import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class LinearProgressIndicatorLoading extends StatefulWidget {
  const LinearProgressIndicatorLoading({super.key, required this.seconds});
  final int seconds;

  @override
  State<LinearProgressIndicatorLoading> createState() =>
      _LinearProgressIndicatorLoadingState();
}

class _LinearProgressIndicatorLoadingState
    extends State<LinearProgressIndicatorLoading>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: Duration(seconds: widget.seconds),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: dimensHeight() * 10, horizontal: dimensWidth() * 5),
      child: const LinearProgressIndicator(
        // color: secondary,
        // value: controller.value,
        // valueColor: controller
        //     .drive(ColorTween(begin: colorCDDEFF, end: secondary)),
      ),
    );
  }
}