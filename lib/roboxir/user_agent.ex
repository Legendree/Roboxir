defmodule Roboxir.UserAgent do
  @type t :: %__MODULE__{
          name: String.t(),
          delay: integer(),
          disallowed_urls: [String.t()],
          allowed_urls: [String.t()],
          sitemap_urls: [String.t()]
        }
  defstruct [:name, :delay, disallowed_urls: [], allowed_urls: [], sitemap_urls: []]
end
