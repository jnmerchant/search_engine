#database name = search_engine
#Amount Requested	Application Date	Loan Title	Risk_Score	Debt-To-Income Ratio	Zip Code	State	Employment Length	Policy Code
require 'csv'
require 'pg'

def build_table
  conn = PG.connect(dbname: 'search_engine')
  file_path= '/Users/Joe/Documents/TIY/Week3/search_engine/data/q3_reject_stats.csv'

  begin
    result = conn.exec('CREATE TABLE IF NOT EXISTS reject_stats (id serial primary key, amount numeric, application_date date, loan_title varchar,
    risk_score integer, debt_to_income numeric, zip_code varchar, state varchar, employment_length varchar);')
  rescue PG::DuplicateTable => e
    puts "That table already exists.."
  end

  seed_database(conn, file_path)
  conn.close
end

def seed_database(conn, file_path)
  CSV.foreach(file_path, {:headers => true }) do |row|
    amount = row[0].to_f
    application_date = row[1]
    loan_title = row[2]
    risk_score = row[3].to_i
    debt_to_income = /[\d+\.]/.match(row[4])
    zip_code = row[5]
    state = row[6]
    employment_length = row[7]

    conn.exec("INSERT INTO reject_stats (amount, application_date, loan_title, risk_score,
    debt_to_income, zip_code, state, employment_length)
    VALUES ('#{amount}', '#{application_date}', '#{loan_title}', '#{risk_score}',
    '#{debt_to_income}', '#{zip_code}', '#{state}', '#{employment_length}');")
  end
end
