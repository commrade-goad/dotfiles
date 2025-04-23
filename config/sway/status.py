#!/usr/bin/env python3

import json
import time
import subprocess
from datetime import datetime
from pathlib import Path
from typing import Callable

BATTERY_PATH: Path = Path("/sys/class/power_supply/BAT1")

class Module:
    def __init__(self, name: str, func: Callable[[], str], use_pango: bool = False, separator: bool = False):
        self.name = name
        self.use_pango = use_pango
        self.separator = separator
        self.func = func

        self.json = ""

    def update(self):
        self.json = json.dumps({
            "full_text": self.func(),
            "name": self.name,
            "markup": "pango" if self.use_pango else "",
            "separator": self.separator
        })

class Bar:
    def __init__(self):
        self.first: bool = True

        self.header: dict = {
            "version": 1,
            "markup": "pango",
            # "click_events": True,
        }
        self.blocks: list[Module] = []
        self._json = ""

    def delay(self, seconds):
        time.sleep(seconds)

    def render_json_header(self):
        print(json.dumps(self.header))
        print("[")

    def blocks_update(self):
        for mod in self.blocks:
            mod.update()

    def render_json(self):
        if not self.first:
            print(",")
        self.first = False
        json_blocks = []
        for mod in self.blocks:
            json_blocks.append(json.loads(mod.json))
        print(json.dumps(json_blocks), flush=True)

def get_datetime():
    return datetime.now().strftime("%d/%m/%Y - %H:%M")

def get_battery():
    try:
        capacity = (BATTERY_PATH / "capacity").read_text().strip()
        status = (BATTERY_PATH / "status").read_text().strip()
        display = f"Bat:{capacity}%"
        if status == "Charging":
            display += "+"
        return display
    except FileNotFoundError:
        return "Bat: N/A"

def get_player_status():
    try:
        output = subprocess.check_output(["swaybar-custom-media-display"]).decode().strip()
        return f"<i>{output}</i>"
    except Exception:
        return "<i>No player</i>"

if __name__ == "__main__":
    calendar = Module("calendar", use_pango=False, separator=True, func=get_datetime)
    battery = Module("battery", use_pango=False, separator=True, func=get_battery)
    media = Module("media", use_pango=True, separator=True, func=get_player_status)
    bar = Bar()

    bar.render_json_header()

    bar.blocks.append(media)
    bar.blocks.append(battery)
    bar.blocks.append(calendar)
    bar.blocks_update()

    while True:
        bar.render_json()
        bar.blocks_update()
        bar.delay(0.2)

