#import "@local/tlacuilolli:0.0.2": *

#show: note-document.with(title: [Local package import], lang: "en", paper: "a4")

The entry point resolves its internal modules inside the package.

#image-center(
  image("../examples/assets/projection.svg", alt: "Sample mathematical diagram"),
  caption: [The caller resolves this image.],
)

#theorem(ref-label: <local-theorem>)[The local package supports native references.]

See @local-theorem and the opening chapter of Austen's novel @austen.

#metadata(none) <before-references>

#bibliography("../examples/assets/references.bib", title: [References], style: "apa")

#metadata(none) <after-references>
Prose resumes on its own page.

#context {
  assert.eq(query(<local-theorem>).first().supplement, [Theorem])
  let references = query(heading).find(it => it.body == [References])
  let before = query(<before-references>).first().location().page()
  let after = query(<after-references>).first().location().page()
  assert.eq(references.location().page(), before + 1)
  assert.eq(after, before + 2)
}
