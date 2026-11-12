# Tlacuilolli

Tlacuilolli is a Typst library for research notes and scholarly essays. It starts with a centered title and justified serif prose on US Letter or A4. Photographs, equations, quotations, and tables sit in the running text. The same package supports English and Spanish documents.

The project takes its name from the Nahuatl word `tlacuilolli`, recorded in the Gran Diccionario Náhuatl as “escritura, pintura.” [Dictionary entry at UNAM](https://tlachia.iib.unam.mx/elementos/tlacuilolli)

## Start writing

Use Typst 0.15.1 or newer. This import will be available after the package is published on Typst Universe.

```typst
#import "@preview/tlacuilolli:0.1.0": *

#show: note-document.with(
  title: [Cuaderno de lectura],
  subtitle: [Notas sobre una primera edición],
  category: [Literatura],
  lang: "es",
)

Aquí comienza mi investigación.
```

To try this example before publication, use the local package import below. In a note stored in this repository's `examples/` directory, you can also use `#import "../lib.typ": *`.

The default body font is Libertinus Serif with New Computer Modern as the next choice. Both families ship with the official Typst CLI. Display and inline mathematics use Typst's bundled math font. Pass `font` to choose an installed family or an ordered list of families.

## Install as a local package

Copy `lib.typ`, `typst.toml`, `LICENSE`, and `src/` into the version directory for your platform. Run the copy commands from the repository root.

| Platform | Version directory |
| --- | --- |
| Windows | `%APPDATA%\typst\packages\local\tlacuilolli\0.1.0` |
| Linux | `$XDG_DATA_HOME/typst/packages/local/tlacuilolli/0.1.0`, or `~/.local/share/typst/packages/local/tlacuilolli/0.1.0` |
| macOS | `~/Library/Application Support/typst/packages/local/tlacuilolli/0.1.0` |

```powershell
$tlacuilolliPackage = Join-Path $env:APPDATA 'typst\packages\local\tlacuilolli\0.1.0'
New-Item -ItemType Directory -Force -Path $tlacuilolliPackage | Out-Null
Copy-Item -Path lib.typ, typst.toml, LICENSE, src -Destination $tlacuilolliPackage -Recurse -Force
```

```sh
# Linux
tlacuilolli_package="${XDG_DATA_HOME:-$HOME/.local/share}/typst/packages/local/tlacuilolli/0.1.0"
# macOS uses the following path instead of the Linux assignment above.
# tlacuilolli_package="$HOME/Library/Application Support/typst/packages/local/tlacuilolli/0.1.0"
mkdir -p "$tlacuilolli_package"
cp lib.typ typst.toml LICENSE "$tlacuilolli_package/"
cp -R src "$tlacuilolli_package/"
```

In your own project, use the same show rule with this import.

```typst
#import "@local/tlacuilolli:0.1.0": *
```

During development, rerun the copy commands after edits. If a module is removed, remove the corresponding old file from the installed copy. On a version bump, install to a new version directory and update the import in the consuming document. Typst also accepts `--package-path` for a custom package root. See [Typst's local package instructions](https://github.com/typst/packages#local-packages).

## Public API

| Functions | Purpose |
| --- | --- |
| `note-document` | Page layout, type, title, and PDF metadata |
| `image-left`, `image-right`, `image-center` | Figures with optional captions |
| `display-equation` | Native display math with optional numbering and references |
| `inner`, `set-builder`, `derivative`, `partial-derivative` | Mathematical notation |
| `theorem`, `definition`, `lemma`, `proposition`, `corollary`, `axiom`, `example`, `remark` | Bilingual statements with independent, document-wide counters |
| `proof` | Unnumbered proof with an optional closing mark |
| `roman-list`, `note-table` | Native enumerations and tables with restrained styling |

Side figures use two fixed columns. Long prose can continue in its column across pages, and the text after the macro resumes at full width. Use native `@key` citations and `#bibliography(...)` with your own `.bib` or Hayagriva file. The [API reference](docs/api.md) documents parameters, examples, and page-break behavior.

Tables size their columns to the contents by default. For a wider table, specify flexible tracks such as `columns: (2fr, 1fr)`.

## Examples and development

- [Physics](examples/atomic-bomb.typ) covers the Manhattan Project, Oppenheimer's doctoral research, and his leadership at Los Alamos with archival images and a TikZ chronology.
- [Mathematics](examples/mathematics.typ) uses a TikZ projection diagram, a geometric proof, cross-references, and a compact table.
- [Literature](examples/literature.typ) uses a block quotation and an illustration from an early edition of the novel.

The three examples use the same US Letter layout, type sizes, and spacing. Each ends with a dedicated page of references.

From the repository root, run the test script with PowerShell 7.

```text
pwsh -NoProfile -File tests/run.ps1
```

The script builds the PDFs and a PNG of the physics opening page under `build/`. It also checks document-wide counters, both languages, native references, figure geometry and pagination, repeating table headers, and a staged `@local` import. GitHub Actions runs the same script. To compile or preview an example directly, create the `build/` directory and run the following commands.

```sh
typst compile --root . examples/atomic-bomb.typ build/atomic-bomb.pdf
typst compile --root . --pages 1 --ppi 130 examples/atomic-bomb.typ build/atomic-bomb-preview.png
```

### Figures and image size

The [diagram sources](examples/diagrams/) are standalone LaTeX files. The examples embed vector PDF and SVG from `examples/assets/`. To regenerate a figure, run the [TikZ renderer](.agents/skills/tikz-diagrams/scripts/render_diagram.py) with Tectonic on PATH. SVG export also uses PyMuPDF 1.x.

```sh
python .agents/skills/tikz-diagrams/scripts/render_diagram.py examples/diagrams/oppenheimer.tex examples/assets/oppenheimer.pdf
python .agents/skills/tikz-diagrams/scripts/render_diagram.py examples/diagrams/projection.tex examples/assets/projection.svg
```

The [image optimizer](.agents/skills/document-images/scripts/prepare_image.py) uses Pillow to size rasters by printed width and target DPI. The [image credits](examples/assets/CREDITS.md) record the source files and optimization settings. Building the examples from the supplied assets requires only Typst.

### Codex workflows

Open the repository in Codex to use [`$tikz-diagrams`](.agents/skills/tikz-diagrams/SKILL.md) for figures or [`$document-images`](.agents/skills/document-images/SKILL.md) for sourcing and compression. The repository also defines [`tikz_diagrammer`](.codex/agents/tikz_diagrammer.toml) and [`document_image_editor`](.codex/agents/document_image_editor.toml) for scoped delegation. [Codex skills documentation](https://learn.chatgpt.com/docs/build-skills) · [Custom subagents](https://learn.chatgpt.com/docs/agent-configuration/subagents)

## License and package name

The code and original diagrams use the [MIT license](LICENSE). Archival images have separate [credits and public-domain records](examples/assets/CREDITS.md).

The local package is `@local/tlacuilolli:0.1.0`. See the [publishing guide](docs/publishing.md) for the first GitHub push, a versioned release, and a separate Typst Universe submission.
