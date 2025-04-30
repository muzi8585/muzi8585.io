import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Data/Provider.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/Widgets/FeedbackShimmer.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/Widgets/ProjectShimmer.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/Widgets/RowFilterButton.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/Widgets/WidgetFeedback.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FeedbackScreen extends ConsumerWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedbackFuture = ref.watch(fetchFeedbackProvider);
    final usersFuture = ref.watch(fetchUsersName);
    final selectedLevel = ref.watch(selectedLevelProvider);

    return Expanded(
      child: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Colors.teal,
        onRefresh: () async {
          await ref.refresh(fetchFeedbackProvider);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RowWidgetButtons(selectedLevel: selectedLevel),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Total Feedback: ${feedbackFuture.when(
                      data: (list) => selectedLevel == 'All Level'
                          ? list.length
                          : list.where((f) => f.level == selectedLevel).length,
                      loading: () => 0,
                      error: (_, __) => 0,
                    )}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: feedbackFuture.when(
                  skipLoadingOnRefresh: false,
                  data: (feedbacks) {
                    feedbacks
                        .sort((a, b) => b.createdAt.compareTo(a.createdAt));

                    final filtered = selectedLevel == 'All Level'
                        ? feedbacks
                        : feedbacks
                            .where((f) => f.level == selectedLevel)
                            .toList();

                    if (filtered.isEmpty) {
                      return const Center(
                          child: Text('No feedback available.'));
                    }

                    return usersFuture.when(
                      data: (users) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 2.6,
                          ),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final feedback = filtered[index];
                            final user = users.firstWhere(
                              (u) => u.userUID == feedback.uid,
                              orElse: () => users.first,
                            );

                            return _FeedbackCard(
                              name: user.name,
                              level: feedback.level,
                              description: feedback.description,
                              date: feedback.createdAt,
                            );
                          },
                        );
                      },
                      loading: () => const Projectshimmer(),
                      error: (err, _) =>
                          Center(child: Text('Error loading users: $err')),
                    );
                  },
                  loading: () => const Feedbackshimmer(),
                  error: (err, _) =>
                      Center(child: Text('Error loading feedbacks: $err')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeedbackCard extends StatelessWidget {
  final String name;
  final String level;
  final String description;
  final DateTime date;

  const _FeedbackCard({
    required this.name,
    required this.level,
    required this.description,
    required this.date,
  });

  Color getLevelColor(String level) {
    switch (level.toLowerCase()) {
      case 'amazing':
        return Colors.green.shade50;
      case 'good':
        return Colors.blue.shade50;
      case 'okay':
        return Colors.yellow.shade50;
      case 'bad':
        return Colors.orange.shade50;
      case 'terrible':
        return Colors.red.shade50;
      default:
        return Colors.grey.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.15)),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 3,
              spreadRadius: 3,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 8),

          /// Bottom feedback widget
          FeedbackWidget(feedbackLevel: level),
          Row(
            children: [
              Spacer(),
              Text(
                DateFormat('MMM dd').format(date),
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
