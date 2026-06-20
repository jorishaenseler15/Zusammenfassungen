#set page(
  paper: "a4",
  flipped: true,
  margin: (x: 0.1cm, top: 0.1cm, bottom: 0.1cm),
  background: [
    #place(top + left, dx: 7.575cm, dy: 0.8cm)[#line(angle: 90deg, length: 19.4cm, stroke: 0.4pt + rgb("#e2e8f0"))]
    #place(top + left, dx: 14.85cm, dy: 0.8cm)[#line(angle: 90deg, length: 19.4cm, stroke: 0.4pt + rgb("#e2e8f0"))]
    #place(top + left, dx: 22.125cm, dy: 0.8cm)[#line(angle: 90deg, length: 19.4cm, stroke: 0.4pt + rgb("#e2e8f0"))]
  ],
)

#set text(size: 6.5pt, font: ("Helvetica", "Arial"), lang: "de")
#set par(justify: true, leading: 0.3em)

#show heading.where(level: 1): it => block(
  width: 100%,
  above: 0.8em,
  below: 0.4em,
)[
  #line(length: 100%, stroke: 1.2pt + rgb("#2a6f97"))
  #v(2pt)
  #set text(fill: rgb("#2a6f97"), weight: "bold", size: 7.5pt)
  #upper(it.body)
]

#show heading.where(level: 2): it => block(
  width: 100%,
  above: 0.6em,
  below: 0.3em,
)[
  #text(fill: rgb("#0f172a"), weight: "bold", size: 7pt)[#it.body]
]

#let tipp(body) = block(
  width: 100%,
  stroke: (left: 1.5pt + rgb("#3b82f6")),
  inset: (left: 4pt, y: 2pt),
  fill: rgb("#f8fafc"),
  above: 0.5em,
  below: 0.5em,
)[
  #text(size: 6pt, style: "italic", fill: rgb("#334155"))[#body]
]

#let hl(body) = highlight(fill: rgb("#fef08a"), extent: 1pt, body)

#show: columns.with(4, gutter: 0.4cm)

= 0. Notation & Grundlagen
#show math.equation: set text(size: 7.5pt)

== Typografie & Dimensionen
- Skalare: $x, alpha in RR$ (normal)
- Vektoren (Standard = Spaltenvektor): \
  $bold(x) in RR^(n times 1)$ bzw. Transponiert $bold(x)^T in RR^(1 times n)$
- Matrizen: $bold(X) in RR^(m times n)$ (Zeilen $m$, Spalten $n$), Eintrag: $X_(i j)$

== Matrix-Vektor-Multiplikation
- Dimensions-Check: $(m times n) dot (n times 1) => (m times 1)$
- Regel: Innere Dimensionen ($n$) müssen gleich sein.
#grid(
  columns: (1.4fr, 1fr),
  gutter: 4pt,
  [
    - Kochbuch-Berechnung:
      1. Zeile $i$ im Ergebnis = Skalarprodukt aus $i$-ter Zeile von $bold(A)$ und Vektor $bold(x)$.
      2. Formel: $y_i = sum_(j=1)^n A_(i j) x_j$ \
        #block[
          #show math.equation: it => {
            show "k": set text(fill: rgb("#b91c1c"))
            show "i": set text(fill: rgb("#1e40af"))
            it
          }
          $v_i = sum_k M_(i k) x_k$
        ]
  ],
  align(center + horizon)[
    #image("img/matmul.png", width: 100%)
  ],
)

== Kronecker-Delta ($delta_(i j)$)
- Definition: $delta_(i j) = 1$ falls $i=j$, sonst $0$.
- 3 goldene Prüfungs-Regeln:
  1. Matrix-Äquivalent: Einheitsmatrix $bold(I) = (delta_(i j))$
  2. Ableitung von Vektoren: $partial x_i / partial x_j = delta_(i j)$
  3. Filter-Regel: $sum_(j) delta_(i j) f(j) = f(i)$
    #block[
      #show math.equation: it => {
        show "k": set text(fill: rgb("#b91c1c"))
        show "m": set text(fill: rgb("#047857"))
        show "i": set text(fill: rgb("#1e40af"))
        it
      }
      _Bsp:_ $sum_(k=1)^n delta_(k m) U_(k i) = U_(m i)$
    ]


== Mitternachtsformel (a-b-c-Formel)
Löse $a x^2 + b x + c = 0$ über:
$ x_(1,2) = frac(-b +- sqrt(b^2 - 4 a c), 2 a) $
#show math.equation: set text(size: 6.5pt)

= 1. Vektoren: Linearkombination & Unabhängigkeit
#show math.equation: set text(size: 7.5pt)

