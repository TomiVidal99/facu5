#let numEquations = counter("mycounter");
#context numEquations.step()

#let cmd(t) = text[
  #set text(font: "Verdana", fill: rgb("#4171ba"))
  _#raw(t, lang: "bash")_
]

#let lk(href, nombre) = text[
  #text(blue)[#link(href)[_#text(nombre)_]]
]

#let equation(equation) = {
  v(1em)
  block(width: 100%, inset: 0pt, {
    align(center)[
      $#equation$
    ]
    place(right, dx: -1em)[
      (#context numEquations.get().first())
    ]
  })
  context numEquations.step()
  v(1em)
}

#let project(title: "", sub: "", authors: (), date: none, body) = {
  // Set document metadata
  set document(author: authors.join(", "), title: title)
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
    #for author in authors {
      text(11pt, style: "italic")[#author]
      v(.1em)
    }

    #v(4em)
    #image("unlp_logo.png", width: 60%)

  ]
  // Switch back to two-column layout for the body
  set page(columns: 2)
  body
}

// Document content
#project(
  title: "Trabajo práctico entrega N°2",
  sub: "Economía para Ingenieros y Organización Industrial",
  authors: (
    "Vidal Tomás",
    "Lopez Sebastián Javier",
    "Vidal Facundo",
    "Marchesotti Guido Daniel",
    "Gatta Agustín Julián",
  ),
  date: "7 de Octubre de 2025",
)[
  = Proceso productivo general

  Proceso Productivo General
  El proceso productivo del porta mate MatelHold consiste en la fabricación de un accesorio ajustable que se fija al borde de una mesa para sostener un termo y un mate, con una versión premium que incluye compartimentos para azucarero y yerbero. El proceso abarca desde la adquisición de materias primas hasta el ensamblaje final, empaquetado y distribución. Se utiliza una combinación de técnicas de moldeo por inyección para piezas plásticas y mecanizado para componentes metálicos, con un enfoque en eficiencia, ergonomía y sostenibilidad. La producción se realiza en una planta en La Plata, Buenos Aires, con proveedores locales de materiales plásticos y metálicos.

  == Etapas del Proceso Productivo

  + Adquisición y Preparación de Materias Primas
  - Descripción: Compra de polímeros plásticos (polipropileno de alta resistencia) y aleaciones metálicas ligeras (aluminio anodizado) de proveedores en Gran Buenos Aires. Se inspeccionan las materias primas para garantizar calidad (resistencia, durabilidad, no toxicidad).
  - Duración: 2 días (incluye transporte y control de calidad).
  - Recursos: Proveedores locales, personal de control de calidad, equipos de medición (calibres, espectrómetros).
  - Interacción: Esta etapa inicia el proceso y suministra materiales a las siguientes fases de moldeo y mecanizado.

  + Moldeo por Inyección (Piezas Plásticas)

  - Descripción: Las piezas plásticas (base, soporte ajustable, y accesorios para la versión premium) se fabrican mediante moldeo por inyección. Los gránulos de polipropileno se funden a 200-250°C y se inyectan en moldes diseñados específicamente para cada componente.
  - Duración: 1 día por lote de 1.000 unidades (ciclo de moldeo: 30 segundos por pieza).
  - Recursos: Máquina de inyección de 100 toneladas, moldes de acero, operarios capacitados, sistema de enfriamiento.
  - Interacción: Las piezas plásticas se envían al ensamblaje tras un control de calidad.


  + Mecanizado de Componentes Metálicos

  - Descripción: Los soportes metálicos ajustables se fabrican mediante corte CNC y doblado de láminas de aluminio. Se aplica un acabado anodizado para resistencia a la corrosión.
  - Duración: 1,5 días por lote de 1.000 unidades (corte: 1 minuto por pieza, anodizado: 2 horas por lote).
  - Recursos: Máquina CNC, dobladora, baño de anodizado, operarios especializados.
  - Interacción: Los componentes metálicos se integran con las piezas plásticas en el ensamblaje.


  + Ensamblaje

  - Descripción: Las piezas plásticas y metálicas se ensamblan manualmente en una línea de producción. Se utilizan tornillos y adhesivos industriales para fijar los componentes. La versión premium incluye ensamblaje adicional de compartimentos para azucarero y yerbero.
  - Duración: 1 día por lote de 1.000 unidades (5 minutos por unidad).
  - Recursos: Estaciones de ensamblaje, herramientas manuales (destornilladores, prensas), adhesivos industriales, operarios.
  - Interacción: Producto terminado pasa a control de calidad final.


  + Control de Calidad Final

  - Descripción: Cada unidad se inspecciona para verificar ajuste, resistencia (pruebas de carga hasta 2 kg) y acabado estético. Se realizan pruebas de funcionalidad (fijación a mesas de 2-5 cm de grosor).
  - Duración: 0,5 días por lote de 1.000 unidades (30 segundos por unidad).
  - Recursos: Equipos de prueba (dinamómetros, calibres), personal de control de calidad.
  - Interacción: Productos aprobados pasan a empaquetado.


  + Empaquetado y Distribución

  -Descripción: Los porta mates se empaquetan en cajas de cartón reciclable con manual de uso. Se preparan para distribución local (CABA, La Plata) y mercados online (Mercado Libre).
  - Duración: 1 día por lote de 1.000 unidades (1 minuto por unidad).
  - Recursos: Máquina de empaquetado, cartón reciclable, cintas adhesivas, logística de transporte.
  - Interacción: Fin del proceso productivo; productos listos para venta.

  *Tiempo Total Estimado: 7 días por lote de 1.000 unidades.*

  #figure(
    image("Imagenes/ProcesoFabricacionMateHolder.png", width: 100%),
    caption: [Proceso de fabricación del MateHolder],
    supplement: "Figura",
  )
  
  == Diagrama de explosión

  #figure(
    image("Imagenes/DiagramaArbol.png", width: 100%),
    caption: [Diagrama de explosión],
    supplement: "Figura",
  )


  == Layout de la fábrica

  #figure(
    image("Imagenes/LayoutFabrica.png", width: 100%),
    caption: [Layout de la fábrica],
    supplement: "Figura",
  )


]
