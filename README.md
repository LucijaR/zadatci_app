# zadatci_app

**Ime i prezime:** Lucija Rašić
* **Operacijski sustav:** Windows 10
* **Verzija Fluttera:** 3.47.7
* **Verzija Darta:** 3.13.5
* **Korišteni uređaj:** Windows (desktop) / Chrome

# 1. pitanje
**Zašto polja modela nisu promjenjiva (final)?**
  Da bi objekt bio imutable (nepromjenjiv), što sprječava nepredvidive promjene podataka u hodu. Umjesto mijenjanja postojećeg objekta, koristimo metodu kopiraj koja vraća novu instancu s izmijenjenim vrijednostima.
* **Što bi se dogodilo da u JSON-u polje naslov nedostaje (uz as String na vrijednosti null)?**
Program bi puknuo uz TypeError jer pokušavamo spremiti null u polje koje traži String.

# 2. pitanje
**U repozitorij_provjera.dart dohvat pozovite s Future.wait dvaput istovremeno i izmjerite vrijeme pomoću Stopwatch. Koliko traje: 800 ms ili 1600 ms?**
Traje oko 800 ms, a ne 1600 ms, zato što se Future.wait izvršava paralelno 
**Objasnite što se događa kad iznimku iz Futurea ne uhvatimo ni na jednom mjestu. Odgovor zapišite u README.**
Ako se iznimka (error) unutar Future-a ne obradi pomoću try-catch bloka ili .catchError(), ona postaje neuhvaćena iznimka i to uzrokuje prekid izvođenja.

# 3. pitanje
### Provjera razumijevanja 3
* **Zašto se Future stvara u polju, a ne u metodi build?**
  Zato što se metoda build može pozvati više puta tijekom rada aplikacije. Kad bi se `Future` stvarao unutar metode build, ponovno bi se pokretao dohvat pri svakom iscrtavanju zaslona, što bi uzrokovalo beskonačnu petlju ponovnog učitavanja.
* **Koja su tri stanja koja svaki zaslon s podacima mora prikazati?**
  1. **Stanje učitavanja:** Prikazuje se dok se podaci dohvaćaju (npr. kružni indikator napretka CircularProgressIndicator).
  2. **Stanje pogreške (Error):** Prikazuje se ako dohvat podataka ne uspije (npr. poruka o grešci i gumb za ponovni pokušaj).
  3. **Stanje uspješnih podataka (Success / Data):** Prikazuje se kada su podaci uspješno dohvaćeni (npr. ListView s popisom elemenata ili poruka da je popis prazan).


