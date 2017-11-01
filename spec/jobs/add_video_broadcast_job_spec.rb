require "rails_helper"

describe AddVideoBroadcastJob, type: :job do
  let(:video) { create(:video) }
  let(:user) { create(:user) }
  let(:target) { "room_#{video.room.id}" }

  describe "#perform_later" do
    subject { AddVideoBroadcastJob.perform_later(video) }

    it { expect { subject }.to have_enqueued_job(AddVideoBroadcastJob).with(video) }
  end

  describe "perform_enqueued_jobs" do
    subject { perform_enqueued_jobs { AddVideoBroadcastJob.perform_later(video) } }

    it "expect to have broadcast" do
      expect { subject }.to have_broadcasted_to(target).exactly(2).with { |data|
                              expect(data).to have_json_path("data_type")
                            }
    end
  end
end