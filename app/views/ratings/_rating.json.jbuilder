json.extract! rating, :id, :score, :beer_id, :user_id, :created_at, :updated_at
json.url rating_url(rating, format: json)
