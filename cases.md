Cases that will and will not be supported.

Most code chunks from PenLight source (library which spawned ldoc).

At the first stage LDoc comments will be created for all supported
cases if there is no LDoc comments for them. (So that comments will
never be changed automatically.)

At the second stage automatic comment update for new/gone function
parameters may be done. (This requires carefully parsing comment
structure. And thoughts about common backfires (like that then big
annotation text will be dropped just because we renamed parameter).)

-- IS supported

  * Named non-local function.

    --- remove a column from an array.
    -- @array2d t a 2d array
    -- @int j a column index
    function array2d.remove_col (t,j)
        assert_arg(1,t,'table')
        for i = 1,#t do
            remove(t[i],j)
        end
    end

-- NOT supported

  * Assignment to function.

    --- remove a row from an array.
    -- @function array2d.remove_row
    -- @array2d t a 2d array
    -- @int i a row index
    array2d.remove_row = remove

  * Local functions definition.

    local function dimension (t)
      return type(t[1])=='table' and 2 or 1
    end

  * Anonymous functions ("function" value type)

    local DataMT = {
      column_by_name = function(self,name)
        if type(name) == 'number' then
          name = '$'..name
        end
        local arr = {}
        for res in data.query(self,name) do
          append(arr,res)
        end
        return makelist(arr)
      end,

    f =
      function(a)
      end

  * Parameter types guessing. All function arguments is listed
    under "@param" tag.
