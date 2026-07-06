Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6174B361667;
	Mon,  6 Jul 2026 02:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303318; cv=none; b=HB//5QGlFtOMqqmfLXIn39Wj5pGLRciC80K4YLB1T5uTZBqBN6v4QDeZyqgtjNHcFEbW5xQgF56380zEdiWb0tFqsJKKwCJg/ZM05c8V3rVEx0lmyaz0tI132YSeOJw/h6pLsjxaA1fwchWqZElxA6dtx4EbpIn65hfGCOIL+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303318; c=relaxed/simple;
	bh=XX1HZjBwPvH5Iy9qjdy+8vKn9tw7pFlczJY2zCqRpVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A0w5L2BBB//FQkbpOW4b0U3TSPgiOpPry264csr1rZzq+j0imOGzdQccYLD6g49JMHb8tcD2iPzSCLf9jyHnTG2OYjPD2HT3yoQVRV46rIl5UT49jJit/0pns+wPv1ta74PaOVTSw59c08/IPyIyQxnOV/HSqPpWmdaaiBzkV4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVi2I6T/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVi2I6T/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783303318; x=1814839318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XX1HZjBwPvH5Iy9qjdy+8vKn9tw7pFlczJY2zCqRpVg=;
  b=eVi2I6T/mLowqqtgXKoJJAvXxcJz5IE2iRs8QE/bUKDu/zZBVejiu9Hj
   2lgNmjzoFDhxiLRNUoWqW1jLQxRc550TChC1xVYSOvnv0oWyc8DIeT81b
   5D5qhQy8MOi2miOSW2I94BKNgfrvbdEYrPlSvuSE7kmTTdbNp95fzaj6j
   in2G0HH5JdxO5XqhsgG8T6lLVfbCn0juHVjCktQx0TTiIfaleuXl/8vfB
   ax/q9LVfKOOBROEcyt7olBGIi6ILhxKji6uroiUHlR0HayF56KNq3YB9C
   FOn6++TxN0APcKbx7rHhfksKYW9Kxcf0q3igdRtL2wzPNFYnHGzoIQ3fS
   A==;
X-CSE-ConnectionGUID: l0QAao2wQQqUpCFhiJgUlQ==
X-CSE-MsgGUID: OlsWBVjeQ6GUW5jR0gZOqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83911642"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83911642"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:01:58 -0700
X-CSE-ConnectionGUID: Ikdd5N/cSgyap/2jrVyOFg==
X-CSE-MsgGUID: rRF3eK2JRsySGpvmEVJuWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="247191301"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jul 2026 19:01:52 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v9 10/24] perf/x86/intel: Consolidate PMU capability updates
Date: Mon,  6 Jul 2026 09:54:25 +0800
Message-Id: <20260706015439.3040804-11-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the PERF_PMU_CAP_EXTENDED_REGS capability is set in two
different places: intel_ds_pebs_init() and __intel_update_pmu_caps()
for adaptive and architectural PEBS. The upcoming XSAVES-based SIMD
register sampling will also require setting and validating this
capability. Managing it across multiple locations introduces
unnecessary complexity and potential conflicts.

To centralize and simplify the PERF_PMU_CAP_EXTENDED_REGS logic,
consolidate its initialization into a single helper function,
__intel_update_pmu_xregs_caps(), handling both adaptive and
architectural PEBS.

Additionally, optimize the capability update paths by moving the
initialization of intel_cap.capabilities out of the update_pmu_cap()
helper. The helper is guarded by archPerfmonExt support, whereas
intel_cap.capabilities is independent of it.

Finally, introduce a new wrapper function, intel_update_pmu_caps(),
to cleanly encapsulate all these PMU capability updates.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 54 ++++++++++++++++++++++++------------
 arch/x86/events/intel/ds.c   |  1 -
 2 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2e658b4bc83a..11a0c4dd2026 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6143,19 +6143,27 @@ static void intel_pmu_check_extra_regs(struct extra_reg *extra_regs);
 
 static inline bool intel_pmu_broken_perf_cap(void)
 {
-	/* The Perf Metric (Bit 15) is always cleared */
-	if (boot_cpu_data.x86_vfm == INTEL_METEORLAKE ||
+	/*
+	 * The Perf Metric (Bit 15) is always cleared on P-core of
+	 * PRL and MTL. Details can be found in RPL018 Errata Details.
+	 */
+	if (boot_cpu_data.x86_vfm == INTEL_RAPTORLAKE ||
+	    boot_cpu_data.x86_vfm == INTEL_RAPTORLAKE_P ||
+	    boot_cpu_data.x86_vfm == INTEL_RAPTORLAKE_S ||
+	    boot_cpu_data.x86_vfm == INTEL_METEORLAKE ||
 	    boot_cpu_data.x86_vfm == INTEL_METEORLAKE_L)
 		return true;
 
 	return false;
 }
 
-static inline void __intel_update_pmu_caps(struct pmu *pmu)
+static inline void __intel_update_pmu_xregs_caps(struct pmu *pmu)
 {
 	struct pmu *dest_pmu = pmu ? pmu : x86_get_pmu(smp_processor_id());
+	u64 caps = hybrid(pmu, arch_pebs_cap).caps;
 
-	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_VECR_XMM)
+	if ((x86_pmu.arch_pebs && (caps & ARCH_PEBS_VECR_XMM)) ||
+	    (x86_pmu.intel_cap.pebs_format >= 4 && x86_pmu.intel_cap.pebs_baseline))
 		dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 }
 
