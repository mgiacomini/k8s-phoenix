defmodule Api.ErrorView do
  use Api, :view

  def render("400.json", _assigns) do
    "Bad request"
  end

  def render("401.json", _assigns) do
    "Unauthorized access"
  end

  def render("404.json", _assigns) do
    "Page not found"
  end

  def render("500.json", _assigns) do
    "Internal server error"
  end
end
