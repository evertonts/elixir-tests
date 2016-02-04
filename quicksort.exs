defmodule Sort do
  def quicksort(list) when length(list) < 2, do: list
  def quicksort(list) do
    [divider| tail] = list
    {left, right} = partition(tail, divider)
    left = :lists.reverse([divider | left])
    quicksort(left) ++ quicksort(right)
  end

  def partition([], _divider), do: {[],[]}

  def partition(list, divider) do
    {acc1, acc2} = Enum.reduce(list, {[], []}, fn(entry, {acc1, acc2}) ->
      if entry < divider do
        {[entry|acc1], acc2}
      else
        {acc1, [entry|acc2]}
      end
    end)

    {acc1, acc2}
  end
end

ExUnit.start()

defmodule Test do
  use ExUnit.Case

  test 'partition for empty list returns empty list' do
    assert Sort.partition([], 1) == {[], []}
  end

  test 'partition for a one element list returns an one element list' do
    assert Sort.partition([1], 2) == {[1], []}
    assert Sort.partition([2], 1) == {[], [2]}
  end

  test 'partition for [1,2], 1 returns {[1], [2]}' do
    assert Sort.partition([1,2], 1) == {[], [2, 1]}
  end

  test 'partition for [1,2,4,5], 4 returns {[1,2,4], [5]}' do
    assert Sort.partition([1,2,4,5], 4) == {[2,1], [5, 4]}
  end

  test 'quicksort for empty list returns an empty list' do
    assert  Sort.quicksort([]) == []
  end

  test 'quicksort for an one element list returns the same one element list' do
    assert Sort.quicksort([1]) == [1]
  end

  test 'quicksort with a two elements list sort its elements' do
    assert Sort.quicksort([2, 1]) == [1, 2]
    assert Sort.quicksort([2, 1, 5, 9]) == [1, 2, 5, 9]
    assert Sort.quicksort([1, 1, 5, 4, 4, 6]) == [1, 1, 4, 4, 5, 6]
  end
end