@@ -6179,7 +6187,7 @@ static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
 
 #define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_IDX_FIXED))
 
-static void update_pmu_cap(struct pmu *pmu)
+static void update_pmu_cap_from_perfmonext(struct pmu *pmu)
 {
 	unsigned int eax, ebx, ecx, edx;
 	union cpuid35_eax eax_0;
@@ -6227,21 +6235,34 @@ static void update_pmu_cap(struct pmu *pmu)
 		hybrid(pmu, arch_pebs_cap).counters = pebs_mask;
 		hybrid(pmu, arch_pebs_cap).pdists = pdists_mask;
 
-		if (WARN_ON((pebs_mask | pdists_mask) & ~cntrs_mask)) {
+		if (WARN_ON((pebs_mask | pdists_mask) & ~cntrs_mask))
 			x86_pmu.arch_pebs = 0;
-		} else {
-			__intel_update_pmu_caps(pmu);
+		else
 			__intel_update_large_pebs_flags(pmu);
-		}
 	} else {
 		WARN_ON(x86_pmu.arch_pebs == 1);
 		x86_pmu.arch_pebs = 0;
 	}
+}
 
-	if (!intel_pmu_broken_perf_cap()) {
-		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
-		rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
+static void intel_update_pmu_caps(struct pmu *pmu)
+{
+	if (this_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
+		update_pmu_cap_from_perfmonext(pmu);
+
+	if (is_hybrid() && this_cpu_has(X86_FEATURE_PDCM)) {
+		rdmsrq(MSR_IA32_PERF_CAPABILITIES,
+		       hybrid(pmu, intel_cap).capabilities);
+
+		/*
+		 * Restore perf_metrics on platforms with broken
+		 * perf_capablities.
+		 */
+		if (intel_pmu_broken_perf_cap() &&
+		    hybrid_pmu(pmu)->pmu_type == hybrid_big)
+			hybrid(pmu, intel_cap).perf_metrics = 1;
 	}
+	__intel_update_pmu_xregs_caps(pmu);
 }
 
 static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
@@ -6325,8 +6346,7 @@ static bool init_hybrid_pmu(int cpu)
 	if (!cpumask_empty(&pmu->supported_cpus))
 		goto end;
 
-	if (this_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
-		update_pmu_cap(&pmu->pmu);
+	intel_update_pmu_caps(&pmu->pmu);
 
 	intel_pmu_check_hybrid_pmus(pmu);
 
@@ -6395,8 +6415,6 @@ static void intel_pmu_cpu_starting(int cpu)
 		}
 	}
 
-	__intel_update_pmu_caps(cpuc->pmu);
-
 	if (!cpuc->shared_regs)
 		return;
 
@@ -8821,8 +8839,8 @@ __init int intel_pmu_init(void)
 	 * from the leaf 0xa. The core specific update will be done later
 	 * when a new type is online.
 	 */
-	if (!is_hybrid() && boot_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
-		update_pmu_cap(NULL);
+	if (!is_hybrid())
+		intel_update_pmu_caps(NULL);
 
 	if (x86_pmu.arch_pebs) {
 		static_call_update(intel_pmu_disable_event_ext,
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7b69f8c8d0c2..78b9c0dcb14d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -3396,7 +3396,6 @@ static void __init intel_ds_pebs_init(void)
 				x86_pmu.flags |= PMU_FL_PEBS_ALL;
 				x86_pmu.pebs_capable = ~0ULL;
 				pebs_qual = "-baseline";
-				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 			} else {
 				/* Only basic record supported */
 				x86_pmu.large_pebs_flags &=
-- 
2.34.1

