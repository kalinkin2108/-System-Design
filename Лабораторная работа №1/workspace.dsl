workspace {
    name "Сервис поиска попутчиков"
    !identifiers hierarchical
    model {
        //Создание пользователя
        user = person "Пользователь" 
        TravelCompanionSearchService = softwareSystem "Сервис поиска попутчиков" "Организует совместные поездки" {
            //Создание сервисов
            ServiceUser = container "Сервис пользователя"
            ServiceRoute = container "Сервис маршрута"
            ServiceTrip = container "Сервис поездки"

            //Создание баз данных
            DataBaseUser = container "База данных пользователи"{
                description "Хранит данные пользователей"
                technology "PostgreSQL"
            }
            DataBaseRoute = container "База данных маршрутов"{
                description "Хранит данные маршрутов"
                technology "PostgreSQL"
            }
            DataBaseTrip = container "База данных поездок"{
                description "Хранит данные поездок"
                technology "PostgreSQL"
            }

            Website = container "Веб-сайт" {
                description "Осуществляет взаимодействие пользователя с сервисами"
                //Взаимодействие веб-сайта с сервисами
                -> ServiceUser "Передача данные о пользователе" "HTTPS"
                -> ServiceRoute "Передача данных о маршруте" "HTTPS"
                -> ServiceTrip "Передача данных о поездке" "HTTPS"
            }

            //Взаимодействие пользователя c cервисом попутчиков
            user -> TravelCompanionSearchService "Использует с целью соединения с другими людьми для совместного путешествия" "HTTPS"

            //Взаимодействие пользователя с веб сайтом
            user -> Website "Данные о пользователе"
            user -> Website "Создание маршрута"
            user -> Website "Создание поездки"

            //Взаимодействие сервисов с базами данных
            ServiceUser -> DataBaseUser "Чтение/запись данных о пользователе" "JDBC"
            ServiceUser -> DataBaseUser "Запрос в базу данных"

            ServiceRoute -> DataBaseRoute "Чтение/запись данных о маршрутах" "JDBC"
            ServiceRoute -> DataBaseRoute "Запрос в базу данных"

            ServiceTrip -> DataBaseTrip "Чтение/запись данных о поездках" "JDBC"
            ServiceTrip -> DataBaseTrip "Запрос в базу данных"
        }
    }
    
    views {

        //Установка темы
        themes default

        //Диаграмма контекста
        systemContext TravelCompanionSearchService "ContextDiagram" {
            include *
            autoLayout lr
        }


        //Диаграмма контенеров системы
        container TravelCompanionSearchService "ContainersDiagram" {
            include *
            autoLayout lr
        }

        //Диаграмма для архитектурно значимого варианта использования
        dynamic TravelCompanionSearchService "a08" "DynamicDiagram" {
            autoLayout lr
            user -> TravelCompanionSearchService.Website "Данные о пользователе"
            TravelCompanionSearchService.Website -> TravelCompanionSearchService.ServiceUser "Передача данных о пользователе"
            TravelCompanionSearchService.ServiceUser -> TravelCompanionSearchService.DataBaseUser "Запрос в базу данных"
            TravelCompanionSearchService.ServiceUser -> TravelCompanionSearchService.DataBaseUser "Чтение/запись данных о пользователе"
            
            user -> TravelCompanionSearchService.Website "Создание маршрута"
            TravelCompanionSearchService.Website -> TravelCompanionSearchService.ServiceRoute "Передача данных о маршруте"
            TravelCompanionSearchService.ServiceRoute -> TravelCompanionSearchService.DataBaseRoute "Запрос в базу данных"
            TravelCompanionSearchService.ServiceRoute -> TravelCompanionSearchService.DataBaseRoute "Чтение/запись данных о маршрутах"

            user -> TravelCompanionSearchService.Website "Создание поездки"
            TravelCompanionSearchService.Website -> TravelCompanionSearchService.ServiceTrip "Передача данных о поездке"
            TravelCompanionSearchService.ServiceTrip -> TravelCompanionSearchService.DataBaseTrip "Запрос в базу данных"
            TravelCompanionSearchService.ServiceTrip -> TravelCompanionSearchService.DataBaseTrip "Чтение/запись данных о поездках"
        }
    }
}