== Linearkombination (LK)
$bold(v) = lambda_1 bold(v)_1 + dots + lambda_k bold(v)_k$
- Kochbuch (LGS): Matrix $[bold(A) | bold(v)]$ aufstellen (Vektoren als Spalten) und mit Gauss lösen:
  - Lösbar $=>$ Ja (ist LK)
  - Widerspruch (z.B. $0=c$) $=>$ Nein (keine LK)
  - _Bsp:_ $mat(1, 2, 5; 0, 1, 2; augment: #2) =>$ lösbar.

== Lineare Unabhängigkeit (LU)
$sum lambda_i bold(v)_i = bold(0) => lambda_1 = ... = lambda_k = 0$ (nur triviale Lösung)
- Kochbuch (Vektoren als Spalten in Matrix $bold(A)$): \
  Bringe $[bold(A)|bold(0)]$ mit Gauss auf Zeilenstufenform.
  - Jede Spalte hat ein Pivot-Element $=>$ LU
  - Spalte ohne Pivot (freie Variable) $=>$ LA
  _Bsp:_ $bold(v)_1 = mat(1; 0; 2), bold(v)_2 = mat(2; 1; 0), bold(v)_3 = mat(0; -1; 4) arrow.r.double [bold(A) | bold(0)] = mat(1, 2, 0, 0; 0, 1, -1, 0; 2, 0, 4, 0; augment: #3)$ \
  $arrow.r.double^"Gauss" mat(1, 2, 0, 0; 0, 1, -1, 0; 0, -4, 4, 0; augment: #3) arrow.r.double mat(1, 2, 0, 0; 0, 1, -1, 0; 0, 0, 0, 0; augment: #3) =>$ Spalte 3 ohne Pivot $=>$ LA.

#show math.equation: set text(size: 6.5pt)

= 2. Multivariate Ableitungen
#show math.equation: set text(size: 7.5pt)

== Gradient $nabla f$ (Skalar $arrow.r$ Vektor)
$f: RR^n arrow.r RR$ (Spaltenvektor der partiellen Ableitungen).
- _Bsp:_ $f(x,y) = x^2 y + 3 y => partial f / partial x = 2 x y, partial f / partial y = x^2+3$
  $=> nabla f(x,y) = mat(2 x y; x^2 + 3)$
- *Vektor-Gradienten:*
  $ |dot| : cases(
    RR^n &arrow.r RR^+,
    bold(x) &|-> sqrt(sum_(i=1)^n x_i^2)
  ) $
  $ |bold(u)| = sqrt(bold(u)^T bold(u)) = sqrt(sum_k u_k^2) \
    nabla |bold(u)| = frac(1, |bold(u)|) bold(u)^T \
    nabla (bold(x)^T bold(x)) = nabla |bold(x)|^2 = 2 bold(x)^T $
  #text(
    size: 5.5pt,
    fill: rgb("#475569"),
  )[(Hinweis: $bold(x)^T bold(x)$ ist reell. $1/(|bold(x)|) = (sum_(i=1)^n x_i^2)^(-1/2)$)]

== Jacobi-Matrix $J_f$ (Vektor $arrow.r$ Matrix)
$bold(f): RR^n arrow.r RR^m$ (Grösse $m times n$). Zeile $i$ = Ableitungen von $f_i$ nach allen Variablen.
#grid(
  columns: (1.3fr, 1fr),
  gutter: 4pt,
  [
    - _Bsp:_ $bold(f)(x,y) = mat(x^2 y; 5 x + y)$
      $=> J_f = mat(2 x y, x^2; 5, 1)$ \
      (Hinweis: $nabla f = J_f^T$)
  ],
  align(center + horizon)[
    #image("img/jakobimatrix.png", width: 100%)
  ],
)

== Mehrdimensionale Kettenregel
#grid(
  columns: (1.5fr, 1fr),
  gutter: 4pt,
  [
    $J_(f compose g)(x) = J_f(g(x)) dot J_g(x)$ \
    Für $3+$ Funktionen: \
    $J_(f compose g compose h)(x) = J_f(g(h(x))) dot J_g(h(x)) dot J_h(x)$ \
    (Matrizenmultiplikation von links nach rechts)
    - _Kochbuch-Bsp (Ableitung entlang Kurve):_ \
      Gegeben $f(x,y) = x dot y$ und Kurve $bold(c)(t) = mat(t^2; 3 t)$. Gesucht $dif / (dif t) f(bold(c)(t))$:
      1. Äussere Ableitung: $J_f (x,y) = mat(y, x)$
      2. Kurve in $J_f$ einsetzen: $J_f (bold(c)(t)) = mat(3 t, t^2)$
      3. Innere Ableitung: $J_c (t) = bold(c)'(t) = mat(2 t; 3)$
      4. Multiplikation: $mat(3 t, t^2) dot mat(2 t; 3) = 3 t dot 2 t + t^2 dot 3 = 6 t^2 + 3 t^2 = 9 t^2$
  ],
  align(center + horizon)[
    #v(4pt)
    #image("img/cummutative-diagram-3.png", width: 100%)
  ],
)

