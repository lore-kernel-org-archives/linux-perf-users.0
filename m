Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28187E103;
	Fri, 28 Jun 2024 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605617; cv=none; b=XzI73I7F9+k47XUQmwP8JyfXTY7S6bT90vVGAYXCyfdkqx3RwTF+8NK0gdRr4B4pa6K2gEijyQHQXpGjCLg7HZNNDFKXuj5DaYYKEFQKTYSCGzUw0nzU0QY/5w6GWYYqom7NyMDkSEVjizj3EIkfmztoZA5Cr4xfCVbhuHiH8rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605617; c=relaxed/simple;
	bh=k6q6WxbyXw0+7mPgcDLUOmJB6APsUSfvyDqOQXl4s+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gy/do5+3mU+YG1OkJ22G2pg//H3o7n1PRBP2JjwdTDzxPc9tcYXH0Ii0EIjtKkl+ezZBif/LbqGhkRxCp/RkEMPFBSGR/6vyTn8ZJO0M+Xldx81SIxyp13HXpv8qY6PdNp6GapP4ACOWPqrhA81TY3QCTw6AnrcigV9HV955gqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z009rNsG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z009rNsG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719605615; x=1751141615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k6q6WxbyXw0+7mPgcDLUOmJB6APsUSfvyDqOQXl4s+Q=;
  b=Z009rNsGqt+1frZoSbqpWDiOhztRUuA7LFW6K4NtN8zHuMqtrSJFlVEA
   7vGdpdcIB/uAbfJBjHJtZjpomsP0LhvYKAWGJnaGeQ3w6oicycO35Bgeg
   O1xVE3s/p3rTHqC5e/LjKeRRMp8Oz2oBqRsr3IQTInZxSRmZBSbDgHtZ+
   QZ8gi+qmiQNcJt2PhMrqSONM4SpMHdyY53NEOdDIf7jYmYscsp7eVbMmP
   aisJ9bMpKJXwXn1oUZXYrvtH9083x/DTuOrywn4nH/sM1D9WZhEMR5/XS
   79zOSri/HzhN/h75OL4270Yu7Q6RHaUZNLj920XXtobB1bXtfzZWE0LhC
   Q==;
X-CSE-ConnectionGUID: DfgKSmFEQr21PmEXHQVxLA==
X-CSE-MsgGUID: UmFxBJD1SJuC1QP+RjQeQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="12307028"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="12307028"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:13:33 -0700
X-CSE-ConnectionGUID: IpoE4qTESu6CEJKscEUvLw==
X-CSE-MsgGUID: VUV5Dq8DS/GtHs234Yo4JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49312597"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa005.fm.intel.com with ESMTP; 28 Jun 2024 13:13:33 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: X86 Kernel <x86@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Ingo Molnar" <mingo@redhat.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Xin Li" <xin3.li@intel.com>,
	linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Tony Luck <tony.luck@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	acme@kernel.org,
	kan.liang@linux.intel.com,
	Andi Kleen <andi.kleen@intel.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Zeng Guang <guang.zeng@intel.com>
Subject: [PATCH v3 08/11] perf/x86: Enable NMI source reporting for perfmon
Date: Fri, 28 Jun 2024 13:18:36 -0700
Message-Id: <20240628201839.673086-9-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
References: <20240628201839.673086-1-jacob.jun.pan@linux.intel.com>
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
Signed-off-by: Zeng Guang <guang.zeng@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

---
v3: Program NMI source vector in PVTPC unconditionally (HPA)
v2: Fix a compile error apic_perfmon_ctr is undefined in i386 config
---
 arch/x86/events/core.c       | 6 ++++--
 arch/x86/events/intel/core.c | 6 +++---
 arch/x86/include/asm/apic.h  | 1 +
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1ef2201e48ac..be75bdcdd400 100644
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
@@ -1723,7 +1724,8 @@ void perf_events_lapic_init(void)
 	/*
 	 * Always use NMI for PMU
 	 */
-	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	apic_perfmon_ctr |= NMI_SOURCE_VEC_PMI;
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

