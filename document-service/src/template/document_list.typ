/// Template for autogenerating lists
/// Parts of this template are taken from https://github.com/jomaway/typst-teacher-templates


/// Create a checkbox
///
/// - fill (color): background color of the box
/// - tick (bool): if true a checkmark symbol is shown inside the box.
/// -> content
#let checkbox(fill: none, tick: false) = box(
  width: 0.8em, 
  height: 0.8em, 
  stroke: 0.7pt, 
  radius: 1pt, 
  fill: fill,
  if (tick) { align(horizon + center, sym.checkmark) }
)

/// Create a autosized small colored and rounded box around the content.
///
/// - value (content): the content to show
/// - fill (color): background of the box
/// -> content
#let tagit(value, fill: orange.lighten(45%)) = {
  if value != none {
    context {
      let size = measure(value)
      box(
        width: size.width + 6pt,
        inset: (x: 3pt, y: 0pt),
        outset: (y: 3pt),
        radius: 2pt,
        fill: fill
      )[#value]
    }
  }
}

#let eval_row(row) = {
    row = row.map(cell => {
        if (cell == false) { align(center, checkbox()) }
        else if (cell == true) { align(center,checkbox(fill: green.lighten(30%), tick: true)) }
        else { str(cell).trim() } 
    })
    row.push("")
    row
}


/// prints a list of students from the given data.
#let document_table(data, tag: none, numbered: false, lines: false, rh: auto) = {
    assert(type(numbered) == bool, message: "expected numbered parameter to be a [bool], found " + type(numbered))
    assert.eq(type(lines),bool, message: "expected lines parameter to be a [bool], found " + type(lines))
    assert(type(rh) == length or rh == auto, message: "expected rh parameter to be [auto] or a [length], found " + type(rh))
    assert(type(tag) == str or tag == none, message: "expected tag parameter tp be a [str] or [none], found " + type(tag))

    let header = data.at(0);
    let body = data.slice(1).map(row => eval_row(row));

    if (numbered) {
        header.insert(0, "Nr");
        body = body.enumerate().map(((i, row)) => (str(i+1), row).flatten());
    }
    
    let cols = (auto,) * header.len()
    cols.push(1fr)

    header.push(strong(delta: -200, place(end + horizon, tagit(tag))))
    
    // grid settings
    show grid.cell.where(y: 0): it => strong(delta: 200)[#it]
    let stroke_color = luma(200)
    set grid.vline(stroke: stroke_color)


    let list = grid(
        columns: cols,
        rows: rh,
        inset: 0.6em,
        stroke: (col, _) => if (lines) { (right: stroke_color)},
        fill: (_, row) => if calc.odd(row) { luma(240) } else { white },
        align: (col,_) => if (numbered and col == 0) {horizon + end} else {horizon + start },
        grid.header(..header),
        grid.hline(stroke: stroke_color),
        ..body.flatten(),
        if (numbered) {grid.vline(x:1)} // must be at last position
    )
    
    // wrapper to display the round corners.
    block(
        stroke: stroke_color,
        radius: 5pt,
        clip: true,
        list
    )
}

//
// Actual Page Setup
//


#let data = json.decode(sys.inputs.data)

#set page(
  "a4",
  margin: 1cm,
  footer: [
    #data.title
    #h(1fr)
    Generiert am #datetime.today().display("[year]-[month]-[day]")
  ]
)
    
#set text(14pt, font:"Inter", weight: 300, lang: "de")

//
// Page starts here
//

= #{data.title}

#document_table(
  numbered: data.numbered, 
  lines: data.lines,
  tag: data.tag,
  (data.header,) + data.rows,
);
