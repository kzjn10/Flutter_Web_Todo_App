import 'package:flutter/material.dart';

import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/theme_color.dart';

abstract class BaseStateWidget<T extends StatefulWidget> extends State<T>
    with RouteAware {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: buildAppBar(context),
      body: buildContentView(context) ?? _buildHintWidget(context),
      floatingActionButton: buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) => null;

  bool hasAppBar() => false;

  Widget buildContentView(BuildContext context) => Container();

  Widget buildFloatingActionButton(BuildContext context) => Container();

  Widget _buildHintWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      width: double.infinity,
      height: double.infinity,
      child: Center(
          child: Text(
        translate('common_message_initializationContent'),
        textAlign: TextAlign.center,
      )),
    );
  }

  void hideKeyboard() => FocusScope.of(context).requestFocus(FocusNode());

  Size get device => MediaQuery.of(context).size;

  ThemeData get theme => Theme.of(context);

  @override
  void didPush() {}

  @override
  void didPopNext() {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
