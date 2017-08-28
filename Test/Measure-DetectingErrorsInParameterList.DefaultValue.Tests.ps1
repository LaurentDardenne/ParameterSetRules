$Path="$PsScriptRoot\MandatoryWithDefaultValue"
$CustomRulePath='..\Release\ParameterSetRules\ParameterSetRules.psm1'
$M=Import-module ..\Release\ParameterSetRules\ParameterSetRules.psd1 -Pass

$RulesMessage=&$m {$RulesMsg}

Describe "Rule DetectingErrorsInParameterList-MandoryWithDefaultValue" {

     Context "When there is no violation" {
#régle 14 : Un paramètre Mandatory ne peut avoir de valeur par défaut. 
      It "Function no param() ,no cmdletbinding." {
        $FileName="$Path\No error.ps1"
        $Results = Invoke-ScriptAnalyzer -Path $Filename -CustomRulePath $CustomRulePath
        $Results.Count | should be (0)
      }
    }#context
   
    Context "When there are violations" {
#régle 14 
      It "One incorrect parameter (string)" {
        $FileName="$Path\One incorrect parameter.ps1"
        
        $Results = Invoke-ScriptAnalyzer -Path $Filename -CustomRulePath $CustomRulePath
        $Results.Count | should be (1)
        $Results[0].Severity| should be 'Warning'
        $Results[0].Message|should be ($RulesMessage.W_MandoryParameterWithDefaultValue -F 'Test-DefaultValue\Evar')
      }

      It "One incorrect parameter (Int)" {
        $FileName="$Path\One incorrect parameterUseINT.ps1"
        $Results = Invoke-ScriptAnalyzer -Path $Filename -CustomRulePath $CustomRulePath

        $Results.Count | should be (1)
        $Results[0].Severity| should be 'Warning'
        $Results[0].Message|should be ($RulesMessage.W_MandoryParameterWithDefaultValue -F 'Test-DefaultValue\Evar')
      }
      
      It "One incorrect parameter  (Mandatory without assignment)" {
        $FileName="$Path\One incorrect parameter (Mandatory without assignment).ps1"
        $Results = Invoke-ScriptAnalyzer -Path $Filename -CustomRulePath $CustomRulePath

        $Results.Count | should be (1) 
        $Results[0].Severity| should be 'Warning'
        $Results[0].RuleName| should be 'AvoidUsingMandoryParameterWithDefaultValue'
        $Results[0].Message|should be ($RulesMessage.W_MandoryParameterWithDefaultValue -F 'Test-DefaultValue\Avar')
      }

      It "Two incorrects parameters" {
        $FileName="$Path\Two incorrects parameters.ps1"
        $Results = Invoke-ScriptAnalyzer -Path $Filename -CustomRulePath $CustomRulePath
        
        $Results.Count | should be (2)
        $Results[0].Severity| should be 'Warning'
        $Results[0].Message|should be ($RulesMessage.W_MandoryParameterWithDefaultValue -F 'Test-DefaultValue\Evar')
        $Results[1].Severity| should be 'Warning'
        $Results[1].Message|should be ($RulesMessage.W_MandoryParameterWithDefaultValue -F 'Test-DefaultValue\Gvar')
      }
      
      It "Three incorrects parameters" {
        $FileName="$Path\Three incorrects parameters.ps1"
        $Results = Invoke-ScriptAnalyzer -Path $Filename -CustomRulePath $CustomRulePath
#         write-warning "c=$($Results.Count)" 
#         write-warning "$($Results|out-string)"
#         $results |export-clixml c:\temp\t.xml
        $Results.Count | should be (3)
        $Results[0].Severity| should be 'Warning'
        $Results[0].Message|should be ($RulesMessage.W_MandoryParameterWithDefaultValue -F 'Test-DefaultValue\Evar')
        $Results[1].Severity| should be 'Warning'
        $Results[1].Message|should be ($RulesMessage.W_MandoryParameterWithDefaultValue -F 'Test-DefaultValue\Gvar')
        $Results[2].Severity| should be 'Warning'
        $Results[2].Message|should be ($RulesMessage.W_MandoryParameterWithDefaultValue -F 'Test-DefaultValue\Hvar')
      }
    }#context
}
