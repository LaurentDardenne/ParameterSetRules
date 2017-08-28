# MissingProcessBlock
**Severity Level: Error**

## Description
A parameter attribute using ValueFromPipeline involves the presence of the process block.

### Function :  ParameterSetRules\Measure-DetectingErrorsInParameterList
## How to Fix
Add the process block.

## Example
### Wrong：
```PowerShell
Function Test{
  [CmdletBinding(DefaultParameterSetName = "Feature3")]
  Param (
      [Parameter(ValueFromPipeline = $true,ParameterSetName="Feature1")]
    [String] $Avariable,
       
      [Parameter(ValueFromPipelineByPropertyName = $true,ParameterSetName="Feature3")]
    [Int] $Bvariable
  )

    Write-Verbose "..."
}
```
### Correct:
```PowerShell
Function Test{
  [CmdletBinding(DefaultParameterSetName = "Feature3")]
  Param (
      [Parameter(ValueFromPipeline = $true,ParameterSetName="Feature1")]
    [String] $Avariable,
       
      [Parameter(ValueFromPipelineByPropertyName = $true,ParameterSetName="Feature3")]
    [Int] $Bvariable
  )
 
 process {
    Write-Verbose "..."
 }
}
```