== Mehrdimensionale Linearisierung
Approximation 1. Ordnung von $bold(f): RR^n arrow.r RR^m$ an der Stelle $bold(a) in RR^n$:
$ bold(f)(bold(x)) approx bold(f)(bold(a)) + J_f (bold(a)) dot (bold(x) - bold(a)) $
- _Bsp:_ $bold(f)(x,y) = mat(x^2 + y^2; x y)$ an der Stelle $bold(a) = mat(1; 2)$.
  1. $bold(f)(bold(a)) = mat(1^2 + 2^2; 1 dot 2) = mat(5; 2)$
  2. Jacobi: $J_f (x,y) = mat(2x, 2y; y, x) => J_f (bold(a)) = mat(2, 4; 2, 1)$
  3. Formel:
    $
      tilde(bold(f))(x,y) & = mat(5; 2) + mat(2, 4; 2, 1) mat(x - 1; y - 2) \
                          & = mat(2x + 4y - 5; 2x + y - 2)
    $
  4. Approx. für $bold(x) = mat(1.01; 1.98)$ (nahe $bold(a)$):
    $
      tilde(bold(f))(1.01, 1.98) & = mat(5; 2) + mat(2, 4; 2, 1) mat(0.01; -0.02) \
                                 & = mat(4.94; 2.00)
    $
    *(Exakt: $bold(f)(1.01, 1.98) = mat(4.9405; 1.9998)$)*

#show math.equation: set text(size: 6.5pt)

= 3. Optimierung: Stationäre Punkte & Hesse-Matrix
#show math.equation: set text(size: 7.5pt)
_Ziel:_ Lokale Extrema finden & klassifizieren für $f(x,y)$.
- _Bsp:_ $f(x,y) = x^3 - 12 x + y^2$
1. *Stationäre Punkte:* $nabla f(x,y) = mat(3 x^2 - 12; 2 y) limits(=)^! mat(0; 0)$
  $=> 3 x^2 - 12 = 0 => x_(1,2) = +- 2$ und $2 y = 0 => y = 0$. Kandidaten: $P_1(2, 0), P_2(-2, 0)$ \
  #hl[(Tipp: Mit Fällen arbeiten und in die andere Gleichung einsetzen!)]
  - *LGS-Lösungsstrategien für $nabla f = bold(0)$:*
    - *S1: Ausklammern & Nullprodukt* (Trick):
      Nie durch Variable teilen!
      $x y = 2x => x y - 2x = 0 => x(y-2) = 0 =>$ Fall 1: $x=0$, Fall 2: $y=2$.
      Fälle einzeln in andere Gleichung einsetzen.
    - *S2: Einsetzungsverfahren* (Zuverlässig):
      Einfachste Gleichung nach einer Variable auflösen und in andere einsetzen.
      Bsp: $2x - y = 0 => y = 2x$ in (II) einsetzen.
    - *S3: Subtraktion* (Symmetrie-Trick):
      Bei fast identischen Gleichungen (I) - (II) rechnen.
      Oft entsteht $x^2 - y^2 = (x-y)(x+y) = 0 =>$ S1 anwenden.
#grid(
  columns: (1.6fr, 1fr),
  gutter: 6pt,
  [
    2. *Hesse-Matrix:* $H_f (x,y) = mat(f_(x x), f_(x y); f_(y x), f_(y y))$ \
      #v(2pt)
      (In Prüfungsaufgaben meist symmetrisch, da $f_(x y) = f_(y x)$) \
      #v(2pt)
      - Bsp: $H_f (x,y) = mat(6 x, 0; 0, 2)$
  ],
  align(center + horizon)[
    #image("img/hessematrix.png", width: 90%)
  ],
)3. *Punkte einsetzen:* Falls Variablen in $H_f(x,y)$ existieren (z.B. $x$ im Bsp.), jeden stationären Punkt $P_i$ einzeln in $H_f$ einsetzen, um für jeden Punkt eine konstante Matrix zu erhalten. \
\
4. *Definitheit (über quadratische Form):*
  #block[

    #show math.equation: it => {
      show "a": set text(fill: rgb("#1e40af"))
      show "b": set text(fill: rgb("#047857"))
      show "c": set text(fill: rgb("#86198f"))
      show "d": set text(fill: rgb("#0369a1"))
      show "e": set text(fill: rgb("#b91c1c"))
      show "f": set text(fill: rgb("#be185d"))
      set text(size: 6pt)
      it
    }
    Hesse-Matrix $H_f = mat(a, b, d; b, c, e; d, e, f)$ aufstellen $arrow.r$ quadratische Form:
    $
      q(u, v, w) & = mat(u, v, w) mat(a, b, d; b, c, e; d, e, f) mat(u; v; w) \
                 & = a u^2 + c v^2 + f w^2 + 2 b u v + 2 d u w + 2 e v w
    $
  ]
  Bringe durch quadratisches Ergänzen in die Form $c_1 (u + ...)^2 + c_2 (v + ...)^2 + c_3 w^2$:
  - Nur plus ($+$) $=>$ positiv definit $=>$ Minimum
  - Nur minus ($-$) $=>$ negativ definit $=>$ Maximum
  - Beides ($+$ und $-$) $=>$ indefinit $=>$ Sattelpunkt
  - _Klassifikation Bsp:_
    - $P_1(2,0): H_f (2,0) = mat(12, 0; 0, 2) => q(u, v) = mat(u, v) mat(12, 0; 0, 2) mat(u; v) = 12 u^2 + 2 v^2$ (nur $+$) $=>$ Minimum
    - $P_2(-2,0): H_f (-2,0) = mat(-12, 0; 0, 2) => q(u, v) = mat(u, v) mat(-12, 0; 0, 2) mat(u; v) = -12 u^2 + 2 v^2$ (beides) $=>$ Sattelpunkt
  - *Contour Plots (Höhenlinien):*
    - Minima/Maxima: Zentren geschlossener Ringe/Ellipsen.
    - Sattelpunkte: Kreuzungen/Einschnürungen zw. Bergen & Tälern.

