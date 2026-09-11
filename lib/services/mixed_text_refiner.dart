import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

class MixedText extends StatelessWidget {
  final String text;
  final double fontSize;

  const MixedText({
    super.key,
    required this.text,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    final parts = _parseText(text);

    return Text.rich(
      TextSpan(
        children: parts.map((part) {
          if (part.isLatex) {
            return WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Math.tex(
                part.text,
                textStyle: TextStyle(
                  fontSize: fontSize,
                ),
              ),
            );
          }

          return TextSpan(
            text: part.text,
            style: TextStyle(
              fontSize: fontSize,
            ),
          );
        }).toList(),
      ),
    );
  }

  List<_TextPart> _parseText(String text) {
    final List<_TextPart> parts = [];

    int i = 0;
    String normalText = '';

    void flushNormalText() {
      if (normalText.isNotEmpty) {
        parts.add(
          _TextPart(
            text: normalText,
            isLatex: false,
          ),
        );
        normalText = '';
      }
    }

    while (i < text.length) {
      // --------------------------------------------------
      // 1. LaTeX command
      // Examples:
      // \Delta
      // \nu
      // \times
      // \frac{1}{2}
      // \text{ C}
      // --------------------------------------------------

      if (text[i] == '\\') {
        final result = _readLatexCommand(text, i);

        if (result != null) {
          flushNormalText();

          parts.add(
            _TextPart(
              text: result.text,
              isLatex: true,
            ),
          );

          i = result.end;
          continue;
        }
      }

      // --------------------------------------------------
      // 2. Letter with subscript or superscript
      //
      // n_i
      // n_f
      // E_n
      // x^2
      // a_{n}
      // --------------------------------------------------

      if (_isLetter(text[i])) {
        final result = _readSubscriptOrSuperscript(text, i);

        if (result != null) {
          flushNormalText();

          parts.add(
            _TextPart(
              text: result.text,
              isLatex: true,
            ),
          );

          i = result.end;
          continue;
        }
      }

      // --------------------------------------------------
      // 3. Normal character
      // --------------------------------------------------

      normalText += text[i];
      i++;
    }

    flushNormalText();

    return parts;
  }

  // ======================================================
  // READ: n_i, n^2, E_n, x_{12}, etc.
  // ======================================================

  _ParseResult? _readSubscriptOrSuperscript(
    String text,
    int start,
  ) {
    int i = start;

    // Base letter
    if (!_isLetter(text[i])) {
      return null;
    }

    i++;

    // Must have _ or ^
    if (i >= text.length ||
        (text[i] != '_' && text[i] != '^')) {
      return null;
    }

    // Save operator
    i++;

    // ----------------------------------------------
    // Case: n_{f}
    // ----------------------------------------------

    if (i < text.length && text[i] == '{') {
      final end = _findClosingBrace(text, i);

      if (end == -1) {
        return null;
      }

      i = end + 1;
    }

    // ----------------------------------------------
    // Case: n_f
    // ----------------------------------------------

    else if (i < text.length) {
      // One character after _ or ^
      i++;
    } else {
      return null;
    }

    return _ParseResult(
      text: text.substring(start, i),
      end: i,
    );
  }

  // ======================================================
  // READ LATEX COMMAND
  // ======================================================

  _ParseResult? _readLatexCommand(
    String text,
    int start,
  ) {
    int i = start;

    // Must start with \
    if (text[i] != '\\') {
      return null;
    }

    i++;

    // Need a letter after \
    if (i >= text.length || !_isLetter(text[i])) {
      return null;
    }

    // ----------------------------------------------
    // Read command name
    // Example:
    //
    // \Delta
    // \nu
    // \times
    // \frac
    // \text
    // ----------------------------------------------

    final commandStart = i;

    while (i < text.length && _isLetter(text[i])) {
      i++;
    }

    final command = text.substring(commandStart, i);

    // ----------------------------------------------
    // Commands that take {...}
    // ----------------------------------------------

    if (i < text.length && text[i] == '{') {
      final end = _findClosingBrace(text, i);

      if (end == -1) {
        return null;
      }

      i = end + 1;

      // --------------------------------------------
      // \frac{1}{2}
      // \sqrt{x}
      // \text{ C}
      // --------------------------------------------

      if (command == 'frac') {
        if (i < text.length && text[i] == '{') {
          final secondEnd = _findClosingBrace(text, i);

          if (secondEnd != -1) {
            i = secondEnd + 1;
          }
        }
      }
    }

    // ----------------------------------------------
    // Handle _ and ^ after a command
    //
    // \Delta_n
    // \Delta^{2}
    // ----------------------------------------------

    while (i < text.length &&
        (text[i] == '_' || text[i] == '^')) {
      i++;

      if (i < text.length && text[i] == '{') {
        final end = _findClosingBrace(text, i);

        if (end == -1) break;

        i = end + 1;
      } else if (i < text.length) {
        i++;
      }
    }

    // ----------------------------------------------
    // IMPORTANT:
    //
    // \Delta E
    //
    // We want:
    //
    // \Delta E
    //
    // BUT NOT:
    //
    // \Delta E is positive
    //
    // So only consume ONE mathematical letter.
    // ----------------------------------------------

    if (i < text.length && text[i] == ' ') {
      int next = i + 1;

      if (next < text.length && _isLetter(text[next])) {
        // Only consume a single letter.
        //
        // \Delta E
        //       ^
        //
        // becomes one LaTeX piece.
        if (next + 1 >= text.length ||
            !_isLetter(text[next + 1])) {
          i = next + 1;
        }
      }
    }

    return _ParseResult(
      text: text.substring(start, i),
      end: i,
    );
  }

  // ======================================================
  // FIND MATCHING }
  // ======================================================

  int _findClosingBrace(String text, int start) {
    if (start >= text.length || text[start] != '{') {
      return -1;
    }

    int depth = 0;

    for (int i = start; i < text.length; i++) {
      if (text[i] == '{') {
        depth++;
      } else if (text[i] == '}') {
        depth--;

        if (depth == 0) {
          return i;
        }
      }
    }

    return -1;
  }

  // ======================================================
  // HELPERS
  // ======================================================

  bool _isLetter(String character) {
    return RegExp(r'[A-Za-z]').hasMatch(character);
  }
}

// ========================================================
// DATA CLASSES
// ========================================================

class _TextPart {
  final String text;
  final bool isLatex;

  _TextPart({
    required this.text,
    required this.isLatex,
  });
}

class _ParseResult {
  final String text;
  final int end;

  _ParseResult({
    required this.text,
    required this.end,
  });
}