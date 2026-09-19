$parts = Get-ChildItem -Path ".\parts\Delta-2.738.1397.apk.part*" | Sort-Object Name
if ($parts.Count -eq 0) { throw "No APK parts found in .\parts" }

$outPath = ".\Delta-2.738.1397.apk"
$out = [IO.File]::Open($outPath, [IO.FileMode]::Create, [IO.FileAccess]::Write)
try {
    foreach ($part in $parts) {
        $in = [IO.File]::OpenRead($part.FullName)
        try { $in.CopyTo($out) } finally { $in.Dispose() }
    }
}
finally {
    $out.Dispose()
}

Get-FileHash $outPath -Algorithm SHA256
