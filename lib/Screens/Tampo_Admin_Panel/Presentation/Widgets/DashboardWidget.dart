import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Data/Provider.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/Widgets/WidgetConatiner.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Dashboardwidget extends ConsumerWidget {
  const Dashboardwidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncLength = ref.watch(fetchUsersFromRepoProvider).when(
          skipLoadingOnRefresh: false,
          data: (users) => users.length,
          loading: () => null,
          error: (error, stackTrace) => null,
        );
    final projectsAsyncValue = ref.watch(fetchProjectsProvider).when(
          skipLoadingOnRefresh: false,
          data: (project) => project.length,
          loading: () => null,
          error: (error, stackTrace) => null,
        );
    final tasksAsyncValue = ref.watch(fetchTasksProvider).when(
          skipLoadingOnRefresh: false,
          data: (tasks) => tasks.length,
          loading: () => null,
          error: (error, stackTrace) => null,
        );
    final notesAsyncValue = ref.watch(fetchNotesProvider).when(
          skipLoadingOnRefresh: false,
          data: (tasks) => tasks.length,
          loading: () => null,
          error: (error, stackTrace) => null,
        );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          WidgetConatiner(
            title: 'Projects',
            length: projectsAsyncValue?.toString() ?? '...',
            icon: LucideIcons.folderKanban,
            color: Colors.purple,
            ontap: () {},
          ),
          WidgetConatiner(
            title: 'Tasks',
            length: tasksAsyncValue?.toString() ?? '...',
            icon: LucideIcons.circleCheckBig,
            color: Colors.orange,
            ontap: () {},
          ),
          WidgetConatiner(
            title: 'Notes',
            length: notesAsyncValue?.toString() ?? '...',
            icon: LucideIcons.notepadText,
            color: Colors.brown,
            ontap: () {},
          ),
          WidgetConatiner(
            title: 'User',
            length: userAsyncLength?.toString() ?? '...',
            icon: LucideIcons.users,
            color: Colors.indigo,
            ontap: () {},
          ),
        ],
      ),
    );
  }
}
