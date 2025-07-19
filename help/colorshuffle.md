# Color Shuffle Plugin

**Color Shuffle** is a micro plugin that randomly switches the color scheme
whenever you open a file.

## Features

- Randomly selects a different color scheme each time you open a file
- Includes both built-in and user-defined themes
- Avoids repeating the current scheme
- Command `colorshuffle` and keybind `Ctrl-Alt-s` to switch on demand

## Tips

To check the current color scheme in micro, use the following built-in command:

```
show colorscheme
```

## Limitations

- **Not exactly "whenever you open a file"**  
  The color scheme is set when a buffer pane is opened. This may happen in
  various situations, for example when splitting panes or switching tabs, so
  it is not strictly tied to file opening.

- **Recognized color schemes**  
  Only `.micro` files inside the `~/.config/micro/colorschemes/` directory are
  detected. Built-in color schemes are included manually and may differ from
  what your micro installation actually supports.
