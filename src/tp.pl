
% Parte 1

% Punto 1

% habitante(Nombre, Raza, AnioNacimiento, Pueblo).

habitante(denken, humano, 1290, auberst).
habitante(voll, enano, 1200, ende).
habitante(serie, elfo, 500, weise).
habitante(fern, humano, 1370, weise).
habitante(stark, humano, 1368, riegel).
habitante(lawine, humano, 1372, auberst).
habitante(kanne, humano, 1365, weise).
habitante(wirbel, humano, 1350, klares).
habitante(lernen, humano, 1315, auberst).
habitante(frieren, elfo, 100, weise).
habitante(eisen, enano, 1150, riegel).


estaViva(Persona, AnioDado):-
    habitante(Persona, Raza, AnioNacimiento, _),
    AnioNacimiento=<AnioDado,
    sigueConVida(Raza, AnioNacimiento, AnioDado).

sigueConVida(humano, AnioNacimiento, AnioDado):-
    AnioDado =< AnioNacimiento + 80.

sigueConVida(enano, AnioNacimiento, AnioDado):-
    AnioDado =< AnioNacimiento + 350.

sigueConVida(elfo, _, _).


% Punto 2

% conoce(Quien, Hazania, DesdeCuando, Como)

conoce(wirbel, hazania(rescatarALaHermanaDeWirbel, [stark, fern], klares), 1390, presencio).
conoce(frieren, hazania(rescatarALaHermanaDeWirbel, [stark, fern], klares), 1390, presencio).
conoce(lawine, hazania(destruirAlDemonioAura, [frieren], weise), 1393, escucho).
conoce(voll, hazania(destruirAlDemonioAura, [denken], auberst), 1400, leyo(50)).
conoce(serie, hazania(destruirAlReyDemonio, [frieren, himmel, heiter, eisen], ende), 1335, leyo(100)).
conoce(kanne, hazania(recuperarAlGatoPerdido, [frieren, himmel], weise), 1375, presencio).


esRecordada(NombreHazania, Persona, AnioDado):-
    conoce(Persona, hazania(NombreHazania, _, _), AnioQueConocio, Medio),
    AnioQueConocio =< AnioDado,
    estaViva(Persona, AnioDado),
    sigueRecordando(Medio, AnioQueConocio, AnioDado).


sigueRecordando(presencio, _, _).

sigueRecordando(escucho, AnioQueConocio, AnioDado):-
    AnioDado =< AnioQueConocio + 15.

sigueRecordando(leyo(Paginas), AnioQueConocio, AnioDado):-
    AnioDado =< AnioQueConocio + Paginas.



tieneVersionesDistintas(NombreHazania):-
    conoce(_, hazania(NombreHazania, Quienes1, Donde1), _, _ ),
    conoce(_, hazania(NombreHazania, Quienes2, Donde2), _, _ ),
    hazania(NombreHazania, Quienes1, Donde1) \= hazania(NombreHazania, Quienes2, Donde2).

estaCorroborada(NombreHazania):-
    conoce(_, hazania(NombreHazania, _, _), _, _),
    not(tieneVersionesDistintas(NombreHazania)).


pasoAlOlvido(NombreHazania, AnioDado):-
    conoce(_, hazania(NombreHazania, _, _), _, _),   
    not(esRecordada(NombreHazania, _, AnioDado)).


% Punto 3


% conmemora(Pueblo, Hazania, FechaDeConmemoracion, ComoConmemora)

conmemora(weise, hazania(destruirAlReyDemonio, [frieren, himmel, heiter, eisen], ende), 1340, diaFestivo).

% Auberst
conmemora(auberst, hazania(destruirAlReyDemonio, [frieren, himmel, heiter, eisen], ende), 1370, estatua(elEquipoDeHeroes, bronce)).
conmemora(auberst, hazania(destruirASchlatElOmnisciente, [heroeDelSur], ende), 1340, estatua(elHeroeDelSur, marmol)).

mantenimiento(elEquipoDeHeroes, 1400).
mantenimiento(elHeroeDelSur, 1450).



conoce(Persona, Hazania, AnioQueConocio, ComoConmemora):-
    habitante(Persona, _, AnioNacimiento, Pueblo),
    conmemora(Pueblo, Hazania, AnioInicio, ComoConmemora),
    maximo(AnioNacimiento, AnioInicio, AnioQueConocio).


maximo(Valor1, Valor2, Valor2):-
    Valor1 =< Valor2.

