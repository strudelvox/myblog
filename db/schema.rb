# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151102181728) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "recording_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "c_text"
  end

  add_index "comments", ["recording_id"], name: "index_comments_on_recording_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "recordings", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "rec_header"
    t.text     "rec_teaser"
    t.text     "rec_text"
    t.integer  "rec_approved", default: 0, null: false
    t.integer  "rec_hits",     default: 0, null: false
  end

  add_index "recordings", ["created_at"], name: "index_recordings_on_created_at", using: :btree
  add_index "recordings", ["rec_approved"], name: "index_recordings_on_rec_approved", using: :btree
  add_index "recordings", ["rec_hits"], name: "index_recordings_on_rec_hits", using: :btree
  add_index "recordings", ["user_id"], name: "index_recordings_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             default: "", null: false
    t.string   "last_name",              default: "", null: false
    t.integer  "role",                   default: 0,  null: false
    t.integer  "status",                 default: 1,  null: false
    t.integer  "notifications",          default: 0,  null: false
    t.text     "message",                default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "webimages", force: :cascade do |t|
    t.integer  "recording_id"
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "wi_type"
    t.string   "wi_name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "webimages", ["comment_id"], name: "index_webimages_on_comment_id", using: :btree
  add_index "webimages", ["recording_id"], name: "index_webimages_on_recording_id", using: :btree
  add_index "webimages", ["user_id"], name: "index_webimages_on_user_id", using: :btree

end
