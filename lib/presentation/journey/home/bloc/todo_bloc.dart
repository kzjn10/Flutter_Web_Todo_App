import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/global.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/localization/keys.dart';
import '../../../../data/models/todo_model.dart';
import '../../../../utils/toast_utils.dart';
import '../../../common_bloc/loader_bloc/loader_bloc.dart';
import '../interactor/home_interactor.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  HomeInteractor homeInteractor;
  LoaderBloc loaderBloc;

  TodoBloc({
    this.homeInteractor,
    this.loaderBloc,
  }) : super(InitState());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    switch (event.runtimeType) {
      case AddTodoEvent:
        yield* _mapAddTodoEventToState(event);
        break;
      case FetchAllTodoEvent:
        yield* _mapFetchAllTodoEventToState(event);
        break;
      case DeleteTodoEvent:
        yield* _mapDeleteEventToState(event);
        break;
      case MarkTodoEvent:
        yield* _mapUpdateEventToState(event);
        break;
      default:
        break;
    }
  }

  Stream<TodoState> _mapAddTodoEventToState(AddTodoEvent event) async* {
    try {
      if (event.title.isEmpty || event.desc.isEmpty) {
        ToastUtils.show(
            message: translate(Keys.common_messageinputinvaliddata));
      } else {
        final todoData = TodoModel(
          id: Uuid().v1(),
          title: event.title,
          description: event.desc,
          isDone: false,
          isNotDone: false,
          isDeleted: false,
          createdDate: DateTime.now().millisecondsSinceEpoch,
          updatedDate: DateTime.now().millisecondsSinceEpoch,
        );
        await homeInteractor.addTodo(todoData);
        final dataList = await homeInteractor.getAllTodo();
        yield AddTodoSuccessState(state: state, todoList: dataList);
        Timer(const Duration(milliseconds: 500), () {
          ToastUtils.show(message: translate(Keys.common_messageaddsuccess));
        });
      }
    } catch (ex) {
      yield* _handleException(ex);
    }
  }

  Stream<TodoState> _mapFetchAllTodoEventToState(
      FetchAllTodoEvent event) async* {
    try {
      yield FetchingTodoListState(state: state);
      final dataList = await homeInteractor.getAllTodo();
      yield FetchingTodoListSuccessState(state: state, todoList: dataList);
    } catch (e) {
      _handleException(e);
    } finally {}
  }

  Stream<TodoState> _mapDeleteEventToState(DeleteTodoEvent event) async* {
    try {
      final temp = event.todoData
        ..isDeleted = true
        ..updatedDate = DateTime.now().millisecondsSinceEpoch;
      await homeInteractor.updateTodo(temp);

      final dataList = await homeInteractor.getAllTodo();
      yield FetchingTodoListSuccessState(state: state, todoList: dataList);
      Timer(const Duration(milliseconds: 500), () {
        ToastUtils.show(message: translate(Keys.common_messagedeletesuccess));
      });
    } catch (ex) {
      yield* _handleException(ex);
    }
  }

  Stream<TodoState> _mapUpdateEventToState(MarkTodoEvent event) async* {
    try {
      final temp = event.todoData
        ..isNotDone = event.isNotDone
        ..isDone = event.isDone
        ..updatedDate = DateTime.now().millisecondsSinceEpoch;
      await homeInteractor.updateTodo(temp);

      final dataList = await homeInteractor.getAllTodo();
      yield FetchingTodoListSuccessState(state: state, todoList: dataList);
      Timer(const Duration(milliseconds: 500), () {
        ToastUtils.show(message: translate(Keys.common_messageactionsuccess));
      });
    } catch (ex) {
      yield* _handleException(ex);
    }
  }

  Stream<TodoState> _handleException(Exception e) async* {
    switch (e.runtimeType) {
      default:
        ToastUtils.show(
            message: translate(Keys.common_messagesomethingwentwrong));
        break;
    }
  }
}
