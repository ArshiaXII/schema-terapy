import 'package:flutter/material.dart';

/// Fade page transition
class FadePageRoute<T> extends PageRoute<T> {
  FadePageRoute({
    required this.builder,
    this.duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) : super(settings: settings);

  final WidgetBuilder builder;
  final Duration duration;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;

  @override
  bool get opaque => false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

/// Slide page transition
class SlidePageRoute<T> extends PageRoute<T> {
  SlidePageRoute({
    required this.builder,
    this.duration = const Duration(milliseconds: 400),
    RouteSettings? settings,
  }) : super(settings: settings);

  final WidgetBuilder builder;
  final Duration duration;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;

  @override
  bool get opaque => false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
      child: child,
    );
  }
}

/// Scale page transition
class ScalePageRoute<T> extends PageRoute<T> {
  ScalePageRoute({
    required this.builder,
    this.duration = const Duration(milliseconds: 400),
    RouteSettings? settings,
  }) : super(settings: settings);

  final WidgetBuilder builder;
  final Duration duration;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;

  @override
  bool get opaque => false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.8, end: 1).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOut),
      ),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}

/// Rotate page transition
class RotatePageRoute<T> extends PageRoute<T> {
  RotatePageRoute({
    required this.builder,
    this.duration = const Duration(milliseconds: 500),
    RouteSettings? settings,
  }) : super(settings: settings);

  final WidgetBuilder builder;
  final Duration duration;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;

  @override
  bool get opaque => false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return RotationTransition(
      turns: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOut),
      ),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.8, end: 1).animate(animation),
        child: child,
      ),
    );
  }
}

