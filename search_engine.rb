require 'pg'
require_relative 'seed_search_engine'
#database name is search_engine
#table name is reject_stats

def main
  conn = PG.connect(dbname: 'search_engine')
  table_name = 'reject_stats'
  search_options = {}

  records = conn.exec("SELECT COUNT(*) FROM #{table_name};")
  row_count = records.getvalue 0, 0
  if row_count.to_i == 0
    build_table
  end

  puts "Lending Club 2016 Q3 Rejected Loan Database"

  # search_value = 'TX'
  # field_name = 'state'
  # search_database(conn, table_name, field_name, search_value)

  # sort_field = 'amount'
  # sort_order = 'DESC'
  # sort_database(conn, table_name, sort_field, sort_order)

  # record_id = 1
  # id_field_name = 'id'
  # updated_value = 450
  # field_name = 'risk_score'
  # update_record(conn, table_name, field_name, id_field_name, updated_value, record_id)

  conn.close
end

def search_database(conn, table_name, field_name, search_value)
  results = conn.exec("SELECT * FROM #{table_name} WHERE #{field_name} = '#{search_value}';")
  results.each do |result|
    puts "$#{result['amount']} \t#{result['debt_to_income']} \t#{result['loan_title']} \t#{result['risk_score']} \t#{result['employment_length']} \t#{result['state']}"
  end
end

def sort_database(conn, table_name, sort_field, sort_order)
  results = conn.exec("SELECT * FROM #{table_name} ORDER BY #{sort_field} #{sort_order};")
  results.each do |result|
    puts "$#{result['amount']} \t#{result['debt_to_income']} \t#{result['loan_title']} \t#{result['risk_score']} \t#{result['employment_length']} \t#{result['state']}"
  end
end

def update_record(conn, table_name, field_name, id_field_name, updated_value, record_id)
  results = conn.exec("UPDATE #{table_name} SET #{field_name} = #{updated_value} WHERE #{id_field_name} = '#{record_id}';")
  search_database(conn, table_name, id_field_name, record_id)
end


main if __FILE__ == $PROGRAM_NAME
