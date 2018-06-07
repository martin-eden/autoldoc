# Supported and not supported cases

## Supported

* Named global function.

  ```lua
  function array2d.remove_col(t, j)
  end
  ```

  This is a common form to describe global function.

## Not supported

* Assignment to function.

  ```lua
  array2d.remove_row = remove
  ```

  Hard to implement.

* Named local function.

  ```lua
  local function dimension(t)
  end
  ```

  Not many want to document (and read documentation) for local
  functions.

* Anonymous function.

  ```lua
  f =
    function(a)
    end
  ```

  ```lua
  local DataMT = {
    column_by_name = function(self, name)
    end,
  }
  ```

  Hard to distinguish between global functions (than we wish to
  document) and other functions (which we're not going to document).


## Implementation stages

1. LDoc comments added if entity has no LDoc comments yet.

   So already present comments will never be changed automatically.

2. Function parameter comments match function parameters.

   This inroduces danger of dropping valuable description text because
   parameter was renamed. Also this requires more coding work in
   parsing comment structure.

Currently stage 1 is implemented.

---

```
2017-08-28
2018-06-07 better docs
```
