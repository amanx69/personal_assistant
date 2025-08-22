import google.generativeai as genai

genai.configure(api_key="AIzaSyBQCk6uNt2uRL8fQrBlZ1LB75_iC2i3Vdw ")

model = genai.GenerativeModel("gemini-2.0-flash")

chat = model.start_chat()
responce= chat.send_message("hello how are you")


print(responce)