import 'package:flutter/material.dart';
import 'financial_product_page.dart';

class WealthPage extends StatefulWidget {
  const WealthPage({super.key});

  @override
  State<WealthPage> createState() => _WealthPageState();
}

class _WealthPageState extends State<WealthPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC), // Light greyish blue background for the body
      body: Column(
        children: [
          // 顶部背景与搜索 + 资产卡片
          _buildTopSection(),

          // 主体内容区域
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 功能按钮网格
                  _buildGridMenu(),

                  // 财富优选区域
                  _buildWealthSelectionSection(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 顶部区域（包含背景、搜索框、资产卡片）
  Widget _buildTopSection() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFF5E6), // Light peach/orange top
            Color(0xFFFFFBF5), // Fading to white/cream
          ],
          stops: [0.0, 1.0],
        ),
      ),
      padding: const EdgeInsets.only(bottom: 10),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // 搜索栏
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.orange.withOpacity(0.1)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey[400], size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '花一笔攒一笔',
                              style: TextStyle(color: Colors.grey[400], fontSize: 14),
                            ),
                          ),
                          Icon(Icons.mic_none, color: Colors.grey[600], size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // 客服图标
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.headset_mic_outlined, color: Colors.black87, size: 24),
                      const SizedBox(height: 2),
                      const Text(
                        '客服',
                        style: TextStyle(fontSize: 10, color: Colors.black87),
                      )
                    ],
                  ),
                ],
              ),
            ),

            // 堆叠式资产卡片
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // 底层白色卡片 (活钱/理财)
                  Container(
                    margin: const EdgeInsets.only(top: 80), // Push down to peek out from bottom
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 15), // Top padding accommodates the overlap
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '活钱',
                                    style: TextStyle(color: Colors.grey[400], fontSize: 13),
                                  ),
                                  Text(
                                    '0.37',
                                    style: TextStyle(color: Colors.grey[400], fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 30),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '理财',
                                    style: TextStyle(color: Colors.grey[400], fontSize: 13),
                                  ),
                                  Text(
                                    '364,832.50',
                                    style: TextStyle(color: Colors.grey[400], fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // 下拉把手
                        Container(
                          width: 30,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 上层渐变卡片 (总资产)
                  Container(
                    height: 120, // Fixed height for consistency
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFFFF3E0), // Very light orange
                          Color(0xFFFFCC80), // Orange 200 equivalent
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Labels Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  '总资产',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF5D4037),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Icon(Icons.remove_red_eye_outlined,
                                    size: 16, color: Color(0xFF5D4037)),
                                const SizedBox(width: 5),
                                Transform.rotate(
                                  angle: 3.14 / 2,
                                  child: const Icon(Icons.sync,
                                      size: 16, color: Color(0xFF5D4037)),
                                ),
                              ],
                            ),
                            const Text(
                              '昨日收益',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFF5D4037),
                              ),
                            ),
                          ],
                        ),
                        
                        // Values Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            const Text(
                              '¥ 364,832.50',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4E342E),
                                fontFamily: 'Roboto',
                              ),
                            ),
                            const Text(
                              '- ¥ 136.60',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4E342E),
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        ),
                        
                        // Bottom Label "建行龙财富" (Centered)
                         Center(
                           child: Text(
                             '建行龙财富', 
                             style: TextStyle(
                               color: const Color(0xFF8D6E63).withOpacity(0.5), 
                               fontSize: 12,
                               fontWeight: FontWeight.bold
                             )
                           ),
                         ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  // 功能按钮网格
  Widget _buildGridMenu() {
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': '存款产品',
        'icon': Icons.description_outlined, // More document-like
        'overlayIcon': Icons.attach_money,
        'overlayColor': const Color(0xFFE1A100),
        'overlaySize': 14.0,
        'overlayOffset': const Offset(-6, 6), // Bottom left
      },
      {
        'title': '理财产品',
        'isCustom': true,
        'customBuilder': (context) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(width: 5, height: 14, margin: const EdgeInsets.symmetric(horizontal: 2), decoration: BoxDecoration(border: Border.all(color: Colors.black87, width: 1.5), borderRadius: BorderRadius.circular(1))),
            Container(width: 5, height: 22, margin: const EdgeInsets.symmetric(horizontal: 2), decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE1A100), width: 1.5), borderRadius: BorderRadius.circular(1))),
            Container(width: 5, height: 10, margin: const EdgeInsets.symmetric(horizontal: 2), decoration: BoxDecoration(border: Border.all(color: Colors.black87, width: 1.5), borderRadius: BorderRadius.circular(1))),
          ],
        ),
        'action': 'financial_product',
      },
      {
        'title': '基金投资',
        'icon': Icons.show_chart_outlined, // Chart specifically
        'isCustom': true,
        'customBuilder': (context) => Stack(
           alignment: Alignment.center,
           children: [
             Container(
               width: 28, height: 22,
               decoration: BoxDecoration(
                 border: Border.all(color: Colors.black87, width: 1.5),
                 borderRadius: BorderRadius.circular(2)
               ),
             ),
             const Positioned(
               bottom: 6,
               left: 4,
               right: 4,
               child: Icon(Icons.trending_up, size: 18, color: Color(0xFFE1A100)),
             )
           ],
        )
      },
      {
        'title': '保险',
        'icon': Icons.shield_outlined,
        'overlayIcon': Icons.check,
        'overlayColor': const Color(0xFFE1A100),
        'overlaySize': 14.0,
        'overlayOffset': const Offset(0, 0),
      },
      {
        'title': '贵金属',
        'isCustom': true,
        'customBuilder': (context) => Stack(
          alignment: Alignment.center,
          children: [
             // Two bars stacked
             Transform.translate(
               offset: const Offset(-4, 4),
               child: Transform.rotate(
                 angle: -0.2,
                 child: Container(width: 20, height: 10, decoration: BoxDecoration(border: Border.all(color: Colors.black87, width: 1.5), borderRadius: BorderRadius.circular(2))),
               ),
             ),
             Transform.translate(
               offset: const Offset(2, -2),
               child: Transform.rotate(
                  angle: 0.1,
                  child: Container(width: 20, height: 10, decoration: BoxDecoration(border: Border.all(color: Colors.black87, width: 1.5), borderRadius: BorderRadius.circular(2))),
               ),
             ),
             const Positioned(
               right: -2,
               bottom: 0,
               child: Icon(Icons.star, size: 8, color: Color(0xFFE1A100)), // Star sparkle
             )
          ],
        ),
      },
      {
        'title': '建行严选',
        'isCustom': true,
        'customBuilder': (context) => Stack(
           alignment: Alignment.center,
           children: [
             const Icon(Icons.diamond_outlined, size: 30, color: Colors.black87),
             Positioned(
               bottom: 0,
               child: Container(width: 16, height: 2, color: Colors.black87), // Underline
             ),
             const Positioned(
               top: 8,
               child: Icon(Icons.check, size: 10, color: Color(0xFFE1A100)),
             )
           ],
        )
      },
      {
        'title': '龙钱宝1号',
        'icon': Icons.hexagon_outlined,
        'overlayIcon': Icons.emoji_events, 
        'overlayColor': const Color(0xFFE1A100),
        'overlaySize': 14.0,
        'overlayOffset': const Offset(0, 0),
      },
      {
        'title': '龙钱宝2号',
        'icon': Icons.home_outlined,
        'overlayIcon': Icons.attach_money,
        'overlayColor': const Color(0xFFE1A100),
        'overlaySize': 14.0,
        'overlayOffset': const Offset(0, 2),
      },
      {
        'title': '速盈',
        'isCustom': true,
        'customBuilder': (context) => Stack(
          alignment: Alignment.center,
          children: [
             const Icon(Icons.monetization_on_outlined, size: 30, color: Colors.black87), // Coin base
             const Positioned(
               right: -2,
               bottom: -2,
               child: Icon(Icons.bolt, size: 16, color: Color(0xFFE1A100)), // Lightning overlay
             )
          ],
        ),
      },
      {
        'title': '更多',
        'icon': Icons.more_horiz_outlined, 
        'overlayIcon': null,
      },
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25), // Increased horizontal padding to squeeze columns
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: menuItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 0, // Removed vertical spacing
          crossAxisSpacing: 0, 
          childAspectRatio: 1.0, // Square aspect ratio for very tight vertical layout
        ),
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return GestureDetector(
            onTap: () {
              if (item['action'] == 'financial_product') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FinancialProductPage()),
                );
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically in cell
              children: [
                SizedBox(
                  width: 36, 
                  height: 36,
                  child: item['isCustom'] == true
                      ? item['customBuilder'](context)
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              item['icon'],
                              size: 30, 
                              color: Colors.black87,
                            ),
                            if (item['overlayIcon'] != null)
                              Positioned(
                                left: item['overlayOffset']?.dx < 0 ? item['overlayOffset'].dx.abs() : null,
                                right: item['overlayOffset']?.dx > 0 ? item['overlayOffset'].dx : null,
                                top: item['overlayOffset']?.dy < 0 ? item['overlayOffset'].dy.abs() : null,
                                bottom: item['overlayOffset']?.dy > 0 ? item['overlayOffset'].dy : null,
                                child: item['overlayOffset'] == const Offset(0, 0) || item['overlayOffset'] == null
                                  ? Center(child: Icon(item['overlayIcon'], size: item['overlaySize'], color: item['overlayColor']))
                                  : Icon(item['overlayIcon'], size: item['overlaySize'], color: item['overlayColor']),
                              ),
                             if (item['title'] == '更多') 
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black87, width: 1.5),
                                    shape: BoxShape.circle,
                                  ),
                                  width: 28,
                                  height: 28,
                                  child: const Icon(Icons.more_horiz, size: 18, color: Color(0xFFE1A100)),
                                )
                          ],
                        ),
                ),
                const SizedBox(height: 4), // Reduced text spacing
                Text(
                  item['title'],
                  style: const TextStyle(
                    fontSize: 12, 
                    color: Color(0xFF333333),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // 财富优选区域
  Widget _buildWealthSelectionSection() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题行
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '财富优选',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: 0.5, // Slight letter spacing
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.favorite_border, size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(
                    '我的关注',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // TabBar
          SizedBox(
            height: 30,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: const Color(0xFF333333),
              unselectedLabelColor: const Color(0xFF666666),
              labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(fontSize: 15),
              indicatorColor: Colors.transparent, // Remove default underline
              dividerColor: Colors.transparent,
              labelPadding: const EdgeInsets.only(right: 28), // Increased spacing
              padding: EdgeInsets.zero,
              tabs: const [
                Tab(text: '多享系列'),
                Tab(text: '零钱管理'),
                Tab(text: '稳健投资'),
                Tab(text: '追求回报'),
                Tab(text: '保险保障'),
              ],
            ),
          ),
          
          const SizedBox(height: 15),

          // 产品网格区域 (带背景)
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 10, 20), // Top/Bottom padding for the background area
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFFFFF9EF), // Very light orange/cream
                  Colors.white.withOpacity(0.5),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildProductCard(
                        title: '日日享',
                        tag: '按日申赎',
                        yieldValue: '2.29',
                        subText: '成立以来年化',
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _buildProductCard(
                        title: '周周享',
                        tag: '短期闲钱',
                        yieldValue: '1.99',
                        subText: '成立以来年化',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25), // Increased vertical spacing between rows
                Row(
                  children: [
                    Expanded(
                      child: _buildProductCard(
                        title: '月月享',
                        tag: '稳健投资',
                        yieldValue: '2.33',
                        subText: '成立以来年化',
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _buildProductCard(
                        title: '年年享',
                        tag: '长线优选',
                        yieldValue: '3.21',
                        subText: '成立以来年化',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard({
    required String title,
    required String tag,
    required String yieldValue,
    required String subText,
  }) {
    // Shared styles
    const Color tagBgColor = Color(0xFFFFF3E0); // Light orange bg for tag
    const Color tagTextColor = Color(0xFFE69830); // Darker orange text for tag
    const Color yieldColor = Color(0xFFFF8C00); // Main Orange

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: tagBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                tag,
                style: const TextStyle(
                  fontSize: 10,
                  color: tagTextColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10), // Spacing between title and yield
        // Yield Rate RichText
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: yieldValue,
                style: const TextStyle(
                  fontSize: 28, // Larger font for number
                  fontWeight: FontWeight.w600, // Semi-bold but not too heavy
                  color: yieldColor,
                  fontFamily: 'Roboto', // Ensure number font looks clean
                ),
              ),
              const TextSpan(
                text: ' %',
                style: TextStyle(
                  fontSize: 14, // Smaller font for symbol
                  fontWeight: FontWeight.w500,
                  color: yieldColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6), // Spacing between yield and subtitle
        Text(
          subText,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[500],
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

