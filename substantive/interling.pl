#!/usr/bin/perl
no warnings 'layer';
use utf8;
use Data::Dumper;
our %en = (
    'Склонение первое' => 'First declension',
    'Склонение второе' => 'Second declension',
    ', согласный тип' => '',
    ', смешанный тип' => ', i-stem',
    ', гласный тип' => ', "pure" i-stem',
    'Склонение четвёртое' => 'Fourth declension',
    'Склонение пятое' => 'Fifth declension',
    'Склонение третье' => 'Third declension',
    ', средний род' => ' neuter',
    'исключение' => 'exception',
    'ПАДЕЖИ' => 'CASE',
    'Не удалось просклонять слово' => 'The word could not be declined',
    'Возможно, Вы допустили ошибку при вводе слова или ввели не существительное, а другую часть речи' => 'Maybe you had a mistake by entering word or another part of speech was entered',
    'Указанное слово содержит недопустимые символы' => 'The word contains illegal characters'
);
our %de = (
    'Склонение первое' => 'Erste Deklination',
    'Склонение второе' => 'Zweite Deklination',
    ', согласный тип' => '',
    ', смешанный тип' => ', gemischt',
    ', гласный тип' => ', i-Deklination',
    'Склонение четвёртое' => 'Vierte Deklination',
    'Склонение пятое' => 'Fünfte Deklination',
    'Склонение третье' => 'Dritte Deklination',
    ', средний род' => ' neutrum',
    'исключение' => 'Ausnahme',
    'ПАДЕЖИ' => 'KASUS',
    'Не удалось просклонять слово' => 'Das Wort kann nicht dekliniert sein',
    'Возможно, Вы допустили ошибку при вводе слова или ввели не существительное, а другую часть речи' => 'Vielleicht, haben Sie ein Fehler beim Eingeben des Wortes gemacht oder eine andere Wortart eingegeben',
    'Указанное слово содержит недопустимые символы' => 'Eingegebenes Wort enthält unerlaubte Symbole'
);
our %la = (
    'Склонение первое' => 'Declinatio prima',
    'Склонение второе' => 'Declinatio secunda',
    ', согласный тип' => '',
    ', смешанный тип' => ', declinatio in -i-',
    ', гласный тип' => ', declinatio in -i-',
    'Склонение четвёртое' => 'Declinatio quarta',
    'Склонение пятое' => 'Declinatio quinta',
    'Склонение третье' => 'Declinatio tertia',
    ', средний род' => ' neutrum',
    'исключение' => 'Exclusio',
    'ПАДЕЖИ' => 'CASUS',
    'Не удалось просклонять слово' => 'Verbum declinari non potest',
    'Возможно, Вы допустили ошибку при вводе слова или ввели не существительное, а другую часть речи' =>
    'Possible lapsum fecisti aut aliam orationis partem induxisti',
    'Указанное слово содержит недопустимые символы' => 'Hoc verbum symbola inconcessibilia continet'
);