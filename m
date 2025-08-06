Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3842D3EDB
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Aug 2025 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510282; cv=none; b=ScZe51PlpqvE1gGv2m2OxmEZ4Js2/0hY6GhlKSPr6eiOJ+Kn/E2CJO1WQrYoMpzj0XmPKo++yQfgZcOU6C77G8XD9NLTll7T5IWpPc0wN0cbH5nOTX0p/d6uMBEYG0FxOwY37LoMyig7ptaTlyRvEjGdpmbNgYjj+cF5OEAvuKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510282; c=relaxed/simple;
	bh=S2PXduPc6MjaQTDHugYUZGj6hH4KjT2QfQWxoS/aD0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rR0/Qi2sS4FZ5stkdP3DyDIcuokFueeMtqwclhHSXokSZavVmrQHOznCWJivcZCaWXk9kvkmiyAsYPxvKWPxX/6Ei4IZD3/bozLY6wl22q1SNdsuw5OX5JuLqf3LbbLxEeaYgUt2ghz4rjr1UbgaI9S6aws9ehYRhCfF1w3y3AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RftfEKTN; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RftfEKTN"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-315af08594fso334492a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Aug 2025 12:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510278; x=1755115078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JPhdbzRHNYwbPflarjN5FFRR+xgGKTfGx/VQdQ/Orqk=;
        b=RftfEKTNvfTY8Q1dM7kumzdRIgT/7PwiLqewU5flhj4i88I029T4mOwusCNgRsRM/C
         3DC+Zom+mfGr0pw8qIJ7GkY3JK8TEayzHs+dRHTLtAp2ykPEs/SKvy+ZjK1/tJO+vrNF
         hJsVz6n0fZyRqtP/kN78Z9W/dcP9xZsIgJa4vA+ukrnnkEfVirucpGvl6IHrgWbTVchS
         0qZYgVaJVn8/TrhJHAtxBDHp9ToYa8OQDoYRj9gH/GaH3j5ZM/om45iAIeO8w4rz1o5W
         MjNUxzir0SPCwmAbSPUOpRWZh+t4W2RU7eVF7ljOQ0rHDhkkAG+b5L1u+YJByKZIGab/
         iFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510278; x=1755115078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPhdbzRHNYwbPflarjN5FFRR+xgGKTfGx/VQdQ/Orqk=;
        b=DqtSPjV9B/0HDs1uienqJdIQxWnX3IWgTtn1qWjru7X0CHFWAQyDPPEv3tGW27le7f
         ZKwEiff6tV0YKpmIoO46ZRIhGv7DITYgHgMs59G7KrUKncy3IgiFY7yUYwncrz/Pu0Ja
         5WsNivW5g8un3Wfq+omLLglAJ0kgG2ICOM0mOFUWMiBcvan0O0W9juaPAbEryP69Fktj
         6njmzVOr2pJz7Sw7bexCLuk9JSKVb25dK4Zl8pRjxpusrViVkqszRidm5LoDImdCgCTV
         yt7zIF/j7sV2RcnAPtLIWIaN/NfhqRC4QkRSGpDo9w2mZ6PwDFewWIZPlVXxM3Jz/rto
         v/uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhOy/x11hdTt0NomUL75gdQX7KIWx5bDX+heqm2P1K55egrteyc6upyWRbNAkhIpyY0itMyFiV9K/2QV9KDZhj@vger.kernel.org
X-Gm-Message-State: AOJu0YzIouUT4a9CsZ3RZB6/3bR7nIIDgdGbUs1BVq50qoYKl9OPpByk
	QHiMoGVJSrR5NrK+ezCZaNUSfRJtJXzptpvK57Ff1vameyrR0W/LpNPxLa83T4uUWZ0jW6rmiWi
	eSRZsjQ==
X-Google-Smtp-Source: AGHT+IFSe1FbjsND/XiMAlJbwSv08tGHE8p8b2tGPxUBNGb/T59D+jgsyqvY56UbSdKD1Cfbmzp8QhdLT3k=
X-Received: from pjzj16.prod.google.com ([2002:a17:90a:eb10:b0:313:274d:3007])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c86:b0:312:ffdc:42b2
 with SMTP id 98e67ed59e1d1-32167541295mr4635514a91.23.1754510278028; Wed, 06
 Aug 2025 12:57:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:38 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-17-seanjc@google.com>
