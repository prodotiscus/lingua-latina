#!/usr/bin/python3
from regexp import *
tl = {
    'en' : {
        r'Прилагательное 1 - 2 склонений' : 'First-second declension adjective',
        r'Прилагательное 3 склонения трёх окончаний' : 'Third declension, masculine nominative singular in -er, neuter in -e',
        r'Прилагательное 3 склонения двух окончаний' : 'Third declension, neuter nominative singular in -e',
        r'Прилагательное 3 склонения одного окончания' : 'Third declension, neuter nominative singular like masculine/feminine',
        r'ПАДЕЖ': 'CASE',
        r'РОД': 'GENDER',
        r'МУЖСКОЙ': 'MASCULINE',
        r'ЖЕНСКИЙ': 'FEMININE',
        r'СРЕДНИЙ': 'NEUTER'
    },
    'de' : {
        r'Прилагательное 1 - 2 склонений': 'Adjektiv der ersten - zweiten Deklination',
        r'Прилагательное 3 склонения трёх окончаний': 'Dritte Deklination, Masculinum Nominativ Singular in -er, Neuterum in -e',
        r'Прилагательное 3 склонения двух окончаний': 'Dritte Deklination, Neutrum Singular Nominativ in -e',
        r'Прилагательное 3 склонения одного окончания': 'Dritte Deklination, Neutrum Singular Nominativ ist für alle Geschlechten identisch',
        r'ПАДЕЖ': 'KASUS',
        r'РОД': 'GESCHLECHT',
        r'МУЖСКОЙ': 'MASKULINUM',
        r'ЖЕНСКИЙ': 'FEMININUM',
        r'СРЕДНИЙ': 'NEUTRUM'
    },
    'la' : {
            r'Прилагательное 1 - 2 склонений': 'Adjectivum declinationis primae-secundae',
            r'Прилагательное 3 склонения трёх окончаний': 'Declinatio tertia, numerus singularis generis masculini nominativi cum -er, generis neutri cum -e',
            r'Прилагательное 3 склонения двух окончаний': 'Declinatio tertia, numerus singularis generis neutri cum -e',
            r'Прилагательное 3 склонения одного окончания': 'Declinatio tertia, finis <i>(ending)</i> est pro omnibus generibus equalis',
            r'ПАДЕЖ': 'CASUS',
            r'РОД': 'GENUS',
            r'МУЖСКОЙ': 'MASCULINUM',
            r'ЖЕНСКИЙ': 'FEMININUM',
            r'СРЕДНИЙ': 'NEUTERUM'
        }    
}
def translate(html, lang):
    global tl
    if lang != 'ru':
        for t in tl[lang]:
            html = r(html).s(t, tl[lang][t])
    return html