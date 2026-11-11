package ApiPulseArchitecture {
    doc /* Слои приложения. Зависимости направлены так: Presentation → Application ← Infrastructure */

    package Application {
        part def MonitoredApi {
            attribute name : String;
            attribute endpointUrl : String;
            attribute intervalMinutes : Integer;
            attribute accessKey : String[0..1];
        }
        part def CheckResult {
            attribute checkedAt : String;
            attribute success : Boolean;
            attribute responseMs : Integer[0..1];
        }
        part def Notification {
            attribute kind : String;        // сбой или восстановление
            attribute createdAt : String;
            attribute isRead : Boolean;
        }
        part def ApiStatus {
            attribute consecutiveFailures : Integer;
            attribute isUnavailable : Boolean;
        }

        port def IApiProber     { doc /* CheckResult Probe(MonitoredApi api): запрос с таймаутом 10 секунд */ }
        port def IApiRepository { doc /* сохранить и загрузить API, результаты проверок, уведомления */ }
        port def IMailSender    { doc /* отправить письмо владельцу API */ }

        part def ApiManagementService    { doc /* добавить и удалить API, проверить введённые данные */ }
        part def MonitorService          { doc /* выполнить проверку и передать результат в StatusEvaluator */ }
        part def StatusEvaluator         { doc /* счётчик неудач подряд, переход в недоступен и обратно */ }
        part def NotificationService     { doc /* создать уведомление о сбое и восстановлении, отправить письмо */ }
    }

    package Infrastructure {
        part def HttpApiProber         { doc /* реализует IApiProber */ }
        part def DatabaseApiRepository { doc /* реализует IApiRepository */ }
        part def SmtpMailSender        { doc /* реализует IMailSender */ }
        part def CheckScheduler        { doc /* таймер: запускает проверку каждого API по его интервалу (допуск ±10 с) */ }
    }

    package Presentation {
        part def DashboardView     { doc /* панель статусов, обновление без перезагрузки не позднее 30 секунд */ }
        part def AddApiView        { doc /* форма добавления API и сообщения об ошибках ввода */ }
        part def NotificationsView { doc /* список уведомлений и баннер о сбое */ }
    }
}
