json.extract! item, :id, :vendor_id, :item_status_id, :tag_status_id, :building_id, :serial_number, :item_name, :created_at, :updated_at
json.url item_url(item, format: :json)