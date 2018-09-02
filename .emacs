(require 'tls)
(add-to-list 'gnutls-trustfiles "/usr/local/etc/openssl/cert.pem")
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
(add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

;;##################################### Haskell Start ###############################
;to fix problem with using ghc-mod with ##(add-hook 'haskell-mode-hook (lambda () (ghc-init)))##
(setenv "cabal_helper_libexecdir" (expand-file-name "~/Library/Haskell/libexec/x86_64-osx-ghc-8.0.2/cabal-helper-0.7.3.0"))



;;##################################### GHC-MOD Start ###############################
(let ((my-cabal-path (expand-file-name "~/Library/Haskell/bin")))
  (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(setq ghc-debug t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
;;##################################### GHC-MOD End ###############################
(add-hook 'haskell-mode-hook #'hindent-mode)
(require 'company)
(add-hook 'haskell-mode-hook 'company-mode)
(add-to-list 'company-backends 'company-ghc)
;;(custom-set-variables '(company-ghc-show-info t))
(setq ac-modes '(haskell-mode))


;;##################################### Haskell End ###############################


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#2d3743" :foreground "#e1e1e0" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 160 :width normal :foundry "nil" :family "menlo")))))
 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (wombat)))
 '(custom-set-variables (quote (company-ghc-show-info t)))
 '(package-selected-packages (quote (auto-complete company-ghc hindent ghc))))
