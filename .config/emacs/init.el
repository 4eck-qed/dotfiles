;; -*- lexical-binding: t; outline-regexp: ";;;"; eval: (local-set-key (kbd "C-c i") #'consult-outline); -*-

(require 'package)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)


;;; load packages

;;; lsp
(use-package lsp-mode
  :ensure t
  :bind (:map lsp-mode-map
	      ("C-c d" . lsp-describe-thing-at-point)
	      ("C-c a" . lsp-execute-code-action))
  :bind-keymap ("C-c l" . lsp-command-map)
  :config
  (lsp-enable-which-key-integration t))

;;; rust
(use-package rust-mode
  :ensure t
  :hook ((rust-mode . flycheck-mode)
	 (rust-mode . lsp-deferred))
  :bind (("<f6>" . my/rust-format-buffer))
  :config
  (require 'rust-rustfmt)
  (defun my/rust-format-buffer ()
    (interactive)
    (rust-format-buffer)
    (save-buffer))
  (require 'lsp-rust)
  (setq lsp-rust-analyzer-completion-add-call-parenthesis nil
	lsp-rust-analyzer-proc-macro-enable t)
  (cl-defmethod lsp-clients-extract-signature-on-hover
    (contents (_server-id (eql rust-analyzer)))
    "from https://github.com/emacs-lsp/lsp-mode/pull/1740 to extract signature in rust"
    (-let* (((&hash "value") contents)
	    (groups (--partition-by (s-blank? it) (s-lines (s-trim value))))
	    (sig_group (if (s-equals? "```rust" (car (-third-item groups)))
			   (-third-item groups)
			 (car groups)))
	    (sig (--> sig_group
		      (--drop-while (s-equals? "```rust" it) it)
		      (--take-while (not (s-equals? "```" it)) it)
		      (--map (s-trim it) it)
		      (s-join " " it))))
	   (lsp--render-element (concat "```rust\n" sig "\n```")))))
	   
;;; Go
(use-package go-mode
  :ensure t
  :hook ((go-mode . lsp-deferred)
	 (go-mode . company-mode))
  :bind (:map go-mode-map
	      ("<f6>"  . gofmt)
	      ("C-c 6" . gofmt))
  :config
  (require 'lsp-go)
  ;; https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
  (setq lsp-go-analyses
	'((fieldalignment . t)
	  (nilness        . t)
	  (unusedwrite    . t)
	  (unusedparams   . t)))
  ;; GOPATH/bin
  (add-to-list 'exec-path "~/go/bin")
  (setq gofmt-command "goimports"))

(global-set-key (kbd "<f5>") #'recompile)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file t)

(setq auto-save-file-name-transforms
      '((".*" "~/.emacs.d/auto-save-list/" t))
      backup-directory-alist
      '(("." . "~/.emacs.d/backups")))

(set-face-attribute 'region nil :background "deep sky blue")
(set-face-attribute 'default nil :height 140)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(put 'narrow-to-region 'disabled nil)

;;; load config
(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))
