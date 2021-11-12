defmodule Roboxir.UserAgent do
  defstruct [:name, disallowed_urls: [], allowed_urls: [], delay: 0, sitemap_urls: []]
end
