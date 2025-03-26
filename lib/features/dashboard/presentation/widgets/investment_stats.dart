import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InvestmentStats extends StatelessWidget {
  const InvestmentStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24,width: 1)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatColumn('Invested', '₹1.5k',''),
          Container(
            width: 1,
            height: 40,
            color: Colors.grey[800],
          ),
          _buildStatColumn('Current Value', '₹1.28k',''),
          Container(
            width: 1,
            height: 40,
            color: Colors.grey[800],
          ),
          _buildStatColumn('Total Gain', '₹-220.16','-14.7' , isNegative: false,isTwoValue: true),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value,String? valueTwo, {bool isNegative = false,bool isTwoValue = false}) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.grey[400],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        isTwoValue?Row(children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              color: isNegative ? Colors.red[400] : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(Icons.keyboard_arrow_down_rounded,color: Colors.red[400],size: 16,),
          Text(
            valueTwo??'',
            style: GoogleFonts.poppins(
              color:Colors.red[400] ,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

        ],):
        Text(
          value,
          style: GoogleFonts.poppins(
            color: isNegative ? Colors.red[400] : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
} 