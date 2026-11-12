#import "../lib.typ": *

#show: note-document.with(
  title: [Orthogonal projection],
  subtitle: [A geometric proof of the Cauchy–Schwarz inequality],
  category: [Mathematics],
  author: "Folio Notes contributors",
  description: [Orthogonal decomposition, Cauchy–Schwarz, and projections in the plane.],
  keywords: ("linear algebra", "orthogonal projection", "Cauchy–Schwarz"),
)

A vector can be split into a part along a line and a part perpendicular
to it. The first part gives the nearest point on the line. The second
part measures how far away the vector lies. Strang develops the same
idea for higher-dimensional subspaces @strang-projections.

= Projection onto a line

#definition(title: [Projection coefficient])[
  Let $u$ be a unit vector in $RR^n$. For a vector $x$ in the same space, the signed coefficient
  along $u$ is $alpha = #inner($x$, $u$)$. The orthogonal projection of
  $x$ onto the line $RR u$ is $alpha u$.
]

#image-center(
  image("assets/projection.svg", alt: "A right triangle with diagonal x, horizontal projection alpha u, and vertical remainder r."),
  caption: [The remainder $r = x - alpha u$ is perpendicular to the line.],
)

#theorem(title: [Orthogonal decomposition], ref-label: <decomposition>)[
  The remainder $r = x - alpha u$ is perpendicular to $u$.
  The squared lengths satisfy
  #display-equation(
    $ norm(x)^2 = alpha^2 + norm(r)^2. $,
    numbering: "(1)",
    ref-label: <pythagoras>,
  )
]

#proof[
  The inner product of $r$ and $u$ is
  $#inner($x$, $u$) - alpha #inner($u$, $u$) = alpha - alpha = 0$.
  The two summands of $x = alpha u + r$ are therefore perpendicular,
  and the identity follows from the Pythagorean theorem.
]

#pagebreak()

= An inequality for lengths

The squared length of the projected part cannot exceed the squared
length of the original vector. This observation gives a bound for the
inner product of any two vectors.

#theorem(title: [Cauchy–Schwarz], ref-label: <cauchy-schwarz>)[
  For $x, y in RR^n$,
  $ abs(#inner($x$, $y$)) <= norm(x) norm(y). $
  Equality holds precisely when $x$ and $y$ are linearly dependent.
]

#proof[
  If $y = 0$, both sides vanish. Otherwise let $u = y / norm(y)$.
  By @decomposition and @pythagoras, the signed coefficient satisfies
  $alpha^2 <= norm(x)^2$, with equality exactly when $r = 0$.

  Taking square roots and multiplying by $norm(y)$ gives the stated
  bound. The remainder vanishes exactly when $x$ is a scalar multiple
  of $u$, hence of $y$.
]

== The nearest point

Every point on the line has the form $t u$. Subtracting it from $x$
gives $(alpha - t)u + r$. The two summands are perpendicular, so

$ norm(x - t u)^2 = (alpha - t)^2 + norm(r)^2. $

The second term is fixed. The first vanishes exactly when $t = alpha$,
so $alpha u$ is the unique nearest point on the line.

== A calculation in the plane

Take $x = (3, 4)$, which has norm $5$. The choice of direction changes
the signed coefficient. Along the coordinate axes it is simply the
corresponding coordinate of $x$.

#note-table(
  header: ([Unit direction $u$], [Signed coefficient $alpha$]),
  align: (start, end),
  caption: [Projections of $(3, 4)$ onto three lines.],
  [$(1, 0)$], [$3$],
  [$(0, 1)$], [$4$],
  [$(1/sqrt(2), 1/sqrt(2))$], [$7/sqrt(2)$],
)

Along the diagonal the coefficient is $7/sqrt(2)$, still less than
$5$. Reversing the chosen unit vector changes the sign of $alpha$ and
gives the same projected vector $alpha u$.

#bibliography("assets/references.bib", title: [References])
