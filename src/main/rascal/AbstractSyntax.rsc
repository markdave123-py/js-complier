module AbstractSyntax extend ConcreteSyntax;

data KeyValuePairs = keyValue(Expression name, Expression val);
data ClassProperty =
    classAttribute(str AttributeName, Expression AttributeValue)
    | classAttribute(str AttributeName)
    | classConstructor(list[Expression] constructorArguments, FunctionExpression constructorBody)
    | classMethod(str methodName, list[Expression] methodArguments, FunctionExpression methodBody)

    ;

    data FunctionExpression =
    expression(Expression)
    | \return(Expression expression)
    ;

data Expression
    = let(Expression lhs, Expression rhs)
    | \const(Expression lhs, Expression rhs)
    | \switch(Expression switchVariable, list[SwitchStatement] switchCases)
    | condition(Expression condition, Expression then, Expression \else)
    | blockExpression(Expression blockBody)
    | variable(str name)
    | integerLiteral(int integerLiteral)
    | floatLiteral(real floatLiteral)
    | string(str string)
    | \import(Expression defaultModule, str importPath)
    | \import(list[Expression] importModules, str importPath)
    | \import(Expression defaultModule, list[Expression] importModules, str importPath)
    | \list(list[Expression] items)
    | object(list[KeyValuePairs] pairs)
    | property(Expression variable, Expression prop)
    | member(Expression variable, Expression mem)
    | \return(Expression expression)
    | tryCatch(Expression tryBlock, Expression exceptionVariable, Expression catchBlock )
    | tryCatch(Expression tryBlock,  Expression catchBlock )
    | new(Expression expression)
    | class(Expression className, list[Expression] baseClasses, ClassProperty classBody)
    | class(Expression className, ClassProperty classBody)
    | \function(Expression functionName, list[Expression] functionArguments, Expression FunctionBody)
    | \function(list[Expression] functionArguments, Expression FunctionBody)
    | arrowFunction(list[Expression] arrowFunctionArguments, Expression arrowFunctionBody)
    | \for(Expression forInitializer, Expression forCondition, Expression forIncrement, Expression forBody)
    | \while(Expression whileCondition, Expression whileBody)
    | doWhile(Expression doBody, Expression doCondition)
    | \forIn(Expression forInVariable, Expression forInObject, Expression forInBody)
    | \forOf(Expression forOfVariable, Expression forOfObject, Expression forOfBody)
    | mul(Expression lhs, Expression rhs)
    | div(Expression lhs, Expression rhs)
    | add(Expression lhs, Expression rhs)
    | sub(Expression lhs, Expression rhs)
    | gt(Expression lhs, Expression rhs)
    | lt(Expression lhs, Expression rhs)
    | geq(Expression lhs, Expression rhs)
    | leq(Expression lhs, Expression rhs)
    | eq(Expression lhs, Expression rhs)
    | neq(Expression lhs, Expression rhs)
    | and(Expression lhs, Expression rhs)
    | or(Expression lhs, Expression rhs)
    | not(Expression expression)
    | assign(Expression lhs, Expression rhs)
    | addAssign(Expression lhs, Expression rhs)
    | subAssign(Expression lhs, Expression rhs)
    | mulAssign(Expression lhs, Expression rhs)
    | divAssign(Expression lhs, Expression rhs)
    | modAssign(Expression lhs, Expression rhs)

    | sequence(Expression first, Expression second)
    // | line(Expression expression)
    | increment(Expression expression)
    | decrement(Expression expression)
    | call(Expression function, list[Expression] arguments)

    ;


data SwitchStatement =
     switchCase(Expression caseValue, Expression caseBody)
    | defaultCase(Expression defaultBody)
;


// data Binding = binding(str variable, Expression expression);