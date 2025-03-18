import 'package:flutter/material.dart';
import 'wealth_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isLoading = false;
  final List<Widget> _pages = [
    const HomeContent(),
    const Center(child: Text('信用卡')),
    const WealthPage(),
    const Center(child: Text('生活')),
    const Center(child: Text('我的')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 0 
          ? const HomeContent() 
          : _selectedIndex == 2 
              ? const WealthPage()
              : _buildLoadingOrPlaceholder(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildLoadingOrPlaceholder() {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(
              _selectedIndex == 1 ? '信用卡页面加载中...' : 
              _selectedIndex == 3 ? '生活页面加载中...' : '我的页面加载中...',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _selectedIndex == 1 ? Icons.credit_card : 
              _selectedIndex == 3 ? Icons.coffee : Icons.person,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 20),
            Text(
              _selectedIndex == 1 ? '信用卡' : 
              _selectedIndex == 3 ? '生活' : '我的',
              style: TextStyle(fontSize: 20, color: Colors.grey.shade400),
            ),
          ],
        ),
      );
    }
  }

  // 底部导航栏
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        // 如果点击的是当前选中项，不做任何操作
        if (index == _selectedIndex) return;
        
        setState(() {
          _selectedIndex = index;
          
          // 只对信用卡、生活和我的页面显示加载动画
          if (index == 1 || index == 3 || index == 4) {
            _isLoading = true;
            
            // 模拟加载，3秒后结束
            Future.delayed(const Duration(seconds: 3), () {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
              }
            });
          }
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue.shade700,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '首页',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.credit_card),
          label: '信用卡',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: '财富',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.coffee),
          label: '生活',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: '我的',
        ),
      ],
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 背景渐变
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade400,
                  Colors.blue.shade100,
                ],
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // 顶部搜索栏
                _buildSearchBar(),
                
                // 内容区域
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 电费达标礼Banner
                        _buildPromotionBanner(),
                        
                        // 功能按钮区域1
                        _buildFunctionButtons1(),
                        
                        // 功能按钮区域2
                        _buildFunctionButtons2(),
                        
                        // 功能按钮区域3
                        _buildFunctionButtons3(),
                        
                        // 账户变动通知
                        _buildAccountNotification(),
                        
                        // 投资理财区域
                        _buildInvestmentSection(),
                        
                        // 资产配置与养老规划
                        _buildAssetPlanningSection(),
                        
                        // 底部广告
                        _buildBottomAd(),
                        
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 顶部搜索栏
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          // 位置信息
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: Colors.white, size: 20),
              const SizedBox(width: 2),
              const Text('上海', style: TextStyle(color: Colors.white, fontSize: 14)),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16),
            ],
          ),
          
          // 搜索框
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.white, size: 20),
                  const SizedBox(width: 5),
                  Text('财富会员', 
                     style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14)),
                  const Spacer(),
                  const Icon(Icons.mic, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
          
          // 右侧图标
          const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 15,
            child: Icon(Icons.headset_mic, color: Colors.blue, size: 18),
          ),
          const SizedBox(width: 10),
          Stack(
            children: [
              const Icon(Icons.email_outlined, color: Colors.white, size: 24),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('99+', 
                     style: TextStyle(color: Colors.white, fontSize: 8)),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          const Icon(Icons.add_circle_outline, color: Colors.white, size: 24),
        ],
      ),
    );
  }

  // 电费达标礼Banner
  Widget _buildPromotionBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 120,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '电费达标礼',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '领取600任务分',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: const Icon(
                Icons.card_giftcard,
                color: Colors.white,
                size: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 功能按钮区域1
  Widget _buildFunctionButtons1() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFunctionButton(Icons.account_balance_wallet, '账户查询', Colors.blue),
          _buildFunctionButton(Icons.swap_horiz, '转账汇款', Colors.blue),
          _buildFunctionButton(Icons.monetization_on, '贷款', Colors.blue),
          _buildFunctionButton(Icons.qr_code_scanner, '扫一扫', Colors.blue),
        ],
      ),
    );
  }

  // 功能按钮区域2
  Widget _buildFunctionButtons2() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildOutlinedButton(Icons.savings, '存款产品'),
          _buildOutlinedButton(Icons.show_chart, '基金投资'),
          _buildOutlinedButton(Icons.credit_card, '信用卡申请'),
          _buildOutlinedButton(Icons.speed, '快贷'),
          _buildOutlinedButton(Icons.attach_money, '龙钱宝1号'),
        ],
      ),
    );
  }

  // 功能按钮区域3
  Widget _buildFunctionButtons3() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildOutlinedButton(Icons.elderly, '个人养老金'),
          _buildOutlinedButton(Icons.phone_android, '手机话费'),
          _buildOutlinedButton(Icons.home, '住房公积金'),
          _buildOutlinedButton(Icons.task, '任务中心'),
          _buildOutlinedButton(Icons.trending_up, '贵金属'),
        ],
      ),
    );
  }

  // 账户变动通知
  Widget _buildAccountNotification() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Row(
              children: [
                Text(
                  '动账',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 2),
                Text(
                  '99+',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            '您有66条账户变动通知，快来看看吧！',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  // 投资理财区域
  Widget _buildInvestmentSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.local_fire_department, color: Colors.white, size: 12),
                            Text('稳健低波', style: TextStyle(color: Colors.white, fontSize: 10)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '主投低波动资产',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '资金最低持有7天',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '2.23%',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    '成立以来年化',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '建信沪深300C',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    children: [
                      Text(
                        '近一月',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '-0.24%',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    '整存整取',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Row(
                    children: [
                      Text(
                        '最高年利率',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '1.90%',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 资产配置与养老规划
  Widget _buildAssetPlanningSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.pie_chart, color: Colors.blue, size: 24),
                  SizedBox(width: 10),
                  Text(
                    '资产配置',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.elderly, color: Colors.blue, size: 24),
                  SizedBox(width: 10),
                  Text(
                    '养老规划',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 底部广告
  Widget _buildBottomAd() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.indigo.shade900,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          SizedBox(width: 20),
          Text(
            '3·15',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // 功能按钮组件（带蓝色背景）
  Widget _buildFunctionButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: color,
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  // 功能按钮组件（带轮廓）
  Widget _buildOutlinedButton(IconData icon, String label) {
    return SizedBox(
      width: 65,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Colors.blue.shade800,
              size: 22,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
} 