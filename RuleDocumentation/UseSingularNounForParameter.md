# UseSingularNounForParameter
**Severity Level: Warning**

## Description
The name of a parameter name is invalid.

### Function :  ParameterSetRules\Measure-DetectingErrorsInParameterList
## How to Fix
Change plurals to singular. 

## Example
### Wrong：
```PowerShell
Function TestSingular{
  Param (
    [Parameter(Position=1)]
   [string] $Children,

   [string] $Properties,

    [Parameter(Position=2)]
   [string] $Indexes
   )
  Write-Verbose "Test"
}
```

### Correct:
```PowerShell
Function TestSingular{
  Param (
    [Parameter(Position=1)]
   [string] $Child,
 
   [string] $Property,
    
    [Parameter(Position=2)]
   [string] $Index
   )
  Write-Verbose "Test"
}
```
