import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../presentation/widgets/toast_widget/toast_widget.dart';
import '../presentation/widgets/toast_widget/toast_widget_enum.dart';

class ToastUtils {
  static void show({
    String message = '',
    String translateKey = '',
    ToastEnum type = ToastEnum.info,
  }) {
    BotToast.showCustomNotification(
      animationDuration: const Duration(milliseconds: 200),
      animationReverseDuration: const Duration(milliseconds: 100),
      duration: const Duration(seconds: 2),
      toastBuilder: (cancel) {
        return ScreenUtilInit(
          builder: () => ToastWidget(
            message: message,
            translateKey: translateKey,
            type: type,
          ),
        );
      },
      enableSlideOff: true,
      onlyOne: true,
      crossPage: true,
      backButtonBehavior: BackButtonBehavior.none,
    );
  }
}
