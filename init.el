;; run server if necessary and if called from emacsclient
(require 'server)
(unless (server-running-p) (server-start))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Add .emacs.d to path
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/custom_lisp")
(add-to-list 'load-path "~/.emacs.d/sollya-mode")
(load "inf-sollya.el")
(load "sollya.el")
(add-to-list 'load-path "~/.emacs.d/gappa-mode")
(load "gappa-mode.el")
(load "gappa-out.el")
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Early load of packages and add melpa
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize nil)
(setq package-enable-at-startup nil)

(defconst mohaminaj-packages
  '(
    ;; Color theme
    solarized-theme
    ;; UI improvements
    anzu                                ; Mode line indicators for isearch
    browse-kill-ring                    ; Kill ring browser
    smex                                ; Improved M-x
    ;; File handling
    hardhat                             ; Protect user-writable files
    launch                              ; Open files externally
    ;; Navigation tools
    ido-ubiquitous                      ; Use IDO everywhere
    imenu-anywhere                      ; imenu with IDO and for all buffers
    ido-vertical-mode                   ; Show IDO vertically
    ;ace-jump-mode                       ; Fast jump within the buffer
    ;; Editing indicators
    ;page-break-lines                    ; page breaks
    ;volatile-highlights                 ; certain editing operations,
    flycheck                            ; and syntax errors
    ;; Editing helpers
    ;whitespace-cleanup-mode             ; Cleanup whitespace on save
    ;undo-tree                           ; Undo reloaded
    ;adaptive-wrap                       ; Automatic wrap prefix
    ;expand-region                       ; Expand region by semantic units
    multiple-cursors                    ; Multiple cursors
    easy-kill                           ; Killing and marking on steroids
    ;; Search and replace
    ag                                  ; Code search
    wgrep wgrep-ag                      ; Edit ag results in-place
    visual-regexp                       ; Regexp reloaded
    ;; Completion and expansion
    company                             ; Auto completion
    ;; LaTeX/AUCTeX
    auctex                              ; The one and only LaTeX environment
    auctex-latexmk                      ; latexmk support for AUCTeX
    ;; Markup languages
    markdown-mode                       ; Markdown major mode
    graphviz-dot-mode                   ; Graphviz mode
    ;; Configuration languages
    puppet-mode                         ; For Puppet files
    ;; YAML
    yaml-mode                           ; YAML major mode
    ansible-doc                         ; Ansible documentation lookup
    ;; General programming utilities
    highlight-symbol                    ; Symbol awareness
    pcre2el                             ; Regular expression utilities
    highlight-numbers                   ; Syntax highlighting for numeric
					; literals
    rainbow-delimiters                  ; Color delimiters by level
    rainbow-mode                        ; Show colours as they are
    ;; Programming languages
    ;js2-mode                            ; Powerful Javascript mode
    ;feature-mode                        ; Cucumber major mode
    cmake-mode                          ; CMake files
    ;; Python
    anaconda-mode                       ; Documentation, lookup and navigation
    company-anaconda                    ; Company integration for Anaconda
    pip-requirements                    ; requirements.txt files
    ;; Ruby support
    inf-ruby                            ; Ruby interpreter in Emacs
    robe                                ; Code navigation, docs and completion
    ;; Rust
    ;rust-mode
    ;toml-mode                           ; For Cargo.toml
    ;flycheck-rust                       ; Better Rust support for Flycheck
    ;; Haskell support
    haskell-mode                        ; Haskell major modes
    ghci-completion                     ; Complete GHCI commands
    flycheck-haskell                    ; Improve Haskell syntax checking
    shm                                 ; Structured Haskell editing
    ;; OCaml support
    tuareg                              ; OCaml major mode
    merlin                              ; OCaml completion engine
    ;; Lisp tools
    paredit                            ; Balanced parenthesis editing
    ;; Emacs Lisp utility modes and libraries
    elisp-slime-nav                     ; Navigate to symbol definitions
    macrostep                           ; Interactively expand macros
    flycheck-cask                       ; Cask support for Flycheck
    ;; Clojure
    ;cider                               ; Clojure IDE
    ;clojure-mode-extra-font-locking
    ;; General Version Control
    diff-hl                             ; Highlight VCS diffs in the fringe
    ;; Git and Gist integration
    magit                               ; Git frontend
    git-commit-mode                     ; Git commit message mode
    gitconfig-mode                      ; Git configuration mode
    gitignore-mode                      ; .gitignore mode
    gitattributes-mode                  ; Git attributes mode
    git-rebase-mode                     ; Mode for git rebase -i
    git-timemachine                     ; Go back in (Git) time
    ;; Utilities
    google-this                         ; Google from Emacs
    paradox                             ; Better package menu
    use-package
    )
  "Packages needed by my configuration. Hijacked from lunaryon.")

;; (defun mohaminaj-ensure-packages ()
;;   "Install all required packages."
;;   (interactive)
;;   (unless package-archive-contents
;;     (package-refresh-contents))
;;   (dolist (package mohaminaj-packages)
;;     (unless (package-installed-p package)
;;       (package-install package))))

;; (mohaminaj-ensure-packages)

;; (defun mohaminaj-uniquify-list (l)
;;   (let ((res ()))
;;     (dolist (el l)
;;       (when (not (memq el res))
;; 	  (push el res)
;; 	  ))
;;     res))

;; (defun mohaminaj-sync-packages (file-path)
;;   (with-temp-buffer
;;     (find-file (concat user-emacs-directory file-path))
;;     (let* ((packs (ignore-errors (read (current-buffer))))
;; 	   (new (mohaminaj-uniquify-list (append packs package-activated-list)))
;; 	   )
;;       (progn
;; 	(dolist (p new)
;; 	  (unless (package-installed-p p)
;; 	    (package-install p)
;; 	    ))
;; 	(erase-buffer)
;; 	(insert (format "%S" (sort new #'(lambda (x y) (string< (symbol-name x) (symbol-name y))))))))
;;     (save-buffer)
;;     (kill-buffer)))

;; (mohaminaj-sync-packages "packs.el")

;;;;;;;;;;;;;;;;;;;
;; Personal info ;;
;;;;;;;;;;;;;;;;;;;
(setq user-full-name "Mohamed Amine Najahi"
      user-mail-address "mohaminaj@gmail.com")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Early loading of use-package ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-verbose t)
(require 'use-package)

;; (use-package auto-compile
;;   :ensure t
;;   :init (auto-compile-on-load-mode))
;; (setq load-prefer-newer t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Initialize helm	       ;;
;; config hijacked from sachac ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package helm
  :ensure t
  :diminish helm-mode
  :init
  (progn
    (require 'helm-config)
    (setq helm-candidate-number-limit 100)
    ;; From https://gist.github.com/antifuchs/9238468
    (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
          helm-input-idle-delay 0.01  ; this actually updates things
                                        ; reeeelatively quickly.
          helm-yas-display-key-on-candidate t
          helm-quick-update t
          helm-M-x-requires-pattern nil
          helm-ff-skip-boring-files t)
    (helm-mode))
  :bind (("C-c h" . helm-mini)
         ("C-h a" . helm-apropos)
         ("C-x C-b" . helm-buffers-list)
         ("C-x b" . helm-buffers-list)
         ("M-y" . helm-show-kill-ring)
         ("M-x" . helm-M-x)
	 ("C-x C-m" . helm-M-x)
         ("C-x c o" . helm-occur)
         ("C-x c s" . helm-swoop)
         ("C-x c y" . helm-yas-complete)
         ("C-x c Y" . helm-yas-create-snippet-on-region)
         ("C-x c b" . my/helm-do-grep-book-notes)
         ("C-x c SPC" . helm-all-mark-rings)))
(ido-mode -1) ;; Turn off ido mode in case I enabled it accidentally


(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x" "C-x r" "C-c" "C-x"))
(guide-key-mode 1) ; Enable guide-key-mode

;; (use-package powerline
;;     :config
;;   (setq powerline-display-buffer-size nil)
;;   (setq powerline-display-mule-info nil)
;;   (setq powerline-display-hud nil)
;;   (when (display-graphic-p)
;;     (powerline-default-theme)))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load global look of emacs
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "look.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load global configurations
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "global_configurations.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load my functions
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "my_functions.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; autoload_modes.el contains modes to autoload 
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "autoload_modes.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; header configuration
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "header_config.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; bbdb configuration
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "bbdb_config.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ERC configuration
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "erc_config.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auctex configuration
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "auctex_config.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode configuration
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "orgmode_config.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-journal configuration
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "journal.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; To handle accents in html and tex files
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "accents.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; eshell configuration
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "eshell_config.el")

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ac and spelling configuration
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "ac_spelling_config.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; keybindings.el contains keybindings
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "keybindings.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-save-query nil)
 '(TeX-view-program-selection
   (quote
    ((engine-omega "dvips and gv")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "Evince")
     (output-html "xdg-open"))))
 '(gnuserv-program "/usr/lib/xemacs-21.0/i386-pc-linux/gnuserv")
 '(inhibit-startup-screen t)
 '(virtualenv-root "/home/amine/Documents/tests/django/Firstblog/"))
;;;; --------------------- Printer options  ---------------------------
;;(setq lpr-switches '("-w80"))
(setq ps-printer-name "copieur_dali")
(setq ps-paper-type 'a4)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-sectioning-5-face ((((type tty pc) (class color) (background light)) (:foreground "cyan" :weight bold))))
 '(font-lock-function-name-face ((t (:foreground "color-21"))))
 '(gnus-cite-1 ((((class color) (background light)) (:foreground "cyan"))))
 '(hl-line ((t (:inherit highlight :background "#ffffff"))))
 '(message-header-subject ((((class color) (background light)) (:foreground "cyan" :weight bold))))
 '(message-header-to ((((class color) (background light)) (:foreground "cyan" :weight bold))))
 '(minibuffer-prompt ((t (:foreground "cyan"))))
 '(org-document-title ((t (:foreground "cyan" :weight bold))))
 '(show-paren-match ((((class color) (background light)) (:background "red"))))
 '(which-func ((t (:foreground "magenta" :underline nil)))))


