# MissingArgumentToManageIncomingPipelineObject
**Severity Level: Warning**

## Description
The presence of the process block implies that at least one parameter attribute declares 'ValueFromPipeline' or 'ValueFromPipelineByPropertyName' to $true.

### Function :  ParameterSetRules\Measure-DetectingErrorsInParameterList
## How to Fix
Remove the process block or change the configuration of the parameters.

## Example
### Wrong：
```PowerShell
Function Test{
  [CmdletBinding(DefaultParameterSetName = "Feature3")]
  Param (
      [Parameter(ValueFromPipeline = $false,ParameterSetName="Feature1")]
    [String] $Avariable,

      [Parameter(ParameterSetName="Feature2")]
    [Int] $Bvariable
  )
 
   process {
     Write-Verbose "Traitement..."
   }
}
```
### Correct:
```PowerShell
Function Test{
  [CmdletBinding(DefaultParameterSetName = "Feature2")]
  Param (
      [Parameter(ValueFromPipeline = $false,ParameterSetName="Feature1")]
    [String] $Avariable,

      [Parameter(ParameterSetName="Feature2")]
    [Int] $Bvariable
  )
 
     Write-Verbose "..."
}

#Or

Function Test{
  [CmdletBinding(DefaultParameterSetName = "Feature2")]
  Param (
      [Parameter(ValueFromPipeline,ParameterSetName="Feature1")]
    [String] $Avariable,

      [Parameter(ParameterSetName="Feature2")]
    [Int] $Bvariable
  )
 
   process {
     Write-Verbose "..."
   }
}
```
