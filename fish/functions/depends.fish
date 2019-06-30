function depends -d 'Check for dependencies with pacman'
    pacman -Si $args|sed -n '/Depends\ On/,/:/p'|sed '$d'|cut -d: -f2
end
