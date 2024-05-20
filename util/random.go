package util

import (
	"math/rand"
)

var (
	letters = []rune("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
)

func RandomInt(min, max int64) int64 {
	return min + rand.Int63n(max-min)
}

func RandomString(n int) string {
	b := make([]rune, n)
	k := len(letters)

	for i := range b {
		b[i] = letters[rand.Intn(k)]
	}
	return string(b)
}