Subject: [PATCH v5 16/44] KVM: Add a simplified wrapper for registering perf callbacks
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Add a parameter-less API for registering perf callbacks in anticipation of
introducing another x86-only parameter for handling mediated PMU PMIs.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/arm.c      |  2 +-
 arch/loongarch/kvm/main.c |  2 +-
 arch/riscv/kvm/main.c     |  2 +-
 arch/x86/kvm/x86.c        |  2 +-
 include/linux/kvm_host.h  | 11 +++++++++--
 virt/kvm/kvm_main.c       |  5 +++--
 6 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 888f7c7abf54..6c604b5214f2 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2328,7 +2328,7 @@ static int __init init_subsystems(void)
 	if (err)
 		goto out;
 
-	kvm_register_perf_callbacks(NULL);
+	kvm_register_perf_callbacks();
 
 out:
 	if (err)
diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 80ea63d465b8..f62326fe29fa 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -394,7 +394,7 @@ static int kvm_loongarch_env_init(void)
 	}
 
 	kvm_init_gcsr_flag();
-	kvm_register_perf_callbacks(NULL);
+	kvm_register_perf_callbacks();
 
 	/* Register LoongArch IPI interrupt controller interface. */
 	ret = kvm_loongarch_register_ipi_device();
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 67c876de74ef..cbe842c2f615 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -159,7 +159,7 @@ static int __init riscv_kvm_init(void)
 		kvm_info("AIA available with %d guest external interrupts\n",
 			 kvm_riscv_aia_nr_hgei);
 
-	kvm_register_perf_callbacks(NULL);
+	kvm_register_perf_callbacks();
 
 	rc = kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
 	if (rc) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5af2c5aed0f2..d80bbd5e0859 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9689,7 +9689,7 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 		set_hv_tscchange_cb(kvm_hyperv_tsc_notifier);
 #endif
 
-	kvm_register_perf_callbacks(ops->handle_intel_pt_intr);
+	__kvm_register_perf_callbacks(ops->handle_intel_pt_intr, NULL);
 
 	if (IS_ENABLED(CONFIG_KVM_SW_PROTECTED_VM) && tdp_mmu_enabled)
 		kvm_caps.supported_vm_types |= BIT(KVM_X86_SW_PROTECTED_VM);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 15656b7fba6c..20c50eaa0089 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1731,10 +1731,17 @@ static inline bool kvm_arch_intc_initialized(struct kvm *kvm)
 #ifdef CONFIG_GUEST_PERF_EVENTS
 unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu);
 
-void kvm_register_perf_callbacks(unsigned int (*pt_intr_handler)(void));
+void __kvm_register_perf_callbacks(unsigned int (*pt_intr_handler)(void),
+				   void (*mediated_pmi_handler)(void));
+
+static inline void kvm_register_perf_callbacks(void)
+{
+	__kvm_register_perf_callbacks(NULL, NULL);
+}
+
 void kvm_unregister_perf_callbacks(void);
 #else
-static inline void kvm_register_perf_callbacks(void *ign) {}
+static inline void kvm_register_perf_callbacks(void) {}
 static inline void kvm_unregister_perf_callbacks(void) {}
 #endif /* CONFIG_GUEST_PERF_EVENTS */
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ecafab2e17d9..d477a7fda0ae 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6429,10 +6429,11 @@ static struct perf_guest_info_callbacks kvm_guest_cbs = {
 	.handle_mediated_pmi	= NULL,
 };
 
-void kvm_register_perf_callbacks(unsigned int (*pt_intr_handler)(void))
+void __kvm_register_perf_callbacks(unsigned int (*pt_intr_handler)(void),
+				   void (*mediated_pmi_handler)(void))
 {
 	kvm_guest_cbs.handle_intel_pt_intr = pt_intr_handler;
-	kvm_guest_cbs.handle_mediated_pmi = NULL;
+	kvm_guest_cbs.handle_mediated_pmi = mediated_pmi_handler;
 
 	perf_register_guest_info_callbacks(&kvm_guest_cbs);
 }
-- 
2.50.1.565.gc32cd1483b-goog

