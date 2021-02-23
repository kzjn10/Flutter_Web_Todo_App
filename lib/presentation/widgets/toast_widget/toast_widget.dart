import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../../theme/theme_color.dart';
import '../responsive.dart';
import 'toast_widget_enum.dart';

class ToastWidget extends StatelessWidget {
  final String message;
  final String translateKey;
  final ToastEnum type;

  ToastWidget({
    this.message = '',
    this.translateKey,
    this.type = ToastEnum.info,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ToastEnum.info:
        return _buildInfoMessageWidget(
          context,
          Icons.info,
          AppColor.black25.withOpacity(.5),
        );
      case ToastEnum.success:
        return _buildInfoMessageWidget(
          context,
          Icons.info,
          AppColor.downy.withOpacity(.5),
        );
      case ToastEnum.error:
        return _buildInfoMessageWidget(
          context,
          Icons.info,
          AppColor.cardinal.withOpacity(.5),
        );
      case ToastEnum.networkError:
        return _buildInfoMessageWidget(
          context,
          Icons.info,
          AppColor.cardinal.withOpacity(.5),
        );
      case ToastEnum.warning:
        return _buildInfoMessageWidget(
          context,
          Icons.info,
          AppColor.webOrange.withOpacity(.5),
        );
      default:
        return _buildInfoMessageWidget(
          context,
          Icons.info,
          AppColor.cerulean.withOpacity(.5),
        );
    }
  }

  Widget _buildInfoMessageWidget(
    BuildContext context,
    IconData icon,
    Color color,
  ) {
    var messageValue = '';
    if (message?.isNotEmpty ?? false) {
      messageValue = message;
    } else if (translateKey?.isNotEmpty ?? false) {
      messageValue = translate(translateKey);
    }

    if (messageValue.isEmpty) {
      return const SizedBox();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      width: _getToastWidth(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color.withOpacity(.9),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 0,
            color: AppColor.shadowColor,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Text(
        messageValue,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText2.copyWith(
              color: AppColor.white,
            ),
      ),
    );
  }

  double _getToastWidth(BuildContext context) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return ScreenUtil().screenWidth * .3;
    } else if (ResponsiveWidget.isMediumScreen(context)) {
      return ScreenUtil().screenWidth * .5;
    } else {
      return ScreenUtil().screenWidth * .975;
    }
  }
}
