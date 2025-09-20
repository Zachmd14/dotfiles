(setq inhibit-startup-message t)

(setq initial-scratch-message
      "; Welcome to Emacs.
; Use 'C-x C-f' to open a file.")

(add-to-list 'load-path "~/.config/emacs/site-lisp/emacs-application-framework/")
(require 'eaf)
(require 'eaf-pdf-viewer)
(require 'eaf-file-manager)

(global-disable-mouse-mode t)

(use-package emacs
  :bind ("C-c h" . comment-line))

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)


;; set up the visible bell
(setq visible-bell t)

(set-face-attribute 'default nil :font "Fira Code")
(set-fontset-font "fontset-default" 'unicode "Noto Color Emoji" nil 'prepend)
(set-fontset-font "fontset-default" 'symbol "Noto Color Emoji" nil 'prepend)
(set-fontset-font "fontset-default" 'emoji "Noto Color Emoji" nil 'prepend)

;; Then configure fontset
(setq inhibit-compacting-font-caches t) ; Prevent font cache issues

;; Forcer l'encodage UTF-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))

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
  :ensure t
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; for treemacs users
  (doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  :config
  ;; Load the default theme (black)
  (load-theme 'doom-homage-black t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; Define functions to switch between themes
(defun switch-to-doom-homage-white ()
  "Switch to doom-homage-white theme."
  (interactive)
  (disable-theme 'doom-homage-black)
  (load-theme 'doom-homage-white t))

(defun switch-to-doom-homage-black ()
  "Switch to doom-homage-black theme."
  (interactive)
  (disable-theme 'doom-homage-white)
  (load-theme 'doom-homage-black t))

;; Optional: Keybindings for quick switching
(global-set-key (kbd "C-c t w") 'switch-to-doom-homage-white)
(global-set-key (kbd "C-c t b") 'switch-to-doom-homage-black)


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
(add-hook 'vterm-mode-hook
          (lambda ()
            (display-line-numbers-mode -1)  ; Disable line numbers
            (setq display-line-numbers nil))) ; Ensure they stay off

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

(defhydra hydra-org-latex (:color blue :hint nil)
  ("p" org-latex-preview "toggle all previews")
  ("c" org-clear-latex-preview "clear previews")
  ("r" (org-latex-preview t "regenerate preview"))
  ("q" nil "finished" :exit t))

(define-key obsidian-mode-map (kbd "C-c M-o") 'obsidian-hydra/body)

(defhydra hydra-windows-nav (:color red)
  ("s" shrink-window-horizontally "shrink horizontally" :column "Sizing")
  ("e" enlarge-window-horizontally "enlarge horizontally")
  ("S" shrink-window "shrink vertically")
  ("E" enlarge-window "enlarge vertically")
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
    "tt" '(vterm-mode :which-key "vterm")
    "td" '(deepseek-query :which-key "deepseek")
    "tu" '(vundo :which-key "undo graph")
    "tr" (list (lambda () (interactive)
                 (split-window-right)
                 (other-window 1)
                 (vterm))
               :which-key "open vterm to the right")
    "ts" '(hydra-text-scale/body :which-key "scale text")
    "tf" '(format-all-buffer :which-key "format buffer")
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
(yas-global-mode 1)


;; (use-package auto-complete)
;; (global-auto-complete-mode t)

(use-package surround
  :ensure t
  :bind-keymap ("C-c s" . surround-keymap))

(use-package vundo)

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((html-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration)
         (lsp-mode . lsp-headerline-breadcrumb-mode))
  :commands lsp
  :config
  ;; Disable icons and set segments
  (setq lsp-headerline-breadcrumb-icons-enable nil)
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols)))

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
  (setq lsp-eldoc-render-all t)
  ;; (add-to-list 'lsp-language-id-configuration '(web-mode . "html"))
  )
(use-package lsp-ui)

;; (use-package auto-complete)
;; ;; Add more languages as needed

(use-package org)
(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode -1)))
(add-hook 'find-file-hook
          (lambda ()
            (when (string-equal (buffer-file-name) "~/Documents/orgmode/anki.org")
              (anki-editor-mode 1))))
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
     (?- . "•")
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
(use-package org-roam-ui)
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
         ("C-c n v" . org-view-mode)
         ("C-c n u" . org-roam-ui-open)
         ("C-c n l" . hydra-org-latex/body)
         ("C-c n o" . org-overview)
         ("C-c n I" . org-indent-mode)
         ("C-c n p" . org-paste-image-from-clipboard)
         ("C-c n n" . org-num-mode)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(use-package deepseek
  :load-path "/home/zach/.config/emacs/lisp/deepseek.el")
(require 'deepseek)

(use-package org-modern-indent
  :load-path "/home/zach/.config/emacs/lisp/org-modern-indent"
					; or
					; :straight (org-modern-indent :type git :host github :repo "jdtsmith/org-modern-indent"))
  :config ; add late to hook
  (add-hook 'org-mode-hook #'org-modern-indent-mode 90))

(setq org-startup-indented t)

(setq org-roam-completion-everywhere t)
;; Enable auto-complete for org-mode and org-roam buffers
(add-hook 'org-mode-hook
          (lambda ()
            (when (derived-mode-p 'org-mode)
              ;; (auto-complete-mode 1)
	      )))

(use-package consult-org-roam)
(add-hook 'org-mode-hook 'olivetti-mode)
(add-hook 'org-mode-hook 'org-indent-mode)
;; Company mode configuration
(use-package company
  :ensure t
  :config
  (global-company-mode 1)

  ;; Settings
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1
        company-show-numbers nil
        company-tooltip-limit 10
        company-selection-wrap-around t
        company-require-match nil
        company-dabbrev-downcase nil
        company-dabbrev-ignore-case t
        company-dabbrev-code-other-buffers t)

  ;; Key bindings
  (define-key company-active-map (kbd "TAB") 'company-complete-selection)
  (define-key company-active-map (kbd "<tab>") 'company-complete-selection)
  (define-key company-active-map (kbd "C-j") 'company-select-next)
  (define-key company-active-map (kbd "C-k") 'company-select-previous)
  )

;; Enable global company mode
(setq-default global-company-mode 1)

;; Enable company mode in programming modes
(add-hook 'prog-mode-hook 'company-mode)

;; Set default company backends
;; (setq-default company-backends '((company-capf :with company-yasnippet)
;;                                  (company-files :with company-yasnippet)
;;                                  company-dabbrev))

(setq-default company-backends
      '((company-capf :with company-yasnippet)
        (company-files :with company-yasnippet)
        company-dabbrev
        company-keywords
        company-etags
        company-dabbrev-code))

;; Configure LSP mode settings
(with-eval-after-load 'lsp-mode
  ;; Enable yasnippet globally
  (yas-global-mode 1)

  ;; Disable LSP's built-in completion (use company instead)
  (setq lsp-completion-provider :none)

  ;; Set company backends for LSP-managed buffers
  (add-hook 'lsp-managed-mode-hook
            (lambda ()
              (setq-local company-backends '((company-capf :with company-yasnippet)))))

  ;; Additional completion configuration for LSP
  (add-hook 'lsp-completion-mode-hook
            (lambda ()
              (setq-local company-backends '((company-capf :with company-yasnippet)
                                             (company-files :with company-yasnippet))))))

(setq lsp-completion-provider :none) ;; disable lsp-mode injecting capf



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
(setq org-preview-latex-remove-previous-images nil)

;; (setq org-preview-latex-image-directory
;;       (concat temporary-file-directory "ltximg/"))

(use-package format-all
  :preface
  (defun ian/format-code ()
    "Auto-format whole buffer."
    (interactive)
    (if (derived-mode-p 'prolog-mode)
        (prolog-indent-buffer)
      (format-all-buffer)))
  :config
  (global-set-key (kbd "M-F") #'ian/format-code)
  (add-hook 'prog-mode-hook #'format-all-ensure-formatter))

(defun my/vterm-new-unique ()
  "Create a new vterm buffer with a unique name."
  (interactive)
  (let ((buffer (generate-new-buffer "*vterm*")))
    (with-current-buffer buffer
      (vterm-mode))
    (switch-to-buffer buffer)))

;; (defun my/vterm-new-unique-frame ()
;;   "Create a new frame with a unique vterm buffer."
;;   (interactive)
;;   (select-frame (make-frame))
;;   (my/vterm-new-unique))

;; Add to your init.el
(use-package ox-hugo
  :ensure t
  :after ox)

;; Configure for Obsidian
(setq org-hugo-base-dir "/home/zach/Documents/Obsidian/uniVault/") ; Change to your vault path
(setq org-hugo-auto-set-lastmod t)


(defun org-export-to-markdown-on-save ()
  "Export current buffer to markdown if it's an org file."
  (when (and (eq major-mode 'org-mode)
             (buffer-file-name)
             (string= (file-name-extension (buffer-file-name)) "org"))
    (let* ((export-dir "~/Documents/Obsidian/uniVault/")  ; Your custom directory
           (base-name (file-name-base (buffer-file-name)))
           (md-file (concat export-dir base-name ".md")))
      ;; Create directory if it doesn't exist
      (unless (file-directory-p export-dir)
        (make-directory export-dir t))
      ;; Use the newer export function with proper arguments
      (org-md-export-to-markdown)
      ;; Move the exported file to the desired location
      (let ((default-md-file (concat (file-name-sans-extension (buffer-file-name)) ".md")))
        (when (file-exists-p default-md-file)
          (rename-file default-md-file md-file t)
          (message "Exported to %s" md-file))))))

;; Add hook to save org files
;; (add-hook 'after-save-hook 'org-export-to-markdown-on-save)

(defun org-paste-image-from-clipboard ()
  "Paste image from clipboard into org buffer and create file link."
  (interactive)
  (let* ((image-dir "~/Documents/Emacs/org-roam/images")  ; Change this to your desired directory
         (filename (format-time-string "image-%Y%m%d-%H%M%S.png"))
         (full-path (expand-file-name filename image-dir)))
    
    ;; Create directory if it doesn't exist
    (unless (file-exists-p image-dir)
      (make-directory image-dir t))
    
    ;; Save clipboard image to file
    (if (and (eq system-type 'gnu/linux)
             (executable-find "xclip"))
        (shell-command (format "xclip -selection clipboard -t image/png -o > %s" full-path))
      (message "Image paste only supported on Linux with xclip"))
    
    ;; Insert org link if file was created
    (when (file-exists-p full-path)
      (insert (format "[[file:%s]]" full-path)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anki-editor-latex-style 'mathjax)
 '(custom-safe-themes
   '("6963de2ec3f8313bb95505f96bf0cf2025e7b07cefdb93e3d2e348720d401425"
     default))
 '(helm-minibuffer-history-key "M-p")
 '(indent-guide-threshold 1)
 '(lsp-headerline-breadcrumb-segments '(path-up-to-project file project) t)
 '(olivetti-body-width 92)
 '(org-export-with-toc nil)
 '(org-format-latex-options
   '(:foreground default :background default :scale 1.6 :html-foreground
		 "Black" :html-background "Transparent" :html-scale
		 1.0 :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))
 '(org-hugo-section "/")
 '(org-modern-block-fringe t)
 '(org-modern-block-name '("‣ " . "‣ "))
 '(org-modern-star 'fold)
 '(org-roam-ui-browser-function 'browse-url)
 '(org-startup-with-latex-preview t)
 '(package-selected-packages
   '(aggressive-indent all-the-icons-dired anki-editor browse-kill-ring
		       comment-tags company company-lsp
		       consult-org-roam counsel dap-mode doom-modeline
		       doom-themes evil-collection flex-autopair
		       format-all general helm-lsp helpful
		       indent-guide ivy-rich ligature lsp-ivy lsp-ui
		       magit obsidian olivetti org org-anki
		       org-bullets org-fragtog org-md-export
		       org-modern org-roam-ui org-super-agenda
		       org-view-mode ox-hugo page-break-lines
		       projectile surround vterm vundo xenops
		       yasnippet-snippets))
 '(package-vc-selected-packages
   '((reader :url "https://codeberg.org/divyaranjan/emacs-reader" :make
	     "all"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-headerline-breadcrumb-path-face ((t (:inherit font-lock-string-face :family "Fira Code")))))
