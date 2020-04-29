class StreetCafeReportByPostCodeView < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE VIEW street_cafes_report_by_post_code AS
            SELECT
              post_code,
              COUNT(*) AS total_places,
              SUM(number_of_chairs) AS total_chairs,
              ROUND((SUM(number_of_chairs) * 1.0 / (SELECT SUM(cafes.number_of_chairs)* 1.0 FROM street_cafes cafes) * 100), 2) AS chair_pct,
              (SELECT restaurant_name FROM street_cafes sc WHERE sc.post_code = street.post_code ORDER BY number_of_chairs desc LIMIT 1) AS place_with_max_chairs,
              MAX(number_of_chairs) as max_chairs
            FROM
              street_cafes street
            GROUP BY
              post_code
            ORDER BY
              post_code
        SQL
      end

      dir.down do
        execute <<-SQL
          DROP VIEW IF EXISTS street_cafes_report_by_post_code;
        SQL
      end
    end
  end
end
