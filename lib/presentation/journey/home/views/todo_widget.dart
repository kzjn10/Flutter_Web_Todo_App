import 'package:flutter/material.dart';

import '../../../../data/models/todo_model.dart';
import '../../../theme/styles.dart';
import '../../../theme/theme_color.dart';
import '../../../widgets/spacing_widget.dart';
import 'view_constants.dart';

class TodoWidget extends StatelessWidget {
  final TodoModel data;
  final Function(TodoModel) onMarkAsDone;
  final Function(TodoModel) onMarkAsNotDone;
  final Function(TodoModel) onDelete;

  TodoWidget({
    Key key,
    @required this.data,
    this.onMarkAsDone,
    this.onMarkAsNotDone,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration:
          todoItemDecoration(backgroundColor: AppColor.white.withOpacity(.5)),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data?.title ?? '',
            style: theme.textTheme.headline6,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            key: TodoWidgetConstant.titleKey,
          ),
          SpacingWidget(verticalSpacing: 8),
          Text(
            data?.description,
            style: theme.textTheme.bodyText2,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            key: TodoWidgetConstant.descriptionKey,
          ),
          SpacingWidget(verticalSpacing: 8),
          Expanded(child: Container()),
          const Divider(
            thickness: .1,
            color: AppColor.dustyGray,
          ),
          Row(
            children: [
              IconButton(
                key: TodoWidgetConstant.buttonDeleteKey,
                icon: Icon(
                  Icons.delete,
                  size: 20,
                  color: theme.iconTheme.color,
                  key: TodoWidgetConstant.buttonDeleteIconKey,
                ),
                onPressed: () {
                  if (onDelete != null) {
                    onDelete(data);
                  }
                },
              ),
              Expanded(child: Container()),
              IconButton(
                key: TodoWidgetConstant.buttonMarkAsNotDoneKey,
                icon: Icon(
                  Icons.remove_circle_outlined,
                  size: 20,
                  color: data.isNotDone
                      ? theme.accentColor
                      : theme.iconTheme.color,
                  key: TodoWidgetConstant.buttonMarkAsNotDoneIconKey,
                ),
                onPressed: () {
                  if (!data.isNotDone && onMarkAsNotDone != null) {
                    onMarkAsNotDone(data);
                  }
                },
              ),
              IconButton(
                key: TodoWidgetConstant.buttonMarkAsDoneKey,
                icon: Icon(
                  Icons.check_circle,
                  size: 20,
                  color:
                      data.isDone ? theme.accentColor : theme.iconTheme.color,
                  key: TodoWidgetConstant.buttonMarkAsDoneIconKey,
                ),
                onPressed: () {
                  if (!data.isDone && onMarkAsDone != null) {
                    onMarkAsDone(data);
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
