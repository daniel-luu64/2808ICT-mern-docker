// Initialize employees database
print("Starting database initialization...");

db = db.getSiblingDB('employees');

db.records.insertMany([
  {
    name: "Tin Doan",
    position: "Ho Chi Minh",
    level: "Intern"
  },
  {
    name: "Kiem Tran",
    position: "Can Tho", 
    level: "Junior"
  },
  {
    name: "Kim Thoa Le",
    position: "Ha Noi",
    level: "Intern"
  },
  {
    name: "John Smith",
    position: "Software Engineer",
    level: "Senior"
  }
]);

db.records.createIndex({ "name": 1 });
db.records.createIndex({ "position": 1 });
db.records.createIndex({ "level": 1 });

print("=== Database Initialization Complete ===");
print("Database: employees");
print("Collection: records");
print("Documents inserted:", db.records.count());
print("==========================================");
