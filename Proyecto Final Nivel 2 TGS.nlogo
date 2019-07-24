globals
[
  Clave
  Fila
  TamM
  R
]
patches-own[Izq Cen Der]


;Recibe una lista para mostrarla en forma de mensaje codificado o decodificado dependiendo del caso ("Botón que la llame").
to-report separar_listaR [L]
  let In 0
  let Fi 5
  let Bas []
  let Sb []
  let NC []
  let J -1
  let N -12

  ;El siguiente repeat pasa la lista dada de binario a decimal
  repeat length Palabra_A_Cifrar
  [
    set Sb sublist L In Fi
    set Bas sentence Bas Decimal Sb 4 0
    set In Fi
    set Fi Fi + 5
  ]

  ;En está parte se están pasando los digitos a letras
  set J length Bas - 1
  repeat length Bas
  [
    set N item J Bas
    set NC sentence Alfabeto_inverso N NC
    set J J - 1
  ]

  ;Aqui Se Pega La Frase
  set J length Bas - 1
  let Fra ""
  repeat length Palabra_A_Cifrar
  [
    set Fra word item J NC Fra
    set J J - 1
  ]
  report Fra
end

;Pasa las componentes de la frase a sus equivalentes en el alfabeto de (0-31).
to-report Alfabeto [k]
  if(k = "#")
  [report 0]

  if(k = "A")
  [report 1]

  if(k = "B")
  [report 2]

  if(k = "C")
  [report 3]

  if(k = "D")
  [report 4]

  if(k = "E")
  [report 5]

  if(k = "F")
  [report 6]

  if(k = "G")
  [report 7]

  if(k = "H")
  [report 8]

  if(k = "I")
  [report 9]

  if(k = "J")
  [report 10]

  if(k = "K")
  [report 11]
  if(k = "L")
  [report 12]

  if(k = "M")
  [report 13]

  if(k = "N")
  [report 14]

  if(k = "Ñ")
  [report 15]

  if(k = "O")
  [report 16]

  if(k = "P")
  [report 17]

  if(k = "Q")
  [report 18]

  if(k = "R")
  [report 19]

  if(k = "S")
  [report 20]

  if(k = "T")
  [report 21]

  if(k = "U")
  [report 22]

  if(k = "V")
  [report 23]

  if(k = "W")
  [report 24]

  if(k = "X")
  [report 25]

  if(k = "Y")
  [report 26]

  if(k = "Z")
  [report 27]

  if(k = "1")
  [report 28]

  if(k = "2")
  [report 29]

  if(k = "3")
  [report 30]

  if(k = "4")
  [report 31]
end

;Pasa los digitos del alfabeto (0-31) a sus equivalentes en letras.
to-report Alfabeto_inverso [k]
  if(k = 0)
  [report "#"]

  if(k = 1)
  [report "A"]

  if(k = 2)
  [report "B"]

  if(k = 3)
  [report "C"]

  if(k = 4)
  [report "D"]

  if(k = 5)
  [report "E"]

  if(k = 6)
  [report "F"]

  if(k = 7)
  [report "G"]

  if(k = 8)
  [report "H"]

  if(k = 9)
  [report "I"]

  if(k = 10)
  [report "J"]

  if(k = 11)
  [report "K"]

  if(k = 12)
  [report "L"]

  if(k = 13)
  [report "M"]

  if(k = 14)
  [report "N"]

  if(k = 15)
  [report "Ñ"]

  if(k = 16)
  [report "O"]

  if(k = 17)
  [report "P"]

  if(k = 18)
  [report "Q"]

  if(k = 19)
  [report "R"]

  if(k = 20)
  [report "S"]

  if(k = 21)
  [report "T"]

  if(k = 22)
  [report "U"]

  if(k = 23)
  [report "V"]

  if(k = 24)
  [report "W"]

  if(k = 25)
  [report "X"]

  if(k = 26)
  [report "Y"]

  if(k = 27)
  [report "Z"]

  if(k = 28)
  [report "1"]

  if(k = 29)
  [report "2"]

  if(k = 30)
  [report "3"]

  if(k = 31)
  [report "4"]
