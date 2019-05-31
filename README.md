# agdaWithPackages

Some nix expressions for working with Agda and agda libraries

## Emacs Setup

### Nix-shell

If you run emacs from inside a nix-shell with agdaWithPackages, then emacs
should find your agda and the libraries it needs.

You should make loading agda-mode conditional if you want to use it from a
nix-shell. You can add something like the following to your ~/.emacs file. The
conditional is so emacs does throw an error if you are outside a nix-shell
and agda-mode cannot be found.

```
(if (executable-find "agda-mode")
  (load-file (let ((coding-system-for-read 'utf-8))
                  (shell-command-to-string "agda-mode locate")))
  (message "agda-mode not found"))
```

### Nixified emacs with Agda in the path

You can see an example here:

https://github.com/srdqty/nix-local-packages/blob/master/agda/default.nix

https://github.com/srdqty/nix-local-packages/blob/master/custom-emacs/default.nix

https://github.com/srdqty/nix-local-packages/blob/master/custom-emacs/default.el
