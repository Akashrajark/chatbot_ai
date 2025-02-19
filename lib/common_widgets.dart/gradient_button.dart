import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final double borderWidth;
  final double borderRadius;
  final List<Color> borderColors;
  final bool isLoading;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.borderWidth = 3.0,
    this.borderRadius = 32.0,
    this.borderColors = const [Colors.blue, Colors.purple],
    this.isLoading = false,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        gradient:
            LinearGradient(colors: widget.borderColors), // Border Gradient
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: _hovering ? const Offset(2, 2) : Offset.zero,
            blurRadius: _hovering ? 4 : 0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(widget.borderWidth),
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(widget.borderRadius - widget.borderWidth),
            color: Colors.black,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(
                  widget.borderRadius - widget.borderWidth),
              onTap: widget.isLoading ? null : widget.onPressed,
              onHover: (value) {
                setState(() {
                  _hovering = value;
                });
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Center(
                  child: widget.isLoading
                      ? const CupertinoActivityIndicator(
                          radius: 10, color: Colors.white)
                      : Text(
                          widget.text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
