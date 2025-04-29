import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Feedbackshimmer extends StatelessWidget {
  const Feedbackshimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 7, 
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 10,
                  width: 100,
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                Container(
                  height: 16,
                  width: double.infinity,
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 50,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    Container(
                      height: 10,
                      width: 80,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
