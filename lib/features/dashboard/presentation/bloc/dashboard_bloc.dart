import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState.initial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
    on<SelectYear>(_onSelectYear);
    on<SelectTimeFrame>(_onSelectTimeFrame);
    on<UpdateInvestmentAmount>(_onUpdateInvestmentAmount);
    on<ToggleInvestmentType>(_onToggleInvestmentType);
  }

  void _onLoadDashboardData(
    LoadDashboardData event,
    Emitter<DashboardState> emit,
  ) {
    // Initial data is already loaded in DashboardState.initial()
  }

  void _onSelectYear(
    SelectYear event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(isLoading: true));


    final Map<String, Map<String, dynamic>> yearData = {
      '2022': {
        'userInvestmentSpots': const [
          FlSpot(0, 15),
          FlSpot(0.5, 18),
          FlSpot(1, 16),
          FlSpot(1.5, 20),
          FlSpot(2, 22),
          FlSpot(2.5, 25),
          FlSpot(3, 28),
        ],
        'niftySpots': const [
          FlSpot(0, 20),
          FlSpot(0.5, 22),
          FlSpot(1, 21),
          FlSpot(1.5, 25),
          FlSpot(2, 27),
          FlSpot(2.5, 30),
          FlSpot(3, 32),
        ],
        'userInvestmentPercentage': '-15.25%',
        'niftyPercentage': '-10.50%',
      },
      '2023': {
        'userInvestmentSpots': const [
          FlSpot(0, 25),
          FlSpot(0.5, 28),
          FlSpot(1, 26),
          FlSpot(1.5, 30),
          FlSpot(2, 32),
          FlSpot(2.5, 35),
          FlSpot(3, 38),
        ],
        'niftySpots': const [
          FlSpot(0, 30),
          FlSpot(0.5, 32),
          FlSpot(1, 31),
          FlSpot(1.5, 35),
          FlSpot(2, 37),
          FlSpot(2.5, 40),
          FlSpot(3, 42),
        ],
        'userInvestmentPercentage': '-17.50%',
        'niftyPercentage': '-11.75%',
      },
      '2024': {
        'userInvestmentSpots': const [
          FlSpot(0, 35),
          FlSpot(0.5, 38),
          FlSpot(1, 36),
          FlSpot(1.5, 40),
          FlSpot(2, 42),
          FlSpot(2.5, 45),
          FlSpot(3, 48),
        ],
        'niftySpots': const [
          FlSpot(0, 40),
          FlSpot(0.5, 42),
          FlSpot(1, 41),
          FlSpot(1.5, 45),
          FlSpot(2, 47),
          FlSpot(2.5, 50),
          FlSpot(3, 52),
        ],
        'userInvestmentPercentage': '-18.90%',
        'niftyPercentage': '-12.25%',
      },
      '2025': {
        'userInvestmentSpots': const [
          FlSpot(0, 20),
          FlSpot(0.5, 25),
          FlSpot(1, 22),
          FlSpot(1.5, 28),
          FlSpot(2, 32),
          FlSpot(2.5, 35),
          FlSpot(3, 40),
        ],
        'niftySpots': const [
          FlSpot(0, 25),
          FlSpot(0.5, 30),
          FlSpot(1, 28),
          FlSpot(1.5, 35),
          FlSpot(2, 38),
          FlSpot(2.5, 42),
          FlSpot(3, 45),
        ],
        'userInvestmentPercentage': '-19.75%',
        'niftyPercentage': '-12.97%',
      },
    };

    final selectedYearData = yearData[event.year];
    if (selectedYearData != null) {
      emit(state.copyWith(
        selectedYear: event.year,
        userInvestmentSpots: selectedYearData['userInvestmentSpots'] as List<FlSpot>,
        niftySpots: selectedYearData['niftySpots'] as List<FlSpot>,
        userInvestmentPercentage: selectedYearData['userInvestmentPercentage'] as String,
        niftyPercentage: selectedYearData['niftyPercentage'] as String,
        isLoading: false,
      ));
    }
  }

  void _onSelectTimeFrame(
    SelectTimeFrame event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(isLoading: true));


    final Map<TimeFrame, Map<String, dynamic>> timeFrameData = {
      TimeFrame.oneMonth: {
        'userInvestmentSpots': const [
          FlSpot(0, 30),
          FlSpot(0.5, 32),
          FlSpot(1, 31),
          FlSpot(1.5, 35),
          FlSpot(2, 33),
          FlSpot(2.5, 36),
          FlSpot(3, 34),
        ],
        'niftySpots': const [
          FlSpot(0, 35),
          FlSpot(0.5, 37),
          FlSpot(1, 36),
          FlSpot(1.5, 40),
          FlSpot(2, 38),
          FlSpot(2.5, 41),
          FlSpot(3, 39),
        ],
        'userInvestmentPercentage': '-5.25%',
        'niftyPercentage': '-3.50%',
      },
      TimeFrame.threeMonths: {
        'userInvestmentSpots': const [
          FlSpot(0, 25),
          FlSpot(0.5, 28),
          FlSpot(1, 26),
          FlSpot(1.5, 30),
          FlSpot(2, 28),
          FlSpot(2.5, 32),
          FlSpot(3, 30),
        ],
        'niftySpots': const [
          FlSpot(0, 30),
          FlSpot(0.5, 33),
          FlSpot(1, 31),
          FlSpot(1.5, 35),
          FlSpot(2, 33),
          FlSpot(2.5, 37),
          FlSpot(3, 35),
        ],
        'userInvestmentPercentage': '-10.75%',
        'niftyPercentage': '-8.25%',
      },
      TimeFrame.sixMonths: {
        'userInvestmentSpots': const [
          FlSpot(0, 20),
          FlSpot(0.5, 23),
          FlSpot(1, 21),
          FlSpot(1.5, 25),
          FlSpot(2, 23),
          FlSpot(2.5, 27),
          FlSpot(3, 25),
        ],
        'niftySpots': const [
          FlSpot(0, 25),
          FlSpot(0.5, 28),
          FlSpot(1, 26),
          FlSpot(1.5, 30),
          FlSpot(2, 28),
          FlSpot(2.5, 32),
          FlSpot(3, 30),
        ],
        'userInvestmentPercentage': '-15.50%',
        'niftyPercentage': '-10.75%',
      },
      TimeFrame.oneYear: {
        'userInvestmentSpots': const [
          FlSpot(0, 20),
          FlSpot(0.5, 25),
          FlSpot(1, 22),
          FlSpot(1.5, 28),
          FlSpot(2, 32),
          FlSpot(2.5, 35),
          FlSpot(3, 40),
        ],
        'niftySpots': const [
          FlSpot(0, 25),
          FlSpot(0.5, 30),
          FlSpot(1, 28),
          FlSpot(1.5, 35),
          FlSpot(2, 38),
          FlSpot(2.5, 42),
          FlSpot(3, 45),
        ],
        'userInvestmentPercentage': '-19.75%',
        'niftyPercentage': '-12.97%',
      },
      TimeFrame.threeYear: {
        'userInvestmentSpots': const [
          FlSpot(0, 15),
          FlSpot(0.4, 35),
          FlSpot(0.8, 28),
          FlSpot(1.2, 42),
          FlSpot(1.6, 38),
          FlSpot(2.0, 55),
          FlSpot(2.3, 48),
          FlSpot(2.6, 65),
          FlSpot(2.8, 58),
          FlSpot(3.0, 75),
        ],
        'niftySpots': const [
          FlSpot(0, 20),
          FlSpot(0.4, 38),
          FlSpot(0.8, 32),
          FlSpot(1.2, 45),
          FlSpot(1.6, 42),
          FlSpot(2.0, 58),
          FlSpot(2.3, 52),
          FlSpot(2.6, 68),
          FlSpot(2.8, 62),
          FlSpot(3.0, 80),
        ],
        'userInvestmentPercentage': '275.50%',
        'niftyPercentage': '285.75%',
      },
      TimeFrame.max: {
        'userInvestmentSpots': const [
          FlSpot(0, 10),
          FlSpot(0.3, 35),
          FlSpot(0.6, 28),
          FlSpot(0.9, 48),
          FlSpot(1.2, 42),
          FlSpot(1.5, 65),
          FlSpot(1.8, 58),
          FlSpot(2.1, 85),
          FlSpot(2.4, 78),
          FlSpot(2.7, 110),
          FlSpot(3.0, 130),
        ],
        'niftySpots': const [
          FlSpot(0, 15),
          FlSpot(0.3, 38),
          FlSpot(0.6, 32),
          FlSpot(0.9, 52),
          FlSpot(1.2, 45),
          FlSpot(1.5, 70),
          FlSpot(1.8, 62),
          FlSpot(2.1, 90),
          FlSpot(2.4, 82),
          FlSpot(2.7, 115),
          FlSpot(3.0, 135),
        ],
        'userInvestmentPercentage': '395.50%',
        'niftyPercentage': '405.75%',
      },
    };

    final selectedTimeFrameData = timeFrameData[event.timeFrame];
    if (selectedTimeFrameData != null) {
      emit(state.copyWith(
        selectedTimeFrame: event.timeFrame,
        userInvestmentSpots: selectedTimeFrameData['userInvestmentSpots'] as List<FlSpot>,
        niftySpots: selectedTimeFrameData['niftySpots'] as List<FlSpot>,
        userInvestmentPercentage: selectedTimeFrameData['userInvestmentPercentage'] as String,
        niftyPercentage: selectedTimeFrameData['niftyPercentage'] as String,
        isLoading: false,
      ));
    }
  }

  void _onUpdateInvestmentAmount(
    UpdateInvestmentAmount event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(
      investmentAmount: event.amount,
    ));
  }

  void _onToggleInvestmentType(
    ToggleInvestmentType event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(
      investmentType: event.type,
    ));
  }
} 