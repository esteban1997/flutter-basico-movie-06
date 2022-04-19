// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

enum TransitionType { none, size, scale, fade, slideLeft }

class CustomTransitionRoute<T> extends PageRouteBuilder<T> {
  final TransitionType transitionType;
  final Duration duration;
  final Widget widget;
  final Curve curve, reverseCurve;

  CustomTransitionRoute(
      {this.transitionType = TransitionType.none,
      this.duration = const Duration(milliseconds: 500),
      required this.widget,
      this.curve = Curves.ease,
      this.reverseCurve = Curves.easeInExpo})
      : super(
            pageBuilder: (_, Animation<double> animation,
                Animation<double> animationSecondary) {
              return widget;
            },
            transitionsBuilder: (_, Animation<double> animation,
                Animation<double> animationSecondary, Widget child) {
              switch (transitionType) {
                case TransitionType.fade:
                  return Align(
                      alignment: Alignment.topRight,
                      child: FadeTransition(opacity: animation, child: child));
                case TransitionType.scale:
                  return ScaleTransition(scale: animation, child: child);
                case TransitionType.size:
                  return SizeTransition(sizeFactor: animation, child: child);
                case TransitionType.slideLeft:
                  return SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(0.0, 0.1), end: Offset(0.0, 0.0))
                          .animate(animation),
                      child: child);
                default: //TransitionType.none
                  return child;
              }
            },
            transitionDuration: duration,
            reverseTransitionDuration: duration);
}

class CustomSizeTransitionRoute extends PageRouteBuilder {
  final Widget widget;

  CustomSizeTransitionRoute(this.widget)
      : super(
            pageBuilder: (_, Animation<double> animation,
                Animation<double> animationSecondary) {
              return widget;
            },
            transitionsBuilder: (_, Animation<double> animation,
                Animation<double> animationSecondary, Widget child) {
              return Align(
                alignment: Alignment.bottomLeft,
                child: SizeTransition(sizeFactor: animation, child: child),
              );
            },
            transitionDuration: Duration(milliseconds: 500),
            reverseTransitionDuration: Duration(milliseconds: 500));
}

class CustomScaleTransitionRoute extends PageRouteBuilder {
  final Widget widget;

  CustomScaleTransitionRoute(this.widget)
      : super(
            pageBuilder: (_, Animation<double> animation,
                Animation<double> animationSecondary) {
              return widget;
            },
            transitionsBuilder: (_, Animation<double> animation,
                Animation<double> animationSecondary, Widget child) {
              return Align(
                alignment: Alignment.bottomLeft,
                child: ScaleTransition(scale: animation, child: child),
              );
            },
            transitionDuration: Duration(milliseconds: 500),
            reverseTransitionDuration: Duration(milliseconds: 500));
}

class CustomFadeTransitionRoute extends PageRouteBuilder {
  final Widget widget;

  CustomFadeTransitionRoute(this.widget)
      : super(
            pageBuilder: (_, Animation<double> animation,
                Animation<double> animationSecondary) {
              return widget;
            },
            transitionsBuilder: (_, Animation<double> animation,
                Animation<double> animationSecondary, Widget child) {
              return Align(
                alignment: Alignment.bottomLeft,
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            transitionDuration: Duration(milliseconds: 500),
            reverseTransitionDuration: Duration(milliseconds: 500));
}
