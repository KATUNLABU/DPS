Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName System.Drawing

function Invert-ImageColors($inputPng, $outputPng) {
    $bmp = [System.Drawing.Bitmap]::FromFile((Resolve-Path $inputPng).Path)
    $w = $bmp.Width
    $h = $bmp.Height
    $rect = New-Object System.Drawing.Rectangle(0, 0, $w, $h)
    $data = $bmp.LockBits($rect, [System.Drawing.Imaging.ImageLockMode]::ReadWrite, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    
    $stride = $data.Stride
    $bytes = New-Object byte[] ($stride * $h)
    [System.Runtime.InteropServices.Marshal]::Copy($data.Scan0, $bytes, 0, $bytes.Length)

    for ($y = 0; $y -lt $h; $y++) {
        $rowStart = $y * $stride
        for ($x = 0; $x -lt $w; $x++) {
            $idx = $rowStart + ($x * 3)
            # Invert RGB bytes
            $bytes[$idx] = [byte](255 - $bytes[$idx])
            $bytes[$idx + 1] = [byte](255 - $bytes[$idx + 1])
            $bytes[$idx + 2] = [byte](255 - $bytes[$idx + 2])
        }
    }

    [System.Runtime.InteropServices.Marshal]::Copy($bytes, 0, $data.Scan0, $bytes.Length)
    $bmp.UnlockBits($data)
    $fullOutput = [System.IO.Path]::GetFullPath($outputPng)
    $bmp.Save($fullOutput, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Output "Successfully inverted colors: $fullOutput"
}

Invert-ImageColors "public/imagenes/cortadora-lc350pm-real.png" "public/imagenes/lc-350-pm-real-color.png"
Invert-ImageColors "public/imagenes/cortadora-gemini40-real.png" "public/imagenes/gemini-40-real-color.png"
