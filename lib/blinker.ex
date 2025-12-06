defmodule Blinker do
  @moduledoc """
  Documentation for `Blinker`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Blinker.hello()
      :world

  """

  @red_pin "GPIO26"
  @yellow_pin "GPIO5"
  @green_pin "GPIO6"

  def hello do
    :world
  end

  def heellllooo do
    :newman
  end

  def random_for_5_seconds do
    Enum.each(1..1000, fn _ ->
      led = random_light()
      Circuits.GPIO.write_one(led, 1)
      :timer.sleep(Enum.random(1..50) + 25)
      Circuits.GPIO.write_one(led, 0)
    end)
  end

  def random_light do
    case Enum.random([1, 2, 3]) do
      1 -> @red_pin
      2 -> @yellow_pin
      3 -> @green_pin
    end
  end
end
