# Übersichtsseite aller Fallstudien

## Bilder

Die Logo-Bilder der Fallstudien liegen in `images/` und werden von dort eingebunden.
`scripts/update-oer-images.sh` lädt die aktuellen Logos aus den veröffentlichten OERs
und ersetzt sie, wenn sie sich geändert haben.

Die GitHub Action `.github/workflows/update-oer-images.yml` führt das Skript bei jedem
Push auf `main` sowie wöchentlich aus und committet Aktualisierungen automatisch.
