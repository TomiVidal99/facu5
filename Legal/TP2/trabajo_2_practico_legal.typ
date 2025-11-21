#let project(title: "", sub: "", author: "", date: none, body) = {
  // Set document metadata
  set document(author: author, title: title)
  set text(lang: "es")
  // IEEE page setup for US Letter (8.5in × 11in)
  set page(
    paper: "us-letter",
    margin: (top: 19mm, bottom: 25.4mm, left: 15.875mm, right: 15.875mm),
    columns: 2, // Enable two-column layout
    numbering: "1",
    number-align: center,
  )
  // Set text properties (IEEE uses 10pt for body text)
  set text(font: "Times New Roman", size: 10pt, lang: "en")
  // Configure headings (IEEE style: numbered, bold)
  set heading(numbering: "1.")
  show heading: it => [
    #set text(weight: "bold", size: 11pt)
    #it
    #v(0.5em)
  ]
  // Configure figures for IEEE style (9pt caption, centered images)
  show figure: it => [
    #set text(size: 9pt)
    #v(0.5em)
    #align(center)[
      #it.body
      #v(0.25em)
      #it.caption
    ]
    #v(0.5em)
  ]
  // Title page (single-column for title)
  set page(columns: 1) // Temporarily switch to single-column for title
  align(center)[
    #v(10em)
    #text(16pt, weight: "bold")[#title]
    #v(1em)
    #text(14pt, style: "italic")[#sub]
    #v(1em)
    // Render list of authors
    // #text(12pt)[#authors.join(", ")]
    #text(11pt)[#date]
    #v(1.5em)
    // Uniform image size (e.g., 80% of column width)
    #text(11pt, style: "italic")[#author]

    #v(4em)
    #image("unlp_logo.png", width: 60%)

    // Table of Contents
    //#set page(columns: 1) // Single-column for TOC
    //#v(2em)
    //#text(14pt, weight: "bold")[Tabla de contenido]
    //#v(1em)
    //#set text(font: "Times New Roman", size: 10pt)
    //#outline(
    //  title: none, // No extra title since we added "Table of Contents" above
    //  indent: 2em, // Indent entries for hierarchy
    //  //fill: box(width: 1fr, repeat[.]), // Dotted line for TOC entries
    //)
    //#v(2em)
    //#set page(columns: 2)

  ]
  // Switch back to two-column layout for the body
  set text(lang: "es")
  set page(columns: 2)
  set ref(form: "page")
  body
}

#let reference(t) = text[
  #set text(fill: rgb("#4171ba"))
  _#ref(t)_
]

#let cmd(t) = text[
  #set text(font: "Verdana", fill: rgb("#4171ba"))
  _#raw(t, lang: "bash")_
]

#let lk(href, nombre) = text[
  #text(blue)[#link(href)[_#text(nombre)_]]
]

#let img(src, caption, w: 100%) = text[
  #figure(
    image(src, width: w),
    caption: [#caption],
  )
]

// Document content
#project(
  title: "Trabajo práctico N°2",
  sub: "Ingeniería Legal y Ejercicio Profesional",
  author: "Vidal Tomás",
  date: "16 de Noviembre de 2025",
)[

  = a

  == Honorarios

  Según la tabla de honorarios del CIPBA#footnote("Colegio de Ingenieros de la provincia de BUenos Aires"), corresponde un 8% del total, es decir *\$12.000.000*.

  #img("TABLA_HONORARIOS.png", "Tabla de honorarios (CIPBA)")

  == Caja de Previsión

  Los aportes a la Caja de Previsión son del 10% de los honorarios, según lo que dice la Ley 12490, artículo 26 inciso b, que cita lo siguiente: 
  _"El aporte obligatorio del diez por ciento (10%) a cargo de los afiliados, de los honorarios percibidos y de todo ingreso o remuneración de origen profesional originados en trabajos ejecutados en jurisdicción de la Provincia de Buenos Aires o referidos a inmuebles o bienes ubicados en su territorio."._ (#lk("https://normas.gba.gob.ar/documentos/BLmDYSQV.html", "https://normas.gba.gob.ar/documentos/BLmDYSQV.html")). \
  Por lo que el monto sería del 10% de \$12.000.000, es decir *\$1.200.000*.

  == Tasa de visado

  La tasa de visado se debe hacer a través del sitio web del CIPBA, por lo que no pude encontrar cuál es la tarifa exacta, ya que se necesita estar matriculado. (#lk("http://www.colegioingenieros.org.ar/consulta-de-visados/", "http://www.colegioingenieros.org.ar/consulta-de-visados/"))

  = b

  En la ley 10.416, capítulo III \"Deberes y derechos de los profesionales\", en el artículo 14 dice: _"1. Ser defendidos por el Colegio a su pedido y previa consideración de los Organismos del mismo en todos aquellos casos en que sus intereses profesionales, en razón del ejercicio de la profesión, fueran lesionados."_. \
  Por lo tanto, el Ingeniero Pérez estaría bajo la protección, ya que al no percibir los honorarios se estaría incumpliendo el deber del empleador y el derecho del empleado. \
  Ignacio podría actuar primero haciendo una intimación con una carta documento, donde exprese el problema e indique el monto endeudado. Tambien puede solitar asistencia al Colegio de Ingenieros, y/o hacer un reclamo por vía judicial.

  = c

  No se posee suficiente información para determinarlo con exactitud, ya que depende del rol que Ignacio tenga. Si tiene un rol puramente técnico y no dirige ninguna parte de la obra, y la contratación fue realizada por un tercero, entonces no tendría responsabilidad sobre el error. Pero si tuviera un rol administrativo y/o fuese quien realizó la contratación, entonces sí recibiría las consecuencias legales correspondientes.

  = d

  No, no correspondería aplicar atenuantes, ya que el comitente debe cumplir su deber de efectuar el pago de los honorarios pertinentes.

  = Referencias

  - #lk("https://normas.gba.gob.ar/documentos/BLmDYSQV.html", "https://normas.gba.gob.ar/documentos/BLmDYSQV.html")
  - #lk("http://www.colegioingenieros.org.ar/resolucion-1498-y-anexas-i-ii-y-iii/", "http://www.colegioingenieros.org.ar/resolucion-1498-y-anexas-i-ii-y-iii/")
  - #lk("https://normas.gba.gob.ar/documentos/xkdm6UAB.html", "https://normas.gba.gob.ar/documentos/xkdm6UAB.html")

]
