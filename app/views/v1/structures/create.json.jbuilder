json.data do
  json.structure do
    json.call(
      @structure,
      :id,
      :name,
      :alias,
      :type,
      :ancestry,
      :structure_id,
      :category,
      :active,
      :user_id

    )
  end
end
