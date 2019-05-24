### Создание пользователя
В приложении отключена регистрация.
Юзера можно создать выполнив сиды, либо руками в консоли
```
User.create! email: "admin@mail.ru", password: "password"
```

### Создание организации
- azure id - id вашей организации в [dev.azure](https://dev.azure.com). Найдёте по url
- azure access token - документация по созданию [вот](https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops)
- hubstaff id - id вашей организации в [hubstaff](https://hubstaff.com/). Найдёте по url
- auto create azure hooks on project create - создавать ли автоматичесик вебхуки в азуре при создании проекта
- auto create hubstaff project on project create - создавать ли автоматически проект в хабстаф при создании проекта

### Подключение огранизации к hubstaff
- На странице организации нажмите "hubstaff access edit"
- Запросите код "get code"
- Авторизуйтесь в hubstaff
- Скопируйте полученный код
- Вставьте код в инпут на странице "hubstaff access edit" и сохраните

### Настройка сотрудников
- На странице организации нажмите "members: get azure list"
- Подключите каждого сотрудника к hubstaff нажав edit в его странице. Список ссылок на сотрудников из hubstaff должен появится при редактировании

### Настройка проектов
- Когда вы создаёте проект в dev.azure, на странице организации нажмите "projects: get azure list", проект будет добавлен в список
- Если у организации включены опции "создавать проект в хабстаф автоматически" и "создавать хуки автоматически", то редактировать проект не нужно
- Иначе:
- Подключите каждый проект к hubstaff нажав edit в его странице. Список ссылок на проекты из hubstaff должен появится при редактировании
- Либо создайте проект в HB нажав на странице проекта "create in HB"
- Создайте хуки нажав "create azure hooks" на странице проекта, если хуки не были созданы
