import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';

enum TimeFrame { oneMonth, threeMonths, sixMonths, oneYear, threeYear, max }

enum InvestmentType {
  oneTime,
  monthlySip,
}

class DashboardState extends Equatable {
  final String selectedYear;
  final TimeFrame selectedTimeFrame;
  final double investmentAmount;
  final double savingsReturn;
  final double categoryReturn;
  final double directPlanReturn;
  final String userInvestmentPercentage;
  final InvestmentType investmentType;
  final List<FlSpot> userInvestmentSpots;
  final List<FlSpot> niftySpots;
  final String niftyPercentage;
  final bool isLoading;

  const DashboardState({
    required this.selectedYear,
    required this.selectedTimeFrame,
    required this.investmentAmount,
    required this.savingsReturn,
    required this.categoryReturn,
    required this.directPlanReturn,
    required this.userInvestmentPercentage,
    required this.investmentType,
    required this.userInvestmentSpots,
    required this.niftySpots,
    required this.niftyPercentage,
    this.isLoading = false,
  });

  factory DashboardState.initial() => const DashboardState(
        selectedYear: '2024',
        selectedTimeFrame: TimeFrame.oneYear,
        investmentAmount: 100000, // 1L
        savingsReturn: 119000, // 1.19L
        categoryReturn: 363000, // 3.63L
        directPlanReturn: 455000, // 4.55L
        userInvestmentPercentage: '395.3%',
        investmentType: InvestmentType.oneTime,
        userInvestmentSpots: const [
          FlSpot(0, 20),
          FlSpot(0.5, 25),
          FlSpot(1, 22),
          FlSpot(1.5, 28),
          FlSpot(2, 32),
          FlSpot(2.5, 35),
          FlSpot(3, 40),
        ],
        niftySpots: const [
          FlSpot(0, 25),
          FlSpot(0.5, 30),
          FlSpot(1, 28),
          FlSpot(1.5, 35),
          FlSpot(2, 38),
          FlSpot(2.5, 42),
          FlSpot(3, 45),
        ],
        niftyPercentage: '-12.97%',
      );

  DashboardState copyWith({
    String? selectedYear,
    TimeFrame? selectedTimeFrame,
    double? investmentAmount,
    double? savingsReturn,
    double? categoryReturn,
    double? directPlanReturn,
    String? userInvestmentPercentage,
    InvestmentType? investmentType,
    List<FlSpot>? userInvestmentSpots,
    List<FlSpot>? niftySpots,
    String? niftyPercentage,
    bool? isLoading,
  }) {
    return DashboardState(
      selectedYear: selectedYear ?? this.selectedYear,
      selectedTimeFrame: selectedTimeFrame ?? this.selectedTimeFrame,
      investmentAmount: investmentAmount ?? this.investmentAmount,
      savingsReturn: savingsReturn ?? this.savingsReturn,
      categoryReturn: categoryReturn ?? this.categoryReturn,
      directPlanReturn: directPlanReturn ?? this.directPlanReturn,
      userInvestmentPercentage: userInvestmentPercentage ?? this.userInvestmentPercentage,
      investmentType: investmentType ?? this.investmentType,
      userInvestmentSpots: userInvestmentSpots ?? this.userInvestmentSpots,
      niftySpots: niftySpots ?? this.niftySpots,
      niftyPercentage: niftyPercentage ?? this.niftyPercentage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        selectedYear,
        selectedTimeFrame,
        investmentAmount,
        savingsReturn,
        categoryReturn,
        directPlanReturn,
        userInvestmentPercentage,
        investmentType,
        userInvestmentSpots,
        niftySpots,
        niftyPercentage,
        isLoading,
      ];
} 