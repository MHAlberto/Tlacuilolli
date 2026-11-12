---
name: tikz-diagrams
description: Build or revise editable TikZ figures for documents, including plots, timelines, concept maps, and geometry, and export them as vector PDF or SVG.
---

# TikZ diagrams

1. Identify the claim, relationship, or dataset that the figure should communicate. Check the underlying data or dates before choosing geometry. Use positions proportional to time for a scale timeline. An evenly spaced milestone sequence can use a caption that describes it as a selection of milestones.
2. Keep the editable source in a standalone TeX document. Borrow line weights, labels, and proportions from the document. For Tlacuilolli, see the [chronology](../../../examples/diagrams/oppenheimer.tex) and [projection figure](../../../examples/diagrams/projection.tex). Use the [line plot](assets/line-plot.tex) for a small fixed dataset and the [concept map](assets/concept-map.tex) for labeled relationships. Use PGFPlots with the source data for axes, scales, or series that need automatic layout.
3. Run [render_diagram.py](scripts/render_diagram.py) with the source and desired output path. PDF preserves text and can be smaller for label-heavy figures. SVG outlines labels to preserve their appearance across machines and works for Typst PDF/A and PDF/UA exports. Both formats stay vector.
4. Add an accessible image description in the host document. Compile and inspect the figure at its placed width. Check labels and diacritics, arrows, ticks and units, overlaps, and captions. Record the byte size if weight matters.

```sh
python .agents/skills/tikz-diagrams/scripts/render_diagram.py examples/diagrams/oppenheimer.tex examples/assets/oppenheimer.svg
```

The script uses Tectonic and accepts `--tectonic` for an executable outside PATH. SVG export also uses PyMuPDF (`python -m pip install "PyMuPDF>=1.24.3,<2"`). A Tectonic installation can fetch TeX resources on its first compilation. [TikZ and PGF manual](https://tikz.dev/) · [PyMuPDF SVG export](https://pymupdf.readthedocs.io/en/latest/page.html#Page.get_svg_image)
