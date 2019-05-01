class Chat < ApplicationRecord
  belongs_to :room
  belongs_to :user, optional: true
  after_create_commit do
    # TODO: このselfって何をさすんだろう。。。
    AddMessageBroadcastJob.perform_later(self)
  end

  scope :latest_by, ->(num) do
    order(id: :desc).limit(num)
  end

  scope :before, ->(cursor) do
    where("id < ?", cursor)
  end
end
