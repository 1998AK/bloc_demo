import 'package:flutter/material.dart';

class AppBarCommon extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final bool showBackButton;
  final List<Widget>? actions;
  final Color backgroundColor;
  final VoidCallback? onBackPressed;

  const AppBarCommon({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.showBackButton = true,
    this.actions,
    this.backgroundColor = Colors.blue,
    this.onBackPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false, // custom back button logic
      leading: showBackButton
          ?
      IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBackPressed ?? () => Navigator.pop(context))
          :
      null,
      actions: actions,
    );
  }
}
