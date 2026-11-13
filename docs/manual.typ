#import "../lib.typ": *

#show: note-document.with(
  title: [Tlacuilolli manual],
  subtitle: [A guide to the public Typst macros],
  category: [Documentation],
  author: "Folio Notes contributors",
  description: [Usage examples for every public macro in Tlacuilolli 0.4.0.],
  keywords: ("Typst", "Tlacuilolli", "manual"),
  show-page-number: true,
  title-size: 3.45em,
)

= Start a note

Use Typst 0.15.1 or newer. In the web app, upload `lib.typ` and the
`src` folder from the #link("https://github.com/MHAlberto/Tlacuilolli/tree/v0.4.0")[release source]
beside `main.typ`. Use this show rule once, then write the note below it.

```typ
#import "lib.typ": *

#show: note-document.with(
  title: [Field notes],
  subtitle: [A first observation],
  category: [Mathematics],
  author: "Ada Rivera",
  lang: "en",
  show-page-number: true,
)

Start writing here. Inline math looks like $x^2$.
```

The title is required. Set `lang: "es"` for Spanish statement names or
`paper: "a4"` for A4. The author goes into PDF metadata. Set
`show-byline: true` to print it under the title.

#outline(title: [Contents], depth: 1)

#pagebreak()

= Equations and notation

Use `equation` for displays numbered (1), (2), and so on. Give a display
a `ref-label` to cite it by number. `display-equation` is unnumbered by
default and accepts the same options for numbering, alignment, and spacing.

```typ
#equation($a^2 + b^2 = c^2$, ref-label: <pythagoras>)
See @pythagoras for the squared lengths.
#display-equation($c = sqrt(a^2 + b^2)$)
#equation($c^2 - a^2 = b^2$, ref-label: <rearranged>)
```

#equation($a^2 + b^2 = c^2$, ref-label: <pythagoras>)
See @pythagoras for the squared lengths.
#display-equation($c = sqrt(a^2 + b^2)$)
#equation($c^2 - a^2 = b^2$, ref-label: <rearranged>)

The unnumbered display leaves the next number available. Use ordinary
`$x^2$` for inline math. `equation-size` in `note-document` changes
the display type size, and `spacing` on a display sets both outer gaps.
Native equation references are documented in @typst-equation.

== Inline notation

```typ
Inner product #inner($x$, $u$).
Set #set-builder($x in RR$, $x > 0$).
Ordinary derivative #derivative($q$, $t$, order: 2).
Partial derivative #partial-derivative($f$, $x$).
```

Inner product #inner($x$, $u$). Set #set-builder($x in RR$, $x > 0$).
Ordinary derivative #derivative($q$, $t$, order: 2).
Partial derivative #partial-derivative($f$, $x$).

#pagebreak()

= Mathematical statements

Each statement type has its own counter. Set `title` to add a name in
parentheses, `numbered: false` to omit the number, or `lang: "es"` to
override the document language for one statement. Reference a numbered
statement with `ref-label` and `@key`.

```typ
#definition(title: [Identity])[$e$ is an identity if $x + e = x$.]
#axiom[Addition of real numbers is commutative.]
#lemma[Zero is an additive identity for the real numbers.]
#theorem(ref-label: <unique-identity>)[The identity is unique.]
#proof[
  If $e$ and $f$ are identities, then $e = e + f = f$.
]
#proposition[The additive inverse of zero is zero.]
#corollary[Every real number has the same additive identity.]
#example[Adding zero to three gives three.]
#remark(numbered: false)[This example uses the real numbers.]
See @unique-identity.
```

#definition(title: [Identity])[$e$ is an identity if $x + e = x$.]
#axiom[Addition of real numbers is commutative.]
#lemma[Zero is an additive identity for the real numbers.]
#theorem(ref-label: <unique-identity>)[The identity is unique.]
#proof[
  If $e$ and $f$ are identities, then $e = e + f = f$.
]
#proposition[The additive inverse of zero is zero.]
#corollary[Every real number has the same additive identity.]
#example[Adding zero to three gives three.]
#remark(numbered: false)[This example uses the real numbers.]
See @unique-identity.

Use `qed: none` to omit the closing square from a proof.

#pagebreak()

= Figures

Give each graphic a text description with `alt`. The two side layouts
take prose in a trailing content block. Use `width` to size the image
panel and `gutter` to adjust the gap next to the prose. Copy
`projection.svg` beside your file to run these examples.

```typ
#let diagram = image("projection.svg", alt: "Projection triangle")
#image-left(diagram, caption: [The projection.], width: 27%)[
  The horizontal leg shows the component along the line.
]
#image-right(diagram, caption: [The remainder.], width: 27%)[
  The vertical leg is perpendicular to the line.
]
#image-center(diagram, caption: [Orthogonal components.], width: 31%)
```

#let diagram = image("../examples/assets/projection.svg", alt: "Projection triangle")
#image-left(diagram, caption: [The projection.], width: 27%)[
  The horizontal leg shows the component along the line.
]
#image-right(diagram, caption: [The remainder.], width: 27%)[
  The vertical leg is perpendicular to the line.
]
#image-center(diagram, caption: [Orthogonal components.], width: 31%)

The source diagram ships in `examples/assets/projection.svg`. The
caption is optional and appears beneath the graphic.

#pagebreak()

= Lists and tables

`roman-list` takes content items. Set `style: "lower"` for lowercase
Roman numerals or `style: "decimal"` for Arabic numerals. `start`
changes the first number and `tight: false` opens the list spacing.

```typ
#roman-list([Collect the samples.], [Record their units.])
#roman-list([Review the values.], style: "lower", start: 3)
```

#roman-list([Collect the samples.], [Record their units.])
#roman-list([Review the values.], style: "lower", start: 3)

`note-table` takes cells in row order. A `header` repeats across
pages. Columns size to their contents by default. Use `columns` to
specify tracks and `align` to align each column.

```typ
#note-table(
  header: ([Measurement], [Length (cm)]),
  align: (start, end),
  caption: [Two recorded measurements.],
  [First], [3.2],
  [Second], [5.1],
)
```

#note-table(
  header: ([Measurement], [Length (cm)]),
  align: (start, end),
  caption: [Two recorded measurements.],
  [First], [3.2],
  [Second], [5.1],
)

#pagebreak()

= Code and references

Fence code with a language tag to select syntax highlighting. Use
`typ` for Typst source. The listing starts directly with code.

````typ
```typ
#let length = 3.2
The first measurement is #length cm.
```
````

Use `code-listing` when an excerpt needs to start at a specific line.
Pass a string or a raw block. Set `numbers: false` to hide the gutter.

````typ
#code-listing(
  ```typ
  #let length = 3.2
  The first measurement is #length cm.
  ```,
  start: 12,
)
````

#code-listing(
  ```typ
  #let length = 3.2
  The first measurement is #length cm.
  ```,
  start: 12,
)

Use Typst's native `@key` citations and place `bibliography` at the
end of the document. Tlacuilolli starts the references on a fresh page.
Language tags and bibliography formats are described in @typst-raw and
@typst-bibliography.

```typ
See @typst-raw for language tags.
#bibliography("manual-references.bib", style: "ieee")
```

#bibliography("manual-references.bib", title: [References], style: "ieee")
