# expensive-tracker

expensive-tracker/
├── cmd/
│   └── server/
│       └── main.go              # Точка входа приложения
│
├── internal/                    # Внутренний код (не экспортируется наружу)
│   ├── handlers/                # HTTP handlers (обработчики запросов)
│   │   └── expense_handler.go
│   ├── models/                  # Модели данных (структуры)
│   │   └── expense.go
│   ├── storage/                 # Работа с базой данных
│   │   └── repository.go
│   ├── config/                  # Конфигурация приложения
│   │   └── config.go
│   └── service/                 # Бизнес-логика (опционально, но полезно)
│       └── expense_service.go
│
├── migrations/                   # SQL миграции (если используете БД)
│   └── 001_create_expenses.sql
│
├── .env                         # Переменные окружения (не коммитить!)
├── .env.example                 # Пример переменных окружения
├── .gitignore                   # Игнорируемые файлы
├── go.mod                       # Модуль Go (зависимости)
├── go.sum                       # Checksums зависимостей
└── README.md                    # Документация