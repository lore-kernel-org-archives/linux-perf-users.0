Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A254D3B38BE;
	Fri, 10 Jul 2026 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783666681; cv=none; b=h1rEz7QvvNzGrS+XfIONz95/MBOdTpfMa10o2OsoQEtWWL8Qryegm/mxONO746D/0hlRQXEhHnhpeFtPQBaJIAt4cIy+iDHC0GJio78F8m4cp4eUlK4IVD8h6PoEdoGi5nhLhPmenWChQcQr9FVqNcwJNUdVjuqxt+IQh169b58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783666681; c=relaxed/simple;
	bh=vZ0EJwDOuH1uBpTTGpUp/6DImqmBT4NinNT/N/xe2zA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t7NSVAQOE+wZSc2f/uqldEHSrtNsgIkS4/4NRb6ZUcjMFiO1cAOcgHMEyAxsptmSHIP3u8Bc5j+2OsujTbSFPStnbhtsoUuAL81s9wtLynvqNdTk5CaldeZxBJGdrsm1skpUHWiW8rQTDQGf0QHfyIpoBZ8E1htJNsSu0XQFEBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jFHf8yg1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jFHf8yg1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783666676; x=1815202676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vZ0EJwDOuH1uBpTTGpUp/6DImqmBT4NinNT/N/xe2zA=;
  b=jFHf8yg1ahpK8NtrI1Eg1HhmGgsuyCOWXM3buorYk8w9sywb8aEqHC5x
   nos9TpsdVEKzowz3PUpbKHmHRNwhpde3XRkRaZpARi9C+5bdSbf2xjsof
   Flg0D4EEu85SjcOujB9V6MKrIVBC4i+ZoJqyte/uS/6fWSYNlFtfU8D61
   2EYxy+Z2a6ny3kzvt9VovRIWEcQlRND+EB6OwaMJIGqsCSebdegThpKte
   ZFsvMIOufemHWbrKcN53HACVIDTQMZ50OO4dP16zfnqTLU1xyXuYJm9f4
   oFDeEtvkhInZ1lubXOYRG2Xazf8bJkq2NvETyxY5i5VpsmH0bC5Mp8lzj
   A==;
X-CSE-ConnectionGUID: nmxz+jTJQUOcovso8jNCoQ==
X-CSE-MsgGUID: F/xAG1gcTEOkE/yrnxYSDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84554227"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84554227"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 23:57:55 -0700
X-CSE-ConnectionGUID: o+1SlUTeT/eZFP2LtU/AoQ==
X-CSE-MsgGUID: hXkQkMmhRsmg7TEvraR3Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252159238"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 09 Jul 2026 23:57:50 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 5/7] perf/x86: Remove stale fixed counter helper and fix hybrid PMU access
Date: Fri, 10 Jul 2026 14:51:26 +0800
Message-Id: <20260710065128.1799838-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710065128.1799838-1-dapeng1.mi@linux.intel.com>
References: <20260710065128.1799838-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On hybrid systems, init_hw_perf_events() can call check_hw_exists() with
the global PMU pointer after perf_is_hybrid is set. In that case,
fixed_counter_disabled() uses hybrid() on a non-hybrid PMU object, so the
intel_ctrl access is taken from the wrong layout and can read out of
bounds.

fixed_counter_disabled() was added in commit 32451614da2a
("perf/x86/intel: Support CPUID 10.ECX to disable fixed counters"), when
fixed counters were tracked via num_fixed_counters. Today fixed counters
are represented by fixed_cntr_mask, so this helper is obsolete.

Remove fixed_counter_disabled() and its callers, and rely directly on the
fixed-counter bitmask. With the helper gone, check_hw_exists() no longer
needs a PMU argument, so drop that parameter as well. This removes the
invalid hybrid access and closes the out-of-bounds read risk.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c       | 8 ++------
 arch/x86/events/intel/core.c | 4 +---
 arch/x86/events/perf_event.h | 9 +--------
 3 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 6c63b27e11e6..0bd3798b6e33 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -265,7 +265,7 @@ static void release_pmc_hardware(void) {}
 
 #endif
 
