# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

PietyCategory.create!(
  name: 'category1'
)

PietyTarget.create!(
  name: 'target1'
)

10.times do |i|
  Article.create!(
    user_id: 1,
    piety_target_id: 1,
    piety_category_id: 1,
    days: i,
    cost: i * 1000,
    title: "Article_#{i}",
    body: "body_#{i}"
  )
  Project.create!(
    user_id: 1,
    piety_target_id: 1,
    piety_category_id: 1,
    limit_day: Time.current.since(7.days),
    cost: i * 1000,
    title: "Project_#{i}",
    body: "body_#{i}"
  )
  Forum.create!(
    user_id: 1,
    piety_target_id: 1,
    piety_category_id: 1,
    days: i,
    cost: i * 1000,
    title: "Forum_#{i}",
    body: "body_#{i}"
  )
end
