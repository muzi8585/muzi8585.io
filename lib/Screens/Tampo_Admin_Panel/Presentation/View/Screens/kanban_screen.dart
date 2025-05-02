import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Data/Provider.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/Widgets/Shimmer.dart';
import 'package:flutter_web_admin_panels/Screens/Tampo_Admin_Panel/Presentation/Widgets/WidgetPagination.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class KanbanScreen extends ConsumerStatefulWidget {
  const KanbanScreen({super.key});

  @override
  ConsumerState<KanbanScreen> createState() => _KanbanScreenState();
}

class _KanbanScreenState extends ConsumerState<KanbanScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  int _currentPage = 1;
  final int _itemsPerPage = 10;
  bool isLoading = false;
  String _sortField = 'name';
  bool _isAscending = true;

  void _refreshData() async {
    _currentPage = 1;
    setState(() {
      isLoading = true;
    });

    await ref.refresh(fetchUsersFromRepoProvider);

    setState(() {
      isLoading = false;
    });
  }

  void _sortUsers(String field) {
    setState(() {
      if (_sortField == field) {
        _isAscending = !_isAscending;
      } else {
        _sortField = field;
        _isAscending = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final usersAsyncValue = ref.watch(fetchUsersFromRepoProvider);

    return Expanded(
      child: Column(
        children: [
           Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8),
                  decoration: BoxDecoration(
                   
                    color: Colors.grey.withOpacity(0.1),
                 
                  ),
                  child: Text(
                    '   Users',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              
                Divider(
                  color: Colors.grey.withOpacity(0.2),
                  height: 1,
                ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[50]!,
                    spreadRadius: 3,
                    blurRadius: 2,
                  )
                ],
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: TextField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                cursorColor: Colors.black,
                controller: _searchController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    LucideIcons.search,
                    size: 16,
                    color: Colors.black38,
                  ),
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query.toLowerCase();
                    _currentPage = 1;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: usersAsyncValue.when(
              skipLoadingOnRefresh: false,
              data: (users) {
                final filteredUsers = _searchQuery.isEmpty
                    ? users
                    : users
                        .where((user) =>
                            user.name.toLowerCase().contains(_searchQuery))
                        .toList();

                filteredUsers.sort((a, b) {
                  final valueA = a.toMap()[_sortField];
                  final valueB = b.toMap()[_sortField];
                  return _isAscending
                      ? Comparable.compare(valueA, valueB)
                      : Comparable.compare(valueB, valueA);
                });

                final totalUsers = filteredUsers.length;
                final totalPages = (totalUsers / _itemsPerPage).ceil();
                final startIndex = (_currentPage - 1) * _itemsPerPage;
                final endIndex = min(startIndex + _itemsPerPage, totalUsers);

                final paginatedUsers =
                    filteredUsers.sublist(startIndex, endIndex);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Table(
                          border: const TableBorder(
                            horizontalInside: BorderSide.none,
                            verticalInside: BorderSide.none,
                          ),
                          columnWidths: const {
                            0: FixedColumnWidth(380),
                            1: FixedColumnWidth(480),
                            2: FixedColumnWidth(280),
                          },
                          children: [
                            TableRow(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                color: Color(0xFF2A3D56),
                              ),
                              children: [
                                TableCell(
                                  child: InkWell(
                                    onTap: () => _sortUsers('name'),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          top: 8, bottom: 8, left: 12),
                                      child: Row(
                                        children: [
                                          Icon(
                                            LucideIcons.arrowDownUp,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'Name',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: InkWell(
                                    onTap: () => _sortUsers('email'),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            LucideIcons.arrowDownUp,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'Email',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Create At',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ...paginatedUsers
                                .asMap()
                                .entries
                                .map<TableRow>((entry) {
                              final index = entry.key;
                              final user = entry.value;

                              final isEvenRow = index % 2 != 0;

                              return TableRow(
                                decoration: BoxDecoration(
                                  color: isEvenRow
                                      ? const Color(0x001e3a5f)
                                          .withOpacity(0.09)
                                      : Colors.transparent,
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        top: 12,
                                        bottom: 12),
                                    child: Text(
                                      user.name,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: const Color(0xFF2A3D56)
                                            .withOpacity(0.75),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        top: 12,
                                        bottom: 12),
                                    child: Text(
                                      user.email,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: const Color(0xFF2A3D56)
                                            .withOpacity(0.75),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5, top: 10, bottom: 10),
                                    child: Text(
                                      formatDate(getRandomDate()),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: const Color(0xFF2A3D56)
                                            .withOpacity(0.75),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: PaginationWidget(
                          currentPage: _currentPage,
                          totalPages: totalPages,
                          onPreviousPage: () {
                            setState(() {
                              _currentPage--;
                            });
                          },
                          onNextPage: () {
                            setState(() {
                              _currentPage++;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
              loading: () => const ShimmerUser(),
              error: (error, stackTrace) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DateTime getRandomDate({int startYear = 2000, int endYear = 2025}) {
    final random = Random();
    final year = random.nextInt(endYear - startYear + 1) + startYear;
    final month = random.nextInt(12) + 1;
    final day = random.nextInt(DateTime(year, month + 1, 0).day) + 1;
    final hour = random.nextInt(24);
    final minute = random.nextInt(60);
    return DateTime(year, month, day, hour, minute);
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy hh:mm a').format(dateTime);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
