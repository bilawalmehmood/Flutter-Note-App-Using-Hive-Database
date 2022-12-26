import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_database_app/database/hive_services.dart';
import 'package:hive_database_app/models/notes_model.dart';

class HomeController extends GetxController {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  final RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  void addDataToBox() async {
    try {
      loading(true);
      NoteModel noteModel = NoteModel(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
      );
      final boxs = HiveBox.getData();
      boxs.add(noteModel);
      noteModel.save();
      _clearController();

      loading(false);
    } on HiveError catch (e) {
      loading(false);
    } catch (e) {
      loading(false);
    }
  }

  void deleteDataFromBox(NoteModel noteModel) async {
    await noteModel.delete();
  }

  void editDataToBox(NoteModel noteModel) async {
    noteModel.title = titleController.text.trim().toString();
    noteModel.description = descriptionController.text.trim().toString();
    await noteModel.save();
  }

  _clearController() {
    titleController.clear();
    descriptionController.clear();
  }
}
