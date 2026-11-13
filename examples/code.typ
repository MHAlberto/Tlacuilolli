#import "../lib.typ": code-listing, note-document

#show: note-document.with(
  title: [Code in research notes],
  subtitle: [Syntax and line numbers in Tlacuilolli],
  category: [Computing],
  author: "Folio Notes contributors",
  description: [Examples of source code listings in six programming languages.],
  keywords: ("source code", "syntax highlighting", "line numbers"),
)

Code belongs close to the observation it supports. Each listing has its
own line numbers, so a note can point to a step in an implementation
while keeping the surrounding discussion in ordinary prose.

= Transforming data

The Python example uses a list comprehension to keep only nonnegative
measurements @python-list-comprehensions. The guard on line 4 avoids
dividing by zero when the filtered list is empty.

```python
def mean_nonnegative(samples):
    """Return the mean of the nonnegative samples."""
    values = [value for value in samples if value >= 0]
    return sum(values) / len(values) if values else None

# The negative measurement is omitted.
print(mean_nonnegative([2, -1, 4, 6]))
```

In JavaScript, `map` converts each measurement from seconds to
milliseconds @ecmascript-array-map.

```javascript
const seconds = [0.25, 0.5, 1];
const milliseconds = seconds.map(value => value * 1000);

console.log("Samples in ms:", milliseconds);
```

The Rust function filters the even values from a borrowed slice and sums
them on line 2 @rust-iterator.

```rust
fn sum_even(values: &[i32]) -> i32 {
    values.iter().copied().filter(|n| n % 2 == 0).sum()
}
```

#pagebreak()

= Comparing implementations

All three examples return `2` for `[3, -1, 0, 5]`. C uses an indexed loop
@c-for-statement. #box[C++] iterates directly over the values @cpp-range-for.
Java filters the stream before counting @java-int-stream.

```c
int count_positive(const int values[], int length) {
    int count = 0;
    for (int i = 0; i < length; ++i) {
        if (values[i] > 0) ++count;
    }
    return count;
}
```

#code-listing(
  ```cpp
  #include <vector>

  int count_positive(const std::vector<int>& values) {
      int count = 0;
      for (int value : values) {
          if (value > 0) ++count;
      }
      return count;
  }
  ```,
  start: 14,
)

```java
import java.util.Arrays;

static long countPositive(int[] values) {
    return Arrays.stream(values)
        .filter(value -> value > 0)
        .count();
}
```

#bibliography("assets/references.bib", title: [References], style: "ieee")
