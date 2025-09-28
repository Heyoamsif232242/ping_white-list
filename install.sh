#!/bin/bash

# Скрипт автоматической установки и запуска ping_domains.sh
# Версия: 1.0
# Автор: GitHub Copilot

set -e  # Завершить выполнение при ошибке

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# URL репозитория (замените YOUR_USERNAME на ваше имя пользователя GitHub)
REPO_URL="https://raw.githubusercontent.com/YOUR_USERNAME/ping_white/main"
SCRIPT_NAME="ping_domains.sh"
TEMP_DIR="/tmp/ping_white_$$"

echo -e "${BLUE}🌐 Ping Domains Tester - Автоматическая установка${NC}"
echo -e "${BLUE}=================================================${NC}"
echo

# Функция для очистки временных файлов
cleanup() {
    if [ -d "$TEMP_DIR" ]; then
        rm -rf "$TEMP_DIR"
    fi
}

# Установить обработчик сигналов для очистки
trap cleanup EXIT

# Проверка наличия необходимых утилит
check_dependencies() {
    local missing_deps=()
    
    for cmd in ping curl awk sort; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            missing_deps+=("$cmd")
        fi
    done
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo -e "${RED}❌ Ошибка: Отсутствуют необходимые утилиты: ${missing_deps[*]}${NC}"
        echo -e "${YELLOW}Установите их с помощью:${NC}"
        echo "  Ubuntu/Debian: sudo apt update && sudo apt install -y iputils-ping curl gawk coreutils"
        echo "  CentOS/RHEL: sudo yum install -y iputils curl gawk coreutils"
        echo "  или: sudo dnf install -y iputils curl gawk coreutils"
        exit 1
    fi
}

# Создание временной директории
create_temp_dir() {
    mkdir -p "$TEMP_DIR"
    cd "$TEMP_DIR"
}

# Скачивание скрипта
download_script() {
    echo -e "${YELLOW}📥 Скачивание скрипта...${NC}"
    
    if ! curl -fsSL "$REPO_URL/$SCRIPT_NAME" -o "$SCRIPT_NAME"; then
        echo -e "${RED}❌ Ошибка: Не удалось скачать скрипт с $REPO_URL/$SCRIPT_NAME${NC}"
        echo -e "${YELLOW}Убедитесь, что:${NC}"
        echo "  1. У вас есть доступ в интернет"
        echo "  2. Репозиторий существует и доступен"
        echo "  3. В URL правильно указано имя пользователя GitHub"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Скрипт успешно скачан${NC}"
}

# Проверка целостности скрипта
verify_script() {
    if [ ! -s "$SCRIPT_NAME" ]; then
        echo -e "${RED}❌ Ошибка: Скачанный файл пуст или поврежден${NC}"
        exit 1
    fi
    
    if ! head -1 "$SCRIPT_NAME" | grep -q "#!/bin/bash"; then
        echo -e "${RED}❌ Ошибка: Скачанный файл не является bash-скриптом${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Скрипт прошел проверку целостности${NC}"
}

# Установка прав доступа
set_permissions() {
    chmod +x "$SCRIPT_NAME"
    echo -e "${GREEN}✅ Права доступа установлены${NC}"
}

# Запуск скрипта
run_script() {
    echo
    echo -e "${BLUE}🚀 Запуск тестирования доменов...${NC}"
    echo -e "${BLUE}=====================================${NC}"
    echo
    
    ./"$SCRIPT_NAME"
}

# Показать информацию о системе
show_system_info() {
    echo -e "${BLUE}💻 Информация о системе:${NC}"
    echo "  ОС: $(uname -s) $(uname -r)"
    echo "  Архитектура: $(uname -m)"
    echo "  Hostname: $(hostname)"
    echo "  Дата: $(date)"
    echo
}

# Основная функция
main() {
    show_system_info
    
    echo -e "${YELLOW}🔍 Проверка зависимостей...${NC}"
    check_dependencies
    echo -e "${GREEN}✅ Все зависимости найдены${NC}"
    echo
    
    create_temp_dir
    download_script
    verify_script
    set_permissions
    run_script
}

# Обработка ошибок
error_handler() {
    local line_no=$1
    echo -e "${RED}❌ Ошибка на строке $line_no${NC}"
    echo -e "${YELLOW}Если проблема повторяется, обратитесь к документации:${NC}"
    echo "https://github.com/YOUR_USERNAME/ping_white"
    exit 1
}

trap 'error_handler $LINENO' ERR

# Проверка, что скрипт запущен не от root (опционально)
if [ "$EUID" -eq 0 ]; then
    echo -e "${YELLOW}⚠️  Предупреждение: Скрипт запущен от root${NC}"
    echo -e "${YELLOW}Это не обязательно, но может потребоваться в некоторых системах${NC}"
    echo
fi

# Запуск основной функции
main

echo
echo -e "${GREEN}🎉 Тестирование завершено успешно!${NC}"
echo -e "${BLUE}Спасибо за использование Ping Domains Tester${NC}"