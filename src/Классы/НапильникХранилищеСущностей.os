#Использовать extends

Перем _Поделка;
Перем _КонтейнерАннотаций;
Перем _ПостроительОпцийПоиска;
Перем _ОпределениеАннотацииХранилищеСущностей;
Перем _ОпределениеАннотацииМетодЗапроса;

Функция ОбработатьЖелудь(Желудь, ОпределениеЖелудя) Экспорт

	Конструктор = ОпределениеЖелудя.Завязь().ДанныеМетода();
	АннотацияХранилищеСущностей = РаботаСАннотациями.НайтиАннотацию(Конструктор.Аннотации, "ХранилищеСущностей");

	Если АннотацияХранилищеСущностей = Неопределено Тогда
		Возврат Желудь;
	КонецЕсли;

	ОбъектАннотации = _ОпределениеАннотацииХранилищеСущностей.СоздатьОбъектАннотации(АннотацияХранилищеСущностей);

	ИмяТипаСущности = ОбъектАннотации.ИмяТипаСущности();
	ИсточникДанныхСущности = ОбъектАннотации.ИсточникДанныхСущности();

	ХранилищеСущностей = _Поделка.НайтиЖелудь("ХранилищеСущностей" + ИсточникДанныхСущности + ИмяТипаСущности);
	ОбъектМодели = ХранилищеСущностей.ПолучитьОбъектМодели();

	МетодыЗапроса = ОпределениеЖелудя.НайтиМетодыСАннотациями("МетодЗапроса");
	// TODO: Вернуть имя поля родителя из построителя декоратора.
	ИмяПоляРодителя = "ХранилищеСущностей";

	ПостроительНаследника = Новый ПостроительНаследника(
		Желудь,
		ХранилищеСущностей,
		ОпределениеЖелудя.Методы(),
		ОпределениеЖелудя.Завязь().ДанныеМетода()
	);	
	ПостроительНаследника.УстановитьКонтейнерАннотаций(_КонтейнерАннотаций);

	Декоратор = ПостроительНаследника.СоздатьДекоратор();

	Для Каждого МетодЗапроса Из МетодыЗапроса Цикл
		АннотацияМетодЗапроса = РаботаСАннотациями.НайтиАннотацию(МетодЗапроса.Аннотации, "МетодЗапроса");
		// Проверка корректности параметров аннотации
		_ОпределениеАннотацииМетодЗапроса.СоздатьОбъектАннотации(АннотацияМетодЗапроса);

		ПараметрыПоиска = _ПостроительОпцийПоиска.РазобратьИмяМетода(МетодЗапроса.Имя, ОбъектМодели);
		СтрокаКонструктораОпций = "ОпцииПоиска = Новый ОпцииПоиска();";
		РазобранныеОпцииПоиска = ПараметрыПоиска.ОпцииПоиска;
		
		Если РазобранныеОпцииПоиска.ВыбираютсяПервые() <> Неопределено Тогда
			ИмяПараметра = МетодЗапроса.Параметры[РазобранныеОпцииПоиска.ВыбираютсяПервые() - 1].Имя;
			СтрокаКонструктораОпций = СтрокаКонструктораОпций + Символы.ПС 
				+ "ОпцииПоиска.Первые(" + ИмяПараметра + ");";
		КонецЕсли;
		Если РазобранныеОпцииПоиска.ВыбираетсяСоСмещением() <> Неопределено Тогда
			ИмяПараметра = МетодЗапроса.Параметры[РазобранныеОпцииПоиска.ВыбираетсяСоСмещением() - 1].Имя;
			СтрокаКонструктораОпций = СтрокаКонструктораОпций + Символы.ПС 
				+ "ОпцииПоиска.Смещение(" + ИмяПараметра + ");";
		КонецЕсли;
		Для Каждого Отбор Из РазобранныеОпцииПоиска.Отборы() Цикл
			ИмяПараметра = МетодЗапроса.Параметры[Отбор.Значение - 1].Имя;
			ПередаваемыйВидСравнения = "ВидСравнения." + Отбор.ВидСравнения; 
			СтрокаКонструктораОпций = СтрокаКонструктораОпций + Символы.ПС 
				+ "ОпцииПоиска.Отбор(""" + Отбор.ПутьКДанным + """, " + ПередаваемыйВидСравнения + ", " + ИмяПараметра + ");";
		КонецЦикла;
		Для Каждого Сортировка Из РазобранныеОпцииПоиска.Сортировки() Цикл
			ПередаваемоеНаправлениеСортировки = ?(
				Сортировка.НаправлениеСортировки = НаправлениеСортировки.Возр,
				"НаправлениеСортировки.Возр",
				"НаправлениеСортировки.Убыв"
			);
			СтрокаКонструктораОпций = СтрокаКонструктораОпций + Символы.ПС 
				+ "ОпцииПоиска.СортироватьПо(""" + Сортировка.ПутьКДанным + """, " + ПередаваемоеНаправлениеСортировки + ");";
		КонецЦикла;

		ТелоПерехватчика = СтрокаКонструктораОпций + "
		|Возврат " + ИмяПоляРодителя + "." + ПараметрыПоиска.РежимПоиска + "(ОпцииПоиска);";

		Перехватчик = Новый Перехватчик(МетодЗапроса.Имя)
			.ТипПерехватчика(ТипыПерехватчиковМетода.Перед)
			.Тело(ТелоПерехватчика);

		Декоратор.Перехватчик(Перехватчик);
	КонецЦикла;
	
	Возврат Декоратор.Построить();

КонецФункции

&Напильник
Процедура ПриСозданииОбъекта(&Пластилин Поделка, &Пластилин КонтейнерАннотаций, &Пластилин ПостроительОпцийПоиска) Экспорт
	_Поделка = Поделка;
	_КонтейнерАннотаций = КонтейнерАннотаций;
	_ПостроительОпцийПоиска = ПостроительОпцийПоиска;

	_ОпределениеАннотацииХранилищеСущностей = _Поделка.ПолучитьОпределениеАннотации("ХранилищеСущностей");
	_ОпределениеАннотацииМетодЗапроса = _Поделка.ПолучитьОпределениеАннотации("МетодЗапроса");
КонецПроцедуры