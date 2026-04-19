import platform
import psutil

print("================= PANELFETCH =================")
print()
print(f"Host OS: {platform.system()} {platform.release()}")
print(f"CPU: {platform.processor()}")
try:
    gpu = psutil.virtual_memory()  # Placeholder; GPU detection is complex
    print("GPU: Detection not implemented (requires additional libraries)")
except:
    print("GPU: N/A")
ram_gb = round(psutil.virtual_memory().total / (1024**3), 1)
print(f"RAM: {ram_gb} GB")
try:
    battery = psutil.sensors_battery()
    if battery:
        print(f"Battery: {battery.percent}%")
    else:
        print("Battery: N/A (desktop or no battery)")
except:
    print("Battery: N/A")
print(f"Python: {platform.python_version()}")
print()
print("==============================================")
input("Press Enter to continue...")