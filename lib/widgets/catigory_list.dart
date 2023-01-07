import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lista/data/theme.dart';
import 'package:lista/models/categories_data.dart';
import 'package:lista/models/task_data.dart';
import 'package:lista/screens/add_task_screen.dart';
import 'package:lista/screens/catigory_tasks_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CatigoryList extends StatelessWidget {
  const CatigoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesData>(
      builder: ((context, category, child) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: category.categories.length,
          itemBuilder: (BuildContext context, int index) {
            String cat = category.categories[index].category;
            return CupertinoButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: CatigoryTasksScreen(
                      category: cat,
                    ),
                  ),
                );
              },
              child: SizedBox(
                width: 270,
                height: 400,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          '${Provider.of<TaskData>(context).getTasksByCategory(cat).length}tasks',
                          style: const TextStyle(
                            color: Color.fromARGB(146, 9, 32, 51),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, top: 10, bottom: 10),
                        child: Text(
                          cat,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SliderTheme(
                        data: Theme.of(context).sliderTheme.copyWith(
                              disabledActiveTrackColor: catColors[cat],
                              trackHeight: 5,
                              inactiveTrackColor: AppColors.backgroundCard,
                              activeTickMarkColor: catColors[cat],
                              trackShape: RoundSliderTrackShape(
                                radius: 2,
                                disabledThumbGapWidth: -2,
                                color: catColors[cat]!,
                              ),
                              activeTrackColor: catColors[cat],
                              thumbShape: RetroSliderThumbShape(
                                thumbRadius: 2,
                                color: catColors[cat],
                              ),
                              disabledThumbColor: catColors[cat],
                            ),
                        child: Slider(
                          min: 0,
                          max: Provider.of<TaskData>(context)
                              .getTasksByCategory(cat)
                              .length
                              .toDouble(),
                          value: Provider.of<TaskData>(context)
                              .getDoneTasksByCategory(cat)
                              .length
                              .toDouble(),
                          onChanged: null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class RetroSliderThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final Color? color;
  const RetroSliderThumbShape({
    this.thumbRadius = 6.0,
    required this.color,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    final rect = Rect.fromCircle(center: center, radius: thumbRadius);

    final rrect = RRect.fromRectAndRadius(
      Rect.fromPoints(
        Offset(rect.left - 1, rect.top - 5),
        Offset(rect.right + 1, rect.bottom + 1),
      ),
      Radius.circular(thumbRadius + 1),
    );

    final fillPaint = Paint()
      ..color = color!
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.inner, 2.0);

    canvas.drawRRect(rrect, fillPaint);
  }
}

class RetroSliderTrackShape extends SliderTrackShape {
  final double thumbRadius;
  final Color? color;
  const RetroSliderTrackShape({
    this.thumbRadius = 6.0,
    required this.color,
  });

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = true,
    bool isDiscrete = false,
  }) {
    throw UnimplementedError();
  }

  @override
  void paint(PaintingContext context, Offset offset,
      {required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required Offset thumbCenter,
      bool isEnabled = true,
      bool isDiscrete = false,
      required TextDirection textDirection}) {
    final Canvas canvas = context.canvas;

    final rect = Rect.fromPoints(offset, offset);

    final rrect = RRect.fromRectAndRadius(
      Rect.fromPoints(
        Offset(rect.left - 1, rect.top - 5),
        Offset(rect.right + 1, rect.bottom + 2),
      ),
      Radius.circular(thumbRadius + 1),
    );

    final fillPaint = Paint()
      ..color = color!
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rrect, fillPaint);
  }
}

class RoundSliderTrackShape extends SliderTrackShape {
  Color color;
  RoundSliderTrackShape({
    this.disabledThumbGapWidth = 2.0,
    this.radius = 0,
    this.color = Colors.blue,
  });

  final double disabledThumbGapWidth;
  final double radius;

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = true,
    bool isDiscrete = false,
  }) {
    final double overlayWidth =
        sliderTheme.overlayShape!.getPreferredSize(isEnabled, isDiscrete).width;
    final double trackHeight = sliderTheme.trackHeight!;
    assert(overlayWidth >= 0);
    assert(trackHeight >= 0);
    assert(parentBox.size.width >= overlayWidth);
    assert(parentBox.size.height >= trackHeight);

    final double trackLeft = offset.dx + overlayWidth / 2;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;

    final double trackWidth = parentBox.size.width - overlayWidth;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(PaintingContext context, Offset offset,
      {required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required Offset thumbCenter,
      bool isEnabled = true,
      bool isDiscrete = false,
      required TextDirection textDirection}) {
    if (sliderTheme.trackHeight == 0) {
      return;
    }

    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: sliderTheme.inactiveTrackColor);

    final activePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, .5);
    final Paint inactivePaint = Paint()
      ..color = const Color.fromARGB(255, 222, 222, 230)
      ..style = PaintingStyle.fill
      ..shader;

    Paint leftTrackPaint;
    Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    double horizontalAdjustment = 0.0;
    if (!isEnabled) {
      final double disabledThumbRadius =
          sliderTheme.thumbShape!.getPreferredSize(false, isDiscrete).width /
              2.0;
      final double gap = disabledThumbGapWidth * (1.0 - enableAnimation.value);
      horizontalAdjustment = disabledThumbRadius + gap;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    //Modify this side
    final RRect leftTrackSegment = RRect.fromLTRBR(
        trackRect.left,
        trackRect.top,
        thumbCenter.dx - horizontalAdjustment,
        trackRect.bottom,
        Radius.circular(radius));
    context.canvas.drawRRect(leftTrackSegment, leftTrackPaint);
    final RRect rightTrackSegment = RRect.fromLTRBR(
        thumbCenter.dx + horizontalAdjustment,
        trackRect.top,
        trackRect.right,
        trackRect.bottom,
        Radius.circular(radius));

    context.canvas.drawRRect(rightTrackSegment, rightTrackPaint);
  }
}
