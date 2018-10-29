# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     InvoiceManager.Repo.insert!(%InvoiceManager.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will halt execution if something goes wrong.

alias InvoiceManager.InvoiceType
alias InvoiceManager.InvoiceItemUnit
alias InvoiceManager.Repo
alias InvoiceManager.User


Repo.insert %User{username: "admin", password_hash: Comeonin.Bcrypt.hashpwsalt("admin"), name: "Admin", email: "admin@invoicemanager.com"}

# invoice_types = ["Sale", "Purchase"]
# for invoice_type <- invoice_types do
# 	Repo.get_by!(InvoiceType, title: invoice_type) || Repo.insert %InvoiceType{title: invoice_type}
# end

# invoice_item_units = ~w(KG)
# for invoice_item_unit <- invoice_item_units do
# 	Repo.get_by(InvoiceItemUnit, title: invoice_item_unit) || Repo.insert %InvoiceItemUnit{title: invoice_item_unit}
# end