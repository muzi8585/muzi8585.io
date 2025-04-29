import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_admin_panels/Models/feedback_model.dart';
import 'package:flutter_web_admin_panels/Models/notes_model.dart';
import 'package:flutter_web_admin_panels/Models/project_model.dart';
import 'package:flutter_web_admin_panels/Models/report_model.dart';
import 'package:flutter_web_admin_panels/Models/task_model.dart';
import 'package:flutter_web_admin_panels/Models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'Repository.g.dart';

@riverpod
Repository repository(ref) {
  return Repository();
}

class Repository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch Users
  Future<List<UserModel>> fetchUsers() async {
    try {
      final querySnapshot = await _firestore.collection('users').get();

      final List<UserModel> users = querySnapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data());
      }).toList();

      return users;
    } catch (e) {
      print("Error fetching users: $e");
      rethrow;
    }
  }

  Future<List<Project>> fetchProjects() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('projects').get();
    return snapshot.docs.map((doc) => Project.fromMap(doc.data())).toList();
  }

  Future<List<TaskModel>> fetchAllTasks() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('tasks').get();

    return querySnapshot.docs
        .map((doc) => TaskModel.fromMap(doc.data()))
        .toList();
  }

  
  Future<Project> getProjectById(String projectId) async {
    final doc = await _firestore.collection('projects').doc(projectId).get();
    if (doc.exists) {
      return Project.fromMap(doc.data()!);
    } else {
      throw Exception('Project not found');
    }
  }


  Future<List<Note>> fetchAllNotes() async {
    final snapshot = await FirebaseFirestore.instance.collection('notes').get();
    return snapshot.docs.map((doc) => Note.fromMap(doc.data())).toList();
  }

  // Fetch Reports
  Future<List<ReportModel>> fetchAllReports() async {
    try {
      final snapshot = await _firestore.collection('reports').get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return ReportModel.fromMap({...data, 'reportId': doc.id});
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch reports: $e");
    }
  }

  // Fetch Feedbacks
  Future<List<FeedbackModel>> fetchAllFeedbacks() async {
    final snapshot = await _firestore.collection('feedbacks').get();

    if (snapshot.docs.isEmpty) {
      return [];
    }
    return snapshot.docs.map((doc) {
      return FeedbackModel.fromMap(doc.data());
    }).toList();
  }

  Future<List<Project>> fetchProjectsByUid() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('projects').get();
      return snapshot.docs.map((doc) => Project.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Error fetching projects: $e');
    }
  }

  Future<List<UserModel>> fetchUsersName() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('users').get();

      final users =
          snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();

      return users;
    } catch (e) {
      throw Exception('Error fetching projects: $e');
    }
  }

  Future<void> saveVersion(
      TextEditingController controller, BuildContext context) async {
    final version = controller.text.trim();

    try {
      await FirebaseFirestore.instance
          .collection('appcommons')
          .doc('appcommons')
          .set({
        'version': version,
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Success')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error Occurred')));
    }
  }
}
