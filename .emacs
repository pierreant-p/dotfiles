(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#708183" "#c60007" "#728a05" "#a57705" "#2075c7" "#c61b6e" "#259185" "#042028"))
 '(background-color "#002b36")
 '(background-mode dark)
 '(blink-cursor-mode nil)
 '(cursor-color "#839496")
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default)))
 '(fci-rule-color "#0a2832")
 '(foreground-color "#839496")
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#c60007")
     (40 . "#bd3612")
     (60 . "#a57705")
     (80 . "#728a05")
     (100 . "#259185")
     (120 . "#2075c7")
     (140 . "#c61b6e")
     (160 . "#5859b7")
     (180 . "#c60007")
     (200 . "#bd3612")
     (220 . "#a57705")
     (240 . "#728a05")
     (260 . "#259185")
     (280 . "#2075c7")
     (300 . "#c61b6e")
     (320 . "#5859b7")
     (340 . "#c60007")
     (360 . "#bd3612"))))
 '(vc-annotate-very-old-color nil t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:background "#0a2832" :foreground "windowFrameColor")))))

;; Package manager
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

;; Font settings
(when (window-system)
  (set-frame-font "Source Code Pro")
  (set-face-attribute 'default nil :font "Source Code Pro" :height 120)
  (set-face-font 'default "Source Code Pro"))

;; Autocomplete buffer
(require 'ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)

;; projectile
(projectile-global-mode)

;; python
(require 'python)
(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args ""
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
 "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
 "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
 "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

;; jedi (python auto-completion)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;; Save temporary files in temp folder
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Mac command key modifiers
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)


;; Show line number
(global-linum-mode 1)

;; Highlight current line
(global-hl-line-mode 1)

;; Syntax highlighting
(global-font-lock-mode 1)

;; set tabs width to 4
(setq tab-width 4)
(setq sgml-basic-offset 4) ;; html-mode

;; git-gutter+
(require 'git-gutter-fringe+)
(global-git-gutter+-mode t)
(eval-after-load 'git-gutter+
  '(progn
     ;;; Jump between hunks
     (define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
     (define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)

     ;;; Act on hunks
     (define-key git-gutter+-mode-map (kbd "C-x v =") 'git-gutter+-show-hunk)
     (define-key git-gutter+-mode-map (kbd "C-x r") 'git-gutter+-revert-hunks)
     ;; Stage hunk at point.
     ;; If region is active, stage all hunk lines within the region.
     (define-key git-gutter+-mode-map (kbd "C-x t") 'git-gutter+-stage-hunks)
     (define-key git-gutter+-mode-map (kbd "C-x c") 'git-gutter+-commit)
     (define-key git-gutter+-mode-map (kbd "C-x C") 'git-gutter+-stage-and-commit)))

;; Never use tabs
(setq-default indent-tabs-mode nil)

;; show white spaces
(require 'ethan-wspace)
(global-ethan-wspace-mode 1)
(ethan-wspace-highlight-eol-mode)

;; flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-flake8rc '"~/dev/sketchfab/src/dev/tox.ini")

;; jinja2-mode
(require 'jinja2-mode)
;; add .jinja to auto-mode list
(add-to-list 'auto-mode-alist '("\\.jinja\\'" . jinja2-mode))

;; scss-mode
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; magit
(setq magit-emacsclient-executable "/usr/local/bin/emacsclient")

;; tramp
(setq explicit-shell-file-name "/bin/bash")

;; disable require new line
(add-hook 'prog-mode-hook
          (lambda ()
            (setq require-final-newline nil)
            (setq mode-require-final-newline nil)))

;; escreen
(require 'escreen)
(escreen-install)

;; jsbeautify
(require 'web-beautify) ;; Not necessary if using ELPA package
(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))
(eval-after-load 'json-mode
  '(define-key json-mode-map (kbd "C-c b") 'web-beautify-js))
(eval-after-load 'sgml-mode
  '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))
(eval-after-load 'css-mode
  '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))

;; autopep8
(require 'py-autopep8)
(setq py-autopep8-options '("--max-line-length=119"))

;; multiple cursor
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; key bindings
(global-set-key "\M-[" 'previous-error)
(global-set-key "\M-]" 'goto-next-locus)

(global-unset-key "\M-i")
(global-unset-key "\M-o")
(global-set-key "\M-o" 'other-window)
(global-set-key "\M-i" (lambda () (interactive) (other-window -1) ))

(global-set-key [M-backspace] 'backward-kill-word)

;; disable column split
(setq split-height-threshold nil split-width-threshold nil)

;; don't compile scss on save
(setq scss-compile-at-save nil)

;; desktop save
(desktop-save-mode 1)

;; rainbow identifiers
(require 'rainbow-identifiers)
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)
(setq rainbow-identifiers-choose-face-function 'rainbow-identifiers-cie-l*a*b*-choose-face)
