#!/usr/bin/python3
# -*- coding: UTF-8 -*-
from regexp import *
def search(word):
    letter = r(word).m('^\w')[0].lower()
    content = open('../dictionary/common/{0}.txt'.format(letter), 'r', encoding='utf-8').read()
    matches = r(content).m(r'(?<=\n)' + word + r'\s+\|\s+.*')
    ret = []
    for m in matches:
        ret.append(remove_special_chars(m))
    return ret
def remove_special_chars(word):
    word = r(word).s('ā','a').s('ē','e').s('ī','i').s('ō','o').s('ū','u')
    word = r(word).s(r'[йцукенгшщзхъфывапролджэячсмитьбю](\s|\.|)', '')
    word = r(word).s(r'^.*\|', '')
    word = r(word).s(r'(I|II|III|IV|V|VI|VII|VIII)\s+', '')
    word = r(word).s(r'^\s*|\s*$', '')
    word = r(word).s(r'(?<!,)\s+\w{1,}(\.|)$', '')
    return word