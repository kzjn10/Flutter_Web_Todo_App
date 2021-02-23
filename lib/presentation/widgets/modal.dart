import 'package:flutter/material.dart';

class Modal<T> extends StatelessWidget {
  final BuildContext context;
  final String title;
  final ValueKey titleKey;
  final String description;
  final List<Widget> actions;
  final Widget body;
  final Key descriptionKey;
  final Function closeFunction;
  final bool isFixedHorizontalActions;
  final _actionButtonPadding = 22.0;
  final _barrierColor = Colors.black45;
  final _isOverlayTapDismiss = false;
  final _popUpDuration = const Duration(milliseconds: 150);
  final _heightFactor = 158.0;
  final _widthFactor = 270.0;
  final CrossAxisAlignment crossContentAlignment;

  Modal(
      {Key key,
      this.context,
      this.titleKey,
      this.title,
      @required this.description,
      this.descriptionKey,
      this.body,
      this.actions = const [],
      this.closeFunction,
      this.isFixedHorizontalActions = false,
      this.crossContentAlignment = CrossAxisAlignment.stretch})
      : super(key: key);

  Future<T> showModal() {
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return _buildModal(context);
      },
      barrierDismissible: _isOverlayTapDismiss,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: _barrierColor,
      transitionDuration: _popUpDuration,
    );
  }

  Widget _buildModal(context) {
    return Center(
      widthFactor: _widthFactor,
      key: key,
      heightFactor: _heightFactor,
      child: SingleChildScrollView(
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(16),
          title: title != null
              ? Text(
                  title,
                  key: titleKey,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.black),
                  textAlign: TextAlign.center,
                )
              : null,
          content: Column(
            crossAxisAlignment: crossContentAlignment,
            children: <Widget>[
              body ?? const SizedBox.shrink(),
              if (description?.isNotEmpty ?? false)
                Column(
                  children: <Widget>[
                    SizedBox(height: title != null ? 20 : 5),
                    Text(
                      description,
                      key: descriptionKey,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: _actionButtonPadding),
                    ),
                  ],
                ),
              _renderBottomActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderBottomActions() {
    return isFixedHorizontalActions
        ? Row(
            children: actions,
          )
        : ButtonBar(
            alignment: MainAxisAlignment.center,
            children: actions,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
