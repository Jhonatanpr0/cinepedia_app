import 'package:flutter/material.dart';

class FullscreenLoader extends StatelessWidget {
  const FullscreenLoader({super.key});

  Stream<String> getLoadingMessage() {
    final messages = <String>[
      'Cargando ultimas peliculas...',
      'Cargando proximas peliculas...',
      'Cargando las mas populares...',
      'Cargando las mejores calificadas...',
      'Te estan llamando...',
      'Esta demorando mas de lo esperado pipipi...',
    ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Espere por favor...'),
        const SizedBox(height: 10),
        const CircularProgressIndicator(),
        const SizedBox(height: 10),
        StreamBuilder(
          stream: getLoadingMessage(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Cargando');
            return Text(snapshot.data!);
          },
        )
      ],
    ));
  }
}
