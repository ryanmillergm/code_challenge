class StreetCafeReportByCategory < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE VIEW street_cafes_report_by_category AS
            SELECT
              category,
              COUNT(ID) AS total_places,
              SUM(number_of_chairs) AS total_chairs
            FROM
              street_cafes
            GROUP BY
              category
            ORDER BY
              category
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
