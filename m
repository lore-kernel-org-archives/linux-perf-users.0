Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840861C9EA1;
	Wed, 29 May 2024 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717014519; cv=none; b=kDp1SLFe+AIniobQtlRbAdP5glOJShn4xINbvxYS1e0PuI05NOzSuAfaMn+fA59ixIlopqOt2/H4f917rly/OfA89O6xKs0/IKuptbzUzv98Bl1krZVi+A993oERH137m4hyK0tbIjODpxFhIPYzbFv9PqVovguAKiyANSk37/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717014519; c=relaxed/simple;
	bh=rcS88EGxEczwKZqGchK9BbjqykpecfivATqJO505QHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ad9fBdaIJxItoMyHq0NVfaGICw94+pSE4lWy4/iUC4/g6ENtg9PGaIL8zNB/CCUIkLA2/N2GeZmXNIGvMNRzpTNgRemakD8aV7rUihuos63QV6BywikOj0ItYtKbpbrhQsD7ruf40rWqUAABtxId+EEPtY4XMibz9KO4aZh9l2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QYx+SDwx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QYx+SDwx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717014518; x=1748550518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rcS88EGxEczwKZqGchK9BbjqykpecfivATqJO505QHU=;
  b=QYx+SDwxaodHPyZ9krqdZVd9eL4eI5Pg4HvKQethhKGkzUB9wNvqzR/I
   7kznkb9fFLmQWY+JQuvd0zzNhlV/SDkbb8YIqW8HC94nwUqpGXiAwu+VR
   9vmD4VAnekjuXjDV8hcrYi4pvKtGel7ycDoufchWD8XWF0ZpL8AV7eXzn
   WrmMtdC0bf33OjjOsYTlzsDe7mTZANJnkZA5ctBJiTSsb7D01cb/cuZ8s
   +Qy3adqFTT/oQEdhHlFPSGEzXA4wdT6VwUWYcwdZ/TJ3u2G82GalBRGrz
   kBRCA1YbomKBGfEetDMY92ergyBt7OFl+2kvPow4WprDYxAIYZq72QwJl
   A==;
X-CSE-ConnectionGUID: 1kxOJGOFQRiPhNKPmx4w9g==
X-CSE-MsgGUID: B6ajrsXtRHGRgm38E/Vj2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13574565"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13574565"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 13:28:35 -0700
X-CSE-ConnectionGUID: XKmrw6dtReyWeL+mmZtZ4w==
X-CSE-MsgGUID: IpntXb8LSOyRhdXzO8EvoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35491292"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa007.fm.intel.com with ESMTP; 29 May 2024 13:28:34 -0700
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
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 5/6] perf/x86: Enable NMI source reporting for perfmon
Date: Wed, 29 May 2024 13:33:24 -0700
Message-Id: <20240529203325.3039243-6-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240529203325.3039243-1-jacob.jun.pan@linux.intel.com>
References: <20240529203325.3039243-1-jacob.jun.pan@linux.intel.com>
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

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
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
index 9327eb00e96d..062a6edd36d3 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -59,6 +59,7 @@ extern int local_apic_timer_c2_ok;
 
 extern bool apic_is_disabled;
 extern unsigned int lapic_timer_period;
+extern u32 apic_perfmon_ctr;
 
 extern enum apic_intr_mode_id apic_intr_mode;
 enum apic_intr_mode_id {
-- 
2.25.1

