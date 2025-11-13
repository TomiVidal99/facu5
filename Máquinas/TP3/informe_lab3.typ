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
  set text(font: "Times New Roman", size: 10pt, lang: "es")
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
  title: "Laboratorio N°3",
  sub: "Máquinas e Instalaciones Eléctricas",
  authors: (
    "Tomás Vidal (69854/4)",
    "Mateo Natale (75316/9)",
    "Esteban Fernández Madau (71271/5)",
    "Ignacio Nahuel Chantiri (69869/1)",
    "Ezequiel Bavaro (65396/0)",
  ),
  date: "16 de Octubre de 2025",
)[

  = Introducción
  En este laboratorio se determinan los parámetros eléctricos fundamentales de una máquina sincrónica trifásica de rotor liso mediante ensayos indirectos: vacío, cortocircuito y medición de la resistencia de estator. A partir de estas pruebas se obtienen la curva de magnetización, la característica de cortocircuito, la resistencia por fase y la reactancia/impedancia síncrona, con los cuales se construye el circuito equivalente por fase del generador. Este modelo permite predecir el comportamiento de la máquina cerca de su tensión y corriente nominales y constituye la base para análisis de regulación de tensión, caída interna y flujo de potencias.

  = Marco teórico
  Una máquina sincrónica trifásica es un convertidor electromecánico que, en régimen, gira a velocidad sincrónica (fijada por la frecuencia eléctrica y el número de polos) y mantiene acoplados en fase el campo magnético del estator y el campo del rotor. En este trabajo se opera como generador y se obtienen sus parámetros equivalentes a partir de ensayos indirectos, lo que evita llevarla a plena carga y permite deducir el modelo con pruebas seguras y breves.

  #figure(
    image("Imagenes/esteban1.png", width: 70%),
    caption: [Circuito equivalente del generador],
    supplement: "Figura",
  )

  En el modelo monofásico por fase (red equilibrada), el generador se representa por una f.e.m. interna $E_0$ (proporcional a la excitación de campo) en serie con la resistencia de armadura $R_a$ y la reactancia síncrona $X_S$. Esta última resume la reacción del inducido y la dispersión.
  Este circuito equivalente por fase es la base para estimar caídas internas, corrientes y potencias en torno a la tensión nominal.
  Desde el punto de vista físico, con el estator alimentado (o, en modo generador, por el giro del rotor) se crea un campo giratorio a la frecuencia de red. El rotor, excitado en CC, establece un segundo campo; el par electromagnético resulta de su interacción y, en régimen, el rotor gira sin deslizamiento respecto del campo del estator. En el fasorial, a tensión terminal $U_a$ y frecuencias fijas, la corriente $I_a$ y su ángulo $#math.phi$ dependen de la relación entre $E_0$ y la caída $j X_S I_a$; al variar la excitación cambia $E_0$ y, por tanto, el comportamiento en potencia reactiva Q y el factor de potencia.
  Cuando se hace girar el generador en vacío y se barre la corriente de excitación $I_"exc"$, la tensión inducida $E_0$ crece aproximadamente lineal a bajas excitaciones (zona no saturada, influida por magnetismo remanente) y luego se curva por saturación del hierro. La relación $E_0-I_"exc"$ es la curva de magnetización, que fija la referencia de tensión nominal en vacío. La saturación impacta la estimación de $X_S$:_ en no saturación se usa la recta del entrehierro ($U_"eh"$), mientras que cerca de tensión nominal se habla de una reactancia síncrona “saturada”_.

  = Desarrollo experimental
  == Ensayo en vacío
  Para el ensayo, se impulsó la máquina hasta llevarla a un punto de operación con su velocidad
  nominal de 3000rpm, haciéndola funcionar como generador y sin carga, con sus terminales de
  salida sin conexión.
  Se fue modificando la corriente de excitación hasta obtener la tensión inducida en su valor
  nominal, tomando nota de las corrientes de excitación y la tensión inducida resultante;
  construyendo así la curva de vacío.

  === Conexionado

  Se midió corriente de excitación, tensión inducida, y se controló la velocidad del motor.

  #figure(
    image("Imagenes/image1.png", width: 70%),
    caption: [Conexionado ensayo de vacío],
    supplement: "Figura",
  )

  - Para inyectar y medir la corriente de excitación, se utilizó una fuente digital conectada al circuito de excitación, como se indica en la imagen con los terminales + y -.
  - Para medir la tensión inducida, se conectó un multímetro digital en modo voltímetro entre dos fases de salida del generador. Se considera que el generador está en vacío, puesto que la impedancia del multímetro es muy grande.
  - La velocidad se monitoreó con el tacómetro que tiene integrado el equipo del motor.
  - La máquina de impulso fué un motor de continua conectado al eje del generador sincrónico.

  === Mediciones
  Se elevó la corriente de excitación comenzando desde 0A hasta 10A, en intervalos de 2A,
  utilizando la fuente digital. En cada intervalo se tomó medida de la tensión inducida, según la
  indicación del voltímetro.

  == Ensayo de cortocircuito
  Para este ensayo, se buscará impulsó la máquina hasta su velocidad nominal (3000rpm),
  funcionando como generador con el bobinado estatórico en cortocircuito. Se mantuvo la
  velocidad constante y ser varió la corriente de excitación hasta obtener la corriente de
  armadura nominal, tomando nota de las corrientes de excitación y la corriente de armadura
  resultante; obteniendo así la curva de cortocircuito.

  === Conexionado
  Se midió corriente de armadura, corriente de excitación, y se controló la velocidad de la
  máquina.

  #figure(
    image("Imagenes/image2.png", width: 70%),
    caption: [Conexionado ensayo de corto circuito],
    supplement: "Figura",
  )

  - Para inyectar y medir la corriente de excitación, se utilizó una fuente digital conectada al circuito de excitación, como se indica en la imagen con los terminales + y -.
  - Para medir la corriente de armadura, se utilizó un multímetro dígital en modo amperímetro, dispuesto como A1 en la imagen.
  - Las salidas W, V, U del generador se conectaron entre sí como indica la figura, formando un cortocircuito.
  - La velocidad se monitoreó con el tacómetro que tiene integrado el equipo del motor.
  - La máquina de impulso fué un motor de continua conectado al eje del generador sincrónico.

  === Mediciones
  Se elevó la corriente de excitación comenzando desde 0A hasta 10A, en intervalos de 2A,
  utilizando la fuente digital. En cada intervalo se tomó medida de la corriente de armadura
  según la indicación del amperímetro.
  Se fué monitoreando la velocidad a modo de verificar que ésta no varíe.

  = Resultados

  Los resultados se obtuvieron teniendo en cuenta las siguientes ecuaciones:

  #equation($Z_s=U_0/(sqrt(3)*I_"cc")$)
  #equation($X_s = sqrt(Z_s^2 - R_a^2)$)
  #equation(
    $R_"uv"=0.514; #h(.5em) R_"vw"=0.511; #h(.5em) R_"wu"=0.525; #h(.5em) T_a=21.8°C \ R_a = 1/3 (R_"uv"/2 + R_"vw"/2 + R_"wu"/2)$,
  )

  #align(center)[ #figure(
    table(
      columns: (auto, auto),
      align: (center, center),
      [*$I_"exc"$ (A)*], [*$U_0$ (V)*],
      [0], [0.4],
      [2], [14.4],
      [4], [29.2],
      [6], [41.8],
      [8], [51.3],
      [10], [57.9],
    ),
    caption: [Tensión y corriente en ensayo de vacío],
    placement: top,
  ) ]

  #align(center)[ #figure(
    table(
      columns: (auto, auto),
      align: (center, center),
      [*$I_"exc"$ (A)*], [*$I_"cc"$ (A)*],
      [0], [0.08],
      [2], [1.42],
      [4], [2.77],
      [6], [4.2],
      [8], [5.46],
      [10], [6.83],
    ),
    caption: [Valores de corriente en ensayo de cortocircuito],
    placement: top,
  ) ]


  #align(center)[ #figure(
    table(
      columns: (auto, auto, auto),
      align: (center, center, center),
      [*$I_"exc"$ (A)*], [*$Z_s$ (#math.Omega)*], [*$X_s$ (#math.Omega)*],
      [0], [2.8668], [2.8752],
      [2], [5.8548], [5.8491],
      [4], [6.0861], [6.0807],
      [6], [5.746], [5.7402],
      [8], [5.4246], [5.4184],
      [10], [4.8944], [4.8876],
    ),
    caption: [Datos para la impedancia],
    placement: top,
  ) ]

  #figure(
    image("Imagenes/Ensayo_de_Vacio.jpg", width: 100%),
    caption: [Ensayo vacío],
    supplement: "Figura",
  )

  #figure(
    image("Imagenes/Ensayo_de_Cortocircuito.jpg", width: 100%),
    caption: [Ensayo cortocircuito],
    supplement: "Figura",
  )

  #figure(
    image("Imagenes/Impedancia_sincronica.jpg", width: 100%),
    caption: [Impedancia sincrónica],
    supplement: "Figura",
  )

  #figure(
    image("Imagenes/Curva_de_comparacion.jpg", width: 100%),
    caption: [Comparación de los resultados],
    supplement: "Figura",
  )

  #figure(
    image("Imagenes/fasorial.png", width: 100%),
    caption: [Fasorial en condición nominal con $cos#math.phi=0.8$],
    supplement: "Figura",
  )

  = Conclusión

  En este laboratorio se determinaron con éxito los parámetros eléctricos fundamentales de una máquina sincrónica trifásica de rotor liso mediante ensayos indirectos en vacío y cortocircuito, junto con la medición de la resistencia del estator. Se obtuvieron la curva de magnetización, que muestra un comportamiento lineal inicial y saturación a altas excitaciones, y la característica de cortocircuito, permitiendo calcular la resistencia de armadura ($R_a$), la impedancia sincrónica ($Z_s$) y la reactancia sincrónica ($X_s$), con valores decrecientes por saturación. Estos resultados validan el circuito equivalente por fase, facilitando el análisis de regulación de tensión y comportamiento bajo carga nominal, y confirman la influencia de la saturación en el rendimiento de la máquina.

]

