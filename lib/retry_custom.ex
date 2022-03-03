defmodule RetryCustom do
  require Logger
  @wait_time_milisec 2000

  def execute(_, _, _retry = 0), do: :ignore

  def execute(f, args, retry) do
    if is_function(f, 1) do
      retry_op(f, args, retry)
    else
      {:error, "Invalid function"}
    end
  end

  defp retry_op(f, args, retry) do
    case f.(args) do
      :error ->
        Logger.info("Pending attempts: #{retry - 1}")
        Process.sleep(@wait_time_milisec)
        execute(f, args, retry - 1)
      :ok -> :ok
      _ -> :ignore
    end
  end
end
