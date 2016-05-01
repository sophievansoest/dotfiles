#!/usr/bin/python3
from i3pystatus import Status

status = Status(standalone=True)

status.register("clock",
        color="#93A8D8",
        format=" %a %-d %b %H:%M",)

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
