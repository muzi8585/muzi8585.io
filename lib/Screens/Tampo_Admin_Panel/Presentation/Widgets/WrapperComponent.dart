import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_admin_panels/Screens/Background_Location_Admin_Panel/Presentation/View/Screens/BackgroundLocationPanel.dart';
import 'package:flutter_web_admin_panels/Screens/Background_Location_Admin_Panel/Presentation/View/Background_Location_Admin_Panel.dart';
import 'package:flutter_web_admin_panels/Screens/Routing_Flow_Admin_Panel/Presentation/View/Routing_Admin_Panel.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/View/Screens/Commons.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/View/Screens/FeedBackScreen.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/View/Screens/Reports.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/View/Screens/kanban_screen.dart';
import 'package:flutter_web_admin_panels/Utils/build_context_extension.dart';
import 'package:flutter_web_admin_panels/Utils/color_data.dart';

import 'package:lucide_icons_flutter/lucide_icons.dart';

class WrapperComponent extends StatefulWidget {
  final Widget? child;
  final FirebaseApp? appA;
  final FirebaseApp? appB;

  const WrapperComponent({super.key, this.child, this.appA, this.appB});

  @override
  State<WrapperComponent> createState() => _WrapperComponentState();
}

class _WrapperComponentState extends State<WrapperComponent> {
  bool showMenu = false;
  bool showProfile = false;
  bool showMessage = false;
  bool showNotification = false;
  String selected = 'Tampo';
  bool isExpanded = false;

  final List<String> options = [
    'Tampo',
    'Background Location',
    'Routing Flow',
  ];
  void navigate(String panel) {
    setState(() => selected = panel);

    if (panel == 'Background Location') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => BackgroundLocationAdminPanel(
            appA: widget.appB ?? Firebase.app(),
            appB: widget.appA ?? Firebase.app(),
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => RoutingAdminPanel(
            appA: widget.appB ?? Firebase.app(),
            appB: widget.appB ?? Firebase.app(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = context.width();
    double height = context.height();
    bool isDesktop = context.isDesktop();

    return Row(
      children: [
        Stack(
          children: [
            SizedBox(
              width: 250,
              height: height,
              child: Scaffold(
                backgroundColor: ColorData().greyDark,
                body: SafeArea(
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: width,
                          height: 80,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            // titleSpacing: 0,
                            color: ColorData().greyDark,
                            // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  "Tampo Admin",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                if (!isDesktop)
                                  InkWell(
                                    onTap: () {
                                      showMenu = !showMenu;
                                      setState(() {});
                                    },
                                    child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Icon(
                                        LucideIcons.x,
                                        color: Colors.grey[200]!,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          padding: const EdgeInsets.only(
                            top: 80,
                            left: 16,
                            right: 16,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              Column(
                                children: [
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(
                                      LucideIcons.layoutGrid,
                                      color: Colors.white54,
                                    ),
                                    title: Text('Dashboard'),
                                    textColor: Colors.white,
                                    // onTap: () {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (_) =>
                                    //               ECommerceScreen()));
                                    // },
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(
                                      LucideIcons.users,
                                      color: Colors.white54,
                                    ),
                                    title: Text('Users'),
                                    textColor: Colors.white,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  KanbanScreen()));
                                    },
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(
                                      LucideIcons.messageSquare,
                                      color: Colors.white54,
                                    ),
                                    title: Text('Feedbacks'),
                                    textColor: Colors.white,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  FeedbackScreen()));
                                    },
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(
                                      LucideIcons.arrowUpFromLine,
                                      color: Colors.white54,
                                    ),
                                    title: Text('Commons'),
                                    textColor: Colors.white,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => AppVersion()));
                                    },
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(
                                      LucideIcons.bug,
                                      color: Colors.white54,
                                    ),
                                    title: Text('Reports'),
                                    textColor: Colors.white,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  ReportsScreen()));
                                    },
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Icon(LucideIcons.shieldCheck,
                                        color: Colors.white54),
                                    title: const Text(
                                      'Admin Panels',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    trailing: Icon(
                                      isExpanded
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: Colors.white54,
                                    ),
                                    onTap: () {
                                      setState(
                                          () => isExpanded = !isExpanded);
                                    },
                                  ),
                                  if (isExpanded)
                                    ...options.map((panel) {
                                      final isSelected = selected == panel;
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(left: 32.0),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          leading: Icon(
                                              LucideIcons.shieldUser,
                                              color: Colors.white54),
                                          title: Text(
                                            panel,
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(
                                                  isSelected ? 0.5 : 1.0),
                                            ),
                                          ),
                                          onTap: () => navigate(panel),
                                        ),
                                      );
                                    }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ].reversed.toList(),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          height: 80,
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(1, 1),
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              if (isDesktop)
                                const SizedBox(
                                  width: 300,
                                ),
                              if (!isDesktop)
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showMenu = !showMenu;
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: const Icon(
                                          Icons.menu,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Tampo Admin Panel',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ].reversed.toList(),
                    ),
                  ),
                ),
              ),
            ),
          ].reversed.toList(),
        ),
        Container(
          width: width,
          height: height,
          color: Colors.grey[100],
          child: widget.child,
        ),
      ],
    );
  }
}
