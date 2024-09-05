import 'package:flutter/material.dart';
import 'package:instagramclone/provider/user_provider.dart';
import 'package:instagramclone/utils/globalVeriables.dart';
import 'package:provider/provider.dart';

class ReposnsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ReposnsiveLayout(
      {super.key,
      required this.webScreenLayout,
      required this.mobileScreenLayout});

  @override
  State<ReposnsiveLayout> createState() => _ReposnsiveLayoutState();
}

class _ReposnsiveLayoutState extends State<ReposnsiveLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        //web screen
        return widget.webScreenLayout;
      }
      //mobile screen layout
      return widget.mobileScreenLayout;
    });
  }
}
