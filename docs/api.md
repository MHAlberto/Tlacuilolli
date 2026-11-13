# Tlacuilolli API

Import `lib.typ` or `@local/tlacuilolli:0.4.0` once at the start of the document. The examples below assume a wildcard import. The [PDF manual](manual.pdf) shows what the macros render.

## `note-document`

```typst
#show: note-document.with(
  title: [Field notes],
  subtitle: [Observations from a winter survey],
  category: [Ecology],
  paper: "a4",
  author: "A. Researcher",
  date: datetime(year: 2026, month: 1, day: 3),
  show-byline: true,
  description: [A survey of the winter habitat.],
  keywords: ("ecology", "winter survey"),
  font-size: 12pt,
  show-page-number: true,
)
```

The signature is `note-document(title:, subtitle:, category:, author:, date:, description:, keywords:, show-byline:, lang:, paper:, font:, font-size:, equation-size:, margin:, show-page-number:, title-size:, title-font:, subtitle-size:, category-size:, leading:, paragraph-spacing:, body)`. Use a show rule to supply `body` automatically.

| Option | Accepted values and defaults |
| --- | --- |
| `title` | Required text or Typst content. The visible title also supplies the PDF title. |
| `subtitle`, `category` | Text or content. Both default to `none`. |
| `author` | A string or array of strings. Defaults to `none`. Also supplies PDF authors. |
| `date` | A Typst `datetime` with a date component, or `none` (default). It appears as an ISO date and supplies the PDF date. |
| `description` | Optional content for the PDF subject. Defaults to `none`. |
| `keywords` | A string or array of strings for the PDF keywords. Defaults to `()`. |
| `show-byline` | Defaults to `false`. Set it to `true` to show the author and date beneath the title. |
| `lang` | A native Typst language code, default `"en"`. Use `"es"` for Spanish text and statement names. |
| `paper` | A native Typst paper name, including `"us-letter"` (default) and `"a4"`. |
| `font` | A family name or ordered array of family names. Defaults to `("New Computer Modern", "Libertinus Serif")`. |
| `font-size` | Body type size, default `13pt`. |
| `equation-size` | Size of displayed equations, including those made with `display-equation`. Defaults to `0.95em` relative to the surrounding text. |
| `margin` | A length or native page-margin dictionary, default `(x: 0.64in, top: 0.56in, bottom: 0.58in)`. |
| `show-page-number` | Set to `true` for centered page numbers at the bottom. Defaults to `false`. |
| `title-size`, `subtitle-size`, `category-size` | Lengths relative to the body size when written in `em`. Defaults are `3.8em`, `1.34em`, and `0.86em`. |
| `title-font` | A family name or ordered array of family names. Defaults to `auto`, which uses `font`. |
| `leading`, `paragraph-spacing` | Native paragraph lengths, default `0.66em` and `1.28em`. |

