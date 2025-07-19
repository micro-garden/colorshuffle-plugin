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

This plugin supports both built-in color schemes and user-defined `.micro`
files in `~/.config/micro/colorschemes/`.  
The list of built-in schemes is hardcoded and may not match exactly what your
micro installation provides.  
Color schemes added dynamically by other plugins are **not detected**.
