import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';

//  轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(1080),
      height: ScreenUtil().setHeight(500),
      child: Swiper(
        itemCount: swiperDataList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Fluttertoast.showToast(
                msg: "点击了${swiperDataList[index]}",
              );
            },
            child: Container(
              decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage("${swiperDataList[index]}"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
        autoplay: true,
//        viewportFraction: 0.8,
        scale: 0.8,
        loop: false,
        pagination: new SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Colors.white.withOpacity(0.5),
            activeColor: Colors.white,
          ),
          margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
        ),
      ),
    );
  }
}
