Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E352C55880;
	Tue, 11 Jun 2024 16:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124601; cv=none; b=TCWiW7J/hqDW7Uzbc8vFNC9L/+fUbX1qWgUzXziIE8pDfVoE1ldq90RRkd18smkx5IFvKBOxEFe6FX7LgAT7oeUKIBWWqnUD4bnpcrDbwWxkdgw7UwrPb9j6ceQc6ilTupJ8oPu4eyIlAhVcDVMdT70Zozg/LF3RTRoBCLFZlLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124601; c=relaxed/simple;
	bh=k75EWiLGbT8v5X6AJvmrIwUxotvioqipvuQ9n/eL580=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RKM541ahtRKEkfrUPpL+hbbQRQIlKD3vkw78Y3SttehPQuyYVz2PZiA3GtZrie3vJ3JVfgBRyg7lYoUwB8f+nZ4cel2WY6czD5raUVejEzQmQy+H1k3qk9X8ADYivIjSxxJMjfEITMZXT4p5UaHOvKcURcjRFMCRugCG72q4sR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ho9qZ2nR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ho9qZ2nR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718124600; x=1749660600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k75EWiLGbT8v5X6AJvmrIwUxotvioqipvuQ9n/eL580=;
  b=Ho9qZ2nRU7Y6On8MG9u4TrGQG3vZyD3HgDKuE0BtIaSWolkkeT6CVzKT
   w3fyYsQcYyU2ulC++3Lh656CIV8Uu4wXiMH9aSanyZSfjOEetoc1+pd3D
   7FvG9cmHh5MCzT2GwddbInK0FykeLn3gFIdYltGryEtyZPi3VV6ElHIPQ
   eztCGjwFhQ10ue82ZcOO0ZzhTs7yJEumlYODGy4RgNrarA3oeDyCWN3ng
   vdmnsVcO9kh9PQPcq5qzYT1aeNq6tLPBJpAig7e2y3lNU4fMOeJiU1oWm
   dylCRdKPSRq4YncBHugiyDKtCrhWyi4U5lh13ZJ458N2EVLwRplbC9oqE
   A==;
X-CSE-ConnectionGUID: coijBmh+RE2Qw3Z8VI0VmQ==
X-CSE-MsgGUID: mnRNCBiSTP2rLQfVl4ieXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="40249667"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="40249667"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 09:49:59 -0700
X-CSE-ConnectionGUID: prw5tJPDTMChoJPIe/LuxQ==
X-CSE-MsgGUID: g3xvhN0eTX6960PvsJSbsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="40103312"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by orviesa008.jf.intel.com with ESMTP; 11 Jun 2024 09:49:58 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: X86 Kernel <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Ingo Molnar" <mingo@redhat.com>,
	"Borislav Petkov" <bp@alien8.de>,
	linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <andi.kleen@intel.com>,
	"Xin Li" <xin3.li@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Zeng Guang <guang.zeng@intel.com>
Subject: [PATCH v2 5/6] perf/x86: Enable NMI source reporting for perfmon
Date: Tue, 11 Jun 2024 09:54:56 -0700
Message-Id: <20240611165457.156364-6-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
References: <20240611165457.156364-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Program the designated NMI source vector into the performance monitoring
interrupt (PMI) of the local vector table. PMI handler will be directly
invoked when its NMI is generated. This avoids the latency of calling all
NMI handlers blindly.

Co-developed-by: Zeng Guang <guang.zeng@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

---
v2: Fix a compile error apic_perfmon_ctr is undefined in i386 config
---
 arch/x86/events/core.c       | 8 ++++++--
 arch/x86/events/intel/core.c | 6 +++---
 arch/x86/include/asm/apic.h  | 1 +
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1ef2201e48ac..db8c30881f5c 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -46,6 +46,7 @@
 
 struct x86_pmu x86_pmu __read_mostly;
 static struct pmu pmu;
+u32 apic_perfmon_ctr = APIC_DM_NMI;
 
 DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
 	.enabled = 1,
@@ -1680,7 +1681,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 	 * This generic handler doesn't seem to have any issues where the
 	 * unmasking occurs so it was left at the top.
 	 */
-	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	apic_write(APIC_LVTPC, apic_perfmon_ctr);
 
 	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
 		if (!test_bit(idx, cpuc->active_mask))
@@ -1723,7 +1724,10 @@ void perf_events_lapic_init(void)
 	/*
 	 * Always use NMI for PMU
 	 */
-	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	if (cpu_feature_enabled(X86_FEATURE_NMI_SOURCE))
+		apic_perfmon_ctr |= NMI_SOURCE_VEC_PMI;
+
+	apic_write(APIC_LVTPC, apic_perfmon_ctr);
 }
 
 static int
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 38c1b1f1deaa..b4a70457c678 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3093,7 +3093,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	 * NMI handler.
 	 */
 	if (!late_ack && !mid_ack)
-		apic_write(APIC_LVTPC, APIC_DM_NMI);
+		apic_write(APIC_LVTPC, apic_perfmon_ctr);
 	intel_bts_disable_local();
 	cpuc->enabled = 0;
 	__intel_pmu_disable_all(true);
@@ -3130,7 +3130,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 
 done:
 	if (mid_ack)
-		apic_write(APIC_LVTPC, APIC_DM_NMI);
+		apic_write(APIC_LVTPC, apic_perfmon_ctr);
 	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
 	cpuc->enabled = pmu_enabled;
 	if (pmu_enabled)
@@ -3143,7 +3143,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	 * Haswell CPUs.
 	 */
 	if (late_ack)
-		apic_write(APIC_LVTPC, APIC_DM_NMI);
+		apic_write(APIC_LVTPC, apic_perfmon_ctr);
 	return handled;
 }
 
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9327eb00e96d..bcf8d17240c8 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -49,6 +49,7 @@ static inline void x86_32_probe_apic(void) { }
 #endif
 
 extern u32 cpuid_to_apicid[];
+extern u32 apic_perfmon_ctr;
 
 #define CPU_ACPIID_INVALID	U32_MAX
 
-- 
2.25.1

