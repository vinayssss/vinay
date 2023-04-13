- name: State_users_count
  title: Map-USA Visualization
  model: ecommerce_vinay
  explore: order_items
  type: looker_google_map
  fields: [users.country, users.state, users.count]
  sorts: [users.count desc 0]
  limit: 500
  query_timezone: Asia/Dhaka
  hidden_fields: []
  hidden_points_if_no: []
  series_labels: {}
  show_view_names: true
  map: usa
  map_projection: ''
  quantize_colors: false
  defaults_version: 0
  series_types: {}
