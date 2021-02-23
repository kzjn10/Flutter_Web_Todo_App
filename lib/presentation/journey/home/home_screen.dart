import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/todo_model.dart';
import '../../theme/theme_color.dart';
import '../../widgets/base_stateless_widget.dart';
import '../../widgets/modal.dart';
import '../../widgets/responsive.dart';
import 'bloc/todo_bloc.dart';
import 'home_screen_constants.dart';
import 'views/empty_note_widget.dart';
import 'views/todo_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStateWidget<HomeScreen> {
  TextEditingController _titleTextInputController;
  TextEditingController _descriptionTextInputController;

  TodoBloc get _todoBloc => BlocProvider.of<TodoBloc>(context);

  @override
  void initState() {
    _titleTextInputController = TextEditingController();
    _descriptionTextInputController = TextEditingController();
    _todoBloc?.add(FetchAllTodoEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        key: HomeScreenConstants.appbarKey,
        title: const Text('Todo App'),
      ),
      body: Container(
        child: BlocConsumer(
          cubit: _todoBloc,
          listener: (context, state) {
            switch (state.runtimeType) {
              case AddTodoSuccessState:
                _titleTextInputController.text = '';
                _descriptionTextInputController.text = '';
                Navigator.of(context).pop();
                break;
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case AddTodoSuccessState:
                return _buildTodoListWidget(context, state.todoList);
              case FetchingTodoListSuccessState:
                return _buildTodoListWidget(context, state.todoList);
              default:
                return EmptyNoteWidget(
                  key: HomeScreenConstants.emptyWidgetKey,
                  onItemInteraction: () {
                    _buildAddTodoDialogModel(context);
                  },
                );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: HomeScreenConstants.fabKey,
        elevation: 0.0,
        onPressed: () {
          _buildAddTodoDialogModel(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTodoListWidget(BuildContext context, List<TodoModel> dataSet) {
    if ((dataSet?.length ?? 0) == 0) {
      return EmptyNoteWidget(
        key: HomeScreenConstants.emptyWidgetKey,
        onItemInteraction: () {
          _buildAddTodoDialogModel(context);
        },
      );
    }

    return Container(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        itemCount: dataSet.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _getGridColumn(context),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, position) {
          return Container(
              alignment: Alignment.center,
              child: TodoWidget(
                key: ValueKey('todo_item_$position'),
                data: dataSet[position],
                onDelete: (TodoModel data) {
                  _buildConfirmDeleteDialogModel(context, data);
                },
                onMarkAsDone: (TodoModel data) {
                  _todoBloc.add(MarkTodoEvent(todoData: data, isDone: true));
                },
                onMarkAsNotDone: (TodoModel data) {
                  _todoBloc.add(MarkTodoEvent(todoData: data, isNotDone: true));
                },
              ));
        },
      ),
    );
  }

  Future _buildAddTodoDialogModel(BuildContext context) {
    final theme = Theme.of(context);
    return Modal(
      key: HomeScreenConstants.addTodoDialogKey,
      isFixedHorizontalActions: true,
      title: 'Add Todo',
      description: '',
      context: context,
      body: Container(
        child: Column(
          children: [
            TextField(
              key: HomeScreenConstants.titleDialogKey,
              controller: _titleTextInputController,
            ),
            TextField(
              key: HomeScreenConstants.descDialogKey,
              controller: _descriptionTextInputController,
            ),
            const SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
      actions: [
        Expanded(child: Container()),
        TextButton(
          key: HomeScreenConstants.cancelBtnDialogKey,
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: theme.textTheme.subtitle2
                .copyWith(color: AppColor.deepCerulean),
          ),
        ),
        SizedBox(
          width: 8,
          child: Container(),
        ),
        TextButton(
          key: HomeScreenConstants.addBtnDialogKey,
          onPressed: () {
            _todoBloc.add(
              AddTodoEvent(
                  title: _titleTextInputController.text,
                  desc: _descriptionTextInputController.text),
            );
          },
          child: Text(
            'Add Todo',
            style:
                theme.textTheme.subtitle2.copyWith(color: theme.primaryColor),
          ),
        ),
      ],
    ).showModal();
  }

  Future _buildConfirmDeleteDialogModel(BuildContext context, TodoModel data) {
    final theme = Theme.of(context);
    return Modal(
      key: HomeScreenConstants.addTodoDialogKey,
      isFixedHorizontalActions: true,
      title: 'Delete Todo',
      description: 'Are you sure?',
      context: context,
      actions: [
        Expanded(child: Container()),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: theme.textTheme.subtitle2
                .copyWith(color: AppColor.deepCerulean),
          ),
        ),
        SizedBox(
          width: 8,
          child: Container(),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            _todoBloc.add(DeleteTodoEvent(todoData: data));
          },
          child: Text(
            'Delete Todo',
            style:
                theme.textTheme.subtitle2.copyWith(color: theme.primaryColor),
          ),
        ),
      ],
    ).showModal();
  }

  int _getGridColumn(BuildContext context) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return 6;
    } else if (ResponsiveWidget.isMediumScreen(context)) {
      return 4;
    } else {
      return 2;
    }
  }
}
