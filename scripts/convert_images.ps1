Add-Type -AssemblyName PresentationCore

function Convert-CmykJpegToPng($inputPath, $outputPath) {
    $fullInput = (Resolve-Path $inputPath).Path
    $uri = New-Object System.Uri($fullInput)
    $decoder = [System.Windows.Media.Imaging.BitmapDecoder]::Create($uri, [System.Windows.Media.Imaging.BitmapCreateOptions]::None, [System.Windows.Media.Imaging.BitmapCacheOption]::OnLoad)
    $frame = $decoder.Frames[0]
    
    $converted = New-Object System.Windows.Media.Imaging.FormatConvertedBitmap
    $converted.BeginInit()
    $converted.Source = $frame
    $converted.DestinationFormat = [System.Windows.Media.PixelFormats]::Bgr24
    $converted.EndInit()

    $encoder = New-Object System.Windows.Media.Imaging.PngBitmapEncoder
    $encoder.Frames.Add([System.Windows.Media.Imaging.BitmapFrame]::Create($converted))
    
    $fullOutput = [System.IO.Path]::GetFullPath($outputPath)
    $stream = [System.IO.File]::Create($fullOutput)
    $encoder.Save($stream)
    $stream.Close()
    Write-Output "Saved: $fullOutput"
}

Convert-CmykJpegToPng "public/imagenes/lc350pm-extracted-0.jpg" "public/imagenes/cortadora-lc350pm-real.png"
Convert-CmykJpegToPng "public/imagenes/gemini40-extracted-0.jpg" "public/imagenes/cortadora-gemini40-real.png"
