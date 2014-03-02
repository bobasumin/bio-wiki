class Wiki < ActiveRecord::Base
  attr_accessible :user_ids, :sections_attributes, :biocard_attributes, :user_id, :title
  belongs_to :user
  has_many :sections
  has_many :votes, dependent: :destroy, through: :sections
  has_one :biocard
  accepts_nested_attributes_for :sections, :reject_if => lambda { |a| a[:name].blank? }, allow_destroy: true
  accepts_nested_attributes_for :biocard

  has_many :collaborations
  has_many :users, through: :collaborations
  before_save :set_title

  default_scope order('created_at DESC')

  validates :user, presence: true

  def set_title
    self.title = self.user.name
  end

  include Tire::Model::Search
  include Tire::Model::Callbacks

  def self.search(params)
    tire.search(page: params[:page], per_page: 5) do
      query { string params[:query], default_operator: "AND" } if params[:query].present?
      sort { by :created_at, "desc" } if params[:query].blank?
    end
  end

  def to_indexed_json
    to_json(methods: [:location, :user_name])
  end

  def location
    biocard.location
  end

  def user_name
    user.name
  end
end
