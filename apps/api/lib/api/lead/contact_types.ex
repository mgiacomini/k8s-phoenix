defmodule Api.Lead.ContactTypes do
  use Api, :schema_type
  alias Api.Lead.ContactResolver

  @desc "Contact queries"
  object :contact_queries do
    @desc "List all contacts of an organization"
    field :contacts, list_of(:contact) do
      resolve(&ContactResolver.all/2)
    end
  end

  @desc "Contact mutations"
  object :contact_mutations do
    @desc "Create a new Contact"
    field :create_contact, type: :contact do
      arg(:name, non_null(:string))
      arg(:email, non_null(:string))
      arg(:phone, non_null(:string))
      arg(:birthdate, :date)
      arg(:age, non_null(:integer))
      arg(:address, :address_input)

      resolve(&ContactResolver.create/2)
    end
  end

  @desc "Contact"
  object :contact do
    field(:id, :id)
    field(:name, :string)
    field(:email, :string)
    field(:phone, :string)
    field(:birthdate, :date)
    field(:age, :integer)
    field(:address, :address)
    field(:attachments, list_of(:attachment), resolve: assoc(:attachment))
  end

  @desc "Contact input"
  input_object :contact_input do
    field(:name, non_null(:string))
    field(:email, non_null(:string))
    field(:phone, non_null(:string))
    field(:birthdate, :date)
    field(:age, :integer)
    field(:address, :address_input)
  end
end
