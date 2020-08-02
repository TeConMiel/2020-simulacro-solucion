# Simulacro de Parcial de Lógico :: Downloads !
![Download](https://www.simhubdash.com/wp-content/uploads/2019/05/Download-Button.png)

Los dueños de distintas empresas de contenidos requieren cierto análisis sobre la información de descargas, con el supuesto propósito de mejorar la calidad del servicio a sus clientes, que de acuerdo a nuestro entendimiento es solo para vender nuevos upgrades a los clientes de acuerdo a lo que consumen. 
Para esto nos brindaron una pequeña información de las descargas realizadas en este último tiempo, escritas en forma de cláusulas (¿quién lo hubiese dicho?) del predicado contenido/4, que relaciona: una empresa, nombre del servidor, peso en GBs del contenido y el contenido propiamente dicho, que puede ser libro, disco de música, serie o película:

```
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
```
Y por supuesto también hay información de las descargas de los usuarios.
```
descarga(mati1009, strangerThings).
descarga(mati1009, infinityWar).
descarga(leoOoOok, dark).
descarga(leoOoOok, powerslave).
```
Para esto se pide realizar los siguientes predicados, teniendo en cuenta que todos deben ser totalmente inversibles, a menos que se aclare lo contrario.

1. La vida es más fácil cuando hablamos solo de los títulos de las cosas...
    1. `titulo/2`. Relacionar un contenido con su título.
    2. `descargaContenido/2`. Relaciona a un usuario con un contenido descargado, es decir toda la información completa del mismo.

2. `contenidoPopular/1`. Un contenido es popular si lo descargan más de 10 usuarios.

3. `cinefilo/1`  Un usuario es cinéfilo si solo descarga contenido audiovisual (series y películas)

4. `totalDescargado/2`. Relaciona a un usuario con el total del peso del contenido de sus descargas, en GB

5. `usuarioCool/1`. Un usuario es cool, si solo descarga contenido cool:
- La música es cool si el género es kpop o hardRock.
- Las series, si tienen más de un género.
- Las películas anteriores al 2010 son cool.
Ningún libro es cool.

6. `empresaHeterogenea/1`. Si todo su contenido no es del mismo tipo. Es decir, todo película, o todo serie... etc.

7. Existe la sobrecarga de equipos, por lo tanto vamos a querer trabajar sobre los servidores a partir del peso de su contenido:
    1. `cargaServidor/3`. Relaciona a una empresa con un servidor de dicha empresa y su carga, es decir el peso conjunto de todo su contenido.
    2. `tieneMuchaCarga/2`. Relaciona una empresa con su servidor que tiene exceso de carga. Esto pasa cuando supera los 1000 GB de información.
    3. `servidorMasLiviano/2`. Relaciona a la empresa con su servidor más liviano, que es aquel que tiene menor carga, teniendo en cuenta que si es uno solo, no puede tener mucha carga.
    4. `balancearServidor/3`. Relaciona una empresa, un servidor que tiene mucha carga y el servidor más liviano de la empresa; de forma tal de planificar una migración de contenido del primero al segundo, los cuales deben ser distintos.


