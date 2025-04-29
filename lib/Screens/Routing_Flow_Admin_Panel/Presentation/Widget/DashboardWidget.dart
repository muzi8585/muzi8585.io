import 'package:flutter/material.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/Widgets/WidgetConatiner.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Dashboardwidget extends StatelessWidget {
  const Dashboardwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  WidgetConatiner(
                    title: 'Projects',
                    length: '0',
                    icon: LucideIcons.folderKanban,
                    color: Colors.purple,
                    ontap: () {},
                  ),
                  WidgetConatiner(
                    title: 'Tasks',
                    length: '0',
                    icon: LucideIcons.circleCheckBig,
                    color: Colors.orange,
                    ontap: () {},
                  ),
                  WidgetConatiner(
                    title: 'Notes',
                    length: '0',
                    icon: LucideIcons.notepadText,
                    color: Colors.brown,
                    ontap: () {},
                  ),
                  WidgetConatiner(
                    title: 'Users',
                    length: '0',
                    icon: LucideIcons.users,
                    color: Colors.indigo,
                    ontap: () {},
                  ),
                ],
              ),
            );
  }
}