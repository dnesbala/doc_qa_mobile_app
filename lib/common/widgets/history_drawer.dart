import 'package:flutter/material.dart';

class HistoryDrawer extends StatelessWidget {
  final List history;

  const HistoryDrawer({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.sizeOf(context).width * .8,
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFB02782),
            ),
            child: Center(
              child: Text(
                'Document Q&A History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (history.isEmpty)
            const Expanded(
              child: Center(
                child: Text(
                  'No history available',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final item = history[index];
                  return ListTile(
                    title: Text(
                      item.question,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(item.answer),
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
