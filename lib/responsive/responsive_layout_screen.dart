import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/user_provider.dart';
import 'package:flutter_application_1/util/dimensions.dart';
import 'package:provider/provider.dart';
 class ResponsiveLayoutScreen extends StatefulWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;

  const ResponsiveLayoutScreen({
    super.key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  });

  @override
  State<ResponsiveLayoutScreen> createState() => _ResponsiveLayoutScreenState();
}

class _ResponsiveLayoutScreenState extends State<ResponsiveLayoutScreen> {

 @override
  void initState(){
      super.initState();
      addData();
  }

  Future<void> addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          // If the screen is wider than 600 pixels, show the web layout
          return widget.webScreenLayout;
        } else {
          // Otherwise, show the mobile layout
          return widget.mobileScreenLayout;
        }
      },
    );
  }
}