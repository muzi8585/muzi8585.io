import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_admin_panels/Screens/Background_Location_Admin_Panel/Presentation/View/Screens/BackgroundLocationPanel.dart';
import 'package:flutter_web_admin_panels/Screens/Background_Location_Admin_Panel/Presentation/Widget/CommonWidget.dart';
import 'package:flutter_web_admin_panels/Screens/Background_Location_Admin_Panel/Presentation/Widget/DashboardWidget.dart';
import 'package:flutter_web_admin_panels/Screens/Background_Location_Admin_Panel/Presentation/Widget/LocationWidget.dart';
import 'package:flutter_web_admin_panels/Screens/Background_Location_Admin_Panel/Presentation/Widget/WrapperComponent2.dart';
import 'package:flutter_web_admin_panels/Screens/Routing_Flow_Admin_Panel/Presentation/View/Routing_Admin_Panel.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Data/Controller.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/Widgets/WidgetConatiner.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/View/Screens/Commons.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/View/Screens/FeedBackScreen.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/View/Screens/Reports.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/View/Screens/kanban_screen.dart';
import 'package:flutter_web_admin_panels/Utils/build_context_extension.dart';
import 'package:flutter_web_admin_panels/Utils/color_data.dart';

class BackgroundLocationAdminPanel extends ConsumerStatefulWidget {
  final FirebaseApp appA;
  final FirebaseApp appB;
  const BackgroundLocationAdminPanel(
      {super.key, required this.appA, required this.appB});

  @override
  ConsumerState<BackgroundLocationAdminPanel> createState() =>
      _BackgroundLocationAdminPanelState();
}

class _BackgroundLocationAdminPanelState
    extends ConsumerState<BackgroundLocationAdminPanel> {
  late FirebaseApp activeApp;
  bool isLoading = false;
  String selectedMenu = 'Dashboard';
  bool showMenu = false;
  bool showProfile = false;
  bool showMessage = false;
  bool showNotification = false;
  String selected = 'Background Location';
  bool isExpanded = false;
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
  void initState() {
    super.initState();
    activeApp = widget.appA;
  }

  @override
  Widget build(BuildContext context) {
    double width1 = context.width();
    double height = context.height();
    bool isDesktop = context.isDesktop();
    double width = MediaQuery.of(context).size.width;
    final firestore = FirebaseFirestore.instanceFor(app: widget.appB);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      width: width1,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: width1,
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
                                    "Location Admin",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Expanded(
                                    child: SizedBox(),
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
                                    buildMenuTile(
                                      icon: LucideIcons.layoutGrid,
                                      label: 'Dashboard',
                                      onTap: () {
                                         setState(() {
                                          selectedMenu == "Dashboard";
                                        });
                                      },
                                    ),
                                    buildMenuTile(
                                      icon: LucideIcons.locate,
                                      label: 'Locations',
                                      onTap: () {
                                        setState(() {
                                          selectedMenu == "Locations";
                                        });
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (_) =>
                                        //         BackgroundLocationAdminScreen(
                                        //       app:
                                        //           widget.appB ?? Firebase.app(),
                                        //     ),
                                        //   ),
                                        // );
                                      },
                                    ),
                                    buildMenuTile(
                                      icon: LucideIcons.users,
                                      label: 'Users',
                                      onTap: () {
                                        setState(() {
                                          selectedMenu == "Users";
                                        });
                                      },
                                    ),
                                    buildMenuTile(
                                      icon: LucideIcons.messageSquare,
                                      label: 'Feedbacks',
                                      onTap: () {
                                        setState(() {
                                          selectedMenu == "Feedbacks";
                                        });
                                      },
                                    ),
                                    buildMenuTile(
                                      icon: LucideIcons.arrowUpFromLine,
                                      label: 'Commons',
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (_) => AppVersion()),
                                        // );
                                        setState(() {
                                          selectedMenu == "Commons";
                                        });
                                      },
                                    ),
                                    buildMenuTile(
                                      icon: LucideIcons.bug,
                                      label: 'Reports',
                                      onTap: () {
                                         setState(() {
                                          selectedMenu == "Reports";
                                        });
                                      },
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: Icon(LucideIcons.shieldCheck,
                                          color: Colors.white54),
                                      title: const Text(
                                        'Select App',
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
                      width: width1,
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            height: 80,
                            width: width1,
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
          if (selectedMenu == "Dashboard") const Dashboardwidget(),
          if (selectedMenu == "Locations") const Locationwidget(),
          if (selectedMenu == "Commons") const Commonwidget(),
          if (selectedMenu == "Feedbacks") const FeedbackScreen(),
          if (selectedMenu == "Reports") const ReportsScreen(),
         
        ],
      ),
    );
  }

  Widget buildMenuTile({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    final bool isSelected = selectedMenu == label;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: Colors.white54.withOpacity(isSelected ? 0.5 : 1.0),
      ),
      title: Text(
        label,
        style: TextStyle(
          color: Colors.white.withOpacity(isSelected ? 0.5 : 1.0),
        ),
      ),
      onTap: () {
        setState(() {
          selectedMenu = label;
        });
        onTap?.call();
      },
    );
  }
}
