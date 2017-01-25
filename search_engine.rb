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

  puts "Lending Club 2016 Q3 Rejected Loan Database\n\n"
  puts "Enter (1) to Search, (2) to Sort, (3) to Update, and (4) to Delete"
  input_selection = gets.chomp.to_i

  case input_selection
    when 1
      search(conn, table_name)
    when 2
      sort(conn, table_name)
    when 3
      update(conn, table_name)
    when 4
      delete(conn, table_name)
    else 1
  end

  conn.close
end

def search(conn, table_name)
  field_name = value_to_search(conn, table_name)
  get_field_values(conn, table_name, field_name)
  search_value = gets.chomp
  search_database(conn, table_name, field_name, search_value)
end

def sort(conn, table_name)
  sort_field = value_to_search(conn, table_name)
  sort_order = get_sort_order(conn, table_name)
  sort_database(conn, table_name, sort_field, sort_order)
end

def update(conn, table_name)
  puts "Please enter a value from the list below in which you would like to make an update: "
  display_fields(conn, table_name)
  field_name = gets.chomp
  puts "Please enter a valid id of the record you would like to update from the list below: "
  get_field_values(conn, table_name, 'id')
  record_id = gets.chomp.to_i
  puts "Please enter the updated value: "
  updated_value = gets.chomp
  id_field_name = 'id'
  update_record(conn, table_name, field_name, id_field_name, updated_value, record_id)
end

def delete(conn, table_name)
  puts "Please enter a valid id from the list below: "
  get_field_values(conn, table_name, 'id')
  record_id = gets.chomp.to_i
  id_field_name = 'id'
  delete_record(conn, table_name, id_field_name, record_id)
end

def value_to_search(conn, table_name)
  puts "Please enter a value from the list below to search: "
  display_fields(conn, table_name)
  gets.chomp
end

def get_sort_order(conn, table_name)
  puts "Please enter ASC or DESC sort order: "
  sort_order = gets.chomp.upcase
end

def search_database(conn, table_name, field_name, search_value)
  results = conn.exec("SELECT * FROM #{table_name} WHERE #{field_name} = '#{search_value}';")
  format = "%-10s\t%-15s\t%-10s\t%-20s\t%-10s\t%-20s\t%-10s\n"
  printf(format, "ID", "Amount", "Debt to Income", "Loan Title", "Risk Score", "Employment Length", "State\n")
  results.each do |result|
    printf(format, "#{result['id']}", "$""#{result['amount']}", "#{result['debt_to_income']}", "#{result['loan_title']}", "#{result['risk_score']}", "#{result['employment_length']}", "#{result['state']}")
  end
end

def sort_database(conn, table_name, sort_field, sort_order)
  results = conn.exec("SELECT * FROM #{table_name} ORDER BY #{sort_field} #{sort_order};")
  format = "%-10s\t%-15s\t%-10s\t%-20s\t%-10s\t%-20s\t%-10s\n"
  printf(format, "ID", "Amount", "Debt to Income", "Loan Title", "Risk Score", "Employment Length", "State\n")
  results.each do |result|
    printf(format, "#{result['id']}", "$""#{result['amount']}", "#{result['debt_to_income']}", "#{result['loan_title']}", "#{result['risk_score']}", "#{result['employment_length']}", "#{result['state']}")
  end
end

def update_record(conn, table_name, field_name, id_field_name, updated_value, record_id)
  results = conn.exec("UPDATE #{table_name} SET #{field_name} = #{updated_value} WHERE #{id_field_name} = '#{record_id}';")
  search_database(conn, table_name, id_field_name, record_id)
end

def delete_record(conn, table_name, id_field_name, record_id)
  results = conn.exec("DELETE FROM #{table_name} WHERE #{id_field_name} = '#{record_id}';")
  search_database(conn, table_name, id_field_name, record_id)
end

def display_fields(conn, table_name)
  fields = conn.exec("SELECT * FROM #{table_name} WHERE id=0;")
  puts fields.fields
end

def get_field_values(conn, table_name, field_name)
  valid_inputs = conn.exec("SELECT DISTINCT #{field_name} FROM #{table_name};")
  valid_inputs.each do |valid_input|
    puts "#{valid_input[field_name]}"
  end
end

main if __FILE__ == $PROGRAM_NAME
