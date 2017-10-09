#! /bin/sh

# -----------------------------------------------------------------------------#
# Завдання 1 (10 балів). Створити shell скріпт для керування todo записками.
# Реалізувати команди
#
#    todo.sh add "Купити молоко"    | V |
#    todo.sh add "Запрограмувати"
#
#    todo.sh list                   | V |
#    1. Купити молоко
#    2. Запрограмувати
#
#    todo.sh done 1                 | V |
#    todo.sh pri 1 high             | X |

# -----------------------------------------------------------------------------#
# TODO one day for the sake of interest
# 1. The same functionality using shell functions
# 2. Add configurable logger
# 3. The same functionality using bash
# 4. Test for portability

# -----------------------------------------------------------------------------#

readonly STORAGE_FILE='storage.txt'

readonly SCRIPT_MINIMAL_AMOUNT_OF_ARGUMENTS=1

readonly ADD_ACTION='add'
readonly LIST_ACTION='list'
readonly PRIORITY_ACTION='pri'
readonly DONE_ACTION='done'
readonly UNKNOW_ACTION="*"

readonly FIRST_TASK_NUMBER=1


# Checks if STORAGE_FILE exists. Creates new one if not.
if [ ! -e $STORAGE_FILE ]; then
  # echo 'Storage file created.' # Logger
  touch $STORAGE_FILE
fi


SCRIPT_AMOUNT_OF_ARGUMENTS=$#

# Checks if at least one argument passed to script.
if [ $SCRIPT_AMOUNT_OF_ARGUMENTS -ge $SCRIPT_MINIMAL_AMOUNT_OF_ARGUMENTS ]; then
  # echo 'At least one argument passed to script.' # Logger

  ACTION=$1

  case $ACTION in
    $ADD_ACTION)
      TASK_DESCRIPTION=$2

      if [ "$TASK_DESCRIPTION" ]; then
        REDUNDANT_ARGUMENT=$3

        # If REDUNDANT_ARGUMENT passed to script, then add command has invalid format.
        # For example:
        #   todo.sh add Запрограмувати    # valid
        #   todo.sh add 'Запрограмувати'  # valid
        #   todo.sh add "Запрограмувати"  # valid
        # but
        #   todo.sh add Купити молоко     # not valid
        #   todo.sh add 'Купити молоко'   # valid
        #   todo.sh add "Купити молоко"   # valid
        if [ $REDUNDANT_ARGUMENT ]; then
          echo 'Error: Task description should be one word or multiple words enclosed by quotes.'
          exit 1
        else
          # TASK_NUMBER='' empty string

          AMOUNT_OF_LINES_IN_STORAGE_FILE=`wc -l < $STORAGE_FILE`

          # Determines task number.
          # If STORAGE_FILE has zero lines,
          # it means that task with first number is going to be created.
          if [ $AMOUNT_OF_LINES_IN_STORAGE_FILE -eq 0 ]; then
            TASK_NUMBER=$FIRST_TASK_NUMBER
          else
            LAST_LINE_NUMBER_IN_STORAGE_FILE=$AMOUNT_OF_LINES_IN_STORAGE_FILE
            LAST_LINE_IN_STORAGE_FILE=`cat $STORAGE_FILE | sed -n "${LAST_LINE_NUMBER_IN_STORAGE_FILE}p"`
            LAST_TASK_NUMBER=`echo $LAST_LINE_IN_STORAGE_FILE | sed -n 's/\..*//p'`

            while [ ! $LAST_TASK_NUMBER ]
            do
              LAST_LINE_NUMBER_IN_STORAGE_FILE=`expr $LAST_LINE_NUMBER_IN_STORAGE_FILE - 1`
              LAST_LINE_IN_STORAGE_FILE=`cat $STORAGE_FILE | sed -n "${LAST_LINE_NUMBER_IN_STORAGE_FILE}p"`
              LAST_TASK_NUMBER=`echo $LAST_LINE_IN_STORAGE_FILE | sed -n 's/\..*//p'`
            done

            TASK_NUMBER=`expr $LAST_TASK_NUMBER + 1`
          fi

          echo "$TASK_NUMBER. \"$TASK_DESCRIPTION\"" >> $STORAGE_FILE

          echo 'New task has been successfully created.'
        fi
      else
        echo 'Error: Task description is empty.'
        exit 1
      fi

      ;;
    $LIST_ACTION)
      # Example:
      #   todo.sh list

      AMOUNT_OF_LINES_IN_STORAGE_FILE=`wc -l < $STORAGE_FILE`

      if [ $AMOUNT_OF_LINES_IN_STORAGE_FILE -eq 0 ]; then
        echo 'No tasks.'
      else
        more $STORAGE_FILE
      fi

      ;;
    $PRIORITY_ACTION)
      # More details about this feature in the task description needed.
      echo 'Not implemented.'
      ;;
    $DONE_ACTION)
      # Example:
      #   todo.sh done 1

      TASK_NUMBER=$2

      if [ $TASK_NUMBER ]; then
        TASK_NUMBER_IS_INTEGER=`echo $TASK_NUMBER | sed -n '/^[0-9]\+$/p'`

        if [ $TASK_NUMBER_IS_INTEGER ]; then
          TASK_FIRST_LINE_WITH_NUMBER=`cat $STORAGE_FILE | grep -n "^$TASK_NUMBER\."`

          if [ "$TASK_FIRST_LINE_WITH_NUMBER" ]; then
            LINE_NUMBER=`echo $TASK_FIRST_LINE_WITH_NUMBER | sed -n 's/\:.*//p'`

            # Deletes line with LINE_NUMBER.
            sed -i -e "${LINE_NUMBER}d" $STORAGE_FILE

            AMOUNT_OF_LINES_IN_STORAGE_FILE=`wc -l < $STORAGE_FILE`

            # If false then the last line was deleted.
            if [ $LINE_NUMBER -lt $AMOUNT_OF_LINES_IN_STORAGE_FILE ]; then
              # NEXT_LINE has same LINE_NUMBER, as deleted line,
              # because STORAGE_FILE already updated !!!
              NEXT_LINE=`cat $STORAGE_FILE | sed -n "${LINE_NUMBER}p"`

              # NEXT_LINE_IS_NEXT_TASK_FIRST_LINE='' empty string

              NEXT_LINE_IS_NEXT_TASK_FIRST_LINE=`echo $NEXT_LINE | sed -n '/^[0-9]\+\./p'`

              while [ ! "$NEXT_LINE_IS_NEXT_TASK_FIRST_LINE" ]
              do
                # NEXT_LINE has same LINE_NUMBER, as deleted line,
                # because STORAGE_FILE already updated !!!
                sed -i -e "${LINE_NUMBER}d" $STORAGE_FILE

                NEXT_LINE=`cat $STORAGE_FILE | sed -n "${LINE_NUMBER}p"`

                NEXT_LINE_IS_NEXT_TASK_FIRST_LINE=`echo $NEXT_LINE | sed -n '/^[0-9]\+\./p'`
              done
            fi

            echo 'Task has been successfully deleted.'
          else
            echo 'Task with such number not found.'
          fi
        else
          echo 'Error: Task number should be an integer.'
          exit 1
        fi
      else
        echo 'Error: No task number specified.'
        exit 1
      fi

      ;;
    $UNKNOW_ACTION)
      echo 'Error: Unknown action. Possible actions: add, list, done.'
      exit 1

      ;;
  esac
else
  echo 'Error: No action specified. Possible actions: add, list, done.'
  exit 1
fi

exit 0
