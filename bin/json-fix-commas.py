#!/usr/bin/python

import ply.lex
import ply.yacc
import sys

tokens = ["STRING", "OPENBRACE", "CLOSEBRACE", "OPENBRACKET", "CLOSEBRACKET",
          "COLON", "COMMA", "WS"]

t_STRING = r'\s*("([^"\\]|\\.)*"|\w+)'
t_OPENBRACE = "\s*{"
t_CLOSEBRACE = "\s*}"
t_OPENBRACKET = "\s*\["
t_CLOSEBRACKET = "\s*\]"
t_COLON = "\s*:"
t_COMMA = "\s*,"
t_WS = "\s+"

def t_error(t):
    raise Exception('Illegal character "%s"' % t.value[0])

def p_error(p):
    if p:
        raise Exception('Syntax error at "%s", %s' % (p.value, p.lexpos))
    else:
        raise Exception("Syntax error at EOF")

def p_start(p):
    """
    start : object
          | object WS
    """
    p[0] = "".join(p[1:])

def p_object(p):
    """
    object : OPENBRACE pairs maybetrailingcomma CLOSEBRACE
           | OPENBRACKET objects maybetrailingcomma CLOSEBRACKET
           | STRING
"""
    p[0] = "".join(p[1:])

def p_maybetrailingcomma(p):
    """
    maybetrailingcomma : COMMA
                       |
    """
    p[0] = ""

def p_objects(p):
    """
    objects : object
            | objects COMMA object
            |
    """
    p[0] = "".join(p[1:])

def p_pairs(p):
    """
    pairs : STRING COLON object
          | pairs COMMA STRING COLON object
          | 
    """
    p[0] = "".join(p[1:])

lexer = ply.lex.lex()
ply.yacc.yacc(debug=0, write_tables=0)

if __name__ == "__main__":
    sys.stdout.write(ply.yacc.parse(sys.stdin.read()))
