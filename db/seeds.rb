# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

piety_categories = [
  { id: 1, name: "プレゼント" },
  { id: 2, name: "旅行" },
  { id: 3, name: "食事" },
  { id: 4, name: "体験" },
  { id: 5, name: "季節ごと・行事" },
  { id: 6, name: "ライフイベント" },
  { id: 7, name: "その他" }
]

piety_categories.each do |category|
  PietyCategory.find_or_create_by(category)
end

piety_targets = [
  { id: 1, name: "両親" },
  { id: 2, name: "父親" },
  { id: 3, name: "母親" },
  { id: 4, name: "祖父母" },
  { id: 5, name: "子供" },
  { id: 6, name: "親戚" },
  { id: 7, name: "パートナー・恋人" },
  { id: 8, name: "友達" },
  { id: 9, name: "仕事仲間" },
  { id: 10, name: "ペット" },
  { id: 11, name: "推し" },
  { id: 12, name: "その他" }
]

piety_targets.each do |target|
  PietyTarget.find_or_create_by(target)
end
