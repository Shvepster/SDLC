package ApiPulseStates {
    doc /* Состояния наблюдаемого API. Неуспешная проверка: нет ответа за 10 секунд или код 5xx. Коды 2xx, 3xx, 4xx считаются успешными */

    state def ApiStatusStates {
        entry action init;
        then state pending;
        state pending     { doc /* ожидает первой проверки */ }
        state working     { doc /* последняя проверка успешна */ }
        state failed1     { doc /* 1 неуспешная проверка подряд */ }
        state failed2     { doc /* 2 неуспешные проверки подряд */ }
        state unavailable { doc /* 3 и более неуспешных проверок подряд; на панели «недоступен» */ }
        state removed     { doc /* API удалён, наблюдение прекращено */ }

        transition first_ok       first pending     accept CheckOk     then working;
        transition first_fail     first pending     accept CheckFailed then failed1;
        transition stay_working   first working     accept CheckOk     then working;
        transition working_fail   first working     accept CheckFailed then failed1;
        transition failed1_fail   first failed1     accept CheckFailed then failed2;
        transition failed1_ok     first failed1     accept CheckOk     then working;
        transition failed2_fail   first failed2     accept CheckFailed then unavailable;  // уведомление о сбое
        transition failed2_ok     first failed2     accept CheckOk     then working;
        transition stay_down      first unavailable accept CheckFailed then unavailable;  // новых уведомлений нет
        transition recovered      first unavailable accept CheckOk     then working;      // уведомление о восстановлении

        transition remove_pending first pending     accept ApiRemoved then removed;
        transition remove_working first working     accept ApiRemoved then removed;
        transition remove_failed1 first failed1     accept ApiRemoved then removed;
        transition remove_failed2 first failed2     accept ApiRemoved then removed;
        transition remove_down    first unavailable accept ApiRemoved then removed;
    }
}
