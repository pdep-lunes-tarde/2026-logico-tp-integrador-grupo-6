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

:- end_tests(tpIntegrador).
