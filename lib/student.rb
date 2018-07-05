require_relative "../config/environment.rb"
require "pry"

class Student
attr_accessor :name, :grade
attr_reader :id

def initialize(id = nil,name,grade)
  @name = name
  @grade = grade
  @id = id
end

def self.create_table
  sql = <<-SQL
  CREATE TABLE students (
    id INTEGER PRIMARY KEY,
    name TEXT,
    grade TEXT
  );
  SQL
  DB[:conn].execute(sql)
end

def self.drop_table
  sql = <<-SQL
  DROP TABLE students
  SQL
  DB[:conn].execute(sql)
end

def save
   sql = <<-SQL
     INSERT INTO students (name, grade)
     VALUES (?, ?)
   SQL

   DB[:conn].execute(sql, self.name, self.grade)
   @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
 end

 def self.create(name:, grade:)
  student = Student.new(name, grade)
  student.save
  student
end

def self.find_by_name(name)
    sql = "SELECT * FROM students WHERE name = ?"
    result = DB[:conn].execute(sql, name)[0]
    result[1]
end






end
