import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppNavigator{
  static void navigateTo(BuildContext context, screen) {
    Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: const Duration(seconds: 1),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child, );
      },
    ),
    );
  }

}