
% Parte 1

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



% Parte 2

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


% parte 3 

% diaFestivo(Pueblo, Hazania, AnioInicio).

diaFestivo(weise, destruirReyDemonio, 1340).

% estatua(Pueblo, Nombre, Material, Hazania, AnioConstruccion).

estatua(auberst, "el equipo de heroes", bronce, destruirReyDemonio, 1370).
estatua(auberst, "el heroe del sur", marmol, destruirSchlatOmnisciente, 1340).

% mantenimiento(NombreEstatua, Anio).

mantenimiento("el equipo de heroes", 1400).
mantenimiento("el equipo de heroes", 1450).

mantenimiento("el heroe del sur", 1410).







:- begin_tests(tpIntegrador, []).

% Tests parte 1

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

% Tests parte 2

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




:- end_tests(tpIntegrador).
