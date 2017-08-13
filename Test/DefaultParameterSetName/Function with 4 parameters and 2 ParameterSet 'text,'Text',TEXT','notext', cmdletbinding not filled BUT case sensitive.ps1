Function TestParameterSet {
  param(
    [parameter(parametersetname="text",mandatory=$false)]
    [switch]$MyText,

    [parameter(parametersetname="Text",mandatory=$false)]
    [switch]$YourTtext,

    [parameter(parametersetname="TEXT",mandatory=$false)]
    [switch]$HerText,

    [parameter(parametersetname="notext",mandatory=$false)]
    [switch]$NoText
  )
 
  Write-Verbose "ParameterSetName = $($PsCmdlet.ParameterSetName)"
}
