# HbAzureInterface

Приложение для синхронизации данных между dev.azure и hubstaff по наработанному времени

### Фишки
- Приём вебхуков о событиях по work items от dev.azure
- Передача данных hubstaff
- Опрашивание hubstaff и получение наработанного времени по каждой задаче
- Передача наработанного времени в dev.azure

### Зависимости
- PostgreSQL 9.5
- Ruby 2.6.1
- Rails 5.2.3

### Предварительная настройка
Необходимо [создать приложение](https://developer.hubstaff.com/apps) для авторизации на hubstaff.
В credentials записать ключи и redirect_url от созданного приложения.

# Usage

### Создание пользователя
В приложении отключена регистрация.
Юзера можно создать выполнив сиды, либо руками в консоли
`User.create! email: "admin@mail.ru", password: "password"`

### Создание организации
При подключении огранизации необходимо указать
- azure_id - id вашей организации в dev.azure. Найдёте по url
- azure_access_token - документация по созданию [вот](https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops)
- hubstaff_id - id вашей организации в hubstaff. Найдёте по url

### Подключение огранизации к hubstaff
- На странице организации нажмите "hubstaff access edit"
- запросите код "get code"
- авторизуйтесь в hubstaff
- скопируйте полученный код
- вставьте в инпут на странице "hubstaff access edit" и сохраните

### Настройка сотрудников
- На странице организации нажмите "members: get azure list"
- Подключите каждого сотрудника к hubstaff нажав edit в его странице. Список ссылок на сотрудников из hubstaff должен появится при редактировании

### Настройка проектов
- На странице организации нажмите "projects: get azure list"
- Подключите каждый проект к hubstaff нажав edit в его странице. Список ссылок на проекты из hubstaff должен появится при редактировании

### Подключение проекта со стороны dev.azure
- Зайдите в настройки проекта на dev.azure
- Нажмите Service Hooks => добавить (+) => выберите web hooks
- Выберите действие (work item created)
- next
- Вставьте url колбека из домашней страницы приложения HbAzureInterface и нажмите finish
- Добавьте остальные хуки
