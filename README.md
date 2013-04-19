Szkolenie SOLR4 - podstawy
================

Prosze wykonajcie nastepujace kroki:

Sprawdzenie czy dziala ruby - pobranie danych z wolnelektury.pl
---------------------------------------------------------------
``
cd data/lektury; ruby get_data.rb; cd -
``

Sprawdzenie czy na komputerze jest zainstalowana java
-----------------------------------------------------
``
java -version
``

Stworzenie self-embeded SOLR (Opcjonalne)
----------------------------
Na komputerze musi byc zainstalowany maven
``
cd solr; mvn package; cd -
``

Jesli cos nie zadziala
----------------------
Nie przejmuj sie zarowno dane do szkolenia, jak i sam jar z SOLR zostanie udostepniony.
