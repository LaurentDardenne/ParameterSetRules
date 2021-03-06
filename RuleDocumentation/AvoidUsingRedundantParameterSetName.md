# AvoidUsingRedundantParameterSetName
**Severity Level: Information**

## Description
The statement of parameter set name is redundant because one single parameter set name was found.

### Function :  ParameterSetRules\Measure-DetectingErrorsInDefaultParameterSetName

## How to Fix
Remove the redundant declaration.

## Example
### Wrong：
```PowerShell
Function TestParameterSet{
  [CmdletBinding()]
  Param (
    [Parameter(ParameterSetName="Name1")]
   [Switch] $A
   )
  Write-Verbose "processing ..."
}
```
### Correct:
```PowerShell
Function TestParameterSet{
  [CmdletBinding()]
  Param (
   [Switch] $A
   )
  Write-Verbose "processing ..."
}
```
