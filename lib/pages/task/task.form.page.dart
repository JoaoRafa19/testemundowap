import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testemundowap/core/widgets/input/flat.animated.loading.button.input.dart';
import 'package:testemundowap/core/widgets/input/form.input.dart';
import 'package:testemundowap/pages/main/main.binding.dart';
import 'package:testemundowap/pages/task/task.controller.dart';

class TaskFormPage extends GetView<TaskController> {
  TaskFormPage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.offAndToNamed(MainBinding.route);
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          'Editar tarefa',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Obx(
              () => RefreshIndicator(
                onRefresh: controller.getTask,
                child: ListView.builder(
                  itemCount: controller.controllersNumber.value,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final taskField = controller.task?.fields[index];
                    if (taskField != null) {
                      return FormInput(
                        inputName: taskField.label,
                        isPriceInput: taskField.isMaskPrice,
                        controller: controller.textControllers[taskField.id],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            FlatAnimatedLoadingButton(
              label: "Salvar",
              onPressed: () async {
                FocusScope.of(context).unfocus();
                await controller.saveTask();
              },
            )
          ],
        ),
      ),
    );
  }
}
