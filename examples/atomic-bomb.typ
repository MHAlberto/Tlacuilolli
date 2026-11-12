#import "../lib.typ": *

#show: note-document.with(
  title: [La bomba atómica],
  subtitle: [El Proyecto Manhattan y J. Robert Oppenheimer],
  category: [Física],
  author: "Folio Notes contributors",
  description: [El Proyecto Manhattan, la dirección de Los Álamos y el trabajo doctoral de Oppenheimer.],
  keywords: ("Proyecto Manhattan", "Oppenheimer", "Los Álamos"),
  lang: "es",
)

El _Proyecto Manhattan_ fue el programa con el que Estados Unidos
desarrolló las primeras armas nucleares durante la Segunda Guerra
Mundial. A partir de 1942, reunió a físicos, matemáticos e ingenieros
de universidades, laboratorios e instituciones militares. Parte de la
investigación se concentró en Los Álamos, Nuevo México, donde se formó
un laboratorio bajo la dirección científica de J. Robert Oppenheimer
@nps-oppenheimer.

#let portrait = block(width: 100%, height: 159pt, clip: true)[
  #place(center + top, dx: -8pt, dy: -9pt, image(
    "assets/oppenheimer.jpg",
    width: 170%,
    height: 354pt,
    fit: "cover",
    alt: "J. Robert Oppenheimer en Oak Ridge, fotografiado por Ed Westcott en 1946",
  ))
]
#image-left(
  pad(x: 5pt, portrait),
  caption: [
    #text(size: 1.15em)[J. Robert Oppenheimer]
    #linebreak()
    #text(size: 0.91em, style: "italic", fill: rgb("#535353"))[(1904–1967)]
  ],
)[
  #v(0.28em)
  *J. Robert Oppenheimer* llegó a Los Álamos con experiencia en
  mecánica cuántica y en la formación de físicos teóricos. Su tarea
  principal fue dar una dirección científica común a equipos de
  procedencias distintas. Participó en la selección de investigadores,
  impulsó el intercambio entre las divisiones del laboratorio y
  mantuvo el contacto con el general Leslie Groves, quien dirigía el
  proyecto en su conjunto. Los Álamos comenzó a operar en 1943
  @ias-oppenheimer.
]

La división de responsabilidades ayuda a entender el alcance del
proyecto. Groves tenía a su cargo un programa repartido entre varias
instalaciones. Oppenheimer debía coordinar la investigación en Los
Álamos y mantener el diálogo entre quienes trabajaban con cálculos,
experimentos y problemas de ingeniería.

El trasfondo físico del proyecto era la _fisión nuclear_. Cuando un
núcleo pesado se divide, los productos tienen una energía en reposo
distinta de la del núcleo inicial. La diferencia se manifiesta como
movimiento de los fragmentos y radiación. Para expresar la relación
entre la masa en reposo y la energía se emplea la ecuación de Einstein.

$ E = m c^2 $

En esta expresión, $m$ es la masa en reposo y $c$ la velocidad de la luz.
La formación científica de Oppenheimer lo llevó antes a otro problema
físico. En Gotinga estudió cómo la mecánica cuántica podía explicar la
respuesta de los átomos a la radiación.

#pagebreak()

= La tesis de Gotinga

Oppenheimer obtuvo el doctorado en 1927 en la Universidad de Gotinga
bajo la dirección de Max Born. Su tesis, _Zur Quantentheorie
kontinuierlicher Spektren_, estudiaba transiciones cuánticas hacia
estados con un intervalo continuo de energías. Desarrolló un método
para normalizar las funciones que describen esos estados y lo aplicó
al efecto fotoeléctrico. Así pudo calcular cómo se distribuyen las
velocidades de los electrones que un material emite al absorber luz
@goettingen-thesis @oppenheimer-spectra.

Ese mismo año publicó con Born un artículo sobre la teoría cuántica de
las moléculas. Allí aprovecharon la diferencia de masas entre los
electrones y los núcleos para estudiar sus movimientos por separado.
De ese trabajo procede la aproximación de Born–Oppenheimer
@born-oppenheimer.

#image-center(
  image(
    "assets/oppenheimer.pdf",
    alt: "Cronología: doctorado en Gotinga en 1927, docencia en Berkeley y Caltech en 1929 y dirección de Los Álamos en 1943.",
  ),
  caption: [De la formación en mecánica cuántica a la dirección de Los Álamos.],
)

= La dirección de Los Álamos

El laboratorio se organizó en divisiones. Según Hans Bethe, los jefes
de división discutían la marcha de Los Álamos en una junta y los
responsables de cada grupo se reunían en un consejo de coordinación
@bethe-oppenheimer.

#image-right(
  image("assets/los-alamos.jpg", alt: "Rabi, McKibbin, Oppenheimer y Weisskopf en Los Álamos"),
  caption: [Rabi, McKibbin, Oppenheimer y Weisskopf, Los Álamos, 1944.],
)[
  Oppenheimer defendió que los resultados circularan entre los grupos
  y que sus integrantes pudieran discutirlos en los coloquios. Así,
  una pregunta planteada por un equipo podía recibir una respuesta
  de otra especialidad.

  Bethe recuerda que Oppenheimer seguía de cerca las discusiones
  teóricas y el trabajo experimental. Esa presencia le permitía
  conocer de primera mano los problemas de los equipos.
]

#bibliography("assets/references.bib", title: [Referencias])
