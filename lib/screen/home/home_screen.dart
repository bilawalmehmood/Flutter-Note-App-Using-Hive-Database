import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hive_database_app/database/hive_services.dart';
import 'package:hive_database_app/models/notes_model.dart';
import 'package:hive_database_app/screen/home/controller/home_controller.dart';

import 'package:hive_database_app/widgets/my_widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(title: const Text("Hive Datbase")),
      body: ValueListenableBuilder<Box<NoteModel>>(
        valueListenable: HiveBox.getData().listenable(),
        builder: (context, boxs, child) {
          List<NoteModel> data = boxs.values.toList().cast<NoteModel>();
          return ListView.builder(
              itemCount: boxs.length,
              reverse: true,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                NoteModel noteModel = data[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SizedBox(
                    height: 100,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Title :\t${noteModel.title!}"),
                                const SizedBox(height: 20),
                                Text(
                                    "Description :\t${noteModel.description!}"),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      controller.titleController.text =
                                          noteModel.title!;
                                      controller.descriptionController.text =
                                          noteModel.description!;
                                      MyWidgets.showDialogBox(
                                        context: context,
                                        title: "Edit",
                                        titleController:
                                            controller.titleController,
                                        descriptionController:
                                            controller.descriptionController,
                                        onPressed: () =>
                                            controller.editDataToBox(
                                          noteModel,
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.edit)),
                                const SizedBox(width: 20),
                                IconButton(
                                    onPressed: () =>
                                        controller.deleteDataFromBox(noteModel),
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.descriptionController.clear();
          controller.titleController.clear();
          MyWidgets.showDialogBox(
            title: "Add",
            context: context,
            titleController: controller.titleController,
            descriptionController: controller.descriptionController,
            onPressed: () => controller.addDataToBox(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
