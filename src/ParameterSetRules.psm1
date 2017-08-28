Import-LocalizedData -BindingVariable RulesMsg -Filename ParameterSetRules.Resources.psd1 -EA Stop
                                      
#<DEFINE %DEBUG%> 
#todo :  Function Measure-DetectingErrorsInOutputAttribut
#        bug OutputType : https://github.com/PowerShell/PowerShell/issues/2935

#todo DynamicParamBlock

#todo bug PSScriptAnalyzer (IPMO  et Add-Type): https://github.com/PowerShell/PSScriptAnalyzer/issues/599
#todo bug ps v4,5,6 (PSN +Position) : https://github.com/PowerShell/PowerShell/issues/2212#issuecomment-257989424

#note : https://github.com/PowerShell/PSScriptAnalyzer/issues/396
#régle 1 :  annulée, PascalCase gére ces cas là

#régle 12 : Support Input from the Pipeline : In each parameter set for a cmdlet, include at least one parameter that supports input from the pipeline

#régle 15 : TODO Parameters That Take True and False : les types boolean sont à remplacer par le type switch

#Recommendations : 
#régle 11 : Use Strongly-Typed .NET Framework Types: Parameters should be defined as .NET Framework types to provide better parameter validation.

#régle 13 : nommage des paramètre utilisant un nom de variable automatique : 
# https://github.com/PowerShell/PowerShell/issues/3061#issuecomment-275776552

Import-module Log4Posh

$Script:lg4n_ModuleName=$MyInvocation.MyCommand.ScriptBlock.Module.Name

  #This code create the following variables : $script:DebugLogger, $script:InfoLogger, $script:DefaultLogFile
$InitializeLogging=[scriptblock]::Create("${function:Initialize-Log4NetModule}")
$Params=@{
  RepositoryName = $Script:lg4n_ModuleName
  XmlConfigPath = "$psScriptRoot\ParameterSetRulesLog4Posh.Config.xml"
  DefaultLogFilePath = "$psScriptRoot\Logs\${Script:lg4n_ModuleName}.log"
}
&$InitializeLogging @Params
#<UNDEF %DEBUG%>   

$DebugLogger.PSDebug("-- LoadModule --") #<%REMOVE%>

[string[]]$script:CommonParameters=[System.Management.Automation.Internal.CommonParameters].GetProperties().Names

$script:CommonParametersFilter= { $script:CommonParameters -notContains $_.Name}

$script:PositionDefault=[int]::MinValue
$script:SharedParameterSetName='__AllParametersSet'
$script:isSharedParameterSetName_Unique=$false


$script:Helpers=[Microsoft.Windows.PowerShell.ScriptAnalyzer.Helper]::new($MyInvocation.MyCommand.ScriptBlock.Module.SessionState.InvokeCommand,$null)

Add-Type -AssemblyName System.Data.Entity.Design,System.Globalization
$script:PluralSrvc =[System.Data.Entity.Design.PluralizationServices.PluralizationService]::CreateService(([System.Globalization.CultureInfo]::GetCultureInfo("en-us")))

#<DEFINE %DEBUG%>
function TraceHeader {
  param($Name)
   $DebugLogger.PSDebug("$('-'*40)") 
   $DebugLogger.PSDebug($Name)
}
#<UNDEF %DEBUG%> 
Function NewCorrectionExtent{
 param (
   $Extent,
   
    [ValidateNotNullOrEmpty()]
   $Text,
    [ValidateNotNullOrEmpty()]
   $Description
 )
 $DebugLogger.PSDebug("Extent='$Extent'")  #<%REMOVE%>
 if ($null -eq $Extent) 
 { 
   $DebugLogger.Error("NewDiagnosticRecord $Rulename")  #<%REMOVE%>
   throw "NewDiagnosticRecord : $Rulename :`$Extent est `$null"
 }
[Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.CorrectionExtent]::new(
    #Informations d’emplacement
  $Extent.StartLineNumber, 
  $Extent.EndLineNumber,
  $Extent.StartColumnNumber,
  $Extent.EndColumnNumber, 
   #Texte de la correction lié à la régle
  $Text, 
    #Nom du fichier concerné
  $Extent.File,                
    #Description de la correction
  $Description
 )
}

