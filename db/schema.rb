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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 1) do

  create_table "author_terms", :force => true do |t|
    t.integer  "author_id"
    t.integer  "term_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "author_terms", ["author_id"], :name => "index_author_terms_on_author_id"
  add_index "author_terms", ["term_id"], :name => "index_author_terms_on_term_id"

  create_table "authors", :force => true do |t|
    t.string   "first"
    t.string   "last"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_chapters", :force => true do |t|
    t.integer  "book_id",    :null => false
    t.integer  "chapter_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_chapters", ["book_id"], :name => "index_mettings_on_mark_id"
  add_index "book_chapters", ["chapter_id"], :name => "index_mettings_on_meta_id"

  create_table "item_authors", :force => true do |t|
    t.integer  "item_id",    :null => false
    t.integer  "author_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "items", :force => true do |t|
    t.string   "type",                          :null => false
    t.integer  "flag_chapters",                 :null => false
    t.integer  "flag_sections",                 :null => false
    t.integer  "page_first"
    t.integer  "page_last"
    t.integer  "year"
    t.string   "title"
    t.string   "isbn"
    t.integer  "book_id"
    t.integer  "journal_id",    :default => -1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "journal_articles", :force => true do |t|
    t.integer  "jounral_id", :null => false
    t.integer  "article_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "journal_articles", ["article_id"], :name => "index_mettings_on_meta_id"
  add_index "journal_articles", ["jounral_id"], :name => "index_mettings_on_mark_id"

  create_table "list_items", :force => true do |t|
    t.integer  "list_id",    :null => false
    t.integer  "item_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "lists", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mark_tags", :force => true do |t|
    t.integer  "mark_id",    :null => false
    t.integer  "tag_id",     :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mark_tags", ["mark_id"], :name => "index_mettings_on_mark_id"
  add_index "mark_tags", ["tag_id"], :name => "index_mettings_on_meta_id"
  add_index "mark_tags", ["user_id"], :name => "index_mettings_on_user_id"

  create_table "mark_terms", :force => true do |t|
    t.integer  "mark_id",    :null => false
    t.integer  "term_id",    :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mark_terms", ["mark_id"], :name => "index_mettings_on_mark_id"
  add_index "mark_terms", ["term_id"], :name => "index_mettings_on_meta_id"
  add_index "mark_terms", ["user_id"], :name => "index_mettings_on_user_id"

  create_table "marks", :force => true do |t|
    t.string   "type",       :null => false
    t.integer  "item_id",    :null => false
    t.integer  "user_id",    :null => false
    t.integer  "page"
    t.integer  "section"
    t.string   "area"
    t.text     "quote"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_authors", :force => true do |t|
    t.integer  "search_id"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "search_authors", ["author_id"], :name => "index_search_authors_on_author_id"
  add_index "search_authors", ["search_id"], :name => "index_search_authors_on_search_id"

  create_table "search_tags", :force => true do |t|
    t.integer  "search_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "search_tags", ["search_id"], :name => "index_search_tags_on_search_id"
  add_index "search_tags", ["tag_id"], :name => "index_search_tags_on_tag_id"

  create_table "search_terms", :force => true do |t|
    t.integer  "search_id"
    t.integer  "term_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "search_terms", ["search_id"], :name => "index_search_terms_on_search_id"
  add_index "search_terms", ["term_id"], :name => "index_search_terms_on_term_id"

  create_table "search_types", :force => true do |t|
    t.integer  "search_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "search_types", ["search_id"], :name => "index_search_types_on_search_id"

  create_table "searches", :force => true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.string   "name"
    t.string   "keywords"
    t.boolean  "f_single_item_search", :default => false
    t.boolean  "f_quoted_text_only",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_authors", :force => true do |t|
    t.integer  "user_id"
    t.integer  "author_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_authors", ["author_id"], :name => "index_user_tags_on_tag_id"
  add_index "user_authors", ["user_id"], :name => "index_user_tags_on_user_id"

  create_table "user_items", :force => true do |t|
    t.integer  "user_id"
    t.integer  "item_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_items", ["item_id"], :name => "index_user_tags_on_tag_id"
  add_index "user_items", ["user_id"], :name => "index_user_tags_on_user_id"

  create_table "user_tags", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_tags", ["tag_id"], :name => "index_user_tags_on_tag_id"
  add_index "user_tags", ["user_id"], :name => "index_user_tags_on_user_id"

  create_table "user_terms", :force => true do |t|
    t.integer  "user_id"
    t.integer  "term_id"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_terms", ["author_id"], :name => "index_user_terms_on_author_id"
  add_index "user_terms", ["term_id"], :name => "index_user_terms_on_term_id"
  add_index "user_terms", ["user_id"], :name => "index_user_terms_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "first"
    t.string   "last"
    t.string   "email"
    t.string   "password_digest",                    :null => false
    t.boolean  "is_admin",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
