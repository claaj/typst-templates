#let proyecto(
    titulo: "",
    subtitulo: "",
    indice: false,
    caratula: false,
    fuente: "Linux Biolinum O",
    fuente_mono: "Liberation Mono",
    autores: (),
    materia: "",
    carrera: "",
    año: "",
    fecha: "",
    version: "",
    body
    ) = {

  // Setear autores y titulos en el documento
  set document(author: autores, title: titulo)

  // Creamos lineas
  let linea = line(length: 100%, stroke: 0.25pt)

  // Columna derecha del encabezado
  let columna-der = grid(
      columns: (100%),
      gutter: 9%,
      rows: (auto, auto),
      [#carrera],
      [#materia - #año],)

  // Logo de la UNRN
  let unrn-logo = align(left)[#image("UNRN-color.png", width: 75%)]

  // Titulo de documento
  let doc-titulo = align(right)[#columna-der]

  // Encabezado del documento
  let header-unrn = grid(
    columns: (auto, auto),
    rows: (auto),
    [#unrn-logo],[#doc-titulo],)

  // Pie de pagina
  let pie_pag = align(left)[
      #box(
          width: auto,
          fill: rgb("#ffffff"),
          inset: 10pt,
          [#version])]

  // Config de pagina
  set page(
    paper: "a4",
    header: [
        #set text(9pt)
        #header-unrn
      ],
    margin: (top: 1in, right: 1in, left: 1in, bottom: 1in),
    footer: [
        // Config del pie de pag
        #set text(9pt)
        #grid(
            columns: (50%, 50%),
            [#pie_pag],
            [#set align(end)
            #box(
                width: auto,
                fill: rgb("#cccccc"),
                inset: 8pt,
                radius: 3pt,
                [#counter(page).display((numero, total) => text[Página #numero de #total], both: true)])])
      ])

  // Config de texto
  set text(
    font: (fuente, "Twemoji", "Linux Libertine"),
    size: 12pt,
    lang: "es",)

  // Setear headings
  show heading.where(level: 1): it => grid(
      columns:(auto),
      rows: (auto, auto),
      gutter: (1.5%),
      [#align(right)[#it]],
      [#linea])

  // Titulo grande config
  let titulo_grande = [
      #set text(24pt, weight: "extrabold",)
      #set align(center)
      *#titulo*
    ]

  // Subtitulo config
  let subtitulo = [
      #set text(16pt, weight: "extrabold",)
      #set align(center)
      #subtitulo
    ]

  // Agregar numeros a ecuaciones
  set math.equation(numbering: "(1)")

  // Fuente bloque de codigo
  show raw: set text(font: fuente_mono)

  // Agrega bloque gris atras de bloques de código (Más fachero)
  show raw.where(block: true): block.with(
    fill: rgb("#f2f2f2"),
    inset: 7pt,
    radius: 3pt,
    width: 100%,)

  show raw.where(block: true): text.with(size: 10pt)
  show raw.where(block: false): text.with(size: 12pt)

  show parbreak: it => {
    it
    v(10pt)
  }

  // Centra los cuadros
  show table: align.with(center)

  // Justificar cuerpo.
  set par(justify: true, leading: 1.5em,)
  

  v(15pt)
  titulo_grande
  subtitulo
  linea

  if caratula {
    set align(center)
    v(50pt)
    [
    #set text(13pt)
    #for autor in autores {
        if autor == autores.last() {
            autor
        } else {
                autor + ", "
        }
    }
    #v(50pt)
    Universidad Nacional de Río Negro
    #v(50pt)
    #materia
    #v(50pt)
    #fecha
    #pagebreak()
    ]
  }

  if indice {
      outline(title: [*Índice*])
      pagebreak()
  }

  body
}

// Creamos linea para poder llamarla directamente
#let linea = line(length: 100%, stroke: 0.25pt)

// Crear cuadro para contenidos importantes
// Crea un cuadro con un signo de exclamacion
#let ojo(contenido) = {
    set align(center)

    // Crear una caja con el signo de exclamacion
    let excl = box(
        fill: rgb("#ffffff"),
        inset: 5pt,
        [
          #set align(horizon)
          #set align(center)
          #set text(36pt)
          #sym.excl
        ]
    )

    // Grilla donde ira de un lado la caja con el signo y del otro lado el contenido
    let grilla = grid(
        columns: (40pt, auto),
        [#excl], 
        [
         #set align(horizon)
         #set align(left)
         #contenido
        ])

    // Caja que contiene la grilla
    box(
        inset: 10pt,
        width: auto,
        stroke: 0.25pt,
        grilla,)
}