end

;Está función pasa números decimales a binarios
to-report Binario [B]
  ifelse B = 0
  [report []]
  [
    let I 98
    set I B mod 2
    set B floor (B / 2)
    report sentence Binario  B  I
  ]
end

;La función cinco_bits nos transforma todos los elementos en binario de la frase inicial en numeros binarios de 5 bits.
;NOTA: Si el número dado a la función ya posee 5 bits está lo deja igual.
to-report cinco_bits [B]
  ifelse (length B = 5)
  [
    report B
  ]
  [
    repeat 5 - length B
    [
      set B sentence 0 B
    ]
    report B
  ]
end

;Decimal nos pasa números binarios a decimales
to-report Decimal [D I J]
  let V -1
  ifelse I < 0
  [
    report 0
  ]
  [
    set V item J D
    set V V * (2 ^ I )
    set I I - 1
    set J J + 1
    report V + Decimal D I J
  ]
end

;La explicacón de lo que hace la función Comenzar está en su cuerpo
to-report Comenzar [L]
  let J length L - 1
  let Nueva []
  let M []
  let aux []
  let N 99
  let aux1 []
  set R []

  ;Pasa cada elemento de la frase a un digito entre 0 y 31
  repeat length L
  [
    set N item J L
    set Nueva sentence Alfabeto N Nueva
    set J J - 1
  ]

  ;Se crea a M ya como tal es decir como una lista con 1 y 0 de tamaño igual a la longitud original de la frase por 5
  set J length Nueva - 1
  repeat length Nueva
  [
   set aux sentence aux binario item J Nueva
   if (length aux < 5)
   [
     set aux sentence aux1 cinco_bits aux
   ]
    set M sentence aux M
    set aux []
    set aux1 []
    set J J - 1
  ]

  ;Se crea nuestra célula I
  set R CélulaI
  report M
end


;Regla Solo Uno
;Función Perteneciente a la regla de solo uno
to Configurar
  clear-all
  set Fila max-pycor
  ask patches [set pcolor white]
  Cinicial
  reset-ticks
end

;Está función nos dispone la cadena Clave como la configuración inicial del autómata celular.
to Cinicial
  set Clave [1 0 1 0 0 0 1 1 0 1 1 1 0 0 1 1 0 0 1 1 0 0 1 1 1 0 1 0 1 0]
  let X -15
  let P 0
  repeat length Clave
  [
    if (item P Clave = 0)
    [
       ask patch X max-pycor [ set pcolor black ]
    ]
    set P P + 1
    set X X + 1
  ]
end

;Esta no se modifico para el presente ejercicio
to Ejecutar
  if (Fila = min-pycor) [ stop ]
  ask patches with [pycor = Fila]
    [ Evaluar-regla ]
  set Fila (Fila - 1)
  tick
end

;El unico cambio que recibio la función Evaluar-regla fue cambiar el color Amarillo por el Blanco
to Evaluar-regla

  set Izq [pcolor] of patch-at -1 0
  set Cen pcolor
  set Der [pcolor] of patch-at 1 0
  ifelse
  ( Izq + Cen + Der = 19.8 )
    [ ask patch-at 0 -1 [ set pcolor black ] ]
    [ ask patch-at 0 -1 [ set pcolor white ] ]
end

;Está función nos crea nuestra celula R la cual se usara para continuar con el proceso de codificación
;NOTA: El color negro en R equivale a un 0 y el blanco a un 1
to-report CélulaI
  let I []
  let Y max-pycor
  repeat length Palabra_A_Cifrar * 5
  [
    ifelse([pcolor] of patch 0 Y = black)
    [
      set I sentence I 0
    ]
    [
      set I sentence I 1
    ]
    set Y Y - 1
  ]
 report I
end

