import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_bloc/loader_bloc/loader_bloc.dart';
import '../../theme/theme_color.dart';
import 'loader_constants.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key key, @required this.child, this.navigator})
      : super(key: key);

  final Widget child;
  final GlobalKey<NavigatorState> navigator;

  @override
  Widget build(BuildContext context) {
    final _queryData = MediaQuery.of(context);

    return Stack(
      children: <Widget>[
        child,
        BlocBuilder<LoaderBloc, LoaderState>(
          builder: (context, state) {
            return Visibility(
                visible: state.loading,
                child: Container(
                  key: const ValueKey(LoaderConstants.loaderBackgroundKey),
                  height: _queryData.size.height,
                  width: _queryData.size.width,
                  color: Colors.black
                      .withOpacity(LoaderConstants.loaderBackgroundOpacity),
                  child: Center(
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        height: LoaderConstants.loaderHeight,
                        width: LoaderConstants.loaderWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColor.white,
                        ),
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                        )),
                  ),
                ));
          },
        ),
      ],
    );
  }
}
