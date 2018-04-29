


;;;;
;;;; { browsing-and-editing
;;;;

;; smoother-scrolling "line by line instead of jumping like a retard"
(setq scroll-margin 5
      scroll-conservatively 5
      scroll-step 1)

;; highlight-whitespace:

;; show line numbers:
(global-linum-mode t)
(setq linum-format "%x ")


;;;;
;;;; } end of browsing-and-editing
;;;;



;;;;
;;;; packages
;;;;
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                        ("marmalade" . "http://marmalade-repo.org/packages/")
			("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")))
(package-initialize)

(defun require-package (package)
  (setq-default highlight-tabs t)
  "Install given PACKAGE"
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))



;;;;
;;;; { evil-mode
;;;;
(add-to-list 'load-path "~/.emacs.d/evil" )
(require 'evil)
(evil-mode 1)


;; colors of state - don't work though
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

;; j/k for browsing wrapped lines
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)


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

;;;;
;;;; nyan-mode
;;;;
(add-to-list 'load-path "~/.emacs.d/nyan-mode" )
(require 'nyan-mode)
(nyan-mode 1)











