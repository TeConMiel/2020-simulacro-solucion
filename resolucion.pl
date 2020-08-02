  
:- encoding(utf8).

/*
Nombre: Agustin D'Beasado,
Legajo: 999999-9
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


% 1.1 ------------------
titulo(Contenido, Titulo):-
    contenido(_, _, _, Contenido),
    tituloFunctor(Contenido, Titulo).
    
tituloFunctor(libro(Titulo, _, _), Titulo).
tituloFunctor(musica(Titulo, _, _), Titulo).
tituloFunctor(serie(Titulo, _), Titulo).
tituloFunctor(pelicula(Titulo, _, _), Titulo).

% 1.2 ------------------
descargaContenido(Usuario, Contenido):-
    descarga(Usuario, Titulo),
    titulo(Contenido, Titulo).

% 2 ------------------
contenidoPopular(Contenido):-
    contenido(_, _, _, Contenido),
    findall(Usuario, descargaContenido(Usuario, Contenido), Usuarios),
    length(Usuarios, Cantidad),
    Cantidad > 10.

% -
contenidoPopular(Contenido):-
    contenidoTotalUsuarios(Contenido, TotalDescargas),
    TotalDescargas >= 10.
    
contenidoTotalUsuarios(Contenido, TotalDescargas):-
    descargaContenido(_, Contenido),
    findall(Contenido, descargaContenido(_, Contenido), Descargas),
    length(Descargas, TotalDescargas).

% 3 ------------------
contenidoAudiovisual(pelicula(_, _, _)).
contenidoAudiovisual(serie(_, _)).

cinefilo(Usuario) :-
    descarga(Usuario, _),
    forall(descargaContenido(Usuario, Contenido), contenidoAudiovisual(Contenido)).

% 4 ------------------
totalDescargado(Usuario, TotalDescargado):-
    descargaContenido(Usuario, _),
    findall(Gigas, 
        (descargaContenido(Usuario, Contenido),
            peso(Contenido, Gigas)), 
        TodosLosGigas),
    sum_list(TodosLosGigas, TotalDescargado).   

peso(Contenido, Peso):- contenido(_, _, Peso, Contenido).


% 5 ------------------
usuarioCool(Usuario):-
    descarga(Usuario, _),
    forall(descargaContenido(Usuario, Contenido),
        contenidoCool(Contenido)).

contenidoCool(serie(_, Generos)):-
    length(Generos, CantGeneros),
    CantGeneros > 1.
contenidoCool(musica(_, kpop, _)).
contenidoCool(musica(_, hardRock, _)).
contenidoCool(pelicula(_, _, Anio)):-
    Anio < 2010.

% 6 ------------------
empresaHeterogenea(Empresa):-
    contenido(Empresa, _, _, Contenido1),
    contenido(Empresa, _, _, Contenido2),
    not(mismoTipo(Contenido1, Contenido2)).

mismoTipo(pelicula(_, _, _), pelicula(_, _, _)).
mismoTipo(musica(_, _, _), musica(_, _, _)).
mismoTipo(libro(_, _, _), libro(_, _, _)).
mismoTipo(serie(_, _), serie(_, _)).

% 7.1 ------------------
cargaServidor(Empresa, Servidor, Carga):-
    contenido(Empresa, Servidor, _, _),
    findall(Peso, contenido(Empresa, Servidor, Peso, _), Pesos),
    sum_list(Pesos, Carga).

% 7.2 ------------------
tieneMuchaCarga(Empresa, Servidor):-
    cargaServidor(Empresa, Servidor, CargaTotal),
    CargaTotal > 1000.

% 7.3 ------------------
servidorMasLiviano(Empresa,ServidorLiviano):-
    cargaServidor(Empresa,ServidorLiviano,_),
    not((cargaServidor(Empresa,OtroServidor,_), OtroServidor \= ServidorLiviano)),
    not(tieneMuchaCarga(Empresa, ServidorLiviano)).

servidorMasLiviano(Empresa,ServidorLiviano):-
    cargaServidor(Empresa,ServidorLiviano,Carga),
    cargaServidor(Empresa,OtroServidor,_), 
    OtroServidor \= ServidorLiviano,
    not((cargaServidor(Empresa,_,OtraCarga),Carga>OtraCarga)).

% 7.4 ------------------
balancearServidor(Empresa, ServidorMuyCargado, ServidorMasLiviano):-
    tieneMuchaCarga(Empresa, ServidorMuyCargado),
    servidorMasLiviano(Empresa, ServidorMasLiviano).

% Fin :) 






