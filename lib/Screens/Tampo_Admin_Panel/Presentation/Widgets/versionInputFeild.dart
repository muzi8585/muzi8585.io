import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VersionInputField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final bool showUpdateButton;
  final VoidCallback onUpdateTap;

  const VersionInputField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.showUpdateButton,
    required this.onUpdateTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 250,
      child: TextField(
        controller: controller,
        cursorColor: Colors.black,
        keyboardType: TextInputType.text,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.\-]')),
        ],
        onChanged: onChanged,
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 5, horizontal: 8),
                  child: GestureDetector(
                    onTap: onUpdateTap,
                    child: Container(
                      height: 40,
                      width: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Text(
                          'Update',
                          style:
                              TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
