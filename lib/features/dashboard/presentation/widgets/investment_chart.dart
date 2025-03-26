import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';

class InvestmentChart extends StatelessWidget {
  const InvestmentChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          _buildLegendItem('Your Investments', Colors.blue, state?.userInvestmentPercentage ?? '-0.00%'),
                          _buildLegendItem('Nifty Midcap 150', Colors.orange, state?.niftyPercentage ?? '-0.00%'),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.white24, width: 1)
                        ),
                        child: Text(
                          'NAV',
                          style: GoogleFonts.poppins(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Stack(
                  children: [
                    if (state.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      LineChart(
                        LineChartData(
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval: 20,
                            verticalInterval: 1,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: Colors.transparent,
                                strokeWidth: 1,
                              );
                            },
                            getDrawingVerticalLine: (value) {
                              if (value.toInt() == value && value >= 0 && value <= 3) {
                                return FlLine(
                                  color: Colors.grey[800]!,
                                  strokeWidth: 1,
                                );
                              }
                              return FlLine(
                                color: Colors.transparent,
                                strokeWidth: 0,
                              );
                            },
                          ),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 1,
                                getTitlesWidget: (value, meta) {
                                  if (value.toInt() != value) return const Text('');
                                  const labels = ['2022', '2023', '2024', '2025'];
                                  final index = value.toInt();
                                  if (index >= 0 && index < labels.length) {
                                    return GestureDetector(
                                      onTap: () {
                                        context.read<DashboardBloc>().add(SelectYear(labels[index]));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 8,
                                            width: 1,
                                            color: Colors.grey[800]!.withOpacity(0.3),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            labels[index],
                                            style: GoogleFonts.poppins(
                                              color: labels[index] == state?.selectedYear 
                                                ? Colors.blue 
                                                : Colors.grey[600],
                                              fontSize: 12,
                                              fontWeight: labels[index] == state?.selectedYear 
                                                ? FontWeight.bold 
                                                : FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return const Text('');
                                },
                                reservedSize: 40,
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            _createLineData(Colors.blue, state?.userInvestmentSpots ?? []),
                            _createLineData(Colors.orange, state?.niftySpots ?? []),
                          ],
                          lineTouchData: LineTouchData(
                            enabled: true,
                            touchTooltipData: LineTouchTooltipData(
                              fitInsideHorizontally: true,
                              fitInsideVertically: true,
                              showOnTopOfTheChartBoxArea: true,
                              rotateAngle: 0,
                              tooltipBorder: BorderSide(color: Colors.white.withOpacity(0.1)),
                              tooltipRoundedRadius: 8,
                              tooltipBgColor: const Color(0xFF1A1A1A),
                              tooltipPadding: const EdgeInsets.all(12),
                              tooltipMargin: 0,
                              getTooltipItems: (touchedSpots) {
                                return touchedSpots.map((spot) {
                                  final isFirstSpot = touchedSpots.indexOf(spot) == 0;
                                  if (isFirstSpot) {
                                    // First spot shows date and value
                                    return LineTooltipItem(
                                      '09-01-2022\n',
                                      GoogleFonts.poppins(
                                        color: Colors.grey[400],
                                        fontSize: 12,
                                        height: 1.5,
                                      ),
                                      children: [

                                        TextSpan(
                                          text: '- Your Investment: ₹949.31\n',
                                          style: GoogleFonts.poppins(
                                            color: Colors.blue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            height: 1.5,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '- Nifty Midcap: ₹956.72',
                                          style: GoogleFonts.poppins(
                                            color: Colors.orange,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            height: 1.5,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  // Return null for second spot to avoid duplicate tooltip
                                  return null;
                                }).toList();
                              },
                            ),
                            getTouchedSpotIndicator: (barData, spotIndexes) {
                              return spotIndexes.map((spotIndex) {
                                return TouchedSpotIndicatorData(
                                  FlLine(
                                    color: Colors.grey[800]!,
                                    strokeWidth: 1,
                                    dashArray: [5, 5],
                                  ),
                                  FlDotData(
                                    getDotPainter: (spot, percent, barData, index) {
                                      return FlDotCirclePainter(
                                        radius: 6,
                                        color: barData.color ?? Colors.blue,
                                        strokeWidth: 2,
                                        strokeColor: Colors.white,
                                      );
                                    },
                                  ),
                                );
                              }).toList();
                            },
                            touchCallback: (event, response) {},
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  LineChartBarData _createLineData(Color color, List<FlSpot> spots) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 2.5,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        color: color.withOpacity(0.05),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, String percentage) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 2,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8                                                                                                                 ),
        Text(
          percentage,
          style: GoogleFonts.poppins(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
} 