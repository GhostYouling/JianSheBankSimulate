import 'package:flutter/material.dart';
import 'product_detail_page.dart';

class MyFinancePage extends StatefulWidget {
  const MyFinancePage({super.key});

  @override
  State<MyFinancePage> createState() => _MyFinancePageState();
}

class _MyFinancePageState extends State<MyFinancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Background Gradient (extended)
          Container(
            height: 450,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.7, 1.0],
                colors: [
                  Color(0xFF1565C0), // Blue 800 - darker start
                  Color(0xFF0D47A1), // Blue 900 - User preferred dark blue
                  Color(0xFFF5F5F5), // Fade to background
                ],
              ),
            ),
          ),
          
          Column(
            children: [
              // 顶部蓝色区域内容
              _buildTopSection(),
              
              // 内容区域
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // 功能按钮区
                      _buildFunctionButtons(),
                      
                      const SizedBox(height: 12),
                      
                      // 白色大卡片区域：包含视图切换、标题、产品列表
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // 视图切换和资产分析
                            _buildViewToggleAndAnalysis(),
                            
                            const Divider(height: 1, color: Color(0xFFEEEEEE)),
                            
                            // 产品列表标题
                            _buildSectionTitle(),
                            
                            const Divider(height: 1, color: Color(0xFFEEEEEE)),
                            
                            // 产品列表
                            _buildProductList(),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 80), // Bottom padding for floating button
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // 客户经理悬浮按钮
          Positioned(
            right: 16,
            bottom: 30, // Adjust based on bottom nav bar height approx
            child: _buildCustomerManagerButton(),
          ),
          
          // Floating arrow button (Right side middle-ish)
          // Based on screenshot, there is a small grey arrow button floating or attached.
          // It seems to be part of the UI overlay or a floating action button for scroll to top/next?
          // For now, I'll stick to the customer manager button as requested.
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // 顶部蓝色区域 (Only content, background is handled in Stack)
  Widget _buildTopSection() {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 20,
        left: 20,
        right: 20,
      ),
      child: Column(
        children: [
          // 顶部导航
          Row(
            children: [
              const BackButton(color: Colors.white),
              const Expanded(
                child: Center(
                  child: Text(
                    '我的理财',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.headset_mic_outlined, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // 参考总市值
          Row(
            children: [
              const Text(
                '参考总市值(元)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(width: 5),
              const Icon(Icons.remove_red_eye_outlined, color: Colors.white70, size: 16),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Row(
                  children: [
                    Text(
                      '人民币',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text('|', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ),
                    Text(
                      '全部',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down, color: Colors.white, size: 16),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 5),
          
          // 总资产金额
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '364,832.50',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Roboto', // Assuming a standard font
              ),
            ),
          ),
          
          const SizedBox(height: 25),
          
          // 资产详情网格
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAssetInfoItem('持仓盈亏(元)', '+12,745.50'),
                    const SizedBox(height: 15),
                    _buildAssetInfoItem('累计收益(元)', '+14,075.50'),
                  ],
                ),
              ),
              // Right Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAssetInfoItem('持仓份额(份)', '317989.0350', showInfoIcon: false),
                    const SizedBox(height: 15),
                    _buildAssetInfoItem('昨日收益(元)', '-136.60'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 资产信息项
  Widget _buildAssetInfoItem(String title, String value, {bool showInfoIcon = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
            if (showInfoIcon) ...[
              const SizedBox(width: 4),
              const Icon(Icons.info_outline, color: Colors.white70, size: 14),
            ],
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // 功能按钮区
  Widget _buildFunctionButtons() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFunctionButton(Icons.receipt_long_outlined, '交易查询'),
          _buildFunctionButton(Icons.help_outline, '问卷调查'),
          _buildFunctionButton(Icons.currency_yen, '零钱理财'), 
          _buildFunctionButton(Icons.savings_outlined, '智富盈'),
        ],
      ),
    );
  }

  // 功能按钮
  Widget _buildFunctionButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.black87,
          size: 28,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // 视图切换和资产分析
  Widget _buildViewToggleAndAnalysis() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                '视图切换',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900, // Very bold
                  color: Colors.black,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 8),
              // Grid Icon (Four squares)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      _buildGridDot(),
                      const SizedBox(width: 2),
                      _buildGridDot(),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      _buildGridDot(),
                      const SizedBox(width: 2),
                      _buildGridDot(),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF3B71CA), // Stronger blue
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '资产收益分析',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildGridDot() {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF3B71CA), width: 1.5),
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }

  // 产品列表标题
  Widget _buildSectionTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF8AB4F8), // Lighter blue dot
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            '全部理财',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          const Text(
            '参考市值/持仓收益',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // 产品列表
  Widget _buildProductList() {
    return Column(
      children: [
        _buildProductItem(
          '龙鑫固收类最低持有120\n天（代销建信理财）',
          '363,819.61',
          '+12,732.61',
          '2009',
          isFirst: true,
        ),
        const Divider(height: 1, indent: 16, endIndent: 16, color: Color(0xFFEEEEEE)),
        _buildProductItem(
          '嘉鑫固收最低持有7天第\n9期(代销建信理财)',
          '1,012.89',
          '+12.89',
          '2009',
          isFirst: false,
        ),
      ],
    );
  }

  // 产品项
  Widget _buildProductItem(String name, String value, String profit, String tailNum, {required bool isFirst}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductDetailPage(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF333333),
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto', 
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      profit,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFFE53935), // Red color
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0), // Light grey background
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    '开放赎回: 工作日 09:00 ~ 17:00',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF757575),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '尾号$tailNum',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF333333),
                      ),
                    ),
                    // Grey arrow if it's there in the screenshot (it seems to be a floating one, but might be associated here)
                    if (isFirst) ...[ // Assuming the arrow is relevant generally
                       // The arrow in screenshot is actually a floating one overlaying the list item, 
                       // but in standard lists it usually implies navigation. 
                       // I will leave it out as it conflicts with the "floating" arrow description or add it if needed.
                    ]
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 客户经理悬浮按钮
  Widget _buildCustomerManagerButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Grey floating arrow (as seen in screenshot right edge)
        Container(
          margin: const EdgeInsets.only(bottom: 8, right: 0),
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 16),
        ),
        
        Container(
          width: 50,
          height: 60, // Taller to accommodate label
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // Avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  image: const DecorationImage(
                     // Placeholder for the 3-person avatar
                     image: AssetImage('assets/icons/app_icon.png'), 
                     fit: BoxFit.cover,
                  )
                ),
              ),
              // Label
              Positioned(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1976D2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '客户经理',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9, 
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 底部导航栏
  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 1,
      selectedItemColor: const Color(0xFF05408a),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedLabelStyle: const TextStyle(fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontSize: 12),
      onTap: (index) {
        if (index == 0) {
          Navigator.pop(context);
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Icon(Icons.layers_outlined, size: 24),
          ),
          label: '理财产品',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Icon(Icons.trending_up, size: 24),
          ),
          label: '我的理财',
        ),
      ],
    );
  }
}


