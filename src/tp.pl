% Parte 1: empleados.

contador(roque).
honesto(roque).
honesto(ana).
ambicioso(roque).
ingeniero(ana).
abogado(cecilia).

trabajoEn(roque,utn).
trabajoEn(cecilia,utn).

puedeAndar(Empleado,contaduria):-
    honesto(Empleado),contador(Empleado).
puedeAndar(Empleado,ventas):-
    ambicioso(Empleado),tieneExperiencia(Empleado).
puedeAndar(lucia,ventas).

tieneExperiencia(Empleado):-trabajoEn(Empleado,_).

% Parte 2: el asesinato de Tia Agatha.

viveEnMansion(agatha).
viveEnMansion(carnicero).
viveEnMansion(charles).

odiaA(agatha, Persona):-
    viveEnMansion(Persona), 
    Persona \= carnicero.
odiaA(charles, Persona):-
    viveEnMansion(Persona), 
    not(odiaA(agatha, Persona)).
odiaA(carnicero, Persona):-
    odiaA(agatha, Persona).

masRicoQueAgatha(P):-
    viveEnMansion(P), 
    not(odiaA(carnicero, P)).

asesino(Victima, Asesino):-
    odiaA(Asesino, Victima), 
    viveEnMansion(Asesino), 
    not(masRicoQueAgatha(Asesino)).

% Tests

:- begin_tests(tp1).

test(un_contador_honesto_puede_trabajar_en_contaduria, nondet):-
    puedeAndar(roque, contaduria).
test(alguien_ambicioso_con_experiencia_puede_trabajar_en_ventas, nondet):-
    puedeAndar(roque, contaduria).
test(alguien_honesto_que_no_es_contador_no_puede_trabajar_en_contaduria, nondet):-
    not(puedeAndar(ana, contaduria)).
test(alguien_sin_experiencia_no_puede_trabajar_en_ventas, nondet):-
    not(puedeAndar(ana, ventas)).

test(agatha_odia_a_charles, nondet):-
    odiaA(agatha,charles).
test(el_carnicero_no_se_odia_a_mismo, nondet):-
    not(odiaA(carnicero,carnicero)).
test(el_carnicero_es_mas_rico_que_agatha):-
    masRicoQueAgatha(carnicero).

:- end_tests(tp1).
