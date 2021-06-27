from gtts import gTTS
from tempfile import TemporaryFile
tts = gTTS(text='Hello', lang='en')
tts.save('failed123.mp3')
'''import os
os.system('failed.wav')'''