== Quadratische Ergänzung
- *1D-Ergänzung:*
  #align(center)[
    #image("img/quadratischerweitern-1.png", width: 40%)
  ]
- *Mehrdimensionale Expansion:* (Es müssen immer alle Kombinationen vorhanden sein)
  #align(center)[
    #image("img/quadratischerweitern-2.png", width: 100%)
  ]

#show math.equation: set text(size: 7.5pt)

= 4. Theorie: PDF, CDF & Maximum Likelihood (MLE)
*A. Wahrscheinlichkeitsdichte (PDF: $f(x)$)*
- Bedingung 1: $f(x) >= 0$ (nie negativ)
- Bedingung 2 (Fläche = 1): $integral_(-oo)^(oo) f(x) dif x = 1$

*B. Kumulative Verteilungsfunktion (CDF: $F(x)$)*
- Definition: $F(x) = P(X <= x) = integral_(-oo)^x f(t) dif t$
- Eigenschaften: $F(-oo) = 0$, $F(oo) = 1$ (monoton steigend)
- Zusammenhang: $f(x) = dif / (dif x) F(x)$ (Dichte ist Ableitung der CDF)

#align(center)[
  #image("img/pdf-cdf.png", width: 60%)
]

*C. Stetige Gleichverteilung $"unif"(a, b)$*
#grid(
  columns: (1.5fr, 1fr),
  gutter: 4pt,
  [
    - Dichte (PDF): $f(x) = 1 / (b - a)$ für $a <= x <= b$, sonst $0$
    - Verteilung (CDF): $F_X (x) = (x - a) / (b - a)$ für $a < x < b$
  ],
  align(center + horizon)[
    #image("img/pdfexample.png", width: 100%)
  ],
)

*D. Statistische Unabhängigkeit*
$X, Y$ unabhängig $<=> f_(X,Y)(x,y) = f_X (x) dot f_Y (y)$ (sonst abhängig)
- _Bsp:_ $f_X(x) = 1/2 dot bb(1)_((0,2))(x)$ und $f_Y(y) = 1/3 dot bb(1)_((0,3))(y)$. \
  Da $f_X (x) dot f_Y (y) = 1/6 dot bb(1)_((0,2))(x) dot bb(1)_((0,3))(y) != 1/6 dot bb(1)_((0,6))(x y) = f_(X,Y)(x,y)$, sind sie *abhängig*. \
  (Gegenbsp: $f_X(1) dot f_Y(5) = 1/2 dot 0 = 0$, aber $f_(X,Y)(1,5) = 1/6 dot bb(1)_((0,6))(5) = 1/6 != 0$)


*E. Maximum Likelihood Estimation (MLE)*
Ziel: Parameter $theta$ finden, die die Wahrscheinlichkeit der Stichprobe maximieren.
_Kochbuch (4 Schritte):_
1. *Likelihood $L(theta)$ aufstellen:* $L(theta) = product_(i=1)^n f(x_i; theta)$
2. *Log-Likelihood $ell(theta)$ (ln anwenden):* \
  $ell(theta) = ln(L(theta)) = sum_(i=1)^n ln(f(x_i; theta))$ (Aus Produkt wird Summe) \
  #text(
    size: 5.5pt,
    fill: rgb("#475569"),
  )[(Kostenfunktion / Neg. Log-Likelihood: $c(theta) = -ell(theta) = -sum ln(f(x_i; theta))$)]
3. *Ableiten:* $partial / (partial theta) ell(theta)$ berechnen.
4. *Nullsetzen & Auflösen:* $partial / (partial theta) ell(theta) limits(=)^! 0 => hat(theta)_(M L E)$
- *Bernoulli-Likelihood (k Erfolge in n Versuchen):* \
  $L(p) = p^k dot (1-p)^(n-k)$

= 5. Kochbuch: Die wichtigsten Aufgabentypen
*Typ 1: Normalisierung (Konstante $c$ finden)*
- Geg: $f(x) = c dot g(x)$ im Intervall $[a, b]$
- *Schritt 1:* Integral $= 1$ setzen: $c dot integral_a^b g(x) dif x = 1$
- *Schritt 2:* Integral berechnen: $K = integral_a^b g(x) dif x$
- *Schritt 3:* Nach $c$ auflösen: $c dot K = 1 => c = 1/K$

*Typ 2: Wahrscheinlichkeit im Intervall ($P(a <= X <= b)$)*
- *Schritt 1:* Integral der PDF von $a$ bis $b$ berechnen:
  $ P(a <= X <= b) = integral_a^b f(x) dif x $

*Typ 3: Die CDF $F(x)$ herleiten*
- Geg: $f(x)$ ab Startwert $a$
- *Schritt 1:* Dummy-Variable $t$ nutzen. Integral aufstellen:
  $ F(x) = integral_a^x f(t) dif t $
