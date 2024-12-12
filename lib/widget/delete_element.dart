import 'package:flutter/material.dart';

class DeleteElement extends StatelessWidget {
  const DeleteElement({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }
}
