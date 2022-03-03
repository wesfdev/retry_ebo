defmodule App do
  require Logger

  @request_ok %{ "status" => "ok"}
  @request_err %{"status" => "error"}

  defp insert(audits) do
    Process.sleep(1000)
    case audits["status"] do
      "ok" ->
        Logger.info("Insert succesfull into BigQuery")
        :ok
      "error" ->
        Logger.error("Error Inserting to BigQuery")
        :error
    end
  end

  def run_ok() do
    #RetryCustom.execute(&insert/1, @request_ok, @attempts)
    #RetryConstBackoff.const_backoff(&insert/1, @request_ok)
    #RetryExpBackoff.exp_backoff(&insert/1, @request_ok)
    RetryAnnotation.insert(@request_ok)
  end

  def run_err() do
    #RetryCustom.execute(&insert/1, @request_err, @attempts)
    #RetryConstBackoff.const_backoff(&insert/1, @request_err)
    #RetryExpBackoff.exp_backoff(&insert/1, @request_err)
    RetryAnnotation.insert(@request_err)
  end

# https://hexdocs.pm/retry/Retry.html#summary
# https://github.com/safwank/ElixirRetry
# https://hexdocs.pm/gen_retry/GenRetry.html
end
