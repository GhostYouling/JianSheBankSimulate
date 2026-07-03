import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final Color mainBlue = const Color(0xFF2F7DEB);
  final Color textGrey = const Color(0xFF9AA2AD);
  final Color bgGrey = const Color(0xFFF4F6F9);
  final Color textBlack = const Color(0xFF1F2329);
  final Color redColor = const Color(0xFFFF3347);
  String get _marketValue => '370,585.54';
  String get _totalProfit => '+17,585.54';
  String get _holdingShares => '319626.5188';

  int _selectedTabIndex = 0;
  int _selectedTimeRangeIndex = 3;
  bool _isExpanded = false;

  static const List<double> _netValuePoints = [
    1.0868, 1.0874, 1.0881, 1.0888, 1.0895, 1.0901, 1.0908, 1.0916,
    1.0924, 1.0930, 1.0941, 1.0952, 1.0960, 1.0972, 1.0983, 1.0990,
    1.1004, 1.1011, 1.1023, 1.1031, 1.1044, 1.1050, 1.1061, 1.1074,
    1.1082, 1.1095, 1.1106, 1.1119, 1.1130, 1.1141, 1.1156, 1.1163,
    1.1178, 1.1192, 1.1204, 1.1217, 1.1225, 1.1234, 1.1248, 1.1260,
    1.1275, 1.1281, 1.1300, 1.1292, 1.1306, 1.1313, 1.1325, 1.1330,
    1.1341, 1.1350, 1.1362, 1.1370, 1.1384, 1.1391, 1.1408, 1.1415,
    1.1422, 1.1430, 1.1446, 1.1458, 1.1469, 1.1484, 1.1501, 1.1514,
    1.1532, 1.1547, 1.1541, 1.1556, 1.1572, 1.1586,
  ];

  static const List<double> _annualizedPoints = [
    3.05, 3.07, 3.04, 3.05, 3.03, 3.03, 3.02, 3.00, 3.03, 2.96,
    2.92, 2.91, 2.92, 2.90, 2.93, 2.89, 2.94, 2.92, 2.96, 2.99,
    3.03, 3.04, 3.01, 3.00, 2.96, 2.99, 2.94, 2.88, 2.84, 2.87,
    2.91, 2.90, 2.89, 2.90, 2.91, 2.89, 2.90, 2.89, 2.91, 2.90,
    2.86, 2.87, 2.84, 2.83, 2.81, 2.78, 2.80, 2.79, 2.81, 2.84,
    2.83, 2.79, 2.78, 2.75, 2.76, 2.78, 2.80, 2.79, 2.82, 2.81,
    2.80, 2.77, 2.76, 2.79, 2.81, 2.82, 2.81, 2.83, 2.80, 2.79,
  ];

  static const List<double> _assetPoints = [
    12600000000, 15100000000, 17600000000, 18400000000, 18100000000,
    17400000000, 15600000000, 13900000000, 14000000000, 13800000000,
    14200000000, 14500000000, 2600000000, 14600000000, 15400000000,
    15800000000, 16000000000, 15600000000, 14700000000, 14100000000,
    13800000000, 13700000000, 13900000000, 13500000000, 13600000000,
    13400000000, 13100000000, 12800000000, 12400000000, 11900000000,
    11500000000, 11100000000, 10800000000, 10500000000, 10300000000,
    10100000000, 9950000000, 9820000000, 9700000000, 9586741800.81,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGrey,
      appBar: AppBar(
        toolbarHeight: 44,
        backgroundColor: const Color(0xFFEAF3FF),
        elevation: 0,
        leadingWidth: 44,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF222222), size: 22),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '持仓详情',
          style: TextStyle(
            color: Color(0xFF111111),
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share_outlined, color: Color(0xFF222222), size: 22),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 108),
        child: Column(
          children: [
            _buildMainCard(),
            const SizedBox(height: 10),
            _buildTransactionStatusCard(),
            const SizedBox(height: 10),
            _buildNetValueCard(),
            const SizedBox(height: 10),
            _buildRiskResistanceCard(),
            const SizedBox(height: 10),
            _buildAnnualReturnCard(),
            const SizedBox(height: 10),
            _buildRedemptionRulesCard(),
            const SizedBox(height: 10),
            _buildProductArchivesCard(),
          ],
        ),
      ),
      bottomSheet: _buildBottomActionSheet(),
    );
  }

  Widget _card({required Widget child, EdgeInsetsGeometry? padding}) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: child,
    );
  }

  Widget _buildMainCard() {
    return _card(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '龙鑫固收类最低持有120天（代销建信理财）',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF111111),
              height: 1.18,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'JXLXZD20200924001 代销 | 建信理财有限责任公司',
            style: TextStyle(fontSize: 11, color: textGrey, height: 1.1),
          ),
          const SizedBox(height: 22),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('参考市值(元)', style: TextStyle(fontSize: 13, color: textGrey)),
                const SizedBox(width: 4),
                Icon(Icons.info_outline, size: 14, color: textGrey),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: Text(
              _marketValue,
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                color: Colors.black,
                letterSpacing: 0,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _buildSummaryMetric('累计收益(元)', _totalProfit, redColor, showInfo: true),
              ),
              Expanded(
                child: _buildSummaryMetric('持有份额', _holdingShares, Colors.black, alignRight: true),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: GestureDetector(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Icon(
                _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: const Color(0xFFD6DAE0),
                size: 24,
              ),
            ),
          ),
          if (_isExpanded) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFD),
                borderRadius: BorderRadius.circular(5),
              ),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 3.2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                padding: EdgeInsets.zero,
                children: [
                  _buildDataGridItem('最新净值', '1.086824'),
                  _buildDataGridItem('净值日期', '2026/06/30'),
                  _buildDataGridItem('成立以来年化收益率', '2.80%', color: redColor),
                  _buildDataGridItem('可用份额', _holdingShares),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
          const Divider(height: 1, color: Color(0xFFEFF1F5)),
          SizedBox(
            height: 43,
            child: Row(
              children: [
                Expanded(child: _buildMainAction(Icons.fact_check_outlined, '持仓明细')),
                Container(width: 1, height: 18, color: const Color(0xFFEFF1F5)),
                Expanded(child: _buildMainAction(Icons.receipt_long_outlined, '交易记录')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryMetric(
    String label,
    String value,
    Color color, {
    bool showInfo = false,
    bool alignRight = false,
  }) {
    return Column(
      crossAxisAlignment: alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: alignRight ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 13, color: textGrey)),
            if (showInfo) ...[
              const SizedBox(width: 4),
              Icon(Icons.info_outline, size: 14, color: textGrey),
            ],
          ],
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildMainAction(IconData icon, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 14, color: const Color(0xFF5B6472)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF2B313B))),
      ],
    );
  }

  Widget _buildTransactionStatusCard() {
    return _card(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusStep('下一个交易日', '卖出'),
              const SizedBox(width: 36),
              _buildStatusStep('07/08', '资金兑付到账'),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(top: 14),
                child: Text('可按日申赎', style: TextStyle(fontSize: 12, color: Color(0xFF111111))),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(height: 19, color: const Color(0xFFF3F3F3)),
              Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: 0.33,
                  child: Container(height: 19, color: const Color(0xFFEAF5FF)),
                ),
              ),
              const Text('投资期', style: TextStyle(fontSize: 11, color: Color(0xFF303540))),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F9FC),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Icon(Icons.circle, size: 5, color: mainBlue),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 11.5, color: textGrey, height: 1.45),
                      children: [
                        const TextSpan(text: '本产品设置最短持有期，持有120天的份额可'),
                        TextSpan(text: '按日赎回', style: TextStyle(color: mainBlue)),
                        TextSpan(text: '\n07月06日17:00', style: TextStyle(color: mainBlue)),
                        const TextSpan(text: '前赎回，预计'),
                        TextSpan(text: '07月08日', style: TextStyle(color: mainBlue)),
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

  Widget _buildStatusStep(String labelTop, String labelBottom) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelTop, style: TextStyle(fontSize: 11.5, color: textGrey, height: 1.35)),
        const SizedBox(height: 1),
        Text(
          labelBottom,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF111111),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildNetValueCard() {
    final _ChartSpec spec = _currentChartSpec;
    return _card(
      padding: const EdgeInsets.fromLTRB(12, 12, 10, 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTabItem(0, '单位净值'),
              _buildTabItem(1, '成立以来年化'),
              _buildTabItem(2, '累计净值'),
              _buildTabItem(3, '资产'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(spec.date, style: const TextStyle(fontSize: 12, color: Color(0xFF3D4652))),
              Row(
                children: [
                  Text('·', style: TextStyle(fontSize: 20, color: mainBlue, height: 0.8)),
                  const SizedBox(width: 2),
                  Text(spec.legend, style: const TextStyle(fontSize: 11.5, color: Color(0xFF242933))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 205,
            width: double.infinity,
            child: CustomPaint(
              painter: ChartPainter(
                lineColor: mainBlue,
                dataPoints: spec.dataPoints,
                minY: spec.minY,
                maxY: spec.maxY,
                xLabels: spec.xLabels,
                yLabels: spec.yLabels,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildTimeRangeButton(0, '近1月'),
              const SizedBox(width: 6),
              _buildTimeRangeButton(1, '近3月'),
              const SizedBox(width: 6),
              _buildTimeRangeButton(2, '近1年'),
              const SizedBox(width: 6),
              _buildTimeRangeButton(3, '近3年'),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('查看近一个月业绩走势', style: TextStyle(fontSize: 12, color: mainBlue)),
              Icon(Icons.keyboard_arrow_down, size: 17, color: mainBlue),
            ],
          ),
          if (_selectedTabIndex == 1) ...[
            const SizedBox(height: 22),
            _buildAnnualizedHistoryTable(),
          ],
        ],
      ),
    );
  }

  _ChartSpec get _currentChartSpec {
    switch (_selectedTabIndex) {
      case 1:
        return const _ChartSpec(
          date: '2026-01-19',
          legend: '成立以来年化2.80%',
          dataPoints: _annualizedPoints,
          minY: 2.44,
          maxY: 3.37,
          xLabels: ['2024-04-25', '2026-07-01'],
          yLabels: ['3.37%', '3.18%', '3.00%', '2.81%', '2.63%', '2.44%'],
        );
      case 2:
        return const _ChartSpec(
          date: '2026-07-01',
          legend: '累计净值1.158962',
          dataPoints: _netValuePoints,
          minY: 1.0029,
          maxY: 1.2381,
          xLabels: ['2023-07-03', '2026-07-01'],
          yLabels: ['1.238100', '1.191060', '1.144020', '1.096980', '1.049940', '1.002900'],
        );
      case 3:
        return const _ChartSpec(
          date: '2026-07-01',
          legend: '资产净值9586741800.81',
          dataPoints: _assetPoints,
          minY: -18392433477.18,
          maxY: 36784866954.36,
          xLabels: ['2023-07-03', '2026-07-01'],
          yLabels: [
            '36784866954.36',
            '25749406868.05',
            '14713946781.74',
            '3678486695.44',
            '-7356973390.87',
            '-18392433477.18',
          ],
        );
      default:
        return const _ChartSpec(
          date: '2023-09-02',
          legend: '单位净值1.086824',
          dataPoints: _netValuePoints,
          minY: 1.0025,
          maxY: 1.2383,
          xLabels: ['2023-07-02', '2026-06-30'],
          yLabels: ['1.2383', '1.1911', '1.1440', '1.0968', '1.0497', '1.0025'],
        );
    }
  }

  Widget _buildAnnualizedHistoryTable() {
    const rows = [
      ('2026/07/01', '2.79%'),
      ('2026/06/30', '2.80%'),
      ('2026/06/29', '2.80%'),
      ('2026/06/28', '2.79%'),
    ];

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      color: const Color(0xFFFCFCFD),
      child: Column(
        children: [
          Row(
            children: const [
              Text('日期', style: TextStyle(fontSize: 14, color: Color(0xFF9A9A9A))),
              Spacer(),
              Text('成立以来年化', style: TextStyle(fontSize: 14, color: Color(0xFF9A9A9A))),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFEDEDED)),
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Row(
                children: [
                  Text(row.$1, style: const TextStyle(fontSize: 18, color: Color(0xFF1E1E1E))),
                  const Spacer(),
                  Text(row.$2, style: const TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String text) {
    final bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: isSelected ? mainBlue : const Color(0xFF6E7480),
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 22,
            height: 3,
            decoration: BoxDecoration(
              color: isSelected ? mainBlue : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeRangeButton(int index, String text) {
    final bool isSelected = _selectedTimeRangeIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTimeRangeIndex = index),
        child: Container(
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFEAF3FF) : const Color(0xFFF7F8FA),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? mainBlue : const Color(0xFF858C98),
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
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
            Text(label, style: TextStyle(fontSize: 11.5, color: textGrey)),
            if (isInfo) ...[
              const SizedBox(width: 2),
              Icon(Icons.info_outline, size: 10, color: textGrey),
            ],
          ],
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            color: color ?? textBlack,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildRiskResistanceCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('抗跌能力', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildRiskHeader('时间'),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 5,
                child: _buildRiskHeader('最大回撤比例'),
              ),
            ],
          ),
          const SizedBox(height: 7),
          _buildRiskRow('近1个月', '0.23%', 0.17),
          _buildRiskRow('近3个月', '0.23%', 0.18),
          _buildRiskRow('近6个月', '0.23%', 0.17),
          _buildRiskRow('近1年', '0.23%', 0.19),
          const SizedBox(height: 2),
          Row(
            children: [
              const Expanded(flex: 2, child: SizedBox()),
              Expanded(
                flex: 5,
                child: Row(
                  children: [
                    const SizedBox(width: 56),
                    Expanded(
                      child: Center(
                        child: Text('0.00%', style: TextStyle(fontSize: 12, color: textGrey)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRiskHeader(String text) {
    return Container(
      height: 30,
      alignment: Alignment.center,
      color: const Color(0xFFEFF7FF),
      child: Text(text, style: const TextStyle(fontSize: 12, color: Color(0xFF1F2329))),
    );
  }

  Widget _buildRiskRow(String label, String val, double factor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Center(child: Text(label, style: TextStyle(fontSize: 12, color: textGrey))),
          ),
          Expanded(
            flex: 5,
            child: Row(
              children: [
                SizedBox(width: 48, child: Text(val, style: TextStyle(fontSize: 12, color: textGrey))),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 16,
                    child: CustomPaint(
                      painter: DrawdownBarPainter(
                        barColor: const Color(0xFF9BC9F5),
                        trackColor: const Color(0xFFF1F1F1),
                        axisColor: const Color(0xFFFF8D8D),
                        factor: factor,
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

  Widget _buildAnnualReturnCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('年化收益率', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: mainBlue)),
              const Spacer(),
              Text('涨跌幅', style: TextStyle(fontSize: 14, color: textGrey)),
              const SizedBox(width: 32),
              Text('特定收益率', style: TextStyle(fontSize: 14, color: textGrey)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('时间区间', style: TextStyle(fontSize: 12, color: textGrey)),
              Text('区间年化收益率', style: TextStyle(fontSize: 12, color: textGrey)),
            ],
          ),
          const SizedBox(height: 12),
          _buildAnnualRow('成立以来年化收益率', '(2020/10/27-2026/06/30)', '2.80%'),
          _buildAnnualRow('2025年度收益率', '(2024/12/31-2025/12/31)', '1.51%'),
          _buildAnnualRow('2024年度收益率', '(2023/12/31-2024/12/31)', '3.00%'),
          _buildAnnualRow('2023年度收益率', '(2022/12/31-2023/12/31)', '3.15%'),
          _buildAnnualRow('2022年度收益率', '(2021/12/31-2022/12/31)', '2.00%'),
          const SizedBox(height: 6),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('展开查看更多', style: TextStyle(fontSize: 12, color: mainBlue)),
                Icon(Icons.keyboard_arrow_down, size: 17, color: mainBlue),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '理财产品过往业绩不代表其未来表现，不等于理财产品实际收益，投资需谨慎。\n龙鑫固收类最低持有120天（代销建信理财）理财产品成立于2020/10/27，数据截止至2026/06/30，过往业绩相关数据已经托管人核对。 数据来源：建信理财',
            style: TextStyle(fontSize: 10.5, color: const Color(0xFF7E8794), height: 1.45),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnualRow(String label, String sub, String val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF2A3039))),
              const SizedBox(height: 2),
              Text(sub, style: TextStyle(fontSize: 11, color: textGrey)),
            ],
          ),
          Text(
            val,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: redColor),
          ),
        ],
      ),
    );
  }

  Widget _buildRedemptionRulesCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('赎回规则', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          const SizedBox(height: 20),
          _buildRuleRow('赎回时间', '产品工作日9：00-17：00'),
          _buildRuleRow('赎回金额', '1份起赎'),
          _buildRuleRow('赎回费率', '无'),
          _buildRuleRow('赎回确认', '赎回申请T+2确认，并完成赎回资金到账。赎回金额按投资者实际赎回份额和赎回申请日（T日）产品份额净值计算'),
          const SizedBox(height: 12),
          Center(
            child: Text('查看全部规则', style: TextStyle(fontSize: 12, color: mainBlue)),
          ),
        ],
      ),
    );
  }

  Widget _buildRuleRow(String label, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 88, child: Text(label, style: TextStyle(fontSize: 13, color: textGrey))),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(fontSize: 13, height: 1.45, color: Color(0xFF202631)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductArchivesCard() {
    return _card(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Row(
        children: [
          const Text('产品档案', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          const Spacer(),
          Flexible(
            child: Text(
              '协议、说明书、公告、风险揭示',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 12, color: textGrey),
            ),
          ),
          Icon(Icons.keyboard_arrow_right, size: 16, color: textGrey),
        ],
      ),
    );
  }

  Widget _buildBottomActionSheet() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              color: const Color(0xFFF9FBFF),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      '@当前持有的份额已满足最短持有期  查看详情',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, color: Color(0xFF7D8795)),
                    ),
                  ),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF2084F3),
                    ),
                    child: const Icon(Icons.support_agent, size: 17, color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Flexible(
                        child: Text(
                          '可设置预约赎回，指定时间自动赎回  ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 13, color: Color(0xFF4D5663)),
                        ),
                      ),
                      Text('去看看>', style: TextStyle(fontSize: 13, color: mainBlue, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const SizedBox(
                        width: 44,
                        child: Column(
                          children: [
                            Icon(Icons.add_circle_outline, size: 23, color: Color(0xFF333333)),
                            SizedBox(height: 2),
                            Text('关注', style: TextStyle(fontSize: 10, color: Color(0xFF333333))),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(23),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('赎回', style: TextStyle(fontSize: 15, color: Color(0xFFB2B2B2), fontWeight: FontWeight.w700)),
                              Text('非交易时间', style: TextStyle(fontSize: 10, color: Color(0xFFB2B2B2))),
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
                            borderRadius: BorderRadius.circular(23),
                          ),
                          child: const Center(
                            child: Text('加购', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w800)),
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

class _ChartSpec {
  final String date;
  final String legend;
  final List<double> dataPoints;
  final double minY;
  final double maxY;
  final List<String> xLabels;
  final List<String> yLabels;

  const _ChartSpec({
    required this.date,
    required this.legend,
    required this.dataPoints,
    required this.minY,
    required this.maxY,
    required this.xLabels,
    required this.yLabels,
  });
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
    final TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    double maxLabelWidth = 0;
    for (final label in yLabels) {
      textPainter.text = TextSpan(
        text: label,
        style: const TextStyle(color: Color(0xFFADB4BE), fontSize: 10.5),
      );
      textPainter.layout();
      if (textPainter.width > maxLabelWidth) {
        maxLabelWidth = textPainter.width;
      }
    }

    final double leftPadding = maxLabelWidth + 14;
    const double topPadding = 4;
    const double rightPadding = 4;
    const double bottomPadding = 28;
    final Rect plot = Rect.fromLTWH(
      leftPadding,
      topPadding,
      size.width - leftPadding - rightPadding,
      size.height - topPadding - bottomPadding,
    );

    final Paint gridPaint = Paint()
      ..color = const Color(0xFFEFF2F6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 0; i < yLabels.length; i++) {
      final double y = plot.top + (plot.height / (yLabels.length - 1)) * i;
      canvas.drawLine(Offset(plot.left, y), Offset(plot.right, y), gridPaint);
      textPainter.text = TextSpan(
        text: yLabels[i],
        style: const TextStyle(color: Color(0xFFADB4BE), fontSize: 10.5),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, y - textPainter.height / 2));
    }

    final double xStep = plot.width / (dataPoints.length - 1);
    final double yRange = maxY - minY;
    final Path linePath = Path();

    for (int i = 0; i < dataPoints.length; i++) {
      final double x = plot.left + i * xStep;
      final double normalizedY = (dataPoints[i] - minY) / yRange;
      final double y = plot.bottom - (normalizedY * plot.height);
      if (i == 0) {
        linePath.moveTo(x, y);
      } else {
        linePath.lineTo(x, y);
      }
    }

    final Path fillPath = Path.from(linePath)
      ..lineTo(plot.right, plot.bottom)
      ..lineTo(plot.left, plot.bottom)
      ..close();

    final Paint fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          lineColor.withOpacity(0.20),
          lineColor.withOpacity(0.06),
          lineColor.withOpacity(0.00),
        ],
      ).createShader(plot)
      ..style = PaintingStyle.fill;
    canvas.drawPath(fillPath, fillPaint);

    final Paint linePaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.1
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(linePath, linePaint);

    if (xLabels.isNotEmpty) {
      textPainter.text = TextSpan(
        text: xLabels.first,
        style: const TextStyle(color: Color(0xFFADB4BE), fontSize: 11),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(plot.left, plot.bottom + 8));

      if (xLabels.length > 1) {
        textPainter.text = TextSpan(
          text: xLabels.last,
          style: const TextStyle(color: Color(0xFFADB4BE), fontSize: 11),
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(plot.right - textPainter.width, plot.bottom + 8));
      }
    }
  }

  @override
  bool shouldRepaint(covariant ChartPainter oldDelegate) {
    return oldDelegate.dataPoints != dataPoints ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.minY != minY ||
        oldDelegate.maxY != maxY;
  }
}

class DrawdownBarPainter extends CustomPainter {
  final Color barColor;
  final Color trackColor;
  final Color axisColor;
  final double factor;

  DrawdownBarPainter({
    required this.barColor,
    required this.trackColor,
    required this.axisColor,
    required this.factor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width * 0.5;
    final RRect track = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 4, size.width, 8),
      const Radius.circular(2),
    );
    final Paint trackPaint = Paint()..color = trackColor;
    canvas.drawRRect(track, trackPaint);

    final double barWidth = size.width * factor;
    final RRect bar = RRect.fromRectAndRadius(
      Rect.fromLTWH(centerX - barWidth, 4, barWidth, 8),
      const Radius.circular(2),
    );
    final Paint barPaint = Paint()..color = barColor;
    canvas.drawRRect(bar, barPaint);

    final Paint axisPaint = Paint()
      ..color = axisColor
      ..strokeWidth = 1;
    canvas.drawLine(Offset(centerX, 0), Offset(centerX, size.height), axisPaint);
  }

  @override
  bool shouldRepaint(covariant DrawdownBarPainter oldDelegate) {
    return oldDelegate.factor != factor ||
        oldDelegate.barColor != barColor ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.axisColor != axisColor;
  }
}
