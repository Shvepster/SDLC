# ApiPulse — проектная документация

## Автор и дисциплина

- **Автор:** Ледник Ярослав Юрьевич, группа 450501
- **Дисциплина:** Жизненный цикл разработки программного обеспечения
- **Проект:** веб-приложение ApiPulse — мониторинг доступности внешних API и контроль расходов на них

## Документы

| Документ | Версия | Файл |
|----------|--------|------|
| Спецификация требований (SRS) | 0.7 | [`srs/project-srs.md`](srs/project-srs.md) |
| Карточки требований | — | [`srs/project-req.md`](srs/project-req.md) |
| Описание дизайна (SDD) | 0.5 | [`sdd/project-sdd.md`](sdd/project-sdd.md) |
| План реализации по итерациям | v1–v3 | [`docs/plans/plan.md`](docs/plans/plan.md) |
| Переписка с Заказчиком | 2 раунда | [`docs/correspondence/correspondence.md`](docs/correspondence/correspondence.md) |
| Переписка (краткая версия для скриншотов) | — | [`docs/correspondence/correspondence-chat.md`](docs/correspondence/correspondence-chat.md) |
| Список лицензий | — | [`docs/licenses.md`](docs/licenses.md) |

## Протоколы архитектурных решений (ADR)

Формат: MADR по шаблону `adr/adr-template.md`. Язык: русский.

| ID | Решение | Статус | Затрагиваемые требования |
|----|---------|--------|--------------------------|
| [ADR-0001](adr/ADR-0001-spring-boot-java-backend.md) | Spring Boot 3 на Java 21 для серверной части | accepted | REQ-FUNC-010, REQ-FUNC-002, REQ-FUNC-004, REQ-SEC-001 … 004 |
| [ADR-0002](adr/ADR-0002-postgresql-database.md) | PostgreSQL 16 как основная база данных | accepted | REQ-FUNC-008, REQ-SEC-001, REQ-PERF-002 |
| [ADR-0003](adr/ADR-0003-db-backed-check-scheduler.md) | Планирование проверок по полю `next_check_at` в БД | accepted | REQ-FUNC-002, REQ-FUNC-003, REQ-FUNC-004, REQ-PERF-002, REQ-REL-001 |
| [ADR-0004](adr/ADR-0004-dashboard-polling.md) | Обновление панели опросом раз в 10 секунд | accepted | REQ-FUNC-003, REQ-PERF-001 |
| [ADR-0005](adr/ADR-0005-jwt-in-httponly-cookie.md) | JWT в cookie с флагами HttpOnly, Secure, SameSite=Strict | accepted | REQ-SEC-001, REQ-SEC-002, REQ-SEC-004 |
| [ADR-0006](adr/ADR-0006-aes-gcm-access-key-encryption.md) | Шифрование ключей доступа AES-256-GCM | accepted | REQ-SEC-003, REQ-FUNC-001 |
| [ADR-0007](adr/ADR-0007-in-process-caffeine-cache.md) | Кэширование панели и журнала библиотекой Caffeine | accepted (реализация в 1.1) | REQ-PERF-001, REQ-FUNC-003, REQ-FUNC-009 |
| [ADR-0008](adr/ADR-0008-ssrf-url-validation.md) | Поэтапная защита от SSRF | accepted (этап 2 — в 1.1) | REQ-SEC-005, REQ-FUNC-001, REQ-FUNC-002 |
| [ADR-0009](adr/ADR-0009-telegram-notifications.md) | Уведомления в Telegram через Bot API с long polling | accepted | REQ-FUNC-011, REQ-FUNC-004, REQ-REL-001 |

## Итог согласования

- Срок версии 1.0 — 10 недель (23.11.2026 — 29.01.2027), не сдвигается.
- Объём версии 1.0 — 249 ч, версии 1.1 — 33 ч.
- Команда: исполнитель + junior-разработчик с итерации 2 (коэффициент 1,6, ревью 16 %).
- Стоимость версии 1.0 — 7 722 BYN с резервом 10 % (без junior — 8 217 BYN).
- Все 21 требование SRS прослеживаются до представлений SDD, ADR и тест-кейсов (SDD, приложение A).
