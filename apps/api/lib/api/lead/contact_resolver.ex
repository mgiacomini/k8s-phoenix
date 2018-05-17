defmodule Api.Lead.ContactResolver do
  alias Backoffice.Auth.Organization
  alias Backoffice.Lead

  def all(_args, %{context: %{organization: %Organization{} = organization}}) do
    {:ok, Lead.list_contacts(organization)}
  end

  def create(args, %{context: %{organization: %Organization{} = organization}}) do
    Lead.create_contact(organization, args)
  end
end
