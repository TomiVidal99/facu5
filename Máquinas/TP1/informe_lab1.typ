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
  title: "Laboratorio N°1",
  sub: "Máquinas e Instalaciones Eléctricas",
  authors: (
    "Tomás Vidal (69854/4)",
    "Mateo Natale (75316/9)",
    "Esteban Fernández Madau (71271/5)",
    "Ignacio Nahuel Chantiri (69869/1)",
    "Ezequiel Bavaro (65396/0)",
  ),
  date: "7 de Septiembre de 2025",
)[

  // NATA Y ESTEBAN

  = Introducción
  En este laboratorio se estudia el comportamiento de un transformador monofásico seco mediante un ensayo indirecto. El objetivo es determinar la relación de transformación, así como las pérdidas en vacío (pérdidas en el hierro y en el dieléctrico) y las pérdidas bajo carga (pérdidas por efecto Joule en el cobre y pérdidas suplementarias). A partir de estos ensayos, y mediante cálculos, se obtendrán los parámetros longitudinales y transversales del circuito equivalente del transformador, considerando las tensiones y corrientes nominales.

  = Marco teórico
  Un transformador es una máquina eléctrica estática cuya función principal es transferir energía eléctrica de un circuito a otro manteniendo la misma frecuencia, pero modificando los niveles de tensión y corriente. Este proceso se realiza mediante el principio de la inducción electromagnética, sin que exista un contacto eléctrico directo entre los devanados.

  Está constituido por un núcleo ferromagnético (generalmente de chapas de acero al silicio apiladas) y dos devanados:
  - Devanado primario: Conectado a la fuente de alimentación
  - Devanado secundario: Conectado a la carga

  Cuando una tensión alterna se aplica al devanado primario, circula una corriente que genera un flujo magnético alterno en el núcleo. Este flujo enlaza el devanado secundario, induciendo en él una fuerza electromotriz (fem) de acuerdo con la ley de Faraday.

  #set align(center)
  $#math.epsilon=#math.integral^1_0 arrow(e) * arrow(b) * arrow("dl") = "f.e.m"$

  #set align(left)
  La relación entre la tensión del primario y la del secundario depende de la relación de vueltas entre los devanados, llamada relación de transformación:

  #set align(center)
  $a = v_1/v_2 = N_1 / N_2$

  #set align(left)

  Donde:
  - V_1: tensión del primario
  - V_2: tensión del secundario
  - N_1: número de espiras del primario
  - N_2: número de espiras del secundario

  En condiciones ideales, un transformador no presenta pérdidas, y la potencia entregada en el primario es igual a la recibida en el secundario:

  #set align(center)
  $V_1 * I_1 = V_2 * I_2 #sym.arrow P_1 = P_2$

  #set align(left)

  Sin embargo, en la práctica el transformador no es ideal, ya que presenta pérdidas en el núcleo (hierro), pérdidas en los devanados (cobre) y pérdidas adicionales debidas a fugas de flujo y efectos parásitos. Por este motivo, se representa mediante un circuito equivalente, que incorpora tanto las pérdidas transversales (asociadas al núcleo y magnetización) como las pérdidas longitudinales (asociadas a los devanados).

  #figure(
    image("Imagenes/modelo_trafo.png", width: 100%),
    caption: [Modelo del transformador con sus parámetros],
    supplement: "Figura",
  )

  Para determinar los parámetros de este modelo se realizan dos ensayos fundamentales:
  == Ensayo en vacío
  Se realiza conectando los bornes de baja tensión a tensión nominal y dejando los bornes de alta tensión abiertos. Utilizado para hallar los parámetros transversales (en paralelo) del transformador. \
  Parámetros transversales:
  - Pérdidas en el hierro ($P_"Fe"$)
  - Resistencia equivalente del hierro ($R_"Fe"$)
  - Reactancia de magnetización ($X_m$)

  #figure(
    image("Imagenes/parametros_transversales.png", width: 40%),
    caption: [Parámetros transversales del modelo del transformador],
    supplement: "Figura",
  )

  == Ensayo en cortocircuito
  Se realiza a corriente nominal, alimentando los bornes de alta tensión hasta alcanzar dicha corriente. Utilizado para hallar los parámetros longitudinales (en serie) del transformador. \
  Parámetros longitudinales:
  - Pérdidas en el cobre ($P_"Cu"$)
  - Resistencia equivalente de cortocircuito ($R_"eq1"$)
  - Reactancia equivalente de dispersión ($X_"eq1"$)

  #figure(
    image("Imagenes/parametros_longitudinales.png", width: 40%),
    caption: [Parámetros transversales del modelo del transformador],
    supplement: "Figura",
  )

  // NACHO

  = Desarrollo experimental

  Se describe a continuación cómo se llevaron a cabo los ensayos mencionados previamente.

  == Ensayo de continua (resistencia de los arrollamientos)

  === Conexionado

  #figure(
    image("Imagenes/trafo_ensayo_continua.png", width: 100%),
    caption: [Conexión del transformador en ensayo de continua],
    supplement: "Figura",
  )

  Se efectuó mediante el método del voltímetro amperímetro:
  - Se conectó una fuente de tensión continua variable al lado de baja tensión del transformador
  - En serie, se conectó un amperímetro
  - En paralelo, se conectó un voltímetro

  === Procedimiento de medición

  Se buscó inyectar en el transformador, del lado de baja tensión, una tensión aproximadamente igual al 10% de la nominal, de modo que se permitan obtener lecturas aceptables sin generar calentamiento en los devanados.  Una vez establecida esta tensión (aproximadamente 20V), se realizaron las siguientes mediciones:

  - *Tensión en el primario*: Se tomó lectura del voltímetro
  - *Corriente en el primario*: Se tomó lectura del amperímetro.

  == Ensayo en cortocircuito

  === Conexionado

  #figure(
    image("Imagenes/trafo_ensayo_cc.png", width: 100%),
    caption: [Conexión del transformador en ensayo de continua],
    supplement: "Figura",
  )

  - Se conectó una fuente de tensión alterna variable, de frecuencia nominal 50Hz, en bornes del arrollamiento de alta tensión, con un voltímetro analógico en paralelo para control.
  - En bornes del arrollamiento de baja tensión, se realizó el cortocircuito mediante un conductor (cable).
  - Se empleó un transformador de corriente con el fin de reducir la corriente y posibilitar su medición, junto con la de la potencia, mediante los instrumentos disponibles. mismo se conectó en serie del lado del bobinado de alta tensión como indica el esquema.
  - Para la medición de corriente, se conectó un amperímetro analógico al secundario del transformador de corriente, como indica el esquema.
  - Para la medición de potencia, se conectó la bobina amperométrica de un vatímetro analógico al secundario del transformador de corriente, como indica el esquema. La bobina voltimétrica se conectó en bornes de alta tensión del transformador.
  - Para la medición de tensión del primario, se utilizó también un transformador de tensión que permitió medir con el voltímetro disponible.

  === Procedimiento de medición

  Se buscó llevar el transformador a dos puntos de trabajo: a corriente nominal y a 0.75 de la corriente nominal.  Para ello, primero se elevó la tensión de alimentación progresivamente desde cero hasta medir corriente nominal en el amperímetro.  Una vez en el punto de operación, se midió:

  - *Tensión de cortocircuito* (medida con el voltímetro en el primario, teniendo en cuenta la relación de transformación del transformador de tensión utilizado).
  - *Potencia* (medida con el vatímetro, teniendo en cuenta la relación de transformación del transformador de corriente).
  - *Corriente medida en el primario* (de control, ya que se definió que sería la nominal o una fracción de ella).

  == Ensayo en vacío

  #figure(
    image("Imagenes/trafo_ensayo_vacio.png", width: 100%),
    caption: [Conexión del transformador en ensayo de continua],
    supplement: "Figura",
  )

  - Se conectó una fuente de tensión alterna variable, de frecuencia nominal 50Hz, al arrollamiento de baja tensión del transformador a ensayar, con un voltímetro analógico de control.
  - En bornes de alta tensión, se conectó un multímetro digital de control. Al ser de resistencia considerablemente, no afecta la condición de carga en vacío.
  - Para la medición de corriente, se utilizó un amperímetro analógico, conectado según el esquema en el lado de baja tensión.
  - Para la medición de potencia, se utilizó un vatímetro analógico, conectado según el esquema en el lado de baja tensión.
  - Para la medición de tensión, se conecto un voltímetro analógico en bornes de baja tensión, como indica el esquema

  === Procedimiento de medición

  Se buscó elevar la tensión de fuente progresivamente hasta un poco más de la tensión nominal del transformador a ensayar (240V primario).  A diferencia del ensayo en cortocircuito, se realizaron varias mediciones a distintas tensiones aplicadas, comenzando desde 20V con incrementos de 20V, hasta llegar a 240V

  En cada uno de estos puntos, se midió:
  - *Tension aplicada al primario* (medida con el voltímetro de control, conectado a la fuente)
  - *Tensión inducida en el secundario* (medida con el multímetro conectado en el bobinado de alta tensión).
  - *Potencia activa* (medida con el vatímetro).
  - *Corriente* (medida con el amperímetro).

  Para los posteriores cálculos basados en las medidas realizadas, se considerarán los consumos de los instrumentos:
  - Consumo de potencia la bobina voltimétrica del vatímetro.
  - Consumo de potencia del voltímetro.
  - Corriente del voltímetro (puesto que es un voltímetro analógico de resistencia considerablemente baja).
  Mientras que se desprecian:
  - Consumo de potencia de la bobina amperométrica del vatímetro (puesto que es de baja resistencia y por ella circula una corriente muy baja).
  - Consumo del multímetro en el secundario (Se considera de muy alta resistencia, por lo que el transformador opera prácticamente en vacío).

  = Resultados

  A continuación (siguiente página) se muestran en tabla los resultados de las mediciones hechas en los experimentos mencionados anteriormente.

  #set page(columns: 1)

  #align(center)[ #figure(
    table(
      columns: (auto, auto, auto, auto, auto),
      align: (center, center, center, center, center),
      [Tensión Aplicada [V]], [Consumo de los instrumentos], [Potencia [W]], [Corriente [A]], [Tensión inducida [V]],

      [20], [54.17 [mW]], [0.5], [0.11], [40.3],
      [40], [216.67 [mW]], [2.8], [0.13], [74.1],
      [60], [487.5 [mW]], [5], [0.15], [105.1],
      [80], [866.67 [mW]], [8.2], [0.17], [139.4],
      [100], [1.354 [W]], [12.1], [0.19], [174.9],
      [120], [1.95 [W]], [16.9], [0.21], [209.3],
      [140], [2.654 [W]], [22.5], [0.24], [245],
      [160], [3.487 [W]], [28.1], [0.28], [277.8],
      [180], [4.388 [W]], [35.1], [0.33], [314],
      [200], [5.417 [W]], [42.9], [0.39], [348],
      [220], [6.554 [W]], [51.5], [0.5], [384],
      [240], [7.8 [W]], [60.1], [0.63], [420],
    ),
    caption: [Parámetros del ensayo en vacío],
    placement: top,
  ) ]

  #align(center)[ #figure(
    table(
      columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto),
      align: (center, center, center, center, center, center, center, center, center),
      [Tensión Aplicada [V]],
      [ Pérdidas de vacío [W]],
      [ Corriente de vacío [A] ],
      [cos(#math.phi)],
      [ Corriente de pérdidas [A]],
      [ Corriente magnetizante [A]],
      [ $X_#math.mu$ [#math.Omega] ],
      [ $R_p$ [#math.Omega]],
      [ $Z_0$ [#math.Omega]],

      [20], [0.446], [0.107], [0.208], [22.26m], [0.105], [190.48], [898.83], [186.92],
      [40], [2.583], [0.125], [0.517], [64.63m], [0.107], [373.83], [618.88], [320],
      [60], [4.513], [0.142], [0.530], [75.26m], [0.120], [500], [797.34], [422.54],
      [80], [7.333], [0.159], [0.576], [91.58m], [0.13], [615.38], [873.98], [503.14],
      [100], [10.746], [0.176], [0.611], [0.108], [0.139], [719.42], [925.93], [568.18],
      [120], [14.95], [0.194], [0.642], [0.124], [0.149], [805.37], [967.74], [618.56],
      [140], [19.85], [0.221], [0.642], [0.142], [0.17], [823.53], [985.92], [633.94],
      [160], [24.63], [0.258], [0.600], [0.155], [0.206], [776.70], [1032.26], [620.16],
      [180], [30.71], [0.306], [0.558], [0.171], [0.254], [708.66], [1052.63], [588.24],
      [200], [37.48], [0.363], [0.516], [0.187], [0.311], [642.65], [1069.52], [550.41],
      [220], [44.95], [0.470], [0.435], [0.204], [0.423], [519.15], [1078.43], [468.09],
      [240], [52.30], [0.598], [0.364], [0.218], [0.557], [430.16], [1100.92], [401.34],
    ),
    caption: [Mediciones del ensayo en vacío],
    placement: top,
  ) ]

  #align(center)[ #figure(
    table(
      columns: (auto, auto, auto, auto, auto),
      align: (center, center, center, center, center),
      [$U_"Run1"$ [V]], [$I_"Run1"$ [A]], [$U_"Run2"$ [V]], [$I_"Run2"$ [A]], [$T_A$ [°C]],
      [0.49V], [1A], [0.2V], [1A], [18.5],
    ),
    caption: [Resultados en las mediciones de los arrollamientos],
    placement: top,
  ) ]

  #align(center)[ #figure(
    table(
      columns: (auto, auto, auto, auto),
      align: (center, center, center, center),
      [Tensión de cortocircuito [V]],
      [Potencia medida pérdidas en carga [W] ],
      [Corriente Medida en el secundario [A]],
      [Corriente medida en el primario [A]],

      [13.2], [56.25], [6.5], [3.763],
      [15.2], [75], [10], [5.645],
      [20], [131.25], [13], [7.526],
    ),
    caption: [Mediciones en el ensayo de cortocircuito],
    placement: top,
  ) ]

  #align(center)[ #figure(
    table(
      columns: (auto, auto, auto),
      align: (center, center, center),
      [Corriente de cortocircuito [A]],
      [Factor de potencia $cos_"cc" (#math.phi)$ [W]],
      [Relación de Corrientes #math.eta],

      [6.5], [0.868], [1.727],
      [10], [0.847], [1.771],
      [13], [0.851], [1.727],
    ),
    caption: [Parámetros de funcionamiento en ensayo de cortocircuito],
    placement: top,
  ) ]

  #figure(
    image("Imagenes/Corriente_vs_regulacion.png", width: 70%),
    caption: [Curvas de regulación vs corriente],
    supplement: "Figura",
  )

  #v(2em)

  #align(center)[ #figure(
    table(
      columns: (auto, auto, auto, auto, auto),
      align: (center, center, center, center, center),
      [Carga %], [I (A)], [Vout FP=1 (V)], [Vout FP=0.8 ind (V)], [Vout FP=0.8 cap (V)],
      [10], [0.7526], [219.889], [219.870], [219.952],
      [20], [1.5052], [219.779], [219.741], [219.905],
      [30], [2.2578], [219.668], [219.611], [219.857],
      [40], [3.0104], [219.557], [219.481], [219.810],
      [50], [3.7630], [219.446], [219.351], [219.762],
      [60], [4.5156], [219.336], [219.222], [219.715],
      [70], [5.2682], [219.225], [219.092], [219.667],
      [80], [6.0208], [219.114], [218.962], [219.620],
      [90], [6.7734], [219.004], [218.833], [219.572],
      [100], [7.5260], [218.893], [218.703], [219.524],
      [110], [8.2786], [218.782], [218.573], [219.477],
      [120], [9.0312], [218.671], [218.444], [219.429],
    ),
    caption: [Mediciones de tensión de salida],
    placement: top,
  ) ]

  #align(center)[ #figure(
    table(
      columns: (auto, auto, auto, auto, auto),
      align: (center, center, center, center, center),
      [Carga %], [I (A)], [Vout FP=1 (V)], [Vout FP=0.8 ind (V)], [Vout FP=0.8 cap (V)],
      [10], [0.7526], [219.889], [219.870], [219.952],
      [20], [1.5052], [219.779], [219.741], [219.905],
      [30], [2.2578], [219.668], [219.611], [219.857],
      [40], [3.0104], [219.557], [219.481], [219.810],
      [50], [3.7630], [219.446], [219.351], [219.762],
      [60], [4.5156], [219.336], [219.222], [219.715],
      [70], [5.2682], [219.225], [219.092], [219.667],
      [80], [6.0208], [219.114], [218.962], [219.620],
      [90], [6.7734], [219.004], [218.833], [219.572],
      [100], [7.5260], [218.893], [218.703], [219.524],
      [110], [8.2786], [218.782], [218.573], [219.477],
      [120], [9.0312], [218.671], [218.444], [219.429],
    ),
    caption: [Mediciones de corrientes de salida],
    placement: top,
  ) ]

  #align(center)[ #figure(
    table(
      columns: (auto, auto, auto, auto),
      align: (center, center, center, center),
      [Corriente [A]], [#math.eta FP=1], [#math.eta FP=0.8 ind], [#math.eta FP=0.8 cap],
      [1.3158], [91.58], [89.69], [89.69],
      [2.6316], [95.32], [94.22], [94.22],
      [3.9474], [96.52], [95.68], [95.68],
      [5.2632], [97.03], [96.31], [96.31],
      [6.5789], [97.26], [96.59], [96.59],
      [7.8947], [97.35], [96.7], [96.7],
      [9.2105], [97.36], [96.72], [96.72],
      [10.526], [97.31], [96.66], [96.66],
      [11.842], [97.24], [96.57], [96.57],
      [13.158], [97.14], [96.45], [96.45],
      [14.474], [97.02], [96.31], [96.31],
      [15.789], [96.99], [96.15], [96.15],
    ),
    caption: [Tabla de datos de corriente y rendimiento por factor de potencia],
    placement: top,
  ) ]

  #figure(
    image("Imagenes/Rendimientos.png", width: 70%),
    caption: [Rendimiento vs corriente],
    supplement: "Figura",
  )

  #set page(columns: 2)

  == Aclaraciones sobre los datos

  Durante el ensayo no fue posible medir directamente la temperatura de los arrollamientos, por lo que se asumió que coincidía con la temperatura ambiente. Esta suposición resulta lógica, dado que al inicio los arrollamientos se encontraban efectivamente a temperatura ambiente y las mediciones se realizaron con rapidez, antes de que se produjera un incremento térmico significativo. Así, se tomó como referencia un valor de
  $T_"cc"=T=24°C$. Sin embargo, los resultados obtenidos no fueron los esperados, ya que al aplicar los valores experimentales en las fórmulas se encontraron inconsistencias; por ejemplo, al calcular $P_s$
  se obtuvo un valor negativo, lo cual carece de sentido. \
  Este resultado puede deberse a distintos factores: en primer lugar, para calcular $P_j$ se utilizó una resistencia medida en corriente continua, mientras que el ensayo de cortocircuito se llevó a cabo con corriente alterna; además, otra posible fuente de error radica en que las magnitudes medidas estuvieron muy alejadas del rango óptimo de los instrumentos, lo que amplifica el error absoluto.

  = Conclusión

  En el laboratorio se estudiaron los parámetros característicos de un transformador monofásico seco a través de los ensayos de vacío y de cortocircuito. Estos permitieron, de manera indirecta, estimar las pérdidas en el hierro y en el cobre, así como obtener los parámetros longitudinales y transversales del circuito equivalente. Si bien los resultados presentaron algunas inconsistencias, como valores negativos en el cálculo de ciertas potencias, dichas discrepancias pueden explicarse por limitaciones en la precisión de los instrumentos utilizados, la lectura analógica, la calibración y la antigüedad de los equipos, así como por la suposición de igualdad entre la temperatura ambiente y la de los arrollamientos. Aun con estas limitaciones, los valores obtenidos se encuentran dentro de un rango razonable y permiten validar el procedimiento experimental como una herramienta eficaz para caracterizar transformadores en condiciones de laboratorio. En definitiva, la experiencia permitió comprender el fundamento de los ensayos indirectos, identificar las fuentes de error que afectan la exactitud de los resultados y reconocer la importancia de contar con métodos prácticos para determinar parámetros que serían difíciles de medir directamente.



]
