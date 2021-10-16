# PGU Vertretungsplan App

<img src="./assets/pgu.svg" width="200">

Die PGU Vertretungsplan App um seine Vertretungen schnell und einfach zu finden.

## Features

- Nur ausgewählte Klassen sehen
- Benachrichtigungen bei neuen Vertretungen
- Fächerfarbe selber auswählen
- Filter für Kurse in einem Jahrgang (Nicht alle haben Französisch)
- Fächer wieder anzeigen lassen
- Voreinstellungen Fächerfarben
- Ausgeblendete Kurse in neuem Schuljahr resetten
- Benachrichtigungen einbauen
- Firebase Token an Server senden mit Code (wenn sich token ändert überschreiben)

## Roadmap (Nicht nach Priorität geordnet)
- Spiele in Einstellungen unter Versionsnummer
- Termine einbauen (https://www.pgu.de/aktuelles/termine)
- Benachrichtigungen nur mit Filter senden (ohne ausgeblendete Kurse)
- Benachrichtigungen gestalten (Icon)
- Json Parsing Error behandeln

## Working on
- Wenn neue Vertretung Benachrichtigung senden

## Eventuell überarbeiten
- Ausgeblendete Kurse ansicht
- Wenn alle Kurse ausgeblendet Hund anzeigen und darunter Ausgeblendete Kurse

## Benutzte Resourcen
- https://medium.com/@info_67212/flutter-swipe-your-widget-for-more-action-items-2b85866ca238
- https://firebase.flutter.dev/docs/messaging/notifications/

## API
### Authorisieren (Code überprüfen)
https://pgu.backslash-vr.com/api/user/authorize?code=

### Vertretungen bekommen (Für Code)
https://pgu.backslash-vr.com/api/user/get?code=

