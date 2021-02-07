import 'package:flutter/widgets.dart';

class SnapListener extends StatefulWidget {
  final double size;
  final ListView child;
  final Duration duration = Duration(milliseconds: 500);

  SnapListener({@required this.size, @required this.child});

  @override
  SnapListenerState createState() => SnapListenerState();
}

class SnapListenerState extends State<SnapListener> {

  @override
  Widget build(BuildContext context) =>
      Container(
          child: LayoutBuilder(
              builder: (context, constraints) =>
                  GestureDetector(
                      child: NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (scrollInfo is ScrollEndNotification) {
                              var offset = ((scrollInfo.metrics.pixels -
                                  widget.size / 2) / widget.size).ceil() *
                                  widget.size;
                              if ((scrollInfo.metrics.pixels - offset).abs() >
                                  0.01)
                                animate(offset);
                            }
                            return true;
                          },
                          child: widget.child))));

  void animate(double location) =>
      widget.child.controller
          .animateTo(location, duration: widget.duration, curve: Curves.ease);

}
