#! /bin/sh

# -----------------------------------------------------------------------------#
# Завдання 3 (5 балів).
# Підрахувати сумарну кількість стрічок у файлах *.h, *.cpp, *.java,
# що рекурсивно містяться у поточній директорії.

# -----------------------------------------------------------------------------#

readonly SUCCESS_EXIT_STATUS=0
readonly FISRT_LINE_NUMBER=1

FILES_WITH_H_EXTENTION=`find *.h`
FIND_FILE_WITH_H_EXTENTION_COMMAND_EXIT_STATUS=`echo $?`

if [ $FIND_FILE_WITH_H_EXTENTION_COMMAND_EXIT_STATUS -eq $SUCCESS_EXIT_STATUS ]; then
  AMOUNT_OF_FILES_WITH_H_EXTENTION=`echo "$FILES_WITH_H_EXTENTION" | wc -l`

  echo "List of found files with '.h' extention:"
  echo "$FILES_WITH_H_EXTENTION"

  LINE_NUMBER=$FISRT_LINE_NUMBER

  SUM_OF_LINES=0

  while [ "$LINE_NUMBER" -le "$AMOUNT_OF_FILES_WITH_H_EXTENTION" ]
  do
    FILE=`echo "$FILES_WITH_H_EXTENTION" | sed -n "${LINE_NUMBER}p"`

    AMOUNT_OF_LINES_IN_FILE=`wc -l < $FILE`

    SUM_OF_LINES=`expr "$SUM_OF_LINES" + "$AMOUNT_OF_LINES_IN_FILE"`

    LINE_NUMBER=`expr "$LINE_NUMBER" + 1`
  done

  echo "Total amount of lines equals $SUM_OF_LINES."
else
  echo "No files with '.h' extention found."
fi


FILES_WITH_CPP_EXTENTION=`find *.cpp 2>/dev/null`
FIND_FILE_WITH_CPP_EXTENTION_COMMAND_EXIT_STATUS=`echo $?`

if [ $FIND_FILE_WITH_CPP_EXTENTION_COMMAND_EXIT_STATUS -eq $SUCCESS_EXIT_STATUS ]; then
  AMOUNT_OF_FILES_WITH_CPP_EXTENTION=`echo "$FILES_WITH_CPP_EXTENTION" | wc -l`

  echo "List of found files with '.cpp' extention:"
  echo "$FILES_WITH_CPP_EXTENTION"

  LINE_NUMBER=$FISRT_LINE_NUMBER

  SUM_OF_LINES=0

  while [ "$LINE_NUMBER" -le "$AMOUNT_OF_FILES_WITH_CPP_EXTENTION" ]
  do
    FILE=`echo "$FILES_WITH_CPP_EXTENTION" | sed -n "${LINE_NUMBER}p"`

    AMOUNT_OF_LINES_IN_FILE=`wc -l < $FILE`

    SUM_OF_LINES=`expr "$SUM_OF_LINES" + "$AMOUNT_OF_LINES_IN_FILE"`

    LINE_NUMBER=`expr "$LINE_NUMBER" + 1`
  done

  echo "Total amount of lines equals $SUM_OF_LINES."
else
  echo "No files with '.cpp' extention found."
fi


FILES_WITH_JAVA_EXTENTION=`find *.java 2>/dev/null`
FIND_FILE_WITH_JAVA_EXTENTION_COMMAND_EXIT_STATUS=`echo $?`

if [ $FIND_FILE_WITH_JAVA_EXTENTION_COMMAND_EXIT_STATUS -eq $SUCCESS_EXIT_STATUS ]; then
  AMOUNT_OF_FILES_WITH_JAVA_EXTENTION=`echo "$FILES_WITH_JAVA_EXTENTION" | wc -l`

  echo "List of found files with '.java' extention:"
  echo "$FILES_WITH_JAVA_EXTENTION"

  LINE_NUMBER=$FISRT_LINE_NUMBER

  SUM_OF_LINES=0

  while [ "$LINE_NUMBER" -le "$AMOUNT_OF_FILES_WITH_JAVA_EXTENTION" ]
  do
    FILE=`echo "$FILES_WITH_JAVA_EXTENTION" | sed -n "${LINE_NUMBER}p"`

    AMOUNT_OF_LINES_IN_FILE=`wc -l < $FILE`

    SUM_OF_LINES=`expr "$SUM_OF_LINES" + "$AMOUNT_OF_LINES_IN_FILE"`

    LINE_NUMBER=`expr "$LINE_NUMBER" + 1`
  done

  echo "Total amount of lines equals $SUM_OF_LINES."
else
  echo "No files with '.java' extention found."
fi
