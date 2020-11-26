require 'test_helper'

class StructuresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @structure = structures(:one)
  end

  test "should get index" do
    get structures_url, as: :json
    assert_response :success
  end

  test "should create structure" do
    assert_difference('Structure.count') do
      post structures_url, params: { structure: { active: @structure.active, alias: @structure.alias, ancestry: @structure.ancestry, category: @structure.category, name: @structure.name, structurable_id: @structure.structurable_id, structurable_type: @structure.structurable_type, structure_id: @structure.structure_id, type: @structure.type, user_id: @structure.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show structure" do
    get structure_url(@structure), as: :json
    assert_response :success
  end

  test "should update structure" do
    patch structure_url(@structure), params: { structure: { active: @structure.active, alias: @structure.alias, ancestry: @structure.ancestry, category: @structure.category, name: @structure.name, structurable_id: @structure.structurable_id, structurable_type: @structure.structurable_type, structure_id: @structure.structure_id, type: @structure.type, user_id: @structure.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy structure" do
    assert_difference('Structure.count', -1) do
      delete structure_url(@structure), as: :json
    end

    assert_response 204
  end
end
