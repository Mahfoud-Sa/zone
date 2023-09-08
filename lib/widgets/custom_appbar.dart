import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MyAppBar(this.title, {super.key});
  @override
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () {
            // context.read<RecipientsListData>().add();
            // context.read<DrawerD`ata>().getNotification();
          },
          icon: const Icon(Icons.refresh),
        ),
        IconButton(
          onPressed: () {
            // showSearch(context: context, delegate: SearchList());
          },
          icon: const Icon(Icons.search),
        ),
        // IconButton(
        //   onPressed: () {
        //     ThemeService().changeTheme();
        //   },
        //   icon: Icon(CupertinoIcons.moon_stars_fill),
        //   splashRadius: 25,
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
