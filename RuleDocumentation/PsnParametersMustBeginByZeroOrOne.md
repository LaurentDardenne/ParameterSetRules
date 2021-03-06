# PsnParametersMustBeginByZeroOrOne
**Severity Level: Warning**

## Description
It is preferred that the positions of parameters must begin by zero or one.


### Function :  ParameterSetRules\Measure-DetectingErrorsInParameterList
## How to Fix
Change the position property.

## Example
### Wrong：
```PowerShell
Function TestParameterSet{
   
  Param (
    [Parameter(Position=2)]
   [string] $A,
    [Parameter(Position=3)]
   [string] $B,
    [Parameter(Position=4)]
   [string] $C
   )
   Write-Verbose "ParameterSetName =$($PsCmdlet.ParameterSetName)"
}
```

### Correct:
```PowerShell
Function TestParameterSet{
   
  Param (
    [Parameter(Position=1)]
   [string] $A,
    [Parameter(Position=2)]
   [string] $B,
    [Parameter(Position=3)]
   [string] $C
   )
   Write-Verbose "ParameterSetName =$($PsCmdlet.ParameterSetName)"
}
```
