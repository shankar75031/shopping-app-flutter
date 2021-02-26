import 'package:flutter/material.dart';
import 'package:go_shoppin/screens/auth_screen.dart';

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({
    WidgetBuilder builder,
    RouteSettings settings,
  }) : super(
          builder: builder,
          settings: settings,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.name == AuthScreen.ROUTE_NAME || settings.name == '/')
      return child;
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class CustomPageTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (route.settings.name == AuthScreen.ROUTE_NAME ||
        route.settings.name == '/') return child;
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
