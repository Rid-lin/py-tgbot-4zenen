# A simple telegram bot for spying on chats

(github.com/rid-lin/py-tgbot-4zenen)
This bot monitors several chats and sends a message if a keyword appears in these chats.

## Usage 

Create file `dev.env`:
```
TGB4Z_ID=<your_API_ID>
TGB4Z_HASH=<your_API_HASH>
TGB4Z_PHONE=<your_phone_number>
TGB4Z_FORWARD=<chat_for_notification>
TGB4Z_WORDS=<firt_search_word>
TGB4Z_WORDS=<second_search_word>
```

First run container
`docker run -i --env-file ./dev.env -v ./data:/app/data vsvegner/py-tgbot-4zenen:latest`
enter yor phone number, code and password

Regular Run
`docker run --restart=on-failure:20 -d --env-file ./dev.env -v ./saved.session:/app/saved.session vsvegner/py-tgbot-4zenen:latest`
