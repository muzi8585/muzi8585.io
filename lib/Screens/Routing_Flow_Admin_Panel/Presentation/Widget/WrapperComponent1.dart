import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_admin_panels/Screens/Background_Location_Admin_Panel/Presentation/View/Screens/BackgroundLocationPanel.dart';
import 'package:flutter_web_admin_panels/Screens/Background_Location_Admin_Panel/Presentation/View/Background_Location_Admin_Panel.dart';
import 'package:flutter_web_admin_panels/Screens/Routing_Flow_Admin_Panel/Presentation/View/Routing_Admin_Panel.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/View/Screens/Commons.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/View/Screens/FeedBackScreen.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/View/Screens/Reports.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/View/Screens/kanban_screen.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/View/tampoAdminUI.dart';
import 'package:flutter_web_admin_panels/Utils/build_context_extension.dart';
import 'package:flutter_web_admin_panels/Utils/color_data.dart';

import 'package:lucide_icons_flutter/lucide_icons.dart';

class WrapperComponent1 extends StatefulWidget {
  final Widget? child;
  final FirebaseApp? appA;
  final FirebaseApp? appB;

  const WrapperComponent1({super.key, this.child, this.appA, this.appB});

  @override
  State<WrapperComponent1> createState() => _WrapperComponent1State();
}

class _WrapperComponent1State extends State<WrapperComponent1> {
  bool showMenu = false;
  bool showProfile = false;
  bool showMessage = false;
  bool showNotification = false;
String selected = 'Routing Flow';
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

    return Material(
      child: Stack(
        children: [
          Positioned(
            left: isDesktop
                ? 0
                : showMenu
                    ? 0
                    : -300,
            top: 0,
            child: SizedBox(
              width: 300,
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
                                  "Routing AdminPanel",
                                  maxLines: 1,
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
                                              builder: (_) => KanbanScreen()));
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
                                              builder: (_) => ReportsScreen()));
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
                                    'Routing Flow Admin Panel',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            //Search bar add
                            Expanded(
                              child: Container(
                                height: 60,
                                width: width,
                                alignment: Alignment.center,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if (isDesktop)
                                      const Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.search_outlined),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          // vertical: 4,
                                                          ),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                      if (showProfile)
                        Positioned(
                          top: 86,
                          right: 16,
                          child: Container(
                            width: 250,
                            height: 232,
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
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  width: width,
                                  height: 40,
                                  child: const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.account_box_outlined,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Text("My Profile"),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  width: width,
                                  height: 40,
                                  child: const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.contact_page_outlined,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Text("My Contacts"),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  width: width,
                                  height: 40,
                                  child: const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.settings_outlined,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Text("Account Settings"),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Divider(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  width: width,
                                  height: 40,
                                  child: const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.logout_outlined,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Text("Log Out"),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (showMessage)
                        Positioned(
                          top: 86,
                          right: isDesktop ? 266 : 16,
                          child: Container(
                            width: 300,
                            height: 369,
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
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 50,
                                  width: width,
                                  alignment: Alignment.centerLeft,
                                  decoration: const BoxDecoration(
                                      // border: Border(
                                      //   bottom: BorderSide(
                                      //     color: Colors.grey[600]!,
                                      //   ),
                                      // ),
                                      ),
                                  child: Text(
                                    "Messages",
                                    style: TextStyle(
                                      color: Colors.grey[600]!,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: 5,
                                    itemBuilder: (_, index) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        width: width,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: Colors.grey[400]!,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                color: Colors.grey[400]!,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: SizedBox(
                                                          width: width,
                                                          child: Text(
                                                            "Orang Ke-$index",
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "$index menit lalu",
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color:
                                                              Colors.grey[500]!,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  SizedBox(
                                                    width: width,
                                                    child: Text(
                                                      "Percakapan Orang Ke-$index",
                                                      style: TextStyle(
                                                        color:
                                                            Colors.grey[500]!,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (showNotification)
                        Positioned(
                          top: 86,
                          right: isDesktop ? 326 : 76,
                          child: Container(
                            width: 300,
                            height: 369,
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
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  height: 50,
                                  width: width,
                                  alignment: Alignment.centerLeft,
                                  decoration: const BoxDecoration(
                                      // border: Border(
                                      //   bottom: BorderSide(
                                      //     color: Colors.grey[600]!,
                                      //   ),
                                      // ),
                                      ),
                                  child: Text(
                                    "Notification",
                                    style: TextStyle(
                                      color: Colors.grey[600]!,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: 4,
                                    itemBuilder: (_, index) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 16,
                                        ),
                                        width: width,
                                        // height: 80,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              color: Colors.grey[400]!,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: width,
                                                    child: Text(
                                                      "$index menit lalu",
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Colors.grey[500]!,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  SizedBox(
                                                    width: width,
                                                    child: Text(
                                                      "Notification Ke-$index Lorem ipsum dolor sir amet asgdhjasd ashdjkasd asgdhja sdghasdh gashdj agshdjsda gh",
                                                      style: TextStyle(
                                                        color:
                                                            Colors.grey[500]!,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      Positioned(
                        top: 80,
                        bottom: 0,
                        left: isDesktop ? 300 : 0,
                        right: 0,
                        child: Container(
                          width: width,
                          height: height,
                          color: Colors.grey[100],
                          child: widget.child,
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
    );
  }
}
