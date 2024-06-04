view: view_explanation {
  sql_table_name: "TRAINING_SOCCER"."PLAYERS" ;;

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  measure: count_id {
    type: count
  }
}
