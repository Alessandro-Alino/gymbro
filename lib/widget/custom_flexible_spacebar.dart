import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gymbro/feature/programs/widget/program_dropdown.dart';

class CustomFlexibleSpaceBar extends StatelessWidget {
  const CustomFlexibleSpaceBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double dynamicWidth() {
          final double offset = constraints.maxHeight - constraints.minHeight;
          final double scrollPercentage =
              1.2 - offset / (300.0 - kToolbarHeight);
          final double width = max(0, constraints.maxWidth * scrollPercentage);
          return width;
        }

        return FlexibleSpaceBar(
          expandedTitleScale: 1.2,
          titlePadding: EdgeInsets.zero,
          title: Row(
            children: [
              Flexible(
                child: SizedBox(
                  width: dynamicWidth(),
                ),
              ),
              ProgramDropdown(),
            ],
          ),
        );
      },
    );
  }
}
