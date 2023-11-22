#!/bin/bash

echo "Скрипт - проверка изменяемости файла. Автор скрипта - студент гр.730-1 Чикин Дмитрий Андреевич. Скрипт позволяет определить наличие файла в папке и проверить изменялся ли он начиная с указанной пользователям даты"
while true; do
	echo "Текущий каталог: $(pwd)"
	read -p "Введите имя файла: " filename
	
	while [ ! -f "$filename" ]; do
		echo "Файл не существует."
		echo "Файл \"$filename\" не существует." >> errors.txt
		read -p "Попробуйте еще раз, введите имя файла: " filename
	done
	
	read -p "Введите дату в формате 'гггг-мм-дд': " input_date
	
	while ! date -d "$input_date" &>/dev/null; do
		echo "Неккоректный формат даты."
		echo "Неккоректный формат даты: $input_date" >> errors.txt
		read -p "Введите дату в формате 'гггг-мм-дд': " input_date
	done
	
	file_modified=$(stat -c %Y "$filename")
	input_epouch=$(date -d "$input_date" +%s)
	
	if [ $file_modified -gt $input_epouch ]; then
		echo "Содержимое файла \"$filename\" было изменено после указанной даты."
		exit 120
	else
		echo "Содержимое файла \"$filename\" осталось без изменений после указанной даты."
	fi
	
	read -p "Хотите продолжить (yes/no)? " choice
	case "$choice" in
		[Nn]* )
			exit 0
			;;
	esac
done
	
