import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luggagemanagementsystem/pages/deposit_page.dart';
import 'package:luggagemanagementsystem/pages/me_page.dart';
import 'package:luggagemanagementsystem/pages/receive_page.dart';
import 'package:luggagemanagementsystem/provide/index_provider.dart';
import 'package:provide/provide.dart';

class IndexPage extends StatelessWidget {
  //  底部按钮栏
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(Icons.enhanced_encryption),
      title: Text("寄存"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.card_travel),
      title: Text("领取"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text("我的"),
    ),
  ];

  //  底部按钮对应页面
  final List<Widget> tabPages = [
    DepositPage(),
    ReceivePage(),
    MePage(),
  ];

  //  页面控制器，控制左右滑动切换页面
  PageController pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1980);
    return Provide<IndexProvider>(
      builder: (context, child, indexProvider) {
        return Scaffold(
          appBar: AppBar(
            title: Text('智能酒店行李管理'),
          ),
          body: PageView.builder(
            onPageChanged: (int index) {
              Provide.value<IndexProvider>(context).indexChange(index);
            },
            controller: pageController,
            itemCount: tabPages.length,
            itemBuilder: (BuildContext context, int index) {
              return tabPages[index];
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.grey[200],
            items: bottomTabs,
            currentIndex: Provide.value<IndexProvider>(context).currentIndex,
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.teal,
            unselectedItemColor: Colors.black,
            onTap: (int index) {
              pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
          ),
        );
      },
    );
  }
}
