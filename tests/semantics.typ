#import "../lib.typ": *

#show: note-document.with(
  title: [Environment and equation assertions],
  author: ("Test Author", "Second Author"),
  date: datetime(year: 2026, month: 1, day: 3),
  description: [Regression tests for mathematical environments.],
  keywords: ("theorems", "equations"),
  show-byline: false,
  lang: "es",
)

= Primera sección

#theorem(ref-label: <theorem-one>)[Primera afirmación.]
#definition(ref-label: <definition-one>)[Primera definición.]
#theorem(numbered: false)[Afirmación sin número.]
#lemma(ref-label: <lemma-one>)[Primera afirmación auxiliar.]
#axiom(ref-label: <axiom-one>)[Primer axioma.]
#proposition(ref-label: <proposition-one>)[Primera proposición.]

= Segunda sección

#theorem(ref-label: <theorem-two>)[Segunda afirmación.]
#definition(lang: "en", ref-label: <definition-two>)[Second definition.]
#corollary(ref-label: <corollary-one>)[Primer corolario.]
#example(ref-label: <example-one>)[Primer ejemplo.]
#remark(ref-label: <remark-one>)[Primera observación.]
#proof(qed: none)[Demostración sin marca de cierre.]

Véanse @theorem-one, @theorem-two y @definition-two.

#display-equation($x &= 1 \ y &= 2$, numbering: "(1)", ref-label: <equation-one>)
#display-equation($x + y = 3$)
#equation($x y = 2$, ref-label: <equation-two>)

Las ecuaciones @equation-one y @equation-two ilustran la numeración.
#partial-derivative($f$, $x$, order: 3).

#roman-list([Primero. #roman-list([A.], [B.], style: "lower")], [Segundo.])
#roman-list([Cinco.], [Seis.], style: "decimal", start: 5)

#context {
  assert.eq(document.author, ("Test Author", "Second Author"))
  assert.eq(document.description, [Regression tests for mathematical environments.])
  assert.eq(document.keywords, ("theorems", "equations"))
  for (id, expected-name, expected-number) in (
    (<theorem-one>, "Teorema", 1),
    (<theorem-two>, "Teorema", 2),
    (<definition-one>, "Definición", 1),
    (<definition-two>, "Definition", 2),
    (<lemma-one>, "Lema", 1),
    (<axiom-one>, "Axioma", 1),
    (<proposition-one>, "Proposición", 1),
    (<corollary-one>, "Corolario", 1),
    (<example-one>, "Ejemplo", 1),
    (<remark-one>, "Observación", 1),
  ) {
    let target = query(id).first()
    assert.eq(target.supplement, [#expected-name])
    assert.eq(counter(figure.where(kind: target.kind)).at(target.location()), (expected-number,))
  }
  assert.eq(counter(math.equation).at(<equation-one>), (1,))
  assert.eq(counter(math.equation).at(<equation-two>), (2,))
  assert.eq(query(<equation-two>).first().numbering, "(1)")
}
