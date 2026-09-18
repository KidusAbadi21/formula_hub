import 'package:flutter/material.dart';
import '../models/bookmarked_formula.dart';
import '../theme/app_colors.dart';
import '../services/bookmark_service.dart';
import '../services/loadjson_formulas.dart';
import '../widgets/formula_card.dart';
import 'formula_detail_screen.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key, this.refreshToken = 0});

  final int refreshToken;

  @override
  State<BookmarkScreen> createState() =>
      _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {

  late Future<List<BookmarkedFormula>>
      bookmarkedFormulas;

  @override
  void initState() {
    super.initState();

    bookmarkedFormulas =
        Loadjson.loadBookmarkedFormulas();
  }

  @override
  void didUpdateWidget(covariant BookmarkScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.refreshToken != oldWidget.refreshToken) {
      refreshBookmarks();
    }
  }

  Future<void> refreshBookmarks() async {
    setState(() {
      bookmarkedFormulas =
          Loadjson.loadBookmarkedFormulas();
    });
  }

  Future<void> clearAllBookmarks() async {
    final shouldClear = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Clear all bookmarks?'),
        content: const Text(
          'This will remove every bookmarked formula.',
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primaryButotns,
            ),
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primaryButotns,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear all')
          ),
        ],
      ),
    ) ?? false;

    if (!shouldClear) {
      return;
    }

    await BookmarkService.clearAll();

    if (mounted) {
      await refreshBookmarks();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.primary,

        title: const Text(
          "Bookmarks",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        actions: [
          FutureBuilder<List<BookmarkedFormula>>(
            future: bookmarkedFormulas,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SizedBox.shrink();
              }

              return IconButton(
                tooltip: 'Clear all bookmarks',
                onPressed: clearAllBookmarks,
                icon: const Icon(
                  Icons.delete_sweep_outlined,
                  color: Colors.white,
                ),
              );
            },
          ),
        ],
      ),

      body: FutureBuilder<List<BookmarkedFormula>>(
        future: bookmarkedFormulas,

        builder: (context, snapshot) {

          // Loading
          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error
          if (snapshot.hasError) {

            return Center(
              child: Text(
                "Error loading bookmarks: "
                "${snapshot.error}",
              ),
            );
          }

          List<BookmarkedFormula> bookmarks =
              snapshot.data ?? [];

          // No bookmarks
          if (bookmarks.isEmpty) {

            return Center(
              child: Transform.translate(
                offset: const Offset(0, -56),
                child: Padding(
                  padding: const EdgeInsets.all(24),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        Container(
                          padding:
                              const EdgeInsets.all(20),                    
                          decoration: BoxDecoration(
                            color: AppColors.primary
                                .withOpacity(0.10),                   
                            shape: BoxShape.circle,
                          ),             
                          child: Icon(
                            Icons.bookmark_border,
                            size: 55,
                            color: AppColors.primary,
                          ),
                        ),
                    
                        const SizedBox(height: 20),
                    
                        const Text(
                          "No bookmarks yet",
                    
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    
                        const SizedBox(height: 8),
                    
                        Text(
                          "Bookmark formulas while studying\n"
                          "and they will appear here.",
                    
                          textAlign: TextAlign.center,
                    
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }

          // Group by subject
          Map<String, List<BookmarkedFormula>>
              subjects = {};

          for (var bookmark in bookmarks) {

            subjects
                .putIfAbsent(
                  bookmark.subject,
                  () => [],
                )
                .add(bookmark);
          }

          return ListView(
            padding: EdgeInsets.only(
              top: 8,
              bottom: 96 + MediaQuery.of(context).padding.bottom,
            ),

            children: [

              for (var subjectEntry
                  in subjects.entries) ...[

                // SUBJECT HEADER
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    12,
                    16,
                    8,
                  ),

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 13,
                    ),

                    decoration: BoxDecoration(
                      color: AppColors.primary
                          .withOpacity(0.10),

                      borderRadius:
                          BorderRadius.circular(14),

                      border: Border.all(
                        color: AppColors.primary
                            .withOpacity(0.15),
                      ),
                    ),

                    child: Row(
                      children: [

                        Container(
                          padding:
                              const EdgeInsets.all(8),

                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius:
                                BorderRadius.circular(10),
                          ),

                          child: const Icon(
                            Icons.bookmark,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            subjectEntry.key,

                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),

                        Text(
                          "${subjectEntry.value.length}",

                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // CHAPTERS
                ..._buildChapters(
                  subjectEntry.value,
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildChapters(
    List<BookmarkedFormula> formulas,
  ) {

    // Group formulas by chapter
    Map<String, List<BookmarkedFormula>>
        chapters = {};

    for (var bookmark in formulas) {

      String chapterKey =
          "${bookmark.chapterNumber}|"
          "${bookmark.chapterName}";

      chapters
          .putIfAbsent(
            chapterKey,
            () => [],
          )
          .add(bookmark);
    }

    List<Widget> result = [];

    for (var chapterEntry
        in chapters.entries) {

      List<BookmarkedFormula> chapterFormulas =
          chapterEntry.value;

      BookmarkedFormula first =
          chapterFormulas.first;

      result.add(
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),

          child: Card(
            color: AppColors.expandableCard,
            elevation: 1,
            margin: EdgeInsets.zero,

            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(14),
            ),

            child: ExpansionTile(
              backgroundColor: AppColors.expandableCardExpanded,
              collapsedBackgroundColor: AppColors.expandableCard,
              tilePadding:
                  const EdgeInsets.symmetric(
                horizontal: 14,
              ),

              childrenPadding:
                  const EdgeInsets.only(
                bottom: 8,
              ),

              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(14),
              ),

              collapsedShape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(14),
              ),

              leading: Container(
                width: 38,
                height: 38,

                decoration: BoxDecoration(
                  color: AppColors.primary
                      .withOpacity(0.10),

                  borderRadius:
                      BorderRadius.circular(10),
                ),

                child: Icon(
                  Icons.menu_book_rounded,
                  color: AppColors.primary,
                  size: 21,
                ),
              ),

              title: Text(
                "Chapter ${first.chapterNumber}",

                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              subtitle: Padding(
                padding:
                    const EdgeInsets.only(top: 3),

                child: Text(
                  first.chapterName,

                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),

              children: [

                // FORMULA CARDS
                for (int index = 0;
                    index < chapterFormulas.length;
                    index++)

                  FormulaCard(
                    key: ValueKey(
                      chapterFormulas[index]
                          .formula
                          .name,
                    ),

                    formula:
                        chapterFormulas[index]
                            .formula,

                    sequence: index + 1,

                    subject:
                        chapterFormulas[index]
                            .subject,

                    chapterNumber:
                        chapterFormulas[index]
                            .chapterNumber,

                    onTap: () async {

                      await Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (context) =>
                              FormulaDetailScreen(
                            formula:
                                chapterFormulas[index]
                                    .formula,
                          ),
                        ),
                      );

                      // Refresh when returning
                      await refreshBookmarks();
                    },

                    // Remove immediately when
                    // bookmark button is pressed
                    onBookmarkChanged: () {

                      refreshBookmarks();
                    },
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return result;
  }
}