Function NewDiagnosticRecord{
 param (
    [ValidateNotNullOrEmpty()]  
  $RuleName,

    [ValidateNotNullOrEmpty()]  
  $Message,
  
  [ValidateNotNullOrEmpty()]  
  $Severity,
  
  $Ast,
  
  $Correction=$null
 )
 if ($null -eq $Ast) 
 { 
   $DebugLogger.Error("NewDiagnosticRecord $Rulename") 
   throw "NewDiagnosticRecord : $Rulename :`$Ast est `$null"
 }
 $Extent=$Ast.Extent

 [Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord]::new(
    $Message,
    $Extent,
    $RuleName,
    $Severity,
     #ScriptPath
    $Extent.File,
     #RuleID 
    $null,
    $Correction
 )
}
Function Get-ScriptBlockType {
  param ($ScriptBlockAst)
    $isFunction=$false
    $NameOfBlock=$null
    $Parent=$ScriptBlockAst.Parent
    if ($null -eq $Parent) 
    { 
      $DebugLogger.PSDebug('Type=Script/Module') #<%REMOVE%>
      if (-not [string]::IsNullOrEmpty($ScriptBlockAst.Extent.File))
      { $NameOfBlock=([System.IO.FileInfo]$ScriptBlockAst.Extent.File).BaseName }
      $ParamBlock=$ScriptBlockAst.ParamBlock  
    }  
    elseif ($Parent -is [System.Management.Automation.Language.FunctionDefinitionAst]) 
    { 
      #note : un filtre (Filter) est aussi une fonction (isfilter=$true), 
      #Dans ce cas le corps de la fonction est aussi le bloc process.
      #si le filtre (Filter) déclare un des blocs (begin,process,end) c'est aussi une fonction (mais isfilter=$false), 
      $DebugLogger.PSDebug('Type=function') #<%REMOVE%>
      $NameOfBlock=$Parent.Name
      $ParamBlock=$Parent.Body.ParamBlock
      $isFunction=$true
    } 
    else {
      #A script block is an unnamed block of statements that can be used as a single unit.
      $DebugLogger.PSDebug('Type=unnamed block') #<%REMOVE%>
      $NameOfBlock='unnamed block'
      $ParamBlock=$ScriptBlockAst.ParamBlock  
    } 
    $DebugLogger.PSDebug("Paramblock is null ? $($null -eq $ParamBlock). isfunction ? $isFunction") #<%REMOVE%>
    if ($null -eq $ParamBlock)
    { 
     
      if ($isFunction)
      {  $Parameters=$Parent.Parameters  }
      else
      { 
          #Un scriptbloc doit avoir un bloc Param() sinon on utilise $args
         $Parameters=$null
      }  
    } 
    else {
      $Parameters=$ParamBlock.Parameters
    }  
    $DebugLogger.PSDebug(" Get-ScriptBlockType ParamBlock est `$null ? $($null -eq $Paramblock)")  #<%REMOVE%>
    return  [pscustomobject]@{
              PSTypeName='SBType';
              Parent=$Parent;
              isFunction=$isFunction;
              NameOfBlock=$NameOfBlock;
              ParamBlock=$ParamBlock;
              Parameters=$Parameters
             }
}

<#
.SYNOPSIS
    Detecting errors in default ParameterSetName

.EXAMPLE
   Measure-DetectingErrorsInDefaultParameterSetName $ScriptBlockAst
    
.INPUTS
  [System.Management.Automation.Language.ScriptBlockAst]
  
.OUTPUTS
   [Microsoft.Windows.Powershell.ScriptAnalyzer.Generic.DiagnosticRecord[]]
   
.NOTES
  See this issue : https://windowsserver.uservoice.com/forums/301869-powershell/suggestions/11088147-parameterset-names-should-not-be-case-sensitive
