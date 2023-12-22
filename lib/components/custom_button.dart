import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Function() onPressed;
  final String text;
  final bool isExpand;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isExpand,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: const MaterialStatePropertyAll(
          Color(0xff262626),
        ),
      ),
      onPressed: widget.onPressed,
      child: widget.isExpand
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.text,
                    style: const TextStyle(fontSize: 16, color: Colors.white)),
              ],
            )
          : Text(widget.text,
              style: const TextStyle(fontSize: 16, color: Colors.white)),
    );
  }
}
