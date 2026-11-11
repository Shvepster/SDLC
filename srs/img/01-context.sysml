package ApiPulseContext {
    doc /* Контекст приложения ApiPulse: веб-приложение мониторинга доступности внешних API (Java). Соответствует REQ-FUNC-001…004 */

    part def User;                  // человек, который добавляет API и смотрит статусы
    part def MonitoredApi;          // внешний API, адрес которого указал пользователь
    part def MailService;           // почтовый сервис для писем-уведомлений

    part def WebUi               { doc /* панель статусов, форма добавления API, список уведомлений */ }
    part def MonitorService      { doc /* периодические проверки, определение статуса API */ }
    part def NotificationService { doc /* уведомления на экране и по почте */ }
    part def DataStore           { doc /* список API, результаты проверок, уведомления */ }

    part def Presentation {
        part webUi : WebUi;
    }
    part def Services {
        part monitorService      : MonitorService;
        part notificationService : NotificationService;
        part dataStore           : DataStore;
    }
    part def ApiPulseApp {
        part presentation : Presentation;
        part services     : Services;
    }

    interface def HttpsProbe {
        doc /* HTTPS GET на адрес эндпоинта; неуспешная проверка: нет ответа за 10 секунд или код 5xx */
    }
    interface def MailSend {
        doc /* отправка письма о сбое или восстановлении на адрес владельца API */
    }

    part system       : ApiPulseApp;
    part user         : User;
    part monitoredApi : MonitoredApi;
    part mailService  : MailService;

    connection useApp       connect user to system.presentation.webUi;
    connection manageApis   connect system.presentation.webUi to system.services.monitorService;
    connection apiEvents    connect system.services.monitorService to system.services.notificationService;
    connection notifyScreen connect system.services.notificationService to system.presentation.webUi;
    connection keepData     connect system.services.monitorService to system.services.dataStore;
    connection probe : HttpsProbe connect system.services.monitorService to monitoredApi;
    connection mail  : MailSend   connect system.services.notificationService to mailService;
}