#>
Function Measure-DetectingErrorsInDefaultParameterSetName{
 [CmdletBinding()]
 [OutputType([Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord[]])]

 Param(
       [Parameter(Mandatory = $true)]
       [ValidateNotNullOrEmpty()]
       [System.Management.Automation.Language.ScriptBlockAst]
      $ScriptBlockAst
 )

process { 
 #<DEFINE %DEBUG%>
  try {
 #<UNDEF %DEBUG%>            
  TraceHeader 'DetectingErrorsInDefaultParameterSetName'  #<%REMOVE%> 
  $SBInfo=Get-ScriptBlockType $ScriptBlockAst
  if ( ($null -eq $SBInfo.ParamBlock) -and ($SBInfo.isFunction -eq $false))
  { 
      $DebugLogger.PSDebug("param-block is omitted") #<%REMOVE%>
      return 
  }  
     
  $DebugLogger.PSDebug("Check the block '$($SBInfo.NameOfBlock)'") #<%REMOVE%>
  try
  {
   #A script may have a param-block but not a function-parameter-declaration. 
   #A function or filter definition may have a function-parameter-declaration or a param-block, but not both.
   
    $Result_DEIDPSN=New-object System.Collections.Arraylist 
    if ($null -eq $SBInfo.ParamBlock)
    { 
     
      if ($SBInfo.isFunction)
      { 
        $DebugLogger.PSDebug("Search ParameterSetname in attributs") #<%REMOVE%>
         #L'attribut [CmdletBinding] ne peut être lié qu'a un bloc Param()
        $DPS_Name=$null
        [string[]] $ParameterSets=@(($SBInfo.Parent.Parameters.Attributes.NamedArguments|Where-Object {$_.ArgumentName -eq 'ParameterSetName'}).Argument.Value|
                                     Select-Object -Unique)      
      }
      else
      { 
          #If param-block is omitted, any arguments passed to the script block are available via $args (PS Specs §8.10.1).
         $DebugLogger.PSDebug("param-block is omitted") #<%REMOVE%>
         return 
      }  
    } 
    else {
      $DebugLogger.PSDebug("ParamBlock.Attributes.Count: $($SBInfo.ParamBlock.Attributes.Count)") #<%REMOVE%>
      
        #note: si plusieurs attributs [CmdletBinding] existe, la méthode GetCmdletBindingAttributeAst renvoi le premier trouvé 
      $CBA=$script:Helpers.GetCmdletBindingAttributeAst($SBInfo.ParamBlock.Attributes)
      $DPS_Name=($CBA.NamedArguments|Where-Object {$_.ArgumentName -eq 'DefaultParameterSetName'}).Argument.Value
        #Récupère les noms de jeux 
        #Les paramètres communs sont dans le jeu nommé '__AllParameterSets' créé à l'exécution
      [string[]] $ParameterSets=@(($SBInfo.ParamBlock.Parameters.Attributes.NamedArguments|Where-Object {$_.ArgumentName -eq 'ParameterSetName'}).Argument.Value|
                                    Select-Object -Unique)      
    }  

    $SetCount=$ParameterSets.Count

    if (($null -eq $DPS_Name) -and ($SetCount -eq 0 ))
    { 
      $DebugLogger.PSDebug("Nothing to do. No DPS and no ParametSet") #<%REMOVE%>
      return 
    }                                                                            
    
    if (($null -eq $DPS_Name) -and ($SetCount -gt 1))
    {  
       #Todo : Pour certaines constructions basées sur les paramètres obligatoire (ex: Pester.Set-ScriptBlockScope) #<%REMOVE%>
       #       ce warning ne devrait pas se déclencher.                                                             #<%REMOVE%>
       #       Reste à connaitre les spécification de la règle à coder...                                           #<%REMOVE%>
      $Result_DEIDPSN.Add((NewDiagnosticRecord 'ProvideDefaultParameterSetName' ($RulesMsg.W_DpsNotDeclared -F $SBInfo.NameOfBlock) Warning  $ScriptBlockAst)) > $null 
    } 

    # Les cas I_PsnRedundant et I_DpsUnnecessary sont similaires                                                      
    # Pour I_PsnRedundant il y a 1,n déclarations redondantes mais pour I_DpsUnnecessary il n'y a qu'une déclaration jugée inutile
    if ((($null -ne $DPS_Name) -and ($SetCount -eq 1) -and ($DPS_Name -ceq  $ParameterSets[0])) -or (($null -eq $DPS_Name) -and ($SetCount -eq 1))) 
    {       
       $DebugLogger.PSDebug("PSN redondant.") #<%REMOVE%>
       $Result_DEIDPSN.Add((NewDiagnosticRecord 'AvoidUsingRedundantParameterSetName' ($RulesMsg.I_PsnRedundant -F $SBInfo.NameOfBlock ) Information  $ScriptBlockAst)) > $null
    }
    
    if (@($ParameterSets;$DPS_Name) -eq [System.Management.Automation.ParameterAttribute]::AllParameterSets)
    { 
       $DebugLogger.PSDebug("Le nom est '__AllParameterSets', ce nommage est improbable, mais autorisé.") #<%REMOVE%>
       $Result_DEIDPSN.Add((NewDiagnosticRecord 'AvoidUsingTheNameAllParameterSets' ($RulesMsg.W_DpsAvoid_AllParameterSets_Name -F $SBInfo.NameOfBlock) Warning  $ScriptBlockAst)) > $null
    }

    if ($null -ne $DPS_Name) 
    {       
       if (($SetCount -eq  0) -or (($SetCount -eq  1) -and ($DPS_Name -ceq  $ParameterSets[0])))
       {
          $DebugLogger.PSDebug("Dps seul est inutile") #<%REMOVE%>
          $Result_DEIDPSN.Add((NewDiagnosticRecord 'AvoidUnnecessaryDefaultParameterSet' ($RulesMsg.I_DpsUnnecessary -F $SBInfo.NameOfBlock) Information  $ScriptBlockAst)) > $null
       }
       else 
       {       
          $DebugLogger.PSDebug("Test sur la cohérence et sur la casse: $ParameterSets") #<%REMOVE%>
          if (($ParameterSets.count -gt 0) -and ($DPS_Name -cnotin $ParameterSets))
          {
            $DebugLogger.PSDebug("Dps inutilisé") #<%REMOVE%>
            $Result_DEIDPSN.Add((NewDiagnosticRecord 'AvoidInunsedDefaultParameterSet' ($RulesMsg.W_DpsInused -F $SBInfo.NameOfBlock) Warning  $ScriptBlockAst)) > $null
          }
       }
    }
    if (($SetCount -gt 1) -or (($null -ne $DPS_Name) -and ($SetCount -eq  1)))
    {
       $ParameterSets += $DPS_Name    
       $CaseSensitive=[System.Collections.Generic.HashSet[String]]::new($ParameterSets,[StringComparer]::InvariantCulture)
       $CaseInsensitive=[System.Collections.Generic.HashSet[String]]::new($ParameterSets,[StringComparer]::InvariantCultureIgnoreCase)

       if ($CaseSensitive.Count -ne $CaseInsensitive.Count)
       {
         $DebugLogger.PSDebug("Parameterset dupliqué à cause de la casse") #<%REMOVE%>
         $ofs=','
         $CaseSensitive.ExceptWith($CaseInsensitive)
         $msg=$RulesMsg.E_CheckPsnCaseSensitive -F $SBInfo.NameOfBlock,"$($ParameterSets -eq ($CaseSensitive|Select-Object -First 1))"
         $Result_DEIDPSN.Add((NewDiagnosticRecord 'AvoidMixingTheCharacterCase' $Msg Error  $ScriptBlockAst)) > $null
       }  
    } 
    return $Result_DEIDPSN
  }
  catch
  {
     $ER= New-Object -Typename System.Management.Automation.ErrorRecord -Argumentlist $_.Exception, 
                                                                             "DetectingErrorsInDefaultParameterSetName-$($SBInfo.NameOfBlock)", 
                                                                             "NotSpecified",
                                                                              $ScriptBlockAst
     $DebugLogger.PSFatal($_.Exception.Message,$_.Exception) #<%REMOVE%>
     $PSCmdlet.ThrowTerminatingError($ER) 
  }  
 #<DEFINE %DEBUG%>
 }      
 finally {
   #On force l'arrêt de Log4Net, pour chaque Scriptblock PSSA charge le module.
   #Pour le moment (14/08/2017) PSSA n'appel pas OnRemove, il ne semble pas y avoir d'appel à Remove-Module.
  $DebugLogger.PSDebug('Finally: Measure-DetectingErrorsInDefaultParameterSetName') #<%REMOVE%>
  Stop-Log4Net $Script:lg4n_ModuleName  
  #Note : le traitement de la régle se fait correctement mais à priori
  # PSSA ne laisse pas le temps a Log4net de se terminer correctement.
  #Ce qui fait que les logs sont affichés une fois sur deux.
  #Le debug ne doit donc pas se faire via Invoke-ScriptAnalyzer...
 }     
#<UNDEF %DEBUG%>        
 }#process
}#Measure-DetectingErrorsInDefaultParameterSetName

