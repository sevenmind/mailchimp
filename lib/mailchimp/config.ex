defmodule Mailchimp.Config do
  @moduledoc """
  Mailchimp Config Module.
  """

  @default_api_version "3.0"
  @default_api_endpoint "api.mailchimp.com"

  @doc """
  Returns configured API Key.

  ### Examples

      iex> Application.put_env(:mailchimp, :api_key, "your apikey-us12")
      iex> Mailchimp.Config.api_key!()
      "your apikey-us12"

  """
  @spec api_key!() :: String.t() | no_return
  def api_key!, do: Application.fetch_env!(:mailchimp, :api_key)

  @doc """
  Returns configured API Version.

  ### Examples

      iex> Application.put_env(:mailchimp, :api_version, "1.0")
      iex> Mailchimp.Config.api_version()
      "1.0"

      iex> Application.delete_env(:mailchimp, :api_version)
      iex> Mailchimp.Config.api_version()
      "3.0"

  """
  @spec api_version() :: String.t()
  def api_version, do: Application.get_env(:mailchimp, :api_version, @default_api_version)

  @doc """
  Returns configured API endpoint.

  ### Examples

      iex> Application.put_env(:mailchimp, :api_endpoint, "api.mc.local")
      iex> Mailchimp.Config.api_endpoint()
      "api.mc.local"

      iex> Application.delete_env(:mailchimp, :api_endpoint)
      iex> Mailchimp.Config.api_endpoint()
      "api.mailchimp.com"

  """
  @spec api_endpoint() :: String.t()
  def api_endpoint, do: Application.get_env(:mailchimp, :api_endpoint, @default_api_endpoint)

  @doc """
  Returns configured API Version.

  ### Examples

      iex> Application.put_env(:mailchimp, :api_key, "your apikey-us12")
      iex> Mailchimp.Config.shard!()
      "us12"

  """
  @spec shard!() :: String.t() | no_return
  def shard! do
    api_key!()
    |> String.split("-", parts: 2)
    |> Enum.at(1)
  end

  @doc """
  Returns configured API Version.

  ### Examples

      iex> Application.put_env(:mailchimp, :api_key, "your apikey-us12")
      iex> Application.delete_env(:mailchimp, :api_version)
      iex> Mailchimp.Config.root_endpoint!()
      "https://us12.api.mailchimp.com/3.0/"

  """
  @spec root_endpoint!() :: String.t() | no_return
  def root_endpoint! do
    case Application.get_env(:mailchimp, :root_endpoint) do
      nil ->
        "https://#{shard!()}.#{api_endpoint()}/#{api_version()}/"

      endpoint ->
        "#{endpoint}/"
    end
  end

  @spec http_options() :: keyword()
  def http_options do
    Application.get_env(:mailchimp, :http_options, [])
  end
end
