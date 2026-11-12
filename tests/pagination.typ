#import "../lib.typ": *

#show: note-document.with(title: [Layout assertions], font-size: 11pt, title-size: 34pt)

#let graphic(id) = [
  #metadata(none)#id
  #image("../examples/assets/projection.svg", alt: "Sample mathematical diagram")
]
#let marker(id) = [#metadata(none)#id]

#image-left(graphic(<left-image>), caption: [#marker(<left-caption>) Left caption.])[
  #marker(<left-prose>) Prose to the right of the graphic.

  Another paragraph with _emphasis_, *weight*, and $x^2$.
]

#marker(<after-left>) Full-width text after the left figure.

#image-right(graphic(<right-image>), caption: [#marker(<right-caption>) Right caption.])[
  #marker(<right-prose>) Prose to the left of the graphic.

  Another paragraph alongside the image.
]

#marker(<after-right>) Full-width text after the right figure.

#place(top + right, marker(<right-edge>))

#image-center(graphic(<center-image>), width: 33%, caption: [#marker(<center-caption>) Centered caption.])

#note-table(
  header: ([#marker(<compact-first>) Item], [#marker(<compact-second>) Count]),
  caption: [A compact table.],
  align: (start, end),
  [A], [12],
)

#note-table(
  header: ([#marker(<start-table>) Item], [Count]),
  caption: [A start-aligned table.],
  placement: start,
  [B], [4],
)

#note-table(columns: 2, placement: end, [#marker(<end-table>) C], [7])

#pagebreak()

#theorem(ref-label: <long-theorem>)[
  #for _ in range(11) { [#lorem(72) #parbreak()] }
  #marker(<end-theorem>) The final paragraph of a theorem across pages.
]

#image-right(graphic(<tall-image>), caption: [#marker(<tall-caption>) Caption of the multi-page aside.])[
  #marker(<start-aside>) The first paragraph of a long aside.
  #parbreak()
  #for _ in range(8) { [#lorem(82) #parbreak()] }
  #marker(<end-aside>) The final paragraph of the aside.
]

#marker(<after-aside>) Full-width text after the multi-page aside.

#note-table(
  columns: (1fr, 1fr),
  align: (start, end),
  header: ([#marker(<header-cell>) Sample], [Value]),
  caption: [#marker(<table-caption>) Repeating header in a captioned table.],
  ..range(88).map(index => ([Observation #index], [#index])).flatten(),
  [#marker(<last-row>) Final observation], [88],
)

#pagebreak()
#v(653pt)

#image-left(
  graphic(<edge-image>),
  width: 48%,
  height: 96pt,
  caption: [#marker(<edge-caption>) Caption near a page boundary.],
)[
  #marker(<edge-prose>) The opening text travels with the figure.
]

#context {
  let pos = id => query(id).first().location().position()
  let content-width = pos(<right-edge>).x - pos(<after-left>).x
  let image-width = content-width * 0.34
  let gutter = 1.48 * 11pt
  assert(pos(<left-image>).x < pos(<left-prose>).x)
  assert(pos(<right-image>).x > pos(<right-prose>).x)
  assert(calc.abs(pos(<left-prose>).x - pos(<left-image>).x - image-width - gutter) < 0.1pt)
  assert(calc.abs(pos(<right-edge>).x - pos(<right-image>).x - image-width) < 0.1pt)
  assert.eq(pos(<after-left>).x, pos(<after-right>).x)
  assert.eq(pos(<after-left>).x, pos(<right-prose>).x)
  assert.eq(pos(<after-left>).x, pos(<after-aside>).x)
  assert(pos(<center-image>).x > pos(<after-left>).x)
  assert(pos(<center-image>).x < pos(<right-image>).x)
  assert.eq(pos(<compact-first>).y, pos(<compact-second>).y)
  assert(pos(<compact-first>).x > pos(<after-left>).x + 1in)
  assert(pos(<compact-second>).x < pos(<right-edge>).x - 1in)
  assert(pos(<start-table>).x < pos(<after-left>).x + 0.3in)
  assert(pos(<end-table>).x > pos(<right-edge>).x - 1in)
  for (graphic, caption) in ((<left-image>, <left-caption>), (<right-image>, <right-caption>), (<center-image>, <center-caption>), (<tall-image>, <tall-caption>)) {
    assert.eq(pos(graphic).page, pos(caption).page)
    assert(pos(graphic).y < pos(caption).y)
  }
  assert(pos(<long-theorem>).page < pos(<end-theorem>).page)
  assert.eq(pos(<start-aside>).page, pos(<tall-image>).page)
  assert(pos(<start-aside>).page < pos(<end-aside>).page)
  assert.eq(pos(<table-caption>).page, pos(<header-cell>).page)
  assert(pos(<table-caption>).y < pos(<header-cell>).y)
  assert(pos(<header-cell>).x < pos(<after-left>).x + 0.3in)
  assert(pos(<table-caption>).page < pos(<last-row>).page)
  let header-pages = query(<header-cell>).map(cell => cell.location().page())
  assert(pos(<last-row>).page in header-pages)
  assert.eq(pos(<edge-image>).page, pos(<edge-caption>).page)
  assert.eq(pos(<edge-image>).page, pos(<edge-prose>).page)
}
