$parts = Get-ChildItem -Path ".\parts\Delta-2.738.1397.zip.part*" | Sort-Object Name
if ($parts.Count -eq 0) { throw "No split parts found in .\parts" }

$out = [IO.File]::OpenWrite(".\Delta-2.738.1397.zip")
try {
    foreach ($part in $parts) {
        $in = [IO.File]::OpenRead($part.FullName)
        try { $in.CopyTo($out) } finally { $in.Dispose() }
    }
}
finally { $out.Dispose() }

Write-Host "Reconstructed Delta-2.738.1397.zip from $($parts.Count) parts."
