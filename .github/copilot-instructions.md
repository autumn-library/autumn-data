## Общее

Этот проект написан на языке 1С:Предприятие 8 и выполняется в независимой реализации виртуальной машины под названием OneScript или oscript. Документация доступна на сайте https://oscript.io, исходный код движка - https://github.com/EvilBeaver/OneScript

Для управления версиями движка OneScript используется OneScript Version Manager (ovm), который уже установлен в окружении Coding Agent. Так же в окружение установлена требуемая версия oscript. Документация по ovm - https://github.com/oscript-library/ovm

Для работы с зависимостями используется пакетный менеджер OneScript Package Manager (opm), который тоже установлен в окружении. При подготовке окружения автоматически был выполнен шаг установки зависимостей текущего проекта. Они доступны в подкаталоге `oscript_modules`, расположенном в корне проекта.

Документация о продукте содержится в каталоге docs. 

## Тестирование

Для запуска тестов используется команда:

```sh
oscript_modules/bin/oneunit e --mode tree
```

Для запуска тестов с замером покрытия используется команда:

```sh
oscript_modules/bin/oneunit e \
            --mode tree \
            --genericExecution out/genericExecution.xml \
            --genericCoverage out/genericCoverage.xml \
            --cobertura out/coverage.xml 
```

Замеры покрытия доступны в подкаталоге `out`.

## Качество кода

Проект анализируется на сервере SonarQube sonar.openbsl.ru, к которому у тебя есть прямой доступ, в том числе по web-api. Используется плагин для поддержки 1С, основанный на проекте BSL Language Server. 
Документация и список диагностик BSL LS доступны на сайте https://1c-syntax.github.io/bsl-language-server
Реализация диагностик доступна по адресу https://github.com/1c-syntax/bsl-language-server

При необходимости ты можешь скачать из релизов BSL LS исполняемый файл (для Linux или -exec.jar), и запустить bsl ls в режиме analyze с выводом результатов, используя reporter json. 

В корне проекта лежит файл .bsl-language-server.json с дополнительной конфигурацией BSL LS (включая параметры диагностик).
