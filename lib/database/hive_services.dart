import 'package:hive/hive.dart';
import 'package:hive_database_app/models/notes_model.dart';
import 'package:hive_database_app/res/constants.dart';

class HiveBox {
  static Box<NoteModel> getData() => Hive.box<NoteModel>(hivaName);
}
