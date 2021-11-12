# Roboxir

Roboxir is a straightforward Robots.txt parser that lets you know if the crawler with specified name is legable to crawl a website.
This parser has two functions, `crawlable/2` and `crawlable?/2`

## Usage

`crawlable/2` usage example:

```elixir
iex> Roboxir.crawlable("some_random_agent", "https://google.com/")
%Roboxir.UserAgent{
  allowed_urls: ["/js/", "/finance", "/maps/reserve/partners", "/maps/reserve",
   "/searchhistory/", "/alerts/$", "/alerts/remove", "/alerts/manage",
   "/accounts/o8/id", "/s2/static", ...],
  delay: 0,
  disallowed_urls: ["/nonprofits/account/", "/localservices/*", "/local/tab/",
   "/local/place/rap/", "/local/place/reviews/", ...],
  name: "google",
  sitemap_urls: []
}
```

`crawlable?/2` usage example:

```elixir
iex> Roboxir.crawlable?("other_randome_agent", "https://google.com/")
true
```

## TODOs

- [ ] Module docs
- [ ] Typespecs
- [ ] Tests
- [ ] Ability to configure via `Config`

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `roboxir` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:roboxir, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/roboxir](https://hexdocs.pm/roboxir).
