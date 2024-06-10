connection: "snowflake_traning"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: training_quirk_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: training_quirk_default_datagroup

explore: countries {}

explore: countries_ex {}

explore: goals {
  join: pairings {
    type: left_outer
    sql_on: ${goals.pairing_id} = ${pairings.id} ;;
    relationship: many_to_one
  }

  join: players {
    type: left_outer
    sql_on: ${goals.player_id} = ${players.id} ;;
    relationship: many_to_one
  }
}

explore: pairings {}

explore: players {}
