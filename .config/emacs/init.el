(setq inhibit-startup-message t)

(setq initial-scratch-message
      "; Welcome to Emacs.
; Use 'C-x C-f' to open a file.")

;; (add-to-list 'load-path "~/.config/emacs/site-lisp/emacs-application-framework/")
;; (require 'eaf)

(use-package emacs
  :bind ("C-c h" . comment-line))

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

;; set up the visible bell
(setq visible-bell t)

(set-face-attribute 'default nil :font "Fira Code")

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package counsel
  :bind (("C-M-j" . 'counsel-switch-buffer)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package doom-themes
  :init (load-theme 'doom-homage-black t))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))


(use-package obsidian
  :config
  ;; Location of obsidian vault
  (setq obsidian-directory "/home/zach/Documents/Obsidian/uniVault/")
  ;; Default location for new notes from `obsidian-capture'
  (setq obsidian-inbox-directory "")
  ;; Useful if you're going to be using wiki links
  (setq markdown-enable-wiki-links t)
  (setq obsidian-daily-notes-directory "1. Daily Notes")
  (setq obsidian-templates-directory "99. Templates")
  (setq obsidian-daily-note-template "daily notes template.md")
  ;(setq obsidian)
  (obsidian-mode 1))
  
  ;; Keybindings
  ;(define-key obsidian-mode-map (kbd "C-c C-n") 'obsidian-capture)
  ;(define-key obsidian-mode-map (kbd "C-c C-l") 'obsidian-insert-link)
  ;(define-key obsidian-mode-map (kbd "C-c C-o") 'obsidian-follow-link-at-point)
  ;(define-key obsidian-mode-map (kbd "C-c C-p") 'obsidian-jump)
  ;(define-key obsidian-mode-map (kbd "C-c C-b") 'obsidian-backlink-jump))

(column-number-mode)
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode +1)

(use-package vterm)

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.5))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package hydra
  :defer t)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(define-key obsidian-mode-map (kbd "C-c M-o") 'obsidian-hydra/body)

(defhydra hydra-windows-nav (:color red)
    ("s" shrink-window-horizontally "shrink horizontally" :column "Sizing")
    ("e" enlarge-window-horizontally "enlarge horizontally")
    ("b" balance-windows "balance window height")
    ("m" maximize-window "maximize current window")
    ("M" minimize-window "minimize current window")
    
    ("H" split-window-below "split horizontally" :column "Split management")
    ("v" split-window-right "split vertically")
    ("d" delete-window "delete current window")
    ("x" delete-other-windows "delete-other-windows")

    ("z" ace-window "ace window" :color blue :column "Navigation")
    ("h" windmove-left "← window")
    ("j" windmove-down "↓ window")
    ("k" windmove-up "↑ window")
    ("l" windmove-right "→ window")
    ("r" toggle-window-split "rotate windows")
    ("q" nil "quit menu" :color blue :column nil))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package general
  :after evil
  :config
  ;; Unbind C-SPC from set-mark-command first
  (global-unset-key (kbd "C-SPC"))

  (general-create-definer zach/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (zach/leader-keys
    "f"  '(:ignore t :which-key "files")
    "t"  '(:ignore t :which-key "toggle")
    "w"  '(:ignore t :which-key "window")
    "o"  '(:ignore t :which-key "obsidian")
    "a"  '(:ignore t :which-key "anki")
    "ac"  '(:ignore t :which-key "anki cloze actions")
    "fp" (list (lambda () (interactive)
               (counsel-find-file "~/.config/emacs/"))
               :which-key "find file in config")
    "ai" '(anki-editor-insert-note :which-key "insert note")
    "ap" '(anki-editor-push-new-notes :which-key "push note")
    "aa" '(anki-editor-gui-browse :which-key "browse gui")
    "ao" '(lambda () (interactive) (counsel-find-file "~/Documents/orgmode/anki.org") :which-key "browse gui")
    "aci" '(anki-editor-cloze-region-auto-incr :which-key "cloze region incr")
    "acr" '(anki-editor-reset-cloze-number :which-key "cloze region reset number")
    "acd" '(anki-editor-cloze-region-dont-incr :which-key "cloze region incr")
    "tt" '(vterm :which-key "vterm")
    "tu" '(vundo :which-key "undo graph")
    "tr" (list (lambda () (interactive)
                 (split-window-right)
                 (other-window 1)
                 (vterm))
               :which-key "open vterm to the right")
    "ts" '(hydra-text-scale/body :which-key "scale text")
    "tl" '(display-line-numbers-mode :which-key "display lines number")
    "ty" '(counsel-yank-pop :which-key "browse kill-ring")
    "wn" '(hydra-windows-nav/body :which-key "windows navigation")
    "oo" '(obsidian-jump :which-key "open note")
    "oj" '(obsidian-jump-back :which-key "jump back to previous note")
    "ot" '(obsidian-insert-tag :which-key "insert tag")
    "or" '(obsidian-rescan-cache :which-key "rescan cache for notes")
    "ol" '(obsidian-insert-link :which-key "insert link")
    "od" '(obsidian-daily-note :which-key "open daily note")
    "oc" '(obsidian-capture :which-key "capture note")
    "ob" '(obsidian-toggle-backlinks-panel :which-key "toggle backlinks panel")))


(use-package flex-autopair)
(use-package page-break-lines)
(use-package projectile)
(use-package nerd-icons)

;; (use-package auto-complete)
;; (global-auto-complete-mode t)

(use-package surround
  :ensure t
  :bind-keymap ("C-c s" . surround-keymap))

(use-package vundo)

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (hml-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
    :config
    (which-key-mode)
    (add-to-list 'lsp-language-id-configuration '(web-mode . "html")))

;; Start lsp when you open a file for each langauge
(add-hook 'python-mode-hook #'lsp)
(add-hook 'go-mode-hook     #'lsp)
(add-hook 'html-mode-hook     #'lsp)
(add-hook 'c-mode-hook #'lsp)
;; Add more languages as needed

(use-package org)
(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode -1)))
(add-hook 'org-mode-hook #'anki-editor-mode)
(setq org-num-skip-unnumbered t)  ; Skip unnumbered headings
(setq org-num-max-level 8)        ; Number up to 8 levels
(add-hook 'org-mode-hook 'org-num-mode)

;; Alternatively, use org-modern for better list styling
(use-package org-modern
  :ensure t
  :custom
  (org-modern-hide-stars nil)		; adds extra indentation
  (org-modern-table nil)
  (org-modern-list 
   '(;; (?- . "-")
     (?* . "•")
     (?+ . "‣")))
  :hook
  (org-mode . org-modern-mode)
  (org-agenda-finalize . org-modern-agenda))
(add-hook 'org-mode-hook #'org-modern-mode)

(dolist (face '(window-divider
                window-divider-first-pixel
                window-divider-last-pixel))
  (face-spec-reset-face face)
  (set-face-foreground face (face-attribute 'default :background)))
(set-face-background 'fringe (face-attribute 'default :background))

(setq org-hide-emphasis-markers t)
(setq org-image-actual-width '(0.5)) 
(use-package indent-guide)
(use-package aggressive-indent)

(use-package yasnippet
  :ensure t
  :hook ((text-mode
          prog-mode
          conf-mode
          snippet-mode) . yas-minor-mode-on)
  :init
  (setq yas-snippet-dir "~/.config/emacs/snippets")
  :bind
  ("C-c n s" . yas-insert-snippet))

(use-package recentf)
(global-set-key (kbd "C-x C-r") 'recentf-open)

(use-package browse-kill-ring)


(use-package anki-editor
  :after org
  :hook (org-capture-after-finalize . anki-editor-reset-cloze-number) ; Reset cloze-number after each capture.
  :config
  (setq anki-editor-create-decks t ;; Allow anki-editor to create a new deck if it doesn't exist
        anki-editor-org-tags-as-anki-tags t)

  (defun anki-editor-cloze-region-auto-incr (&optional arg)
    "Cloze region without hint and increase card number."
    (interactive)
    (anki-editor-cloze-region my-anki-editor-cloze-number "")
    (setq my-anki-editor-cloze-number (1+ my-anki-editor-cloze-number))
    (forward-sexp))
  (defun anki-editor-cloze-region-dont-incr (&optional arg)
    "Cloze region without hint using the previous card number."
    (interactive)
    (anki-editor-cloze-region (1- my-anki-editor-cloze-number) "")
    (forward-sexp))
  (defun anki-editor-reset-cloze-number (&optional arg)
    "Reset cloze number to ARG or 1"
    (interactive)
    (setq my-anki-editor-cloze-number (or arg 1)))
  (defun anki-editor-push-tree ()
    "Push all notes under a tree."
    (interactive)
    (anki-editor-push-notes '(4))
    (anki-editor-reset-cloze-number))
  ;; Initialize
  (anki-editor-reset-cloze-number)
  )

;;;;;;;;;;;;;;
;; ORG-ROAM ;;
;;;;;;;;;;;;;;
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "/home/zach/Documents/Emacs/org-roam"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ("C-c n t" . org-roam-tag-add)
         ("C-c n o" . org-overview)
         ("C-c n I" . org-indent-mode)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(use-package org-modern-indent
  :load-path "/home/zach/dotfiles/.config/emacs/lisp/org-modern-indent"
  :config ; add late to hook
  (add-hook 'org-mode-hook #'org-modern-indent-mode))

(setq org-startup-indented t)

;; (setq org-roam-completion-everywhere t)
;; ;; Enable auto-complete for org-mode and org-roam buffers
;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (when (derived-mode-p 'org-mode)
;;               (auto-complete-mode 1))))

(use-package consult-org-roam)
(add-hook 'org-mode-hook 'olivetti-mode)
(add-hook 'org-mode-hook 'org-indent-mode)

(use-package org-fragtog
:after org
:hook (org-mode . org-fragtog-mode) ; this auto-enables it when you enter an org-buffer, remove if you do not want this
:config
;; whatever you want
)

(with-eval-after-load 'org
  (add-to-list 'org-latex-packages-alist '("" "amsmath" t))
  (add-to-list 'org-latex-packages-alist '("" "amssymb" t))
  (add-to-list 'org-latex-packages-alist '("" "mathtools" t))
  (add-to-list 'org-latex-packages-alist '("" "mathrsfs" t))
  (add-to-list 'org-latex-packages-alist '("" "mhchem" t)))

(setq org-preview-latex-default-process 'dvipng)

(setq org-preview-latex-image-directory
      (concat temporary-file-directory "ltximg/"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anki-editor-latex-style 'mathjax)
 '(helm-minibuffer-history-key "M-p")
 '(indent-guide-threshold 1)
 '(olivetti-body-width 92)
 '(org-format-latex-options
   '(:foreground default :background default :scale 1.7 :html-foreground
		 "Black" :html-background "Transparent" :html-scale
		 1.0 :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-modern-block-fringe t)
 '(org-modern-block-name '("‣ " . "‣ "))
 '(org-startup-with-latex-preview t)
 '(package-selected-packages
   '(aggressive-indent all-the-icons-dired anki-editor auto-complete
		       browse-kill-ring comment-tags company
		       consult-org-roam counsel dap-mode doom-modeline
		       doom-themes evil-collection flex-autopair
		       general helm-lsp helpful indent-guide ivy-rich
		       ligature lsp-ivy lsp-ui magit obsidian olivetti
		       org org-anki org-bullets org-fragtog org-modern
		       org-super-agenda org-view-mode page-break-lines
		       projectile surround vterm vundo xenops
		       yasnippet-snippets)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
