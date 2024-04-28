import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  static const messages = <String>[
    'Loading movies',
    'Buying popcorn',
    'Loading popular',
    'Calling my girlfriend',
    'Wait a bit more...',
    'This is taking a little longer :(',
  ];

  Stream<String> getLoadingMessages() => Stream.periodic(
          const Duration(milliseconds: 1200), (step) => messages[step])
      .take(messages.length);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Wait please'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Cargando...');

              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}
