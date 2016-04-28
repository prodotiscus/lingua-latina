#!/usr/bin/python3
# -*- coding: UTF-8 -*-
import cgi, cgitb, sys, codecs, dictionary, translate
import http.cookies
from regexp import *
params = cgi.FieldStorage()
print("Content-Type: text/html; charset=utf-8")
print()
#
if not 'dict' in params:
    word = params['word'].value
else:
    try:
        word = dictionary.search(params['word'].value)[int(params['i'].value)]
    except KeyError:
        word = dictionary.search(params['word'].value)[0]
lang = params['lang'].value
#
def declination(word):
        decl = ''
        endings = {
           '1' : r',\s\w*a,\s\w*um$',
           '3a' : r',\s\w+,\s\w+$',
           '3b' : r'^\w+,\se$',
           '3c' : r'^\w+,\s\w*is$'
        }
        declinations = '1 3a 3b 3c'.split()
        for declination in declinations:
            if r(word).c(endings[declination]) and decl == '':
                decl = declination
        return [decl, 'non-adjective'][decl == '']
def formate(word, decl):
        forms = {}
        endings = r(word).split(r',\s')
        if decl == '1' and r(endings[0]).c('us$'):
            forms['m'] = endings[0]
            common = r(forms['m']).s(r'.{2}$', '')
            forms['f'] = common + endings[1]
            forms['n'] = common + endings[2]
        elif decl == '1' and indexOf(endings[1:], r'[^euioa]{2}'):
            forms['m'] = endings[0]
            common = r(forms['m']).s(r'.{3}$', '')
            forms['f'] = common + endings[1]
            forms['n'] = common + endings[2]
        elif decl == '1':
            forms['m'] = endings[0]
            common = r(forms['m']).s(r'.{2}$', '')
            forms['f'] = common + endings[1]
            forms['n'] = common + endings[2]
        elif decl == '3a' and indexOf(endings[1:], r'[^euioa]{2}'):
            forms['m'] = endings[0]
            common = r(forms['m']).s(r'.{3}$', '')
            forms['f'] = common + endings[1]
            forms['n'] = common + endings[2]
        elif decl == '3a' and (indexOf(endings[1:], r'[^euioa]{2}') or indexOf(endings[1:], r'is$')):
            forms['m'] = endings[0]
            common = r(forms['m']).s(r'.{2}$', '')
            forms['f'] = common + endings[1]
            forms['n'] = common + endings[2]
        elif decl == '3b':
            forms['mf'] = endings[0]
            forms['n'] = r(endings[0]).s(r'is$', 'e')
        elif decl == '3c':
            (nom, gen) = endings
            forms['gen'] = endings[0]
            endings[1] = r(endings[1]).s(r'is$', '')
            sc = str(len(endings[1]))
            #print('.{' + sc + '}$') #DEBUG
            forms['gen'] = r(forms['gen']).s('.{' + sc + '}$', '')
            forms['gen'] += gen
            forms['nom'] = nom
        return forms
decl = declination(word)
forms = formate(word, decl)
if decl == '1':
        sg = forms['m']
        (m, f, n) = (r(forms['m']).s('us$', ''), r(forms['f']).s('a$', ''), r(forms['n']).s('um$', ''))
        pcon = open('../adj/1.html', 'r', encoding='utf-8').read().format(m, f, n, sg)
        pcon = translate.translate(pcon, lang)
        print(pcon)
elif decl == '3a':
        sg = r(forms['m']).s(r'(?<=[^euioa]).$', 'er')
        (m, f, n) = (forms['m'], r(forms['f']).s(r'is$', ''), r(forms['n']).s(r'e$', ''))
        pcon = open('../adj/3a.html', 'r', encoding='utf-8').read().format(m, f, n, sg)
        pcon = translate.translate(pcon, lang)
        print(pcon)
elif decl == '3b':
        sg = forms['mf']
        (mf, n) = (r(forms['mf']).s(r'is$',''), r(forms['n']).s('e$', ''))
        pcon = open('../adj/3b.html', 'r', encoding='utf-8').read().format(mf, n, sg)
        pcon = translate.translate(pcon, lang)
        print(pcon)
elif decl == '3c':
        sg = forms['nom']
        gen = r(forms['gen']).s('is$', '')
        pcon = open('../adj/3c.html', 'r', encoding='utf-8').read().format(sg, gen)
        pcon = translate.translate(pcon, lang)
        print(pcon)