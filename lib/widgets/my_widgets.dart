import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWidgets {
  static Future<void> showDialogBox({
    String? title,
    BuildContext? context,
    VoidCallback? onPressed,
    TextEditingController? titleController,
    TextEditingController? descriptionController,
  }) async {
    return showDialog(
        context: context!,
        builder: (context) {
          return AlertDialog(
            title: Text("$title Notes"),
            content: SingleChildScrollView(
                child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: "Enter Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: "Enter Description",
                    border: OutlineInputBorder(),
                  ),
                )
              ],
            )),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Exit")),
              TextButton(onPressed: onPressed, child: Text(title!)),
            ],
          );
        });
  }
}
