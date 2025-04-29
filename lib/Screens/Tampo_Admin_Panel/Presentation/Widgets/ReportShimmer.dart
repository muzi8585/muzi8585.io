import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Data/Provider.dart';
import 'package:shimmer/shimmer.dart';

class ReportShimmer extends ConsumerWidget {
   const ReportShimmer({key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
        final reportAsyncValue = ref.watch(fetchReportProvider).when(
          skipLoadingOnRefresh: false,
          data: (tasks) => tasks.length,
          loading: () => null,
          error: (error, stackTrace) => null,
        );
    return ListView.builder(
      itemCount: reportAsyncValue,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 10,
                  width: 170,
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                Container(
                  height: 15,
                  width: 200,
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 10,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 10,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
                const SizedBox(height: 8),
              
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 10,
                      width: 80,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
