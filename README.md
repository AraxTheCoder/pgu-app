# PGU Vertretungsplan App

<img src="./assets/pgu.svg" width="200">

Die PGU Vertretungsplan App um seine Vertretungen schnell und einfach zu finden.

## TODO
[x] Klassen nur bei Übergabe von (klartext Passwort + salt).hashed
[x] Alle Klassen auf einmal bekommen
[ ] Replace SDP
[x] Settings Baustelle (https://www.pexels.com/de-de/foto/person-frau-bau-arbeiten-8960933/)
[x] Links öffnen (https://pub.dev/packages/url_launcher)
[ ] Tagestitel anzeigen + fetchen

## Features
[ ] Lehrer Vertretungen bekommen
[ ] Fehlermeldungen (Wo?)
[x] Vertretung API letzten Stand mitsenden um Geschwindigkeit zu erhöhen
[x] Nur ausgewählte Klassen sehen
[ ] Benachrichtigungen bei neuen Vertretungen
[x] Fächerfarbe selber auswählen
[x] Filter für Kurse in einem Jahrgang (Nicht alle haben Französisch)
[x] Fächer wieder anzeigen lassen
[ ] Benachrichtigungen nur mit Filter senden (ohne ausgeblendete Kurse)
[ ] Firebase Token an Server senden mit Code (wenn sich token ändert überschreiben)

##Erweiterung
[ ] Voreinstellungen Fächerfarben

## Optional
[x] Suffix Icon bei Login
- Benachrichtigungen gestalten (Icon)
- Benachrichtigungen einbauen
- Ausgeblendete Kurse in neuem Schuljahr resetten
- Spiele in Einstellungen unter Versionsnummer
- Termine einbauen (https://www.pgu.de/aktuelles/termine)
- Json Parsing Error behandeln (Welcher?

## Benutzte Resourcen
- https://medium.com/@info_67212/flutter-swipe-your-widget-for-more-action-items-2b85866ca238
- https://firebase.flutter.dev/docs/messaging/notifications/

## API

### Vertretungen bekommen
https://pgu.backslash-vr.com/api/user/get?type=s&content=Q2@Q1&lastFetched=2022-01-25%2016:51:58.948476&apikey=