The title stays with the start of the body. Headings retain native semantics and default to unnumbered. Ordinary paragraphs inherit Typst's widow and orphan control. Hyphenation is off by default. Use `#set text(hyphenate: auto)` to restore Typst's language-aware hyphenation. Write headings, block quotes, footnotes, and inline equations in ordinary Typst syntax. [Typst page setup](https://typst.app/docs/guides/page-setup/)

### Typography

Use this show rule in place of the first example to pair EB Garamond titles with New Computer Modern body text and make displayed equations a little smaller.

```typst
#show: note-document.with(
  title: [Notas de investigación],
  lang: "es",
  title-font: ("EB Garamond", "New Computer Modern"),
  equation-size: 0.9em,
)
```

Use `font: "Libertinus Serif"` for the original text face, or `font: ("STIX Two Text", "New Computer Modern")` for another scholarly serif. EB Garamond and STIX Two Text must be available to Typst. In the web editor, check the font picker and upload a font file if needed. For the CLI, install the font or use `--font-path`. Equations use Typst's math font. [Typst font selection](https://typst.app/docs/reference/text/text/#parameters-font)

## Figures

```text
image-left(graphic, caption: none, width: 34%, height: auto,
           gutter: 1.48em, vertical: top, spacing: 2.38em, body)
image-right(graphic, caption: none, width: 34%, height: auto,
            gutter: 1.48em, vertical: top, spacing: 2.38em, body)
image-center(graphic, caption: none, width: 75%, height: auto,
             spacing: 1.12em)
```

- `graphic` is usually native `image(...)` content. Supply `alt` on the image for a text description. File formats follow the installed Typst compiler.
- `caption` is optional content below the graphic. The graphic and caption occupy the same unnumbered native figure.
- `width` is the panel width as a percentage of available width or a length. When using an `image`, the panel supplies its default width and optional `height`. When both dimensions are constrained, the default fit preserves the aspect ratio. Explicit options on the caller's image take precedence.
- `gutter` is the gap between columns. `vertical` aligns the graphic column within its row, using `top`, `horizon`, or `bottom`.
- `spacing` is the requested block spacing above and below the figure layout. `body` accepts regular prose, including multiple paragraphs, emphasis, and math.

Side figures reserve two columns for the whole macro. A long aside continues in its prose column on later pages. Content after the macro resumes at full width. Choose a graphic and caption that fit together on a page. [Typst image options and supported formats](https://typst.app/docs/reference/visualize/image/)

```typst
#image-left(image("../examples/assets/oppenheimer.jpg", alt: "Oppenheimer"),
  caption: [Ed Westcott, 1946.], height: 120pt,
)[
  This portrait was taken at Oak Ridge.
]

#image-right(image("../examples/assets/los-alamos.jpg", alt: "Four people at Los Alamos"),
  width: 38%, caption: [Los Alamos, 1944.],
)[
  The photograph records a gathering at Oppenheimer's home.
]

#image-center(image("../examples/assets/oppenheimer.pdf", alt: "Three milestones in Oppenheimer's career"),
  caption: [From Göttingen to Los Alamos.],
)
```

These paths assume a document one directory below the repository root. In an installed-package document, use paths relative to the file containing the `image(...)` call.

The examples include diagrams drawn in TikZ and exported as vector PDF or SVG. Use SVG versions of diagrams for Typst exports that require a PDF/A or PDF/UA standard. [Typst guidance for PDF images](https://typst.app/docs/reference/visualize/image/#pdf)

## Mathematics

```text
equation(expression, numbering: "(1)", number-align: end + horizon,
         spacing: auto, ref-label: none)
display-equation(expression, numbering: none, number-align: end + horizon,
                 spacing: auto, ref-label: none)
inner(first, second)
set-builder(element, condition)
derivative(function, variable, order: 1)
partial-derivative(function, variable, order: 1)
```

Both helpers center Typst math content such as `$x^2$`. `equation` automatically prints (1), (2), and so on. `display-equation` is unnumbered by default. Numbered displays share Typst's native equation counter. Use Typst's `&` alignment points and `\` line breaks for derivations. `numbering` accepts a native pattern or function and `number-align` controls the number position. The default spacing is `1.18em` above and `1.5em` below. Set `spacing` to apply the same gap on both sides. Supply `ref-label: <key>` on a numbered display to cite it using `@key`.

```typst
The inline equation $a^2 + b^2 = c^2$ uses ordinary Typst math.

#equation(
  $ (x + y)^2 &= (x + y)(x + y) \
               &= x^2 + 2 x y + y^2 $,
  ref-label: <expand>,
)

See @expand.
```

`inner` encloses two expressions in scalable angle brackets. `set-builder` takes an element expression and a condition and inserts a scalable separator. The derivative helpers take an expression and a differentiation variable as math content. `order` is a positive integer. The partial derivative repeats differentiation with respect to a single variable. Use the native `abs` and `norm` delimiters inside math mode.

```typst
The inner product #inner($x$, $u$) vanishes on
#set-builder($x in RR^n$, $#inner($x$, $u$) = 0$).

The norm $norm(x)$ and the absolute value $abs(t)$ use native math.
Compare #derivative($q$, $t$, order: 2) with #partial-derivative($f$, $x$).
```

## Mathematical environments

`theorem`, `definition`, `lemma`, `proposition`, `corollary`, `axiom`, `example`, and `remark` each have the signature `(title: none, lang: auto, numbered: true, ref-label: none, body)`.

- `title` is optional content shown in parentheses.
- `lang` inherits the text language at the call site. Pass `"en"` or `"es"` to select the statement name for one call. Other document languages use English statement names.
- `numbered` enables the environment's own document-wide counter. Set it to `false` for a single unnumbered statement.
- `ref-label` takes a native label such as `<identity>` on a numbered statement. Refer to it with `@identity`.
- `body` accepts normal prose and block content. Long statements can span pages.

`proof(title: none, lang: auto, qed: sym.square.stroked, body)` shares the title, language, and body options. Proofs are unnumbered. Pass a symbol or content to change the closing mark, or `qed: none` to omit it. When a proof ends with display math, the automatic closing mark can appear on the following line.

```typst
#definition[An additive identity $e$ satisfies $x + e = x$.]
#axiom[Real numbers are closed under addition.]
#lemma[For any real $x$, $x + 0 = x$.]
#theorem(title: [Uniqueness], ref-label: <identity>)[
  The additive identity in the reals is unique.
]
#proof[
  If $e$ and $e'$ are identities, then $e = e + e' = e'$.
]
#proposition[The additive inverse of $0$ is $0$.]
#corollary[An additive identity is its own inverse.]
#example[For $x = 2$, the identity gives $2 + 0 = 2$.]
#remark(numbered: false)[The argument extends to additive groups.]