maximo(Valor1, Valor2, Valor1):-
    Valor1 > Valor2.

sigueRecordando(diaFestivo, _, _).

sigueRecordando(estatua(NombreEstatua, Material), _, AnioDado) :-
    conmemora(_, _, AnioConstruccion, estatua(NombreEstatua, Material)),
    estaEnBuenEstado(NombreEstatua, Material, AnioConstruccion, AnioDado).



duracion_material(marmol, 30).
duracion_material(bronce, 15).

estaEnBuenEstado(NombreEstatua, Material, _, AnioDado) :-
    duracion_material(Material, DuracionMaxima),
    mantenimiento(NombreEstatua, AnioMantenimiento),
    AnioMantenimiento =< AnioDado,
    AnioDado - AnioMantenimiento =< DuracionMaxima.

estaEnBuenEstado(_, Material, AnioConstruccion, AnioDado) :-
    duracion_material(Material, DuracionMaxima),
    AnioDado - AnioConstruccion =< DuracionMaxima.


%----------------------------------------Parte 2-----------------------------------------------------------------%

% Punto 4

seRecuerdaEnPueblo(Pueblo, NombreHazania, AnioDado):-
    habitante(Persona, _, _, Pueblo),
    esRecordada(NombreHazania, Persona, AnioDado).


paginasLeidasEnPueblo(Pueblo, AnioDado, TotalPaginas):-
    findall(Paginas,
            (habitante(Persona, _, _, Pueblo),
            conoce(Persona, hazania(_, _, _), AnioDado, leyo(Paginas))),
            ListaPaginas),
    sum_list(ListaPaginas, TotalPaginas).


esMasLector(Pueblo1, Pueblo2, AnioDado):-
    paginasLeidasEnPueblo(Pueblo1, AnioDado, Paginas1),
    paginasLeidasEnPueblo(Pueblo2, AnioDado, Paginas2),
    Paginas1 > Paginas2.


puebloMasLector(Pueblo, AnioDado):-
    habitante(_, _, _, Pueblo),
    forall(
        (habitante(_, _, _, OtroPueblo), Pueblo \= OtroPueblo),
        esMasLector(Pueblo, OtroPueblo, AnioDado)
    ).


esMusical(Pueblo, AnioDado):-
    hazaniasRecordadas(Pueblo, AnioDado, Hazanias),
    hazaniasRecordadasPorCanciones(Pueblo, AnioDado, HazaniasPorCanciones),
    length(Hazanias, CantidadTotal),
    length(HazaniasPorCanciones, CantidadCanciones),
    CantidadCanciones * 2 > CantidadTotal.


hazaniasRecordadas(Pueblo, AnioDado, Hazanias):-
    findall(
        NombreHazania,
        seRecuerdaEnPueblo(Pueblo, NombreHazania, AnioDado),
        HazaniasRepetidas
    ),
    list_to_set(HazaniasRepetidas, Hazanias).


hazaniasRecordadasPorCanciones(Pueblo, AnioDado, Hazanias):-
    findall(
        NombreHazania,
        (
            habitante(Persona, _, _, Pueblo),
            conoce(Persona, hazania(NombreHazania, _, _), _, escucho),
            esRecordada(NombreHazania, Persona, AnioDado)
        ),
        HazaniasRepetidas
    ),
    list_to_set(HazaniasRepetidas, Hazanias).


esChismoso(Pueblo, AnioDado):-
    habitante(_, _, _, Pueblo),
    not((
        seRecuerdaEnPueblo(Pueblo, NombreHazania, AnioDado),
        estaCorroborada(NombreHazania)
    )).


esImportanteParaPueblo(NombreHazania, Pueblo, AnioDado):-
    habitante(_, _, _, Pueblo),
    forall(
        (habitante(Persona, _, _, Pueblo),
        estaViva(Persona, AnioDado)),
        esRecordada(NombreHazania, Persona, AnioDado)
    ).


estaViviendoTiemposSinPrecedentes(Pueblo, AnioDado):-
    habitante(_, _, _, Pueblo),
    forall(
        (seRecuerdaEnPueblo(Pueblo, NombreHazania, AnioDado),
        esImportanteParaPueblo(NombreHazania, Pueblo, AnioDado)),
        (
            habitante(Persona, _, _, Pueblo),
            conoce(Persona, hazania(NombreHazania, _, _),
                AnioPresencio, presencio),
            AnioPresencio =< AnioDado
        )
    ).

% Punto 5

