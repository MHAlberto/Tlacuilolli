# Tlacuilolli

- Compile and check the examples with `pwsh -NoProfile -File tests/run.ps1`. They share the US Letter style in `src/document.typ` and use dedicated bibliography pages.
- Use the [TikZ skill](.agents/skills/tikz-diagrams/SKILL.md) for diagrams. Keep editable TeX sources in `examples/diagrams/` and compiled assets in `examples/assets/`.
- Use the [document images skill](.agents/skills/document-images/SKILL.md) when sourcing or compressing raster assets. Record provenance in `examples/assets/CREDITS.md` and compare rendered pages after replacing an image.
- Keep generated documents, downloads, and local tool installations under `build/`. See [Publishing](docs/publishing.md) for the GitHub release steps.
