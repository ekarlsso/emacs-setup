;; Simple emacs init.el file that I use when working with clojure
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; Install part
(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      starter-kit-eshell
                      clojure-mode
                      clojure-test-mode
                      nrepl
                      rainbow-delimiters
                      auto-complete
                      ac-nrepl
                      popup
                      color-theme-solarized))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))


;; Keyboard setup
(setq default-input-method "MacOSX")
(setq mac-command-modifier 'meta
      mac-option-modifier nil
      mac-allow-anti-aliasing t
      mac-command-key-is-meta t)

;; Kill that bell
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;; Rainbow delimeters
(global-rainbow-delimiters-mode)

;; paredit
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'paredit-mode)
(global-set-key [f7] 'paredit-mode)

;; nREPL
(global-set-key [f9] 'nrepl-jack-in)
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(setq nrepl-popup-stacktraces nil)
(add-to-list 'same-window-buffer-names "*nrepl*")
(add-hook 'nrepl-mode-hook 'paredit-mode)

;; Auto complete
(require 'auto-complete-config)
(ac-config-default)
(define-key ac-completing-map "\M-/" 'ac-stop) ; use M-/ to stop completion

;; ac-nrepl
(require 'ac-nrepl)
(add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
(add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'nrepl-mode))

;; Theme
(load-theme 'solarized-dark t)

;; Linenumbers on
(global-linum-mode t)
