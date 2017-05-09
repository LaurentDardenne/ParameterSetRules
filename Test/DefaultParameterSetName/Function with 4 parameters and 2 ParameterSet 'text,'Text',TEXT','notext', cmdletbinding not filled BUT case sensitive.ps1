Function TestParameterSet {
  param(
    [parameter(parametersetname="text",mandatory=$false)]
    [switch]$mytext,

    [parameter(parametersetname="Text",mandatory=$false)]
    [switch]$yourtext,

    [parameter(parametersetname="TEXT",mandatory=$false)]
    [switch]$hertext,

    [parameter(parametersetname="notext",mandatory=$false)]
    [switch]$notext
  )
 
  Write-host "ParameterSetName = $($PsCmdlet.ParameterSetName)"
}
