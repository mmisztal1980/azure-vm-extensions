<#
.SYNOPSIS
If the env-variables string is provided, the env variables are set VM-side.

.PARAMETER EnvironmentVariables
JSON formatted representation of the PS-hashset containing the key-value pairs with env-variable values.
#>

Param (
    [string] $EnvironmentVariables
)

if ($EnvironmentVariables -ne $null)
{
    $environmentVariablesObj = ConvertFrom-Json $EnvironmentVariables
    $environmentVariablesProperties = $environmentVariablesObj | Get-Member * -MemberType NoteProperty

    foreach ($property in $environmentVariablesProperties)
    {
        $name = $property.Name
        $value = $environmentVariablesObj.$name
        Write-Host "SET ['$name'] = '$value'"
        [Environment]::SetEnvironmentVariable($name, $value, "Machine")
    }
}