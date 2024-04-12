module Main

import IO;
// import String;

// import ConcreteSyntax;

import vis::Text;
import Parser;
// import Data;

int main(int testArgument=0) {

    str declaration = ";";
    str expression = "foo + 3;";
    str statement = "console.log(foo);";
    str block = "{ let foo = 3; console.log(foo); }";
    str ifStatement = "if (foo) { console.log(foo); } else { console.log(foo); }";
    str whileStatement = "while (foo) { console.log(foo); }";
    str forStatement = "for (let i = 0; i \< 10; i++) { console.log(i); }";
    str returnStatement = "return foo;";
    str functionDeclaration = "let foo = function () { let bar = 4; return 4; }";
    str classDeclaration = "class foo { add() { return 4+3;} }";
    str tryStatement = "try { let foo = 3; } catch(e) { console.error(e); }";
    str throwStatement = "throw new Error(\"foo\");";
    str importStatement = "import foo from \"bar\";";



    declarationTree = Parser::parseExp(declaration);


    return testArgument;
}