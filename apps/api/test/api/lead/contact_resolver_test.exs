defmodule Api.Lead.ContactResolverTest do
  use Api.ConnCase
  alias Backoffice.{Auth, Lead, Documents}

  describe "#all/2" do
    @contact %{
      name: "mauricio",
      email: "mauricio.giacomini@ateliware.com.br",
      phone: "41 995 000 315",
      birthdate: ~D[1994-09-15]
    }
    @attachment %{
      content_type: "some content_type",
      filename: "some filename",
      path: "some path"
    }
    @organization %{
      name: "fake",
      subdomain: "fake"
    }

    setup do
      {:ok, org} = Auth.create_organization(@organization)

      [context: org]
    end

    test "returns a list of contacts for authenticated organization", %{context: org} do
      assert {:ok, %{data: %{"contacts" => _}}} =
               """
               {
                 contacts {
                   id
                   name
                   email
                   birthdate
                 }
               }
               """
               |> Absinthe.run(Api.Schema, context: %{organization: org})
    end

    test "returns a list of contacts with attachments for authenticated organization", %{
      context: org
    } do
      assert {:ok, contact} = org |> Lead.create_contact(@contact)
      assert {:ok, attachment} = org |> Documents.create_attachment(@attachment)

      contact_attachment = %{
        contact_id: contact.id,
        attachment_id: attachment.id
      }

      assert {:ok, _contact_attachment} =
               org |> Lead.create_contact_attachment(contact_attachment)

      assert {:ok, %{data: %{"contacts" => [%{"attachments" => _}]}}} =
               """
               {
                 contacts {
                   id
                   name
                   email
                   birthdate
                   attachments {
                     id
                     filename
                     path
                     content_type
                   }
                 }
               }
               """
               |> Absinthe.run(Api.Schema, context: %{organization: org})
    end
  end

  describe "#create/2" do
    test "returns errors messages when missing inputs for authenticated organization" do
      {:ok, org} = Auth.create_organization(%{name: "fake", subdomain: "fake"})

      assert {:ok, %{errors: _}} =
               """
               mutation CreateContact {
                 create_contact() {
                   id
                   name
                 }
               }
               """
               |> Absinthe.run(Api.Schema, context: %{organization: org})
    end

    test "insert new contact for authenticated organization" do
      {:ok, org} = Auth.create_organization(%{name: "fake", subdomain: "fake"})

      assert {:ok, %{data: %{"create_contact" => _}}} =
               """
               mutation CreateContact {
                 create_contact(
                   address: {
                     street: "test",
                     city: "Curitiba",
                     state: "PR"
                   },
                   name: "mauricio",
                   email: "mauricio.giacomini@ateliware.com.br",
                   phone: "41 995 000 315",
                   birthdate: "1994-09-15",
                   age: 23) {
                   id
                   name
                   address {
                     street
                     city
                   }
                 }
               }
               """
               |> Absinthe.run(Api.Schema, context: %{organization: org})
    end
  end
end
