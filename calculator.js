var log = [];
var expected = "13472611";
var expectedLog = "(1((3)4(7))2)6(11) 0\n1((3)4(7))2 1\n(3)4(7) 2\n3 3\n7 3\n11 1"
console.log("Result 1 equals expected: " + (parse("(1((3)4(7))2)6(11)",0,log).result == expected));
console.log("Log 1 equals expected: " + (log.join('\n') == expectedLog));

log = [];
expected = "4735296";
expectedLog = "4(7(3(5)(2)(9(6)))) 0\n7(3(5)(2)(9(6))) 1\n3(5)(2)(9(6)) 2\n5 3\n2 3\n9(6) 3\n6 4"
console.log("Result 2 equals expected: " + (parse("4(7(3(5)(2)(9(6))))",0,log).result == expected));
console.log("Log 2 equals expected: " + (log.join('\n') == expectedLog));

log = [];
expected = 4*7+3-5-2/9*6;
expectedLog = "4*(7+(3-(5)-(2)/(9*(6)))) 0\n7+(3-(5)-(2)/(9*(6))) 1\n3-(5)-(2)/(9*(6)) 2\n5 3\n2 3\n9*(6) 3\n6 4"
console.log("Result 2 equals expected: " + (parse("4*(7+(3-(5)-(2)/(9*(6))))",0,log).result == expected));
console.log("Log 2 equals expected: " + (log.join('\n') == expectedLog));


function parseParen(query,depth,outputLog){

outputLog.push(query+" "+depth);

//parentheses parser
var parenCount = 0;
var parenStart = 0;
for(var i = 0; i < query.length; i++){
	if(query.charAt(i) == "("){
		parenCount++;
		if(parenCount == 1) parenStart = i+1;//don't include character at i in slice
	}
	if(query.charAt(i) == ")"){
		parenCount--;
		if(parenCount == 0){
			//send text inside parentheses to be eval'd
			var result = parse(query.slice(parenStart,i),depth + 1, outputLog);
			if(!result.success) return result;
			//replace text from open parenthesis to close parenthesis (inclusive)
			query = query.slice(0,parenStart - 1) + result.result + query.slice(i + 1);
			//(i + 1) - ( parenStart - 1 ) is the length of the text that was replaced
			i = i - ( ( (i + 1) - ( parenStart - 1 ) ) - result.result.length );//adjust i to point to last character of replacement text
			//test case 1 found error that subtracting 1 from parenStart fixed
			//test case 2 found error that adding 1 to i fixed
		}
		else if(parenCount == -1)
		{
			return { success: false };
		}
	}
}
return { success: true, result: query };

}

function parse(query,depth,outputLog){
	result = parseParen(query,depth,outputLog);
	query = result.result;
	var params = query.split(/[\+\-\/\*]/g);
	var operators = query.match(/[\+\-\/\*]/g);
	var nextParams = [];
	var nextOperators = [];
	if(operators != null){
		console.log(query);
		console.log(params);
		console.log(operators);
		for(var i = 0; i < operators.length; i++){
			if(operators[i]=="*"){
				params[i+1] = parseFloat(params[i],10)*parseFloat(params[i+1],10);
			}
			else if(operators[i]=="/"){
				params[i+1] = parseFloat(params[i],10)/parseFloat(params[i+1],10);
			}
			else{
				nextParams.push(params[i]);
				nextOperators.push(operators[i]);
			}
		}
		nextParams.push(params[params.length - 1]);
		params = nextParams;
		operators = nextOperators;
		console.log(params);
		console.log(operators);
		for(var i = 0; i < operators.length; i++){
			if(operators[i]=="+"){
				params[i+1] = parseFloat(params[i],10)+parseFloat(params[i+1],10);
			}
			else if(operators[i]=="-"){
				params[i+1] = parseFloat(params[i],10)-parseFloat(params[i+1],10);
			}
		}
		console.log(params);
		console.log(operators);
		result.result = params[params.length - 1].toString();
	}
	return result;
}