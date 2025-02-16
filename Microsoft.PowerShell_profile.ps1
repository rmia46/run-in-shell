# function to run source files and then write the output to output.txt file
# It looks for input in the input.txt file
# usage runf <filename>
function runf {
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$filename
    )

    $extension = [System.IO.Path]::GetExtension($filename).ToLower()

    $inputFile = "input.txt"
    $outputFile = "output.txt"

    switch ($extension) {
        ".c" {
            $output = & gcc $filename -o output.exe 2>&1
            if ($LASTEXITCODE -eq 0) {
                & Get-Content $inputFile | .\output.exe | Set-Content $outputFile
            } else {
                Write-Output $output
            }
        }

        ".cpp" {
            $output = & g++ $filename -Wall -o output.exe 2>&1
            if ($LASTEXITCODE -eq 0) {
                & Get-Content $inputFile | .\output.exe | Set-Content $outputFile
            } else {
                Write-Output $output
            }
        }

        ".java" {
            $classname = [System.IO.Path]::GetFileNameWithoutExtension($filename)
            $output = & javac $filename 2>&1
            if ($LASTEXITCODE -eq 0) {
                & Get-Content $inputFile| java $classname | Set-Content $outputFile
            } else {
                Write-Output $output
            }
        }

        ".py" {
            & Get-Content $inputFile | python $filename | Set-Content $outputFile
        }

        ".rb" {
            & Get-Content $inputFile | ruby $filename | Set-Content $outputFile
        }

        ".js" {
            & Get-Content $inputFile | node $filename | Set-Content $outputFile
        }

        ".lua" {
            & Get-Content $inputFile | lua $filename | Set-Content $outputFile
        }

        default {
            Write-Output "Unsupported Source File"
        }
    }
}	

# function to run source files and then show the output to shell
# usage run <filename>

function run {
    param (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$filename
    )

    $extension = [System.IO.Path]::GetExtension($filename).ToLower()
    $outputExe = [System.IO.Path]::ChangeExtension($filename, ".exe")

    switch ($extension) {
        ".c" {
            $output = & gcc $filename -o $outputExe 2>&1
            if ($LASTEXITCODE -eq 0) {
                & .\$outputExe
            } else {
                Write-Output $output
            }
        }

        ".cpp" {
            $output = & g++ $filename -o $outputExe 2>&1
            if ($LASTEXITCODE -eq 0) {
                & .\$outputExe
            } else {
                Write-Output $output
            }
        }

        ".java" {
            $classname = [System.IO.Path]::GetFileNameWithoutExtension($filename)
            $output = & javac $filename 2>&1
            if ($LASTEXITCODE -eq 0) {
                & java $classname
            } else {
                Write-Output $output
            }
        }

        ".py" {
            & python $filename
        }

        ".rb" {
            & ruby $filename
        }

        ".js" {
            & node $filename
        }

        ".lua" {
            & lua $filename
        }

        default {
            Write-Output "Unsupported file extension: $extension"
        }
    }
}
