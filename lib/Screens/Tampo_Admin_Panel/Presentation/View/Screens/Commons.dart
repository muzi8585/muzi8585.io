import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppVersion extends ConsumerStatefulWidget {
  @override
  _AppVersionState createState() => _AppVersionState();
}

class _AppVersionState extends ConsumerState<AppVersion> {
  final TextEditingController controller = TextEditingController();
  String? currentVersion;
  bool showUpdateButton = false;

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('appcommons')
          .doc('appcommons')
          .get();
      if (doc.exists) {
        final version = doc.data()?['version'] ?? '';
        setState(() {
          currentVersion = version;
          controller.text = version;
        });
      }
    } catch (e) {
      setState(() {
        currentVersion = 'Error';
        controller.text = 'Error';
      });
    }
  }

  Future<void> updateVersion() async {
    final version = controller.text.trim();
    try {
      await FirebaseFirestore.instance
          .collection('appcommons')
          .doc('appcommons')
          .set({'version': version});
      setState(() {
        currentVersion = version;
        showUpdateButton = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Version updated')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating version')),
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'App Version',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              width: 250,
              child: TextField(
                controller: controller,
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.-]')),
                ],
                onChanged: (value) {
                  setState(() {
                    showUpdateButton = value.trim() != currentVersion;
                  });
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  filled: true,
                  fillColor: const Color.fromRGBO(240, 240, 240, 0.7),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: showUpdateButton
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                          child: GestureDetector(
                            onTap: updateVersion,
                            child: Container(
                              height: 40,
                              width: 60,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Center(
                                child: Text(
                                  'Update',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
