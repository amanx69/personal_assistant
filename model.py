import pyttsx3
import wikipedia
import speech_recognition as sr
import  webbrowser
import  datetime
import google.generativeai as genai
import os 
import pyautogui
import screen_brightness_control as sbc
from pycaw.pycaw import AudioUtilities, ISimpleAudioVolume





import  threading
import  tkinter as tk



'''! all gui function and  code  is  here!'''


root= tk.Tk()
root.title("ashu")
root.geometry("300x200")

title = tk.Label(root, text="🤖 Ashu - Personal Assistant",
                 font=("Arial", 18, "bold"),
                 fg="white", bg="#C3C3DF")
title.pack(pady=10)
btn = tk.Button(root, text="Click Me", font=("Arial", 14),
        bg="lightblue", command=open)
btn.pack(pady=15)


#! change  gui emoji color 

# def change_color():
#     root.configure(bg="blue")
   











#! inslize the globle  variable
r = sr.Recognizer()


#!  function for window  open  appliction
def open( ):
  speak("what do you want to open in window aman")
  while True:  
    
    text = listen()
    if "google" in text:
          webbrowser.open("https://www.google.com/")
    
    elif "open chrome" in text :
        os.startfile("C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe") 
    elif "notepad" in text :
        os.startfile("C:\\Windows\\system32\\notepad.exe")
    elif "word" in text :
        os.startfile("C:\\Program Files\\Microsoft Office\\root\\Office16\\WINWORD.EXE")   
    elif"open youtube"in text:
        webbrowser.open("https://www.youtube.com/")
    elif"open facebook"in text:
        webbrowser.open("https://www.facebook.com/")   
        
    elif "instagram"in text:
        webbrowser.open("https://www.instagram.com/")
    elif"open github"in text:
        webbrowser.open("https://github.com/")  
    elif  "open spotify" in text:
        webbrowser.open("https://open.spotify.com/")  
    elif "terminal"in text:
        os.system("start powershell")
        
    elif  "shutdown" in text:
        os.system("shutdown /s /t 1")
        
    elif  "restart" in text:
        os.system("shutdown /r /t 1")
        
    elif "sleep" in text :
        os.system("rundll32.exe powrprof.dll,SetSuspendState 0,1,0")    
        
    elif "open camera" in text:
        os.system("start microsoft.windows.camera:")    
        
    elif "play video" in text:
        os.startfile("C:\works\\all\\aman sahu")    
        
    elif "play music" in text:
        os.startfile("C:\\Users\\anuja\\OneDrive\Desktop\\all\\aman sahu\\Audio")
        
    elif "love" in text :
        os.startfile("C:\\Users\\anuja\\Desktop\\A")
        
        
    elif  "whatsapp" in text:
        os.startfile("https://web.whatsapp.com/")
        
        
        
    elif "exit" or "stop" or "get out" in text:
        print("exit")
        speak("exit")    
        break  
     
        
 
 #! contorl  panal  like control brighness   or  volume  up  down
def control_panal():
    sbc.set_brightness(100)  #! set default 
    setvolume= get_volume()
    current= sbc.get_brightness()[0]  # !get current brightness

    speak("you want brightness and volume  up down  aman")
    while True:  
    
     text = listen()    
     print("you said",text)
     #! if  say up  
     if  text.strip() in ["up", "upward", "higher"]: 
        sbc.set_brightness(current+ 40,100)
        
      #! if  say down
      
     elif text.strip() in ["stop", "get out", "exit"]: 
        print("exit")
        speak("exit")
        break
        
     elif  text.strip() in ["down", "downward", "lower"]:
        sbc.set_brightness(current -40, 0)    
        
        
#! condition fior  volume  up  down
     elif text.strip() in ["echo up ", "sound up", "volume up"]:  
         
         volume(min(setvolume + 0.10, 1.0))  
         speak("volume up")
         
     elif text.strip() in ["echo down", "sound down", "volume down"]:
         volume(max(setvolume - 0.10, 0.0))
         speak("volume down")
     elif "mute" in text:
         volume(0.0)    
         speak("mute")
         
     elif "volume full" in text:
         volume(1.0)
         speak("volume full")    
        
 #!@ function for  volume up down         
def volume(level):
    speak("what do you want volume aman")        
    sessions = AudioUtilities.GetAllSessions()
    for session in sessions:
        volume = session._ctl.QueryInterface(ISimpleAudioVolume)
        volume.SetMasterVolume(level, None)
        
        

