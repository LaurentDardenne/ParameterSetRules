# UsePascalCaseForParameterName

**Severity Level: Information**

## Description

The parameter names should be in Pascal case.

## How

Rewrite the parameter name with the Pascal case namming convention .

## Example

### Wrong

``` PowerShell
function Test-PascalCase
{
  Param (
   $variable,
   $variable_pascal_case
 )
  ...         
}
```

### Correct

``` PowerShell
function Test-PascalCase
{
  Param (
   $Variable,
   $VariablePascalCase
 )
  ...         
}

```