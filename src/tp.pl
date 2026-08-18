
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
    habitante(Persona, humano, AnioNacimiento, _),
    AnioNacimiento=<AnioDado,
    AnioDado =< AnioNacimiento + 80.


estaViva(Persona, AnioDado):-
    habitante(Persona, enano, AnioNacimiento, _),
    AnioNacimiento=<AnioDado,
    AnioDado =< AnioNacimiento + 350.


estaViva(Persona, AnioDado):-
    habitante(Persona, elfo, AnioNacimiento, _),
    AnioNacimiento=<AnioDado.



% Punto 2

% conoce(Quien, Hazania, DesdeCuando, Como)

conoce(wirbel, hazania(rescatarALaHermanaDeWirbel, [stark, fern], klares), 1390, presencio).
conoce(frieren, hazania(rescatarALaHermanaDeWirbel, [stark, fern], klares), 1390, presencio).
conoce(lawine, hazania(destruirAlDemonioAura, [frieren], weise), 1393, escucho).
conoce(voll, hazania(destruirAlDemonioAura, [denken], auberst), 1400, leyo(50)).
conoce(serie, hazania(destruirAlReyDemonio, [frieren, himmel, heiter, eisen], ende), 1335, leyo(100)).
conoce(kanne, hazania(recuperarAlGatoPerdido, [frieren, himmel], weise), 1375, presencio).


esRecordada(NombreHazania, Persona, AnioDado):-
    conoce(Persona, hazania(NombreHazania, _, _), AnioQuePresencio, presencio),
    AnioQuePresencio =< AnioDado,
    estaViva(Persona, AnioDado).

esRecordada(NombreHazania, Persona, AnioDado):-
    conoce(Persona, hazania(NombreHazania, _, _), AnioQueEscucho, escucho),
    AnioQueEscucho =< AnioDado,
    AnioDado =< AnioQueEscucho + 15.

esRecordada(NombreHazania, Persona, AnioDado):-
    conoce(Persona, hazania(NombreHazania, _, _), AnioQueLeyo, leyo(Paginas)),
    AnioQueLeyo =< AnioDado,
    AnioDado =< AnioQueLeyo + Paginas.



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


% conmemora(Pueblo, Hazania, FechaDeConmemoracion)

conmemora(weise, hazania(destruirAlReyDemonio, [frieren, himmel, heiter, eisen], ende), diaFestivo(1340)).

conmemora(auberst, hazania(destruirAlReyDemonio, [frieren, himmel, heiter, eisen], ende), estatua(elEquipoDeHeroes, bronce ,1370)).
conmemora(auberst, hazania(destruirASchlatElOmnisciente, [heroeDelSur], ende), estatua(elHeroeDelSur, marmol, 1340)).


mantenimiento(elEquipoDeHeroes, 1400).
mantenimiento(elHeroeDelSur, 1450).


esRecordada(NombreHazania, Persona , AnioDado):-
    habitante(Persona, _, AnioNacimiento, PuebloDondeVive),
    conmemora(PuebloDondeVive, hazania(NombreHazania, _, _), diaFestivo(AnioInicio)),
    
    cuandoConocio(AnioNacimiento, AnioInicio, AnioQueConocio),
    AnioQueConocio =< AnioDado,

    estaViva(Persona, AnioDado).


esRecordada(NombreHazania, Persona , AnioDado):-
    habitante(Persona, _, AnioNacimiento, PuebloDondeVive),
    conmemora(PuebloDondeVive, hazania(NombreHazania, _, _), estatua(NombreEstatua, Material, AnioConstruccion)),
    
    estaEnBuenEstado(NombreEstatua, AnioDado),
    
    cuandoConocio(AnioNacimiento, AnioConstruccion, AnioQueConocio),
    AnioQueConocio =< AnioDado,
    
    estaViva(Persona, AnioDado).


cuandoConocio(AnioNacimiento, AnioInicio, AnioInicio):-
    AnioNacimiento =< AnioInicio.

