# UsePascalCaseForParameterName

**Severity Level: Information**

## Description

The parameter names should be in PascalCase.

## How

Rewrite with the namming convention PascalCase.

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