Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4D845BEC
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Jan 2025 01:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738285647; cv=none; b=SSRsHpmAC629M3V8tHMYvefuZOwQZAUDBrrxpCvJfZgtkMhRvK/26yxy4TVDi4yIhUCXCb7h03kU1Hrgz82AbQ9HBzj9qYbCNy3dIxuxnprpoWH5FWfpdbP0aFGbZg5r4c3MEIXMboysJiO5eO7ldxseEtWE73OksABdTdSOCA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738285647; c=relaxed/simple;
	bh=+7IdRtAgvETSYKgiufYxprCEuNa1bqjk/oCFp9BzVJc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oMPFhcEUCyznLjJYzJzpsilLR3fdbjX3OY5uPBe18kX/HahyiXjULtoHuX1nIPh5QAhbIz7H0pqtdpJ9KpozvXlcDKzEVPzZ1IhYZNqp8PRPxompkxaSHPew7AZNFAdxD7xHNn1azCqe0CPvItS4+N230nSmuHsRsLpwwfhZP7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kR5py71y; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kR5py71y"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2efa74481fdso2856653a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Jan 2025 17:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738285645; x=1738890445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fy7bg8EETE392HuVNTlpZ3+nQUkioeYxYXPabwBQMYo=;
        b=kR5py71y8IJijHLh1FnbeF80JGdz0s/J3cq+foE0+p3cXQ76bkRV/NzSo/Xt99ZkLt
         GXMLbpfxDvkzLAJ7WvoLgeZ1tMkRvz80qwFMwv9IgykgCLqrzojVYMR6u7eXr725BmSH
         MZV75Tp+wcAw+ze/9rbyqAJVihz4UKn10CiXBwhVurcd+X9D30R3u9AM9WGqCnufAyO4
         ZFlBTblvRmIHcb5+NiSUawezzYXG690Ce5HEa3gXGoGcPWJF8HK9QQdMvocqoPRNN6LU
         1XbUS1nD+P0ER1hNhulGmmTATZsh/cQNIBuGIvI5MSbXwx1QS2KS3AeiI+yhFZn6Ci3V
         juGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738285645; x=1738890445;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fy7bg8EETE392HuVNTlpZ3+nQUkioeYxYXPabwBQMYo=;
        b=iZ4eMqFXfKUcc5Q0tfJXJvI3wAM22nCauxXKkdYnbeFnjLS80ZJiSdA3E5ikh2L+6i
         MKQyW9hU3Izh5tI2CXJUJ+qPYoLupVo7x7FBww+w0XjkfsoEmn75lEWcib9/h2uti046
         Q/mbePmzpO3E6X9hzBG7osGMUyxg7dgrWuWHfAZZOmDxJpDvbcFsORMPX2K1Muxn5W2K
         xoo+LUcP3Bi4+m5PzMcrNMmf+K5H0E6823REemwYb//NHuDobBhW/W6JE3GC9VC+TXS/
         l/FTcZkt2/MDTg77TJyGp2Xm3AwAmZRl62I2NN3glKd4SmVfTKEV34opUyayX1nFIzW3
         8LSA==
X-Gm-Message-State: AOJu0Ywo2osYLUWQLLlSAgV+56loyavBFL4l6mMmwh/SiDAV6Acz5V/4
	kauxfUd8Zn+Sfwm+v0S5H6sPWWqD4VLguR37/PR4hdDkT2hTwIohDDa1nDg9UBWHGpldQOPK4iT
	OHg==
X-Google-Smtp-Source: AGHT+IF1BNjYxjRBdic3EsMUw3LnVZh5PgBgpydEPWZ4u388Z/jGMXftglmcQ1LhMQO6p4J62ZYaHJzh7no=
X-Received: from pfam19.prod.google.com ([2002:aa7:8a13:0:b0:72f:cbb1:275d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f8c:b0:728:927b:7de2
 with SMTP id d2e1a72fcca58-72fd0be829amr15451790b3a.8.1738285644816; Thu, 30
 Jan 2025 17:07:24 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Jan 2025 17:07:21 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250131010721.470503-1-seanjc@google.com>
Subject: [PATCH] perf/x86/intel: Ensure LBRs are disabled when a CPU is starting
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Explicitly clear DEBUGCTL.LBR when a CPU is starting, prior to purging the
LBR MSRs themselves, as at least one system has been found to transfer
control to the kernel with LBRs enabled (it's unclear whether it's a BIOS
flaw or a CPU goof).  Because the kernel preserves the original DEBUGCTL,
even when toggling LBRs, leaving DEBUGCTL.LBR as is results in running
with LBRs enabled at all times.

Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
Closes: https://lore.kernel.org/all/c9d8269bff69f6359731d758e3b1135dedd7cc61.camel@redhat.com
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/events/intel/core.c     | 5 ++++-
 arch/x86/include/asm/msr-index.h | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e76e892f44cd..efd069bc9c28 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5038,8 +5038,11 @@ static void intel_pmu_cpu_starting(int cpu)
 
 	init_debug_store_on_cpu(cpu);
 	/*
-	 * Deal with CPUs that don't clear their LBRs on power-up.
+	 * Deal with CPUs that don't clear their LBRs on power-up, and that may
+	 * even boot with LBRs enabled.
 	 */
+	if (!static_cpu_has(X86_FEATURE_ARCH_LBR) && x86_pmu.lbr_nr)
+		msr_clear_bit(MSR_IA32_DEBUGCTLMSR, DEBUGCTLMSR_LBR_BIT);
 	intel_pmu_lbr_reset();
 
 	cpuc->lbr_sel = NULL;
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3ae84c3b8e6d..61e991507353 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -395,7 +395,8 @@
 #define MSR_IA32_PASID_VALID		BIT_ULL(31)
 
 /* DEBUGCTLMSR bits (others vary by model): */
-#define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
+#define DEBUGCTLMSR_LBR_BIT		0	     /* last branch recording */
+#define DEBUGCTLMSR_LBR			(1UL <<  DEBUGCTLMSR_LBR_BIT)
 #define DEBUGCTLMSR_BTF_SHIFT		1
 #define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
 #define DEBUGCTLMSR_BUS_LOCK_DETECT	(1UL <<  2)

base-commit: b709eb872e19a19607bbb6d2975bc264d59735cf
-- 
2.48.1.362.g079036d154-goog

