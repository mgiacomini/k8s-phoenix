defmodule Api.Schema do
  use Absinthe.Schema
  
  import_types(Absinthe.Type.Custom)
  import_types(Api.Core.AddressTypes)
  import_types(Api.Lead.ContactTypes)

  query do
    import_fields(:contact_queries)
  end

  mutation do
    import_fields(:contact_mutations)
  end
end
