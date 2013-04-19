Szkolenie SOLR4 - podstawy
================

Prosze wykonajcie nastepujace kroki:

Sprawdzenie czy dziala ruby - pobranie danych z wolnelektury.pl
---------------------------------------------------------------
``
cd data/lektury; ruby get_data.rb; cd -
``

Stworzenie self-embeded SOLR
----------------------------
``
cd solr; mvn package; cd -
``

Jesli cos nie zadziala
----------------------
Nie przejmuj sie zarowno dane do szkolenia, jak i sam jar z SOLR zostanie udostepniony.
