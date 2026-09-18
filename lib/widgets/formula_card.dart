
import 'package:flutter/material.dart';

import 'package:formula_hub/models/formula.dart';

import '../theme/app_colors.dart';
import '../services/bookmark_service.dart';

import 'package:flutter_math_fork/flutter_math.dart';

class FormulaCard extends StatefulWidget {
  final Formula formula;
  final int sequence;

  final String subject;
  final int chapterNumber;

  final VoidCallback onTap;

  final VoidCallback? onBookmarkChanged;

  const FormulaCard({
    super.key,
    required this.formula,
    required this.sequence,
    required this.subject,
    required this.chapterNumber,
    required this.onTap,
    this.onBookmarkChanged,
  });

  @override
  State<FormulaCard> createState() => _FormulaCardState();
}

class _FormulaCardState extends State<FormulaCard> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();

    BookmarkService.changes.addListener(_reloadBookmark);
    loadBookmark();
  }

  void _reloadBookmark() {
    loadBookmark();
  }

  @override
  void dispose() {
    BookmarkService.changes.removeListener(_reloadBookmark);
    super.dispose();
  }

  Future<void> loadBookmark() async {
    final result = await BookmarkService.isBookmarked(
      subject: widget.subject,
      chapterNumber: widget.chapterNumber,
      formulaName: widget.formula.name,
    );

    if (mounted) {
      setState(() {
        isBookmarked = result;
      });
    }
  }

  Future<void> toggleBookmark() async {
    await BookmarkService.toggleBookmark(
      subject: widget.subject,
      chapterNumber: widget.chapterNumber,
      formulaName: widget.formula.name,
    );

    if (mounted) {
      setState(() {
        isBookmarked = !isBookmarked;
      });

      widget.onBookmarkChanged?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,

        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            offset: Offset(-3, 3),
            blurRadius: 15,
            spreadRadius: 2.0,
          ),
        ],

        borderRadius: BorderRadius.circular(10),
      ),

      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),

      child: Material(
        borderRadius: BorderRadius.circular(10),

        color: Colors.transparent,

        child: InkWell(
          splashColor: AppColors.splashColorlor,

          borderRadius: BorderRadius.circular(10),

          onTap: widget.onTap,

          child: Container(
            constraints: BoxConstraints(
              minHeight: 68.0,
            ),

            width: 320.0,

            padding: EdgeInsets.fromLTRB(
              16,
              12,
              18,
              13,
            ),

            alignment: Alignment.centerLeft,

            child: Row(
              children: [
                SizedBox(
                  width: 12.0,
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.sequence}. "
                        "${widget.formula.name}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5,
                        ),
                      ),

                      SizedBox(
                        height: 2,
                      ),

                      Math.tex(
                        widget.formula.expression,

                        textStyle: TextStyle(
                          color: AppColors.subtitle,
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: toggleBookmark,

                  icon: Icon(
                    isBookmarked
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                  color: AppColors.primary,
                  ),
                  
                ),

                Icon(
                  Icons.arrow_forward_ios,
                  size: 18.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
