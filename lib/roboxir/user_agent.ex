defmodule Roboxir.UserAgent do
  defstruct [:name, :delay, disallowed_urls: [], allowed_urls: [], sitemap_urls: []]
end
