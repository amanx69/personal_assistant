from fastapi import FastAPI
from pydantic import BaseModel
import webbrowser
import types
import os
import screen_brightness_control as sbc
from pycaw.pycaw import AudioUtilities, ISimpleAudioVolume
app = FastAPI()
 
     #~  uvicorn main:app --reload    run the  server
     #!uvicorn main:app --reload --host 0.0.0.0 --port 8000  for   run  server  in phycal device 

 #! function for  take  screen shot
def screenshort():
    import pyautogui

    img = pyautogui.screenshot()
    img_path = os.path.expanduser("~\\Pictures\\screenshots\\screenshot.png")
    img.save(img_path)

    print(f"Screenshot saved as {img_path}.")
    return{"massaage":"screenshort taken"}


#! function for  volume  up  down
def volume(level):
  
     sessions = AudioUtilities.GetAllSessions()
     for session in sessions:
        volume = session._ctl.QueryInterface(ISimpleAudioVolume)
        volume.SetMasterVolume(level, None)
        
        

#! function get volume
def get_volume():
     sessions = AudioUtilities.GetAllSessions()
     for session in sessions:
        volume = session._ctl.QueryInterface(ISimpleAudioVolume)
        return volume.GetMasterVolume()  #! value between 0.0 – 1.
     
 

  #! FOR  OPEN ANY appliction
@app.get("/openweb")
async def  openappliction(text :str ):
     text.lower()     
    
     url = f"https://www.{text}.com"

      #! open the web 
     webbrowser.open(url)
     return {"message": f"Opening {text}", "url": url}
    
    


#!  of  ai gemini
@app.get("/ai")

async def ai(text: str | int |float):
    import  google.generativeai as genai
    
    
    while True:    
     
     
     genai.configure(api_key="AIzaSyBQCk6uNt2uRL8fQrBlZ1LB75_iC2i3Vdw ") #!  gemini  api

     model = genai.GenerativeModel("gemini-2.0-flash")

     chat = model.start_chat()
     responce= chat.send_message(text)
     
     content = responce.text
 
     
     print(content)
    
       #! Save question and answer line by line
     with open("history.txt", "a", encoding="utf-8") as f:
        f.write(f"Q: {text}\n")
        f.write(f"A: {content}\n")
        
        
        return {"question:":text, "answer":content}
    
    
    
    #!  wkikipidea search 
    
    
@app.get("/research")

async def research(text: str ):
    text.lower() 
    import wikipedia
    result = wikipedia.summary(text, sentences=4)
    print(result)
    return {"question:":text, "wikianswer":result}




#! for open appliction  in windoes  
''' make  more  app add in and  functionlity add   in future  '''


@app.get("/openappliction")


async def openwindowsapp(text:str):
         
       text.lower() 
       
       if "exit" in text:
           print('exit')
        
       elif "open chrome" in text :
        os.startfile("C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe")
       elif "notepad" in text :
        os.startfile("C:\\Windows\\system32\\notepad.exe")
       elif "word" in text :
        os.startfile("C:\\Program Files\\Microsoft Office\\root\\Office16\\WINWORD.EXE")
        
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
        
       elif "take screenshot"in text:
        screenshort() #! call the screenshort function s
        
        
        return {"message": f"Opening {text}"} 
    
    
    
@app.get("/controls")    


def control_panal(text :str):
    
    
    text.lower()
    sbc.set_brightness(100)  #! set default 
    current_vol= get_volume() #! store  the volume 
    brightness= sbc.get_brightness()[0]  # !get current brightness
    
   
   

    if text in ["up", "upward", "higher"]:
        sbc.set_brightness(min(brightness + 40, 100))
    elif text in ["down", "downward", "lower"]:
        sbc.set_brightness(max(brightness - 40, 0))
    elif text in ["volume up", "sound up", "echo up"]:
        volume(min(current_vol + 0.10, 1.0))
    elif text in ["volume down", "sound down", "echo down"]:
        volume(max(current_vol - 0.10, 0.0))
    elif "mute" in text:
        volume(0.0)
    elif "volume full" in text:
        volume(1.0)
    elif text in ["stop", "exit", "get out"]:
        return {"message": "Exiting control panel..."}

    return {"message": f"Executed command: {text}"}







   
       
    



    
    
    
        
         
    
    
   
   