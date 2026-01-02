import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // 提取颜色常量，方便统一管理
  final Color mainBlue = const Color(0xFF4285F4); 
  final Color textGrey = const Color(0xFF9E9E9E);
  final Color bgGrey = const Color(0xFFF5F5F5);
  final Color textBlack = const Color(0xFF333333);
  final Color redColor = const Color(0xFFE53935);

  // 状态变量
  int _selectedTabIndex = 1; // 默认选中"成立以来年化"
  int _selectedTimeRangeIndex = 3; // 默认选中"近3年"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGrey,
      appBar: AppBar(
        backgroundColor: bgGrey,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '持仓详情',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMainCard(),
              const SizedBox(height: 12),
              _buildTransactionStatusCard(),
              const SizedBox(height: 12),
              _buildNetValueAndReturnsCard(),
              const SizedBox(height: 12),
              _buildRiskResistanceCard(),
              const SizedBox(height: 12),
              _buildRedemptionRulesCard(),
              const SizedBox(height: 12),
              _buildProductArchivesCard(),
              const SizedBox(height: 100), // 底部留白
            ],
          ),
        ),
      ),
      bottomSheet: _buildBottomActionSheet(),
    );
  }

  Widget _buildMainCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        children: [
          const Text(
            '龙鑫固收类最低持有120天（代销建信理\n财）',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'JXLXZD20200924001 代销 | 建信理财有限责任公司',
            style: TextStyle(fontSize: 11, color: textGrey),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('参考市值(元)', style: TextStyle(fontSize: 13, color: textGrey)),
              const SizedBox(width: 4),
              Icon(Icons.info_outline, size: 14, color: textGrey),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '363,819.61',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('累计收益(元)', style: TextStyle(fontSize: 13, color: textGrey)),
                        const SizedBox(width: 4),
                        Icon(Icons.info_outline, size: 14, color: textGrey),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '+12,732.61',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: redColor,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('持有份额', style: TextStyle(fontSize: 13, color: textGrey)),
                    const SizedBox(height: 6),
                    const Text(
                      '317,989.0350',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Icon(Icons.keyboard_arrow_down, color: textGrey.withOpacity(0.5), size: 20),
          const SizedBox(height: 15),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          SizedBox(
            height: 48,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.description_outlined, size: 16, color: textBlack),
                      const SizedBox(width: 6),
                      Text('持仓明细', style: TextStyle(fontSize: 14, color: textBlack)),
                    ],
                  ),
                ),
                Container(width: 1, height: 16, color: const Color(0xFFEEEEEE)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time, size: 16, color: textBlack),
                      const SizedBox(width: 6),
                      Text('交易记录', style: TextStyle(fontSize: 14, color: textBlack)),
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

  Widget _buildTransactionStatusCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusStep('下一个交易日', '卖出', true),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Container(
                  width: 1,
                  height: 24,
                  color: const Color(0xFFEEEEEE),
                ),
              ),
              _buildStatusStep('01/07', '资金兑付到账', true),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text('可按日申赎', style: TextStyle(fontSize: 12, color: textBlack)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 进度条区域
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(2),
                ),
                width: double.infinity,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 20,
                  width: 100, // 这里的宽度应根据实际逻辑计算
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(2),
                      bottomLeft: Radius.circular(2),
                    ),
                  ),
                ),
              ),
              const Text('投资期', style: TextStyle(fontSize: 11, color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Icon(Icons.circle, size: 6, color: mainBlue),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 12, color: textGrey, height: 1.5),
                      children: [
                        const TextSpan(text: '本产品设置最短持有期，持有120天的份额'),
                        TextSpan(text: '按日赎回', style: TextStyle(color: mainBlue)),
                        TextSpan(text: '\n01月05日17:00', style: TextStyle(color: mainBlue)),
                        const TextSpan(text: '前赎回，预计'),
                        TextSpan(text: '01月07日', style: TextStyle(color: mainBlue)),
                        const TextSpan(text: '资金自动兑付到账'),
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
  
  Widget _buildStatusStep(String labelTop, String labelBottom, bool isActive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelTop, 
          style: TextStyle(
            fontSize: 12, 
            color: textGrey,
            height: 1.4,
          )
        ),
        const SizedBox(height: 2),
        Text(
          labelBottom,
          style: TextStyle(
             fontSize: 13,
             color: textBlack,
             fontWeight: FontWeight.w500,
          )
        )
      ],
    );
  }

  Widget _buildNetValueAndReturnsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildTabItem(0, '单位净值'),
              const SizedBox(width: 24),
              _buildTabItem(1, '成立以来年化'),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('2025-12-29', style: TextStyle(fontSize: 12, color: Colors.black87)),
              Row(
                children: [
                  Icon(Icons.circle, size: 6, color: mainBlue),
                  const SizedBox(width: 4),
                  const Text('成立以来年化2.77%', style: TextStyle(fontSize: 12, color: Colors.black87)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Chart
          SizedBox(
            height: 180, // Increased height for better visibility
            width: double.infinity,
            child: CustomPaint(
              painter: ChartPainter(
                lineColor: mainBlue,
                dataPoints: [
                  3.04, 3.01, 3.05, 3.00, 2.95, 2.98, 2.94, 2.97, 2.92, 2.99, 
                  3.02, 3.05, 3.01, 2.98, 2.99, 2.89, 2.85, 2.90, 2.92, 2.88,
                  2.91, 2.89, 2.90, 2.84, 2.87, 2.82, 2.78, 2.83, 2.76, 2.79,
                  2.81, 2.78, 2.75, 2.72, 2.77
                ],
                minY: 2.44,
                maxY: 3.37,
                xLabels: ['2024-04-25', '2025-12-29'],
                yLabels: ['2.44%', '2.63%', '2.81%', '3.00%', '3.18%', '3.37%'],
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Time range selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeRangeButton(0, '近1月'),
              _buildTimeRangeButton(1, '近3月'),
              _buildTimeRangeButton(2, '近1年'),
              _buildTimeRangeButton(3, '近3年'),
            ],
          ),
          
          const SizedBox(height: 24),
          
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.8,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            padding: EdgeInsets.zero,
            children: [
              _buildDataGridItem('最新净值', '1.144098', color: redColor),
              _buildDataGridItem('净值日期', '2025/12/31'),
              _buildDataGridItem('成立以来年化收益率', '2.77%', color: redColor),
              _buildDataGridItem('可用份额', '317,989.0350'),
              _buildDataGridItem('交易账户', '6214***2009'),
              _buildDataGridItem('持仓盈亏(元) ⓘ', '+12,732.61', isInfo: true),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildTabItem(int index, String text) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? mainBlue : textGrey,
            ),
          ),
          if (isSelected) ...[
            const SizedBox(height: 6),
            Container(
              width: 20,
              height: 3,
              decoration: BoxDecoration(
                color: mainBlue,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
          ] else ...[
             const SizedBox(height: 9), // Placeholder to keep height consistent
          ]
        ],
      ),
    );
  }

  Widget _buildTimeRangeButton(int index, String text) {
    bool isSelected = _selectedTimeRangeIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTimeRangeIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE3F2FD) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? mainBlue : textGrey,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
  
  Widget _buildDataGridItem(String label, String value, {Color? color, bool isInfo = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(label, style: TextStyle(fontSize: 12, color: textGrey)),
            if (isInfo) ...[
              const SizedBox(width: 2),
              Icon(Icons.info_outline, size: 10, color: textGrey),
            ]
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value, 
          style: TextStyle(
            fontSize: 14, 
            color: color ?? textBlack, 
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto'
          )
        ),
      ],
    );
  }

  Widget _buildRiskResistanceCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('抗跌能力', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(flex: 2, child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6),
                color: const Color(0xFFF5F7FA),
                child: const Center(child: Text('时间', style: TextStyle(fontSize: 12, color: Colors.black54))),
              )),
              const SizedBox(width: 1),
              Expanded(flex: 5, child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6),
                color: const Color(0xFFF5F7FA),
                child: const Center(child: Text('最大回撤比例', style: TextStyle(fontSize: 12, color: Colors.black54))),
              )),
            ],
          ),
          const SizedBox(height: 8),
          _buildRiskRow('近1个月', '0.10%', 0.1),
          _buildRiskRow('近3个月', '0.16%', 0.16),
          _buildRiskRow('近6个月', '0.16%', 0.16),
          _buildRiskRow('近1年', '0.36%', 0.36),
          
          const SizedBox(height: 24),
          Row(
            children: [
              const Text('年化收益率', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
              const Spacer(),
              Text('涨跌幅', style: TextStyle(fontSize: 12, color: textGrey)),
              const SizedBox(width: 16),
              Text('特定收益率', style: TextStyle(fontSize: 12, color: textGrey)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('时间区间', style: TextStyle(fontSize: 12, color: textGrey)),
              Text('区间年化收益率', style: TextStyle(fontSize: 12, color: textGrey)),
            ],
          ),
          const SizedBox(height: 12),
          _buildAnnualRow('成立以来年化收益率', '(2020/10/27-2025/12/29)', '2.77%'),
          _buildAnnualRow('2024年度收益率', '(2023/12/31-2024/12/31)', '3.00%'),
          _buildAnnualRow('2023年度收益率', '(2022/12/31-2023/12/31)', '3.15%'),
          _buildAnnualRow('2022年度收益率', '(2021/12/31-2022/12/31)', '2.00%'),
          _buildAnnualRow('2021年度收益率', '(2020/12/31-2021/12/31)', '3.51%'),
          
          const SizedBox(height: 16),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('展开查看更多', style: TextStyle(fontSize: 12, color: mainBlue)),
                Icon(Icons.keyboard_arrow_down, size: 16, color: mainBlue),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '理财产品过往业绩不代表其未来表现，等于理财产品实际收益，投资需谨慎。\n龙鑫固收类最低持有120天（代销建信理财）理财产品成立于2020/10/27，数据截止至2025/12/31，过往业绩相关数据已经托管人核对。 数据来源：建信理财',
            style: TextStyle(fontSize: 11, color: textGrey, height: 1.5),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRiskRow(String label, String val, double percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(flex: 2, child: Center(child: Text(label, style: TextStyle(fontSize: 12, color: textGrey)))),
          Expanded(flex: 5, child: Row(
            children: [
              SizedBox(
                width: 50,
                child: Text(val, style: TextStyle(fontSize: 12, color: textGrey)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(2)),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: percentage, // 使用传入的比例
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFA0CFFF),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
  
  Widget _buildAnnualRow(String label, String sub, String val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 13, color: Colors.black87)),
              const SizedBox(height: 2),
              Text(sub, style: TextStyle(fontSize: 11, color: textGrey)),
            ],
          ),
          Text(val, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: redColor, fontFamily: 'Roboto')),
        ],
      ),
    );
  }

  Widget _buildRedemptionRulesCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('赎回规则', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _buildRuleRow('赎回时间', '产品工作日9: 00-17: 00'),
          _buildRuleRow('赎回金额', '1份起赎'),
          _buildRuleRow('赎回费率', '无'),
          _buildRuleRow('赎回确认', '赎回申请T+2确认，并完成赎回资金到账。赎回金额按投资者实际赎回份额和赎回申请日（T日）产品份额净值计算'),
          const SizedBox(height: 12),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('查看全部规则', style: TextStyle(fontSize: 12, color: mainBlue)),
                Icon(Icons.keyboard_arrow_right, size: 16, color: mainBlue),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRuleRow(String label, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 70, child: Text(label, style: TextStyle(fontSize: 13, color: textGrey))),
          Expanded(child: Text(content, style: const TextStyle(fontSize: 13, height: 1.5, color: Colors.black87))),
        ],
      ),
    );
  }
  
  Widget _buildProductArchivesCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('产品档案', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Row(
            children: [
              Text('协议、说明书、公告、风险揭示', style: TextStyle(fontSize: 12, color: textGrey)),
              Icon(Icons.keyboard_arrow_right, size: 16, color: textGrey),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildBottomActionSheet() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: const Color(0xFFFFF8E1), // 浅黄色背景提示
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '01月05日 17:00前赎回，预计01月07日到账',
                      style: TextStyle(fontSize: 12, color: Color(0xFFF57F17)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // 客服头像
                  Container(
                    width: 24, height: 24,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue, // 占位
                    ),
                    child: const Icon(Icons.support_agent, size: 16, color: Colors.white),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('可设置预约赎回，指定时间自动赎回  ', style: TextStyle(fontSize: 13, color: Colors.black54)),
                      Text('去看看 >', style: TextStyle(fontSize: 13, color: mainBlue)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: const [
                            Icon(Icons.favorite_border, size: 24, color: Colors.black54),
                            SizedBox(height: 2),
                            Text('关注', style: TextStyle(fontSize: 10, color: Colors.black54)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('赎回', style: TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold)),
                              Text('非交易时间', style: TextStyle(fontSize: 10, color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: mainBlue,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: const Center(
                            child: Text('加购', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final Color lineColor;
  final List<double> dataPoints;
  final double minY;
  final double maxY;
  final List<String> xLabels;
  final List<String> yLabels;

  ChartPainter({
    required this.lineColor,
    required this.dataPoints,
    required this.minY,
    required this.maxY,
    required this.xLabels,
    required this.yLabels,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final Paint gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    double xStep = size.width / (dataPoints.length - 1);
    double yRange = maxY - minY;
    
    // Draw Y-axis grid and labels
    int gridCount = yLabels.length;
    for (int i = 0; i < gridCount; i++) {
      double y = size.height - (i * (size.height / (gridCount - 1)));
      
      // Grid line
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
      
      // Label
      textPainter.text = TextSpan(
        text: yLabels[i],
        style: const TextStyle(color: Colors.grey, fontSize: 10),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, y - textPainter.height - 2));
    }

    // Draw X-axis labels (only start and end for now based on screenshot)
    if (xLabels.isNotEmpty) {
       textPainter.text = TextSpan(
        text: xLabels[0],
        style: const TextStyle(color: Colors.grey, fontSize: 10),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, size.height + 4));

      if (xLabels.length > 1) {
        textPainter.text = TextSpan(
          text: xLabels[1],
          style: const TextStyle(color: Colors.grey, fontSize: 10),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(size.width - textPainter.width, size.height + 4));
      }
    }

    // Draw Line Path
    final Path path = Path();
    for (int i = 0; i < dataPoints.length; i++) {
      double val = dataPoints[i];
      double x = i * xStep;
      double normalizedY = (val - minY) / yRange;
      double y = size.height - (normalizedY * size.height);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    
    canvas.drawPath(path, linePaint);
    
    // Fill Gradient
    final Paint fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          lineColor.withOpacity(0.15),
          lineColor.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
      
    final Path fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
      
    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant ChartPainter oldDelegate) => true; // Always repaint for simplicity when testing
}
