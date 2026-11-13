$ErrorActionPreference = 'Stop'

function Invoke-Typst {
    & typst @args
    if ($LASTEXITCODE -ne 0) {
        throw "Typst exited with code $LASTEXITCODE."
    }
}

Push-Location (Join-Path $PSScriptRoot '..')
try {
    $packagePath = 'build/tests/packages'
    $stagedPackage = Join-Path $packagePath 'local/tlacuilolli/0.0.2'
    New-Item -ItemType Directory -Path $stagedPackage -Force | Out-Null
    Copy-Item -Path lib.typ, typst.toml, LICENSE, src -Destination $stagedPackage -Recurse -Force

    foreach ($example in 'atomic-bomb', 'mathematics', 'literature') {
        Write-Host "Compiling $example"
        Invoke-Typst compile --root . "examples/$example.typ" "build/$example.pdf"
    }
    Invoke-Typst compile --root . --pages 1 --ppi 130 examples/atomic-bomb.typ build/atomic-bomb-preview.png

    foreach ($fixture in 'semantics', 'pagination', 'local-package') {
        Write-Host "Checking $fixture"
        Invoke-Typst compile --root . --package-path $packagePath "tests/$fixture.typ" "build/tests/$fixture.pdf"
    }
}
finally {
    Pop-Location
}