#---------------------------------------------------------------------------
function TestSequential{
#The Collection must be sorted
#Returns $true if the array contains an ordered sequence of numbers.
param([int[]]$List)
  
  if ($List.Count -eq 1)
  {return $true}
  
  $Count=$List.Count
  for ($i = 1; $i -lt $Count; $i++)
  {
     if ($List[$i] -ne $List[$i - 1] + 1)
     {return $false}
  }
  return $true
}# TestSequential


function GetParameter{
#build the parameters collection :
#return objects(into a hashtable) with the parameter name, the parameterset name and the position
#The key of the hashtable avoid the duplication
  param($BlockParameters, $ListDR,$Ast, $isProcessBlocMissing)
   #Un jeu de paramètres ne peut être déduit de la position
   #si aucun de ses paramètres n'est mandatory
  function AddParameter {
     param ($Name,$Psn,$Position=$script:PositionDefault,[boolean]$isValueFromPipeline)
    $DebugLogger.PSDebug("Add '$ParameterName' into '$psn'") #<%REMOVE%>
    $O=[pscustomObject]@{
     Name=$Name
     PSN=$psn
     Position=$Position
     IsValueFromPipeline=$IsValueFromPipeline
    }
    try
    {
      $Parameters.Add("$Name$Psn",$o)
    }
    catch [System.ArgumentException]{
#<DEFINE %DEBUG%> 
      #Cas correct
      #   [Parameter(Position=1)]
      #   [Parameter(ParameterSetName="F6")]
      #   $A          
      #BUG PS: 
      # une duplication de déclaration identique invalide le résultat de Get-Command,
      # Parameters et parameterSet sont vide.
      #   
      #Erreur lors de la duplication de la déclaration :
      #   [Parameter(Position=1,ParameterSetName="F6")]
      #   [Parameter(Position=1,ParameterSetName="F6")]
      #   $A
      #Ou 
      #   [Parameter(Position=1)]
      #   [Parameter(ParameterSetName="F6")]
      #   [Parameter(Position=2)]      
      #   $A
      #ou encore
      #   [Parameter(Position=1)]
      #   [Parameter(ParameterSetName="F6")]
      #   [Parameter(ParameterSetName="F6")]      
#<UNDEF %DEBUG%>   
     #régle 7: Conflit détecté : un attribut [Parameter()] ne peut être dupliqué ou contradictoire
     $DebugLogger.PSDebug("$Name$Psn Conflit détecté : un attribut [Parameter()] ne peut être dupliqué ou contradictoire") #<%REMOVE%>
     $Result_DEIPL.Add((NewDiagnosticRecord 'AvoidDuplicateParameterAttribut' ($RulesMsg.E_ConflictDuplicateParameterAttribut -F $SBInfo.NameOfBlock,$Name,$PSN) Error $Ast)) > $null
    }                                       
  }
 function GetArgumentValue{
   param(
     [System.Management.Automation.Language.NamedAttributeArgumentAst] $na
   )

   $DebugLogger.PSDebug("`t$ParameterName NA is null :$($null -eq $na)") #<%REMOVE%>
   $DebugLogger.PSDebug("`t`$na.Argument type :$($na.Argument.gettype())") #<%REMOVE%>
   if ($na.ExpressionOmitted)
   {
      $DebugLogger.PSDebug("`tGetArgumentValue ExpressionOmitted is True") #<%REMOVE%> 
      return $true
   }
   elseif ($null -ne $na.Argument )
   {
       if ($na.Argument -is [System.Management.Automation.Language.VariableExpressionAst])
       {
          if ($Na.Argument.Extent.Text -eq '$true')
          {
              $DebugLogger.PSDebug("`tGetArgumentValue VariableExpressionAst return True") #<%REMOVE%> 
              return $true
          }
          else 
          {
            $DebugLogger.PSDebug("`tGetArgumentValue VariableExpressionAst return False") #<%REMOVE%>  
            return $false
          }
       }
        # extract from Parser.cs
       $ceAst = $na.Argument -as [System.Management.Automation.Language.ConstantExpressionAst]
       if ($null -ne  $ceAst)
       {
          $istrue=[System.Management.Automation.LanguagePrimitives]::IsTrue($ceAst.Value)
          $DebugLogger.PSDebug("`tGetArgumentValue CONST '$($ceAst.Value)' -> $istrue") #<%REMOVE%> 
          return $istrue
       }
   }
   $DebugLogger.PSDebug("`tGetArgumentValue return False") #<%REMOVE%>
   return $false
 }

  $Parameters=@{}
  # Seule la premiére réussite du test affecte $true
  $isPipelineArgumentUsed=$false
  $DebugLogger.PSDebug("BlockParameters.Count: $($BlockParameters.Count)") #<%REMOVE%>
  Foreach ($Parameter in $BlockParameters)
  {
    
    $ParameterName=$Parameter.Name.VariablePath.UserPath
    $DebugLogger.PSDebug("*-- Parameter  : $ParameterName") #<%REMOVE%>
    $PSN=$script:SharedParameterSetName
    
    if ($Parameter.Attributes.Count -eq 0) 
    { AddParameter $ParameterName $psn }
    else
    { 
      $Predicate= { $args[0].TypeName.FullName -eq 'Parameter' }
      $All=$Parameter.Attributes.FindAll($Predicate,$true) 
      if ($null -eq $All) 
      { AddParameter $ParameterName $psn }
      else
      {
        #régle 14 
        $isDefaultValue = $null -ne $Parameter.DefaultValue #Parameter initializers
         # Seule la premiére réussite du test affecte $true
        $isMandatoryArgumentUsed=$false
        
        #todo use case -> test  
        #Si un attribut Parameter est déclaré plusieurs fois sur le même jeux
          #On gére les doublons, mais on ne considére que la première déclaration de [Parameter()] 
        foreach ($Attribute in $Parameter.Attributes)
        {
          $DebugLogger.PSDebug("Attribut : $Attribut") #<%REMOVE%>
          if ($Attribute.TypeName.FullName -eq 'Parameter')
          {
            $Position=$script:PositionDefault
            $isValueFromPipeline=$false
            if (($Attribute.NamedArguments.Count -eq 0) -and ($Attribute.PositionalArguments.Count -eq 0))
            {
              #régle 6: Un attribut [Parameter()] vide est inutile
              $DebugLogger.PSDebug("`tRule : [Parameter()] vide") #<%REMOVE%>
              $Result_DEIPL.Add((NewDiagnosticRecord 'AvoidUsingUnnecessaryParameterAttribut' ($RulesMsg.W_PsnUnnecessaryParameterAttribut -F $SBInfo.NameOfBlock,$ParameterName) Warning $ScriptBlockAst )) > $null
            }
            else 
            {
              $isMandatory=$false
              foreach ($NamedArgument in $Attribute.NamedArguments)
              {
                  $ArgumentName=$NamedArgument.ArgumentName
                  if ($ArgumentName -eq 'ParameterSetName')
                  { $PSN=$NamedArgument.Argument.Value }
                  elseif ($ArgumentName -eq 'Position')
                  { $Position=$NamedArgument.Argument.Value}
                  elseif ($ArgumentName -eq 'ValueFromPipelineByPropertyName')
                  { 
                     if (-not $isPipelineArgumentUsed)
                     { 
                       if ((GetArgumentValue $NamedArgument) -eq $true)
                       { $isPipelineArgumentUsed=$true }
                     }
                     $DebugLogger.PSDebug("`tByPropertyName isPipelineArgumentUsed=$isPipelineArgumentUsed") #<%REMOVE%>  
                  }
                  elseif ($ArgumentName -eq 'ValueFromPipeline')
                  { 
                    if (-not $isPipelineArgumentUsed)
                    { 
                      #S'il existe 2 jeux avec ($true et $false) le premier à $true évite de remodifier à false
                      $isValueFromPipeline=GetArgumentValue $NamedArgument
                      $DebugLogger.PSDebug("`t$ParameterName isValueFromPipeline($isValueFromPipeline) is null :$($null -eq $isValueFromPipeline)") #<%REMOVE%>
                      if ($isValueFromPipeline -eq $true)
                      { $isPipelineArgumentUsed=$true }
                    }
                    $DebugLogger.PSDebug("`tisPipelineArgumentUsed=$isPipelineArgumentUsed") #<%REMOVE%>  
                  }
                  elseif ($ArgumentName -eq 'Mandatory')
                  {  
                    $isMandatory= GetArgumentValue $NamedArgument
                    $DebugLogger.PSDebug("`t$ParameterName isMandatory is null :$($null -eq $isMandatory)") #<%REMOVE%>
                    $DebugLogger.PSDebug("`tisMandatory=$isMandatory isDefaultValue=$isDefaultValue") #<%REMOVE%>
                    if (-not $isMandatoryArgumentUsed -and $isMandatory -and $isDefaultValue)
                    {
                      <# 
                       Evite 2 déclenchements de la régle pour un seul paramètre mais avec + PSN
                         [Parameter(Mandatory=$true,ParameterSetName="First")]
                         [Parameter(Mandatory=$true,ParameterSetName="Second")]
                        $Hvar="Test error", 
                      #>
                      $isMandatoryArgumentUsed=$true
                      #régle 14 : Un paramètre Mandatory ne peut avoir de valeur par défaut. 
                      # il n'y a qu'un seule déclaration de valeur et pour tout les PSN
                      $DebugLogger.PSDebug("`tRule '$ParameterName' : [Parameter(Mandatory=`$true)] ne peut avoir de valeur par défaut") #<%REMOVE%>
                      #todo vérifier présence Nom de function\nomParamétre ou du n° de ligne 
                      $Result_DEIPL.Add((NewDiagnosticRecord 'AvoidUsingMandoryParameterWithDefaultValue' ($RulesMsg.W_MandoryParameterWithDefaultValue -F "$($SBInfo.NameOfBlock)\$ParameterName") Warning $ScriptBlockAst )) > $null
                    }
                  }
              }
            }
            AddParameter $ParameterName $psn $Position $isValueFromPipeline 
          } 
        }
      }
    }  
  } 
  $DebugLogger.PSDebug("isPipelineArgumentUsed=$isPipelineArgumentUsed   isProcessBlocMissing=$isProcessBlocMissing)") #<%REMOVE%>
  if ($isPipelineArgumentUsed -and $isProcessBlocMissing)
  {
      #régle 8 : To accept all the records from the preceding cmdlet in the pipeline, 
      #           your cmdlet must implement the ProcessRecord method.
      #
      #          Si au moins un paramètre déclare l'attribut [Parameter(ValueFromPipeline = $true)] ou [Parameter(ValueFromPipelineByPropertyName = $true)]
      #          alors la présence du bloc Process dans un scriptblock est nécessaire.
      $DebugLogger.PSDebug("`tRule : Bloc process absent, l'argument ValueFromPipeline est inopérant.") #<%REMOVE%>
      $Result_DEIPL.Add((NewDiagnosticRecord 'MissingProcessBlock' $RulesMsg.E_CheckProcessBlockWhenPipelineIsUsed Error $ScriptBlockAst )) > $null
  } 
  elseif (($isProcessBlocMissing -eq $false) -and ($isPipelineArgumentUsed -eq $false)) {
      #régle 8 : Présence du bloc Process sans aucun attribut [Parameter(ValueFromPipeline = $true)] ou [Parameter(ValueFromPipelineByPropertyName = $true)]
      $DebugLogger.PSDebug("`tRule : Bloc process absent, l'argument ValueFromPipeline est inopérant.") #<%REMOVE%>
      $Result_DEIPL.Add((NewDiagnosticRecord 'MissingArgumentToManageIncomingPipelineObject' $RulesMsg.W_CheckProcessBlockWhenPipelineIsNotUsed Warning $ScriptBlockAst )) > $null
 #todo test Filter/function Test { param($a) "a"; process {"B $_"}} 
 #todo cas : process sans pipeline et sans byname
 #           sans clause param() ? usage simple par $_
 #           plusieurs VFP dans un seul PSN
  } 
 ,$Parameters 
}#GetParameter   

