;;; init.el --- Perl 5 Emacs Configuration
;;; Commentary:
;;; A Perl 5 focused Emacs configuration, for the unix genie.

;;; Code:
;(server-start)

;; -- Get Font Here --
;; https://github.com/slavfox/Cozette/releases
;(add-to-list 'default-frame-alist '(font . "CozetteHiDpi-13"))
;(add-to-list 'default-frame-alist (list '(width . 72) '(height . 72)))

(setq
 backup-by-copying t ; don't clobber symlinks
 backup-directory-alist '(("." . "~/.saves")) ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)
(setq visible-bell nil)
(setq ring-bell-function 'ignore)
(setq shell-file-name "/bin/bash")
(setq shell-command-switch "-ic")

(if (fboundp 'global-linum-mode)
    (global-linum-mode 1)
  (if (fboundp 'global-display-line-numbers-mode)
      (global-display-line-numbers-mode 1)
    )
  )
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(show-paren-mode 1)
(recentf-mode 1)

(defun set-exec-path-from-shell ()
  "Set up Emacs' 'exec-path' and PATH environment."
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(set-exec-path-from-shell)

(defconst pkgs
  '(flycheck
    json-mode
    yaml-mode
    web-mode
    dockerfile-mode
    magit
    dracula-theme
    ctrlf
    smex))
(when (not package-archive-contents)
  (package-refresh-contents))
(dolist (pkg pkgs)
  (unless (package-installed-p pkg)
    (package-install pkg)))

; this enables flycheck globally, supposing the packge fetch above worked.
(if (fboundp 'global-flycheck-mode) (global-flycheck-mode))

;; (add-to-list 'load-path "~/.emacs.d/extras")
;; (require 'perltidy) ; Thanks to https://github.com/zakame/perltidy.el
;; (require 'perl-mode)
;; (require 'cperl-mode)
;; (add-hook 'cperl-mode-hook
;;           #'(lambda ()
;;             (setq font-lock-defaults
;;                   '((perl-font-lock-keywords perl-font-lock-keywords-1 perl-font-lock-keywords-2)
;;                     nil nil ((?\_ . "w")) nil
;;                     (font-lock-syntactic-face-function . perl-font-lock-syntactic-face-function)))
;;             (font-lock-refresh-defaults)))
;; (defalias 'perl-mode 'cperl-mode)

;; (add-hook 'before-save-hook #'(lambda ()
;;                               (when (or (eq major-mode 'perl-mode) (eq major-mode 'cperl-mode))
;;                                 (perltidy-buffer))))
;; (setq cperl-indent-parens-as-block t)
;; (setq flycheck-perlcritic-severity 3)

;; (defun kill-inner-word ()
;;  "It's ciw from Vim."
;;  (interactive)
;;  (backward-word)
;;  (kill-word 1))

;; (global-set-key (kbd "C-c C-c") #'kill-inner-word)

(ctrlf-mode +1)
;(if (fboundp 'ctrlf-mode) (ctrlf-mode +1))

;; (require 'ido)
;; (ido-mode 1)

;; (require 'smex)
;; (smex-initialize)
;; (global-set-key (kbd "M-x") #'smex)

;(provide 'init)

;;; init.el ends here.
