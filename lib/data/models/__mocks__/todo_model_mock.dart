import '../todo_model.dart';

final mockNormalTodoData = TodoModel(
  id: '123',
  title: 'title',
  description: 'description',
  isDone: false,
  isNotDone: false,
  isDeleted: false,
  createdDate: 13124,
  updatedDate: 131313,
);

final mockDoneTodoData = TodoModel(
  id: '123',
  title: 'title',
  description: 'description',
  isDone: true,
  isNotDone: false,
  isDeleted: false,
  createdDate: 13124,
  updatedDate: 131313,
);

final mockNotDoneTodoData = TodoModel(
  id: '123',
  title: 'title',
  description: 'description',
  isDone: false,
  isNotDone: true,
  isDeleted: false,
  createdDate: 13124,
  updatedDate: 131313,
);

final mockDeleteTodoData = TodoModel(
  id: '123',
  title: 'title',
  description: 'description',
  isDone: false,
  isNotDone: false,
  isDeleted: true,
  createdDate: 13124,
  updatedDate: 131313,
);

final mockInsertTodoData = TodoModel(
  id: '12344444',
  title: 'title',
  description: 'description',
  isDone: false,
  isNotDone: false,
  isDeleted: false,
  createdDate: 13124,
  updatedDate: 131313,
);