- *Schritt 2:* Integrieren, Obergrenze $x$ und Untergrenze $a$ einsetzen.
- *Schritt 3:* Formal korrekt aufschreiben:
  $ F(x) = cases(0 &"für" x < a, text("Ergebnis") &"für" x >= a) $

*Typ 4: Mit der CDF Wahrscheinlichkeiten berechnen*
- Geg: $F(x)$ bekannt. Gesucht: $P(a < X <= b)$
- *Schritt 1:* Obere minus untere Grenze einsetzen:
  $ P(a < X <= b) = F(b) - F(a) $ (Kein Integrieren mehr!)

*Typ 5: Erwartungswert $E(X)$ berechnen*
- *Schritt 1:* Integral über $x dot f(x)$ aufstellen:
  $ E(X) = integral_(-oo)^(oo) x dot f(x) dif x $

*Typ 8: Uneigentliche Integrale (z.B. $P(X > a)$)*
- *Weg 1 (Integral):* $integral_a^oo f(x) dif x$. Stammfunktion bilden, Obergrenze $oo$ einsetzen. Tipp: $e^(-oo) = 0$, $1/oo = 0$.
- *Weg 2 (Schneller, falls $F(x)$ bekannt):* Gegenwahrscheinlichkeit nutzen:
  $ P(X > a) = 1 - P(X <= a) = 1 - F(a) $

*Typ 9: Variablentransformation ($Y = g(X)$)*
- Geg: Dichte $f_X (x)$ auf $[a, b]$, Transformation $y = g(x)$. Gesucht: $f_Y (y)$
- *Grenzen:* Alte Grenzen $[a, b]$ in $g(x)$ einsetzen:
  - Wenn $g$ steigend: $[g(a), g(b)]$ | Wenn $g$ fallend: $[g(b), g(a)]$
- *Schritt 1 (Umkehrfunktion):* Löse $y = g(x)$ nach $x$ auf:
  $ x = #text(fill: rgb("#047857"))[$g^(-1)(y)$] $
- *Schritt 2 (Ableitung):* Leite $x$ nach $y$ ab:
  $ dif x / dif y = #text(fill: rgb("#b91c1c"))[$dif / (dif y) g^(-1)(y)$] $
