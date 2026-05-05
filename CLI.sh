#!/bin/bash

LOG_FILE="session.log"

clear

echo "      ADMIN  CLI "

while true; do
    read -p "admin-cli> " -a params
    if [[ ${#params[@]} -eq 0 ]]; then
        continue
    fi

    COMMAND=${params[0]}
    echo "Command: ${params[*]}" >> "$LOG_FILE"

    case $COMMAND in
        find)

            FILE=${params[1]}
            DIR=${params[2]}

            if [[ -z "$FILE" || -z "$DIR" ]]; then
                echo "Usage: find <file> <directory>"
            elif [[ ! -d "$DIR" ]]; then
                echo "No such directory."
            else
                find "$DIR" -name "$FILE"
            fi
            ;;

        math)

            ARG1=${params[1]}
            OPERATOR=${params[2]}
            ARG2=${params[3]}

                case $OPERATOR in
                    add) echo "Result: $((ARG1 + ARG2))" ;;
                    sub) echo "Result: $((ARG1 - ARG2))" ;;
                    *) echo "Available commands: add, sub" ;;
                esac
            ;;
	
        secure)

            FILE=${params[1]}

            if [[ -z "$FILE" ]]; then
                echo "Input filename."
            elif [[ ! -f "$FILE" ]]; then
                echo "No such file or directory."
            else
                OWNER=$( stat -c %U "$FILE" )

                if [[ "$OWNER" == "$USER" ]]; then
                    chmod 600 "$FILE"
                else
                    echo "Permission denied"
                fi

            fi
            ;;
        exit)

            break
            ;;

        *)

            echo "Unknown command: $COMMAND"
            echo "Availabe comands: find, math, secure, exit"
            ;;
    esac
done