esHeroe(Persona):-
    habitante(Persona,_,_,_),
    conoce(_,hazania(_,Participantes,_),_,_),
    member(Persona,Participantes).

inspiroHeroe(Heroe,Inspirador):-
    habitante(Heroe,_,_,_),
    conoce(Heroe,hazania(_,Participantes,_),_,_),
    member(Inspirador,Participantes),
    Inspirador \= Heroe.

cadenaInspiracion(Heroe,Cadena):-
    cadenaRecursiva(Heroe,[Heroe],Cadena). % En Cadena almacenamos los heroes que cumplen 

cadenaRecursiva(HeroeActual, Visitados, Visitados). % Caso Base utilizamos Visitados como una memoria para chequear q no haya loopps

cadenaRecursiva(HeroeActual, Visitados, Cadena):-
    inspiroHeroe(HeroeActual,SiguienteHeroe),
        not(member(SiguienteHeroe, Visitados)), % Chequeamos 
        cadenaRecursiva(SiguienteHeroe, [SiguienteHeroe | Visitados], Cadena). % Utilizamos cadena para guardar el camino final de visitados

% Punto 6

dreamTeam(Heroe, Equipo):-
    esHeroe(Heroe),
    cadenaInspiracion(Heroe, Cadena),

    generarEquipo(Cadena, [], Equipo),
    member(Heroe, Equipo),
    member(Otro, Equipo),
    Heroe \= Otro.


generarEquipo(_, Equipo, Equipo).

generarEquipo(Cadena, Acumulador, EquipoFinal):-
    
    member(Integrante, Cadena),
    not(member(Integrante, Acumulador)),

    generarEquipo(Cadena, [Integrante | Acumulador], EquipoFinal).


    


:- begin_tests(tpIntegrador, []).

% Tests punto 1
test("Nadie esta vivo en un anio anterior a su nacimiento") :- 
    not(estaViva(kanne, 1300)).

test("Un humano esta vivo si el anio dado esta dentro de su expectativa de vida") :- 
    estaViva(kanne, 1370).

test("Un humano ya no esta vivo si supero su expectativa de vida") :- 
    not(estaViva(kanne, 2000)).

test("Un enano esta vivo si el anio dado esta dentro de su expectativa de vida") :- 
    estaViva(voll, 1550).

test("Un enano ya no esta vivo si supero su expectativa de vida") :- 
    not(estaViva(voll, 1551)).

test("Un elfo esta vivo en cualquier anio posterior a su nacimiento porque es inmortal") :- 
    estaViva(serie, 5000).


% Tests punto 2

test("Una persona no puede recordar una hazania en un anio anterior a conocerla") :- 
    not(esRecordada(destruirAlDemonioAura, lawine, 1380)).

test("Una persona recuerda una hazania si el anio esta dentro de la duracion de su recuerdo"):- 
    esRecordada(destruirAlDemonioAura, lawine, 1400).

test("Una persona deja de recordar una hazania cuando termina el tiempo de ese recuerdo"):- 
    not(esRecordada(destruirAlDemonioAura, lawine, 1410)).

test("Una persona recuerda una hazania si el anio esta dentro de la duracion de su recuerdo"):- 
    esRecordada(destruirAlDemonioAura, voll, 1450).

test("Una persona deja de recordar una hazania cuando termina el tiempo de ese recuerdo"):- 
    not(esRecordada(destruirAlDemonioAura, voll, 1460)).

test("Una persona recuerda una hazania que presencio toda su vida"):- 
    esRecordada(rescatarALaHermanaDeWirbel, wirbel, 1430).

test("Una persona no puede recordar una hazania si ya fallecio"):- 
    not(esRecordada(rescatarALaHermanaDeWirbel, wirbel, 1440)).   

test("Una hazania esta corroborada si las diferentes personas que la conocen están de acuerdo en lugar y héroes que la llevaron a cabo"):- 
    estaCorroborada(rescatarALaHermanaDeWirbel).

test("Una hazania no esta corroborada si las diferentes personas que la conocen no están de acuerdo ni en lugar ni en los héroes que la llevaron a cabo"):- 
    not(estaCorroborada(destruirAlDemonioAura)).

test("Una hazania pasa al olvido si ya no existe ninguna persona viva que la recuerde"):- 
    pasoAlOlvido(destruirAlDemonioAura, 1460).

test("Una hazania no pasa al olvido si todavia hay al menos una persona viva que la recuerde"):- 
    not(pasoAlOlvido(destruirAlDemonioAura, 1400)).

% Tests punto 3

