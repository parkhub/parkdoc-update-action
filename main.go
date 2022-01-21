package main

import (
	"context"
	"fmt"
	"os"
	"os/exec"

	"github.com/shurcooL/githubv4"
	"golang.org/x/oauth2"
)

func main() {
	src := oauth2.StaticTokenSource(
		&oauth2.Token{AccessToken: "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"},
	)
	httpClient := oauth2.NewClient(context.Background(), src)
	client := githubv4.NewClient(httpClient)
	// Use client...
	type node struct {
		Repository struct {
			NameWithOwner githubv4.String
			Url           githubv4.URI
		} `graphql:"... on Repository"`
	}

	var q struct {
		Search struct {
			Nodes []node
		} `graphql:"search(query: \"org:parkhub topic:golib\", type:REPOSITORY, first:10)"`
	}
	err := client.Query(context.Background(), &q, nil)
	if err != nil {
		panic(err)
	}

	for _, repo := range q.Search.Nodes {
		url := fmt.Sprintf("%s.git", repo.Repository.Url.String())
		cmd2 := exec.Command("git", "clone", url, "/go/src/github.com/"+string(repo.Repository.NameWithOwner))
		cmd2.Stderr = os.Stderr
		if err := cmd2.Run(); err != nil {
			panic(err)
		}
	}
}
