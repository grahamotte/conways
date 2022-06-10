# elixir conway.ex

defmodule Conway do
  def new_board(size) do
    0..size |> Enum.map(fn _ ->
      0..size |> Enum.map(fn _ ->
        Enum.random(0..1) == 1
      end)
    end)
  end

  def tick(board) do
    board |> Enum.with_index |> Enum.map(fn row ->
      { row_values, row_index } = row
      row_values |> Enum.with_index |> Enum.map(fn col ->
        { cell, col_index } = col
        live_or_die(board, row_index, col_index)
      end)
    end)
  end

  defp mod(a, b) do
    rem = rem(a, b)
    if rem < 0, do: rem + b, else: rem
  end

  defp live_or_die(board, row, col) do
    len = length(board)
    neighbors = Enum.count([
      board |> Enum.at(mod(row + 0, len)) |> Enum.at(mod(col + 1, len)),
      board |> Enum.at(mod(row + 0, len)) |> Enum.at(mod(col - 1, len)),
      board |> Enum.at(mod(row + 1, len)) |> Enum.at(mod(col + 0, len)),
      board |> Enum.at(mod(row - 1, len)) |> Enum.at(mod(col + 0, len)),
      board |> Enum.at(mod(row + 1, len)) |> Enum.at(mod(col + 1, len)),
      board |> Enum.at(mod(row - 1, len)) |> Enum.at(mod(col - 1, len)),
      board |> Enum.at(mod(row + 1, len)) |> Enum.at(mod(col - 1, len)),
      board |> Enum.at(mod(row - 1, len)) |> Enum.at(mod(col + 1, len)),
    ], &(&1))

    case board |> Enum.at(row) |> Enum.at(col) do
      true -> case neighbors do
        2 -> true
        3 -> true
        _ -> false
      end
      false -> case neighbors do
        3 -> true
        _ -> false
      end
    end
  end

  def to_s(board) do
    board |> Enum.map(fn row ->
      row |> Enum.map(fn i ->
        if i do
          '#'
        else
          '.'
        end
      end)
      |> Enum.join(" ")
    end)
    |> Enum.join("\n")
  end
end

board = Conway.new_board(20)

Enum.reduce(1..100, board, fn (_, board) ->
  IO.puts Conway.to_s(board)
  IO.puts ''

  Process.sleep(100)

  board |> Conway.tick
end)
