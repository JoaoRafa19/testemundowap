import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testemundowap/domain/model/task.model.dart';
import 'package:testemundowap/core/helpers/repository.helper.dart';
import 'package:testemundowap/domain/entity/task.entity.dart';
import 'package:testemundowap/domain/repositorys/tasks/i.task.respositoy.dart';

class TaskHiveRepository implements ITaskRepository {
  static TaskHiveRepository? _instance;
  TaskHiveRepository._();
  static TaskHiveRepository get instance =>
      _instance ??= TaskHiveRepository._();

  static Future<Box> onOpenBox() async {
    final dir = await getApplicationDocumentsDirectory();

    final box = await Hive.openBox<String>(RepositoryHelper.taskBucketName,
        path: dir.path);
    return box;
  }

  @override
  Future<List<Task>?> getAll() async {
    final tasks = <Task>[];
    final taskList = (await onOpenBox()).values.toList();
    for (final task in taskList) {
      final addTask = TaskModel.fromJsonToEntity(json.decode(task));
      if (addTask != null) {
        tasks.add(addTask);
      }
    }
    await (await onOpenBox()).flush();
    await (await onOpenBox()).close();

    return tasks;
  }

  @override
  Future<Task?> getTask(int taskId) async {
    try {
      final taskData = await (await onOpenBox()).get(taskId);
      if (taskData == null) return null;
      await (await onOpenBox()).flush();
      await (await onOpenBox()).close();
      return TaskModel.fromJsonToEntity(json.decode(taskData));
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<Task?> saveTask(Task task) async {
    try {
      final existsTask = await getTask(task.id);
      if (existsTask != null) return null;

      final jsonTask = TaskModel.toJson(task);
      final decodedTask = json.encode(jsonTask);

      await (await onOpenBox()).put(task.id, decodedTask);
      await (await onOpenBox()).flush();
      await (await onOpenBox()).close();
      return task;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Task?> updateTask(int taskId, Task newTask) async {
    final task = await getTask(taskId);
    if (task == null) {
      return null;
    }
    await (await onOpenBox())
        .put(taskId, json.encode(TaskModel.toJson(newTask)));
    await (await onOpenBox()).flush();
    await (await onOpenBox()).close();
    return newTask;
  }
}
