import 'package:flutter/material.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/Repository/Repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'Controller.g.dart';

@riverpod
class VersionController extends _$VersionController {
  @override
  bool build() {
    return false;
  }

  Repository get _repo => ref.read(repositoryProvider);
  Future<void> saveVersion(
      BuildContext context, TextEditingController controller) async {
    await _repo.saveVersion(controller, context);
  }
}