cuandoConocio(AnioNacimiento, AnioInicio, AnioNacimiento):-
    AnioNacimiento > AnioInicio.


estaEnBuenEstado(NombreEstatua, AnioDado) :-
    conmemora(_, _, estatua(NombreEstatua, marmol, _)),
    mantenimiento(NombreEstatua, AnioMantenimiento),
    AnioMantenimiento =< AnioDado,
    AnioDado - AnioMantenimiento =< 30.

estaEnBuenEstado(NombreEstatua, AnioDado) :-
    conmemora(_, _, estatua(NombreEstatua, marmol, AnioConstruccion)),
    AnioDado - AnioConstruccion=< 30.


estaEnBuenEstado(NombreEstatua, AnioDado) :-
    conmemora(_, _, estatua(NombreEstatua, bronce, _)),
    mantenimiento(NombreEstatua, AnioMantenimiento),
    AnioMantenimiento =< AnioDado,
    AnioDado - AnioMantenimiento =< 15.

estaEnBuenEstado(NombreEstatua, AnioDado) :-
    conmemora(_, _, estatua(NombreEstatua, bronce, AnioConstruccion)),
    AnioDado - AnioConstruccion =< 15.

% Parte 2

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

:- begin_tests(tpIntegrador, []).

% Tests punto 1

test("kanne esta viva en 1370") :-
    estaViva(kanne, 1370).

test("kanne no esta viva en 1300") :-
    not(estaViva(kanne, 1300)).

test("kanne no esta viva en 2000") :-
    not(estaViva(kanne, 2000)).

test("voll esta vivo en 1550") :-
    estaViva(voll, 1550).

test("voll ya no esta vivo en 1551") :-
    not(estaViva(voll, 1551)).

test("serie esta viva en 5000") :-
    estaViva(serie, 5000).

% Tests punto 2

test("Lawine no recuerda destruir al demonio Aura en 1380") :-
    not(esRecordada(destruirAlDemonioAura, lawine, 1380)).

test("Lawine recuerda destruir al demonio Aura en 1400"):-
    esRecordada(destruirAlDemonioAura, lawine, 1400).

test("Lawine ya no recuerda destruir al demonio Aura en 1410"):-
    not(esRecordada(destruirAlDemonioAura, lawine, 1410)).

test("Voll recuerda destruir al demonio Aura en 1450"):-
    esRecordada(destruirAlDemonioAura, voll, 1450).

test("Voll no recuerda destruir al demonio Aura en 1460"):-
    not(esRecordada(destruirAlDemonioAura, voll, 1460)).

test("Wirbel recuerda rescatar a la hermana de wirbel en 1430"):-
    esRecordada(rescatarALaHermanaDeWirbel, wirbel, 1430).

test("Wirbel ya no recuerda rescatar a la hermana de wirbel en 1440"):-
    not(esRecordada(rescatarALaHermanaDeWirbel, wirbel, 1440)).   

test("rescatar a la hermana de Wirbel es una hazaña corroborada"):-
    estaCorroborada(rescatarALaHermanaDeWirbel).

test("destruir al demonio Aura no es una hazaña corroborada"):-
    not(estaCorroborada(destruirAlDemonioAura)).

test("destruir al demonio Aura pasó al olvidó en 1460"):-
    pasoAlOlvido(destruirAlDemonioAura, 1460).

test("destruir al demonio Aura no pasó al olvidó en 1440"):-
    not(pasoAlOlvido(destruirAlDemonioAura, 1400)).


% Tests punto 3


test("Lawine recuerda destruir al rey demonio en 1400"):-
    esRecordada(destruirAlReyDemonio, lawine, 1400).

test("Lawine no recuerda destruir al rey demonio en 1390"):-
    not(esRecordada(destruirAlReyDemonio, lawine, 1390)).

test("Fern recuerda destruir al rey demonio en 1400"):-
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

test("Weise no vive tiempos sin precedentes en 1400"):-
    estaViviendoTiemposSinPrecedentes(weise, 1400).


:- end_tests(tpIntegrador).
