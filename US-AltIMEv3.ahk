#Requires AutoHotkey v2.0
#SingleInstance Force

; Based on: https://github.com/kskmori/US-AltIME.ahk
;
; US keyboard Alt IME control:
;   RAlt tap -> IME ON
;   LAlt tap -> IME OFF
;   Alt combinations keep their normal Alt behavior.

; Alt -> IME On/Off
$*RAlt::AltIME_Down("RAlt")
$*RAlt Up::AltIME_Up("RAlt", 1)

$*LAlt::AltIME_Down("LAlt")
$*LAlt Up::AltIME_Up("LAlt", 0)

AltIME_Down(keyName) {
    Send("{Blind}{" keyName " down}")
}

AltIME_Up(keyName, imeState) {
    ; Prevent menu-bar activation when Alt is tapped by sending an unused VK.
    ; vkE8 is used instead of vk07 because vk07 can be used by Windows.
    static ALT_MENU_MASK_KEY := "vkE8"

    priorHotkey := A_PriorHotkey
    priorKey    := A_PriorKey

    Send("{Blind}{" ALT_MENU_MASK_KEY "}{" keyName " up}")

    ; Tap detection:
    ;   priorHotkey: guards against interference from other hotkeys in this script.
    ;   priorKey:    guards against interference from other scripts / physical keys.
    ;   priorKey == "" is intentionally excluded to avoid firing on ambiguous state.
    if (priorHotkey == "$*" keyName && priorKey == keyName) {
        IME_SET(imeState)
    }
}

; Gets IME open status.
;   Return: 1 = ON, 0 = OFF, -1 = unavailable.
IME_GET(winTitle := "A") {
    return IME_SendControl(0x0005, 0, winTitle) ; IMC_GETOPENSTATUS
}

; Sets IME open status.
;   setStatus: 1 = ON, 0 = OFF
;   Return: 0 = success, non-zero = failure, -1 = unavailable.
IME_SET(setStatus, winTitle := "A") {
    return IME_SendControl(0x0006, setStatus ? 1 : 0, winTitle) ; IMC_SETOPENSTATUS
}

IME_SendControl(command, data, winTitle := "A") {
    static WM_IME_CONTROL := 0x0283

    hwnd := IME_GetTargetHwnd(winTitle)
    if !hwnd {
        return -1
    }

    imeHwnd := DllCall("imm32\ImmGetDefaultIMEWnd"
        , "Ptr", hwnd
        , "Ptr")
    if !imeHwnd {
        return -1
    }

    return DllCall("SendMessage"
        , "Ptr", imeHwnd
        , "UInt", WM_IME_CONTROL
        , "Ptr", command
        , "Ptr", data
        , "Ptr")
}

IME_GetTargetHwnd(winTitle := "A") {
    hwnd := WinActive(winTitle)
    if !hwnd {
        return 0
    }

    ptrSize := A_PtrSize
    guiThreadInfoSize := 4 + 4 + (ptrSize * 6) + 16
    guiThreadInfo := Buffer(guiThreadInfoSize, 0)
    NumPut("UInt", guiThreadInfoSize, guiThreadInfo, 0)

    if DllCall("GetGUIThreadInfo"
        , "UInt", 0
        , "Ptr", guiThreadInfo
        , "Int") {
        focusHwnd := NumGet(guiThreadInfo, 8 + ptrSize, "Ptr")
        if focusHwnd {
            return focusHwnd
        }
    }

    return hwnd
}
