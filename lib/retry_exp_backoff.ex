defmodule RetryExpBackoff do
  use Retry

  @expiry_time 10_000
  @cap_time 1_000

  def exp_backoff(f, args) do
    retry with: exponential_backoff() |> cap(@cap_time) |> expiry(@expiry_time), rescue_only: [TimeoutError] do
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
