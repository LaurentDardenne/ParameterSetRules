$Path="$PsScriptRoot\ArgumentToManageIncomingPipelineObject"
$CustomRulePath='..\Release\ParameterSetRules\ParameterSetRules.psm1'
$M=Import-module ..\Release\ParameterSetRules\ParameterSetRules.psd1 -Pass

$RulesMessage=&$m {$RulesMsg}

Describe "Rule DetectingErrorsInParameterList-Manage Pipeline" {

    Context "When there is no violation" {
      #régle 8 : To accept all the records from the preceding cmdlet in the pipeline, 
      #           your cmdlet must implement the ProcessRecord method.
      It "Process block present and the parameters used ValueFromPipeline." {
        $FileName="$Path\CorrectValueFromPipeline One by PSN.ps1"
        $Results = Invoke-ScriptAnalyzer -Path $Filename -CustomRulePath $CustomRulePath
        $Results.Count | should be (0)
      }

      It "Process block present and the parameters used ValueFromPipelineByPropertyName." {
        $FileName="$Path\CorrectVFPByPropertyName One by PSN.ps1"
        $Results = Invoke-ScriptAnalyzer -Path $Filename -CustomRulePath $CustomRulePath
        $Results.Count | should be (0)
      }  
    
      It "Process block present and the parameters used both VFP." {
        $FileName="$Path\CorrectMixedVFP One by PSN.ps1"
        $Results = Invoke-ScriptAnalyzer -Path $Filename -CustomRulePath $CustomRulePath
        $Results.Count | should be (0)
      }  
    
      #without process block
      It "Simple function, no process block present none parameter use ValueFromPipeline." {
        $FileName="$Path\SimpleFunction.ps1    "
        $Results = Invoke-ScriptAnalyzer -Path $Filename -CustomRulePath $CustomRulePath
        $Results.Count | should be (0)
      }  
      
      It "Process block present, two ValueFromPipeline in the same PSN ." {
        $FileName="$Path\Two ValueFromPipeline in the same PSN and Process block present.ps1"
        
        $Results = Invoke-ScriptAnalyzer -Path $Filename -CustomRulePath $CustomRulePath
        $Results.Count | should be (0)
      }        
    }#context
  
    Context "When there are violations" {
#with process block
      It "Process block present, none parameter use ValueFromPipeline." {
        $FileName="$Path\NoValueFromPipeline But Processblock present.ps1"
        
        $Results = Invoke-ScriptAnalyzer -Path $Filename -CustomRulePath $CustomRulePath
        $Results.Count | should be (1)
        $Results[0].Severity| should be 'Warning'
        $Results[0].RuleName| should be 'MissingArgumentToManageIncomingPipelineObject'
      }
     
      It "Process block present, none parameter use ValueFromPipelineByPropertName." {
        $FileName="$Path\NoVFPByPropertName But Processblock present.ps1"
        
        $Results = Invoke-ScriptAnalyzer -Path $Filename -CustomRulePath $CustomRulePath
        $Results.Count | should be (1)
        $Results[0].Severity| should be 'Warning'
        $Results[0].RuleName| should be 'MissingArgumentToManageIncomingPipelineObject'
      }  
      #todo mixed ?
      
#without process block
      It "Process block missing, parameters used ValueFromPipeline (one by PSN)." {
        $FileName="$Path\ValueFromPipeline One by PSN Without processblock.ps1"
        
        $Results = Invoke-ScriptAnalyzer -Path $Filename -CustomRulePath $CustomRulePath
        $Results.Count | should be (1)
        $Results[0].Severity| should be 'Error'
        $Results[0].RuleName| should be 'MissingProcessBlock'
      }

      It "Process block missing, parameters used ValueFromPipelinePropertyName (one by PSN)." {
        $FileName="$Path\VFPByPropertyName One by PSN Without processblock.ps1"
        
        $Results = Invoke-ScriptAnalyzer -Path $Filename -CustomRulePath $CustomRulePath
        $Results.Count | should be (1)
        $Results[0].Severity| should be 'Error'
        $Results[0].RuleName| should be 'MissingProcessBlock'
      }

      It "Process block missing, parameters used mixed VPF (one by PSN)." {
        $FileName="$Path\MixedVFP One by PSN Without processblock.ps1"
        
        $Results = Invoke-ScriptAnalyzer -Path $Filename -CustomRulePath $CustomRulePath
        $Results.Count | should be (1)
        $Results[0].Severity| should be 'Error'
        $Results[0].RuleName| should be 'MissingProcessBlock'
      }
      
      It "Process block missing, two ValueFromPipeline in the same PSN ." {
        $FileName="$Path\Two ValueFromPipeline in the same PSN and Process block missing.ps1"
        
        $Results = Invoke-ScriptAnalyzer -Path $Filename -CustomRulePath $CustomRulePath
        $Results.Count | should be (1)
        $Results[0].Severity| should be 'Error'
        $Results[0].RuleName| should be 'MissingProcessBlock'
      }        
    }#context
}