- *Schritt 3 (Formel & Einsetzen):*
  $ f_Y (y) = f_X (#text(fill: rgb("#047857"))[$g^(-1)(y)$]) dot |#text(fill: rgb("#b91c1c"))[$dif x / dif y$]| $
- *Bsp:* $f_X (x) = 1/2$ auf $[0, 2]$ und $y = x^2$ ($x >= 0$):
  - _Grenzen:_ $x in [0, 2] => y in [0^2, 2^2] = [0, 4]$
  - _Schritt 1:_ $x = #text(fill: rgb("#047857"))[$sqrt(y)$]$
  - _Schritt 2:_ $dif x / dif y = #text(fill: rgb("#b91c1c"))[$1 / (2 sqrt(y))$]$
  - _Schritt 3:_ $f_Y (y) = f_X (#text(fill: rgb("#047857"))[$sqrt(y)$]) dot |#text(fill: rgb("#b91c1c"))[$1 / (2 sqrt(y))$]| = 1/2 dot #text(fill: rgb("#b91c1c"))[$1 / (2 sqrt(y))$] = 1 / (4 sqrt(y))$ auf $[0, 4]$
- *Weg 2 (CDF-Methode, z.B. für $Y = X^p$):*
  1. CDF aufstellen: $F_Y(y) = P(Y <= y) = P(X^p <= y) = P(X <= y^(1/p)) = F_X(y^(1/p))$
  2. PDF durch Ableiten finden: $f_Y(y) = dif / (dif y) F_Y(y)$

#show math.equation: set text(size: 7.5pt)

= 6. Numerische Optimierung: Gradient Descent & Newton

*A. Gradientenabstieg (Gradient Descent)*
- *Ziel:* Iterativ ein lokales Minimum finden.
- *Formel:*
  $
    #text(fill: rgb("#1e40af"))[$bold(x)_(k+1)$] = #text(fill: rgb("#1e40af"))[$bold(x)_k$] - #text(fill: rgb("#b91c1c"))[$alpha$] dot #text(fill: rgb("#047857"))[$nabla f(bold(x)_k)$]
  $
  mit $#text(fill: rgb("#b91c1c"))[$alpha$]$ = Lernrate / Step Size $> 0$
- *Kochbuch-Bsp:* $f(x,y) = x^2 + 2 y^2$, Startwert $#text(fill: rgb("#1e40af"))[$bold(x)_0 = mat(2; 1)$]$, Lernrate $#text(fill: rgb("#b91c1c"))[$alpha = 0.1$]$. Gesucht $#text(fill: rgb("#1e40af"))[$bold(x)_1$]$:
  1. Gradient allgemein: $nabla f(x,y) = mat(2 x; 4 y)$
  2. $#text(fill: rgb("#1e40af"))[$bold(x)_0$]$ einsetzen: $#text(fill: rgb("#047857"))[$nabla f(2,1) = mat(4; 4)$]$
  3. Formel anwenden:
    $
      #text(fill: rgb("#1e40af"))[$bold(x)_1$] &= #text(fill: rgb("#1e40af"))[$mat(2; 1)$] - #text(fill: rgb("#b91c1c"))[$0.1$] dot #text(fill: rgb("#047857"))[$mat(4; 4)$] \
      &= #text(fill: rgb("#1e40af"))[$mat(2; 1)$] - mat(0.4; 0.4) = #text(fill: rgb("#1e40af"))[$mat(1.6; 0.6)$]
    $
- *Verhalten im Contour Plot:*
  Bewegung immer orthogonal (senkrecht) zu den Höhenlinien in Richtung des tiefsten Punktes. Bei zu grosser Lernrate $alpha$ kann das Minimum übersprungen werden.
- *Fehlende globale Konvergenz (3 Szenarien):*
  1. *Lokales statt globales Minimum:*
    - _Häufigkeit:_ Sehr wahrscheinlich bei mehreren Minima.
    - _Fix:_ Verschiedene Startpunkte wählen.
  2. *Sattelpunkt / Maximum (stat. Punkt):*
    - _Häufigkeit:_ Sehr unwahrscheinlich.
    - _Fix:_ Anderen Startpunkt wählen.
  3. *Overshooting / Keine Konvergenz:*
    - _Häufigkeit:_ Wahrscheinlich bei grosser Lernrate $alpha$ (v.a. in engen Tälern).
    - _Fix:_ Kleinere Lernrate $alpha$ wählen.


*B. Newton-Verfahren (Newton's Method)*
- *Variante 1: Nullstellensuche (1D)*: $f(x) = 0$
  $ x_(k+1) = x_k - f(x_k) / f'(x_k) $
  - _Bsp:_ $f(x) = x^2 - 5$, $x_0 = 2$. Gesucht $x_1$:
    $f'(x) = 2x => x_1 = 2 - (2^2 - 5) / (2 dot 2) = 2 - (-1)/4 = 2.25$

- *Variante 2: Minimumsuche (Multivariat)*: $nabla f = bold(0)$
  - *Newton-Formel:*
    $
      #text(fill: rgb("#1e40af"))[$bold(x)_(k+1)$] = #text(fill: rgb("#1e40af"))[$bold(x)_k$] - #text(fill: rgb("#86198f"))[$[H_f (bold(x)_k)]^(-1)$] dot #text(fill: rgb("#047857"))[$nabla f(bold(x)_k)$]
    $
  - *Hilfsformeln (Komponenten):*
    - Gradient: $#text(fill: rgb("#047857"))[$nabla f(x,y)$] = mat(f_x; f_y) = mat(partial f / partial x; partial f / partial y)$
    - Hesse-Matrix: $#text(fill: rgb("#86198f"))[$H_f (x,y)$] = mat(f_(x x), f_(x y); f_(y x), f_(y y))$
  - *Diagonal-Matrix Invertierungs-Trick:*
    $ mat(a, 0; 0, b)^(-1) = mat(1/a, 0; 0, 1/b) $ (Kehrwerte der Diagonalelemente)
  - _Bsp:_ Geg: $f(x,y) = x^2 + 2 y^2 + 4 y$, Startwert $#text(fill: rgb("#1e40af"))[$bold(x)_0 = mat(1; 1)$]$. Gesucht $#text(fill: rgb("#1e40af"))[$bold(x)_1$]$:
    1. Gradient & Hesse-Matrix allgemein:
      $ nabla f(x,y) = mat(2 x; 4 y + 4) , quad H_f (x,y) = mat(2, 0; 0, 4) $
    2. Punkt einsetzen: $#text(fill: rgb("#047857"))[$nabla f(1,1) = mat(2; 8)$] , quad #text(fill: rgb("#86198f"))[$H_f (1,1) = mat(2, 0; 0, 4)$]$
    3. $H_f$ invertieren (Diagonal-Trick): $#text(fill: rgb("#86198f"))[$[H_f(1,1)]^(-1)$] = mat(1/2, 0; 0, 1/4)$
    4. Schritt berechnen ($#text(fill: rgb("#0369a1"))[$Delta bold(x)$] = -#text(fill: rgb("#86198f"))[$H_f^(-1)$] dot #text(fill: rgb("#047857"))[$nabla f$]$):
      $
        #text(fill: rgb("#0369a1"))[$Delta bold(x)$] = - mat(1/2, 0; 0, 1/4) mat(2; 8) = mat(- 1/2 dot 2; - 1/4 dot 8) = #text(fill: rgb("#0369a1"))[$mat(-1; -2)$]
      $
    5. Update: $#text(fill: rgb("#1e40af"))[$bold(x)_1$] = #text(fill: rgb("#1e40af"))[$mat(1; 1)$] + #text(fill: rgb("#0369a1"))[$mat(-1; -2)$] = #text(fill: rgb("#1e40af"))[$mat(0; -1)$]$
  - *Alternativer Newton-Schritt über LGS (Extended):*
    Löse $#text(fill: rgb("#86198f"))[$H_f$] dot #text(fill: rgb("#0369a1"))[$Delta bold(x)$] = -#text(fill: rgb("#047857"))[$nabla f$]$ nach $#text(fill: rgb("#0369a1"))[$Delta bold(x)$]$ auf (z.B. mit Gauss-LGS), falls $H_f$ nicht einfach invertierbar ist.

- *Hesse-Matrix Operationen:*
  - *Transponieren:* Da $H_f$ symmetrisch ist ($f_(x y) = f_(y x)$), gilt immer $H_f^T = H_f$ (allgemein: Zeilen & Spalten vertauschen).
  - *2x2 Invertieren:* $mat(a, b; c, d)^(-1) = 1 / (a d - b c) mat(d, -b; -c, a)$

#show math.equation: set text(size: 6.5pt)

= Ableitungsregeln

#table(
  columns: (1fr, 1.2fr),
  stroke: 0.3pt + rgb("#cbd5e1"),
  fill: (col, row) => if row == 0 { rgb("#2a6f97") } else { none },
  inset: 2.5pt,
  align: (left + horizon, left + horizon),
  table.header(
    text(fill: white, weight: "bold")[Funktion $f(x)$],
    text(fill: white, weight: "bold")[Ableitung $f'(x) = dif f / dif x$],
  ),
  [$c$ (Konstante)], [$0$],
  [$x$], [$1$],
  [$x^2$], [$2x$],
  [$x^n$], [$n x^(n-1)$],
  [$1/x$], [$-1/x^2$],
  [$sqrt(x)$], [$1/(2 sqrt(x))$],
  [$e^x$], [$e^x$],
  [$e^(g(x))$], [$g'(x) e^(g(x))$ #text(size: 5.5pt, fill: rgb("#64748b"))[(Kettenregel)]],
  [$a^x$], [$\ln(a) a^x$],
  [$ln(x)$], [$1/x$],
  [$ln(g(x))$], [$g'(x) / g(x)$ #text(size: 5.5pt, fill: rgb("#64748b"))[(Log.-Trick)]],
  [$log_b(x)$], [$1 / (\ln(b) x)$],
  [$sin(x)$], [$cos(x)$],
  [$cos(x)$], [$-sin(x)$],
  [$tan(x)$], [$1 / cos^2(x) = 1 + tan^2(x)$],
  [$arcsin(x)$], [$1 / sqrt(1 - x^2)$],
  [$arccos(x)$], [$-1 / sqrt(1 - x^2)$],
  [$arctan(x)$], [$1 / (1 + x^2)$],
  [Sigmoid $sigma(x)$],
  [$sigma(x) (1 - sigma(x))$ #text(size: 5.5pt, fill: rgb("#64748b"))[mit $sigma(x) = 1/(1+e^(-x))$]],

  [$ln(sigma(x))$], [$1 - sigma(x)$ #text(size: 5.5pt, fill: rgb("#64748b"))[(FS23)]],
  [Produktregel], [$(u v)' = u' v + u v'$],
  [Quotientenregel], [$(u/v)' = (u' v - u v') / v^2$],
  [Totale Ableitung], [$dif f / dif t = partial f / partial x dif x / dif t + partial f / partial y dif y / dif t$],
)

= Integrationsregeln
#text(size: 5.5pt, fill: rgb("#b91c1c"))[*Nach dem Integrieren + C nicht vergessen!*]

#table(
  columns: (1fr, 1.2fr),
  stroke: 0.3pt + rgb("#cbd5e1"),
  fill: (col, row) => if row == 0 { rgb("#2a6f97") } else { none },
  inset: 2.5pt,
  align: (left + horizon, left + horizon),
  table.header(
    text(fill: white, weight: "bold")[Funktion $f(x)$],
    text(fill: white, weight: "bold")[Integral $integral f(x) dif x$],
  ),
  [$0$], [$C$ #text(size: 5.5pt, fill: rgb("#64748b"))[(Integrationskonstante)]],
  [$K$ (Konstante)], [$K x + C$],
  [$x^n$ #text(size: 5.5pt, fill: rgb("#64748b"))[($n != -1$)]], [$x^(n+1) / (n+1) + C$],
  [$sqrt(x)$], [$2/3 x^(3/2) + C$],
  [$1/sqrt(x)$], [$2 sqrt(x) + C$],
  [$1/x$], [$ln |x| + C$],
  [$e^x$], [$e^x + C$],
  [$e^(a x)$], [$1/a e^(a x) + C$],
  [$a^x$], [$1/ln(a) a^x + C$],
  [$sin(x)$], [$-cos(x) + C$],
  [$cos(x)$], [$sin(x) + C$],
  [$1 / cos^2(x)$], [$tan(x) + C$],
  [$1 / sqrt(1-x^2)$], [$arcsin(x) + C$],
  [$1 / (1+x^2)$], [$arctan(x) + C$],
  [$ln(x)$], [$x ln(x) - x + C$],
  [$arcsin(x)$], [$x arcsin(x) + sqrt(1 - x^2) + C$],
  [$arccos(x)$], [$x arccos(x) - sqrt(1 - x^2) + C$],
  [$a / x^(a+1)$], [$-x^(-a) + C$ #text(size: 5.5pt, fill: rgb("#64748b"))[(FS25)]],
  [Part. Integration], [$integral u v' dif x = u v - integral u' v dif x$],
  [Substitution], [$integral f(g(x)) g'(x) dif x = integral f(u) dif u$],
  [Uneigentl. Int.], [$integral_1^oo (a / x^(a+1)) dif x = 1$ #text(size: 5.5pt, fill: rgb("#64748b"))[(für $a > 0$)]],
)

= Logarithmusgesetze

#table(
  columns: (1fr, 1.2fr),
  stroke: 0.3pt + rgb("#cbd5e1"),
  fill: (col, row) => if row == 0 { rgb("#2a6f97") } else { none },
  inset: 2.5pt,
  align: (left + horizon, left + horizon),
  table.header(text(fill: white, weight: "bold")[Regel], text(fill: white, weight: "bold")[Formel]),
  [Multiplikation], [$ln(a dot b) = ln(a) + ln(b)$],
  [Division], [$ln(a / b) = ln(a) - ln(b)$],
  [Potenzierung], [$ln(a^b) = b dot ln(a)$],
  [Konstante 1], [$ln(1) = 0$],
  [Konstante e], [$ln(e) = 1$],
  [Basiswechsel], [$log_b (a) = ln(a) / ln(b)$],
  [Spezialfälle], [$e^(-ln(2)) = 1/2 quad | quad ln(e^(-2)) = -2$],
)

= 7. Machine Learning: Aktivierungen & Losses
#show math.equation: set text(size: 7.5pt)

== Aktivierungsfunktionen
#grid(
  columns: (1.5fr, 1fr),
  gutter: 4pt,
  [
    - *Sigmoid (Binary Classification):*
      $ sigma(z) = frac(1, 1 + e^(-z)) $
      Ableitung: $sigma'(z) = sigma(z) (1 - sigma(z))$
  ],
  align(center + horizon)[
    #image("img/sigmoid.png", width: 100%)
  ],
)
- *Softmax (Multi-Class Classification):*
  Für Vektor $bold(z) in RR^K$:
  $ "Softmax"(bold(z))_i = frac(e^(z_i), sum_(j=1)^K e^(z_j)) $

== Loss-Funktionen (Kostenfunktionen)
- *Log Loss / Binary Cross-Entropy (BCE):*
  Für Wahrscheinlichkeit $p = sigma(z)$ und wahres Label $y in {0, 1}$:
  $ cal(L)_"BCE"(y, p) = - y ln(p) - (1 - y) ln(1 - p) $
- *Multi-Class Cross-Entropy (CE):*
  Für Vorhersagen $p_i = "Softmax"(bold(z))_i$ und wahre Wahrscheinlichkeiten $y_i$ (One-Hot):
  $ cal(L)_"CE"(bold(y), bold(p)) = - sum_(i=1)^K y_i ln(p_i) $
- *Prüfungs-Shortcut (Gradient bzgl. Logit $z_i$):*
  Gilt bei BCE+Sigmoid sowie CE+Softmax:
  $ frac(partial cal(L), partial z_i) = p_i - y_i $

= Trigonometrische Werte
#align(center)[
  $tan(x) = sin(x)/cos(x)$ \
  #v(2pt)
  #image("img/trigonometriewerte.png", width: 100%)
]

= Wichtige Konstanten & Grenzwerte
#table(
  columns: (1fr, 1.2fr),
  stroke: 0.3pt + rgb("#cbd5e1"),
  fill: (col, row) => if row == 0 { rgb("#2a6f97") } else { none },
  inset: 2.5pt,
  align: (left + horizon, left + horizon),
  table.header(text(fill: white, weight: "bold")[Ausdruck / Limes], text(fill: white, weight: "bold")[Wert]),
  [$e^0$], [$1$],
  [$e^1$], [$e approx 2.718$],
  [$e^(-1) = 1/e$], [$approx 0.368$],
  [$pi$], [$approx 3.1415$],
  [$sqrt(2)$], [$approx 1.414$],
  [$sqrt(3)$], [$approx 1.732$],
  [$lim_(x -> oo) 1/x$], [$0$],
  [$lim_(x -> 0^+) 1/x$], [$+oo$],
  [$lim_(x -> 0^-) 1/x$], [$-oo$],
  [$lim_(x -> oo) e^x$], [$oo$],
  [$lim_(x -> -oo) e^x$], [$0$],
  [$lim_(x -> oo) ln(x)$], [$oo$],
  [$lim_(x -> 0^+) ln(x)$], [$-oo$],
  [$lim_(x -> oo) x^n e^(-x)$], [$0$],
  [$lim_(x -> oo) frac(ln(x), x)$], [$0$],
  [$lim_(x -> 0^+) x ln(x)$], [$0$],
  [$lim_(x -> oo) (1 + a/x)^x$], [$e^a$],
  [$lim_(x -> oo) sigma(x)$], [$1$],
  [$lim_(x -> -oo) sigma(x)$], [$0$],
)
