package ApiPulseMockups {
    doc
    /* Макеты интерфейса ApiPulse (SRS версии 0.2) в SysML v2.
       Экран «Добавить API» соответствует mockup-add-api.png,
       экран «Панель» соответствует mockup-dashboard.png. */

    private import ScalarValues::*;

    // ================================================================
    // 1. Требования, к которым относятся макеты
    // ================================================================

    requirement def <'REQ-FUNC-001'> AddApiRequirement {
        doc /* Система должна позволять пользователю добавить API, указав название,
               адрес эндпоинта и интервал проверки, а также удалить ранее добавленный API. */
    }

    requirement def <'REQ-FUNC-003'> DashboardRequirement {
        doc /* Система должна отображать на главной панели для каждого API текущий статус,
               время последней проверки и время ответа. */
    }

    requirement def <'REQ-FUNC-004'> FailureNotificationRequirement {
        doc /* Система должна уведомлять пользователя на экране и по электронной почте
               о недоступности API после трёх неуспешных проверок подряд. */
    }

    requirement reqFunc001 : AddApiRequirement;
    requirement reqFunc003 : DashboardRequirement;
    requirement reqFunc004 : FailureNotificationRequirement;

    // ================================================================
    // 2. Перечисления
    // ================================================================

    enum def ButtonKind {
        enum primary;     // основная кнопка (заливка)
        enum secondary;   // второстепенная кнопка (контур)
        enum danger;      // опасное действие (красный контур)
    }

    enum def ApiStatus {
        enum working;      // «Работает»
        enum unavailable;  // «Недоступен»
    }

    enum def AlertSeverity {
        enum error;
        enum info;
    }

    // ================================================================
    // 3. Типы элементов интерфейса
    // ================================================================

    part def UiElement {
        attribute id : String;
    }

    part def TextLabel :> UiElement {
        attribute text : String;
    }

    part def Button :> UiElement {
        attribute caption : String;
        attribute kind : ButtonKind;
        attribute opens : String[0..1];   // имя экрана, который открывается по нажатию
    }

    part def InputField :> UiElement {
        attribute title : String;
        attribute placeholder : String[0..1];
        attribute defaultValue : String[0..1];
        attribute hint : String[0..1];
        attribute errorMessage : String;  // показывается только при неверном вводе
    }

    part def NavTab :> UiElement {
        attribute caption : String;
        attribute isActive : Boolean = false;
        attribute badgeCount : Integer[0..1];   // число непрочитанных уведомлений
    }

    part def AlertBanner :> UiElement {
        attribute severity : AlertSeverity;
        attribute message : String;
        attribute closable : Boolean = true;
    }

    part def ApiRow :> UiElement {
        attribute apiName : String;
        attribute endpoint : String;
        attribute status : ApiStatus;
        attribute responseMs : Integer[0..1];   // нет значения: на экране «—»
        attribute lastCheck : String;
        attribute intervalMinutes : Integer;

        part deleteButton : Button {
            attribute :>> id = "deleteApi";
            attribute :>> caption = "Удалить";
            attribute :>> kind = ButtonKind::danger;
        }
    }

    part def Screen {
        attribute screenName : String;
        attribute mockupFile : String;
    }

    // ================================================================
    // 4. Экраны
    // ================================================================

    part apiPulseUi {

        // ---------- Экран «Добавить API» ----------
        part addApiScreen : Screen {
            attribute :>> screenName = "AddApiScreen";
            attribute :>> mockupFile = "srs/img/mockup-add-api.png";

            // Сообщения об ошибках показываются только при неверном вводе
            attribute errorsOnlyOnInvalidInput : Boolean = true;

            part brand : TextLabel {
                attribute :>> text = "ApiPulse";
            }

            part heading : TextLabel {
                attribute :>> text = "Добавить API";
            }

            part nameField : InputField {
                attribute :>> id = "apiName";
                attribute :>> title = "Название";
                attribute :>> placeholder = "Например: Платёжный API";
                attribute :>> errorMessage = "Ошибка: название не может быть пустым";
            }

            part endpointField : InputField {
                attribute :>> id = "apiEndpoint";
                attribute :>> title = "Адрес эндпоинта";
                attribute :>> placeholder = "https://example.com/health";
                attribute :>> errorMessage = "Ошибка: введите корректный адрес (http:// или https://)";
            }

            part intervalField : InputField {
                attribute :>> id = "apiInterval";
                attribute :>> title = "Интервал проверки, мин";
                attribute :>> defaultValue = "5";
                attribute :>> hint = "От 1 до 60, по умолчанию 5";
                attribute :>> errorMessage = "Ошибка: допустимо от 1 до 60 минут";
            }

            part saveButton : Button {
                attribute :>> id = "save";
                attribute :>> caption = "Сохранить";
                attribute :>> kind = ButtonKind::primary;
                attribute :>> opens = "DashboardScreen";
            }

            part cancelButton : Button {
                attribute :>> id = "cancel";
                attribute :>> caption = "Отмена";
                attribute :>> kind = ButtonKind::secondary;
                attribute :>> opens = "DashboardScreen";
            }
        }

        // ---------- Экран «Панель» ----------
        part dashboardScreen : Screen {
            attribute :>> screenName = "DashboardScreen";
            attribute :>> mockupFile = "srs/img/mockup-dashboard.png";

            part brand : TextLabel {
                attribute :>> text = "ApiPulse";
            }

            part panelTab : NavTab {
                attribute :>> id = "tabPanel";
                attribute :>> caption = "Панель";
                attribute :>> isActive = true;
            }

            part notificationsTab : NavTab {
                attribute :>> id = "tabNotifications";
                attribute :>> caption = "Уведомления";
                attribute :>> badgeCount = 1;
            }

            part heading : TextLabel {
                attribute :>> text = "Панель";
            }

            part subtitle : TextLabel {
                attribute :>> text = "Состояние внешних API. Обновлено в 14:35";
            }

            part addApiButton : Button {
                attribute :>> id = "addApi";
                attribute :>> caption = "+ Добавить API";
                attribute :>> kind = ButtonKind::primary;
                attribute :>> opens = "AddApiScreen";
            }

            part failureBanner : AlertBanner {
                attribute :>> id = "failureBanner";
                attribute :>> severity = AlertSeverity::error;
                attribute :>> message = "Платёжный API недоступен: три проверки подряд неуспешны, последняя в 14:35";
                attribute :>> closable = true;
            }

            // Таблица API
            attribute columnTitles : String[4] = ("API", "Статус", "Ответ", "Проверка");

            part paymentRow : ApiRow {
                attribute :>> apiName = "Платёжный API";
                attribute :>> endpoint = "https://pay.example.com/health";
                attribute :>> status = ApiStatus::unavailable;
                // responseMs не задан: ответа нет, на экране «—»
                attribute :>> lastCheck = "14:35";
                attribute :>> intervalMinutes = 5;
            }

            part mapsRow : ApiRow {
                attribute :>> apiName = "Карты";
                attribute :>> endpoint = "https://maps.example.com/v1/ping";
                attribute :>> status = ApiStatus::working;
                attribute :>> responseMs = 120;
                attribute :>> lastCheck = "14:35";
                attribute :>> intervalMinutes = 5;
            }

            part smsRow : ApiRow {
                attribute :>> apiName = "SMS-шлюз";
                attribute :>> endpoint = "https://sms.example.com/status";
                attribute :>> status = ApiStatus::working;
                attribute :>> responseMs = 340;
                attribute :>> lastCheck = "14:34";
                attribute :>> intervalMinutes = 2;
            }

            part ratesRow : ApiRow {
                attribute :>> apiName = "Курсы валют";
                attribute :>> endpoint = "https://rates.example.com/api/ping";
                attribute :>> status = ApiStatus::working;
                attribute :>> responseMs = 95;
                attribute :>> lastCheck = "14:35";
                attribute :>> intervalMinutes = 1;
            }

            attribute footerText : String = "Показаны 4 из 4 API";
        }
    }

    // ================================================================
    // 5. Трассировка: какой элемент макета удовлетворяет какому требованию
    // ================================================================

    satisfy reqFunc001 by apiPulseUi.addApiScreen;
    satisfy reqFunc003 by apiPulseUi.dashboardScreen;
    satisfy reqFunc004 by apiPulseUi.dashboardScreen.failureBanner;
}
