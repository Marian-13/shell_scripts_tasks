#! /bin/sh

# -----------------------------------------------------------------------------#
# Завдання 2 (8 балів). Створити shell скріпт для керування фоновим процесом.
# Реалізувати команди
#
#    my-service.sh start # стартує yes у фоні                 | V |
#    my-service.sh status # виводить чи наш процес запужений  | V |
#    my-service.sh stop   # зупиняє наш процес                | V |

# -----------------------------------------------------------------------------#

readonly SCRIPT_MINIMAL_AMOUNT_OF_ARGUMENTS=1

readonly START_ACTION='start'
readonly STATUS_ACTION='status'
readonly STOP_ACTION='stop'
readonly UNKNOW_ACTION="*"

readonly PROCESS='yes'


SCRIPT_AMOUNT_OF_ARGUMENTS=$#

if [ $SCRIPT_AMOUNT_OF_ARGUMENTS -ge $SCRIPT_MINIMAL_AMOUNT_OF_ARGUMENTS ]; then
  ACTION=$1

  case $ACTION in
    $START_ACTION)
      PROCESS_ID=`pgrep $PROCESS`

      if [ $PROCESS_ID ]; then
        echo 'Process has been already started.'
      else
        `$PROCESS > /dev/null &`
        echo 'Process has been successfully started.'
      fi

      ;;
    $STATUS_ACTION)
      PROCESS_ID=`pgrep $PROCESS`

      if [ $PROCESS_ID ]; then
        echo 'Process is active.'
      else
        echo 'Process is inactive.'
      fi

      ;;
    $STOP_ACTION)
      PROCESS_ID=`pgrep $PROCESS`

      if [ $PROCESS_ID ]; then
        kill -9 $PROCESS_ID

        echo 'Process has been successfully stopped.'
      else
        echo 'Process has not even been started.'
      fi

      ;;
    $UNKNOW_ACTION)
      echo 'Error: Unknown action. Possible actions: start, status, stop.'
      exit 1

      ;;
  esac
else
  echo 'Error: No action specified. Possible actions: start, status, stop.'
  exit 1
fi

exit 0
