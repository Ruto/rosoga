require 'test_helper'

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @organization = organizations(:one)
  end

  test "should get index" do
    get organizations_url, as: :json
    assert_response :success
  end

  test "should create organization" do
    assert_difference('Organization.count') do
      post organizations_url, params: { organization: { active: @organization.active, adminstrative_cost: @organization.adminstrative_cost, alias: @organization.alias, ancestry: @organization.ancestry, category: @organization.category, direct_expense: @organization.direct_expense, income: @organization.income, indirect_expense: @organization.indirect_expense, name: @organization.name, organizable_id: @organization.organizable_id, organizable_type: @organization.organizable_type, organization_id: @organization.organization_id, type: @organization.type, user_id: @organization.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show organization" do
    get organization_url(@organization), as: :json
    assert_response :success
  end

  test "should update organization" do
    patch organization_url(@organization), params: { organization: { active: @organization.active, adminstrative_cost: @organization.adminstrative_cost, alias: @organization.alias, ancestry: @organization.ancestry, category: @organization.category, direct_expense: @organization.direct_expense, income: @organization.income, indirect_expense: @organization.indirect_expense, name: @organization.name, organizable_id: @organization.organizable_id, organizable_type: @organization.organizable_type, organization_id: @organization.organization_id, type: @organization.type, user_id: @organization.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy organization" do
    assert_difference('Organization.count', -1) do
      delete organization_url(@organization), as: :json
    end

    assert_response 204
  end
end
