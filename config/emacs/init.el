;; ENV
(setenv "PATH" (concat (getenv "PATH") ":/usr/bin"))  ;; Update with the actual path to git if needed
(setq exec-path (append exec-path '("/usr/bin")))  ;; Adjust based on your system

;; Bootstrap straight.el
(let ((bootstrap-file (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el")
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file t))

;; Use straight.el for package management
(setq straight-use-package-by-default t)
(straight-use-package 'use-package)
(setq use-package-always-ensure t)

;; Disable menu, tool, and scroll bars
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(ido-mode 1)
(ido-everywhere 1)
(indent-tabs-mode 0)

(setq make-backup-files nil) ;; ~
(setq auto-save-default nil) ;; #
(setq create-lockfiles nil) ;; #

(setq-default tab-width 4)
(setq-default standard-indent 4)
(setq-default indent-tabs-mode nil)
(setq-default tab-always-indent 'complete)

;; Line numbers and font
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(set-frame-font "Iosevka Nerd Font Mono 14" nil t)
;; (add-to-list 'default-frame-alist `(font . "Iosevka Nerd Font Mono-14"))

;; Use Smex stuff
(use-package smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Evil mode and Evil Collection
(use-package evil
  :init
  (setq evil-want-integration t) ;; Evil integration
  (setq evil-want-keybinding nil) ;; Control evil-collection
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(setq evil-undo-system 'undo-redo)
(setq evil-shift-width 4)
(evil-set-leader 'normal (kbd "SPC"))

;; C-c as ESC to exit insert/visual/replace modes
(define-key evil-insert-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-visual-state-map (kbd "C-c") 'evil-normal-state)
(define-key evil-replace-state-map (kbd "C-c") 'evil-normal-state)

(evil-define-key 'visual 'global (kbd "g c") 'comment-line)
(evil-define-key 'normal 'global (kbd "<leader> c c") 'compile)
(evil-define-key 'normal 'global (kbd "<leader> b s") 'list-buffers)
(evil-define-key 'normal 'global (kbd "<leader> d l") 'duplicate-line)

(evil-define-key 'normal 'global (kbd "C-j") 'drag-stuff-down)
(evil-define-key 'normal 'global (kbd "C-k") 'drag-stuff-up)
(evil-define-key 'visual 'global (kbd "C-j") 'drag-stuff-down)
(evil-define-key 'visual 'global (kbd "C-k") 'drag-stuff-up)

;; Everforest theme
(straight-use-package
 '(everforest :type git :host github :repo"Theory-of-Everything/everforest-emacs"))

(load-theme 'everforest-hard-dark t)

;; Magit

;; Install drag-stuff package
(use-package drag-stuff
  :straight t
  :config
  (drag-stuff-global-mode 1))

;; Highlight trailing whitespace in red
(setq-default show-trailing-whitespace t)

;; Set the face for trailing whitespace to be red
(set-face-attribute 'trailing-whitespace nil
                    :background "#E67E80"
                    :foreground nil)

;; If you want to enable this only in certain modes, you can use a hook:
;; (add-hook 'prog-mode-hook (lambda () (setq show-trailing-whitespace t)))
;; (add-hook 'text-mode-hook (lambda () (setq show-trailing-whitespace t)))

;; If you want to DISABLE it in certain modes:
(add-hook 'term-mode-hook (lambda () (setq show-trailing-whitespace nil)))
(add-hook 'comint-mode-hook (lambda () (setq show-trailing-whitespace nil)))
(add-hook 'eshell-mode-hook (lambda () (setq show-trailing-whitespace nil)))
(add-hook 'minibuffer-setup-hook (lambda () (setq show-trailing-whitespace nil)))
(add-hook 'minibuffer-setup-hook (lambda () (setq show-trailing-whitespace nil)))
(add-hook 'Buffer-menu-mode-hook (lambda () (setq show-trailing-whitespace nil)))
(add-hook 'ibuffer-mode-hook (lambda () (setq show-trailing-whitespace nil)))

;; Optional: Automatically clean trailing whitespace when saving files
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Custom set variables and faces
(custom-set-variables
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(evil evil-collection)))
(custom-set-faces)
