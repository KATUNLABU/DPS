Add-Type -AssemblyName System.Drawing

$src = (Resolve-Path "public/imagenes/arrow-ezcut-350R-brochure-web-_compressed-pdf-791x1024.jpg").Path
$bmp = [System.Drawing.Bitmap]::FromFile($src)

# Machine is located roughly between x=60, y=380, width=670, height=520
$cropArea = New-Object System.Drawing.Rectangle(40, 360, 710, 560)
$cropped = $bmp.Clone($cropArea, $bmp.PixelFormat)
$outPath = [System.IO.Path]::GetFullPath("public/imagenes/arrow-ezcut-350R-real.png")
$cropped.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
$cropped.Dispose()
$bmp.Dispose()
Write-Output "Cropped EzCut 350R saved: $outPath"
