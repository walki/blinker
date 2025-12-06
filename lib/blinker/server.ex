defmodule Blinker.Server do
  alias Blinker.Led

  defstruct [:led, :on, :ticker, :duration]
  use GenServer

  @pin {"gpiochip0", 26}

  def new(opts) do
    duration = opts[:duration] || 1000

    %__MODULE__{
      on: false,
      led: Led.open(opts[:pin] || @pin),
      ticker:
        opts[:ticker] ||
          fn ->
            Blinker.Server.wait(duration)
          end,
      duration: duration
    }
    |> dbg()
  end

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(opts \\ []) do
    send(self(), :blink)
    {:ok, new(opts)}
  end

  def wait(duration), do: Process.send_after(self(), :blink, duration)

  def handle_info(:blink, blinker) do
    blinker.ticker.()
    {:noreply, blink(blinker)}
  end

  defp blink(%{on: true} = blinker) do
    Led.on(blinker.led)
    %{blinker | on: false}
  end

  defp blink(%{on: false} = blinker) do
    Led.off(blinker.led)
    %{blinker | on: true}
  end
end