function TestSequentialAndBeginByZeroOrOne{
# The positions should begin to zero or 1,
# not be duplicated and be  an ordered sequence.
         
 param($NameOfBlock, $GroupByPSN, $Ast, $isDuplicate)
  $PSN=$GroupByPSN.Name
  $SortedPositions=$GroupByPSN.Group.Position|Where-Object {$_ -ne $script:PositionDefault}|Sort-Object
  if ($null -ne $SortedPositions)
  {
    $DebugLogger.PSDebug("psn= $PSN isUnique=$script:isSharedParameterSetName_Unique  -gt 1 $($SortedPositions[0] -gt 1)") #<%REMOVE%>
    $ofs=','
    #Régle  4 : Les positions doivent débuter à zéro ou 1
    #Il reste possible d'utiliser des numéros de position arbitraire mais au détriment de la compréhension/relecture
    #un jeu (J1) peut avoir un paramètre ayant une position 2, dans le cas où un paramètre commun (J0)  
    #indique une position 1, la régle sera validé J1=(J1+J0) puisque le paramètre commun est ajouté à chaque jeu déclaré.
   if (($SortedPositions[0] -gt 1) -and ($script:isSharedParameterSetName_Unique -or ($PSN -ne $script:SharedParameterSetName)))  
   { 
     $DebugLogger.PSDebug("`tRule : The positions of parameters must begin by zero or one -> $($SortedPositions[0])") #<%REMOVE%>
     NewDiagnosticRecord 'PsnParametersMustBeginByZeroOrOne' ($RulesMsg.W_PsnParametersMustBeginByZeroOrOne -F $NameOfBlock,$PSN,"$SortedPositions") Warning $Ast
   }
   if (-not $iDusplicate) 
   {
     #régle 5 : L'ensemble des positions doit être une suite ordonnée d'éléments.
     # Ex 1,2,3 est correct, mais pas 1,3 ou 1,2,3,1 ni 6,4,2
     # Des positions de paramètre dupliqués invalident forcément cette régle 5   
     if (-not (TestSequential $SortedPositions))
     { 
       $DebugLogger.PSDebug("`tRule : Not Sequential") #<%REMOVE%>
       NewDiagnosticRecord 'ProvideParameterWithSequentialPosition' ($RulesMsg.E_PsnPositionsAreNotSequential -f $NameOfBlock,$PSN,"$SortedPositions") Error $Ast
     }  
   }
  }
}#TestSequentialAndBeginByZeroOrOne

 
Function Measure-DetectingErrorsInParameterList{
<#
.SYNOPSIS
   Determines if the parameters of a command are valid.

.EXAMPLE
   Measure-DetectingErrorsInParameterList $ScriptBlockAst 
    
.INPUTS
  [System.Management.Automation.Language.$ScriptBlockAst]
  
.OUTPUTS
   [Microsoft.Windows.Powershell.ScriptAnalyzer.Generic.DiagnosticRecord[]]
#>

 [CmdletBinding()]
 [OutputType([Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord[]])]
 
 Param(
       [Parameter(Mandatory = $true)]
       [ValidateNotNullOrEmpty()]
       [System.Management.Automation.Language.ScriptBlockAst]
      $ScriptBlockAst       
 )

  process {
   try
   {      
    TraceHeader 'DetectingErrorsInParameterList'  #<%REMOVE%> 
    $SBInfo=Get-ScriptBlockType $ScriptBlockAst
    if ( ($null -eq $SBInfo.ParamBlock) -and ($SBInfo.isFunction -eq $false))
    { 
        $DebugLogger.PSDebug("param-block is omitted") #<%REMOVE%>
        return 
    }  
      
    $Result_DEIPL=New-object System.Collections.Arraylist

    $ParametersList = GetParameter $SBInfo.Parameters $Result_DEIPL $SBInfo.ParamBlock ($null -eq $ScriptBlockAst.ProcessBlock)
    $script:isSharedParameterSetName_Unique=$false
     #régle 0 : si un paramétre déclare une position, les autres peuvent ne pas en déclarer
     #peut sembler incohérent ou incommode mais possible.
    
    #Une fois la liste construite on connait tous les PSN
    #Pour celui nommé '__AllParametersSet' on doit ajouter tous ces paramètres à tous les autres PSN
    $Groups=$ParametersList.Values|Group-Object -Property PSN
   
     #On veut savoir s'il n'existe que le jeu de paramètre par défaut.
    $script:isSharedParameterSetName_Unique=($Groups.Values.Count -eq 1) -and ($Groups[0].Name -eq $script:SharedParameterSetName)
   
    $OtherGroups=New-object System.Collections.Arraylist
    $DefaultGroup=Foreach ($group in $Groups) {
     if ($group.name -eq $script:SharedParameterSetName)
     {$group}
     else
     {$OtherGroups.Add($group) > $null}
    }
    
    if ($null -ne $DefaultGroup)
    {
      Foreach ($group in $OtherGroups)
      {
        $DebugLogger.PSDebug("Compléte ParametersList") #<%REMOVE%>
        $psnName=$group.Name
        Foreach ($parameter in $DefaultGroup.Group)
        {  
          $DebugLogger.PSDebug("Add group $psnname $parameter") #<%REMOVE%>   
          $key="$($parameter.Name)$psnName"
          If (-not ($ParametersList.contains($Key)))
          {
            $ParametersList.Add($Key,(
              [pscustomObject]@{
                Name=$parameter.Name
                PSN=$psnName
                Position=$parameter.Position
              }))
          }
          else { $DebugLogger.PSDebug("Clé déjà présente : $Key") } #<%REMOVE%>   
        }               
      }
    }
    #todo + VFP m dans un seul PSN 
    #pour chaque PSN rechercher s'il existe + paramètres avec VFP
    #FindAll()
    #plus facile à tester que pour chaque attribut ?

    #($null -eq $ScriptBlockAst.ProcessBlock)
    
    Foreach ($GroupByPSN in ( $ParametersList.Values|Group-Object -Property PSN)) {
     $PSN=$GroupByPSN.Name
     $DebugLogger.PSDebug("Psn=$Psn") #<%REMOVE%>
   
     $isduplicate=$false
     #Pour chaque jeu, contrôle  les positions de ses paramètres
     # on regroupe une seconde fois pour déterminer s'il y a des duplications de numéro de position
     # et connaitre le nom des paramètres concernés.
     $GroupByPSN.Group|
      Group-Object Position|
       Foreach-Object {
        $ParameterName=$_.Group[0].Name   
        $DebugLogger.PSDebug("Parameter=$ParameterName") #<%REMOVE%>
         
        $Position=$_.Name -as [Int]
        if ($Position -ne $script:PositionDefault) 
        {
          #régle 2 : le nombre indiqué dans la propriété 'Position' doit être positif
         if ($Position -lt 0)
         {  
           $DebugLogger.PSDebug("`tRule : Position must be positive  '$PSN' - '$ParameterName' - $Position") #<%REMOVE%>
           $Result_DEIPL.Add((NewDiagnosticRecord 'ProvideParameterWithPositivePosition' ($RulesMsg.E_PsnMustHavePositivePosition -f $SBInfo.NameOfBlock,$PSN,$ParameterName,$Position) Error $ScriptBlockAst )) > $null
         }
        } 
        $_      
       }|
       Where-Object { ($_.Count -gt 1) -and ($_.Name[0] -ne '-')}|
       Foreach-Object{
        #Régle  3 : Les positions des paramètres d'un même jeu ne doivent pas être dupliqués
        #Ex 1,2,3 est correct, mais pas 1,2,3,1           
        $DebugLogger.PSDebug("`tRule : Duplicate position") #<%REMOVE%>
        $ofs=','
        $Result_DEIPL.Add((NewDiagnosticRecord 'AvoidDuplicateParameterPosition' ($RulesMsg.E_PsnDuplicatePosition -F $SBInfo.NameOfBlock,$PSN,$_.Name,"$($_.group.name)") Error $ScriptBlockAst )) > $null
        $isDuplicate=$true
        $isduplicate=$isduplicate 
       }

     $Dr=@(TestSequentialAndBeginByZeroOrOne $SBInfo.NameOfBlock $GroupByPSN $ScriptBlockAst $isDuplicate)
     $Result_DEIPL.AddRange($Dr)> $null

    } #foreach

    if ($Result_DEIPL.count -gt 0)
    {
      $DebugLogger.PSDebug("return Result") #<%REMOVE%>
      return $Result_DEIPL 
    }
   }
   catch
   {
      $ER= New-Object -Typename System.Management.Automation.ErrorRecord -Argumentlist $_.Exception, 
                                                                             "DetectingErrorsInParameterList-$($SBInfo.NameOfBlock)", 
                                                                             "NotSpecified",
                                                                             $ScriptBlockAst 
      $DebugLogger.PSFatal($_.Exception.Message,$_.Exception) #<%REMOVE%>
      $PSCmdlet.ThrowTerminatingError($ER) 
   }  
 #<DEFINE %DEBUG%>
   finally {
    $DebugLogger.PSDebug('Finally : Measure-DetectingErrorsInParameterList') #<%REMOVE%>
    Stop-Log4Net $Script:lg4n_ModuleName
   }  
  #<UNDEF %DEBUG%>        
  }#process
}#Measure-DetectingErrorsInParameterList    

