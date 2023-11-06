import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testemundowap/adapters/factory/repository.factory.dart';
import 'package:testemundowap/core/helpers/exceptions.dart';
import 'package:testemundowap/domain/entity/task.entity.dart';
import 'package:testemundowap/domain/usecases/get.task.usecase.dart';
import 'package:testemundowap/domain/usecases/save.task.usecase.dart';
import 'package:testemundowap/pages/main/main.binding.dart';

class TaskController extends GetxController {
  final taskId = Get.arguments;
  Task? task;
  TaskController();
  final _getTaskUsecase = GetTaskUsecase(RepositoryFactory());
  final _saveTaskUsecase = SaveTaskUsecase(RepositoryFactory());
  final textControllers = <int, TextEditingController>{}.obs;
  final controllersNumber = 0.obs;

  @override
  void onInit() async {
    await getTask();
    super.onInit();
  }

  Future<void> getTask() async {
    try {
      task = await _getTaskUsecase.execute(taskId);
      controllersNumber.value = task!.fields.length;
      for (final field in task!.fields) {
        textControllers.addEntries(
            RxMap({field.id: TextEditingController(text: field.value)})
                .entries);
      }
    } on InternalException catch (e) {
      Get.back();

      Get.showSnackbar(GetSnackBar(
        message: e.message,
        title: "Erro",
      ));
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: "Aconteceu um erro inesperado",
        title: "Erro desconhecido",
        isDismissible: true,
        icon: Icon(Icons.error),
      ));
    }
  }

  Future<void> saveTask() async {
    try {
      if (task != null) {
        for (final field in task!.fields) {
          if (textControllers[field.id]?.text.isNotEmpty == true) {
            field.edited = true;
            field.completed = true;
            field.value = textControllers[field.id]?.text;
          }
        }
      }
      _saveTaskUsecase.execute(task);
      Get.showSnackbar(const GetSnackBar(
        message: "Tarefa salva com sucesso",
        title: "Tarefa salva",
        icon: Icon(Icons.save),
        isDismissible: true,
        duration: Duration(seconds: 5),
        borderColor: Colors.green,
      ));
      Get.offAndToNamed(MainBinding.route);
    } on InternalException catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: e.message,
        title: "Erro",
        isDismissible: true,
        borderColor: Colors.amber,
        icon: const Icon(Icons.warning),
      ));
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: "Aconteceu um erro inesperado",
        title: "Erro desconhecido",
        isDismissible: true,
        borderColor: Colors.red,
        icon: Icon(Icons.error),
      ));
    }
  }
}
