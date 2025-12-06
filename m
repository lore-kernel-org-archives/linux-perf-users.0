Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6218E2F3622
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Dec 2025 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980309; cv=none; b=GOVZO+fnnj4nDYOHVbKqqxss7kQ1qpFfsWRN9HTASwu9DACW2AbgAQES/N1NLM4UczbekJXSMsuau4dpmIN3RUbz1DauSo/bhrkqCkpDSj+PzSygYIhlOoYVsFQ4aYr7keYF0hbTess5ptxz+ex5fzQZyX4MAqrhST2vZlh7Bp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980309; c=relaxed/simple;
	bh=XkalrXDc3Qa++HcZCT+ub3/cOt2TlQhCgor1dl+ppOo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cTyVWyF2Ao1k4B0tBbsMPiz1yYedCn34LBpeCUcJDRB57RXZpUorBdkZmIEJ5Bmg3Qgf1UnENq86Yftx238PELHSQ3Wk4WtOUCiLuEOyhv2l79Oa96q8on7/4rHgGEb/IbnYOscSSGnXR+6xSnFWKDdSBThaSl9NE9Hm1nxaL5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LPeIErv8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPeIErv8"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29845b18d1aso46210595ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 16:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764980307; x=1765585107; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=wDDQncQUzzwpRSzzmwHiRYOU7FF2nSUQYIeQTrnvQK8=;
        b=LPeIErv8XJaCf0GqhOGvqDME4xx8RaSPLGaW3LW84EkpdR2n3FnqBLAglxLF22IHCv
         QP2GKLEBgciOSXlBqVcgkgsCnfLLFP3kwcqXuUmwbLB+doE8UmtE/in7ysQxHEeWM7r7
         lZVIgCDhFFB4W+IRE0jSon7CR+83XnwXAlAFhKdQFJpH/004PS9bT10HxZWJ4lVSmBD6
         Mc+xYAWvOjPZSR7i+tRyJy6x1CB2x/Qyf4CRd86qbza3CkCngFCd53RFJh2/H4OMpo3e
         kbBS3Tsp0z4rfXdMehjFpU+gQvQ5GL/HUcp60xMPQI3MMjj0ExVJcJlWVIyR9lfnn5ZG
         jOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764980307; x=1765585107;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDDQncQUzzwpRSzzmwHiRYOU7FF2nSUQYIeQTrnvQK8=;
        b=Z/EjJ6MAJru3+J19zQVu7476Wg0Tdcw1ig4ZTOQ9kCxGoXMqXt0JIxvOGLkGi69PQ9
         cGvEjTbrbu+H+kFXJQlGJZSGuW4ZG9DbGYE2wa9nOmxhMR2SErBH+4O0Ta3ReN7HuiWD
         yheeyjXJ1YbngjJhzXw+6lMeM/lRBou6H7V+AT0rUmp7ZJ+ojE/SJkjO5l9YR5xTiA3T
         DnF3xAdNuxlqURfdLjyPyCMw2KmMmndvijEJWxmywsCT23mJzpdwGuTF3AY25L/86bjR
         y29QCqAyHNivt8PkKq+AvH4wmhPJDCoFEP6JrepMgZNU8JPbKMAcrasqBqBTdjrzDVzP
         6iOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJeahFGqndacrX2yUVs7h60yhcxoJif4Y9KFh5Vna/Zekx9vW8BOqNeb1p8pIYE7ZDLhMnu5OYASDlXRd/m3qI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8rUqsWHVPWDXn89JeKju+4qV0wvj53HStNYMNYLDHRf8GnvqV
	++dcVTX91RXf7rLDCsk9s/loqvYMJYTSLyPXW0uloOcO0FViGe/O+B64LfsMYuiNhwLgr/syTzr
	pVknNDg==
X-Google-Smtp-Source: AGHT+IG4vHPmom8LOFsNf9ubPRsWVZC6RkdL55O4HgJ6N06qyh5/Ls7bYlKNT7sQNBmfh9FVeBcsEGoEIG4=
X-Received: from plhz1.prod.google.com ([2002:a17:902:d9c1:b0:298:51f6:847d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f84:b0:294:fc77:f021
 with SMTP id d9443c01a7336-29df5deb193mr7205895ad.49.1764980306541; Fri, 05
 Dec 2025 16:18:26 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  5 Dec 2025 16:17:06 -0800
In-Reply-To: <20251206001720.468579-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251206001720.468579-1-seanjc@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251206001720.468579-31-seanjc@google.com>
Subject: [PATCH v6 30/44] KVM: nVMX: Add macros to simplify nested MSR
 interception setting
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Add macros nested_vmx_merge_msr_bitmaps_xxx() to simplify nested MSR
interception setting. No function change intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 40777278eabb..b56ed2b1ac67 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -617,6 +617,19 @@ static inline void nested_vmx_set_intercept_for_msr(struct vcpu_vmx *vmx,
 						   msr_bitmap_l0, msr);
 }
 
+#define nested_vmx_merge_msr_bitmaps(msr, type)	\
+	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1,	\
+					 msr_bitmap_l0, msr, type)
+
+#define nested_vmx_merge_msr_bitmaps_read(msr) \
+	nested_vmx_merge_msr_bitmaps(msr, MSR_TYPE_R)
+
+#define nested_vmx_merge_msr_bitmaps_write(msr) \
+	nested_vmx_merge_msr_bitmaps(msr, MSR_TYPE_W)
+
+#define nested_vmx_merge_msr_bitmaps_rw(msr) \
+	nested_vmx_merge_msr_bitmaps(msr, MSR_TYPE_RW)
+
 /*
  * Merge L0's and L1's MSR bitmap, return false to indicate that
  * we do not use the hardware.
@@ -700,23 +713,13 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 	 * other runtime changes to vmcs01's bitmap, e.g. dynamic pass-through.
 	 */
 #ifdef CONFIG_X86_64
-	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
-					 MSR_FS_BASE, MSR_TYPE_RW);
-
-	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
-					 MSR_GS_BASE, MSR_TYPE_RW);
-
-	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
-					 MSR_KERNEL_GS_BASE, MSR_TYPE_RW);
+	nested_vmx_merge_msr_bitmaps_rw(MSR_FS_BASE);
+	nested_vmx_merge_msr_bitmaps_rw(MSR_GS_BASE);
+	nested_vmx_merge_msr_bitmaps_rw(MSR_KERNEL_GS_BASE);
 #endif
-	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
-					 MSR_IA32_SPEC_CTRL, MSR_TYPE_RW);
-
-	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
-					 MSR_IA32_PRED_CMD, MSR_TYPE_W);
-
-	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
-					 MSR_IA32_FLUSH_CMD, MSR_TYPE_W);
+	nested_vmx_merge_msr_bitmaps_rw(MSR_IA32_SPEC_CTRL);
+	nested_vmx_merge_msr_bitmaps_write(MSR_IA32_PRED_CMD);
+	nested_vmx_merge_msr_bitmaps_write(MSR_IA32_FLUSH_CMD);
 
 	nested_vmx_set_intercept_for_msr(vmx, msr_bitmap_l1, msr_bitmap_l0,
 					 MSR_IA32_APERF, MSR_TYPE_R);
-- 
2.52.0.223.gf5cc29aaa4-goog

