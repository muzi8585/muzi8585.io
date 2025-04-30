import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final selectedLevelProvider = StateProvider<String>((ref) => 'All Level');

class RowWidgetButtons extends ConsumerWidget {
  final String selectedLevel;
  const RowWidgetButtons({super.key, required this.selectedLevel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levels = {
      'All Level': 'All Level',
      'Amazing': 'FeedbackType.amazing',
      'Good': 'FeedbackType.good',
      'Okay': 'FeedbackType.okay',
      'Bad': 'FeedbackType.bad',
      'Terrible': 'FeedbackType.terrible',
    };

    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10),
      child: Wrap(
        spacing: 16,
        runSpacing: 12,
        alignment: WrapAlignment.start,
        children: levels.entries.map((entry) {
          final isSelected = selectedLevel == entry.value;
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () =>
                  ref.read(selectedLevelProvider.notifier).state = entry.value,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.teal : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? Colors.teal.shade700
                        : Colors.grey.shade300,
                    width: 1.5,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.teal.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : [],
                ),
                child: Text(
                  entry.key,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
