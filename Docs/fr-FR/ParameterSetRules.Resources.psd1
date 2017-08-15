ConvertFrom-StringData @'
# French strings
   # Measure-DetectingErrorsInDefaultParameterSetName
W_DpsNotDeclared={0} : L'attribut [CmdletBinding] ne déclare pas sa propriété 'DefaultParameterSetName'. 
I_PsnRedundant={0} : Les instructions de nom de jeux de paramètres sont redondantes, car il n'existe qu'un seul jeu.
W_DpsAvoid_AllParameterSets_Name={0} : Evitez d'utiliser '__AllParameterSets' pour un nom de jeu de paramètres.
I_DpsUnnecessary={0} : La déclaration unique du nom de jeu de paramètre par défaut est inutile (cf. attribut [CmdletBinding]).
W_DpsInused={0} : Le nom du jeu de paramètre par défaut ne référence aucun des noms de jeu de paramètres existant.
E_CheckPsnCaseSensitive={0} : Les nom de jeux de paramètres sont sensibles à la casse, un conflit a été détecté : {1}

  # Measure-DetectingErrorsInParameterList
W_PsnUnnecessaryParameterAttribut={0} : Le paramètre '{1}' déclare un attribut [Parameter()] inutile.
W_PsnParametersMustBeginByZeroOrOne={0} : '{1}' la position des paramètres doit débuter par zéro ou un : {2}
E_PsnPositionsAreNotSequential={0} : Le jeu de paramètres '{1}' contient des nombres de positions qui ne forment pas une suite ordonnées : {2}
E_PsnMustHavePositivePosition={0} : Dans le jeu de paramètres '{1}', le paramètre '{2}' doit avoir un position positive ({3})
E_PsnDuplicatePosition={0} : Le jeu de paramètres '{1}' contient une ou des positions dupliquées {2} pour les paramètres {3}
E_ConflictDuplicateParameterAttribut={0} : Conflit détecté pour le paramètre '{1}' dans le jeu '{2}' : un attribut [Parameter()] ne peut être dupliqué ou contenir des déclarations contradictoires.

  # Measure-AvoidPluralNameForParameter
I_ParameterNameUsePlural=Le nom du paramètre '{0}' est au pluriel. Utilisez le singulier '{1}'.
  
  # Measure-ParameterNameShouldBePascalCase
I_UsePascalCaseForParameterName=Le nom du paramètre '{0}' n'utilse pas la conventio de nommage Pascal Case. En d'autres termes, la première lettre de chaque mot constituant le nom du paramètre doit être en majuscule, y compris la première lettre du nom.
'@
