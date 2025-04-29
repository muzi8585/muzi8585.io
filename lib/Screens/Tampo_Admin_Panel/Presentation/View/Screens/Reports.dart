import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Data/Provider.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/Widgets/ReportShimmer.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    final reports = ref.watch(fetchReportProvider);

    return Expanded(
      child: RefreshIndicator(
        color: Colors.teal,
        backgroundColor: Colors.white,
        onRefresh: () async {
          await ref.refresh(fetchReportProvider);
        },
        child: reports.when(
          skipLoadingOnRefresh: false,
          data: (reports) {
            reports.sort((a, b) => b.createdAt.compareTo(a.createdAt));

            return ListView.builder(
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final report = reports[index];

                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[100]!, width: 1),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.email,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black38,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        report.title,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              report.description,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            formatDate(report.createdAt),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          loading: () => ReportShimmer(),
          error: (error, stackTrace) => Center(
            child: Text(
              'Failed to load reports: $error',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy').format(dateTime);
  }
}
