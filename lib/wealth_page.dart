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
    _tabController = TabController(length: 4, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 顶部背景与搜索
          _buildTopSection(),
          
          // 主体内容区域
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 合并的功能按钮区域
                  _buildCombinedFunctionButtons(),
                  
                  // 我的关注区域
                  _buildMyFocusSection(),
                  
                  // 财富管理区域
                  _buildWealthManagementSection(),
                  
                  // 财富直击区域
                  _buildWealthDirectSection(),
                  
                  // 零钱投资广告
                  _buildInvestmentAdSection(),
                  
                  // 人人需要四笔钱区域
                  _buildFourMoneyTypesSection(),
                  
                  // 快速入口选项
                  _buildQuickEntryOptions(),
                  
                  // 零钱区域提示
                  _buildPocketMoneyHintSection(),
                  
                  // 产品推荐
                  _buildProductRecommendation(),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 顶部区域（包含背景和搜索框）
  Widget _buildTopSection() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFF5E6BE),
            const Color(0xFFF5E6BE).withOpacity(0.8),
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // 搜索框
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.brown, size: 20),
                          const SizedBox(width: 10),
                          Text('稳健增值优选',
                              style: TextStyle(color: Colors.brown.withOpacity(0.7))),
                          const Spacer(),
                          const Icon(Icons.mic, color: Colors.brown, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 15,
                    child: Icon(Icons.headset_mic, color: Colors.blue, size: 18),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.add_circle_outline, color: Colors.brown, size: 24),
                ],
              ),
            ),
            
            // 建行龙财富标题和资产信息
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '建行龙财富',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text(
                        '总资产(元)',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(Icons.remove_red_eye_outlined, color: Colors.brown, size: 18),
                      const Icon(Icons.refresh, color: Colors.brown, size: 18),
                      const Spacer(),
                      const Text(
                        '昨日收益(元)',
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        '318,727.73',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        '-91.86',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Icon(Icons.keyboard_arrow_down, color: Colors.brown),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 合并的功能按钮区域
  Widget _buildCombinedFunctionButtons() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // 第一行按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIconButton('存款产品', Icons.account_balance),
              _buildIconButton('理财产品', Icons.bar_chart, onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FinancialProductPage()),
                );
              }),
              _buildIconButton('基金投资', Icons.show_chart),
              _buildIconButton('保险', Icons.shield_outlined),
              _buildIconButton('贵金属', Icons.monetization_on_outlined),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // 第二行按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSpecialIconButton('建行严选', Icons.diamond_outlined),
              _buildSpecialIconButton('龙钱宝1号', Icons.monetization_on_outlined),
              _buildSpecialIconButton('龙钱宝2号', Icons.home_outlined),
              _buildSpecialIconButton('速盈', Icons.flash_on_outlined),
              _buildSpecialIconButton('更多', Icons.more_horiz),
            ],
          ),
        ],
      ),
    );
  }

  // 我的关注区域
  Widget _buildMyFocusSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '我的关注',
            style: TextStyle(
              fontSize: 14,
              // fontWeight: FontWeight.bold,
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  // 财富管理区域
  Widget _buildWealthManagementSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '财富管理',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '资产配置',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '点击一键配置',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5A623),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        '前往',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset('assets/images/coin.png', 
                              errorBuilder: (context, error, stackTrace) => 
                              const Icon(Icons.monetization_on, size: 80, color: Color(0xFFF5A623))),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '养老规划',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '提前规划 养老无忧',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5A623),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        '前往',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset('assets/images/elder.png', 
                              errorBuilder: (context, error, stackTrace) => 
                              const Icon(Icons.elderly, size: 80, color: Colors.blue)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 财富直击区域
  Widget _buildWealthDirectSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '财富直击',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          
          // 产品分类Tab
          SizedBox(
            height: 40,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.amber.shade700,
                    width: 3.0,
                  ),
                ),
              ),
              labelColor: Colors.amber.shade700,
              unselectedLabelColor: Colors.black,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              tabs: const [
                Tab(text: '多享系列'),
                Tab(text: '理财精选'),
                Tab(text: '基金精选'),
                Tab(text: '稳健优选'),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // 日日享和周周享
          Row(
            children: [
              Expanded(
                child: _buildRateCard('日日享', '2.03%'),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _buildRateCard('周周享', '1.96%'),
              ),
            ],
          ),
          
          const SizedBox(height: 15),
          
          // 月月享和年年享
          Row(
            children: [
              Expanded(
                child: _buildRateCard('月月享', '2.45%'),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _buildRateCard('年年享', '3.48%'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 零钱投资广告区域
  Widget _buildInvestmentAdSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
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
                    '零钱投资好帮手',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '轻松转入 灵活申赎',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '基金有风险，投资需谨慎。(中国建设银行代销)',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.credit_card,
                color: Colors.blue,
                size: 60,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Text(
              '广告',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  // 人人需要四笔钱区域
  Widget _buildFourMoneyTypesSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '人人需要四笔钱',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.amber.shade700),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.help_outline, size: 16, color: Colors.amber.shade700),
                const SizedBox(width: 5),
                Text(
                  '不知道如何规划 去一键配置',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.amber.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 快速入口选项
  Widget _buildQuickEntryOptions() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          _buildQuickEntryButton('零钱管理', Colors.amber.shade700),
          const SizedBox(width: 10),
          _buildQuickEntryButton('稳健投资', Colors.blue.shade700),
          const SizedBox(width: 10),
          _buildQuickEntryButton('追求回报', Colors.purple.shade700),
          const SizedBox(width: 10),
          _buildQuickEntryButton('保险保障', Colors.green.shade700),
        ],
      ),
    );
  }

  // 零钱区域提示
  Widget _buildPocketMoneyHintSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        '随时要用的钱在这里',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
    );
  }

  // 产品推荐
  Widget _buildProductRecommendation() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
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
              const Text(
                '建信现金添益A',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  '基金',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '1.6070%',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '7日年化收益率',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 30),
              const Expanded(
                child: Text(
                  '货币基金 流动性管理优选',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 无边框图标按钮 (第一行)
  Widget _buildIconButton(String label, IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 65,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    icon,
                    color: Colors.black87,
                    size: 28,
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE1A100),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // 特殊图标按钮 (第二行)
  Widget _buildSpecialIconButton(String label, IconData icon) {
    return SizedBox(
      width: 65,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 图标 (没有边框)
                Icon(
                  icon,
                  color: const Color(0xFFE1A100),
                  size: 26,
                ),
                // 右下角的黄色小圆点
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Icon(
                    Icons.circle,
                    color: const Color(0xFFE1A100),
                    size: 8,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // 收益率卡片
  Widget _buildRateCard(String title, String rate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          rate,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade700,
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
    );
  }

  // 快速入口按钮
  Widget _buildQuickEntryButton(String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: color, width: 2),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
} 