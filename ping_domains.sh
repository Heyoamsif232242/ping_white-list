#!/bin/bash

# Скрипт для пингования доменов и поиска 5 лучших по времени отклика
# Автор: GitHub Copilot
# Версия: 1.0

echo "Начинаем пинг-тест доменов..."
echo "=================================="

# Список доменов для тестирования
domains=(
    "sun6-22.userapi.com"
    "stats.vk-portal.net"
    "sun6-21.userapi.com"
    "sun6-20.userapi.com"
    "avatars.mds.yandex.net"
    "queuev4.vk.com"
    "sync.browser.yandex.net"
    "top-fwz1.mail.ru"
    "ad.mail.ru"
    "eh.vk.com"
    "akashi.vk-portal.net"
    "sun9-38.userapi.com"
    "st.ozone.ru"
    "ir.ozone.ru"
    "vt-1.ozone.ru"
    "io.ozone.ru"
    "xapi.ozon.ru"
    "strm-rad-23.strm.yandex.net"
    "online.sberbank.ru"
    "esa-res.online.sberbank.ru"
    "egress.yandex.net"
    "st.okcdn.ru"
    "rs.mail.ru"
    "counter.yadro.ru"
    "742231.ms.ok.ru"
    "splitter.wb.ru"
    "a.wb.ru"
    "user-geo-data.wildberries.ru"
    "banners-website.wildberries.ru"
    "chat-prod.wildberries.ru"
    "servicepipe.ru"
    "alfabank.ru"
    "statad.ru"
    "alfabank.servicecdn.ru"
    "alfabank.st"
    "ad.adriver.ru"
    "privacy-cs.mail.ru"
    "imgproxy.cdn-tinkoff.ru"
    "mddc.tinkoff.ru"
    "le.tbank.ru"
    "hrc.tbank.ru"
    "id.tbank.ru"
    "rap.skcrtxr.com"
    "eye.targetads.io"
    "px.adhigh.net"
    "nspk.ru"
    "sba.yandex.net"
    "identitystatic.mts.ru"
    "tag.a.mts.ru"
    "login.mts.ru"
    "serving.a.mts.ru"
    "cm.a.mts.ru"
    "login.vk.com"
    "api.a.mts.ru"
    "mtscdn.ru"
    "d5de4k0ri8jba7ucdbt6.apigw.yandexcloud.net"
    "moscow.megafon.ru"
    "api.mindbox.ru"
    "web-static.mindbox.ru"
    "personalization-web-stable.mindbox.ru"
    "www.t2.ru"
    "beeline.api.flocktory.com"
    "static.beeline.ru"
    "moskva.beeline.ru"
    "wcm.weborama-tech.ru"
    "1013a--ma--8935--cp199.stbid.ru"
    "msk.t2.ru"
    "s3.t2.ru"
    "get4click.ru"
    "dzen.ru"
    "yastatic.net"
    "csp.yandex.net"
    "sntr.avito.ru"
    "yabro-wbplugin.edadeal.yandex.ru"
    "cdn.uxfeedback.ru"
    "goya.rutube.ru"
    "api.expf.ru"
    "fb-cdn.premier.one"
    "www.kinopoisk.ru"
    "widgets.kinopoisk.ru"
    "payment-widget.plus.kinopoisk.ru"
    "api.events.plus.yandex.net"
    "tns-counter.ru"
    "speller.yandex.net"
    "widgets.cbonds.ru"
    "www.magnit.com"
    "magnit-ru.injector.3ebra.net"
    "jsons.injector.3ebra.net"
    "2gis.ru"
    "d-assets.2gis.ru"
    "s1.bss.2gis.com"
)

# Создаем временный файл для результатов
temp_file="/tmp/ping_results.txt"
> "$temp_file"  # очищаем файл

# Счетчик для отображения прогресса
total_domains=${#domains[@]}
current=0

echo "Всего доменов для тестирования: $total_domains"
echo "Пожалуйста, подождите..."
echo

# Функция для пинга домена
ping_domain() {
    local domain=$1
    local ping_result
    
    # Пингуем домен 3 раза и берем среднее время
    ping_result=$(ping -c 3 -W 3 "$domain" 2>/dev/null | grep "time=" | awk -F'time=' '{print $2}' | awk '{print $1}' | sort -n | head -1)
    
    if [ -n "$ping_result" ]; then
        echo "$ping_result $domain" >> "$temp_file"
        echo "✓ $domain: ${ping_result}ms"
    else
        echo "✗ $domain: недоступен"
    fi
}

# Пингуем все домены
for domain in "${domains[@]}"; do
    current=$((current + 1))
    echo -n "[$current/$total_domains] "
    ping_domain "$domain"
done

echo
echo "=================================="
echo "Анализ результатов..."

# Проверяем, есть ли успешные результаты
if [ -s "$temp_file" ]; then
    echo "🏆 ТОП-5 ЛУЧШИХ ДОМЕНОВ ПО ВРЕМЕНИ ОТКЛИКА:"
    echo "=================================="
    
    # Сортируем по времени отклика и выводим топ-5
    sort -n "$temp_file" | head -5 | nl -w2 -s'. ' | while read line; do
        ping_time=$(echo "$line" | awk '{print $2}')
        domain=$(echo "$line" | awk '{print $3}')
        echo "$line" | awk -v time="$ping_time" -v dom="$domain" '{printf "%-3s %-40s %sms\n", $1, dom, time}'
    done
    
    echo
    echo "Лучший результат:"
    best_result=$(sort -n "$temp_file" | head -1)
    best_time=$(echo "$best_result" | awk '{print $1}')
    best_domain=$(echo "$best_result" | awk '{print $2}')
    echo "🥇 $best_domain - ${best_time}ms"
else
    echo "❌ Ни один домен не ответил на пинг."
fi

# Очищаем временный файл
rm -f "$temp_file"

echo
echo "Тест завершен!"