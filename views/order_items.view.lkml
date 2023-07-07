# The name of this view in Looker is "Order Items"
view: order_items {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ecomm.order_items`
    ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,day_of_month
    ]
    sql: ${TABLE}.created_at ;;
  }
  # dimension: day {
  #   type: number
  #   sql:  EXTRACT(DAY FROM ${created_date}(now());;
  # }

  # dimension_group: created1 {
  #   type: time
  #   timeframes: [time, date]
  #   sql: CONVERT_TIMEZONE(${TABLE}.created_at,'UTC','IST') ;;
  # }

  dimension: time {
    type: string
    sql: CURRENT_TIMESTAMP();;
  }

  dimension: time1 {
    type: date_time
    sql: CURRENT_TIMESTAMP();;
  }

  dimension: time2 {
    type: date_time
    sql: EXTRACT(day FROM ${created_date} [
Asia - Kolkata]);;
  }


  dimension_group: current_date {
    type: time
    label: "Current date"
    group_label: "Non-Jira Related"
    timeframes: [
      time,date
    ]
    sql: CURRENT_DATETIME();;
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

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Inventory Item ID" in Explore.

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

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
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
    value_format_name: usd
    drill_fields: [id,total_sale_price]
  }

  measure: average_sale_price {
    type: average
    sql: ${sale_price} ;;
    value_format_name: usd
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

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }
  measure: user_count_organic{
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [detail*]
    filters: {
      field: users.traffic_source
      value: "Organic"
    }
  }
  measure: usersidcount {
    type: count_distinct
    sql: ${user_id} ;;
    drill_fields: [detail*]
  }

  # measure: emojiss {
  #   type: sum
  #   sql: ${sale_price} ;;
  #   html:
  #   {% if {order_item.emojiss} < 200  %}
  #   <a>&#128308</a>
  # { % else %}
  #   {% if (order_item.emojiss) < 100  %}
  # <a>&#128993</a>
  # {%else%}
  # <a>&#128994</a>
  #   {%endif%};;
  #   }

  # {% if value > 100 %}
  #     <span style="color:darkgreen;">{{ rendered_value }}</span>
  #   {% elsif value > 50 %}
  #     <span style="color:goldenrod;">{{ rendered_value }}</span>
  #   {% else %}
  #     <span style="color:darkred;">{{ rendered_value }}</span>
  #   {% endif %} ;;

measure: count_order_id {
  type: count_distinct
  sql: ${order_id} ;;
  drill_fields: [detail*]
}

measure: orderperuser {
  type: number
  sql: ${count_order_id}/${usersidcount} ;;
  value_format_name: decimal_1
}
  measure: percentage_organic_users {
    type: number
    sql: ${user_count_organic}/${count} ;;
    value_format_name: percent_4
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }
  measure: largest_order {
    type: max
    sql: ${sale_price};;
    value_format_name: usd_0
  }
  measure: last_updated_date {

    type: date

    sql: MAX(${created_date}) ;;

    convert_tz: no

  }
  measure: new {
    type: number
    sql: (${count_order_id}-${total_sale_price})/${average_sale_price} ;;
  }
  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.last_name,
      users.id,
      users.first_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }
}
