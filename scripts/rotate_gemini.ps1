Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName System.Drawing

$geminiPath = (Resolve-Path "public/imagenes/gemini-40-real-color.png").Path
$bmp = [System.Drawing.Bitmap]::FromFile($geminiPath)
$bmp.RotateFlip([System.Drawing.RotateFlipType]::Rotate270FlipNone)
$outPath = [System.IO.Path]::GetFullPath("public/imagenes/gemini-40-real.png")
$bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
Write-Output "Successfully saved rotated Gemini: $outPath"
