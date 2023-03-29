# The name of this view in Looker is "Transaction Detail"
view: transaction_detail {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ecomm.transaction_detail`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created_at {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.delivered_at ;;
  }

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: items {
    hidden: yes
    sql: ${TABLE}.items ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Order ID" in Explore.

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user__age {
    type: number
    sql: ${TABLE}.user.age ;;
    group_label: "User"
    group_item_label: "Age"
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_user__age {
    type: sum
    sql: ${user__age} ;;
  }

  measure: average_user__age {
    type: average
    sql: ${user__age} ;;
  }

  dimension: user__city {
    type: string
    sql: ${TABLE}.user.city ;;
    group_label: "User"
    group_item_label: "City"
  }

  dimension: user__country {
    type: string
    sql: ${TABLE}.user.country ;;
    group_label: "User"
    group_item_label: "Country"
  }

  dimension: user__email {
    type: string
    sql: ${TABLE}.user.email ;;
    group_label: "User"
    group_item_label: "Email"
  }

  dimension: user__gender {
    type: string
    sql: ${TABLE}.user.gender ;;
    group_label: "User"
    group_item_label: "Gender"
  }

  dimension: user__location {
    type: string
    sql: ${TABLE}.user.location ;;
    group_label: "User"
    group_item_label: "Location"
  }

  dimension: user__name {
    type: string
    sql: ${TABLE}.user.name ;;
    group_label: "User"
    group_item_label: "Name"
  }

  dimension: user__state {
    type: string
    sql: ${TABLE}.user.state ;;
    group_label: "User"
    group_item_label: "State"
  }

  dimension: user__traffic_source {
    type: string
    sql: ${TABLE}.user.traffic_source ;;
    group_label: "User"
    group_item_label: "Traffic Source"
  }

  dimension_group: user__user_created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.user.user_created_at ;;
  }

  dimension: user__user_id {
    type: number
    sql: ${TABLE}.user.user_id ;;
    group_label: "User"
    group_item_label: "User ID"
  }

  dimension: user__zip {
    type: string
    sql: ${TABLE}.user.zip ;;
    group_label: "User"
    group_item_label: "Zip"
  }

  measure: count {
    type: count
    drill_fields: [user__name]
  }
}

# The name of this view in Looker is "Transaction Detail Items"
view: transaction_detail__items {
  drill_fields: [inventory_item_id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: inventory_item_id {
    primary_key: yes
    type: number
    sql: inventory_item_id ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: returned_at ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Sale Price" in Explore.

  dimension: sale_price {
    type: number
    sql: sale_price ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
  }

  # This field is hidden, which means it will not show up in Explore.
  # If you want this field to be displayed, remove "hidden: yes".

  dimension: transaction_detail__items {
    type: string
    hidden: yes
    sql: transaction_detail__items ;;
  }
}
