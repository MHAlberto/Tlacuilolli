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
    $stagedPackage = Join-Path $packagePath 'local/tlacuilolli/0.4.0'
    New-Item -ItemType Directory -Path $stagedPackage -Force | Out-Null
    Copy-Item -Path lib.typ, typst.toml, LICENSE, src -Destination $stagedPackage -Recurse -Force

    foreach ($example in 'atomic-bomb', 'mathematics', 'literature', 'code') {
        Write-Host "Compiling $example"
        Invoke-Typst compile --root . "examples/$example.typ" "build/$example.pdf"
    }
    Invoke-Typst compile --root . --pages 1 --ppi 130 examples/atomic-bomb.typ build/atomic-bomb-preview.png
    Invoke-Typst compile --root . --pages 1-3 --ppi 112 examples/code.typ 'build/code-preview-{p}.png'
    Invoke-Typst compile --root . docs/manual.typ build/manual.pdf

    foreach ($fixture in 'semantics', 'pagination', 'local-package') {
        Write-Host "Checking $fixture"
        Invoke-Typst compile --root . --package-path $packagePath "tests/$fixture.typ" "build/tests/$fixture.pdf"
    }
}
finally {
    Pop-Location
}
