#Использовать tokenizer

Перем Токенайзер;

&Дуб
Процедура ПриСозданииОбъекта()

	КлючевыеСлова = МассивКлючевыхСлов();

	Спека = Новый Массив();
	Спека.Добавить(Новый СпецификацияТокенПробелы(Истина));

	Для Каждого КлючевоеСлово Из КлючевыеСлова Цикл
		Спека.Добавить(Новый ТОкенКлючевоеСлово(КлючевоеСлово, КлючевоеСлово));
	КонецЦикла;

	Спека.Добавить(Новый ТокенИдентификаторПоля(КлючевыеСлова));

	Токенайзер = Новый Токенайзер(Спека);
КонецПроцедуры

Функция МассивКлючевыхСлов()

	Массив = Новый Массив();

	Массив.Добавить("ПолучитьПервые");
	Массив.Добавить("ПолучитьОдно");
	Массив.Добавить("Получить");
	Массив.Добавить("БольшеИлиРавно");
	Массив.Добавить("Больше");
	Массив.Добавить("МеньшеИлиРавно");
	Массив.Добавить("Меньше");
	Массив.Добавить("НеРавно");
	Массив.Добавить("Равно");
	Массив.Добавить("НеВ");
	Массив.Добавить("УпорядочитьПо");
	Массив.Добавить("Возр");
	Массив.Добавить("Убыв");
	Массив.Добавить("По");
	Массив.Добавить("И");

	Возврат Новый ФиксированныйМассив(Массив);
КонецФункции

&Завязь
Функция ПолучитьТокенайзерЗапросов() Экспорт
	Возврат Токенайзер;
КонецФункции