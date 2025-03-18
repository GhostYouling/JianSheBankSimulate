import 'package:flutter/material.dart';

class MyFinancePage extends StatefulWidget {
  const MyFinancePage({super.key});

  @override
  State<MyFinancePage> createState() => _MyFinancePageState();
}

class _MyFinancePageState extends State<MyFinancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 顶部蓝色区域
          _buildTopSection(),
          
          // 内容区域
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 交易进行中提示
                  // _buildTransactionAlert(),
                  
                  // 功能按钮区
                  _buildFunctionButtons(),
                  
                  // 视图切换
                  _buildViewToggle(),
                  
                  // 产品列表标题
                  _buildSectionTitle(),
                  
                  // 产品列表
                  _buildProductList(),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // 顶部蓝色区域
  Widget _buildTopSection() {
    return Container(
      color: const Color(0xFF0751a6),
      padding: EdgeInsets.only(
        top: 40,
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
                icon: const Icon(Icons.headset_mic, color: Colors.white),
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
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.remove_red_eye_outlined, color: Colors.white, size: 16),
              const Spacer(),
              Row(
                children: [
                  const Text(
                    '人民币',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    '|',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Row(
                    children: [
                      const Text(
                        '全部',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 5),
          
          // 总资产金额
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '306,783.57',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // 持仓盈亏、份额、累计盈亏
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAssetInfoItem('持仓盈亏(元)', '+5,859.57'),
              _buildAssetInfoItem('持仓份额(份)', '272562.0300'),
              _buildAssetInfoItem('累计盈亏(元)', '5,859.57'),
            ],
          ),
        ],
      ),
    );
  }

  // 资产信息项
  Widget _buildAssetInfoItem(String title, String value) {
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
            const SizedBox(width: 3),
            Icon(Icons.info_outline, color: Colors.white70, size: 14),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // 交易进行中提示
  Widget _buildTransactionAlert() {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.circle, color: Colors.blue, size: 12),
          const SizedBox(width: 10),
          const Text(
            '当前有1笔交易，进行中',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  // 功能按钮区
  Widget _buildFunctionButtons() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFunctionButton(Icons.add, '我的关注'),
          _buildFunctionButton(Icons.search, '交易查询'),
          _buildFunctionButton(Icons.description_outlined, '问卷调查'),
          _buildFunctionButton(Icons.account_balance_wallet, '智富盈'),
        ],
      ),
    );
  }

  // 功能按钮
  Widget _buildFunctionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            icon,
            color: Colors.blue,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // 视图切换
  Widget _buildViewToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '视图切换',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                  ),
                  child: Icon(Icons.list, color: Colors.blue),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Icon(Icons.grid_view, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 产品列表标题
  Widget _buildSectionTitle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            '全部理财',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Text(
            '参考市值/持仓收益',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // 产品列表
  Widget _buildProductList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          _buildProductItem(
            '龙鑫固收类最低持有120天（代销建信理财）',
            '306,783.57',
            '+5,859.57',
          ),
        ],
      ),
    );
  }

  // 产品项
  Widget _buildProductItem(String name, String value, String profit) {
    return GestureDetector(
      onTap: () {
        // 点击产品项时跳转到产品详情页
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      profit,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        '开放赎回: 工作日 09:00～17:00',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),                  
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 底部导航栏
  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 1,
      selectedItemColor: const Color(0xFF05408a),
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 0) {
          Navigator.pop(context);
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance),
          label: '理财产品',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: '我的理财',
        ),
      ],
    );
  }
}