test("Un habitante no recuerda una hazania por estatua si pasaron mas de 15 anios de construccion sin mantenimiento"):- 
    not(esRecordada(destruirAlReyDemonio, lawine, 1390)).

test("Un habitante recupera el recuerdo por estatua si esta tuvo mantenimiento reciente"):- 
    esRecordada(destruirAlReyDemonio, lawine, 1400).

test("Un habitante recuerda una hazania conmemorada por un dia festivo mientras siga con vida"):- 
    esRecordada(destruirAlReyDemonio, fern, 1400).



% test punto 4

test("un pueblo puede recordad una hazania si es recordada por un habitante"):-
    seRecuerdaEnPueblo(weise, destruirAlReyDemonio, 1400).

test("un pueblo puede recordad una hazania si es recordada por un habitante"):-
    seRecuerdaEnPueblo(klares, rescatarALaHermanaDeWirbel, 1395).

test("un pueblo no puede recordar una hazania si no es recordada por un habitante"):-
    not(seRecuerdaEnPueblo(klares, destruirAlReyDemonio, 1395)).

test("se leen 100 paginas, si el total de paginas leidas entre todos los habitantes se suma a 100 en ese anio"):-
    paginasLeidasEnPueblo(weise, 1335, 100).

test("se leen 0 paginas, si el total de paginas leidas entre todos los habitantes es 0 en ese anio"):-
    paginasLeidasEnPueblo(weise, 1336, 0).

test("En un anio cuando el pueblo es mas lector que cualquier otros, es el mas lector"):-
    puebloMasLector(ende, 1400).

test("Cuando un pueblo recuerda la mayoria de hazanias de ese anio con canciones o otras maneras, es musical"):-
    esMusical(aubert, 1395).

test("Cuando un pueblo no recuerda la mayoria de hazanias con canciones o otras maneras, no es musical"):-
    not(esMusical(weise, 1400)).

test("un pueblo es chimoso, cuando una hazania en el anio no esta corroborada"):-
    esChismoso(ende, 1420).

test("un pueblo no es chismoso, si la hazania de ese anio si esta corroborada."):-
    not(esChismoso(weise, 1400)).

test("cuando todos los habitantes de un pueblo recuerdan una hazania, esa hazania es la mas importante"):-
    esImportanteParaPueblo(destruirAlReyDemonio, weise, 1400).

test("cuando no todos los habitantes recuerdan una hazania en el anio, entonces no es importante para el pueblo"):-
    not(esImportanteParaPueblo(recuperarAlGatoPerdido, weise, 1400)).

test("cuando alguien del pueblo precencio todas las hazanias importantes, se concidera que viven tiempos sin precedentes"):-
    estaViviendoTiemposSinPrecedentes(klares, 1395).

% Tests Punto 5

test("Alguien que participo en al menos una hazania que alguien conoce es un heroe"):-
    esHeroe(frieren).

test("Alguien que nunca particio en una hazania no puede ser un heroe"):-
    not(esHeroe(wirbel)).

test("Un heroe fue inspirado por otra persona si este segundo participo en una que el heroe conoce"):-
    inspiroHeroe(fern,frieren).

test("Un Personaje fue inspirado por otra persona ya que este segundo participo en una hazania que Personaje conoce"):-
    inspiroHeroe(frieren,stark).

test("Nadie inspira a un heroe del que no sabemos las hazanias que conoce"):-
    not(inspiroHeroe(eisen,_)).

test("Una cadena de inspiracion a un heroe en la que cada heroe siguiente inspira al anterior, no se repiten ni se forman bucles es valida"):-
    cadenaInspiracion(denken,[himmel, fern ,frieren , denken]).

test("Una cadena de inspiracion en la que un personaje que aparece no inspiro al siguiente no es valida"):-
    not(cadenaInspiracion(denken, [denken,frieren])).

test("Una cadena de inspiracion en la que un personaje se repite no es valida"):-
    not(cadenaInspiracion(frieren,[frieren,fern,frieren])).


% Test punto 6

test("Un dream team es valido si incluye al heroe y un antecesor") :-
    dreamTeam(fern, [fern, himmel]).

test("Un dream team es valido sin importar el orden de sus integrantes") :-
    dreamTeam(fern, [himmel, fern]).

test("Un dream team no es valido si el heroe esta solo") :-
    not(dreamTeam(fern, [fern])).

test("Un dream team no es valido si no esta el propio heroe") :-
    not(dreamTeam(fern, [frieren])).

:- end_tests(tpIntegrador).
