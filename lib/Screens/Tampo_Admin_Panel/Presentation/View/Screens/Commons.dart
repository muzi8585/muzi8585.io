import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_admin_panels/Screens/Background_Location_Admin_Panel/Presentation/Widget/CommonWidget.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/Widgets/versionInputFeild.dart';

class AppVersion extends ConsumerStatefulWidget {
  @override
  _AppVersionState createState() => _AppVersionState();
}

class _AppVersionState extends ConsumerState<AppVersion> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controlleriOS = TextEditingController();
  Commonwidget commonwidget = Commonwidget();
  String? currentVersion;
  String? currentVersioniOS;

  bool showUpdateButton = false;
  bool showUpdateButtoniOS = false;

  @override
  void initState() {
    super.initState();
    _loadVersions();
  }

  Future<void> _loadVersions() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('AppCommons')
          .doc('appCommons')
          .get();
      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          currentVersion = data['minSupportedVersion'] ?? '';
          currentVersioniOS = data['minSupportedVersionIos'] ?? '';
          controller.text = currentVersion!;
          controlleriOS.text = currentVersioniOS!;
        });
      }
    } catch (e) {
      setState(() {
        currentVersion = 'Error';
        currentVersioniOS = 'Error';
        controller.text = 'Error';
        controlleriOS.text = 'Error';
      });
    }
  }

  Future<void> updateVersion() async {
    final version = controller.text.trim();
    try {
      await FirebaseFirestore.instance
          .collection('AppCommons')
          .doc('appCommons')
          .update({'minSupportedVersion': version});
      setState(() {
        currentVersion = version;
        showUpdateButton = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Android version updated')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating Android version')),
      );
    }
  }

  Future<void> updateVersioniOS() async {
    final versioniOS = controlleriOS.text.trim();
    try {
      await FirebaseFirestore.instance
          .collection('AppCommons')
          .doc('appCommons')
          .update({'minSupportedVersionIos': versioniOS});
      setState(() {
        currentVersioniOS = versioniOS;
        showUpdateButtoniOS = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('iOS version updated')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating iOS version')),
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    controlleriOS.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding:const  EdgeInsets.symmetric(vertical: 6.0, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
            ),
            child: const Text(
              '   Commons',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        
          Divider(
            color: Colors.grey.withOpacity(0.2),
            height: 1,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Min Support Version(Android)',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    VersionInputField(
                      controller: controller,
                      onChanged: (value) {
                        setState(() {
                          showUpdateButton = value.trim() != currentVersion;
                        });
                      },
                      showUpdateButton: showUpdateButton,
                      onUpdateTap: updateVersion,
                    ),
                  ],
                ),
                const SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Min Support Version(iOS)',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    VersionInputField(
                      controller: controlleriOS,
                      onChanged: (value) {
                        setState(() {
                          showUpdateButtoniOS =
                              value.trim() != currentVersioniOS;
                        });
                      },
                      showUpdateButton: showUpdateButtoniOS,
                      onUpdateTap: updateVersioniOS,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
