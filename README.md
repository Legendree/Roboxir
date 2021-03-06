# Roboxir

0 dependencies, straightforward Robots.txt parser. Plug, parse, and do whatever needed with the result in a convinient `UserAgent` struct.
This parser has two functions, `crawlable/2` and `crawlable?/2`.

## Usage

`crawlable/2` usage example:

```elixir
iex> Roboxir.crawlable("some_random_agent", "https://google.com/")
%Roboxir.UserAgent{
  allowed_urls: ["/js/", "/finance", "/maps/reserve/partners", "/maps/reserve",
   "/searchhistory/", "/alerts/$", "/alerts/remove", "/alerts/manage",
   "/accounts/o8/id", "/s2/static", ..],
  delay: 0,
  disallowed_urls: ["/nonprofits/account/", "/localservices/*", "/local/tab/",
   "/local/place/rap/", "/local/place/reviews/", ..],
  name: "google",
  sitemap_urls: []
}
```

`crawlable?/2` usage example:

```elixir
iex> Roboxir.crawlable?("other_randome_agent", "https://google.com/")
true
```

## ⚠️ Warning

Using `crawlable/2` is recommended, with your own logic to itterate over disallowed_urls
and decide what you can or can't parse. `crawlable?/2` is still being **developed**.

## Config

You can skip and not pass the `url` param everytime by adding the config line to your `config.exs`

```elixir
config :roboxir, url: "https://your_website.com/"
```

## Installation

The package can be installed
by adding `roboxir` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:roboxir, "~> 0.1.1"}
  ]
end
```

The docs can
be found at [https://hexdocs.pm/roboxir](https://hexdocs.pm/roboxir).
