Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF913093C3
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Dec 2025 00:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980333; cv=none; b=PjZNEeko8s28Ll8uUKNdB942so3Syxoi5zQoo8vaMLjevpTaD0UJO334fJWBZ14yMcJnXvZZHpi2jSsRdEnZBoEZnHMXU44tjoswJ9GMtYTfOl8xOaTT98f6HAlKWPAY9JHAJWxh2+cwlzK+j60csbtU38Sp0MtO46u4018iyJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980333; c=relaxed/simple;
	bh=BtLSCOsVaylpZ1Hr4R9W1QzZYCsZevsYtH+m4bBtmCY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gLVlZFfzw0bWrdHzN4e8fCQteIq65sAy5vUEpR1YKTrHNFKYhRX4VQzJAiPOK13FRNvu2wpJfxUu8MoV37jDgt1uC4daiTnAG5DqdxQBQCWGajpTjGyjLY7l8VJ+aJ/jfvVGDB2P9kSvtQwBNPXR3HCcMnSkoPldHAyXSoyNuTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3rbavl3Q; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3rbavl3Q"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-343e262230eso3274438a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 16:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764980329; x=1765585129; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QTKuKPWFr6bVN6iN1gTHfORH5j78nQLhYRuj2ERNrVM=;
        b=3rbavl3QrB9fEsqXUPzgnrQzg4/ptya3GOuLdpIt9d3qM4r4n7Xs+HVnu7AjRBP/c2
         tDNacmy1N54ZRDVUzG9DAtmyfR3O4McLsTUiS6RPgpZE5jjWyRzgjnEGemAJuajzrK+x
         EoUl326BH8suI7dmpKbACahUDk6ntIsq4/1/gV7euXet6w4gjtezZcgjQCpbQfTfmK0T
         A8QyORh6oammBhBfr8Ecd6KXge42ojDmrkmM612hVUV8phrrvHBO0jLjt+RzK54taIZV
         iDdFLbpERT/bMYry1rRVDEqr2ho6t/JGBgMg55GtOmQS+iQPQOdhCssKkEvxTGyHHM5x
         F4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764980329; x=1765585129;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTKuKPWFr6bVN6iN1gTHfORH5j78nQLhYRuj2ERNrVM=;
        b=ZJez4+wwnvu76/cYc6SSCLZJM8Etnl3xkdGPQHNtZ7ViNWos0Afchi/gMWtUR9SABE
         XYrZQFlg/JVFVUhBuq4I/WHz+kPeNWR2cN+/Wbj7Za3RtcyHmgtg6sBADBaXqZQndEDb
         Mc4rWVU9KjPl0bGannAe608/TMM4g+VbbMmWCka3uwdX8zYr6LE1FTXGmyaPbW6nJ1xu
         1uSoL6GcWUnpEnm88YNskC/UkNLWsRDZcYhpMssJ5XEYeyQ7bau02aQIidpqpNgZGF5a
         eh031+stA9o/HwZs2/HaL0uLEPO91G7ngvMA9/yrnT7+p98oKUB4hme7ZKWCSG7aS6t5
         jEhw==
X-Forwarded-Encrypted: i=1; AJvYcCX4Sv4KlHyGy7qwCOfzh0NfoQb7g9dki0AQvOhAGWLGoZzwSiLRxjU+oqSWKnl5pPvLXEVsvJSw9DZCbMC2qR6f@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQYMvqxZk7Rh5QMGJ9HJc5FLTFg+/zV5sFNVQuyH6D3g6VNEI
	dpmoKft9dVdY35qCBKTGhnEN87ImudrwPkTilEcUX0ESB8VqAByMm0jZ7IesbK0old4MFMOKR2L
	3b2no1g==
X-Google-Smtp-Source: AGHT+IHwEgCif9QeztnHlCZf32TA1mft1ORkKdnbi9mkgV4eyxEEshqnwgTA7OOXOPfobSPR/sGAg/rO4Do=
X-Received: from pfjc12.prod.google.com ([2002:a05:6a00:8c:b0:7e5:49a7:f55f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f91:b0:363:cd5e:8f87
 with SMTP id adf61e73a8af0-36617ea8befmr929454637.13.1764980329483; Fri, 05
 Dec 2025 16:18:49 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Dec 2025 16:17:17 -0800
In-Reply-To: <20251206001720.468579-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251206001720.468579-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251206001720.468579-42-seanjc@google.com>
Subject: [PATCH v6 41/44] KVM: VMX: Compartmentalize adding MSRs to host vs.
 guest auto-load list
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Xudong Hao <xudong.hao@intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Undo the bundling of the "host" and "guest" MSR auto-load list logic so
that the code can be deduplicated by factoring out the logic to a separate
helper.  Now that "list full" situations are treated as fatal to the VM,
there is no need to pre-check both lists.

For all intents and purposes, this reverts the add_atomic_switch_msr()
changes made by commit 3190709335dd ("x86/KVM/VMX: Separate the VMX
AUTOLOAD guest/host number accounting").

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index be2a2580e8f1..018e01daab68 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1096,9 +1096,9 @@ static __always_inline void add_atomic_switch_msr_special(struct vcpu_vmx *vmx,
 static void add_atomic_switch_msr(struct vcpu_vmx *vmx, unsigned msr,
 				  u64 guest_val, u64 host_val)
 {
-	int i, j = 0;
 	struct msr_autoload *m = &vmx->msr_autoload;
 	struct kvm *kvm = vmx->vcpu.kvm;
+	int i;
 
 	switch (msr) {
 	case MSR_EFER:
@@ -1133,25 +1133,26 @@ static void add_atomic_switch_msr(struct vcpu_vmx *vmx, unsigned msr,
 	}
 
 	i = vmx_find_loadstore_msr_slot(&m->guest, msr);
-	j = vmx_find_loadstore_msr_slot(&m->host, msr);
-
-	if (KVM_BUG_ON(i < 0 && m->guest.nr == MAX_NR_LOADSTORE_MSRS, kvm) ||
-	    KVM_BUG_ON(j < 0 &&  m->host.nr == MAX_NR_LOADSTORE_MSRS, kvm))
-		return;
-
 	if (i < 0) {
+		if (KVM_BUG_ON(m->guest.nr == MAX_NR_LOADSTORE_MSRS, kvm))
+			return;
+
 		i = m->guest.nr++;
 		m->guest.val[i].index = msr;
 		vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, m->guest.nr);
 	}
 	m->guest.val[i].value = guest_val;
 
-	if (j < 0) {
-		j = m->host.nr++;
-		m->host.val[j].index = msr;
+	i = vmx_find_loadstore_msr_slot(&m->host, msr);
+	if (i < 0) {
+		if (KVM_BUG_ON(m->host.nr == MAX_NR_LOADSTORE_MSRS, kvm))
+			return;
+
+		i = m->host.nr++;
+		m->host.val[i].index = msr;
 		vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, m->host.nr);
 	}
-	m->host.val[j].value = host_val;
+	m->host.val[i].value = host_val;
 }
 
 static bool update_transition_efer(struct vcpu_vmx *vmx)
-- 
2.52.0.223.gf5cc29aaa4-goog

