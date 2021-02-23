import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../../../utils/database_utils.dart';

/// Abstract class takes 2 types.
/// First datatype is used for storing value. [The key is stricted to be String]
/// Second datatype is the model from which the table is extended from. This is
/// used for a overriden function that takes inout as list of model datatype and
/// converts to list of table datatype to insert into database
///
/// This class contains basic functions such as
/// get, getAll, insertOrUpdateAll, delete, deleteAll
///
/// Initiate the class with box name.
///
/// Every extended class should register the adapters in the constructor.
///
/// Example:
/// ```dart
/// ContactsLocalDataSource() : super(boxName: 'contacts') {
/// DatabaseUtil.registerAdapter<ContactTable>(ContactTableAdapter());
/// DatabaseUtil.registerAdapter<AccountContactTable>(
///     AccountContactTableAdapter());
/// }
/// ```
/// Adapter are the hive table adapter which is used for storing data
/// It is generated code by hive.
/// ContactTable will generate its adapter and by default the name will be
/// ContactTableAdapter
abstract class BaseLocalDataSource<TableType, ModelType> {
  String _boxName;
  Future<Box<TableType>> boxInstance;
  bool _isEncrypted;

  BaseLocalDataSource({
    @required String boxName,
    bool isEncrypted = true,
  }) {
    _boxName = boxName;
    _isEncrypted = isEncrypted;
  }

  void _init() {
    boxInstance = DatabaseUtil.getBox<TableType>(
        boxName: _boxName, isEncrypted: _isEncrypted);
  }

  Future<Box<TableType>> get getBoxInstance async => _openBox();

  /// This function is specific to our usecase for converting list of table item
  /// to a list of models
  ///
  /// Example:
  /// ```dart
  /// Future<List<ContactsItemModel>> getformattedData() async {
  ///   final List<ContactTable> contacts = await getAll();
  ///   return contacts
  ///      .map((contact) => ContactsItemModel.fromContactTable(contact))
  ///      .toList();
  /// }
  /// ```
  Future<List<ModelType>> getFormattedData();

  /// This function is specific to our usecase for converting list of models
  /// to a map which contains key which contains the primary key and
  /// value which contains the data belonging to table class.
  ///
  /// Example:
  /// ```dart
  /// Future<void> insertformattedData(List<ContactsItemModel> contacts) async {
  /// final Map<String, ContactTable> contactMap = {
  ///    for (var contact in contacts)
  ///      contact.contactId: ContactTable.fromModel(contact)
  ///  };
  ///  await putAll(contactMap);
  /// }
  /// ```
  Future<void> insertOrUpdateItems(List<ModelType> contacts);

  Future<Box<TableType>> _openBox() async {
    var box = await boxInstance;
    if (box == null || !box.isOpen) {
      _init();
      box = await boxInstance;
    }
    return box;
  }

  Future<TableType> get(String key) async {
    final box = await _openBox();
    return box.get(key);
  }

  Future<List<TableType>> getAll() async {
    final box = await _openBox();
    return box.toMap().values.toList();
  }

  Future<void> put(String key, TableType value) async {
    final box = await _openBox();
    await box.put(key, value);
  }

  Future<void> putAll(Map<String, TableType> items) async {
    final box = await _openBox();
    await box.putAll(items);
  }

  Future<void> delete(String key) async {
    final box = await _openBox();
    await box.delete(key);
  }

  Future<void> deleteAll() async {
    final box = await _openBox();
    await box.deleteAll(box.toMap().keys.toList());
  }
}
