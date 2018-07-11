# choco_interactive
Chocolatey as an interactive "shell" via a simple cmd wrapper.

Inspired by ConEmu's default Chocolatey task (at least when installed via Chocolatey),
I thought about running the app in its own ConEmu tab as if its own shell. Chocolatey
doesn't have a built-in interactive mode that would do that, so a simple looping
batch file should do the trick. The root "choco" command is automatically prefixed to
any actual commands you might want to pass to Chocolatey. Special commands "help"
and "exit" were added as aliases to "choco -?" and exiting the loop, respectively.

To run a standalone looking Chocolatey instance, you might want to use a command line
not far off from this:
```cmd
cmd.exe /C title Chocolatey & choco.exe & A:\Path\to\choco_interactive.cmd
```

As a ConEmu startup task, prefixing that with an `*` will run it as an administrator.

If you use TCC/LE as your default shell, you might be familiar with problems in user
account elevation. To avoid accidentally running doomed-to-fail installation jobs as
a regular user in the default shell, I came up with this ConEmu specific TCC/LE alias
that runs innocent jobs like "choco -?" and "choco list" in the current shell but
anything serious like installs and upgrades will be passed to an elevated cmd.exe tab
with this wrapper. So if that sounds like something you'd be into, put this in your
`tcalias.lst` or wherever you might define you TCC/LE aliases:
```cmd
choco=@IFF %# == 0 .OR. %1 == -? .OR. %1 == list THEN & choco.exe %$ & ELSE ConEmu64 -single -run cmd.exe /C "title Chocolatey & choco.exe %$ & A:\Path\to\choco_interactive.cmd" -new_console:a & ENDIFF
```
