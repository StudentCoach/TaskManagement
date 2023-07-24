import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management_app/task_management/task_list/data/models/task_response.dart';

class TaskManagementRepository {


  Future<String?> addTask({
    required String title,
    required String description,
    required String date,
    required String id,
  }) async {
    try {
      CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');
      final taskId = tasks.doc().id;
      // Call the user's CollectionReference to add a new user
      await tasks.doc(taskId).set({
        'title': title,
        'description': description,
        'date': date,
        'id': id,
        'task_id': taskId,
      });

      return 'success';
    } catch (e) {
      return 'Error adding user';
    }
  }

  Future<List<TaskResponse>?> getTasks(String id) async {
    try {
      CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');
      final snapshot = await tasks.where('id' ,isEqualTo: id).get();
      final data = snapshot.docs;

      List<TaskResponse> tasksList = [];
      for (var doc in data){
        var task = TaskResponse.fromJson(doc.data() as Map<String, dynamic>);
        tasksList.add(task);
      }
      print(tasksList.length);
      return tasksList;
      // return data['full_name'];
    } catch (e) {
      return null;
    }
  }

  Future<String?> editTask({required String title,
    required String description,
    required String date,
    required String id,
    required String taskId
  }) async {
    try {
      CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');
      await tasks.doc(taskId).set({
        'title': title,
        'description': description,
        'date': date,
        'id': id,
        'task_id': taskId,
      });

      return 'success';
    } catch (e) {
      return null;
    }
  }

  Future<String?> deleteTask(String taskId) async {
    try {
      CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');
      final _ = await tasks.doc(taskId).delete();
      return 'success';
    } catch (e) {
      return null;
    }
  }

}