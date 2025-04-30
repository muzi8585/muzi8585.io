import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Data/Controller.dart';

class Commonwidget extends ConsumerStatefulWidget {
  const Commonwidget({super.key});

  @override
  ConsumerState<Commonwidget> createState() => _CommonwidgetState();
}

class _CommonwidgetState extends ConsumerState<Commonwidget> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
              child: Text(
                'Add App Version',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
                height: 40,
                width: 250,
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: controller,
                  cursorColor: Colors.black,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.-]')),
                  ],
                  decoration: InputDecoration(
                    hintText: '0.0.0',
                    hintStyle: const TextStyle(color: Colors.grey),
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
                  ),
                )),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                setState(() {
                  ref
                      .watch(versionControllerProvider.notifier)
                      .saveVersion(context, controller);
                  controller.clear();
                });
              },
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.teal, borderRadius: BorderRadius.circular(8)),
                child: const Center(
                    child: Text(
                  'Save',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
