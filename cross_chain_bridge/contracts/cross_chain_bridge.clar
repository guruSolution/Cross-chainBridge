
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
;; Define liquidity pools for fast transfers
(define-map liquidity-pools 
  { token-id: (string-ascii 32) }
  { balance: uint, fee-percentage: uint }
)


;; Lock tokens on Stacks side
(define-public (lock-tokens (amount uint) (target-chain (buff 32)))
  (begin
    (asserts! (> amount u0) (err u1))
    (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
    
    ;; Track locked assets
    (map-set locked-assets tx-sender 
      (+ (default-to u0 (map-get? locked-assets tx-sender)) amount))
      
    ;; Create bridge request
    (let ((request-id (var-get request-counter)))
      (map-set bridge-requests 
        (tuple (user tx-sender) (amount amount) (target-chain target-chain)) 
        request-id)
      (var-set request-counter (+ request-id u1))
      (ok request-id)
    )
  )
)

;; Set a new admin
(define-public (set-admin (new-admin principal))
  (begin 
    (asserts! (is-admin) (err u5))
    (var-set bridge-admin new-admin)
    (ok true)
  )
)

;; Get locked balance
(define-read-only (get-locked-balance (user principal))
  (default-to u0 (map-get? locked-assets user))
)
;; Provide liquidity to the bridge
(define-public (provide-liquidity 
    (token-id (string-ascii 32)) 
    (amount uint))
  (begin
    (asserts! (> amount u0) (err u10))
    (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
    
    ;; Update pool balance
    (map-set liquidity-pools
      { token-id: token-id }
      { 
        balance: (+ amount (get balance (default-to { balance: u0, fee-percentage: u0 } 
          (map-get? liquidity-pools { token-id: token-id })))),
        fee-percentage: (get fee-percentage (default-to { balance: u0, fee-percentage: u30 } 
          (map-get? liquidity-pools { token-id: token-id })))
      })
    (ok true)
  )
)
