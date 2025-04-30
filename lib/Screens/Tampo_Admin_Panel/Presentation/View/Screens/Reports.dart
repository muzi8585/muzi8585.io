import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Data/Provider.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/Widgets/ReportShimmer.dart';
import 'package:intl/intl.dart';

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

            if (reports.isEmpty) {
              return const Center(child: Text('No reports available.'));
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: GridView.builder(
                itemCount: reports.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1.8,
                ),
                itemBuilder: (context, index) {
                  final report = reports[index];
                  return _ReportCard(report: report);
                },
              ),
            );
          },
          loading: () => const ReportShimmer(),
          error: (error, _) => Center(
            child: Text(
              'Failed to load reports: $error',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final dynamic report;

  const _ReportCard({super.key, required this.report});

  String formatDate(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 3,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            report.email,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black38,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            report.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: Text(
              report.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              formatDate(report.createdAt),
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
