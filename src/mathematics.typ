#let equation-above = 1.18em
#let equation-below = 1.5em

/// Build a native display equation with optional numbering and a reference label.
#let display-equation(expression, numbering: none, number-align: end + horizon, spacing: auto, ref-label: none) = {
  show math.equation.where(block: true): set block(
    above: if spacing == auto { equation-above } else { spacing },
    below: if spacing == auto { equation-below } else { spacing },
  )
  let body = if type(expression) == content and expression.func() == math.equation { expression.body } else { expression }
  [#math.equation(block: true, numbering: numbering, number-align: number-align, body)#ref-label]
}

/// Display an equation numbered with the native document-wide counter.
#let equation = display-equation.with(numbering: "(1)")

/// Typeset an inner product with scalable angle brackets.
#let inner(first, second) = $lr(chevron.l #first, #second chevron.r)$

/// Typeset a set given its elements and a predicate.
#let set-builder(element, condition) = $lr(\{ #element mid(|) #condition \})$

#let differential(symbol, function, variable, order) = {
  assert(type(order) == int and order >= 1, message: "derivative order must be a positive integer")
  if order == 1 {
    $frac(#symbol #function, #symbol #variable)$
  } else {
    $frac(#symbol^#order #function, #symbol #variable^#order)$
  }
}

/// Typeset an ordinary derivative in Leibniz notation.
#let derivative(function, variable, order: 1) = differential($upright(d)$, function, variable, order)

/// Typeset repeated partial differentiation with respect to one variable.
#let partial-derivative(function, variable, order: 1) = differential($∂$, function, variable, order)
