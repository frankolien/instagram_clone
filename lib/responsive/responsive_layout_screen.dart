import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/dimensions.dart';
 class ResponsiveLayoutScreen extends StatelessWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;

  const ResponsiveLayoutScreen({
    super.key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          // If the screen is wider than 600 pixels, show the web layout
          return webScreenLayout;
        } else {
          // Otherwise, show the mobile layout
          return mobileScreenLayout;
        }
      },
    );
  }
}