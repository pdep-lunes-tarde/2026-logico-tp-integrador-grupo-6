
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
            conoce(Persona, hazania(NombreHazania, _, Pueblo),
                AnioPresencio, presencio),
            habitante(Persona, _, _, Pueblo),
            AnioPresencio =< AnioDado
        )
    ).
% FALTA PORQUE ES MUSICAL 

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

test("En Weise se recuerda destruir al rey demonio en 1400"):-
    seRecuerdaEnPueblo(weise, destruirAlReyDemonio, 1400).

test("En Klares se recuerda rescatar a la hermana de Wirbel en 1395"):-
    seRecuerdaEnPueblo(klares, rescatarALaHermanaDeWirbel, 1395).

test("En Klares no se recuerda destruir al rey demonio en 1395"):-
    not(seRecuerdaEnPueblo(klares, destruirAlReyDemonio, 1395)).

test("En Weise se leyeron 100 páginas en 1335"):-
    paginasLeidasEnPueblo(weise, 1335, 100).

test("En Weise se leyeron 0 páginas en 1336"):-
    paginasLeidasEnPueblo(weise, 1336, 0).

test("Ende es el pueblo más lector en 1400"):-
    puebloMasLector(ende, 1400).

test("Ende es chismoso en 1420 ya que solo se recuerda destruir al demonio Aura que no está corroborada"):-
    esChismoso(ende, 1420).

test("Weise no es chismoso en 1400"):-
    not(esChismoso(weise, 1400)).

test("destruir al rey demonio es importante para Weise en 1400"):-
    esImportanteParaPueblo(destruirAlReyDemonio, weise, 1400).

test("recuperar al gato perdido no es importante para Weise en 1400"):-
    not(esImportanteParaPueblo(recuperarAlGatoPerdido, weise, 1400)).

test("Klares vive tiempos sin precedentes en 1395"):-
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

:- end_tests(tpIntegrador).
