

;;;; { browsing-and-editing

;; smoother-scrolling "line by line instead of jumping like a retard"
(setq scroll-margin 5
      scroll-conservatively 5
      scroll-step 1)

;; highlight-whitespace:
(setq default-hightlight-tabs t)

;; show line numbers:
(global-linum-mode t)
(setq linum-format "%x ")


;;;; } end of browsing-and-editing


;;;; { display
(setq default-tab-width 4)

;;;; } end of display




;;;;
;;;; packages
;;;;
(setq package-archives
	  '( ("gnu" . "http://elpa.gnu.org/packages/")
		 ("org" . "http://orgmode.org/elpa/")
		 ("marmalade" . "http://marmalade-repo.org/packages/")
		 ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
	   )
)


;; { Adding MELPA-stable
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
;; }

(defun require-package (package)
  "Install given PACKAGE"
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)
  )
)


;;;; emacs-goodies-el
(require 'tabbar)
(require 'color-theme)


;;;;
;;;; { evil-mode
;;;;
(add-to-list 'load-path "~/.emacs.d/evil" )
(require 'evil)
(evil-mode 1)


;;; key-mappings:
;; j/k for browsing wrapped lines
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

;; remap ';' to enter commands while in normal mode
(define-key evil-normal-state-map (kbd ";") 'evil-ex)


;; { escape-quits "by default, emacs like to cause fucking problems, and in particular 'M-x' mode is insane, no idea how to even exit it"
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer"
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
	  (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)
  )
)



(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)
;; } // end of escape-quits

;;;;
;;;; } end of evil-mode
;;;;



;;;; { nyan-mode
(add-to-list 'load-path "~/.emacs.d/nyan-mode" )
(require 'nyan-mode)
(nyan-mode 1)
(nyan-start-animation)
(nyan-toggle-wavy-trail)
;;;; }




;;;;
;;;; { org-mode
;;;;
(add-to-list 'load-path "~/.emacs.d/org-mode")
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(setq org-log-done t)
;;;;
;;;; }
;;;;



;;;; { styles-for-programming
(setq c-default-style "linux"
	  c-basic-offset 4
	  indent-tabs-mode t
)

;;;; }




;;;; { general-key-mappings "have to be at the end because evil likes to make their own mappings"
(define-key global-map (kbd "C-s") 'save-buffer)
(define-key global-map (kbd "C-v") 'yank)

(define-key global-map (kbd "<C-up>") 'evil-scroll-line-up)
(define-key global-map (kbd "<C-down>") 'evil-scroll-line-down)
; (define-key global-map (kbd "C-o") 'load-file) doesn't work :\
;;;; }


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Liberation Mono" :foundry "1ASC" :slant normal :weight normal :height 121 :width normal :antialias standard)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(c-default-style
   (quote
	((c-mode . "")
	 (c++-mode . "")
	 (java-mode . "java")
	 (awk-mode . "awk")
	 (other . "gnu"))) t)
 '(custom-enabled-themes (quote (wombat)))
 '(show-paren-mode t))
