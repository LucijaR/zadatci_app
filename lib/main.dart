import 'package:flutter/material.dart';

import 'repozitorij.dart';
import 'zadatak.dart';

void main() => runApp(const ZadatciApp());

class ZadatciApp extends StatelessWidget {
  const ZadatciApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zadatci',
      home: ZadatciEkran(),
    );
  }
}

class ZadatciEkran extends StatefulWidget {
  const ZadatciEkran({super.key});

  @override
  State<ZadatciEkran> createState() => _ZadatciEkranState();
}

class _ZadatciEkranState extends State<ZadatciEkran> {
  // Promijenite parametre da isprobate sva stanja:
  // neuspjeha: 1 -> prvi dohvat padne, ponovni pokušaj uspije
  // prazno: true -> poslužitelj vraća prazan popis
  // prvi dohvat pada, ponovni pokušaj uspijeva
  final _repo = ZadatakRepozitorij(neuspjeha: 1, prazno: true);
  late Future<List<Zadatak>> _buduci = _repo.dohvati();

  Future<void> _osvjezi() async {
    setState(() {
      _buduci = _repo.dohvati();
    });
    await _buduci;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Zadatci')),
      body: FutureBuilder<List<Zadatak>>(
        future: _buduci,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 8),
                  const Text(
                    'Došlo je do pogreške pri dohvaćanju podataka. Molimo pokušajte ponovno.',
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: _osvjezi,
                    child: const Text('Pokušaj ponovno'),
                  ),
                ],
              ),
            );
          }
          final zadaci = snap.data!;
          if (zadaci.isEmpty) {
            return const Center(child: Text('Nema zadataka'));
          }
          final zavrseniBroj = zadaci.where((z) => z.zavrsen).length;

          // 3. ZADATAK: Omotano u RefreshIndicator + 2. ZADATAK: Tekst o završenim zadacima ispod
          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _osvjezi,
                  child: ListView.builder(
                    itemCount: zadaci.length,
                    itemBuilder: (context, i) {
                      final z = zadaci[i];
                      return ListTile(
                        leading: Icon(
                          z.zavrsen
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                        ),
                        title: Text(
                          z.naslov,
                          style: TextStyle(
                            decoration: z.zavrsen
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Prikaz broja završenih zadataka na dnu zaslona
              Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                color: Colors.grey.shade100,
                child: Text(
                  'Završeno: $zavrseniBroj od ${zadaci.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
