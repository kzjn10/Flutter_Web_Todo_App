import 'package:equatable/equatable.dart';

class LanguageReferenceModel with EquatableMixin {
  final String code;
  final String vietnamese;
  final String english;
  final int updatedAt;

  LanguageReferenceModel({
    this.code,
    this.vietnamese,
    this.english,
    this.updatedAt,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        code,
        vietnamese,
        english,
      ];
}
