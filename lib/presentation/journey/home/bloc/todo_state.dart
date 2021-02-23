part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  final List<TodoModel> todoList;

  TodoState({this.todoList});

  @override
  List<Object> get props => [todoList];
}

class InitState extends TodoState {
  InitState() : super(todoList: <TodoModel>[]);
}

class AddTodoSuccessState extends TodoState {
  AddTodoSuccessState({
    @required TodoState state,
    List<TodoModel> todoList,
  }) : super(todoList: todoList ?? state.todoList);
}

class FetchingTodoListState extends TodoState {
  FetchingTodoListState({
    @required TodoState state,
  }) : super(todoList: state.todoList);
}

class FetchingTodoListSuccessState extends TodoState {
  FetchingTodoListSuccessState({
    @required TodoState state,
    List<TodoModel> todoList,
  }) : super(todoList: todoList ?? state.todoList);
}
