import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';

class InvestmentReturns extends StatefulWidget {
  const InvestmentReturns({super.key});

  @override
  State<InvestmentReturns> createState() => _InvestmentReturnsState();
}

class _InvestmentReturnsState extends State<InvestmentReturns> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = context.read<DashboardBloc>().state;
    _controller.text = (state.investmentAmount / 100000).toStringAsFixed(1);
  }

  Widget _buildReturnColumn(String title, double amount, String percentage, double maxAmount) {
    final double barHeight = 200.0;
    final double normalizedHeight = (amount / maxAmount) * barHeight;
    final double greenHeight = title == 'Direct Plan' 
        ? normalizedHeight 
        : title == 'Category Avg.' 
            ? normalizedHeight * 0.4 
            : normalizedHeight * 0.3;

    return Column(
      children: [
        Container(
          height: barHeight + 24,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: normalizedHeight,
                width: 70,
                child: Stack(
                  children: [
                    Container(
                      height: normalizedHeight,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,

                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: Container(
                        height: greenHeight,
                        width: 70,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),

                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: normalizedHeight ,
                child: Text(
                  '₹${(amount / 100000).toStringAsFixed(2)}L',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          width: 115.8,
          height: 2,
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: 70,
          child: Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final currentValue = (state.investmentAmount / 100000).toStringAsFixed(1);
        if (_controller.text != currentValue) {
          final selection = _controller.selection;
          _controller.text = currentValue;
          if (selection.start <= currentValue.length) {
            _controller.selection = selection;
          }
        }
        
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Text(
                        'If you invested',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IntrinsicWidth(
                        child: Focus(
                          onFocusChange: (hasFocus) {
                            if (!hasFocus) {
                              final amount = double.tryParse(_controller.text);
                              if (amount != null) {
                                context.read<DashboardBloc>().add(
                                  UpdateInvestmentAmount(amount * 100000),
                                );
                              }
                            }
                          },
                          child: TextFormField(
                            controller: _controller,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              prefixText: '₹ ',
                              prefixStyle: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              suffixText: 'L',
                              suffixStyle: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.white54),
                              ),
                            ),
                            onChanged: (value) {
                              final amount = double.tryParse(value);
                              if (amount != null) {
                                context.read<DashboardBloc>().add(
                                  UpdateInvestmentAmount(amount * 100000),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.edit_outlined,
                        color: Colors.white.withOpacity(0.5),
                        size: 16,
                      ),

                    ],
                  ),

                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade700,width: 1)
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<DashboardBloc>().add(
                              const ToggleInvestmentType(InvestmentType.oneTime),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: state.investmentType == InvestmentType.oneTime
                                  ? Colors.blue[600]
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '1-Time',
                              style: GoogleFonts.poppins(
                                color: state.investmentType == InvestmentType.oneTime
                                    ? Colors.white
                                    : Colors.grey[400],
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<DashboardBloc>().add(
                              const ToggleInvestmentType(InvestmentType.monthlySip),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: state.investmentType == InvestmentType.monthlySip
                                  ? Colors.blue[600]
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Monthly SIP',
                              style: GoogleFonts.poppins(
                                color: state.investmentType == InvestmentType.monthlySip
                                    ? Colors.white
                                    : Colors.grey[400],
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: Colors.blue[600],
                  inactiveTrackColor: Colors.grey[800],
                  thumbColor: Colors.blue[600],
                  overlayColor: Colors.blue.withOpacity(0.2),
                  trackHeight: 4,
                ),
                child: Slider(
                  value: state.investmentAmount / 100000,
                  min: 1,
                  max: 10.0,
                  onChanged: (value) {
                    context.read<DashboardBloc>().add(
                      UpdateInvestmentAmount(value * 100000),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Text(
                    '₹ 1L',
                    style: GoogleFonts.poppins(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '₹ 10L',
                    style: GoogleFonts.poppins(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "This Fund's past returns",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Profit % (Absolute Return)',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹ ${(state.directPlanReturn / 100000).toStringAsFixed(1)}L',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF4CAF50),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        state.userInvestmentPercentage,
                        style: GoogleFonts.poppins(
                          color:Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildReturnColumn(
                    'Saving A/C',
                    state.savingsReturn,
                    '74.55%',
                    455000,
                  ),
                  _buildReturnColumn(
                    'Category Avg.',
                    state.categoryReturn,
                    '395.3%',
                    455000,
                  ),
                  _buildReturnColumn(
                    'Direct Plan',
                    state.directPlanReturn,
                    '395.3%',
                    455000,
                  ),
                ],
              ),

            ],
          ),
        );
      },
    );
  }
} 