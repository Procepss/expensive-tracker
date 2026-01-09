# Makefile для expensive-tracker
BINARY_NAME = expensive-tracker

# Жёстко фиксируем публичные настройки Go
export GOPROXY = https://proxy.golang.org,direct
export GONOSUMDB =

# Объявляем все phony targets (команды, а не файлы)
.PHONY: default build test run tidy clean fmt vet lint help warn

# Команда по умолчанию
default: warn build

# Предупреждение о настройках
warn:
	@echo "⚠️  Внимание: Используются публичные настройки Go"
	@echo "   GOPROXY: $(GOPROXY)"
	@echo ""

# Сборка бинарного файла
build:
	@echo "🔨 Building $(BINARY_NAME)..."
	go build -o $(BINARY_NAME) ./cmd/server
	@echo "✅ Build complete: $(BINARY_NAME)"

# Запуск приложения
run:
	@echo "🚀 Running application..."
	go run ./cmd/server/main.go

# Запуск тестов
test:
	@echo "🧪 Running tests..."
	go test -v ./...

# Запуск тестов с покрытием
test-coverage:
	@echo "📊 Running tests with coverage..."
	go test -v -coverprofile=coverage.out ./...
	go tool cover -html=coverage.out -o coverage.html
	@echo "✅ Coverage report: coverage.html"

# Форматирование кода
fmt:
	@echo "✨ Formatting code..."
	go fmt ./...

# Проверка кода на ошибки
vet:
	@echo "🔍 Running go vet..."
	go vet ./...

# Линтинг (требует golangci-lint)
lint:
	@echo "🔎 Running linter..."
	@if command -v golangci-lint >/dev/null 2>&1; then \
		golangci-lint run; \
	else \
		echo "⚠️  golangci-lint not installed. Install: go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest"; \
	fi

# Синхронизация зависимостей
tidy:
	@echo "📦 Tidying dependencies..."
	go mod tidy
	@echo "✅ Dependencies updated"

# Загрузка зависимостей
deps:
	@echo "📥 Downloading dependencies..."
	go mod download

# Проверка зависимостей на обновления
deps-check:
	@echo "🔍 Checking for dependency updates..."
	go list -u -m all

# Очистка скомпилированных файлов
clean:
	@echo "🧹 Cleaning..."
	rm -f $(BINARY_NAME)
	rm -f coverage.out coverage.html
	go clean -cache
	@echo "✅ Clean complete"

# Инициализация модуля (уже не нужна, но оставлена для справки)
init:
	@echo "⚠️  Module already initialized. Use: go mod init <module-name>"

# Показать справку
help:
	@echo "Available commands:"
	@echo "  make build         - Build the application"
	@echo "  make run           - Run the application"
	@echo "  make test          - Run tests"
	@echo "  make test-coverage - Run tests with coverage report"
	@echo "  make fmt           - Format code"
	@echo "  make vet           - Run go vet"
	@echo "  make lint          - Run linter (requires golangci-lint)"
	@echo "  make tidy          - Update dependencies"
	@echo "  make deps          - Download dependencies"
	@echo "  make deps-check    - Check for dependency updates"
	@echo "  make clean         - Clean build artifacts"
	@echo "  make help          - Show this help message"