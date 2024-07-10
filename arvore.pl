% Nome: Rodrigo Cabral DIniz
% RA: 2022.1.08.037

:- dynamic arvore_atual/1.

% Predicado para inserir um nó na árvore
inserir(Info, null, no(Info, null, null)).
inserir(Info, no(Raiz, Esq, Dir), no(Raiz, EsqRes, Dir)) :-
    Info < Raiz,
    inserir(Info, Esq, EsqRes).
inserir(Info, no(Raiz, Esq, Dir), no(Raiz, Esq, DirRes)) :-
    Info > Raiz,
    inserir(Info, Dir, DirRes).

% Predicado para remover um nó da árvore
remover(Info, null, null).
remover(Info, no(Info, null, null), null).
remover(Info, no(Info, null, Dir), Dir).
remover(Info, no(Info, Esq, null), Esq).
remover(Info, no(Info, Esq, Dir), no(Menor, Esq, DirRes)) :-
    remover_menor(Dir, Menor, DirRes).
remover(Info, no(Raiz, Esq, Dir), no(Raiz, EsqRes, Dir)) :-
    Info < Raiz,
    remover(Info, Esq, EsqRes).
remover(Info, no(Raiz, Esq, Dir), no(Raiz, Esq, DirRes)) :-
    Info > Raiz,
    remover(Info, Dir, DirRes).

% Predicado auxiliar para remover o menor nó da árvore
remover_menor(no(Info, null, Dir), Info, Dir).
remover_menor(no(Raiz, Esq, Dir), Menor, no(Raiz, EsqRes, Dir)) :-
    remover_menor(Esq, Menor, EsqRes).

% Predicado para fazer travessia em ordem pré
pre_ordem(null).
pre_ordem(no(Info, Esq, Dir)) :-
    write(Info), write(' '),
    pre_ordem(Esq),
    pre_ordem(Dir).

% Predicado para fazer travessia em ordem
em_ordem(null).
em_ordem(no(Info, Esq, Dir)) :-
    em_ordem(Esq),
    write(Info), write(' '),
    em_ordem(Dir).

% Predicado para fazer travessia em ordem pós
pos_ordem(null).
pos_ordem(no(Info, Esq, Dir)) :-
    pos_ordem(Esq),
    pos_ordem(Dir),
    write(Info), write(' ').

% Predicado para ler opção e realizar operações
menu :-
    repeat,
    write('Escolha uma opção:'), nl,
    write('1-Inserir, 2-Apagar, 3-Pre-ordem, 4-Em-ordem, 5-Pos-ordem, E-Fim'), nl,
    read(Op),
    (Op == 1 ->
        write('Digite o valor a ser inserido:'), nl,
        read(Valor),
        arvore_atual(Arvore),
        inserir(Valor, Arvore, NovaArvore),
        retractall(arvore_atual(_)),
        assertz(arvore_atual(NovaArvore)),
        nl,
        fail;
    Op == 2 ->
        write('Digite o valor a ser removido:'), nl,
        read(Valor),
        arvore_atual(Arvore),
        remover(Valor, Arvore, NovaArvore),
        retractall(arvore_atual(_)),
        assertz(arvore_atual(NovaArvore)),
        nl,
        fail;
    Op == 3 ->
        write('Travessia em Pre-ordem: '), nl,
        arvore_atual(Arvore),
        pre_ordem(Arvore), nl,
        fail;
    Op == 4 ->
        write('Travessia em Em-ordem: '), nl,
        arvore_atual(Arvore),
        em_ordem(Arvore), nl,
        fail;
    Op == 5 ->
        write('Travessia em Pos-ordem: '), nl,
        arvore_atual(Arvore),
        pos_ordem(Arvore), nl,
        fail;
    Op == e ->
        write('Fim do programa.'), nl, !;
    write('Opção inválida, tente novamente.'), nl,
    fail).

% Inicialização do programa com uma árvore inicial
inicializa :-
    inserir(10, null, A1),
    inserir(5, A1, A2),
    inserir(15, A2, A3),
    inserir(3, A3, A4),
    inserir(8, A4, A5),
    inserir(12, A5, A6),
    inserir(18, A6, A7),
    inserir(1, A7, A8),
    inserir(4, A8, A9),
    inserir(9, A9, ArvoreFinal),
    assertz(arvore_atual(ArvoreFinal)),
    menu.

:- initialization(inicializa).
