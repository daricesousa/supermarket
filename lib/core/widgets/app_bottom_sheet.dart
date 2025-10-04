import 'package:flutter/material.dart';

class AppBottomSheet extends StatelessWidget {
  final List<Widget> actions;
  final String title;
  const AppBottomSheet({super.key, required this.actions, required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            Text(title, style: TextStyle(fontSize: 18)),
            const Divider(),
            ...actions,
          ],
        ),
      ),
    );
  }
}
