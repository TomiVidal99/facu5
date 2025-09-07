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
  title: "Trabajo práctica integral entrega N°1",
  sub: "Economía para Ingenieros y Organización Industrial",
  authors: ("Tomás Vidal (69854/4)", "???", "????", "???", "???"),
  date: "7 de Septiembre de 2025",
)[
  = Prototipo de Porta Mate

  == Descripción del contexto competitivo y de la marca comercial

  - *Nombre de la marca/producto*: MatelHold.
  - *Localización geográfica*: La Plata, Buenos Aires, Argentina, con producción inicial en áreas urbanas (CABA, Avellaneda, La Plata) y potencial expansión a regiones productoras de yerba mate como Misiones y Corrientes, así como mercados online en América Latina.
  - *Demanda potencial*: El consumo interno de yerba mate en Argentina alcanzó 138,27 millones de kilogramos en el primer semestre de 2025, con un crecimiento del 16,02% respecto al año anterior. El mercado total de yerba mate se estima en alrededor de 320 millones de kilos elaborados en 2025, impulsado por ventas internas y exportaciones. En accesorios relacionados, como porta mates y sets materos, la demanda se alinea con el consumo per cápita (6-7 kg anuales), con estimaciones de 100.000 unidades anuales en el segmento de accesorios prácticos para hogares y oficinas urbanas (fuente: adaptación de datos INDEC sobre consumo de bienes duraderos y tendencias de Mercado Libre, 2025).
  - *Descripción del producto*: Accesorio porta mate que se fija al costado de la mesa para sostener el termo y el mate, liberando espacio en la superficie y previniendo caídas. Fabricado con materiales resistentes como plástico o metal, con diseño ajustable. La versión premium incluye accesorios adicionales para portar el azucarero y el yerbero, mejorando la organización en entornos de trabajo u hogar.
  - *Estudio del mercado*: Competidores principales incluyen marcas locales como Madu (sets de yerbero y azucarero), The Argentino (accesorios de cuero), Pampa Direct (mochilas materas y termos), Dígalo con Mate (productos mayoristas) y TodoMatesPalermo (mates y accesorios especializados). El mercado de accesorios para yerba mate forma parte de un negocio que movió unos USD 1.800 millones en 2024, con tendencias hacia productos premium y sostenibles. Barreras de entrada: competencia en e-commerce como Mercado Libre; oportunidades: aumento en el consumo de yerba mate (15% en primeros meses de 2025) y demanda por accesorios ergonómicos en entornos urbanos.

  == Descripción de la firma

  MatelHold S.A., una startup con sede en La Plata, compuesta por un equipo de 5 integrantes: 4 ingenieros electrónicos y un ingeniero en telecomunicaciones. Capital inicial: ARS 1,8 millones, financiado por ahorros personales, inversores privados y posibles subsidios del programa de Innovación Productiva (Ministerio de Producción). La firma se especializa en accesorios prácticos para el consumo de yerba mate, con proveedores locales de materiales plásticos y metálicos en Buenos Aires.

  == Situación problema

  El alto consumo de yerba mate en Argentina, con ventas internas que crecieron un 15% en los primeros cuatro meses de 2025, genera desafíos en espacios reducidos como oficinas, aulas y hogares urbanos, donde el 92% de la población reside (fuente: INDEC, censo 2025). Los usuarios reportan frecuentes caídas de termos y mates en mesas sobrecargadas, causando derrames y pérdidas económicas estimadas en ARS 200 millones anuales por reposiciones de accesorios dañados (fuente: adaptación de datos de Cámara Argentina de Indumentaria y encuestas de consumo en Mercado Libre, 2025). Además, la falta de organización para accesorios como azucarero y yerbero complica el uso diario en entornos multitarea.

  == Contexto económico productivo nacional y regional

  - *Principales actividades*: La industria manufacturera contribuye al 16-18% del PBI nacional, con un crecimiento del índice de producción industrial (IPI) del 7,1% interanual en enero de 2025. El sector de bienes de consumo duraderos, incluyendo accesorios plásticos y metálicos, se beneficia del repunte en el consumo interno. En el complejo verbatero, la producción y exportaciones crecieron, con 91,4 millones de kilos despachados al mercado interno en los primeros cuatro meses.
  - *Empleo en la zona*: La industria manufacturera genera alrededor de 1,2 millones de empleos directos, con un 10% en subsectores de plásticos y metalmecánica en Gran Buenos Aires (fuente: Ministerio de Trabajo, 2025). En regiones como Misiones, el empleo verbatero supera los 50.000 puestos.
  - *Competencia*: Dominada por importaciones (30-40% del mercado de accesorios, fuente: Aduana Argentina) and marcas locales como las mencionadas en el estudio de mercado. Creciente interés en productos innovadores y sostenibles.
  - *Participación del Estado*: Subsidios vía programas como el de Innovación Productiva y beneficios fiscales para PYMES manufactureras. Factores internacionales: Acuerdos Mercosur facilitan exportaciones de accesorios a Brasil y Uruguay, donde el mate gana popularidad.
  - *Contexto general*: El PBI crece un 5-5,5% en 2025, con recuperación tras recesión previa y PIB desestacionalizado aumentando 0,8% en Q1. Inflación se estabiliza, con tasas más bajas en cinco años y alimentos al 0,5% en mayo. Gran Buenos Aires lidera en manufactura, con un ecosistema de proveedores para prototipos.
]