Function Measure-ParameterNameShouldBePascalCase{
<#
.SYNOPSIS
   Determines whether the name of a parameter respects the naming convention pascal case

.EXAMPLE
   Measure-ParameterNameShouldBePascalCase $ScriptBlockAst 
    
.INPUTS
  [System.Management.Automation.Language.$ScriptBlockAst]
  
.OUTPUTS
   [Microsoft.Windows.Powershell.ScriptAnalyzer.Generic.DiagnosticRecord[]]
#>

 [CmdletBinding()]
 [OutputType([Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord[]])]
 
 Param(
       [Parameter(Mandatory = $true)]
       [ValidateNotNullOrEmpty()]
       [System.Management.Automation.Language.ScriptBlockAst]
      $ScriptBlockAst       
 )

  process {
   try
   {      
    TraceHeader 'ParameterNameShouldBePascalCase'  #<%REMOVE%> 
    $SBInfo=Get-ScriptBlockType $ScriptBlockAst
    if ( ($null -eq $SBInfo.ParamBlock) -and ($SBInfo.isFunction -eq $false))
    { 
        $DebugLogger.PSDebug("param-block is omitted") #<%REMOVE%>
        return 
    }  
      
    $Result_PascalCase=New-object System.Collections.Arraylist

    Foreach ($Parameter in $SBInfo.Parameters)
    {
      $ParameterName=$Parameter.Name.VariablePath.UserPath
       #régle 10: The parameter names should be in PascalCase.
      if ($ParameterName -cnotmatch '^([A-Z][a-z]+)+$')
      { 
          #groupe : une majuscule suivi d'une ou plusieures minuscules, le groupe peut être présent plusieurs fois 
          $DebugLogger.PSDebug("'$ParameterName' create 'Measure-ParameterNameShouldBePascalCase' record.") #<%REMOVE%>
          $message= $RulesMsg.I_UsePascalCaseForParameterName -F $ParameterName
          $Result_PascalCase.Add((NewDiagnosticRecord 'Measure-ParameterNameShouldBePascalCase' $message Information $SBInfo.ParamBlock)) > $null 
      } 
    } 
    if ($Result_PascalCase.count -gt 0)
    {
      $DebugLogger.PSDebug("return Result") #<%REMOVE%>
      return $Result_PascalCase
    }
   }
   catch
   {
      $ER= New-Object -Typename System.Management.Automation.ErrorRecord -Argumentlist $_.Exception, 
                                                                             "DetectingErrorsInParameterList-$($SBInfo.NameOfBlock)", 
                                                                             "NotSpecified",
                                                                             $ScriptBlockAst 
      $DebugLogger.PSFatal($_.Exception.Message,$_.Exception) #<%REMOVE%>
      $PSCmdlet.ThrowTerminatingError($ER) 
   }  
  #<DEFINE %DEBUG%>
   finally {
    $DebugLogger.PSDebug('Finally : Measure-ParameterNameShouldBePascalCase') #<%REMOVE%>
    Stop-Log4Net $Script:lg4n_ModuleName
   }  
  #<UNDEF %DEBUG%>        
  }#process
}#Measure-ParameterNameShouldBePascalCase

