# PGU Vertretungsplan App

<img src="./assets/pgu.svg" width="200">

Die PGU Vertretungsplan App um seine Vertretungen schnell und einfach zu finden.

## TODO
[ ] Anzeigen welche Vertretungenseit letzenmal neu\
[ ] Benachrichtigungen bei neuen Vertretungen\
[ ] Bei neuer Internetverbindung automatisch neuladen\
[ ] Parsing Fehler im Backend beheben\
[ ] Replace SDP\
[ ] App Größe vermindern (https://itnext.io/reducing-flutter-app-size-570db9810ebb) \
[x] Intro/Tutorial Screen\
[x] Settings Baustelle (https://www.pexels.com/de-de/foto/person-frau-bau-arbeiten-8960933/)

## Check
[x] Exclude from Backups\
[x] Offline letzte sehen (Stand der Vertretungen + Offline Error Handling)

## Features
[x] Vertretung API letzten Stand mitsenden um Geschwindigkeit zu erhöhen\
[x] Nur ausgewählte Klassen sehen\
[x] Fächerfarbe selber auswählen\
[x] Filter für Kurse in einem Jahrgang (Nicht alle haben Französisch)\
[x] Fächer wieder anzeigen lassen\
[ ] Benachrichtigungen nur mit Filter senden (ohne ausgeblendete Kurse)\
[ ] Firebase Token an Server senden mit Code (wenn sich token ändert überschreiben)

## Erweiterung
[ ] Voreinstellungen Fächerfarben

## Optional
[ ] Fehlermeldungen (Wo?)\
[ ] Benachrichtigungen gestalten (Icon)\
[ ] Benachrichtigungen einbauen\
[ ] Ausgeblendete Kurse in neuem Schuljahr resetten\
[ ] Spiele in Einstellungen unter Versionsnummer\
[ ] Termine einbauen (https://www.pgu.de/aktuelles/termine)\
[ ] Json Parsing Error behandeln (Welcher?)

## Benutzte Resourcen
[ ] https://medium.com/@info_67212/flutter-swipe-your-widget-for-more-action-items-2b85866ca238 \
[ ] https://firebase.flutter.dev/docs/messaging/notifications

## API

### Vertretungen bekommen
type: 's' für Schüler und 'l' für Lehrer\
content: Klassen/Stufen/Lehrer mit '@' getrennt (Q1@Q2)\
lastFetched: Timespamp der letzten Abfrage (2022-01-25%2016:51:58.948476)\
apikey: (Passwort + "salt").md5\

https://pgu.backslash-vr.com/api/user/get?type&content&lastFetched&apikey

## Android Studio
- https://stackoverflow.com/a/67021737

