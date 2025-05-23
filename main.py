from telethon import TelegramClient, events
import os


# Get environment variables

api_id = os.getenv('TGB4Z_ID')
api_hash = os.getenv('TGB4Z_HASH')
phone = os.getenv('TGB4Z_PHONE')
if phone is not None: phone = phone.replace("+", "")
PASSWORD = os.environ.get('TGB4Z_PASSWORD')
forwarding_to = int(os.getenv('TGB4Z_FORWARD'))
additional_chat = os.getenv('TGB4Z_TEST')
words_s = os.getenv('TGB4Z_WORDS')

# Print envirovement
print(f'Envirovements: api_id={api_id}, api_hash={api_hash}, phone_number={phone}, keywords={words_s}, target_chat_id={forwarding_to},{additional_chat}')

client = TelegramClient("data/saved", api_id, api_hash)
client.start(phone)
# print(client.get_me().stringify())
chats_for_finging = tuple()
# print all chats name
for dialog in client.iter_dialogs():
    if dialog.id < 0:
        chats_for_finging = chats_for_finging + (dialog.name,)
#     print(dialog.id, "\t", dialog.name, "\t", dialog.title)

words = words_s.split(" ")
if additional_chat is not None:
    chats_for_finging = chats_for_finging + (additional_chat,)


@client.on(events.NewMessage(chats=chats_for_finging))
async def normal_handler(event):
    # print(event.message)
    # message = event.message
    event_message_dict = event.message.to_dict()
    user_mess = event_message_dict['message']
    s_user_id = event_message_dict['from_id']
    user_id = ""
    if s_user_id:
        user_id = s_user_id['user_id']
    for word in words:
        if word.lower() in user_mess.lower():
            print(f"user message :\n'{user_mess}'\n from:\n'{user_id}'\n")
            await event.forward_to(forwarding_to)
            break
    else:
        print(f"not found key words in meassage with mess_id{1}", 
              event_message_dict['id'])

client.run_until_disconnected()
