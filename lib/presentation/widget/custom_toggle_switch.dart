import 'package:flutter/material.dart';

class CustomToggleButton extends StatefulWidget {
  final String leftLabel;
  final String rightLabel;
  final ValueChanged<int> onToggleValue;
  final bool initialSelection;
  final Color activeColor;
  final Color inactiveColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final TextStyle? leftLabelStyle;
  final TextStyle? rightLabelStyle;

  const CustomToggleButton({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
    required this.onToggleValue,
    this.initialSelection = true,
    this.activeColor = Colors.yellow,
    this.inactiveColor = Colors.grey,
    this.activeTextColor = Colors.white,
    this.inactiveTextColor = Colors.grey,
    this.leftLabelStyle,
    this.rightLabelStyle,
  });

  @override
  State<CustomToggleButton> createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  late bool isLeftSelected;

  @override
  void initState() {
    super.initState();
    isLeftSelected = widget.initialSelection;
  }

  void _toggleSwitch(bool isLeft) {
    setState(() {
      isLeftSelected = isLeft;
    });
    widget.onToggleValue(isLeft ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    double toggleWidth = 344;

    return Container(
      width: toggleWidth,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(82),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          // Background container
          Container(
            height: 50,
            decoration: BoxDecoration(
              // color: widget.inactiveColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(82),
            ),
          ),

          // Sliding animation
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            left: isLeftSelected ? 0 : toggleWidth / 2,
            child: Container(
              height: 48,
              // Slightly smaller to fit inside the border
              width: toggleWidth / 2 - 2,
              decoration: BoxDecoration(
                color: widget.activeColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
                // borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),

          // Text options
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _toggleSwitch(true),
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      widget.leftLabel,
                      style: widget.leftLabelStyle?.copyWith(
                            color: isLeftSelected
                                ? widget.activeTextColor
                                : widget.inactiveTextColor,
                          ) ??
                          TextStyle(
                            color: isLeftSelected
                                ? widget.activeTextColor
                                : widget.inactiveTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _toggleSwitch(false),
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      widget.rightLabel,
                      style: widget.rightLabelStyle?.copyWith(
                            color: !isLeftSelected
                                ? widget.activeTextColor
                                : widget.inactiveTextColor,
                          ) ??
                          TextStyle(
                            color: !isLeftSelected
                                ? widget.activeTextColor
                                : widget.inactiveTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
