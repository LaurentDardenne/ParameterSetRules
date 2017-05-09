[![Build status](https://ci.appveyor.com/api/projects/status/wn4n7ml61ygmoume?svg=true)](https://ci.appveyor.com/project/LaurentDardenne/parametersetrules)
                                                                                    
![Logo](https://raw.githubusercontent.com/LaurentDardenne/Template/master/Assets/Template.png
# ParameterSetRules
This module contains script analyzer rules to control the param block of a scriptblock.

**Documentation**

[Parameter set rules](https://github.com/LaurentDardenne/ParameterSetRules/tree/master/RuleDocumentation)

How to test parameterset of a [binary cmdlet](https://github.com/LaurentDardenne/ParameterSetRules/blob/master/Docs/en-US/Example.md).


**PowerShell 5 Installation, (development version)**

From PowerShell run:
```Powershell
$PSGalleryPublishUri = 'https://www.myget.org/F/ottomatt/api/v2/package'
$PSGallerySourceUri = 'https://www.myget.org/F/ottomatt/api/v2'

Register-PSRepository -Name OttoMatt -SourceLocation $PSGallerySourceUri -PublishLocation $PSGalleryPublishUri #-InstallationPolicy Trusted

Install-Module ParameterSetRules -Repository OttoMatt -Verbose -Force
```

