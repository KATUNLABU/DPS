Add-Type -AssemblyName System.Drawing

$geminiPath = (Resolve-Path "public/imagenes/gemini-40-real.png").Path
$bmp = [System.Drawing.Bitmap]::FromFile($geminiPath)
$bmp.RotateFlip([System.Drawing.RotateFlipType]::Rotate90FlipNone)
$outPath = [System.IO.Path]::GetFullPath("public/imagenes/gemini-40-real.png")
$bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
Write-Output "Rotated Gemini: $outPath"
