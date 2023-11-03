import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/utils/global_variable.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({Key? key, required this.webScreenLayout, required this.mobileScreenLayout}) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      if(constraints.maxWidth>webScreenSize){
        print("webScreenSize........$webScreenSize");
        return widget.webScreenLayout;
        // return const Text('Web');

      }else{
        return widget.mobileScreenLayout;
        // return const Text('Mobile');
      }
    },);
  }

  void addData() async{
    UserProvider _userProvider=Provider.of(context,listen: false);
    await _userProvider.refreshUser();
  }
}
