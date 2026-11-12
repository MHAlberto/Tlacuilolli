"""Compile a standalone TikZ source to a vector PDF or SVG."""

import argparse
from pathlib import Path
import subprocess
from tempfile import TemporaryDirectory


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path, help="standalone .tex source")
    parser.add_argument("output", type=Path, help="destination .pdf or .svg")
    parser.add_argument("--tectonic", default="tectonic", help="Tectonic executable")
    args = parser.parse_args()

    source = args.source.resolve()
    output = args.output.resolve()
    if source.suffix.lower() != ".tex" or not source.is_file():
        parser.error("source must be an existing .tex file")
    if output.suffix.lower() not in {".pdf", ".svg"}:
        parser.error("output must end in .pdf or .svg")

    if output.suffix.lower() == ".svg":
        try:
            from pymupdf import open as open_pdf
        except ImportError:
            parser.exit(1, 'SVG export requires PyMuPDF 1.x. Run: python -m pip install "PyMuPDF>=1.24.3,<2"\n')

    try:
        with TemporaryDirectory(prefix="tikz-diagram-") as scratch:
            subprocess.run(
                [args.tectonic, "--untrusted", "--outdir", scratch, str(source)],
                check=True,
            )
            pdf_path = Path(scratch) / source.with_suffix(".pdf").name
            if output.suffix.lower() == ".svg":
                with open_pdf(pdf_path) as document:
                    if document.page_count != 1:
                        parser.exit(1, "SVG export requires a single-page diagram.\n")
                    data = document[0].get_svg_image(text_as_path=True).encode("utf-8")
            else:
                data = pdf_path.read_bytes()
        output.parent.mkdir(parents=True, exist_ok=True)
        output.write_bytes(data)
    except (OSError, subprocess.CalledProcessError) as error:
        parser.exit(1, f"{error}\n")

    print(f"{args.output}: {len(data):,} bytes")


if __name__ == "__main__":
    main()
