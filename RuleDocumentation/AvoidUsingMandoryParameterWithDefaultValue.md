# AvoidUsingMandoryParameterWithDefaultValue
**Severity Level: Warning**

## Description
A mandatory parameter can not have default value

### Function :  ParameterSetRules\Measure-DetectingErrorsInParameterList
## How to Fix
Suppress the default value or the 'Mandatory' argument in the parameter attribut

## Example
### Wrong：
```PowerShell
function Test-DefaultValue { 
  param( 
    [Parameter(Mandatory=$True,Position=1)]
   $Variable=10
  )
  write-verbose 'Test'
}
```
### Correct:
```PowerShell
function Test-DefaultValue { 
  param( 
    [Parameter(Position=1)]
   $Variable=10
  )
  write-verbose 'Test'
}

#OR
function Test-DefaultValue { 
  param( 
    [Parameter(Mandatory=$True,Position=1)]
   $Variable
  )
  write-verbose 'Test'
}
```
