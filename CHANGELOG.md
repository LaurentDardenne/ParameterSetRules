﻿2017-08-28    Version 1.0.0
 Add rules :
   Measure-ParameterNameShouldBePascalCase 
   Measure-AvoidPluralNameForParameter
   AvoidUsingMandoryParameterWithDefaultValue,
   MissingArgumentToManageIncomingPipelineObject 
   MissingProcessBlock
 
 Remove rule UsePascalCaseForParameterName  (The Measure-ParameterNameShouldBePascalCase rule covers these cases)

 Change the dependency on the PSScriptAnalyzer module to the version 1.16.0
 Change the dependency on the Log4Posh module to the version 2.2.0 (only for the development)

2016-09-29    Version 0.4.0
Fix the type of Ast (FunctionDefinitionAst to ScriptBlockAst)

2016-09-25    Version 0.3.0
Change the dependency on the Log4Posh module to the version 2.0.0 (only for the development)
Change the name of the rules

2016-08-21    Version 0.2.0.0
Add rule 'Measure-DetectingErrorsInParameterList' and tests

2016-08-21    Version 0.1.0.0
Original version