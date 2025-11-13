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
  set footnote.entry(clearance: 8em)
  // set footnote.entry(breakeable: true)
  // Switch back to two-column layout for the body
  set page(columns: 2)
  body
}

#project(
  title: "Laboratorio N°4",
  sub: "Máquinas e Instalaciones Eléctricas",
  authors: (
    "Tomás Vidal (69854/4)",
    "Mateo Natale (75316/9)",
    "Esteban Fernández Madau (71271/5)",
    "Ignacio Nahuel Chantiri (69869/1)",
  ),
  date: "10 de Noviembre de 2025",
)[

  = Introducción

  En este trabajo se presentan los resultados del *ensayo directo en carga* realizado sobre un *motor asincrónico trifásico* con rotor jaula de ardilla. El objetivo del ensayo es *caracterizar el comportamiento eléctrico y mecánico del motor* bajo distintos niveles de carga, obteniendo y graficando (en función de la potencia útil $P_u$) los parámetros de funcionamiento: *rendimiento $#math.eta$* , *factor de potencia* $f_p=cos#math.phi$, *corriente de línea* $I_y$ *resbalamiento* _s_, además de la *característica mecánica* n=f(T)(velocidad angular vs. cupla). El método consiste en operar el motor a *tensión y frecuencia nominales*, acoplado a un freno o dinamopéndulo para imponer la carga, y medir *potencia trifásica, tensión, corriente y velocidad* en varios puntos de operación.

  // El *ensayo directo* se define como aquel en el que el equipo bajo prueba es solicitado *en condiciones normales de funcionamiento* mediante una carga que permite medir *directamente* las magnitudes buscadas. En máquinas eléctricas rotativas, este método es especialmente útil para estudiar el desempeño global , del motor (flujo de potencias, rendimiento y cupla) a diferentes estados de carga, aun cuando su precisión puede verse limitada por la disponibilidad de la carga y de la instrumentación.

  = Marco  teórico

  La *máquina asincrónica trifásica* (motor de inducción) es una máquina eléctrica rotativa en la que el *campo magnético giratorio* producido por el estator induce corrientes en el rotor; de la interacción entre ese campo y las corrientes inducidas resulta el par motor. Su rasgo distintivo es que el rotor gira a una velocidad *inferior* a la del campo: nunca alcanza el sincronismo, de allí el nombre “asincrónica”. La velocidad del campo (o *velocidad sincrónica*) viene fijada por la frecuencia de alimentación _f_ y el número de pares de polos _p_.

  #equation($n_s = (60f)/p$)

  mientras que la velocidad de rotor ny el resbalamiento sse relacionan como:

  #equation($s = (n_s-n)/n_s, n = (1 - s) n_s$)

  == Principio de funcionamiento y flujo de potencias:
  Al alimentar el estator con un sistema trifásico equilibrado se establece un *campo magnético giratorio*. Ese campo corta las barras del rotor, induce fuerzas electromotrices y corrientes, y desarrolla un *par electromagnético* que tiende a arrastrar al rotor. En régimen, el motor absorbe *potencia eléctrica trifásica* $P_"abs"$ de la red; una parte se disipa en el cobre del estator (*pérdidas $I^2R$*), otra en el *hierro* (pérdidas magnéticas) y el resto cruza el entrehierro como *potencia electromagnética* $P_e$. Del lado del rotor, una fracción $P_e s$ se pierde en el cobre rotórico y la fracción restante $P_e(1-s)$ constituye la potencia mecánica interna; descontadas las pérdidas mecánicas (rozamiento y ventilación), se obtiene la potencia útil $P_u$ en el eje. Así, el rendimiento resulta $#math.eta=P_u/P_"abs"$ y el factor de potencia $f_p = cos#math.phi = P_"abs" / (sqrt(3)U_L I_L)$

  == Circuito equivalente monofásico:

  Para el análisis de régimen se utiliza el *circuito equivalente por fase* reducido al estator, formado por: rama serie ($R_1+j*X_1$), rama transversal ($R_p∥j_X$)que modela pérdidas en el hierro y magnetización, y la rama del rotor reflejada ($(R_2 ')/s+j*X_2 '$). Este circuito es monofásico (una “pata” de la estrella equivalente), aun cuando el motor esté conectado en triángulo, y es el que se identifica a partir de ensayos estándar.

  #figure(
    image("Imagenes/modeloMAT.png", width: 100%),
    caption: [Modelo de la máquina asincrónica trifásica],
    supplement: "Figura",
  )

  == Par electromagnético y característica mecánica:
  El par puede escribirse, en forma general como:

  #equation($T_e = P_e/#math.Omega _s, #math.Omega _s = (2#math.pi n_s)/60$)

  y la *cupla útil* resulta de la potencia mecánica útil $P_u=T_u$ (con $#math.Omega=2#math.pi n/60$). Estas relaciones se usan para pasar de mediciones eléctricas a *magnitudes mecánicas* (y viceversa).
  Para estudiar la *característica* T-s y localizar el *par máximo*, es habitual convertir la red de estator (incluida la rama de magnetización) a su *equivalente de Thevenin* y escribir el par como función del deslizamiento. En ese marco, el *resbalamiento al par máximo* $s_m$ depende de $R_2 '$ y de las impedancias de Thevenin, con expresiones del tipo:

  #equation($s_m = R_2/sqrt(R_"th"^2 + (X_"th" + X_2)^2), "(forma típica)"$)

  lo cual permite, con datos de placa y un punto de la curva T-n, ajustar $R_2 '$ e inferir el comportamiento a carga.


  #v(5em)
  = Desarrollo experimental

  == Ensayo en carga

  Se realizó un ensayo directo#footnote[El *ensayo directo* se define como aquel en el que el equipo bajo prueba es solicitado *en condiciones normales de funcionamiento* mediante una carga que permite medir *directamente* las magnitudes buscadas.] a un motor asincrónico trifásico (*MAT*) para obtener las características de entrada y mecánicas de salida para diferentes estados de carga.

  Se hizo funcionar al MAT alimentado con su tensión, frecuencia y secuencia nominales. El motor está acoplado a un freno o dínamo-péndulo mediante el cual se pueden determinar sus parámetros de funcionamiento para diferentes estados de carga.

  Se realizaron mediciones de los parámetros mecánicos: *peso/masa y velocidad*, y de los eléctricos: *potencia trifásica de entrada, corriente de línea y tensión de fase*.

  - El *peso* se mide a través del dínamo-péndulo, por lo que se puede calcular la masa por la relación.
  - La *tensión nominal* se obtiene conectándolo a la red, y se midió con un voltímetro en una de las fases.
  - La *potencia total* se midió empleando 3 vatímetros.
  - Se midió la *corriente de línea* con un amperímetro en una de las líneas.
  - La velocidad se midió con el dínamo-tacómetro acoplado al eje del motor.

  == Conexionado

  #figure(
    image("Imagenes/conexionado.png", width: 100%),
    caption: [Conexionado del ensayo],
    supplement: "Figura",
  )

  == Medición

  Se llevó la máquina a su punto de operación nominal gradualmente ejerciendo un freno, de tal forma que genere distintas fracciones de la cupla nominal ($0, 1/4, 2/4, 3/4, 1$), en cada uno de estos puntos se midieron los parámetros mencionado previamente (*peso*, *potencia*, *corriente*, *velocidad* y *tensión*).

  = Resultados

  Las siguientes tablas se hicieron empleando las siguientes expresiones:

  #image("Imagenes/ecuaciones.png")

  #align(center)[ #figure(
    table(
      columns: (auto, auto, auto, auto, auto, auto, auto, auto),
      align: (center, center, center, center, center, center, center, center),

      [*T*], [*U_f*], [*P₁ [kW]*], [*P₂ [kW]*], [*P₃ [kW]*], [*I [A]*], [*M [g]*], [*n [rpm]*],

      [0], [127], [0,2], [0,16], [0,15], [2,4], [182], [1471],
      [1/4], [127], [0,32], [0,25], [0,29], [2,8], [545], [1460],
      [2/4], [127], [0,52], [0,46], [0,52], [3,2], [1121], [1436],
      [3/4], [127], [0,68], [0,64], [0,74], [3,8], [1670], [1413],
      [4/4], [127], [0,9], [0,88], [0,98], [4,8], [2240], [1383],
      [5/4], [127], [-], [-], [-], [-], [-], [-],
    ),
    caption: [
      Datos experimentales
    ],
    placement: top,
    supplement: "Tabla",
  ) ]

  #align(center)[
    #figure(
      table(
        columns: (auto, auto, auto, auto, auto, auto, auto),
        align: (center, center, center, center, center, center, center, center),

        [*Fracción $T_u$*], [*$P_u$[kW]*], [*$P_e$ [kW]*], [*$#math.eta$ [%]*], [*$f_p$*], [*_s_ [%]*], [*I [A]*],

        [0], [0.085], [0.51], [16.7], [0.056], [1,93], [2.4],
        [1/4], [0.255], [0.86], [29.7], [0.089], [2,67], [2.8],
        [2/4], [0.525], [1.5], [35.0], [0.123], [4,27], [3.2],
        [3/4], [0.796], [2.06], [38.6], [0.143], [5,8], [3.8],
        [4/4], [1.107], [2.76], [40.1], [0.151], [7,8], [4.8],
      ),
      caption: [Parámetros de funcionamiento],
      placement: top,
      supplement: "Tabla",
    )
  ]

  #align(center)[
    #figure(
      table(
        columns: (auto, auto, auto, auto),
        align: (center, center, center, center),
        [*Fracción Tu*], [*n [rpm]*], [*P_u [kW]*], [*T_u = P_u / ω [N·m]*],

        [0], [1471], [0.085], [0.552],
        [1/4], [1460], [0.253], [1.655],
        [2/4], [1436], [0.513], [3.411],
        [3/4], [1413], [0.751], [5.075],
        [4/4], [1383], [0.987], [6.815],
      ),
      caption: [Característica mecánica],
      placement: top,
      supplement: "Tabla",
    )
  ]

  #figure(
    image("Imagenes/nata1.jpg", width: 100%),
    caption: [Comparativa de los parámetros eléctricos y mecánicos],
    supplement: "Figura",
  )

  #figure(
    image("Imagenes/carac_maq.png", width: 100%),
    caption: [Características de la máquina (provisto por el fabricante)],
    supplement: "Figura",
  )

  #figure(
    image("Imagenes/nata2.jpg", width: 100%),
    caption: [Característica mecánica del MAT],
    supplement: "Figura",
  )

  #figure(
    image("Imagenes/carac_mec_fab.jpg.png", width: 100%),
    caption: [Característica mecánica del MAT (provisto por el fabricante)],
    supplement: "Figura",
  )


  = Conclusión

  El ensayo directo en carga permitió caracterizar el comportamiento del motor asincrónico trifásico, obteniendo curvas representativas de rendimiento ($#math.eta$), factor de potencia ($f_p$), corriente ($I$), resbalamiento ($s$) y par útil ($T_u$) en función de la potencia útil ($P_u$). Sin embargo, comparados con el gráfico del fabricante en el apunte del ensayo directo, los valores no fueron los esperados: la potencia por fase medida con los vatímetros resultó más alta de lo previsto, lo que disminuyó el rendimiento. \

  No se pudo medir el punto de $T = 5/4$ de la carga nominal debido al sobrecalentamiento del freno, limitando el análisis hasta carga plena. A pesar de las discrepancias en eficiencia y esta restricción operativa, los datos experimentales son consistentes con el modelo teórico y validan el flujo de potencias, consolidando los objetivos del ensayo.

]

