class RequestResponse < ActiveRecord::Migration[7.0]
  def change
    create_table :request_responses do |t|
      t.string :remote_ip, null:false
      t.string :request_method, null:false
      t.string :request_url, null:false
      t.string :response_status, null:false
      t.string :response_content_type, null:false
    end
  end
end