// ignore_for_file: avoid_print
import 'package:zadatci_app/repozitorij.dart';

import 'dart:async';

Future<void> main() async {
  final repo = ZadatakRepozitorij(neuspjeha: 1);

  final stopwatch = Stopwatch()..start();

  try {
    final rezultati = await Future.wait([repo.dohvati(), repo.dohvati()]);

    stopwatch.stop();
    print(
      'Dva dohvata završena. Ukupno zadataka u listama: ${rezultati[0].length + rezultati[1].length}',
    );
    print('Vrijeme izvođenja: ${stopwatch.elapsedMilliseconds} ms');
  } catch (e) {
    print('Pogreška kod istovremenog dohvata: $e');
  }
  print('\n-----------------------------------\n');

  try {
    print('Pokrećem dohvat s timeoutom od 300 ms...');

    await repo.dohvati().timeout(const Duration(milliseconds: 300));

    print('Dohvat je uspio.');
  } on TimeoutException {
    print('Isteklo vrijeme (TimeoutException)');
  } catch (e) {
    print('Druga pogreška: $e');
  }
}
