import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkService {
  static const String _key = 'bookmarked_formulas';
  static final ValueNotifier<int> changes = ValueNotifier<int>(0);

  static String createId({
    required String subject,
    required int chapterNumber,
    required String formulaName,
  }) {
    return '$subject|$chapterNumber|$formulaName';
  }

  // Get all bookmarked formula IDs.
  static Future<List<String>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(_key) ?? [];
  }

  // Check whether a formula is bookmarked.
  static Future<bool> isBookmarked({
    required String subject,
    required int chapterNumber,
    required String formulaName,
  }) async {
    final bookmarks = await getBookmarks();

    final id = createId(
      subject: subject,
      chapterNumber: chapterNumber,
      formulaName: formulaName,
    );

    return bookmarks.contains(id);
  }

  // Add a bookmark.
  static Future<void> addBookmark({
    required String subject,
    required int chapterNumber,
    required String formulaName,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final bookmarks = prefs.getStringList(_key) ?? [];

    final id = createId(
      subject: subject,
      chapterNumber: chapterNumber,
      formulaName: formulaName,
    );

    if (!bookmarks.contains(id)) {
      bookmarks.add(id);

      await prefs.setStringList(
        _key,
        bookmarks,
      );
    }
  }

  // Remove a bookmark.
  static Future<void> removeBookmark({
    required String subject,
    required int chapterNumber,
    required String formulaName,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final bookmarks = prefs.getStringList(_key) ?? [];

    final id = createId(
      subject: subject,
      chapterNumber: chapterNumber,
      formulaName: formulaName,
    );

    bookmarks.remove(id);

    await prefs.setStringList(
      _key,
      bookmarks,
    );
  }

  // Add or remove a bookmark.
  static Future<void> toggleBookmark({
    required String subject,
    required int chapterNumber,
    required String formulaName,
  }) async {
    final bookmarked = await isBookmarked(
      subject: subject,
      chapterNumber: chapterNumber,
      formulaName: formulaName,
    );

    if (bookmarked) {
      await removeBookmark(
        subject: subject,
        chapterNumber: chapterNumber,
        formulaName: formulaName,
      );
    } else {
      await addBookmark(
        subject: subject,
        chapterNumber: chapterNumber,
        formulaName: formulaName,
      );
    }

    changes.value++;
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_key);
    changes.value++;
  }
}

