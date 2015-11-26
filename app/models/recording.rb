require 'elasticsearch/model'

class Recording < ActiveRecord::Base

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :webimages, dependent: :destroy

  accepts_nested_attributes_for :webimages

  scope :approved, -> { where("rec_approved>0") }
  scope :teased, -> {	where("rec_hits>0 and rec_approved>0").order(rec_hits: :desc).limit(5) }

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name 'recordings_idx'

  Kaminari::Hooks.init
  Elasticsearch::Model::Response::Response.__send__ :include, Elasticsearch::Model::Response::Pagination::Kaminari

  settings index: { number_of_shards: 1, number_of_replicas: 0 } do
    mapping do
      indexes :rec_header
      indexes :rec_teaser, analyzer: 'snowball'
      indexes :rec_text, analyzer: 'snowball'
      indexes :created_at
      indexes :rec_approved
      indexes :user do
        indexes :first_name
        indexes :last_name
      end
    end
  end
  
  def self.search(query, options={})
    __elasticsearch__.search(
    {
      query: {
        multi_match: {
          query: query,
          fields: ['rec_header','rec_teaser','rec_text','created_at','first_name','last_name']
        }
      },
      highlight: {
        pre_tags: ['<em>'],
        post_tags: ['</em>'],
        fields: {
          rec_header: {},
          rec_teaser: {},
          first_name: {},
          last_name: {}
        }
      },
      filter: { term: { :rec_approved => 1 } },
      sort: { created_at: { :order => 'desc' } }
    }).page(options[:page]).per(options[:per])
  end

  def as_indexed_json(options={})
    self.as_json({
      only: [ :rec_header, :rec_teaser, :rec_text, :rec_approved, :created_at ],
      include: {
        user: { only: [:first_name, :last_name] }
      }
    })
  end

  after_commit on: [:create] do
    __elasticsearch__.index_document if self.rec_approved == 1
  end

  after_commit on: [:update] do
    __elasticsearch__.update_document if self.rec_approved == 1
  end

  after_commit on: [:destroy] do
    __elasticsearch__.delete_documentß
  end

end






