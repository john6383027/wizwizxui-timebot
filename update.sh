#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo -e "\033[33mPlease run as root\033[0m"
    exit
fi

wait

echo " "

PS3=" Please Select Action: "
options=("Update 1 single bot" "Update all bots" "Update panel" "Backup" "Delete" "Donate" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "Update 1 single bot")
            echo " "
            read -p "Enter the bot directory name (e.g., william_smith_bot): " bot_name
            echo " "
            bot_path=$(find /var/www/html -type d -name "$bot_name" | head -n 1)
            
            if [ -z "$bot_path" ]; then
                echo -e "\e[41mError: Bot directory '$bot_name' not found.\033[0m\n"
                break
            fi

            echo "Found bot at: $bot_path"
            read -p "Are you sure you want to update the bot at $bot_path? [y/n]: " answer
            echo " "
            if [ "$answer" != "${answer#[Yy]}" ]; then
                mv "$bot_path/baseInfo.php" /root/
                sudo apt-get install -y git wget unzip curl
                echo -e "\n\e[92mUpdating ...\033[0m\n"
                sleep 4
                rm -r "$bot_path/"
                echo -e "\n\e[92mWait a few seconds ...\033[0m\n"
                sleep 3
                git clone https://github.com/john6383027/wizwizxui-timebot.git "$bot_path"
                sudo chown -R www-data:www-data "$bot_path/"
                sudo chmod -R 755 "$bot_path/"
                sleep 3
                mv /root/baseInfo.php "$bot_path/"

                sleep 1

                db_namewizwiz=$(cat "$bot_path/baseInfo.php" | grep '$dbName' | cut -d"'" -f2)
                db_userwizwiz=$(cat "$bot_path/baseInfo.php" | grep '$dbUserName' | cut -d"'" -f2)
                db_passwizwiz=$(cat "$bot_path/baseInfo.php" | grep '$dbPassword' | cut -d"'" -f2)
                bot_token=$(cat "$bot_path/baseInfo.php" | grep '$botToken' | cut -d"'" -f2)
                bot_token2=$(cat "$bot_path/baseInfo.php" | grep '$botToken' | cut -d'"' -f2)
                bot_url=$(cat "$bot_path/baseInfo.php" | grep '$botUrl' | cut -d'"' -d"'" -f2)

                filepath="$bot_path/baseInfo.php"

                bot_value=$(cat $filepath | grep '$admin =' | sed 's/.*= //' | sed 's/;//')

                MESSAGE="🤖 The Robot successfully updated and modified by panelyar core! "$'\n\n'"🔻token: <code>${bot_token}</code>"$'\n'"🔻admin: <code>${bot_value}</code> "$'\n\n'" 📢 @panelYarRobot  -  📢 @wampp "

                curl -s -X POST "https://api.telegram.org/bot${bot_token}/sendMessage" -d chat_id="${bot_value}" -d text="$MESSAGE" -d parse_mode="html"
                curl -s -X POST "https://api.telegram.org/bot${bot_token2}/sendMessage" -d chat_id="${bot_value}" -d text="$MESSAGE" -d parse_mode="html"

                sleep 1

                url="${bot_url}install/install.php?updateBot"
                curl $url

                url3="${bot_url}install/install.php?updateBot"
                curl $url3

                echo -e "\n\e[92mUpdating ...\033[0m\n"

                sleep 2

                sudo rm -r "$bot_path/webpanel"
                sudo rm -r "$bot_path/install"
                rm "$bot_path/createDB.php"
                rm "$bot_path/updateShareConfig.php"
                rm "$bot_path/README.md"
                rm "$bot_path/README-fa.md"
                rm "$bot_path/LICENSE"
                rm "$bot_path/update.sh"
                rm "$bot_path/wizwiz.sh"
                rm "$bot_path/tempCookie.txt"
                rm "$bot_path/settings/messagewizwiz.json"
                clear

                echo -e "\n\e[92mThe script was successfully updated! \033[0m\n"

            else
                echo -e "\e[41mCancel the update.\033[0m\n"
            fi

            break ;;

        "Update all bots")
            echo " "
            echo -e "\n\e[92mUpdating all bots...\033[0m\n"
            for bot_path in $(find /var/www/html -type d -name "*bot"); do
                echo "Updating bot at $bot_path"
                mv "$bot_path/baseInfo.php" /root/
                sudo apt-get install -y git wget unzip curl
                echo -e "\n\e[92mUpdating ...\033[0m\n"
                sleep 4
                rm -r "$bot_path/"
                echo -e "\n\e[92mWait a few seconds ...\033[0m\n"
                sleep 3
                git clone https://github.com/john6383027/wizwizxui-timebot.git "$bot_path"
                sudo chown -R www-data:www-data "$bot_path/"
                sudo chmod -R 755 "$bot_path/"
                sleep 3
                mv /root/baseInfo.php "$bot_path/"

                sleep 1

                db_namewizwiz=$(cat "$bot_path/baseInfo.php" | grep '$dbName' | cut -d"'" -f2)
                db_userwizwiz=$(cat "$bot_path/baseInfo.php" | grep '$dbUserName' | cut -d"'" -f2)
                db_passwizwiz=$(cat "$bot_path/baseInfo.php" | grep '$dbPassword' | cut -d"'" -f2)
                bot_token=$(cat "$bot_path/baseInfo.php" | grep '$botToken' | cut -d"'" -f2)
                bot_token2=$(cat "$bot_path/baseInfo.php" | grep '$botToken' | cut -d'"' -f2)
                bot_url=$(cat "$bot_path/baseInfo.php" | grep '$botUrl' | cut -d'"' -d"'" -f2)

                filepath="$bot_path/baseInfo.php"

                bot_value=$(cat $filepath | grep '$admin =' | sed 's/.*= //' | sed 's/;//')

                MESSAGE="🤖 The Robot successfully updated and modified by panelyar core! "$'\n\n'"🔻token: <code>${bot_token}</code>"$'\n'"🔻admin: <code>${bot_value}</code> "$'\n\n'" 📢 @panelYarRobot  -  📢 @wampp "

                curl -s -X POST "https://api.telegram.org/bot${bot_token}/sendMessage" -d chat_id="${bot_value}" -d text="$MESSAGE" -d parse_mode="html"
                curl -s -X POST "https://api.telegram.org/bot${bot_token2}/sendMessage" -d chat_id="${bot_value}" -d text="$MESSAGE" -d parse_mode="html"

                sleep 1

                url="${bot_url}install/install.php?updateBot"
                curl $url

                url3="${bot_url}install/install.php?updateBot"
                curl $url3

                echo -e "\n\e[92mUpdating ...\033[0m\n"

                sleep 2

                sudo rm -r "$bot_path/webpanel"
                sudo rm -r "$bot_path/install"
                rm "$bot_path/createDB.php"
                rm "$bot_path/updateShareConfig.php"
                rm "$bot_path/README.md"
                rm "$bot_path/README-fa.md"
                rm "$bot_path/LICENSE"
                rm "$bot_path/update.sh"
                rm "$bot_path/wizwiz.sh"
                rm "$bot_path/tempCookie.txt"
                rm "$bot_path/settings/messagewizwiz.json"
                clear

                echo -e "\n\e[92mThe script was successfully updated! \033[0m\n"
            done
            break ;;

        "Update panel")
            echo " "
            read -p "Are you sure you want to update?[y/n]: " answer
            echo " "
            if [ "$answer" != "${answer#[Yy]}" ]; then

                wait
                cd /var/www/html/ && find . -mindepth 1 -maxdepth 1 ! -name wizwizxui-timebot -type d -exec rm -r {} \;

                touch /var/www/html/index.html
                echo "<!DOCTYPE html><html><head><title>My Website</title></head><body><h1>Hello, world!</h1></body></html>" > /var/www/html/index.html

                RANDOM_CODE=$(LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom | head -c 40)
                mkdir "/var/www/html/${RANDOM_CODE}"
                echo "Directory created: ${RANDOM_CODE}"
                echo "Folder created successfully!"

                cd /var/www/html/
                wget -O wizwizpanel.zip https://github.com/john6383027/wizwizxui-timebot/releases/download/10.3.1/wizwizpanel.zip

                file_to_transfer="/var/www/html/wizwizpanel.zip"
                destination_dir=$(find /var/www/html -type d -name "*${RANDOM_CODE}*" -print -quit)

                if [ -z "$destination_dir" ]; then
                    echo "Error: Could not find directory containing 'wiz' in '/var/www/html'"
                    exit 1
                fi

                mv "$file_to_transfer" "$destination_dir/" && yes | unzip "$destination_dir/wizwizpanel.zip" -d "$destination_dir/" && rm "$destination_dir/wizwizpanel.zip" && sudo chmod -R 755 "$destination_dir/" && sudo chown -R www-data:www-data "$destination_dir/"

                wait

                echo -e "\n\e[92mUpdating ...\033[0m\n"

                bot_token=$(cat /var/www/html/wizwizxui-timebot/baseInfo.php | grep '$botToken' | cut -d"'" -f2)
                bot_token2=$(cat /var/www/html/wizwizxui-timebot/baseInfo.php | grep '$botToken' | cut -d'"' -f2)

                filepath="/var/www/html/wizwizxui-timebot/baseInfo.php"

                bot_value=$(cat $filepath | grep '$admin =' | sed 's/.*= //' | sed 's/;//')

                MESSAGE="🕹 WizWiz panel has been successfully updated!"

                curl -s -X POST "https://api.telegram.org/bot${bot_token}/sendMessage" -d chat_id="${bot_value}" -d text="$MESSAGE"
                curl -s -X POST "https://api.telegram.org/bot${bot_token2}/sendMessage" -d chat_id="${bot_value}" -d text="$MESSAGE"

                sleep 1

                if [ $? -ne 0 ]; then
                    echo -e "\n\e[41mError: The update failed!\033[0m\n"
                    exit 1
                else

                    clear

                    echo -e ' '
                    echo -e "\e[100mwizwiz panel:\033[0m"
                    echo -e "\e[33maddres: \e[36mhttps://domain.com/${RANDOM_CODE}/login.php\033[0m"
                    echo " "
                    echo -e "\e[92mThe script was successfully updated!\033[0m\n"
                fi

            else
                echo -e "\e[41mCancel the update.\033[0m\n"
            fi

            break ;;

        "Backup")
            echo " "
            wait

            (crontab -l ; echo "0 * * * * ./dbbackupwizwiz.sh") | sort - | uniq - | crontab -

            wget https://raw.githubusercontent.com/john6383027/wizwizxui-timebot/main/dbbackupwizwiz.sh | chmod +x dbbackupwizwiz.sh
            ./dbbackupwizwiz.sh

            wget https://raw.githubusercontent.com/john6383027/wizwizxui-timebot/main/dbbackupwizwiz.sh | chmod +x dbbackupwizwiz.sh
            ./dbbackupwizwiz.sh

            echo -e "\n\e[92m The backup settings have been successfully completed.\033[0m\n"

            break ;;

        "Delete")
            echo " "

            wait

            passs=$(cat /root/confwizwiz/dbrootwizwiz.txt | grep '$pass' | cut -d"'" -f2)
            userrr=$(cat /root/confwizwiz/dbrootwizwiz.txt | grep '$user' | cut -d"'" -f2)
            pathsss=$(cat /root/confwizwiz/dbrootwizwiz.txt | grep '$path' | cut -d"'" -f2)
            pathsss=$(cat /root/confwizwiz/dbrootwizwiz.txt | grep '$path' | cut -d"'" -f2)
            passsword=$(cat /var/www/html/wizwizxui-timebot/baseInfo.php | grep '$dbPassword' | cut -d"'" -f2)
            userrrname=$(cat /var/www/html/wizwizxui-timebot/baseInfo.php | grep '$dbUserName' | cut -d"'" -f2)

            mysql -u $userrr -p$passs -e "DROP DATABASE wizwiz;" -e "DROP USER '$userrrname'@'localhost';" -e "DROP USER '$userrrname'@'%';"

            sudo rm -r /var/www/html/wizpanel${pathsss}
            sudo rm -r /var/www/html/wizwizxui-timebot

            clear

            sleep 1

            (crontab -l | grep -v "messagewizwiz.php") | crontab -
            (crontab -l | grep -v "rewardReport.php") | crontab -
            (crontab -l | grep -v "warnusers.php") | crontab -
            (crontab -l | grep -v "backupnutif.php") | crontab -

            echo -e "\n\e[92m Removed successfully.\033[0m\n"
            break ;;

        "Donate")
            echo " "
            echo -e "\n\e[91mBank ( 1212 ): \e[36m1212\033[0m\n\e[91mTron(trx): \e[36mTY8j7of18gbMtneB8bbL7SZk5gcntQEemG\n\e[91mBitcoin: \e[36mbc1qcnkjnqvs7kyxvlfrns8t4ely7x85dhvz5gqge4\033[0m\n"
            exit 0
            break ;;

        "Exit")
            echo " "
            break
            ;;
        *) echo "Invalid option!"
    esac
done