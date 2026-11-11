package ApiPulseUseCases {
    part def User;
    part def MonitoredApi;
    part def MailService;
    part def ApiPulseSubject;

    use case def AddApi {
        doc /* REQ-FUNC-001 */
        subject app : ApiPulseSubject;
        actor user : User;
        objective { doc /* Добавить API: название, адрес эндпоинта, интервал проверки */ }
        include use case validate : ValidateApiForm;
    }
    use case def ValidateApiForm {
        doc /* Название не пустое; адрес http:// или https://; интервал целое от 1 до 60 минут */
    }
    use case def ShowFormError {
        doc /* Показать сообщение у неверно заполненного поля */
        extend use case base : AddApi;
    }
    use case def RemoveApi {
        doc /* REQ-FUNC-001: удалить ранее добавленный API */
        actor user : User;
    }
    use case def ViewDashboard {
        doc /* REQ-FUNC-003: статус, время последней проверки, время ответа */
        actor user : User;
    }
    use case def ViewNotifications {
        doc /* REQ-FUNC-004: список уведомлений о сбоях и восстановлении */
        actor user : User;
    }
    use case def CheckAvailability {
        doc /* REQ-FUNC-002: периодическая проверка эндпоинта */
        actor api : MonitoredApi;
    }
    use case def NotifyFailure {
        doc /* REQ-FUNC-004: после 3 неуспешных проверок подряд, не позднее чем через 1 минуту */
        extend use case base : CheckAvailability;
        include use case mail : SendEmail;
    }
    use case def NotifyRecovery {
        doc /* REQ-FUNC-004: после первой успешной проверки недоступного API */
        extend use case base : CheckAvailability;
        include use case mail : SendEmail;
    }
    use case def SendEmail {
        doc /* Письмо на адрес владельца API; при недоступной почте уведомление остаётся на экране */
        actor mailService : MailService;
    }
}
