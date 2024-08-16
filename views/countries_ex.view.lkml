include: "/views/countries.view.lkml" ##継承したいファイル名

view: countries_ex {
  extends: [countries] ##継承するView名

  dimension: id {hidden:yes} ##変更したいDimensionおよびMeasureの記載

  dimension: id_plus_group { ##追加したいDimensionおよびMeasureの記載
    type: string
    sql: CONCAT(CAST(${id} AS STRING),'-',${group_name}) ;;
  }
  ## ここに記載していないcountries.viewのDimensionおよびMeasureはそのまま継承される
}
