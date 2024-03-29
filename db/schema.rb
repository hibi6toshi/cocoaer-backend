# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_28_150426) do
  create_table "actions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_actions_on_project_id"
    t.index ["user_id"], name: "index_actions_on_user_id"
  end

  create_table "articles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "piety_target_id", null: false
    t.integer "piety_category_id", null: false
    t.integer "days"
    t.integer "cost"
    t.string "title", null: false
    t.string "body", null: false
    t.string "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["piety_category_id"], name: "index_articles_on_piety_category_id"
    t.index ["piety_target_id"], name: "index_articles_on_piety_target_id"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "commentable_type", null: false
    t.integer "commentable_id", null: false
    t.integer "user_id", null: false
    t.string "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.string "favoritable_type", null: false
    t.integer "favoritable_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["favoritable_type", "favoritable_id"], name: "index_favorites_on_favoritable"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "forums", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "piety_target_id", null: false
    t.integer "piety_category_id", null: false
    t.integer "days"
    t.integer "cost"
    t.string "title", null: false
    t.string "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["piety_category_id"], name: "index_forums_on_piety_category_id"
    t.index ["piety_target_id"], name: "index_forums_on_piety_target_id"
    t.index ["user_id"], name: "index_forums_on_user_id"
  end

  create_table "piety_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "piety_targets", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "piety_target_id", null: false
    t.integer "piety_category_id", null: false
    t.date "limit_day"
    t.integer "cost"
    t.string "title", null: false
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["piety_category_id"], name: "index_projects_on_piety_category_id"
    t.index ["piety_target_id"], name: "index_projects_on_piety_target_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_tasks_on_project_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "sub"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "introduction"
  end

  add_foreign_key "actions", "projects"
  add_foreign_key "actions", "users"
  add_foreign_key "articles", "piety_categories"
  add_foreign_key "articles", "piety_targets"
  add_foreign_key "articles", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "favorites", "users"
  add_foreign_key "forums", "piety_categories"
  add_foreign_key "forums", "piety_targets"
  add_foreign_key "forums", "users"
  add_foreign_key "projects", "piety_categories"
  add_foreign_key "projects", "piety_targets"
  add_foreign_key "projects", "users"
  add_foreign_key "tasks", "projects"
  add_foreign_key "tasks", "users"
end
