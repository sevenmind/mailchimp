defmodule Mailchimp.List.MergeField do
  alias Mailchimp.HTTPClient
  alias Mailchimp.Link

  defstruct default_value: nil,
            display_order: nil,
            help_text: nil,
            list_id: nil,
            merge_id: nil,
            name: nil,
            options: %{},
            public: nil,
            required: nil,
            tag: nil,
            type: nil,
            links: []

  def new(attributes) do
    %__MODULE__{
      default_value: attributes[:default_value],
      display_order: attributes[:display_order],
      help_text: attributes[:help_text],
      list_id: attributes[:list_id],
      merge_id: attributes[:merge_id],
      name: attributes[:name],
      options: attributes[:options],
      public: attributes[:public],
      required: attributes[:required],
      tag: attributes[:tag],
      type: attributes[:type],
      links: Link.get_links_from_attributes(attributes)
    }
  end


  def delete(%__MODULE__{links: %{"delete" => %Link{href: href}}}) do
    {:ok, %HTTPoison.Response{status_code: status_code}} = HTTPClient.delete(href)

    {:ok, status_code}
  end
end
