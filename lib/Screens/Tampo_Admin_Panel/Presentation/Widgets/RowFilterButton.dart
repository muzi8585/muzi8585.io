import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final selectedLevelProvider = StateProvider<String>((ref) => 'All Level');

class RowWidgetButtons extends ConsumerWidget {
  var selectedLevel;
  RowWidgetButtons({super.key, required this.selectedLevel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Row(
        children: [
          FilterButton(
            text: 'All Level',
            onTap: () =>
                ref.read(selectedLevelProvider.state).state = 'All Level',
            selected: selectedLevel == 'All Level',
          ),
          FilterButton(
            text: 'Amazing',
            onTap: () => ref.read(selectedLevelProvider.state).state =
                'FeedbackType.amazing',
            selected: selectedLevel == 'FeedbackType.amazing',
          ),
          FilterButton(
            text: 'Good',
            onTap: () => ref.read(selectedLevelProvider.state).state =
                'FeedbackType.good',
            selected: selectedLevel == 'FeedbackType.good',
          ),
          FilterButton(
            text: 'Okay',
            onTap: () => ref.read(selectedLevelProvider.state).state =
                'FeedbackType.okay',
            selected: selectedLevel == 'FeedbackType.okay',
          ),
          FilterButton(
            text: 'Bad',
            onTap: () => ref.read(selectedLevelProvider.state).state =
                'FeedbackType.bad',
            selected: selectedLevel == 'FeedbackType.bad',
          ),
          FilterButton(
            text: 'Terrible',
            onTap: () => ref.read(selectedLevelProvider.state).state =
                'FeedbackType.terrible',
            selected: selectedLevel == 'FeedbackType.terrible',
          ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool selected;

  const FilterButton({
    required this.text,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 3),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(right: 8, left: 8, top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: selected ? Colors.teal.withOpacity(0.1) : Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: selected ? Colors.teal : Colors.black12,
            ),
          ),
          child: Text(
            text,
            maxLines: 1,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: selected ? Colors.teal : Colors.black38,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
