import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/global_variable.dart';
// import 'package:instagram_clone/providers/user_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:instagram_clone/models/user.dart'as model;



class MobileScreenLayout extends StatefulWidget {
    const MobileScreenLayout({Key? key}) : super(key: key);

    @override
    State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {

    int _page=0;
    late PageController pageController;

    @override
    void initState() {
        super.initState();
        pageController=PageController();
    }

    @override
    void dispose() {
        super.dispose();
        pageController.dispose();
    }

    void navigationTapped(int page) {
        pageController.jumpToPage(page);
    }

    void onPageChanged(int page) {
        setState(() {
            _page=page;
            print('pageeeeeeeee--$page');
        });
    }


    @override
    Widget build(BuildContext context) {
        // model.User user=Provider.of<UserProvider>(context).getUser;

        return Scaffold(
            body: SafeArea(
                child: PageView(
                    controller: pageController,
                    onPageChanged: onPageChanged,
                    physics: const NeverScrollableScrollPhysics(),
                    children: homeScreenItems,
                ),
            ),
            bottomNavigationBar: BottomNavigationBar(backgroundColor:mobileBackgroundColor,items: [
                BottomNavigationBarItem(
                    label: '',
                    icon: Icon(Icons.home,color: _page==0 ? primaryColor:secondaryColor,),
                    backgroundColor: mobileBackgroundColor,
                ),
                BottomNavigationBarItem(
                    label: 'Search',
                    icon: Icon(Icons.search,color: _page==1 ? primaryColor:secondaryColor,),
                    backgroundColor: primaryColor,
                ),
                BottomNavigationBarItem(
                    label: 'Add',
                    icon: Icon(Icons.add_circle,color: _page==2 ? primaryColor:secondaryColor,),
                    backgroundColor: primaryColor,
                ),
                BottomNavigationBarItem(
                    label: 'Notification',
                    icon: Icon(Icons.favorite,color: _page==3 ? primaryColor:secondaryColor,),
                    backgroundColor: primaryColor,
                ),
                BottomNavigationBarItem(
                    label: 'Account',
                    icon: Icon(Icons.person,color: _page==4 ? primaryColor:secondaryColor,),
                    backgroundColor: primaryColor,
                ),
            ],
                onTap:navigationTapped,
            ),
        );
    }


}

