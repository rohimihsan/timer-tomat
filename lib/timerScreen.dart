import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'dart:math' as math;
import 'package:quiver/async.dart';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => new _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin {
  final _timer = [25, 5, 15];

  AnimationController controller;
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: 25),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              _buildPageView(),
              _buildCircleIndicator(),
            ],
          )
        ],
      ),
      backgroundColor: Color(0xffF4F0BB),
    );
  }

  _buildPageView() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: PageView.builder(
          itemCount: 3,
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            controller.duration = Duration(minutes: _timer[index]);
            return new Container(
              child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Align(
                                  alignment: FractionalOffset.center,
                                  child: AspectRatio(
                                    aspectRatio: 1.0,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned.fill(
                                          child: CustomPaint(
                                            painter: CustomTimerPainter(
                                              animation: controller,
                                              backgroundColor: Colors.white,
                                              color: Color(0xffF95555),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: FractionalOffset.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                timerString,
                                                style: TextStyle(
                                                    fontSize: 85.0,
                                                    color: Color(0xffF95555)),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              AnimatedBuilder(
                                  animation: controller,
                                  builder: (context, child) {
                                    return FloatingActionButton.extended(
                                        onPressed: () {
                                          if (controller.isAnimating)
                                            controller.stop();
                                          else
                                            controller.reverse(
                                                from: controller.value == 0.0
                                                    ? 1.0
                                                    : controller.value);
                                        },
                                        backgroundColor: Color(0xff226F54),
                                        icon: Icon(controller.isAnimating
                                            ? Icons.pause
                                            : Icons.play_arrow),
                                        label: Text(controller.isAnimating
                                            ? "Pause"
                                            : "Play"));
                                  })
                            ],
                          ),
                        )
                      ],
                    );
                  }),
            );
          },
          onPageChanged: (int index) {
            _currentPageNotifier.value = index;
          }),
    );
  }

  _buildCircleIndicator() {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 150.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CirclePageIndicator(
          itemCount: 3,
          currentPageNotifier: _currentPageNotifier,
          dotColor: Color(0xff226F54),
        ),
      ),
    );
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 20.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);

    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
