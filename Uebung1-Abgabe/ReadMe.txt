War Files unterscheiden sich nur duch das security-constraint, "dasi-ssl" erlaubt ausschlie�lich Zugriffe �ber SSL, "dasi-no-ssl" beide.

gencerts.bat:
- In Java_directory/bin kopieren
- Kommandozeile als Administrator ausf�hren und zu Java_directory/bin navigieren
- gencerts.bat mit Username als Parameter aufrufen
- server.jks und <Username>.p12 werden erstellt mit Passwort "password"

dasi.p12 im Browser importieren und bei Abfrage angeben.

Weitere Informationen, siehe Wiki.