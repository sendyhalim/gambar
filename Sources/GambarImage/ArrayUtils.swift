import Swiftz

func splitBy<T> (f: (T) -> Bool, items: Array<T>) -> Array<Array<T>> {
  return items.reduce([]) { acc, item in
    if f(item) {
      return acc + [[item]]
    }

    let lastGroup = acc.last ?? []
    let initGroups = Array(acc.dropLast())

    return initGroups + [ lastGroup + [item] ]
  }
}

func zipWith<T, U> (f: (T, T) -> U, xs: Array<T>, ys: Array<T>) -> Array<U> {
  if xs.isEmpty || ys.isEmpty {
    return []
  }

  let x = xs.first!
  let y = ys.first!

  return [ f(x, y) ] + zipWith(f: f, xs: Array(xs.dropFirst()), ys: Array(ys.dropFirst()))
}
