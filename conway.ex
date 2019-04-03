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
        num_neighbors = live_neighbors(board, row_index, col_index)

        case cell do
          true -> case num_neighbors do
            2 -> true
            3 -> true
            _ -> false
          end
          false -> case num_neighbors do
            3 -> true
            _ -> false
          end
        end
      end)
    end)
  end

  defp live_neighbors(board, row, col) do
    Enum.count([
      dig_val(board, row + 0, col + 1),
      dig_val(board, row + 0, col - 1),
      dig_val(board, row + 1, col + 0),
      dig_val(board, row - 1, col + 0),
      dig_val(board, row + 1, col + 1),
      dig_val(board, row - 1, col - 1),
      dig_val(board, row + 1, col - 1),
      dig_val(board, row - 1, col + 1),
    ], &(&1))
  end

  defp dig_val(board, row, col) do
    row = rem(row, length(board))
    col = rem(col, length(board))

    try do
      board |> Enum.at(row) |> Enum.at(col)
    rescue
      _ -> nil
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
