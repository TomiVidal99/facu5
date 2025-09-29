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
  title: "Laboratorio N°2",
  sub: "Máquinas e Instalaciones Eléctricas",
  authors: (
    "Tomás Vidal (69854/4)",
    "Mateo Natale (75316/9)",
    "Esteban Fernández Madau (71271/5)",
    "Ignacio Nahuel Chantiri (69869/1)",
    "Ezequiel Bavaro (65396/0)",
  ),
  date: "28 de Septiembre de 2025",
)[

  // ESTEBAN
  = Introducción
  El presente informe está destinado al estudio de la máquina de corriente continua, tanto en su funcionamiento como motor como en su funcionamiento como generador.
  En la primera parte, se ensayan las configuraciones del motor en derivación y en serie, con el fin de obtener las características mecánicas velocidad-par en cada caso, evaluando su respuesta ante variaciones de carga.
  En la segunda parte, se examina el comportamiento como generador bajo distintas conexiones de excitación. Se estudian las curvas de magnetización en vacío y las condiciones para el proceso de autoexcitación. Finalmente, con el generador en conexión derivación y compuesta (aditiva y sustractiva), se determinan las características externas de tensión-corriente de carga, analizando la regulación de la tensión bajo diferentes condiciones de operación.

  = Marco teórico
  Una máquina de corriente continua (CC) es un dispositivo electromecánico que convierte energía eléctrica en mecánica (modo motor) o viceversa (modo generador), basado en la inducción electromagnética (ley de Faraday) y la fuerza de Lorentz.
  La f.e.m. inducida en el inducido se calcula como:

  // $E_i = k#math.Phi #math.omega$
  #equation($E_i = k#math.Phi #math.omega$)

  donde ( k ) es una constante de la máquina,  #math.Phi el flujo magnético y ω la velocidad angular.
  El par electromagnético es:

  #equation($T_e = k #math.Phi I_i$)

  Donde $I_i$ es la corriente de inducido.

  == Elementos principales de la máquina de CC

  - *Inductor o rotor:*  Parte giratoria con conductores donde se induce la f.e.m. o circula la corriente que genera el par.
  - *Estator campo inductor:*  Genera el flujo magnético mediante devanados de excitación o imanes permanentes.
  - *Conmutador y escobillas:*  Rectifican la corriente para obtener salida unidireccional.

  == Configuración como motor de corriente continua

  Cuando funciona como motor, la máquina de CC convierte energía eléctrica en mecánica. Al aplicarse una tensión continua al inducido, aparece una corriente que circula a través de los conductores del rotor. Estos conductores se encuentran inmersos en el campo magnético generado por el devanado de excitación, lo que produce una fuerza electromagnética sobre cada conductor según la ley de Lorentz. La suma de estas fuerzas genera un par motor (cupla) que hace girar el rotor.
  A medida que el rotor comienza a girar, debido al movimiento relativo entre los conductores y el flujo magnético, se induce en el inducido una fuerza electromotriz (f.e.m.) de sentido opuesto a la tensión aplicada (según la ley de Lenz). Esta f.e.m. inducida se conoce como f.e.m. de contraelectromotriz y su magnitud depende directamente de la velocidad de giro y del flujo magnético.
  El equilibrio del motor se establece cuando la tensión aplicada al inducido es igual a la suma de la contra-f.e.m. más la caída de tensión en la resistencia del inducido. Si la carga mecánica aumenta, la velocidad tiende a disminuir, lo que reduce la contra-f.e.m., permitiendo que circule una mayor corriente y, por lo tanto, generando un par más alto para compensar la carga.
  De esta manera, el motor de CC autorregula su funcionamiento:
  - *La corriente de inducido:* determina el par motor.
  - *La contra-f.e.m:* está asociada a la velocidad de giro.
  - *El par electromagnético (cupla):* es proporcional al producto del flujo magnético por la corriente de inducido.

  Según cómo se alimente el devanado de campo, el motor de CC puede configurarse en distintas variante:

  - *Motor en derivación (shunt):* El devanado de campo se conecta en paralelo con el inducido. Como la tensión de alimentación es prácticamente constante, la corriente de excitación se mantiene casi invariable, garantizando un flujo constante. Esto proporciona una velocidad casi independiente de la carga, con buena regulación.

  #figure(
    image("Imagenes/cc-shunt.png", width: 60%),
    caption: [Máquina CC conexión shunt],
  )

  - *Motor en serie:* El devanado de campo se conecta en serie con el inducido, por lo que el flujo magnético varía con la corriente del inducido. Esto permite desarrollar un par muy elevado en el arranque, pero provoca riesgo de *embalamiento* si funciona sin carga.

  #figure(
    image("Imagenes/cc-serie.png", width: 60%),
    caption: [Máquina CC conexión serie],
  )

  - *Motor excitación independiente:* El devanado de campo se alimenta desde una fuente externa, independiente del inducido. Esto permite controlar directamente el flujo y regular la velocidad variando la corriente de excitación, siendo útil en aplicaciones que requieren ajuste preciso.

  #figure(
    image("Imagenes/cc-independiente.png", width: 60%),
    caption: [Máquina CC conexión de excitación independiente],
  )

  == Configuración como generador de corriente continua

  Cuando funciona como generador, la máquina de CC transforma energía mecánica en eléctrica. El rotor (inducido) es arrastrado por una máquina motriz externa lo que provoca el movimiento de los conductores dentro del campo magnético del estator. Según la ley de Faraday, este movimiento relativo induce una fuerza electromotriz (f.e.m.) en los conductores, cuya magnitud es proporcional al flujo magnético y a la velocidad de giro del inducido.
  El conmutador y las escobillas rectifican esta tensión alterna inducida en los conductores, entregando en los bornes de la máquina una tensión continua. Si se conecta una carga, circulará una corriente desde el inducido hacia el circuito externo.
  El generador se opone naturalmente al movimiento mecánico aplicado, ya que la corriente en el inducido crea un campo que interactúa con el campo principal produciendo un par resistente. Este par es proporcional al producto del flujo por la corriente del inducido, y representa la potencia mecánica que se convierte en potencia eléctrica.
  El comportamiento del generador de CC depende de la forma en que se alimente o disponga el campo de excitación:

  - * Generador de excitación independiente:*
  El devanado de campo se alimenta desde una fuente externa de corriente continua, independiente del inducido. Esto permite controlar directamente el flujo magnético y obtener la curva de magnetización (tensión inducida en vacío en función de la corriente de excitación). Es la forma más sencilla de analizar el comportamiento de la máquina.

  - * Generador en derivación (shunt):*
  El devanado de campo se conecta en paralelo con el inducido. En este caso, la corriente de excitación se alimenta de la propia tensión inducida, lo que hace posible el fenómeno de autoexcitación, siempre que exista magnetismo remanente en los polos, que la polaridad del devanado sea la adecuada y que la resistencia de campo sea inferior a la resistencia crítica. Este tipo de generador mantiene una tensión relativamente estable bajo carga ligera.

  - * Generador en serie:*
  El devanado de campo se conecta en serie con el inducido, por lo que la corriente de carga también circula por el campo. Esto hace que la tensión dependa fuertemente de la carga, limitando su aplicación práctica.

  - *Generador compuesto:*
  Combina la excitación serie y derivación, pudiendo ser aditiva (mejora la regulación de tensión bajo carga) o sustractiva (compensa parcialmente la autoexcitación). Esta configuración permite obtener un mejor comportamiento frente a variaciones de la corriente de carga.

  == Flujo de potencia:
  El análisis del flujo de potencias permite comprender cómo se transforma la energía dentro de la máquina y cómo se reparten las pérdidas internas.

  - *Generador de CC:*
  La potencia de entrada es suministrada por la máquina motriz que hace girar el inducido. Parte de esta potencia se pierde en las pérdidas rotativas (hierro, roce, ventilación) y en las pérdidas en el cobre (resistencias de inducido y de excitación).
  La potencia interna se denomina potencia electromagnética, y finalmente la potencia útil es la potencia eléctrica entregada en bornes.

  _Potencia de entrada:_  $P_"ab" = T#math.Omega$ \
  _Potencia electromagnética:_ $P_"em" = E_i I_i = T_e #math.Omega$ \
  _potencia eléctrica entregada en bornes:_	 $P_u = U I_L$ \

  - *Motor de CC:*
  En este caso, la potencia absorbida es eléctrica, que se transforma en potencia electromagnética interna. De ella se restan las pérdidas en el cobre y las pérdidas rotativas. El resultado es la potencia útil, que corresponde a la potencia mecánica en el eje.

  _Potencia absorbida:_	$P_"ab" = U I_L$ \
  _Potencia electromagnética:_  $P_"em" = E_i I_i = T_e #math.Omega$ \
  _Potencia mecánica en el eje:_ $P_u = T_u #math.Omega$	\

  En ambos modos de operación, la potencia electromagnética interna actúa como la magnitud intermedia que relaciona la energía eléctrica y mecánica, mientras que las pérdidas determinan el rendimiento real de la máquina.

  = Ensayos

  == Conexión independiente

  El objetivo es determinar la característica en vacío del generador en conexión independiente,
  es decir, la variación de la f.e.m ($E_i$) en función de la corriente de excitación.
  Para ello, se realizó un ensayo directo inyectando distintos valores de corrientes y midiendo la
  tensión a la salida (en vacío) para cada uno de ellos.

  #figure(
    image("Imagenes/ensayo-1.png", width: 80%),
    caption: [Circuito para el ensayo de conexión independiente],
  )

  === Conexionado

  Se realizó el conexionado según indica el esquema, del siguiente modo:

  - Para inyectar la corriente de excitación, se utilizó una fuente de tensión continua digital variable conectada en bornes de alimentación del circuito de excitación. La corriente se midió con el amperímetro incorporado en la misma fuente de tensión

  - La f.e.m inducida se midió según se conecta el multímetro V, en alcance 200V. Al utilizar un instrumento con alta impedancia de entrada, se considerará que el generador se encuentra en vacío.

  - Para girar el rotor, se acopló un motor externo (Máquina de impulso).

  === Procedimiento de medición

  Se llevó el generador al punto de operación, con velocidad del rotor en 3000 _r.p.m_.  Luego, se fue elevando la corriente de excitación en intervalos constantes de 0.3 A, comenzando desde los 0.0 A, hasta llegar a los 2.4 A.  Para cada corriente, se tomaron las siguientes mediciones

  - Tensión en la salida del generador: medida con el multímetro.
  - Corriente de excitación: medida con el amperímetro.

  == Conexión compuesta aditiva

  El objetivo es determinar la característica tensión/corriente de carga para la conexión compuesta aditiva , es decir, la variación de la tensión en función de la corriente de carga.  Para ello, se realizó un ensayo directo conectando un resistor variable como carga, a modo de poder variar la corriente demandada, y midiendo la tensión entregada para distintas corrientes

  #figure(
    image("Imagenes/ensayo-2.png", width: 80%),
    caption: [Circuito para el ensayo de conexión compuesta aditiva],
  )

  = Resultados

  #align(center)[ #figure(
    table(
      columns: (auto, auto, auto),
      align: (center, center, center),
      [$I_"exc"$], [$E_"I_independiente"$], [$E_"I_derivador"$],
      [0], [0.47], [0.57],
      [0.3], [7.01], [5.57],
      [0.6], [13.3], [13.1],
      [0.9], [19.7], [19.05],
      [1.2], [26.2], [24.2],
      [1.5], [31.1], [29.1],
      [1.8], [35.5], [33.4],
      [2.1], [39.9], [36.7],
      [2.4], [42.7], [39.2],
    ),
    caption: [Comparación de las tensiones frente a la configuración de las excitaciones en vacío.],
    placement: top,
  )<table1> ]

  #figure(
    image("Imagenes/Generador_en_vacio.png", width: 100%),
    caption: [Gráfico correspondiente a la tabla @table1],
  )

  #align(center)[ #figure(
    table(
      columns: (auto, auto, auto),
      align: (center, center, center),
      [I], [$E_"i_aditiva"$], [$E_"i_derivativa"$],
      [0], [40], [40],
      [0.5], [39.02], [39.2],
      [1], [38.4], [38.5],
      [1.5], [37.6], [38],
      [2], [35.01], [37],
      [2.5], [33.5], [36.3],
    ),
    caption: [Parámetros del ensayo],
    placement: top,
  )<table2> ]

  #figure(
    image("Imagenes/Generador_en_vacio.png", width: 100%),
    caption: [Gráfico correspondiente a la @table2],
  )

  = Conclusión

  A partir de los ensayos realizados con los tres tipos de conexión _independiente, en derivación y compuesta aditiva_ fue posible determinar las características del generador de corriente continua, analizando tanto su comportamiento en vacío como su comportamiento externo.

  En el ensayo en vacío, correspondiente a las conexiones independiente y en derivación, el comportamiento teórico debería ser lineal. No obstante, debido a la saturación del hierro, la curva resultante presenta una desviación respecto de la recta ideal. En ambos casos debería obtenerse el mismo valor de la fuerza electromotriz (f.e.m.); sin embargo, al disponer una resistencia de excitación en paralelo, parte de la corriente se deriva hacia esta, lo que genera una diferencia en la f.e.m. observada. Asimismo, se comprobó que el generador, incluso sin carga, presenta un valor inicial de f.e.m. producto del campo magnético remanente, lo cual le permite iniciar su funcionamiento.

  En el ensayo de comportamiento externo, efectuado para las conexiones en derivación y compuesta aditiva, se verificó que, para una misma corriente, la tensión en la carga es mayor en la conexión compuesta aditiva que en la conexión en derivación.

]

