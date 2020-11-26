json.extract! organization, :id, :name, :alias, :type, :category, :income, :direct_expense, :indirect_expense, :administrative_cost, :active, :user_id, :created_at, :updated_at
json.url v1_organization_url(organization, format: :json)
