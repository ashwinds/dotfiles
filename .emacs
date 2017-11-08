(setq mac-right-command-modifier 'meta)
(setq mac-right-option-modifier 'control)


;; (desktop-save-mode 1)
(setq desktop-files-not-to-save "^$")


;; .emacs

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
;(setq require-final-newline 'query)

;;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)

(global-set-key "\C-o" 'other-window)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-j" 'set-justification-left)

(cond ((fboundp 'global-font-lock-mode)
       ;; Customize face attributes
       (setq font-lock-face-attributes
             ;; Symbol-for-Face Foreground Background Bold Italic Underline
             '((font-lock-comment-face       "DarkGreen")
               (font-lock-string-face        "Blue")
               (font-lock-keyword-face       "DarkBlue")
               (font-lock-function-name-face "Blue")
               (font-lock-variable-name-face "Purple")
               (font-lock-type-face          "Red")
               ;;(font-lock-reference-face     "DarkGreen")
               ))
       ;; Load the font-lock package.
       (require 'font-lock)
       ;; Maximum colors
       (setq font-lock-maximum-decoration t)
       ;; Turn on font-lock in all modes that support it
       (global-font-lock-mode t)))

;;(setq x-super-keysym 'meta)
;;(setq x-meta-keysym 'alt)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-compression-mode t nil (jka-compr))
 '(case-fold-search t)
 '(current-language-environment "UTF-8")
 '(default-input-method "rfc1345")
 '(ecb-options-version "2.40")
 '(global-font-lock-mode t nil (font-lock))
 '(indent-tabs-mode nil)
 '(load-home-init-file t t)
 '(transient-mark-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;Auto-Fill-Mode
(add-hook 'text-mode-hook '(lambda () (set-fill-column 75)))

(setq frame-title-format "emacs %b")

;;enable iswitch mode
(cond ((fboundp 'iswitchb-mode)                ; GNU Emacs 21
       (iswitchb-mode 1)))

;; alias y to yes and n to no
(defalias 'yes-or-no-p 'y-or-n-p)

(menu-bar-mode -1)
;; (tool-bar-mode -1)

;; (require 'copy-utils)
(load-library "~/.emacs.d/copy-utils.el" )
(global-set-key "\C-p" 'cp-cur-word)

;; (require 'xcscope)
;; (require 'compile)
;; (require 'tramp)
;; (require 'pdbx)
;; (load-library "python-pylint")


;;(require 'copy-utils)
;; (load-library "~/emacs/copy-utils.el" )
;; (global-set-key "\C-p" 'cp-cur-word)

;; ;;(add-to-list 'load-path "~/emacs/kill-ring-search.el")
;; (autoload 'kill-ring-search "~/emacs/kill-ring-search.el"
;;   "Search the kill ring in the minibuffer."
;;   (interactive))
;; (global-set-key "\M-\C-y" 'kill-ring-search)

;; (add-to-list 'load-path
;;              "~/.emacs.d/xcscope.el")
;; (require 'xcscope)

(defun comint-close-completions ()
  "Close the comint completions buffer.
Used in advice to various comint functions to automatically close
the completions buffer as soon as I'm done with it. Based on
Dmitriy Igrishin's patched version of comint.el."
  (if comint-dynamic-list-completions-config
      (progn
        (set-window-configuration comint-dynamic-list-completions-config)
        (setq comint-dynamic-list-completions-config nil))))

(defadvice comint-send-input (after close-completions activate)
  (comint-close-completions))

(defadvice comint-dynamic-complete-as-filename (after close-completions activate)
  (if ad-return-value (comint-close-completions)))

(defadvice comint-dynamic-simple-complete (after close-completions activate)
  (if (member ad-return-value '('sole 'shortest 'partial))
      (comint-close-completions)))

(defadvice comint-dynamic-list-completions (after close-completions activate)
    (comint-close-completions)
    (if (not unread-command-events)
        ;; comint's "Type space to flush" swallows space. put it back in.
        (setq unread-command-events (listify-key-sequence " "))))
(setq x-select-enable-primary t)
