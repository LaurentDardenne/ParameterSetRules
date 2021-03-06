# AvoidMixingTheCharacterCase
**Severity Level: Error**

## Description
The parameter set name are case sensitive, conflicts were detected.

### Function :  ParameterSetRules\Measure-DetectingErrorsInDefaultParameterSetName

## How to Fix
Rename the parameter set name.

## Example
### Wrong：
```PowerShell
Function TestParameterSet{
  [CmdletBinding(DefaultParameterSetName = "Name2")]
  Param (
   [Parameter(ParameterSetName="Name1")]
   [Switch] $A,

   [Parameter(ParameterSetName="name2")]
   [Switch] $B
  )

 Write-Verbose "Processing..."
}
```

### Correct:
```PowerShell
Function TestParameterSet{
  [CmdletBinding(DefaultParameterSetName = "Name2")]
  Param (
   [Parameter(ParameterSetName="Name1")]
   [Switch] $A,

   [Parameter(ParameterSetName="Name2")]
   [Switch] $B
  )

 Write-Verbose "Processing..."
}
```
