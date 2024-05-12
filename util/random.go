package util

import (
	"math/rand"
	"time"
)

var (
	letters = []rune("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
	r       = rand.New(rand.NewSource(time.Now().UnixNano()))
)

func RandomInt(min, max int64) int64 {
	return min + r.Int63n(max-min)
}

func RandomString(n int) string {
	b := make([]rune, n)
	k := len(letters)

	for i := range b {
		b[i] = letters[r.Intn(k)]
	}
	return string(b)
}
