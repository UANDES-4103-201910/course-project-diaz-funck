# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_02_142757) do

  create_table "blacklist_records", force: :cascade do |t|
    t.integer "user_id"
    t.integer "blacklist_status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blacklist_status_id"], name: "index_blacklist_records_on_blacklist_status_id"
    t.index ["user_id"], name: "index_blacklist_records_on_user_id"
  end

  create_table "blacklist_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.integer "parent_comment_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "dumpstered_posts", force: :cascade do |t|
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_dumpstered_posts_on_post_id"
  end

  create_table "file_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "geofences", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "geofences_locations", force: :cascade do |t|
    t.integer "geofence_id"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geofence_id"], name: "index_geofences_locations_on_geofence_id"
    t.index ["location_id"], name: "index_geofences_locations_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "country"
    t.string "region"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_attachments", force: :cascade do |t|
    t.integer "post_id"
    t.integer "file_type_id"
    t.string "file_path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["file_type_id"], name: "index_post_attachments_on_file_type_id"
    t.index ["post_id"], name: "index_post_attachments_on_post_id"
  end

  create_table "post_follows", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_follows_on_post_id"
    t.index ["user_id"], name: "index_post_follows_on_user_id"
  end

  create_table "post_reports", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_reports_on_post_id"
    t.index ["user_id"], name: "index_post_reports_on_user_id"
  end

  create_table "post_shares", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_post_shares_on_post_id"
    t.index ["user_id"], name: "index_post_shares_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "location_id"
    t.string "title"
    t.text "description"
    t.string "gps_coordinate"
    t.boolean "resolved"
    t.boolean "open"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_posts_on_location_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_profiles", force: :cascade do |t|
    t.integer "user_id"
    t.string "picture_path"
    t.text "biography"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "role_id"
    t.integer "location_id"
    t.integer "geofence_id"
    t.string "username"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["geofence_id"], name: "index_users_on_geofence_id"
    t.index ["location_id"], name: "index_users_on_location_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  create_table "votes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.boolean "up"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_votes_on_post_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

end
