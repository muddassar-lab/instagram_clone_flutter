import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final VoidCallback onPressed;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        minimumSize: const Size(
          double.infinity,
          50,
        ),
      ),
      onPressed: onPressed,
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(
              text,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
    );
  }
}
