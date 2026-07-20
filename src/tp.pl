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





















:- begin_tests(tpIntegrador, []).


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


:- end_tests(tpIntegrador).
