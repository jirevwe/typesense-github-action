# Typesense GitHub action

## Introduction

This GitHub Action starts a [Typesense](https://github.com/typesense/typesense) stand-alone server on the default port `8108`.

## Usage

```yaml
name: Run tests

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        go-version: [1.16.x, 1.17.x]
        typesense-version: [0.22.0, 0.23.1]

    steps:
      - name: Git checkout
        uses: actions/checkout@v2

      - name: Use Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v1
        with:
          node-version: ${{ matrix.node-version }}

      - name: Start Typesense
        uses: jirevwe/typesense-github-action@v1.0.1
        with:
          typesense-version: ${{ matrix.typesense-version }}
          typesense-api-key: some-api-key

      - name: Set up Go
        uses: actions/setup-go@v2
        with:
          go-version: ${{ matrix.go-version }}

      - name: Cache go modules
        uses: actions/cache@v1
        with:
          path: ~/go/pkg/mod
          key: ${{ runner.os }}-go-${{ hashFiles('go.sum') }}
          restore-keys: ${{ runner.os }}-go-${{ hashFiles('go.sum') }}

      - name: Check out code
        uses: actions/checkout@v2

      - name: Get and verify dependencies
        run: go mod download && go mod verify

      - name: Build app to make sure there are zero issues
        run: go build -o convoy ./cmd

      - name: Go vet
        run: go vet ./...

      - name: Run tests
        run: go test -v ./...
```

### Using Typesense on a Custom Port

You can start the Typesense instance on a custom port using the `typesense-port` input:

```yaml
name: Run tests

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        go-version: [1.16.x, 1.17.x]
        typesense-version: [0.22.0, 0.23.1]

    steps:
      - name: Start Typesense
        uses: jirevwe/typesense-github-action@v1.0.1
        with:
          typesense-version: ${{ matrix.typesense-version }}
          typesense-port: 20863

      - name: …
```

### Using a Custom Container Name

This GitHub Action provides a Typesense Docker container. The default container name is `typesense`. It can be helpful to customize the container name. For example, when running multiple Typesense instances in parallel. You can customize the container name using the `typesense-container-name` input:

```yaml
name: Run tests

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        go-version: [1.16.x, 1.17.x]
        typesense-version: [0.22.0, 0.23.1]

    steps:
      - name: Start Typesense
        uses: jirevwe/typesense-github-action@v1.0.1
        with:
          typesense-version: ${{ matrix.typesense-version }}
          typesense-container-name: typesense-custom-name

      - name: …
```

## License

MIT
