:- encoding(utf8).

/*
Alumno: Franco damian romagnoli
Legajo: 173.112-9
*/

% libro(título, autor, edición)
contenido(amazingzone, host1, 0.1, libro(lordOfTheRings, jrrTolkien, 4)).
contenido(g00gle, ggle1, 0.04, libro(foundation, asimov, 3)).
contenido(g00gle, ggle1, 0.015, libro(estudioEnEscarlata, conanDoyle, 3)).

% musica(título, género, banda/artista)
contenido(spotify, spot1, 0.3, musica(theLastHero, hardRock, alterBridge)).
contenido(pandora, pand1, 0.3, musica(burn, hardRock, deepPurple)).
contenido(spotify, spot1, 0.3, musica(2, hardRock, blackCountryCommunion)).
contenido(spotify, spot2, 0.233, musica(squareUp, kpop, blackPink)).
contenido(pandora, pand1, 0.21, musica(exAct, kpop, exo)).
contenido(pandora, pand1, 0.28, musica(powerslave, heavyMetal, ironMaiden)).
contenido(spotify, spot4, 0.18, musica(whiteWind, kpop, mamamoo)).
contenido(spotify, spot2, 0.203, musica(shatterMe, dubstep, lindseyStirling)).
contenido(spotify, spot4, 0.22, musica(redMoon, kpop, mamamoo)).
contenido(g00gle, ggle1, 0.31, musica(braveNewWorld, heavyMetal, ironMaiden)).
contenido(pandora, pand1, 0.212, musica(loveYourself, kpop, bts)).
contenido(spotify, spot2, 0.1999, musica(aloneInTheCity, kpop, dreamcatcher)).

% serie(título, géneros)
contenido(netflix, netf1, 30, serie(strangerThings, [thriller, fantasia])).
contenido(fox, fox2, 500, serie(xfiles, [scifi])).
contenido(netflix, netf2, 50, serie(dark, [thriller, drama])).
contenido(fox, fox3, 127, serie(theMentalist, [drama, misterio])).
contenido(amazon, amz1, 12, serie(goodOmens, [comedia,scifi])).
contenido(netflix, netf1, 810, serie(doctorWho, [scifi, drama])).

% pelicula(título, género, año)
contenido(netflix, netf1, 2, pelicula(veronica, terror, 2017)).
contenido(netflix, netf1, 3, pelicula(infinityWar, accion, 2018)).
contenido(netflix, netf1, 3, pelicula(spidermanFarFromHome, accion, 2019)).

descarga(mati1009, strangerThings).
descarga(mati1009, infinityWar).
descarga(leoOoOok, dark).
descarga(leoOoOok, powerslave).




%-------[PUNTO 1]-------%

titulo(Contenido, Titulo) :-
    contenido(_,_,_, Contenido),
    mismoTitulo(Contenido,Titulo).

mismoTitulo(libro(Titulo, _, _), Titulo).
mismoTitulo(serie(Titulo,_), Titulo).
mismoTitulo(pelicula(Titulo,_,_), Titulo).
mismoTitulo(musica(Titulo,_,_), Titulo).

descargaContenido(Usuario, Contenido) :-
    titulo(Contenido, Titulo),
    descarga(Usuario, Titulo).
    
%-------[PUNTO 2]-------%

contenidoPopular(Contenido) :-
    contenido(_,_,_,Contenido),
    findall(Usuario, descargaContenido(Usuario, Contenido), ListaUsuarios),
    length(ListaUsuarios, CantidadDescargas),
    CantidadDescargas > 10.

%-------[PUNTO 3]-------%

cinefilo(Usuario) :-
    descarga(Usuario, _),
    forall(descargaContenido(Usuario, Contenido), contenidoAudiovisual(Contenido)).

contenidoAudiovisual(pelicula(_,_,_)).
contenidoAudiovisual(serie(_,_)).

%-------[PUNTO 4]-------%

totalDescargado(Usuario, PesoTotal) :-
    descarga(Usuario, _),
    findall(Peso, (descargaContenido(Usuario,Contenido), contenido(_,_, Peso, Contenido) ), PesosGB),
    sumlist(PesosGB, PesoTotal).

%-------[PUNTO 5]-------%

usuarioCool(Usuario) :-
    descarga(Usuario, _),
    forall(descargaContenido(Usuario,Contenido), contenidoCool(Contenido)).

contenidoCool(musica(_,kpop,_)).
contenidoCool(musica(_,hardRock,_)).

contenidoCool(serie(_,Generos)) :-
    length(Generos, NumeroDeGeneros),
    NumeroDeGeneros > 1.

contenidoCool(pelicula(_,_,Anio)) :-
    Anio < 2010.

%-------[PUNTO 6]-------%

empresaHeterogenea(Empresa) :-
    contenido(Empresa, _, _, Contenido),
    contenido(Empresa, _, _, OtroContenido),
    Contenido \= OtroContenido,
    not(mismoTipo(Contenido, OtroContenido)). %Existen dos contenidos distintos que NO sean del mismo tipo.

mismoTipo(pelicula(_,_,_), pelicula(_,_,_)).
mismoTipo(serie(_,_), serie(_,_)).
mismoTipo(musica(_,_,_), musica(_,_,_)).
mismoTipo(libro(_,_,_), libro(_,_,_)).

%-------[PUNTO 7]-------%

cargaServidor(Empresa,Servidor, Carga) :-
    contenido(Empresa,Servidor,_,_),
    findall(Peso, contenido(Empresa,Servidor, Peso, _), PesosGB),
    sumlist(PesosGB, Carga).

tieneMuchaCarga(Empresa, Servidor) :-
    cargaServidor(Empresa,Servidor,Carga),
    Carga > 1000.

servidorMasLiviano(Empresa, Servidor) :-
    cargaServidor(Empresa,Servidor, Carga),
    forall((cargaServidor(Empresa,OtroServidor, CargaOtroServidor), Servidor \= OtroServidor) , CargaOtroServidor > Carga ).

balancearServidor(Empresa, ServidorMuchaCarga, ServidorLiviano) :-
    tieneMuchaCarga(Empresa, ServidorMuchaCarga),
    servidorMasLiviano(Empresa, ServidorLiviano),
    ServidorMuchaCarga \= ServidorLiviano.