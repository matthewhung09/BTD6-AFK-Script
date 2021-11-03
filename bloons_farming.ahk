#Include "%A_ScriptDir%\maps\dark_castle.ahk"

; global stateIndicators := ["play_home", "stage_select", "in_game", "collect", "event"]
global timeScale := 1.00

^j:: {
    while WinActive("BloonsTD6") {
		Sleep(3000)
        clickElement("play_home", 1000)
		selectMap("dark_castle_map", 1000, 5000)
		darkCastleScript()
        clearVictoryScreen()
		if searchImage("collect") {
			openBoxes(1000)
		}
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

	; Try to find Dark Castle
	if clickElement(map_name, sleep_time) {
		MsgBox 
		clickElement("easy", sleep_time)
		clickElement("standard", load_time)
		found := true
	}
	; If not on first page of expert maps go to next
	if (found == false) {
		clickElement("expert", sleep_time)

		if clickElement(map_name, sleep_time) {
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

openBoxes(sleepTime) {
	clickElement("collect", sleepTime)

	while !searchImage("event") {
		Click("683 535")
		Sleep(timeScale * sleepTime)
		Click("900, 550")
		Sleep(timeScale * sleepTime)
		Click("897 535")
		Sleep(timeScale * sleepTime)
		Click("900, 550")
		Sleep(timeScale * sleepTime)
		Click("1190 535")
		Sleep(timeScale * sleepTime)
		Click("900, 550")
		Sleep(timeScale * sleepTime)
		Click("950 930")
		Sleep(timeScale * sleepTime)
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