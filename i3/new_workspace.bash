#!/bin/bash
i3-msg workspace  new
i3-input -F 'rename workspace to " %s"' -P 'New name: '
