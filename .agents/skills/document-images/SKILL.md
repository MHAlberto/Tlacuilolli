---
name: document-images
description: Find, credit, download, and compress images for documents or reduce a PDF dominated by photos, scans, or illustrations.
---

# Document images

## Source and credit

- Look for the original museum, library, agency, publisher, or creator's asset page. Record the creator, title or description, date, license or rights statement, source page, and direct file URL. Check redistribution rights for the intended destination, including public GitHub repositories.
- Download the authorized image to a temporary or ignored folder such as `build/originals/`. For a verified direct URL use `curl --fail --location --output build/originals/photo.jpg "https://…"`. Check that the downloaded file opens as the claimed image. Keep the original available for review and use the credited derivative in the document.
- In Tlacuilolli, add that record to [CREDITS.md](../../../examples/assets/CREDITS.md). Supply alt text in the document. [Wikimedia Commons reuse guide](https://commons.wikimedia.org/wiki/Commons:Reusing_content_outside_Wikimedia)

## Prepare the asset

- Keep source diagrams as vectors. For a photo, start with JPEG around quality 85 and 250 pixels per printed inch. Use PNG for transparency and raster artwork that needs crisp edges. Convert a monochrome scan to grayscale when its color carries no information.
- Use the largest placed width, including the pre-clip width when the layout enlarges a crop. [prepare_image.py](scripts/prepare_image.py) calculates the required pixels, keeps the aspect ratio, and writes a separate derivative. Install Pillow with `python -m pip install "Pillow>=11"`.
- Compare the before and after byte counts, compile the document, and inspect the rendered pages at the intended scale. Look at faces, halftones, thin lines, and legible text. If details suffer, raise resolution or quality on the affected asset. Prefer optimizing the source images over rasterizing PDF pages.

```sh
python .agents/skills/document-images/scripts/prepare_image.py build/originals/photo.jpg examples/assets/photo.jpg --width-mm 62 --dpi 250 --quality 85 --grayscale
```
