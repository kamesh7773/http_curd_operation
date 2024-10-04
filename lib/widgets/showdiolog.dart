import 'package:flutter/material.dart';

class MyDiologBox extends StatefulWidget {
  final String btnText;
  final String? nameControllerText;
  final String? emailControllerText;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final void Function() onTap;

  const MyDiologBox({
    super.key,
    required this.btnText,
    this.nameControllerText,
    this.emailControllerText,
    required this.nameController,
    required this.emailController,
    required this.onTap,
  });

  @override
  State<MyDiologBox> createState() => _MyDiologBoxState();
}

class _MyDiologBoxState extends State<MyDiologBox> {
  @override
  Widget build(BuildContext context) {
    widget.nameController.text = widget.nameControllerText ?? "";
    widget.emailController.text = widget.emailControllerText ?? "";
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: widget.nameController,
            decoration: const InputDecoration(
              hintText: "Name :",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: widget.emailController,
            decoration: const InputDecoration(
              hintText: "E-mail :",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: widget.onTap,
          child: Text(widget.btnText),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("CANCEL"),
        ),
      ],
    );
  }
}
