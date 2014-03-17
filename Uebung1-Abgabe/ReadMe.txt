War Files unterscheiden sich nur duch das security-constraint, "dasi-ssl" erlaubt ausschließlich Zugriffe über SSL, "dasi-no-ssl" beide.

gencerts.bat:
- In Java_directory/bin kopieren
- Kommandozeile als Administrator ausführen und zu Java_directory/bin navigieren
- gencerts.bat mit Username als Parameter aufrufen
- server.jks und <Username>.p12 werden erstellt mit Passwort "password"

dasi.p12 im Browser importieren und bei Abfrage angeben.

Weitere Informationen, siehe Wiki.