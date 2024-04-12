module Parser

import AbstractSyntax;
import ConcreteSyntax;
import ParseTree;

AbstractSyntax::Expression load(Tree t) = implode(#AbstractSyntax::Expression,t);
Tree parseExp(str txt) = parse(#ConcreteSyntax::Expression, txt);