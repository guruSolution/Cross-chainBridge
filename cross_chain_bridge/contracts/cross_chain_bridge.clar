
;; title: cross_chain_bridge
;; version:
;; summary:
;; description:Develop a bridge between Stacks and other blockchains for asset transfers. Each of these projects will help you gain proficiency with Clarity's functional programming model and Clarinet's testing capabilities while building practical applications on the Stacks ecosystem. using clarinet programing language

(define-data-var bridge-admin principal tx-sender)
(define-map locked-assets principal uint)
(define-map bridge-requests (tuple (user principal) (amount uint) (target-chain (buff 32))) uint)
(define-data-var request-counter uint u0)

;; Only admin can call
(define-private (is-admin)
  (is-eq tx-sender (var-get bridge-admin))
)
