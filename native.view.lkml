# If necessary, uncomment the line below to include explore_source.
# include: "ecommerce_vinay.model.lkml"

view: native {
  derived_table: {
    explore_source: order_items {
      column: country { field: users.country }
      column: state { field: users.state }
      column: count { field: users.count }
    }
  }
  dimension: country {
    description: ""
  }
  dimension: state {
    description: ""
  }
  dimension: count {
    description: ""
    type: number
  }
}
