view: view_explanation {
  derived_table: {
    sql:
      SELECT id
      FROM "TRAINING_SOCCER"."PLAYERS" ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  measure: count_id {
    type: count
  }
}
