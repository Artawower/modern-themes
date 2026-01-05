(modern-generate-theme
 :name "gruvbox-material"
 :variant 'dark
 :path "./"
 :description "Modern Gruvbox Material theme port."
 :palette
 '( bg-main  "#292828"
    bg-dim   "#383432"
    bg-alt   "#383432"
    bg-active (darken bg-main 20)
    fg-main  "#D4BE98"
    fg-dim   "#7C6F64"
    fg-alt   "#CCB692"
    cursor   "#7aa2f7"
    red      "#EA6962"
    green    "#A8B665"
    orange   "#E78A4F"
    yellow   "#D8A658"
    blue     "#7DAEA3"
    magenta  "#D3859B"
    cyan     "#89B482")
 :syntax
 '( fnname orange
    keyword red
    type blue
    variable fg-main))


(modern-generate-theme
 :name "spacegray"
 :variant 'dark
 :path "./"
 :description "Modern Gruvbox Material theme port."
 :palette
 '( bg-main  "#2B303B"
    bg-dim   (darken bg-main 10)
    bg-alt   (darken bg-main 10)
    bg-active (lighten bg-main 5)
    fg-main  "#B7BBB7"
    fg-dim   "#636574"
    fg-alt   (darken fg-main 25)
    cursor   "#D18770"
    red      "#D18770"
    green    "#A3BE8C"
    yellow   "#E2995C"
    blue     "#8FA1B3"
    magenta  "#A57FA3"
    cyan     "#527C77")
 :syntax
 '( fnname orange
    keyword red
    builtin red
    variable fg-main))


(modern-generate-theme
 :name "spacegray-light"
 :variant 'dark
 :path "./"
 :description "Modern Gruvbox Material theme port."
 :palette
 '( bg-main  "#2B303B"
    bg-dim   (darken bg-main 10)
    bg-alt   (darken bg-main 10)
    bg-active (lighten bg-main 5)
    fg-main  "#B7BBB7"
    fg-dim   "#636574"
    fg-alt   (darken fg-main 25)
    cursor   "#D18770"
    red      "#D18770"
    green    "#A3BE8C"
    yellow   "#E2995C"
    blue     "#8FA1B3"
    magenta  "#8D6494"
    cyan     "#527C77")
 :syntax
 '( fnname orange
    keyword red
    builtin red
    variable fg-main))

(modern-generate-theme
 :name "spacegray-light"
 :variant 'light
 :path "./"
 :description "Modern Spacegray Light theme port."
 :palette
 '( bg-main   "#F2F2F2"
    bg-dim    (darken bg-main 6)
    bg-alt    (darken bg-main 10)
    bg-active (darken bg-main 14)

    fg-main   "#2D2D2D"
    fg-dim    "#6B6B6B"
    fg-alt    (lighten fg-main 20)

    cursor    "#4A90E2"

    red       "#D75F5F"
    green     "#5FAF5F"
    yellow    "#D7AF5F"
    blue      "#4A90E2"
    magenta   "#AF5FD7"
    cyan      "#5FAFAF")

 :syntax
 '( fnname blue
    keyword magenta
    builtin red
    variable fg-main))


(modern-generate-theme
 :name "nano-dark"
 :variant 'dark
 :path "./"
 :description "Modern Nano Dark theme port."
 :palette
 '( bg-main  "#2E3440"
    bg-dim   "#242832"
    bg-alt   "#242832"
    bg-active "#434C5D"
    fg-main  "#ECEFF4"
    fg-dim   "#677691"
    fg-alt   "#677691"
    cursor   "#ECEFF4"
    red      "#D08770"
    green    "#A3BE8C"
    orange   "#FF6F00"
    yellow   "#EBCB8B"
    blue     "#81A1C1"
    magenta  "#B48EAD"
    cyan     "#88C0D0")
 :syntax
 '( fnname fg-main
    keyword blue-cooler
    property fg-main
    type blue-cooler
    variable fg-main
    constant fg-main
    rainbow-0 fg-main
    rainbow-1 fg-main
    rainbow-2 fg-main
    rainbow-3 fg-main
    rainbow-4 fg-main
    rainbow-5 fg-main
    rainbow-6 fg-main
    rainbow-7 fg-main
    rainbow-8 fg-main))