// 修改ProductDetailPage类的定义
class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);
  
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final Color mainBlue = const Color(0xFF0751a6);
  final Color darkBlue = const Color(0xFF05408a);
  final Color redColor = Colors.red;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('持仓详情', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductHeader(),
            _buildAssetInfo(),
            _buildActionButtons(),
            _buildNoticeBox(),
            _buildNetValueChart(),
            _buildRiskResistance(),
            _buildAnnualReturns(),
            _buildRedemptionRules(),
            _buildProductDescription(),
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '龙鑫固收类最低持有120天（代销建信理财）',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            '2ALDZ0202009A001（代销）建信理财有限责任公司',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssetInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '总资产(元)',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(width: 5),
              const Icon(Icons.info_outline, size: 12, color: Colors.grey),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: mainBlue),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.remove_red_eye_outlined, size: 12, color: mainBlue),
                    const SizedBox(width: 4),
                    Text('隐藏资产', style: TextStyle(fontSize: 12, color: mainBlue)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            '306,783.57',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '累计收益(元)',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '+5,859.57',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    '持有份额',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    '272562.0300',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Column(
                children: [
                  Icon(Icons.check_box_outlined, color: Colors.grey),
                  SizedBox(height: 4),
                  Text('自动申赎', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Column(
                children: [
                  Icon(Icons.swap_horiz, color: Colors.grey),
                  SizedBox(height: 4),
                  Text('交易记录', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoticeBox() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('下个交易日', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('赎回到账时间', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('可提回日期', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('· ', style: TextStyle(color: mainBlue, fontWeight: FontWeight.bold)),
              Expanded(
                child: const Text(
                  '本产品仅在交易日可申购，请持T+0天和约定申请日赎回，建议您在03月17日17点前申请，预计03月19日确认交易结果',
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNetValueChart() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('单位净值', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const Text('成立以来年化', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('2022-03-26', style: TextStyle(fontSize: 12, color: Colors.grey)),
              const Text('+ 单位净值1.047200', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: 150,
            width: double.infinity,
            child: CustomPaint(
              painter: ChartPainter(mainBlue),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('查看近一个月走势 >', style: TextStyle(fontSize: 12, color: mainBlue)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskResistance() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('抗跌能力', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(flex: 2, child: const Text('时间', style: TextStyle(fontSize: 12, color: Colors.grey))),
                    Expanded(flex: 4, child: const Text('最大回撤比例', style: TextStyle(fontSize: 12, color: Colors.grey))),
                  ],
                ),
                const SizedBox(height: 12),
                _buildResistanceItem('近1个月', '0.33%'),
                _buildResistanceItem('近3个月', '0.56%'),
                _buildResistanceItem('近6个月', '0.36%'),
                _buildResistanceItem('近1年', '0.36%'),
                Row(
                  children: [
                    Expanded(flex: 2, child: Container()),
                    Expanded(flex: 4, child: const Text('0.00%', style: TextStyle(fontSize: 12, color: Colors.grey))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResistanceItem(String period, String percentage) {
    double value = double.parse(percentage.replaceAll('%', '')) / 5;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(period, style: const TextStyle(fontSize: 12))),
          Expanded(
            flex: 4, 
            child: Row(
              children: [
                Text(percentage, style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: value,
                      child: Container(
                        decoration: BoxDecoration(
                          color: mainBlue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
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

  Widget _buildAnnualReturns() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: mainBlue, width: 2),
                  ),
                ),
                padding: const EdgeInsets.only(bottom: 8),
                child: Text('年化收益率', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: mainBlue)),
              ),
              const SizedBox(width: 16),
              const Text('波动率', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey)),
              const SizedBox(width: 16),
              const Text('特定收益率', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('时间区间', style: TextStyle(fontSize: 12, color: Colors.grey)),
              const Spacer(),
              const Text('区间年化收益率', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 12),
          _buildAnnualReturnItem('成立以来年化收益率', '(2020/10/27-2023/03/12)', '2.85%'),
          _buildAnnualReturnItem('2024年最新收益率', '(2024/01/31-2024/02/31)', '3.00%'),
          _buildAnnualReturnItem('2023年最新收益率', '(2023/01/01-2023/12/31)', '3.15%'),
          _buildAnnualReturnItem('2022年最新收益率', '(2021/12/31-2022/12/31)', '2.00%'),
          _buildAnnualReturnItem('2021年最新收益率', '(2020/12/31-2021/12/31)', '3.51%'),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('查看更多走势 >', style: TextStyle(fontSize: 12, color: mainBlue)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              '理财产品过往业绩不代表其未来表现，净值随行情波动，投资需谨慎。理财产品风险为2级（中低风险）理财产品首发于2020/10/27。',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnualReturnItem(String title, String period, String rate) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 4),
                Text(period, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
          Text(rate, style: const TextStyle(fontSize: 14, color: Colors.red, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRedemptionRules() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('赎回规则', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildRuleItem('赎回时间', '产品工作日9: 00-17: 00'),
          _buildRuleItem('赎回金额', '1份起赎'),
          _buildRuleItem('赎回条件', '无'),
          _buildRuleItem('赎回限制', '需持有满120天；工作日9:00-17:00申请，预计下个交易日确认申请结果；系统根据申请先后顺序处理赎回申请。（T日）产品当前净值为预估净值'),
        ],
      ),
    );
  }

  Widget _buildRuleItem(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ),
          Expanded(
            child: Text(content, style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDescription() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('产品描述', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  const Text('协议、净值、公告 >', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Text('03/17日 17:00前申请，预计03/19日确认', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Text('可设置预约时间，指定时间自动赎回 ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text('去看看 >', style: TextStyle(fontSize: 12, color: mainBlue)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black12, width: 0.5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star_border, color: Colors.grey, size: 18),
                      const SizedBox(width: 4),
                      const Text('收藏', style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text('加购'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 添加一个简单的图表绘制
class ChartPainter extends CustomPainter {
  final Color lineColor;
  
  ChartPainter(this.lineColor);
  
  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
      
    final path = Path();
    
    // 图表数据点 (简化版)
    final points = [
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.1, size.height * 0.65),
      Offset(size.width * 0.2, size.height * 0.6),
      Offset(size.width * 0.3, size.height * 0.58),
      Offset(size.width * 0.4, size.height * 0.55),
      Offset(size.width * 0.5, size.height * 0.5),
      Offset(size.width * 0.6, size.height * 0.45),
      Offset(size.width * 0.7, size.height * 0.4),
      Offset(size.width * 0.8, size.height * 0.35),
      Offset(size.width * 0.9, size.height * 0.3),
      Offset(size.width, size.height * 0.25),
    ];
    
    path.moveTo(points[0].dx, points[0].dy);
    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    
    canvas.drawPath(path, paintLine);
    
    // 绘制底部时间轴参考线
    final paintGridLine = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
      
    canvas.drawLine(Offset(0, size.height), Offset(size.width, size.height), paintGridLine);
    
    // 绘制部分刻度
    const textStyle = TextStyle(color: Colors.grey, fontSize: 10);
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    
    final labels = ['近1月', '近3月', '近半年', '近1年'];
    for (var i = 0; i < labels.length; i++) {
      final x = size.width * (i + 1) / 5;
      canvas.drawLine(Offset(x, size.height - 5), Offset(x, size.height + 5), paintGridLine);
      
      textPainter.text = TextSpan(text: labels[i], style: textStyle);
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, size.height + 10));
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 