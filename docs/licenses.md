# Лицензии библиотек ApiPulse

Все библиотеки распространяются по лицензиям с открытым исходным кодом и допускают коммерческое использование. Список проверяется при сборке (SYS-NFR-011).

| Библиотека | Назначение | Лицензия |
|------------|------------|----------|
| Spring Boot 3 (Web, Security, Data JPA, Mail, Validation) | серверный каркас | Apache License 2.0 |
| PostgreSQL JDBC Driver | драйвер базы данных | BSD 2-Clause |
| PostgreSQL 16 | СУБД (контейнер) | PostgreSQL License |
| Flyway Community | миграции схемы | Apache License 2.0 |
| jjwt | подпись и проверка JWT | Apache License 2.0 |
| Jakarta Mail | отправка почты | EPL 2.0 / GPL 2.0 с исключением |
| HikariCP | пул соединений | Apache License 2.0 |
| Caffeine (версия 1.1) | кэш в памяти | Apache License 2.0 |
| Apache HttpClient 5 (версия 1.1) | HTTP-клиент с собственным `DnsResolver` | Apache License 2.0 |
| JUnit 5 | модульные тесты | EPL 2.0 |
| Mockito | тестовые заглушки | MIT |
| Testcontainers | интеграционные тесты с PostgreSQL | MIT |
| ArchUnit | архитектурный тест | Apache License 2.0 |
| Mermaid | диаграммы в документации | MIT |

Ограничения: LGPL-библиотеки в версии 1.0 не используются, чтобы не усложнять поставку; при добавлении новой зависимости лицензия проверяется до включения в сборку (ADR-0001, SYS-NFR-011).
