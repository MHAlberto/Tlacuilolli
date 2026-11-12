"""Resize and compress a raster image for its printed width."""

import argparse
import math
from pathlib import Path
from tempfile import NamedTemporaryFile

from PIL import Image, ImageOps


def positive_number(raw: str) -> float:
    value = float(raw)
    if not math.isfinite(value) or value <= 0:
        raise argparse.ArgumentTypeError("expected a finite number greater than zero")
    return value


def prepare(source: Path, output: Path, pixels: int, quality: int, grayscale: bool) -> None:
    with Image.open(source) as original:
        if getattr(original, "n_frames", 1) != 1:
            raise ValueError("use a single-frame source")

        image = ImageOps.exif_transpose(original)
        source_size = image.size
        transparent = image.has_transparency_data
        jpeg = output.suffix.lower() in {".jpg", ".jpeg"}
        if jpeg and transparent:
            raise ValueError("use PNG to preserve transparency")

        if grayscale:
            mode = "LA" if transparent else "L"
        else:
            mode = "RGBA" if transparent else ("L" if image.mode == "L" else "RGB")
        profile = image.info.get("icc_profile") if image.mode == mode else None
        image = image.convert(mode)
        if image.width > pixels:
            height = max(1, round(image.height * pixels / image.width))
            image = image.resize((pixels, height), Image.Resampling.LANCZOS)

        # Remove camera metadata while retaining a compatible color profile.
        image.info.clear()
        options = {"optimize": True}
        if profile:
            options["icc_profile"] = profile
        if jpeg:
            options.update(quality=quality, progressive=True)

        output.parent.mkdir(parents=True, exist_ok=True)
        with NamedTemporaryFile(dir=output.parent, delete=False) as handle:
            pending = Path(handle.name)
        try:
            image.save(pending, format="JPEG" if jpeg else "PNG", **options)
            pending.replace(output)
        finally:
            pending.unlink(missing_ok=True)

        print(f"{source.name}: {source_size[0]} x {source_size[1]}, {source.stat().st_size:,} bytes")
        print(f"{output.name}: {image.width} x {image.height}, {output.stat().st_size:,} bytes")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path)
    parser.add_argument("output", type=Path, help="destination .jpg, .jpeg, or .png")
    parser.add_argument("--width-mm", required=True, type=positive_number, help="largest placed width")
    parser.add_argument("--dpi", type=positive_number, default=250, help="target pixels per inch")
    parser.add_argument("--quality", type=int, default=85, help="JPEG quality from 1 to 95")
    parser.add_argument("--grayscale", action="store_true", help="discard color in monochrome originals")
    args = parser.parse_args()

    if args.output.suffix.lower() not in {".jpg", ".jpeg", ".png"}:
        parser.error("output must end in .jpg, .jpeg, or .png")
    if args.source.resolve() == args.output.resolve():
        parser.error("source and output must be different files")
    if not 1 <= args.quality <= 95:
        parser.error("--quality must be between 1 and 95")

    try:
        target = max(1, round(args.width_mm * args.dpi / 25.4))
        prepare(args.source, args.output, target, args.quality, args.grayscale)
    except (OSError, ValueError, OverflowError, Image.DecompressionBombError) as error:
        parser.exit(1, f"{error}\n")


if __name__ == "__main__":
    main()
