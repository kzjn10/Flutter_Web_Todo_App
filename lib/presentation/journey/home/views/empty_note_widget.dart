import 'package:flutter/material.dart';

class EmptyNoteWidget extends StatelessWidget {
  final Function onItemInteraction;

  EmptyNoteWidget({Key key, this.onItemInteraction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onItemInteraction != null) {
          onItemInteraction();
        }
      },
      child: Container(
        child: Center(
          child: Text(
            'Tap to add first Todo',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
  }
}
