import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZigoTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;

  const ZigoTopAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.manrope(fontWeight: FontWeight.bold),
      ),
      leading: leading,
      actions: actions,
      backgroundColor: Colors.white.withOpacity(0.8),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
