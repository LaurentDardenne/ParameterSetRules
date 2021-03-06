# AvoidUnnecessaryDefaultParameterSet
**Severity Level: Information**

## Description
The single declaration of default parameter set name is unnecessary (see attribute [CmdletBinding]).

### Function :  ParameterSetRules\Measure-DetectingErrorsInDefaultParameterSetName

## How to Fix
Remove the unnecessary declarations. 

## Example
### Wrong：
```PowerShell
Function TestParameterSet{
 [CmdletBinding(DefaultParameterSetName = "Name1")]
  Param (
    [Parameter(ParameterSetName="Name1")]
    [Switch] $A
  )
 Write-Verbose "Processing..."
}
```
### Correct:
```PowerShell
Function TestParameterSet{
 [CmdletBinding()]
  Param (
    [Switch] $A
  )
 Write-Verbose "processsing..."
}
```
