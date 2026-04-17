# dotfiles

[Dot, dot dot, dot-dot dot-dot dot-dot.](https://youtu.be/VyZiIuMufTA?si=RyBAJ_Uclv0u7TkJ)

## Sync checklist

```sh
sh scripts/apps-export.sh
BOSSMAN=<redacted> sh scripts/brew-export.sh
BOSSMAN=<redacted> ./scripts/general-sync.sh          # full sync
BOSSMAN=<redacted> ./scripts/general-sync.sh --step4  # conflicts only (-4 also works)
```

<details>
<summary>Few commands to keep things running</summary>

```sh
jq 'walk(if type == "object" then to_entries | sort_by(.key) | from_entries elif type == "array" then sort else . end)' ~/.claude/settings.json | sponge ~/.claude/settings.json

chmod +x ~/.claude/hooks/cmux-notify.sh

```

</details>

![images/Screenshot_2026-02-22_at_1.07.54 PM.png](images/Screenshot_2026-02-22_at_1.07.54 PM.png)

## Note: Linux

I used Linux (ubuntu, arch linux) until July 2020, before migrating to Mac. Config files for linux are available on the [linux branch](https://github.com/kaustubhhiware/dotfiles/tree/linux)
![images/Screenshot_2020-07-26_17-11-59.png](images/Screenshot_2020-07-26_17-11-59.png)

## License

The MIT License (MIT) 2017 - [Kaustubh Hiware](https://github.com/kaustubhhiware). Please have a look at the [LICENSE.md](LICENSE.md) for more details.

This repo contains claude skills, plugins that are already open-sourced. Although this repo uses the MIT License, please follow the required licenses specified by specific skill's LICENSES.
