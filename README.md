# PGU Vertretungsplan App

<img src="./assets/pgu.svg" width="200">

Die PGU Vertretungsplan App um seine Vertretungen schnell und einfach zu finden.

## TODO
- Klassen nur bei Übergabe von (klartext Passwort + salt).hashed
[ ] Replace SDP

## Features
[ ] Lehrer Vertretungen bekommen
[ ] Fehlermeldungen
[x] Nur ausgewählte Klassen sehen
[ ] Benachrichtigungen bei neuen Vertretungen
[x] Fächerfarbe selber auswählen
[x] Filter für Kurse in einem Jahrgang (Nicht alle haben Französisch)
[x] Fächer wieder anzeigen lassen
- Benachrichtigungen nur mit Filter senden (ohne ausgeblendete Kurse)
- Benachrichtigungen gestalten (Icon)
- Benachrichtigungen einbauen
- Firebase Token an Server senden mit Code (wenn sich token ändert überschreiben)
- Wenn neue Vertretung Benachrichtigung senden

##Erweiterung
- Voreinstellungen Fächerfarben
[ ] Vertretung API letzten Stand mitsenden um Geschwindigkeit zu erhöhen

## Optional
[x] Suffix Icon bei Login
- Ausgeblendete Kurse in neuem Schuljahr resetten
- Spiele in Einstellungen unter Versionsnummer
- Termine einbauen (https://www.pgu.de/aktuelles/termine)
- Json Parsing Error behandeln (Welcher?

## Benutzte Resourcen
- https://medium.com/@info_67212/flutter-swipe-your-widget-for-more-action-items-2b85866ca238
- https://firebase.flutter.dev/docs/messaging/notifications/

## API
### Authorisieren (Code überprüfen)
https://pgu.backslash-vr.com/api/user/authorize?code=

### Vertretungen bekommen (Für Code)
https://pgu.backslash-vr.com/api/user/get?code=

