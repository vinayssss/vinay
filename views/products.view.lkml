# The name of this view in Looker is "Products"
view: products {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `ecomm.products`
    ;;
  drill_fields: [id]
  # This primary key is the unique key for this table in the underlying database.
  # You need to define a primary key in a view in order to join to other views.

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Brand" in Explore.

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
    #drill_fields: [brand,total_cost]
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }
dimension: combination {
  type: string
  sql: concat(${brand},",",${category},",",${department}) ;;
  suggestions: ["Men","Women","Allegra K"]
}
  parameter: 13_distinct_value {
    type: string
    allowed_value: {
      label: "Allegra K"
      value: "Allegra K"
    }
    allowed_value: {
      label: "Levi's"
      value: "Levi's"
    }
    allowed_value: {
      label: "Speedo"
      value: "Speedo"
    }
    allowed_value: {
      label: "Dockers"
      value: "Dockers"
    }
    allowed_value: {
      label: "Hanes"
      value: "Hanes"
    }
    allowed_value: {
      label: "Jeans"
      value: "Jeans"
    }
    allowed_value: {
      label: "Allegra K"
      value: "Allegra K"
    }
    allowed_value: {
      label: "Underwear"
      value: "Underwear"
    }
    allowed_value: {
      label: "Carhartt"
      value: "Carhartt"
    }
    allowed_value: {
      label: "Allegra K"
      value: "Allegra K"
    }
    allowed_value: {
      label: "Levi's"
      value: "Levi's"
    }
    allowed_value: {
      label: "Active"
      value: "Active"
    }
    allowed_value: {
      label: "Hagger"
      value: "Hagger"
    }
    allowed_value: {
      label: "Men"
      value: "Men"
    }
    allowed_value: {
      label: "Women"
      value: "Women"
    }
  }
dimension: combision{
  label_from_parameter: 13_distinct_value
  sql:
  {% if (${13_distinct_value} == "Allegra K") %}
  ${combination}
  {% elsif (${13_distinct_value} == "Levi's") %}
  ${combination}
  {% else %}
  NULL
  {% endif %} ;;
}


  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }
dimension: costs {
  type: number
  sql: if(${cost}>5,null,${cost}) ;;





}
  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_cost {
    type: sum
    sql: ${cost} ;;
    value_format_name: usd
    drill_fields: [brand,total_cost]
    # link: {
    #   label: "Explore Top 20 Results"
    #   url: "{{ link }}&limit=20"
    # }
  }

  measure: average_cost {
    type: average
    sql: ${cost} ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: distribution_center_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.distribution_center_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price;;
  }
  dimension: retail {
    type: number
    sql: if(${retail_price}>45,null,${retail_price}) ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }
dimension: brandsss {
  type: string
  sql: ${TABLE}.brand ;;
  html: {{value|raw}};;
}
  measure: count {
    type: count
    drill_fields: [detail*]

  }
  measure: name_list {
    type: list
    list_field: brand
  }
  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      distribution_centers.name,
      distribution_centers.id,
      atom_inventory_items.count,
      discounts.count,
      inventory_items.count
    ]
  }
}
