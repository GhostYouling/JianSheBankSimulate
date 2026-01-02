import 'package:flutter/material.dart';
import 'my_finance_page.dart';

class FinancialProductPage extends StatelessWidget {
  const FinancialProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 全屏显示图片，支持垂直滚动
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              physics: const ClampingScrollPhysics(), // 防止顶部/底部回弹时的空白
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/financial_product_bg.jpg',
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width,
                  ),
                  // 底部导航栏“我的理财”点击区域 (跟随图片底部)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MyFinancePage()),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2, // 占据右半边
                        height: 80, // 覆盖底部导航栏区域
                        color: Colors.transparent, // 透明
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // 隐形返回按钮区域 (覆盖在原图的返回按钮位置 - 固定在屏幕左上角)
          Positioned(
            top: MediaQuery.of(context).padding.top, // 适配刘海屏/状态栏高度
            left: 0,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 60, // 足够大的点击区域
                height: 56, // 标准 AppBar 高度附近
                color: Colors.transparent, // 透明
              ),
            ),
          ),
        ],
      ),
    );
  }
}
