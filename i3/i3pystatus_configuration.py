#!/usr/bin/python3
from i3pystatus import Status
from i3pystatus.mail import imap
from i3pystatus.weather import weathercom

status = Status(standalone=True)

status.register("clock",
    color="#93A8D8",
    format=" %a %-d %b %H:%M",
)

status.register("weather",
    format='{icon} {current_temp}{temp_unit}',
    colorize=True,
    backend=weathercom.Weathercom(
        location_code="GMXX0027",
        units="metric",
    ),
    on_leftclick= ["chromium http://www.weather.com/de-DE/wetter/heute/l/GMXX0027"]
)

status.register("shell",
    format="<span color=\"#FFFFFF\">H:</span> <span color=\"#31F18B\">{output}</span>",
    hints = {"markup": "pango"},
    command="echo \"list DHT_Bedroom humidity\nexit\" | netcat tank 7072 | awk '{print $4}'",
)

status.register("shell",
    format="<span color=\"#FFFFFF\">T:</span> <span color=\"#31F18B\">{output}°C</span> ",
    hints = {"markup": "pango","separator": False, "separator_block_width": 0},
    command="echo \"list DHT_Bedroom temperature\nexit\" | netcat tank 7072 | awk '{print $4}'",
)

status.register("mem",
    color="#E0DA37",
    format="{used_mem} MiB",)

status.register("cpu_usage",
    hints = {"markup": "pango"},
    interval=1,
    format="<span color=\"#F15E5E\">{usage:02}%</span>",)

status.register("temp",
    color="#F1AF5F",
    file="/sys/devices/platform/it87.656/temp1_input",
    format="{temp:.0f}°C",)

status.register("disk",
    color="#80D9D8",
    path="/home",
    format=" {avail}G",)
#format="{used}/{total}G [{avail}G]",)

status.register("mpd",
    host='tank',
    port=6600,
    max_field_len=200,
    max_len=200,
    format="{artist} - {title} {status}",
    status={
        "pause": "▷",
        "play": "▶",
        "stop": "◾",
    },)

status.run()
