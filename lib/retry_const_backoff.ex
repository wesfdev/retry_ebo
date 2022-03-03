defmodule RetryConstBackoff do
  use Retry

  @attempts 3
  @retries_every 3_000

  def const_backoff(f, args) do
    retry with: constant_backoff(@retries_every) |> Stream.take(@attempts) do
      if is_function(f, 1) do
        f.(args)
      else
        {:error, "Invalid function"}
      end

    after
      result -> {result, "db success"}
    else
      error -> {error, "db errors"}
    end
  end

end
