# 🌐 Ping Domains Tester

Bash-скрипт для тестирования времени отклика доменов и определения TOP-5 лучших по скорости подключения.

## 🚀 Быстрый запуск (одна команда)

### Для Ubuntu/Linux серверов:

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/ping_white/main/install.sh | bash
```

### Альтернативный способ с wget:

```bash
wget -qO- https://raw.githubusercontent.com/YOUR_USERNAME/ping_white/main/install.sh | bash
```

## 📋 Что делает скрипт

- ✅ Пингует 85+ популярных российских доменов
- ⚡ Определяет TOP-5 самых быстрых доменов
- 📊 Показывает время отклика в миллисекундах
- 🎯 Обрабатывает недоступные домены
- 📈 Отображает прогресс выполнения

## 🎯 Тестируемые домены

Скрипт тестирует домены популярных российских сервисов:
- **VK**: vk.com, userapi.com, vk-portal.net
- **Яндекс**: yandex.net, yastatic.net, kinopoisk.ru
- **Mail.ru**: mail.ru, ok.ru
- **Банки**: sberbank.ru, alfabank.ru, tbank.ru
- **Маркетплейсы**: ozon.ru, wildberries.ru, avito.ru
- **Мобильные операторы**: mts.ru, megafon.ru, beeline.ru
- И многие другие...

## 📦 Ручная установка

1. **Клонировать репозиторий:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/ping_white.git
   cd ping_white
   ```

2. **Сделать скрипт исполняемым:**
   ```bash
   chmod +x ping_domains.sh
   ```

3. **Запустить тестирование:**
   ```bash
   ./ping_domains.sh
   ```

## 📊 Пример вывода

```
Начинаем пинг-тест доменов...
==================================
Всего доменов для тестирования: 85
Пожалуйста, подождите...

[1/85] ✓ login.vk.com: 12.345ms
[2/85] ✓ yandex.net: 15.678ms
[3/85] ✗ example-unavailable.com: недоступен
...

🏆 ТОП-5 ЛУЧШИХ ДОМЕНОВ ПО ВРЕМЕНИ ОТКЛИКА:
==================================
1.  login.vk.com                     12.345ms
2.  yastatic.net                     14.123ms
3.  mail.ru                          16.789ms
4.  sberbank.ru                      18.456ms
5.  wildberries.ru                   20.234ms

Лучший результат:
🥇 login.vk.com - 12.345ms

Тест завершен!
```

## 🛠 Системные требования

- **ОС**: Ubuntu/Debian/CentOS/RHEL/любой Linux с bash
- **Утилиты**: ping, awk, sort (обычно предустановлены)
- **Интернет**: стабильное подключение для тестирования

## ⚙️ Настройки

Скрипт можно легко модифицировать:

- **Изменить количество пингов**: в строке `ping -c 3` замените `3` на нужное число
- **Изменить таймаут**: в параметре `-W 3` замените `3` на нужное время в секундах
- **Добавить/удалить домены**: отредактируйте массив `domains` в скрипте

## 🔧 Использование на серверах

### Для системных администраторов:

```bash
# Запуск на удаленном сервере через SSH
ssh user@server "curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/ping_white/main/install.sh | bash"

# Запуск на нескольких серверах
for server in server1 server2 server3; do
    echo "=== Testing $server ==="
    ssh user@$server "curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/ping_white/main/install.sh | bash"
done
```

### Добавление в cron для регулярных проверок:

```bash
# Добавить в crontab (каждый час)
0 * * * * curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/ping_white/main/install.sh | bash > /var/log/ping_test.log 2>&1
```

## 📝 Логи

Все результаты выводятся в stdout. Для сохранения в файл:

```bash
./ping_domains.sh > ping_results_$(date +%Y%m%d_%H%M%S).log 2>&1
```

## 🤝 Вклад в проект

1. Форкните репозиторий
2. Создайте ветку для новой функциональности
3. Внесите изменения
4. Отправьте pull request

## 📄 Лицензия

MIT License - используйте свободно в любых целях.

## 🆘 Поддержка

Если у вас есть вопросы или предложения:
- Создайте Issue в репозитории
- Отправьте Pull Request с улучшениями

---
**Создано с ❤️ для тестирования сетевой производительности российских сервисов**