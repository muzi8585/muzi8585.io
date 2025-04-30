import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Feedbackshimmer extends StatelessWidget {
  const Feedbackshimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: 6, // simulate 6 cards
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 2.6,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description bar
                Container(
                  height: 14,
                  width: double.infinity,
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                // Name bar
                Container(
                  height: 14,
                  width: 120,
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                // Feedback widget area
                Container(
                  height: 24,
                  width: 90,
                  color: Colors.white,
                ),
                const Spacer(),
                // Date bar aligned right
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 12,
                    width: 60,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
