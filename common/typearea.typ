//! Type area utils like KOMA

#let tex-pt-to-typ-pt(tpt) = {
  (tpt * 72) / 72.27
}

#let TeX-10pt = tex-pt-to-typ-pt(10pt)
#let TeX-11pt = tex-pt-to-typ-pt(11pt)
#let TeX-12pt = tex-pt-to-typ-pt(12pt)

#let is-close-to(a, b) = {
  let diff = if a > b { a - b } else { b - a }
  diff < .5pt
}

#let divs(fontsize) = {
  if fontsize < TeX-10pt or is-close-to(TeX-10pt, fontsize) {
    8
  } else if is-close-to(TeX-11pt, fontsize) {
    10
  } else {
    12
  }
}

#let typearea(
  div: none,
  binding-correction: 0mm,
  two-sided: true,
  font-size: 11pt,
  header-include: false,
  footer-include: false,
  header-height: 1.25em,
  header-sep: 1.5em,
  footer-height: 1.25em,
  footer-sep: 3.5em,
) = {
  if div == none {
    div = divs(font-size)
  }

  let width = 100% - binding-correction
  let height = 100%
  let content-height = height / div * (div - 3)
  let header-space = header-height + header-sep
  let footer-space = footer-height + footer-sep

  let h-div = height / div
  let w-div = width / div

  let top-margin = h-div + if header-include { header-space } else { 0pt }
  let bottom-margin = (
    h-div * 2 + if footer-include { footer-space } else { 0pt }
  )

  if two-sided {
    (
      "top": top-margin,
      "bottom": bottom-margin,
      "inside": w-div + binding-correction,
      "outside": w-div * 2,
    )
  } else {
    (
      "top": top-margin,
      "bottom": bottom-margin,
      "left": w-div * 1.5,
      "right": w-div * 1.5 + binding-correction,
    )
  }
}
