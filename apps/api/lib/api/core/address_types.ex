defmodule Api.Core.AddressTypes do
  use Api, :schema_type

  @desc "Address"
  object :address do
    field(:id, non_null(:id))
    field(:street, :string)
    field(:number, :string)
    field(:district, :string)
    field(:city, :string)
    field(:state, :string)
    field(:country, :string)
    field(:zipcode, :string)
  end

  @desc "Address input"
  input_object :address_input do
    field(:street, :string)
    field(:number, :string)
    field(:district, :string)
    field(:city, :string)
    field(:state, :string)
    field(:country, :string)
    field(:zipcode, :string)
  end
end
