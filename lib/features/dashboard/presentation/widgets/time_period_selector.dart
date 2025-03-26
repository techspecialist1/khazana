import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';

class TimePeriodSelector extends StatelessWidget {
  const TimePeriodSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white24,width: 1)

          ),
          child: Row(
            children: [
              _buildTimeFrameButton(
                context,
                '1M',
                TimeFrame.oneMonth,
                state?.selectedTimeFrame ?? TimeFrame.oneYear,
              ),
              _buildTimeFrameButton(
                context,
                '3M',
                TimeFrame.threeMonths,
                state?.selectedTimeFrame ?? TimeFrame.oneYear,
              ),
              _buildTimeFrameButton(
                context,
                '6M',
                TimeFrame.sixMonths,
                state?.selectedTimeFrame ?? TimeFrame.oneYear,
              ),
              _buildTimeFrameButton(
                context,
                '1Y',
                TimeFrame.oneYear,
                state?.selectedTimeFrame ?? TimeFrame.oneYear,
              ),
              _buildTimeFrameButton(
                context,
                '3Y',
                TimeFrame.threeYear,
                state?.selectedTimeFrame ?? TimeFrame.threeYear,
              ),
              _buildTimeFrameButton(
                context,
                'Max',
                TimeFrame.max,
                state?.selectedTimeFrame ?? TimeFrame.max,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimeFrameButton(
    BuildContext context,
    String label,
    TimeFrame timeFrame,
    TimeFrame selectedTimeFrame,
  ) {
    final isSelected = timeFrame == selectedTimeFrame;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<DashboardBloc>().add(SelectTimeFrame(timeFrame));
        },
        child: Container(
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                color: isSelected ? Colors.white : Colors.grey[400],
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
} 