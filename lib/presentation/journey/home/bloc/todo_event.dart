part of 'todo_bloc.dart';

abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String title;
  final String desc;

  AddTodoEvent({@required this.title, @required this.desc});
}

class MarkTodoEvent extends TodoEvent {
  final TodoModel todoData;
  final bool isDone;
  final bool isNotDone;

  MarkTodoEvent({
    @required this.todoData,
    this.isDone = false,
    this.isNotDone = false,
  });
}

class DeleteTodoEvent extends TodoEvent {
  final TodoModel todoData;

  DeleteTodoEvent({@required this.todoData});
}

class FetchAllTodoEvent extends TodoEvent {}
