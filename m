Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2CD30BB96
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Dec 2025 00:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980334; cv=none; b=T+cih07hC3GWV6cflAKV1WsfiAPoKej7DbbVMtOqAMHypFr8AM9jVo4uj65Gj3nqecbj4BhZ1qTmAKMyC6JCcnfUronyZOWo/DqmszUBo9ASVo3+EPnCBFBpD+OOUfxmi3/t9U5itWfAXNA3nrHNjJEx2x6aY1WSjG5WDO2k3EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980334; c=relaxed/simple;
	bh=UVioe3cP1bYPqsGVmWsr21dHZMl8z/Ov/PsUa6Us+s0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FEXaL3NDPa//BARueyEHQimRl5pscxHKI6Q27OBQCKQTkhVek7agjtNEkSkdCxj01+5QHvMCuQHfF3D71CJxZJJg8V5i7V7DMFOE9ZrBgIs5qXaoEFk+Rzqlx+AkRXg1nhHQtfKJnB5ng8fUkAxNmU5ZBNPD2rVDIr2T4+NJBpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1k/cmGSx; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1k/cmGSx"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-340bc4ef67fso3026945a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 16:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764980331; x=1765585131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=igvZhN+qFglUKI0D9M5DwytuE53IkpoWDDVxPCMFY70=;
        b=1k/cmGSxnUJf9BbckwKdkvy4OZTsqwjslvKaZMhbHkKF7/PnxBUsgg8TcIxzOzOgbk
         aTw9rz8+Ej2wapUHCe+gocU+bEnJpqi7EKa/jjuyy0XeV1xI9U0b4u9aThcbA+BxdJyw
         h3jrreq2K+TgFdzGrbIu2WkxGbbVYiQYifhmF++CEm3vZuyUJoU60Q7Aza3O7XDfWIUO
         54/g/7zQ5j9mPrCJYX1ZJsJ5gL74PuZGk9poeyo2jkFUgWmMxT0yweqfEG2fiNYUs9IB
         HzFgL0wZ7AIQdVTJTh1Uru6XXZN2zRfCBaicy1wIGiudjhN3Qs0jm4wtm1/h1dH7NHDP
         91SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764980331; x=1765585131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igvZhN+qFglUKI0D9M5DwytuE53IkpoWDDVxPCMFY70=;
        b=c+FSej+gK+d6z3fW0pgc8FsKUGyH/obAMuOPaHjAY7NFk6VU6JWyOiafMQbY3TYDCo
         s+inyJroUs0Si6zQQppG9GAGcUvva7d1ndPZjeKjNG3zlNOsy9klwMN4AiH+gIzcSUXA
         cY9A2UmxVwel1dx7MLDNFuFSg+dZcC9ofQxUYcFRe6gRdrHUB4eoxTENR6ga0w/cQ5I+
         KY+8F59QemgqKh6/CDU8JqCBLHZnt302ufmK1kj2A6ZVuWPqxpNmxVJSmZFF+Pd+4GI8
         Zrmmdq4hDe8SaApWSl7i4638vNc8Q4jcwjMcXi/BKorvbkgEC0rr3Zx+fjfSApPah1MV
         aq8A==
X-Forwarded-Encrypted: i=1; AJvYcCWQyflx0QTy5J2bAuEVKRpLfgTjdJxrCrJ0XJYQEXSEG62EUB+Q2OgmGKjng5FJPReXNwX2EptAh2R71c8LKxCe@vger.kernel.org
X-Gm-Message-State: AOJu0YySW5z3u2E3YA+xMtinv9RpEHIduT9BEinF7+sV0wIp+zTj5Z+Z
	fTV0+RSsEAeNbXwg3YcVHI56XDFxSbKEwYiftODlEhYZeTLpuyQRlf/PccqUOFW+1ZVtWb8r2SM
	jyiu/DQ==
X-Google-Smtp-Source: AGHT+IELoQ04EyxWWYOkaKJLtcnZ6DpPNmUnBZcM+48DKxRjXGIekKbShjkFhb2K5/ObBWXw0pAx2mabe98=
X-Received: from pjbsk6.prod.google.com ([2002:a17:90b:2dc6:b0:340:a5c6:acc3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fc47:b0:343:d70e:bef0
 with SMTP id 98e67ed59e1d1-349a267fbc8mr680584a91.21.1764980331409; Fri, 05
 Dec 2025 16:18:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Dec 2025 16:17:18 -0800
In-Reply-To: <20251206001720.468579-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251206001720.468579-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251206001720.468579-43-seanjc@google.com>
Subject: [PATCH v6 42/44] KVM: VMX: Dedup code for adding MSR to VMCS's auto list
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

Add a helper to add an MSR to a VMCS's "auto" list to deduplicate the code
in add_atomic_switch_msr(), and so that the functionality can be used in
the future for managing the MSR auto-store list.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 018e01daab68..3f64d4b1b19c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1093,12 +1093,28 @@ static __always_inline void add_atomic_switch_msr_special(struct vcpu_vmx *vmx,
 	vm_exit_controls_setbit(vmx, exit);
 }
 
+static void vmx_add_auto_msr(struct vmx_msrs *m, u32 msr, u64 value,
+			     unsigned long vmcs_count_field, struct kvm *kvm)
+{
+	int i;
+
+	i = vmx_find_loadstore_msr_slot(m, msr);
+	if (i < 0) {
+		if (KVM_BUG_ON(m->nr == MAX_NR_LOADSTORE_MSRS, kvm))
+			return;
+
+		i = m->nr++;
+		m->val[i].index = msr;
+		vmcs_write32(vmcs_count_field, m->nr);
+	}
+	m->val[i].value = value;
+}
+
 static void add_atomic_switch_msr(struct vcpu_vmx *vmx, unsigned msr,
 				  u64 guest_val, u64 host_val)
 {
 	struct msr_autoload *m = &vmx->msr_autoload;
 	struct kvm *kvm = vmx->vcpu.kvm;
-	int i;
 
 	switch (msr) {
 	case MSR_EFER:
@@ -1132,27 +1148,8 @@ static void add_atomic_switch_msr(struct vcpu_vmx *vmx, unsigned msr,
 		wrmsrq(MSR_IA32_PEBS_ENABLE, 0);
 	}
 
-	i = vmx_find_loadstore_msr_slot(&m->guest, msr);
-	if (i < 0) {
-		if (KVM_BUG_ON(m->guest.nr == MAX_NR_LOADSTORE_MSRS, kvm))
-			return;
-
-		i = m->guest.nr++;
-		m->guest.val[i].index = msr;
-		vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, m->guest.nr);
-	}
-	m->guest.val[i].value = guest_val;
-
-	i = vmx_find_loadstore_msr_slot(&m->host, msr);
-	if (i < 0) {
-		if (KVM_BUG_ON(m->host.nr == MAX_NR_LOADSTORE_MSRS, kvm))
-			return;
-
-		i = m->host.nr++;
-		m->host.val[i].index = msr;
-		vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, m->host.nr);
-	}
-	m->host.val[i].value = host_val;
+	vmx_add_auto_msr(&m->guest, msr, guest_val, VM_ENTRY_MSR_LOAD_COUNT, kvm);
+	vmx_add_auto_msr(&m->guest, msr, host_val, VM_EXIT_MSR_LOAD_COUNT, kvm);
 }
 
 static bool update_transition_efer(struct vcpu_vmx *vmx)
-- 
2.52.0.223.gf5cc29aaa4-goog