See @identity.
```

## Source code

Fenced code blocks in a `note-document` get syntax highlighting and a line-number gutter. The language tag selects the syntax colors. Inline backticks remain useful for short names such as `main`.

````typst
```python
def squared(x):
    return x * x

print(squared(4))
```
````

`code-listing(body, lang: auto, title: none, start: 1, numbers: true)` applies the same style with optional controls. Use a string or a fenced raw block as `body`. A raw block supplies its language automatically. Set `lang` for a string, `title` for a caption above the listing, `start` to begin at a source file's line number, or `numbers: false` to hide the gutter.

```typst
#code-listing(
  "int squared(int x) {\n    return x * x;\n}",
  lang: "cpp",
  title: [Square a value],
  start: 12,
)
```

Common tags include `python`, `rust`, `c`, `cpp`, `java`, `javascript`, `ts`, `bash`, `sql`, `json`, `yaml`, `html`, `css`, `go`, and `typ`. Use `cpp` on fences for C++. The formatter uses Typst's native syntax definitions. Tabs use four columns, blank source lines are numbered, and wrapped continuations are indented under their original line. [Typst raw code documentation](https://typst.app/docs/reference/text/raw/)

## Lists and tables

`roman-list(..items, style: "upper", start: 1, full: false, tight: true)` wraps a native enumeration. Each positional item is content. Choose `"upper"`, `"lower"`, or `"decimal"` for `I.`, `i.`, or `1.` markers. `start` is the initial positive integer. The native `full` option includes parent numbers when nested. Set `tight: false` for looser spacing.

```typst
#roman-list(
  [Read the introduction.
    #roman-list([Identify the claim.], [Mark the evidence.], style: "lower")
  ],
  [Write a response.],
)
#roman-list([First decimal item.], style: "decimal")
```

`note-table(..cells, columns: auto, header: (), caption: none, align: start, placement: center, font-size: 0.93em, inset: (x: 0.75em, y: 0.38em), rule: true)` takes native table cells in row order.

- With `columns: auto`, the table infers the column count from `header` and sizes each column to its contents. With no header, specify a count for tables with multiple columns. Pass native track sizes such as `(2fr, 1fr)` to fill the available width or `(9em, auto)` to fix an individual column.
- `header` is an array of content for one bold semantic header row. It repeats on subsequent pages. `rule` controls the light rule below it.
- `caption` is optional content above the table. It appears at the start of a captioned table.
- `align` accepts a native alignment or per-column array for cells. Use `end` for right-aligned numeric columns in left-to-right text. `placement` aligns the whole table and caption within the page. `font-size` and `inset` control cell type size and padding.

Long tables can break across pages with or without a caption. [Typst table guide](https://typst.app/docs/guides/tables/)

```typst
#note-table(
  header: ([Vector], [Length]),
  align: (start, end),
  caption: [Two Euclidean lengths.],
  [$(3, 4)$], [$5$],
  [$(1, 1)$], [$sqrt(2)$],
)
```

## Citations and references

Call native `bibliography` at the top level of your document, typically after the main text. Tlacuilolli starts it on a fresh page and starts any subsequent prose on another page. Long bibliographies can continue across pages. Typst resolves the bibliography path relative to the file containing the call. Supported sources include BibLaTeX `.bib` and Hayagriva `.yaml` files. Use `@key` or `#cite(<key>, supplement: ...)` inline.

```typst
The opening sentence is central to the reading #cite(<austen>, supplement: [chap. 1]).

#bibliography("../examples/assets/references.bib", title: [References], style: "chicago-author-date")
```

Built-in styles include `"ieee"`, `"apa"`, `"chicago-author-date"`, and `"american-physics-society"`. Typst can also load custom CSL files. [Typst bibliography and citation styles](https://typst.app/docs/reference/model/bibliography/)
