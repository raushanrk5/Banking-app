package main

import (
	"log"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

type SimpleUser struct {
	ID       string
	Username string
	Email    string
}

func fetchSampleUsers(db *gorm.DB) {
	var users []SimpleUser
	if err := db.Table("users").Select("id", "username", "email").Limit(5).Scan(&users).Error; err != nil {
		log.Printf("❌ Failed to fetch users: %v", err)
		return
	}
	if len(users) == 0 {
		log.Println("⚠️ No users found in DB.")
		return
	}
	log.Println("📦 Sample users from DB:")
	for _, u := range users {
		log.Printf("- %s | %s | %s", u.ID, u.Username, u.Email)
	}
}

func main() {
	// Step 1: Setup DB
	// dsn := fmt.Sprintf(
	// 	"host=%s user=%s password=%s dbname=%s port=%s sslmode=disable",
	// 	os.Getenv("DB_HOST"),
	// 	os.Getenv("DB_USER"),
	// 	os.Getenv("DB_PASSWORD"),
	// 	os.Getenv("DB_NAME"),
	// 	os.Getenv("DB_PORT"),
	// )

	dsn := "host=localhost user=banking_user password=password dbname=banking_app port=5432 sslmode=disable"

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatalf("failed to connect to DB: %v", err)
	}

	fetchSampleUsers(db)

}
