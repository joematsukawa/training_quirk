view: players_liquid {
  derived_table: {
    sql:
      SELECT
        country.id,
        {% if filter_dimension._parameter_value == 'group' %}
          group_name,
        {% else %}
          country.name,
        {% endif %}
        {% if filter_measure._parameter_value == 'height' %}
          MAX(height) AS max_height
        {% else %}
          MAX(weight) AS max_weight
        {% endif %}
      FROM "TRAINING_SOCCER"."PLAYERS" AS player
      INNER JOIN "TRAINING_SOCCER"."COUNTRIES" AS country
      ON country.id = player.country_id
      WHERE {% condition filter_group %} group_name {% endcondition %}
      GROUP BY
        country.id,
        {% if filter_dimension._parameter_value == 'group' %}
          group_name
        {% else %}
          country.name
        {% endif %};;
  }

  filter: filter_group {
    label: "グループ名(フィルター)"
    type: string
    suggestions: ["A","B","C","D","E","F","G","H"]
  }

  parameter: filter_dimension {
    label: "集計軸(フィルター)"
    type: unquoted
    allowed_value: {
      label: "グループ名"
      value: "group"
    }
    allowed_value: {
      label: "国名"
      value: "country"
    }
  }

  parameter: filter_measure {
    label: "集計対象(フィルター)"
    type: unquoted
    allowed_value: {
      label: "最大身長"
      value: "height"
    }
    allowed_value: {
      label: "最大体重"
      value: "weight"
    }
  }

  dimension: id {
    label: "ID"
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: test_dimension {
    label:
      "{% if filter_dimension._parameter_value == 'group' %}
          グループ名
        {% else %}
          国名
        {% endif %}"
    type: string
    sql:
      {% if filter_dimension._parameter_value == 'group' %}
        ${TABLE}.group_name
      {% else %}
        ${TABLE}.name
      {% endif %};;
  }

  measure: test_measure {
    label:
    "{% if filter_measure._parameter_value == 'height' %}
      最大身長
    {% else %}
      最大体重
    {% endif %}"
    type: max
    sql:
      {% if filter_measure._parameter_value == 'height' %}
        ${TABLE}.max_height
      {% else %}
        ${TABLE}.max_weight
      {% endif %};;
  }
}