function TestPluralParameterName {
  param ([string] $ParameterName)
    #Avoid using plural names for parameters whose value is a single element.
    #  https://msdn.microsoft.com/en-us/library/dd878270(v=vs.85).aspx#SD03
    #todo : uses case with array
  $DebugLogger.PSDebug("TestPluralParameterName '$ParameterName'. Is `$script:PluralSrvc null: $($null -eq $script:PluralSrvc)") #<%REMOVE%>
  $isPlural=$script:PluralSrvc.isPlural($ParameterName)
  $DebugLogger.PSDebug("'$ParameterName' isPlural  ? $isPlural") #<%REMOVE%>
  if ($isPlural -and ($script:PluralSrvc.isSingular($ParameterName)))
  { 
    $DebugLogger.PSDebug("'$ParameterName' has no plural form.") #<%REMOVE%>
    $isPlural=$false
  }
  return $isPlural
}
Function Measure-AvoidPluralNameForParameter{
<#
.SYNOPSIS
   Determines whether the name of a parameter is in the singular

.EXAMPLE
   Measure-AvoidPluralNameForParameter $ScriptBlockAst 
    
.INPUTS
  [System.Management.Automation.Language.$ScriptBlockAst]
  
.OUTPUTS
   [Microsoft.Windows.Powershell.ScriptAnalyzer.Generic.DiagnosticRecord[]]
#>

 [CmdletBinding()]
 [OutputType([Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord[]])]
 
 Param(
       [Parameter(Mandatory = $true)]
       [ValidateNotNullOrEmpty()]
       [System.Management.Automation.Language.ScriptBlockAst]
      $ScriptBlockAst       
 )

  process {
   try
   {      
    TraceHeader 'AvoidPluralNameForParameter'  #<%REMOVE%> 
    $SBInfo=Get-ScriptBlockType $ScriptBlockAst
    if ( ($null -eq $SBInfo.ParamBlock) -and ($SBInfo.isFunction -eq $false))
    { 
        $DebugLogger.PSDebug("param-block is omitted") #<%REMOVE%>
        return 
    }  
     
    $Result_PluralName=New-object System.Collections.Arraylist

    Foreach ($Parameter in $SBInfo.Parameters)
    {
      $ParameterName=$Parameter.Name.VariablePath.UserPath

      #régle 9 : Use Singular Parameter Names
    if (TestPluralParameterName $ParameterName)
      { 
        $DebugLogger.PSDebug("'$ParameterName' create 'Measure-AvoidPluralNameForParameter' record.") #<%REMOVE%>
        $message= $RulesMsg.I_ParameterNameUsePlural -F $ParameterName,($script:PluralSrvc.Singularize($ParameterName))
        $Result_PluralName.Add((NewDiagnosticRecord 'Measure-AvoidPluralNameForParameter' $message Information $SBInfo.ParamBlock)) > $null 
      } 
    }     

    if ($Result_PluralName.count -gt 0)
    {
      $DebugLogger.PSDebug("return Result") #<%REMOVE%>
      return $Result_PluralName 
    }
   }
   catch
   {
      $ER= New-Object -Typename System.Management.Automation.ErrorRecord -Argumentlist $_.Exception, 
                                                                             "DetectingErrorsInParameterList-$($SBInfo.NameOfBlock)", 
                                                                             "NotSpecified",
                                                                             $ScriptBlockAst 
      $DebugLogger.PSFatal($_.Exception.Message,$_.Exception) #<%REMOVE%>
      $PSCmdlet.ThrowTerminatingError($ER) 
   }  
   #<DEFINE %DEBUG%>
   finally {
    $DebugLogger.PSDebug('Finally : Measure-AvoidPluralNameForParameter') #<%REMOVE%>
    Stop-Log4Net $Script:lg4n_ModuleName
   }  
  #<UNDEF %DEBUG%>        
  }#process
}#Measure-AvoidPluralNameForParameter
 

Export-ModuleMember -Function Measure-*
