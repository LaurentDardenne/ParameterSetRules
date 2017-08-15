ConvertFrom-StringData @'
# English strings
  # Measure-DetectingErrorsInDefaultParameterSetName
W_DpsNotDeclared={0} : DefaultParameterSetName is not declared. 
I_PsnRedundant={0} : The statement of parameter set name is redundant because one single parameter set name was found.
W_DpsAvoid_AllParameterSets_Name={0} : Avoid to use '__AllParameterSets' as name of a parameter set.
I_DpsUnnecessary={0} : The single declaration of default parameter set name is unnecessary (see attribute [CmdletBinding]).
W_DpsInused={0} : The default parameter set name does not refer to a existing parameter set name.  
E_CheckPsnCaseSensitive={0} : The parameter set names are case sensitive, conflicts were detected : {1}

  # Measure-DetectingErrorsInParameterList
W_PsnUnnecessaryParameterAttribut={0} : The parameter '{1}' declare an unnecessary ParameterAttribut.
W_PsnParametersMustBeginByZeroOrOne={0} : '{1}' The positions of parameters must begin by zero or one: {2}
E_PsnPositionsAreNotSequential={0} : The ParameterSet '{1}' contains positions which are not sequential: {2}
E_PsnMustHavePositivePosition={0} : In the ParameterSet '{1}', the parameter '{2}' must have a positive position ({3})
E_PsnDuplicatePosition={0} : The ParameterSet '{1}' contains duplicate position {2} for the parameters {3}
E_ConflictDuplicateParameterAttribut={0} : Conflict detected for parameter '{1}' in the parameterset '{2}': an attribute [Parameter()] can not be duplicated or contain contradictory statements.

  # Measure-AvoidPluralNameForParameter
I_ParameterNameUsePlural=The parameter name '{0}' use plural. Change to singular '{1}'.
  
  # Measure-ParameterNameShouldBePascalCase
I_UsePascalCaseForParameterName=The parameter name '{0}' dot not use the Pascal case namming convention. In other words, capitalize the first letter of each word in the parameter name, including the first letter of the name.
'@
