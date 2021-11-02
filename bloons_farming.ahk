#Include "%A_ScriptDir%\maps\dark_castle.ahk"

global stateIndicators := ["play_home", "stage_select", "in_game", "collect", "event"]
global timeScale := 1.00

^j:: {
    if WinActive("BloonsTD6") {
        ;darkCastleScript()
        ;clearVictoryScreen()
        clickElement("play_home", 1000)
		selectMap("dark_castle", 1000, 5000)
    }
}

^p:: {
    ExitApp()
}

selectMap(map_name, sleep_time, load_time) {
	if !searchImage("expert_selected") {
		clickElement("expert", sleep_time)
	}
	found := false

	if clickElement("dark_castle_map", sleep_time) {
		MsgBox 
		clickElement("easy", sleep_time)
		clickElement("standard", load_time)
		found := true
	}
	; If not on first page of expert maps go to next
	if (found == false) {
		clickElement("expert", sleep_time)

		if clickElement("dark_castle_map", sleep_time) {
			clickElement("easy", sleep_time)
			clickElement("standard", load_time)
			found := true
		}
	}
}

searchImage(picName) {
	if ImageSearch(&xCoord, &yCoord, 0, 0, 1920, 1080, "*65 " A_ScriptDir "\resources\" picName ".png") {
		return true
	} 
	else {
		return false
	}
}
	
clickElement(picName, sleep_time) {
	if ImageSearch(&xCoord, &yCoord, 0, 0, 1920, 1080, "*65 " A_ScriptDir "\resources\" picName ".png") {
		global x := xCoord
		global y := yCoord
		Click(x,y)
		Sleep(timeScale * sleep_time)
		return true
	} 
	else {
		return false
	}
}

clearVictoryScreen() {
    Loop {
		if searchImage("victory") {
			clickElement("next", 2000)
			clickElement("home", 2000)
			break
		} 
    }
}