def get_volume():
    sessions = AudioUtilities.GetAllSessions()
    for session in sessions:
        volume = session._ctl.QueryInterface(ISimpleAudioVolume)
        return volume.GetMasterVolume()  #! value between 0.0 – 1.0
         

#! function for  take  screen 
def screenshort():
    speak("Taking screenshot aman...")
    img = pyautogui.screenshot()
    img_path = os.path.expanduser("~\\Pictures\\screenshots\\screenshot.png")
    img.save(img_path)
    speak(f"Screenshot saved as {img_path}.")
    print(f"Screenshot saved as {img_path}.")
    


#! function  for  date time 
def time():
    
     current_time = datetime.datetime.now().strftime("%I:%M:%S %p")
     speak(f" the  current time is {current_time}")
     print(f" the  current time is {current_time}")
    


#! spack  function
def speak(text):
    engine = pyttsx3.init()
    voices = engine.getProperty('voices')
    engine.setProperty('voice', voices[1].id)  
    engine.setProperty('rate', 150)
    engine.setProperty('volume', 1.5)
    engine.say(text)
    engine.runAndWait()
    
    
    
    
#! open gemini function
def gemini():
    
    speak("what do you want to ask aman")
    
    while True:    
     text= listen()
     
     genai.configure(api_key="AIzaSyBQCk6uNt2uRL8fQrBlZ1LB75_iC2i3Vdw ") #!  gemini  api

     model = genai.GenerativeModel("gemini-2.0-flash")

     chat = model.start_chat()
     responce= chat.send_message(text)
     content = responce.text
 
     speak(content)
     print(content)
    
       #! Save question and answer line by line
     with open("history.txt", "a", encoding="utf-8") as f:
        f.write(f"Q: {text}\n")
        f.write(f"A: {content}\n")
#! open browser function

    
    
    
 #! wkipedia search function    
def wiki ():
    speak("What do you want to search on Wikipedia aman ")
    while True:
     text = listen()
   
     try:
         
        result = wikipedia.summary(text, sentences=2)
        speak("According to Wikipedia")
        speak(result)
        print(result)
        #! exit the  program 
        if text.lower().strip() in ["exit", "stop", "quit"]:
              speak("exit")
              break 
     except wikipedia.exceptions.DisambiguationError:
        speak("Multiple results found. Please be more specific.")
     except Exception:
        speak("I couldn't find anything on Wikipedia.")
#  
    
    
#! listen function 
    
def listen():
  
    with sr.Microphone() as source:
        r.adjust_for_ambient_noise(source, duration=1)
        print("Listening...")
       
        audio = r.listen(source)
        try:
            text = r.recognize_google(audio,language="en-in")
            # #! if sy exit the program
            # if text.lower().strip() in ["exit", "stop", "quit"]:
            #  break
             
            print("You said:", text)
            while True:  
            # return text.lower()
             if text.lower().strip() in ["exit", "stop", "quit"]:
              speak("exit")
             break

            actions = {
             "search": wiki,
              "open": open,
             "time": time,
              "hello": gemini,
              "screenshot": screenshort,
             "control": control_panal
              # "massage":send_masage
    }

            if text in actions:
                actions[text]() 
            
          
        except sr.UnknownValueError:
         speak("Sorry, I couldn't understand what you said.")
      
        except sr.RequestError:
            speak("Sorry, I have no internet connection.")
         

    
    
    
if __name__ == "__main__":    
    
 
   
   
    

    #! wish  birthday autmatic message
    today = datetime.date.today()
    if today.day == 2 and today.month == 8:
           speak(" Happy Birthday, Aman your  love ashu ")
           
           

# while True:
    
#  try:   

#     command= listen()
#     #! exit  the  program  
#     if command.lower().strip() in ["exit", "stop", "quit"]:
#         speak("exit")
#         break

#     actions = {
#         "search": wiki,
#         "open": open,
#         "time": time,
#         "hello": gemini,
#         "screenshot": screenshort,
#         "control": control_panal
#        # "massage":send_masage
#     }

#     if command in actions:
#         actions[command]()     
#     else:
#         #speak("command  not found aman")  
#         print("command  not found aman")  

#  except Exception as e:
#     speak("An error occurred.")
#     print(f"Error: {e}")
     
     
# threading.Thread(target=None, daemon=True).start()     

# root.mainloop()
open("open youtube")



        
      



