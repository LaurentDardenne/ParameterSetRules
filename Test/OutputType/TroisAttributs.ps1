Function Expand-ZipEntry { 
# .ExternalHelp PsIonic-Help.xml         
    [CmdletBinding()] 
    [OutputType([System.Xml.XmlDocument])] 
    [OutputType([System.String])]
    [OutputType([Byte[]])]
	param(
		[ValidateNotNull()] 
        [parameter(Mandatory=$True)]
      [Ionic.Zip.ZipFile] $ZipFile,   
           
      	[Parameter(Position=1,Mandatory=$True,ValueFromPipeline=$True)]
	  [String[]] $Name,      
	
    	[ValidateScript( { IsValueSupported $_ -Extract } )] 
	  [Ionic.Zip.ExtractExistingFileAction] $ExtractAction=[Ionic.Zip.ExtractExistingFileAction]::Throw,
	
	  [String] $Password,

      [System.Text.Encoding] $Encoding=[Ionic.Zip.ZipFile]::DefaultEncoding,
      [Switch] $AsHashTable,

      [Switch] $Byte,

      [Switch] $XML,

      [Switch] $Strict
	)
 begin {
  if ($AsHashTable) {$HTable=@{}}     
 }     
 process {
   Write "Test"         
 }
}