Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34E13043CF
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Dec 2025 00:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980324; cv=none; b=OWnEYrme55yP3c6dzIdtpcYVnx/upqTnz3ENwRXkhP5FYOPp4H0PBu3kvrP/ZsqUQbOMg+m+iW3Nqc0J47LmbgSvU1wa2/+IvaysWLaPK5lxKBttdF37Pf72dCIUVK4pJUwOWXepVO/DApoGyQMk/g6Zgzw/xSogAd6fJMfLtkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980324; c=relaxed/simple;
	bh=wKnuYKFa2/XawhzwETwLumcOzjORaqQZ0PyG/8KJ2Eg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lRXDv5Ty5ibs6CpZNnb8yTMcFsK1FAUCidnRng9mHCe2BY/2MIz12AqfdHLz6KGSJsUvVFqZJdvVoyhYL/OQMcbUPw6J7ZZ4UlF+CSlpY0olfbDjlTOIANWD0HKWLy5mgmd4LFnCvw2chJw/zrtpZe1pTjIoCs8VoRhs/Zicuck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zMLpL+sB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zMLpL+sB"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29da1ea0b97so53775835ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 16:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764980322; x=1765585122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2n5D0Ng0cmebeVdxSFqRanF8f5+ncu9wEbeJjFPfHxU=;
        b=zMLpL+sBSxZEUVbTdZ5sMjDWV/L1CkczpAetqw/btZhoebaeCFiwNEfO8c3vSc5//n
         wB7fHcHF7zTRN+xHBtdocfFj3rchP5TH0Uotb0QRjTVe/+5mARa2aM8mjVK/o3Oh/uUd
         DUN1UVicqX3ln31AZIjNjsdRJsPGgqIZdHPn8PrGjvuS8JjdXVnAtYSQMu0Z/B1H8mqx
         uYYGDlb5Gn77qaGJghInYBukSw72M6aAYm3636CAW9QGW7WcQAxLVA+cY6EXp5yR18Aj
         ZTWJPuDMOrwenzjQmF5K1so4Na4a8aol4WbonM6sW0SDhbel0MPZZyef0yGHaffxOX99
         PkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764980322; x=1765585122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2n5D0Ng0cmebeVdxSFqRanF8f5+ncu9wEbeJjFPfHxU=;
        b=XC37L3omxrBQ5F7IML3A9pDJKqY9Bc8b6ztrRLVmrxIJOS573w2nfci7n8UhSymULk
         Dbw1AM0gkQECvHY77bwGgCg53+SN+Zia4WizyOhb0cVv2kYrlkmOapTDFjUWCJT3l0fA
         3t7qQuvxRcYyVj59i7TPerG3Dyw6nxuaanD2i5HH/T27H+l7Q9ayDTpbjDN+RaXjgKPd
         xAsxVSC2gfaJpUa6/9luoqECctmTBlrkI3cDVPTJSrL1vfUSsdPlRslMo5xRPTgZSfiD
         ULgNSyRwNOj13CSYg4BpCMevMVVwFBSsrxcu2fZlmkbTKhjpjWcd4yDqRNyVrs6z8mpa
         t2rA==
X-Forwarded-Encrypted: i=1; AJvYcCWpY/MSyRgJf/cshiX1VoWilvVmfXX8v3I0VyIYUCGeYUe+ABVCp750uQnyioBc7RtwJdXRNrspI7YJQctURaUI@vger.kernel.org
X-Gm-Message-State: AOJu0YwU8LYFhN26EUjBS46sohpxolG2Q52UaBtY49+B6IaQ4T/c/qqu
	kLvoVNwLVh7pcffsVGdT11DVJpYxSNmglxqPV0Mk6EVxfkjs0ke3Gc1AIOa2kETsQW8fH2sJf8c
	XVdfAWA==
X-Google-Smtp-Source: AGHT+IED91Xjb0+dxO7/M2E0zHU6IQhei8lnafvXM15EOvowaasBkt+pNEKc95Jh7HmLdvF7r/s8Wu6xUzQ=
X-Received: from plbky13.prod.google.com ([2002:a17:902:f98d:b0:29d:5afa:2c5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d48f:b0:295:62d:5004
 with SMTP id d9443c01a7336-29df5695ff4mr7109145ad.26.1764980321808; Fri, 05
 Dec 2025 16:18:41 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Dec 2025 16:17:13 -0800
In-Reply-To: <20251206001720.468579-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251206001720.468579-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251206001720.468579-38-seanjc@google.com>
Subject: [PATCH v6 37/44] KVM: VMX: Dedup code for removing MSR from VMCS's
 auto-load list
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

Add a helper to remove an MSR from an auto-{load,store} list to dedup the
msr_autoload code, and in anticipation of adding similar functionality for
msr_autostore.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 52bcb817cc15..a51f66d1b201 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1040,9 +1040,22 @@ static int vmx_find_loadstore_msr_slot(struct vmx_msrs *m, u32 msr)
 	return -ENOENT;
 }
 
+static void vmx_remove_auto_msr(struct vmx_msrs *m, u32 msr,
+				unsigned long vmcs_count_field)
+{
+	int i;
+
+	i = vmx_find_loadstore_msr_slot(m, msr);
+	if (i < 0)
+		return;
+
+	--m->nr;
+	m->val[i] = m->val[m->nr];
+	vmcs_write32(vmcs_count_field, m->nr);
+}
+
 static void clear_atomic_switch_msr(struct vcpu_vmx *vmx, unsigned msr)
 {
-	int i;
 	struct msr_autoload *m = &vmx->msr_autoload;
 
 	switch (msr) {
@@ -1063,21 +1076,9 @@ static void clear_atomic_switch_msr(struct vcpu_vmx *vmx, unsigned msr)
 		}
 		break;
 	}
-	i = vmx_find_loadstore_msr_slot(&m->guest, msr);
-	if (i < 0)
-		goto skip_guest;
-	--m->guest.nr;
-	m->guest.val[i] = m->guest.val[m->guest.nr];
-	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, m->guest.nr);
 
-skip_guest:
-	i = vmx_find_loadstore_msr_slot(&m->host, msr);
-	if (i < 0)
-		return;
-
-	--m->host.nr;
-	m->host.val[i] = m->host.val[m->host.nr];
-	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, m->host.nr);
+	vmx_remove_auto_msr(&m->guest, msr, VM_ENTRY_MSR_LOAD_COUNT);
+	vmx_remove_auto_msr(&m->host, msr, VM_EXIT_MSR_LOAD_COUNT);
 }
 
 static __always_inline void add_atomic_switch_msr_special(struct vcpu_vmx *vmx,
-- 
2.52.0.223.gf5cc29aaa4-goog

