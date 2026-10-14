import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/session_provider.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Summary'),
      ),
      body: Consumer<SessionProvider>(
        builder: (context, provider, child) {
          final sessions = provider.sessions;
          
          if (sessions.isEmpty) {
            return const Center(child: Text('No data to summarize yet.'));
          }

          // Replicating the 'groupBy' collection operation
          final Map<String, int> gamesCount = {};
          for (var session in sessions) {
            gamesCount[session.gameTitle] = (gamesCount[session.gameTitle] ?? 0) + 1;
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text('Total Sessions', style: TextStyle(fontSize: 16)),
                            Text('${sessions.length}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Unique Games', style: TextStyle(fontSize: 16)),
                            Text('${gamesCount.length}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text('Breakdown by Game', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: gamesCount.keys.length,
                    itemBuilder: (context, index) {
                      String game = gamesCount.keys.elementAt(index);
                      int count = gamesCount[game]!;
                      return ListTile(
                        title: Text(game),
                        trailing: Text('$count sessions', style: const TextStyle(fontWeight: FontWeight.bold)),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}