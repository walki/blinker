defmodule Blinker.Led do
  alias Circuits.GPIO

  def open(pin) do
    message("Opening #{inspect(pin)}")
    {:ok, led} = GPIO.open(pin, :output)
    led
  end

  def on(led) do
    message("On: #{inspect(led)}")
    GPIO.write(led, 1)
  end

  def off(led) do
    message("Off: #{inspect(led)}")
    GPIO.write(led, 0)
  end

  def message(message) do
    # book warns of hardware unpredictability with IO.puts
    IO.puts(message)
  end
end
