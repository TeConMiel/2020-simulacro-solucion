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

titulo(pelicula(Titulo, Genero, Anio), Titulo) :-
    contenido(_, _, _, pelicula(Titulo, Genero, Anio)).

titulo(serie(Titulo, Generos), Titulo) :-
    contenido(_, _, _, serie(Titulo, Generos)).

titulo(musica(Titulo, Genero, Creador), Titulo) :-
    contenido(_, _, _, musica(Titulo, Genero, Creador)).

titulo(libro(Titulo, Autor, Edicion), Titulo) :-
    contenido(_, _, _, libro(Titulo, Autor, Edicion)).

descargaContenido(Usuario, Contenido) :-
    titulo(Contenido, Titulo),
    descarga(Usuario, Titulo).
    
