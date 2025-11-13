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
    #v(.1em)

    #v(4em)
    #image("unlp_logo.png", width: 60%)

  ]
  // Switch back to two-column layout for the body
  set page(columns: 2)
  body
}

// Document content
#project(
  title: "Trabajo práctico N°1",
  sub: "Ingeniería Legal y Ejercicio Profesional",
  author: "Vidal Tomás",
  date: "3 de Noviembre de 2025",
)[

  =

  Si, puede presentarse para realizar los trámites de la pensión a nombre propio. Debido a que la ley 12490 así lo explicita en la sección VII (_"De la pensión"_), que cita lo siguiente: \
  _"Artículo 56.- CARACTERIZACION. Tendrán derecho a pensión:
  a. Los causahabientes del afiliado que a su muerte o a su presunto fallecimiento judicialmente
  declarado, estuviere gozando de una Jubilación Proporcional Ordinaria, Reducida o
  Extraordinaria por incapacidad.
  b. Los causahabientes del afiliado que a su muerte o a su presunto fallecimiento judicialmente
  declarado se encontrare en actividad y reuniere los requisitos exigidos por la presente ley,
  para acceder a una jubilación proporcional Ordinaria reducida o Extraordinaria por
  incapacidad o cumpliere los requisitos establecidos en el artículo 48 incisos b) y c).
  c. Los causahabientes del afiliado que a su muerte o a su presunto fallecimiento declarado
  judicialmente, se encontrare en actividad y no reuniere los requisitos exigidos por la
  presente ley para acceder a una Jubilación Proporcional Ordinaria"_

  =

  Sí, Lautaro puede ser inscripto como hijo de Tomás, aun habiendo nacido después de su muerte. Los artículos 566 y 558 explicitan por qué esto es cierto.

  _ARTÍCULO 566.- Presunción de filiación. Excepto prueba en contrario, se presumen hijos del o la cónyuge los nacidos después de la celebración del matrimonio y hasta los trescientos días posteriores a la interposición de la demanda de divorcio o nulidad del matrimonio, de la separación de hecho o de la muerte._

  _ARTÍCULO 558.- Fuentes de la filiación. Igualdad de efectos. La filiación puede tener lugar por naturaleza, mediante técnicas de reproducción humana asistida, o por adopción.  La filiación por adopción plena, por naturaleza o por técnicas de reproducción humana asistida, matrimonial y extramatrimonial, surten los mismos efectos, conforme a las disposiciones de este Código.  Ninguna persona puede tener más de dos vínculos filiales, cualquiera sea la naturaleza de la filiación._

  =

  Según el régimen sucesorio del CCyC (arts. 2287 a 2431): _"los herederos forzosos son los descendientes, ascendientes y el cónyuge"_. Por lo que sus herederos serán solo sus hijos: Juan y Lautaro. Por no estar casados Sofía no es heredera.

  =

  Creo que, para el caso presentado, la ley es explícita en los derechos, a diferencia de otros casos donde puede ser de un índole más tácito. También creo que el hecho de haber registrado la unión convivencial fue muy importante, pero quizá hubiera convenido también el matrimonio, para facilitar los trámites y además permitir que Sofía sea una heredera legítima.

]