;La siguiente función hace lo mismo que la función nativa xor
;NOTA: Se creo la FunciónXOR ya que xor no funciono correctamente
to-report FunciónXOR [I J]
  let P 0
  let N []
  repeat length Palabra_A_Cifrar * 5
  [
    ifelse(item P I = item P J)
    [
      set N sentence N 0
    ]
    [
      set N sentence N 1
    ]
    set P P + 1
  ]
  report N
end



;Presentado Por:
; Jose Luis Giraldo Morales
; Yerikson Stanly Clavijo Martinez
; 1088355287









@#$#@#$#@
GRAPHICS-WINDOW
219
38
637
726
-1
-1
6.723
1
10
1
1
1
0
1
1
1
-30
30
-50
50
0
0
1
ticks
30.0

INPUTBOX
64
138
162
198
Palabra_A_Cifrar
NIL
1
0
String (reporter)

BUTTON
79
354
159
387
Codificar
let M []\nlet D []\n;Regla Del Exactamente Uno\nConfigurar\nrepeat length Palabra_A_Cifrar * 5\n[\n  Ejecutar\n]\n\nset M Comenzar Palabra_A_Cifrar\n\nset D FunciónXOR M R\n\nshow (\"La Frase Dada Finalmente Codificada Queda De La Siguiente Forma:\")\nshow separar_listaR D\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
711
385
804
418
Decodificar
let D []\nlet M []\n\nset D Comenzar Palabra_A_Decodificar\n\nset M FunciónXOR D R\n\nshow (\"La Frase Dada Finalmente Decodificada Queda De La Siguiente Forma:\")\nshow separar_listaR M\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

INPUTBOX
699
162
827
222
Palabra_A_Decodificar
NIL
1
0
String

TEXTBOX
1010
71
1160
89
NIL
11
0.0
1

TEXTBOX
207
10
663
28
BIENVENIDO A NUESTRO PROGRAMA PARA CODIFICAR Y DECODIFICAR
14
13.0
1

TEXTBOX
1074
68
1126
86
NOTAS:
14
25.0
1

TEXTBOX
934
221
1268
316
2. Siempre que se quiera decodificar una concatenación de simbolos de cierto tamaño se debe ingresar una frase de igual tamaño para codificarla esto solo para Resetear nuestra celula R y el programa sepa ya de antemano que le seran dadas cadenas de un determinado tamaño y asi sepa como debe codificarlas o decodificarlas.
13
74.0
1

TEXTBOX
5
90
194
149
A Palabra_A_Cifrar se le debe entregar una frase en mayusculas que se desee codificar sin comillas.\nEJ: HOLA
12
0.0
1

TEXTBOX
6
214
222
347
El boton Codificar solo se debe presionar si ya se le ha entregado una frase a la entrada Palabra_A_Cifrar.\nEl resultado de la frase ya codifica sera mostrado en la terminal.\nEn caso de que no se le entregue una frase a Palabra_A_Cifrar el resultado que se visualizara en la terminal seran dos comillas así: \"\"
12
0.0
1

TEXTBOX
648
82
855
172
A Palabra_A_Decodificar se le debe entregar una concatenación letras en mayusculas que se desee codificar sin comillas (La concatenación también puede tener números del 1 al 4).\nEJ: 2XEK
12
104.0
1

TEXTBOX
657
231
855
378
El boton Decodificar solo se debe presionar si ya se le ha entregado una concatenación a la entrada Palabra_A_Decodificar.\nEl resultado de la frase ya decodifica sera mostrado en la terminal.\nEn caso de que no se le entregue nada a Palabra_A_Decodificar el resultado que se visualizara en la terminal seran dos comillas así: \"\"
12
104.0
1

TEXTBOX
931
97
1299
217
1.Por las limitaciones del mundo más especificamente por la coordenada de Y máxima tal como esta el programa solo admite cadenas de simbolos de máximo 20 simbolos.\nEJ:\nELECTROENCEFALOGRAMA\n*Si se desea ingresar cadenas de más de 20 simbolos se tendra que modificar la coordenada Y máx del mundo.
13
74.0
1

TEXTBOX
1117
344
1267
362
NIL
11
0.0
1

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0.3
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
