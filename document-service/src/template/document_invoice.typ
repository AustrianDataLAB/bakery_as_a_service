#import "@preview/based:0.1.0": base64

// for debugging
#let show_boxes = false

#let transparent = rgb(255,255,255,255)

#let box_fill = {
  if show_boxes {
    luma(240)
  } else {
    transparent
  }
}

#let data = json.decode(sys.inputs.data)

#let margin = (
  left: 2.5cm,
  top: 2.5cm,
  right: 2cm,
  bottom: 3cm,
)

#set page(
  paper: "a4",
  margin: margin,
  footer: context [
    #set text(8pt)
    #line(length: 100%)
    #grid(columns: (auto, 1fr, auto), column-gutter: 1.5cm)[
      #box()[
        #set align(left)
        #data.header.sender.join("\n")
      ]
    ][
      #set align(center)
      #data.content.bankinfo.pairs().map(((k,v)) => text(weight: "bold", k) + " " + v).join(" ")
    ][
      #set align(right)
      Seite #counter(page).display(
      "1 von 1",
      both: true,
    )
    ]
  ]
)

#set text(
  font: "Inter",
  size: 12pt
)

// header
#place(
  top+left,
  clearance: 0pt,
  dy: -margin.top,
  dx: -margin.left,
  box(
    width: 100% + margin.left + margin.right,
    height: 27mm,
    inset: (
      top: 5mm,
      left: 5mm,
      right: 10mm,
    ),
    fill: box_fill,
    align(right, image.decode(
      base64.decode(data.header.logo.image),
      format: data.header.logo.format,
    )),
  )
)

// See DIN676 / DIN5008 / Falzmarke
// Falzmarke 1 bei 87mm
#place(top + left,
  clearance: 0pt,
  dy: 87mm - margin.top,
  dx: 1cm - margin.left,
  line(length: 1cm)
)

// Falzmarke 2 bei 192mm
#place(top + left,
  clearance: 0pt,
  dy: 192mm - margin.top,
  dx: 1cm - margin.left,
  line(length: 1cm)
)

// Mittelmarke/Lochmarke bei 148.5mm
#place(top + left,
  clearance: 0pt,
  dy: 148.5mm - margin.top,
  dx: 1cm - margin.left,
  line(length: 1.2cm)
)

// Addressfeld
#place(
  top + left,
  clearance: 0pt,
  dx: 25mm - margin.left,
  dy: 27mm - margin.top,
)[
  #box(width: 80mm, height: 45mm, fill: box_fill, inset: 5mm)[
    #text(size: 9pt, data.header.sender.join(", ")) \

    #data.header.recipient.join("\n")
  ]
]

// Firmen Info
#place(
  top + right,
  clearance: 0pt,
  dx: -10mm + margin.right,
  dy: 32mm - margin.top,
  box(width: 75mm, height: 63mm, fill: box_fill,
    grid(columns: (auto, auto), align: (right, left), stroke: none, gutter: 3mm,
      grid.cell(colspan: 2, align: left)[#text(weight: "bold",data.header.info.name)],
      ..data.header.info.contents.flatten()
    )
  )
)

//

#v(103.46mm - margin.top)
== #data.content.title
#data.content.content

#let stroke_color = black

#let table_entries = data.content.entries.enumerate().map(((n, e)) => (str(n+1),) + e)

#let list = grid(
  columns: (auto,) + (data.content.colwidth.map((w) => if type(w) == int {1fr * w} else {auto})),
  align: (right,) + data.content.align.map((a) => if a == "left" {left} else {right}),
  inset: 0.6em,
  fill: (_,row) => if calc.odd(row) {luma(240)} else {transparent},
  grid.header([*Pos.*], ..data.content.fields.map((a) => text(weight: "bold", a))),
  grid.hline(stroke: stroke_color),
  ..table_entries.flatten(),
  grid.hline(stroke: stroke_color)
)

#list

#align(right, box(width: 45%, table(
    columns: (1fr, auto),
    align: (left, right),
    stroke: none,
    ..data.content.totals.slice(0, -1).flatten(),
    table.hline(stroke: stroke_color),
    table.cell(fill: luma(240), text(weight: "bold", data.content.totals.at(-1).at(0))),
    table.cell(fill: luma(240), text(weight: "bold", data.content.totals.at(-1).at(1)))
  ),
))

#data.content.postmessage