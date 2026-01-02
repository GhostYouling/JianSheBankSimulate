import 'package:flutter/material.dart';
import 'wealth_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  
  // Tab related
  int _currentTabIndex = 0;
  final List<String> _tabs = ['财富精选', '养老', '数字人民币', '住房', '优惠专区'];
  final List<GlobalKey> _sectionKeys = List.generate(5, (_) => GlobalKey());
  bool _isTabClicking = false; // Flag to prevent scroll listener conflict when clicking

  // Colors
  final Color _blueGradientTop = const Color(0xFFD4E4FA); // Light blue top background

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isTabClicking) return;

    // Simple scroll spy: check which section is at the top
    for (int i = 0; i < _sectionKeys.length; i++) {
      final key = _sectionKeys[i];
      final context = key.currentContext;
      if (context != null) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero);
        // If the section is near the top (considering header height ~130)
        // 130 is approx height of SliverAppBar(50) + TabBar(50) + StatusBar(30)
        if (position.dy < 180 && position.dy + box.size.height > 180) {
          if (_currentTabIndex != i) {
            setState(() {
              _currentTabIndex = i;
            });
          }
          break;
        }
      }
    }
  }

  void _scrollToSection(int index) {
    setState(() {
      _currentTabIndex = index;
      _isTabClicking = true;
    });

    final key = _sectionKeys[index];
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context, 
        duration: const Duration(milliseconds: 300), 
        curve: Curves.easeInOut,
        alignment: 0.15, // Align slightly below top to show header
      ).then((_) {
        _isTabClicking = false;
      });
    } else {
      _isTabClicking = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7FC),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeContent();
      case 2:
        return const WealthPage();
      default:
        return _buildPlaceholderPage();
    }
  }

  Widget _buildHomeContent() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter, // Gradient covers the whole scrollable area
          colors: [_blueGradientTop, const Color(0xFFF2F7FC)],
          stops: const [0.0, 0.4], // Blue top fades into background color
        ),
      ),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // 1. Top Search Bar (Pinned)
          SliverAppBar(
            pinned: true,
            floating: false,
            elevation: 0,
            backgroundColor: Colors.transparent, 
            flexibleSpace: Container(
               decoration: const BoxDecoration(
                 gradient: LinearGradient(
                   begin: Alignment.topCenter,
                   end: Alignment.bottomCenter,
                   colors: [Color(0xFFD4E4FA), Color(0xFFEBF4FF)], // Subtle blue gradient for header
                 ),
               ),
            ),
            titleSpacing: 0,
            toolbarHeight: 50,
            title: _buildSearchBar(),
          ),

          // 2. Top Content (Grid Menus, Banner)
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildTopMenuGrid(),
                _buildNotificationBar(),
                _buildBanner(),
              ],
            ),
          ),

          // 3. Sticky Tab Bar
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyTabBarDelegate(
              child: Container(
                color: const Color(0xFFF2F7FC), // Match page background
                child: _buildTabBar(),
              ),
            ),
          ),

          // 4. Content Sections
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildSectionWrapper(0, _buildWealthSection()),
                _buildSectionWrapper(1, _buildPensionSection()),
                _buildSectionWrapper(2, _buildDigitalRMBSection()),
                _buildSectionWrapper(3, _buildHousingSection()),
                _buildSectionWrapper(4, _buildDiscountSection()),
                const SizedBox(height: 100), // Bottom padding
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionWrapper(int index, Widget child) {
    return Container(
      key: _sectionKeys[index],
      child: child,
    );
  }

  // --- Components ---

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
           // Left: Version/Icon
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Custom Version Icon (Square with rounded corners + circles)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87, width: 1.5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Stack(
                  children: [
                    // Top Left Circle (Hollow)
                    Positioned(
                      top: -2,
                      left: -2,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4E4FA), // Match bg
                          border: Border.all(color: Colors.black87, width: 1.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    // Bottom Right Square (Hollow)
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black87, width: 1.5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              const Text('版本', style: TextStyle(fontSize: 10, color: Colors.black87, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(width: 10),
          // Search Box
          Expanded(
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white, width: 1), // White border
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.search, color: Colors.grey, size: 20),
                  const SizedBox(width: 5),
                  const Expanded(
                    child: Text(
                      '建行快贷至高30万',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.mic_none, color: Colors.grey, size: 24),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Right Icons
          _buildTopIcon(Icons.headset_mic_outlined, '客服'),
          const SizedBox(width: 15),
          Stack(
            clipBehavior: Clip.none, // Allow badge to overflow
            children: [
              _buildTopIcon(Icons.mail_outline, '消息'),
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange, // Darker orange
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 1), // White border around badge
                  ),
                  child: const Text('99+', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopIcon(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.black87, size: 24),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.black87)),
      ],
    );
  }

  Widget _buildTopMenuGrid() {
    return Column(
      children: [
        // Top Card with 4 Big Icons
        Container(
          margin: const EdgeInsets.fromLTRB(15, 10, 15, 5),
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBigMenuItem(Icons.account_balance_wallet_outlined, '账户查询', const Color(0xFF4A90E2)),
              _buildBigMenuItem(Icons.currency_exchange, '转账汇款', const Color(0xFF4A90E2)),
              _buildBigMenuItem(Icons.monetization_on_outlined, '贷款', const Color(0xFF4A90E2)),
              _buildBigMenuItem(Icons.qr_code_scanner, '扫一扫', const Color(0xFF4A90E2)),
            ],
          ),
        ),

        // Bottom Grid with Small Icons (Directly on background)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Wrap(
            spacing: 12,
            runSpacing: 25,
            alignment: WrapAlignment.spaceBetween,
            children: [
              // Row 1
              _buildSmallMenuItemWithStack(Icons.description_outlined, '存款产品', 
                  overlayIcon: Icons.attach_money, overlayColor: const Color(0xFF1976D2), overlaySize: 10, overlayOffset: const Offset(6, 6)), // Bill with Yen
              _buildSmallMenuItemWithStack(Icons.desktop_windows_outlined, '基金投资',
                  overlayIcon: Icons.show_chart, overlayColor: const Color(0xFF1976D2), overlaySize: 12, overlayOffset: const Offset(0, 0)), // Monitor with Chart
              _buildSmallMenuItemWithStack(Icons.credit_card_outlined, '信用卡申请',
                  overlayIcon: Icons.add, overlayColor: const Color(0xFF1976D2), overlaySize: 12, overlayOffset: const Offset(6, -6)), // Card with Plus
              _buildSmallMenuItemWithStack(Icons.local_mall_outlined, '快贷',
                  overlayIcon: Icons.attach_money, overlayColor: const Color(0xFF1976D2), overlaySize: 12, overlayOffset: const Offset(0, 2)), // Bag with Yen
              _buildSmallMenuItemWithStack(Icons.insert_chart_outlined, '理财产品',
                  overlayIcon: null, overlayColor: null, overlaySize: 0, overlayOffset: Offset.zero), // Bar chart (Standard icon is close)
              
              // Row 2
              _buildSmallMenuItemWithStack(Icons.shield_outlined, '个人养老金',
                  overlayIcon: Icons.person, overlayColor: const Color(0xFF1976D2), overlaySize: 12, overlayOffset: const Offset(0, 0)), // Shield with Person
              _buildSmallMenuItemWithStack(Icons.water_drop_outlined, '生活缴费',
                  overlayIcon: Icons.bolt, overlayColor: const Color(0xFF1976D2), overlaySize: 12, overlayOffset: const Offset(0, 0)), // Drop with Bolt
              _buildSmallMenuItemWithStack(Icons.payment, '龙支付',
                  overlayIcon: Icons.circle, overlayColor: Colors.transparent, overlaySize: 0, overlayOffset: Offset.zero, isPayIcon: true),
              _buildSmallMenuItemWithStack(Icons.fact_check_outlined, '资信证明',
                  overlayIcon: Icons.star, overlayColor: const Color(0xFF1976D2), overlaySize: 10, overlayOffset: const Offset(6, 6)), // Doc with Star
              _buildSmallMenuItemWithStack(Icons.credit_card_outlined, '一键绑卡',
                  overlayIcon: Icons.link, overlayColor: const Color(0xFF1976D2), overlaySize: 14, overlayOffset: const Offset(0, 0)), // Card with Link
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBigMenuItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF64B5F6), Color(0xFF1976D2)], // Light blue to dark blue gradient
            ),
            borderRadius: BorderRadius.circular(16), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1976D2).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ]
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87)),
      ],
    );
  }

  Widget _buildSmallMenuItemWithStack(IconData baseIcon, String label, 
      {IconData? overlayIcon, Color? overlayColor, double? overlaySize, Offset? overlayOffset, bool isPayIcon = false}) {
    
    Widget iconWidget;
    
    if (isPayIcon) {
       // Dragon Pay Special Icon
       iconWidget = Stack(
         alignment: Alignment.center,
         children: [
           const Icon(Icons.crop_landscape_outlined, size: 32, color: Colors.black87),
           Text('PAY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF1976D2))),
         ],
       );
    } else {
      iconWidget = Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none, // Allow badge to overflow
        children: [
          Icon(baseIcon, size: 30, color: Colors.black87),
          if (overlayIcon != null)
            Positioned(
              left: overlayOffset?.dx == 0 ? null : (overlayOffset!.dx > 0 ? null : -overlayOffset.dx),
              right: overlayOffset?.dx == 0 ? null : (overlayOffset!.dx > 0 ? -overlayOffset.dx : null),
              top: overlayOffset?.dy == 0 ? null : (overlayOffset!.dy > 0 ? null : -overlayOffset.dy),
              bottom: overlayOffset?.dy == 0 ? null : (overlayOffset!.dy > 0 ? -overlayOffset.dy : null),
              child: Icon(overlayIcon, size: overlaySize, color: overlayColor),
            ),
             // Center overlay fallback
             if (overlayIcon != null && overlayOffset == const Offset(0, 0))
              Icon(overlayIcon, size: overlaySize, color: overlayColor),
        ],
      );
    }

    return SizedBox(
      width: 65, // Slightly wider for labels
      child: Column(
        children: [
          SizedBox(height: 32, width: 32, child: Center(child: iconWidget)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.black87), textAlign: TextAlign.center, maxLines: 1),
        ],
      ),
    );
  }

  Widget _buildNotificationBar() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: Colors.transparent, // Background handled by parent gradient/color
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD), // Light blue pill
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('动账', style: TextStyle(color: Color(0xFF1565C0), fontWeight: FontWeight.bold, fontSize: 13, fontStyle: FontStyle.italic)),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text('您有785条账户变动通知，快来看看吧！', 
              style: TextStyle(fontSize: 14, color: Colors.black87), overflow: TextOverflow.ellipsis),
          ),
          // Orange dot
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.deepOrange,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          const Icon(Icons.keyboard_arrow_right, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [const Color(0xFFFFCCBC), const Color(0xFFFFF3E0)], // Salmon/Orange gradient
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: [
          // Text Content
          Positioned(
            left: 20,
            top: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('新户线上办卡达标', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFBF360C))),
                const SizedBox(height: 5),
                const Text('享128好礼', style: TextStyle(fontSize: 14, color: Color(0xFFBF360C))),
              ],
            ),
          ),
          // Dots
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 4, width: 4, margin: const EdgeInsets.symmetric(horizontal: 2), decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
                Container(height: 4, width: 4, margin: const EdgeInsets.symmetric(horizontal: 2), decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
                Container(height: 4, width: 12, margin: const EdgeInsets.symmetric(horizontal: 2), decoration: BoxDecoration(color: Colors.blue.shade700, borderRadius: BorderRadius.circular(2))),
              ],
            ),
          ),
          // Image placeholder
          Positioned(
            right: 10,
            bottom: 10,
            top: 10,
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.card_giftcard, size: 40, color: Colors.deepOrange),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _tabs.length,
        itemBuilder: (context, index) {
          final isSelected = _currentTabIndex == index;
          return GestureDetector(
            onTap: () => _scrollToSection(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _tabs[index],
                    style: TextStyle(
                      fontSize: isSelected ? 18 : 15,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.black : Colors.grey.shade600,
                    ),
                  ),
                  if (isSelected)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: 20,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.transparent, 
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // --- Content Sections ---

  Widget _buildWealthSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Card
              Expanded(
                flex: 4,
                child: Container(
                  height: 160,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade200, blurRadius: 4, offset: const Offset(0, 2))
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.blue.shade100)
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                 const Icon(Icons.local_fire_department, size: 10, color: Colors.blue),
                                 const Text(' 策略稳健', style: TextStyle(fontSize: 10, color: Colors.blue)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text('低风险', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          const Text('龙宝按日5号A', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
                            child: const Text('代销', style: TextStyle(fontSize: 9, color: Colors.grey)),
                          )
                        ],
                      ),
                      const Spacer(),
                      const Text('1.36%', style: TextStyle(fontSize: 26, color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                      const Text('七日年化', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Right Column
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    _buildWealthSmallCard('建信渤泰债券C', '0.04%', '近三月', Colors.orange),
                    const SizedBox(height: 10),
                    _buildWealthSmallCard('整存整取', '1.55%', '最高年利率', Colors.orange),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWealthSmallCard(String title, String value, String subtitle, Color valueColor) {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 4, offset: const Offset(0, 2))
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 18, color: valueColor, fontWeight: FontWeight.bold)),
          Text(subtitle, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildPensionSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('养老'),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 150,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white, 
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.blue.shade50, Colors.white],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('早规划早受益', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const Text('个人养老金攒钱投资一举多得', style: TextStyle(fontSize: 10, color: Colors.grey)),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(60, 24),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          elevation: 0,
                        ),
                        child: const Text('去参与 >', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    _buildSimpleListTile('投专属理财', '攒幸福资本'),
                    const SizedBox(height: 10),
                    _buildSimpleListTile('专属基金上新', '费率优惠五折起'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleListTile(String title, String subtitle) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text(subtitle, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDigitalRMBSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('数字人民币'),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('钱包余额', style: TextStyle(fontSize: 14)),
                          const SizedBox(width: 5),
                          const Icon(Icons.remove_red_eye_outlined, size: 16, color: Colors.grey),
                          const SizedBox(width: 10),
                          const Icon(Icons.refresh, size: 16, color: Colors.grey),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text('¥ --', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                _buildActionIcon(Icons.qr_code_scanner, '扫一扫', Colors.blue),
                const SizedBox(width: 20),
                _buildActionIcon(Icons.payment, '付钱', Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHousingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('住房'),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                // Tabs inside Housing
                Row(
                  children: [
                    Expanded(child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      child: const Text('购房服务', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                    )),
                    Expanded(child: Container(
                      decoration: const BoxDecoration(
                         color: Colors.blue,
                         borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      child: const Text('租房服务', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    )),
                  ],
                ),
                // Grid content
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildBigMenuItem(Icons.assignment_outlined, '房贷预审', Colors.grey),
                      _buildBigMenuItem(Icons.person_search_outlined, '我的贷款', Colors.grey),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTextLink('住房公积金'),
                      _buildTextLink('还款计划'),
                      _buildTextLink('建行找房'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextLink(String text) {
    return Row(
      children: [
        Text(text, style: const TextStyle(fontSize: 12, color: Colors.black87)),
        const Icon(Icons.keyboard_arrow_right, size: 14, color: Colors.grey)
      ],
    );
  }

  Widget _buildDiscountSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('优惠专区'),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 120,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('财富会员', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const Text('月月享好礼', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text('去了解', style: TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    _buildSimpleListTile('积分抵现', '点外卖至高可抵90%'),
                    const SizedBox(height: 10),
                    _buildSimpleListTile('权益中心', '获取尊享福利与优惠'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Text('更多', style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildPlaceholderPage() {
    return const Center(child: Text('Coming Soon'));
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        if (index == _selectedIndex) return;
        setState(() {
          _selectedIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFFE1A100), // Gold/Amber for selected
      unselectedItemColor: Colors.black87,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
      items: [
        BottomNavigationBarItem(
          icon: Icon(_selectedIndex == 0 ? Icons.home : Icons.home_outlined), 
          label: '首页'
        ),
        BottomNavigationBarItem(
          icon: Icon(_selectedIndex == 1 ? Icons.credit_card : Icons.credit_card_outlined), 
          label: '信用卡'
        ),
        BottomNavigationBarItem(
          icon: Icon(_selectedIndex == 2 ? Icons.account_balance_wallet : Icons.account_balance_wallet_outlined), 
          label: '财富'
        ),
        BottomNavigationBarItem(
          icon: Icon(_selectedIndex == 3 ? Icons.coffee : Icons.coffee_outlined), 
          label: '生活'
        ),
        BottomNavigationBarItem(
          icon: Icon(_selectedIndex == 4 ? Icons.person : Icons.person_outline), 
          label: '我的'
        ),
      ],
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyTabBarDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true; 
  }
}
