import Swiftz

func splitBy<T> (f: (T, Int) -> Bool, items: Array<T>) -> Array<Array<T>> {
  return items.reduce(([], -1)) { acc, item in
    let (arr, previousIndex) = acc
    let index = previousIndex + 1

    if f(item, index) {
      return (arr + [[item]], index)
    }

    let lastGroup = arr.last ?? []
    let initGroups = Array(arr.dropLast())

    return (initGroups + [ lastGroup + [item] ], index)
  }.0
}

func zipWith<T, U> (f: (T, T) -> U, xs: Array<T>, ys: Array<T>) -> Array<U> {
  if xs.isEmpty || ys.isEmpty {
    return []
  }

  let x = xs.first!
  let y = ys.first!

  return [ f(x, y) ] + zipWith(f: f, xs: Array(xs.dropFirst()), ys: Array(ys.dropFirst()))
}
