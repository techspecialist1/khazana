import 'package:equatable/equatable.dart';
import 'dashboard_state.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class LoadDashboardData extends DashboardEvent {
  const LoadDashboardData();
}

class SelectYear extends DashboardEvent {
  final String year;

  const SelectYear(this.year);

  @override
  List<Object> get props => [year];
}

class SelectTimeFrame extends DashboardEvent {
  final TimeFrame timeFrame;

  const SelectTimeFrame(this.timeFrame);

  @override
  List<Object> get props => [timeFrame];
}

class UpdateInvestmentAmount extends DashboardEvent {
  final double amount;

  const UpdateInvestmentAmount(this.amount);

  @override
  List<Object> get props => [amount];
}

class ToggleInvestmentType extends DashboardEvent {
  final InvestmentType type;

  const ToggleInvestmentType(this.type);

  @override
  List<Object> get props => [type];
} 