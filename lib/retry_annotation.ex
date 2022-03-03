defmodule RetryAnnotation do
  use Retry.Annotation

  @attempts 3
  @retries_every 3_000

  @retry with: constant_backoff(@retries_every) |> Stream.take(@attempts)
  def insert(audits) do
    Process.sleep(1000)
    case audits["status"] do
      "ok" ->
        Logger.info("Insert succesfull into db")
        :ok
      "error" ->
        Logger.error("Error Inserting to db")
        :error
    end
  end

end
