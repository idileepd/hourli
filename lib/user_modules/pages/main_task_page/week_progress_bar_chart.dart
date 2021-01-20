import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hourli/auth_module/controllers/user_controller.dart';
import 'package:hourli/global_module/components/customized/gradient_floating_action_btn.dart';
import 'package:hourli/global_module/controllers/theme_controller.dart';
import 'package:hourli/global_module/utils/hl_colors.dart';
import 'package:hourli/models/user_deatils_model.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class WeekProgressBarGraph extends StatefulWidget {
  final void Function() onTapLogs;

  const WeekProgressBarGraph({Key key, @required this.onTapLogs})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => WeekProgressBarGraphState();
}

class WeekProgressBarGraphState extends State<WeekProgressBarGraph> {
  int touchedIndex;
  final _userController = Get.find<UserController>();
  final _themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Obx(
        () => Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          color: _themeController.themeIndexRx.value == 1
              ? ThemeData.dark().scaffoldBackgroundColor
              : Colors.white,
          elevation: 0.0,
          child: Stack(
            children: <Widget>[
              _buildBarGraph(),
              // _buildWeekScore(),
              // SizedBox(),
            ],
          ),
          // child: _buildBarGraph(),
        ),
      ),
    );
  }

  Padding _buildWeekScore() {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0, right: 0.0),
      child: Column(
        children: <Widget>[
          Text(
            "WEEK | SCORE",
            style: TextStyle(
              // color: Colors.white70,
              fontSize: 1.9 * MediaQuery.of(context).size.height / 100,
              // fontFamily: 'poppins',
            ),
          ),
          Text(
            NumberFormat.compact().format(
                _userController.firestoreUserStream.value.getWeekScore()),
            style: TextStyle(
              // color: Colors.white,
              fontSize: 4 * MediaQuery.of(context).size.height / 100,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildBarGraph() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // Text(
          //   'Week Progress',
          //   style: TextStyle(
          //     color: Get.isDarkMode
          //         ? Colors.white
          //         : ThemeData.dark().scaffoldBackgroundColor,
          //     fontSize: 24,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          // const SizedBox(
          //   height: ,
          // ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: widget.onTapLogs,
                child: Icon(
                  LineAwesomeIcons.bars,
                  color: _themeController.themeIndexRx.value == 1
                      ? Colors.white
                      : ThemeData.dark().scaffoldBackgroundColor,
                ),
              ),
              _buildWeekScore(),
            ],
          ),

          SizedBox(height: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: BarChart(
                _buildBarGraphWidget(),
                // swapAnimationDuration: animDuration,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  BarChartData _buildBarGraphWidget() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              (rod.y - 1).toInt().toString(),
              TextStyle(
                color: HLColors.secondaryColor,
              ),
            );
          },
        ),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: _themeController.themeIndexRx.value == 1
                ? Colors.white
                : ThemeData.dark().scaffoldBackgroundColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'Su';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minY: 1,
      barGroups: _generateBarsData(),
    );
  }

  List<BarChartGroupData> _generateBarsData() {
    UserDetailsModel user = _userController.firestoreUserStream.value;
    return List.generate(
      7,
      (i) {
        switch (i) {
          case 0:
            return _buildBarData(
                x: 0,
                y: user.week['1']?.toDouble() ?? 0,
                isTouched: i == touchedIndex,
                indexOfbar: 0);
          case 1:
            return _buildBarData(
                x: 1,
                y: user.week['2']?.toDouble() ?? 0,
                isTouched: i == touchedIndex,
                indexOfbar: 1);
          case 2:
            return _buildBarData(
                x: 2,
                y: user.week['3']?.toDouble() ?? 0,
                isTouched: i == touchedIndex,
                indexOfbar: 2);
          case 3:
            return _buildBarData(
                x: 3,
                y: user.week['4']?.toDouble() ?? 0,
                isTouched: i == touchedIndex,
                indexOfbar: 3);
          case 4:
            return _buildBarData(
                x: 4,
                y: user.week['5']?.toDouble() ?? 0,
                isTouched: i == touchedIndex,
                indexOfbar: 4);
          case 5:
            return _buildBarData(
                x: 5,
                y: user.week['6']?.toDouble() ?? 0,
                isTouched: i == touchedIndex,
                indexOfbar: 5);
          case 6:
            return _buildBarData(
                x: 6,
                y: user.week['0']?.toDouble() ?? 0,
                isTouched: i == touchedIndex,
                indexOfbar: 6);
          default:
            return null;
        }
      },
    );
  }

  BarChartGroupData _buildBarData({
    @required int x,
    @required double y,
    bool isTouched: false,
    Color barColor: Colors.white,
    double width: 8,
    List<int> showTooltips = const [],
    @required int indexOfbar,
  }) {
    bool barIsOfCurrentWeekDay = indexOfbar + 1 == DateTime.now().weekday;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y + 1,
          color: isTouched || barIsOfCurrentWeekDay
              ? HLColors.secondaryColor
              : HLColors.primaryColor,
          width: width,

          // backDrawRodData: BackgroundBarChartRodData(
          //   show: true,
          //   y: 20,
          //   color: HLColors.primaryColor,
          // ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }
}
