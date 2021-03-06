# AvoidInunsedDefaultParameterSet
**Severity Level: Warning**

## Description
The default parameter set name does not refer to an existing parameter set name.

### Function :  ParameterSetRules\Measure-DetectingErrorsInDefaultParameterSetName

## How to Fix
Remove the DefaultParameterSetName or rename it to use an existing parameter set name.

## Example
### Wrong：
```PowerShell
Function TestParameterSet{
  [CmdletBinding(DefaultParameterSetName = "Name2")]
  Param (
   [Parameter(ParameterSetName="Name1")]
   [Switch] $A,
   
   [Parameter(ParameterSetName="Name1")]
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