-bool check_hw_exists(struct pmu *pmu, unsigned long *cntr_mask,
+bool check_hw_exists(unsigned long *cntr_mask,
 		     unsigned long *fixed_cntr_mask)
 {
 	u64 val, val_fail = -1, val_new= ~0;
@@ -297,8 +297,6 @@ bool check_hw_exists(struct pmu *pmu, unsigned long *cntr_mask,
 		if (ret)
 			goto msr_fail;
 		for_each_set_bit(i, fixed_cntr_mask, X86_PMC_IDX_MAX) {
-			if (fixed_counter_disabled(i, pmu))
-				continue;
 			if (val & (0x03ULL << i*4)) {
 				bios_fail = 1;
 				val_fail = val;
@@ -1613,8 +1611,6 @@ void perf_event_print_debug(void)
 			cpu, idx, prev_left);
 	}
 	for_each_set_bit(idx, fixed_cntr_mask, X86_PMC_IDX_MAX) {
-		if (fixed_counter_disabled(idx, cpuc->pmu))
-			continue;
 		rdmsrq(x86_pmu_fixed_ctr_addr(idx), pmc_count);
 
 		pr_info("CPU#%d: fixed-PMC%d count: %016llx\n",
@@ -2175,7 +2171,7 @@ static int __init init_hw_perf_events(void)
 	pmu_check_apic();
 
 	/* sanity check that the hardware exists or is emulated */
-	if (!check_hw_exists(&pmu, x86_pmu.cntr_mask, x86_pmu.fixed_cntr_mask))
+	if (!check_hw_exists(x86_pmu.cntr_mask, x86_pmu.fixed_cntr_mask))
 		goto out_bad_pmu;
 
 	pr_cont("%s PMU driver.\n", x86_pmu.name);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 737c5a070379..83c60ad00085 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3713,8 +3713,6 @@ static void intel_pmu_reset(void)
 		wrmsrq_safe(x86_pmu_event_addr(idx),  0ull);
 	}
 	for_each_set_bit(idx, fixed_cntr_mask, INTEL_PMC_MAX_FIXED) {
-		if (fixed_counter_disabled(idx, cpuc->pmu))
-			continue;
 		wrmsrq_safe(x86_pmu_fixed_ctr_addr(idx), 0ull);
 	}
 
@@ -6336,7 +6334,7 @@ static bool init_hybrid_pmu(int cpu)
 
 	intel_pmu_check_hybrid_pmus(pmu);
 
-	if (!check_hw_exists(&pmu->pmu, pmu->cntr_mask, pmu->fixed_cntr_mask)) {
+	if (!check_hw_exists(pmu->cntr_mask, pmu->fixed_cntr_mask)) {
 		cpuc->pmu = NULL;
 		return false;
 	}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a8afea8d38f0..088f7ce715df 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1242,7 +1242,7 @@ static inline int x86_pmu_rdpmc_index(int index)
 	return x86_pmu.rdpmc_index ? x86_pmu.rdpmc_index(index) : index;
 }
 
-bool check_hw_exists(struct pmu *pmu, unsigned long *cntr_mask,
+bool check_hw_exists(unsigned long *cntr_mask,
 		     unsigned long *fixed_cntr_mask);
 
 int x86_add_exclusive(unsigned int what);
@@ -1455,13 +1455,6 @@ ssize_t events_hybrid_sysfs_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *page);
 
-static inline bool fixed_counter_disabled(int i, struct pmu *pmu)
-{
-	u64 intel_ctrl = hybrid(pmu, intel_ctrl);
-
-	return !(intel_ctrl >> (i + INTEL_PMC_IDX_FIXED));
-}
-
 #ifdef CONFIG_CPU_SUP_AMD
 
 int amd_pmu_init(void);
-- 
2.34.1

