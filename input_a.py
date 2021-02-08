import sys
import time

    from pykeyboard import PyKeyboard
    import ctypes
def run():

    k = PyKeyboard()

    english = "0x409"
    chinese = "0x804"

    user32 = ctypes.WinDLL("user32", use_last_error=True)
    current_windown = user32.GetForegroundWindow()
    thread_id = user32.GetWindowThreadProcessId(current_windown, 0)
    klid = user32.GetKeyboardLayout(thread_id)

    lid = klid & (2 ** 16 - 1)
    lid_hex = hex(lid)

    if lid_hex == chinese:
        k.press_keys([k.control_l_key, k.shift_l_key])

    if lid_hex == english:
        k.press_key(k.escape_key)


run()

time.sleep(1)
sys.exit()
