;;; early-init.el --- Loaded before the UI and package system -*- lexical-binding: t; -*-

;; early-init.el is read by Emacs *before* the GUI is initialised and before
;; package.el runs. It is the right place for startup-performance tweaks and for
;; disabling UI chrome so it is never drawn in the first place.

;; --- Garbage collection -------------------------------------------------------
;; Collecting garbage during startup is wasteful: raise the threshold to
;; effectively infinity while Emacs loads, then restore a sane runtime value
;; once initialisation has finished. The 100mb runtime value matches what
;; lsp/eglot benefit from (see the Performance section in emacs.org).
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

(add-hook 'after-init-hook
          (lambda ()
            (setq gc-cons-threshold (* 100 1000 1000) ;; 100mb
                  gc-cons-percentage 0.1)))

;; --- UI chrome ----------------------------------------------------------------
;; Disable the tool bar, menu bar and scroll bars before the first frame is
;; created. Doing it here (rather than with `tool-bar-mode -1' etc. later)
;; avoids drawing them and then removing them, which is both slower and causes a
;; visible flash on startup.
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(setq tool-bar-mode nil
      menu-bar-mode nil
      scroll-bar-mode nil)

;; Don't let Emacs implicitly resize the frame when the default font is set.
(setq frame-inhibit-implicit-resize t)

;; package.el is initialised explicitly in emacs.org, so don't also do it here.
(setq package-enable-at-startup nil)

;;; early-init.el ends here
