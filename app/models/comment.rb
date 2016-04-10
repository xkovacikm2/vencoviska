class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :area

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :content, presence: true

  ### My database methods

  #same as save but unsafe and lame
  def my_save
    return false unless self.valid?
    sql = "
      INSERT INTO comments (content, user_id, area_id, created_at, updated_at)
      VALUES ('#{self.content}', '#{self.user_id}', '#{self.area_id}', localtimestamp, localtimestamp);
    "
    ActiveRecord::Base.connection.execute sql
  end
end
