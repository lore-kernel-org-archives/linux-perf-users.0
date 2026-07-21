Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE63840BCB0;
	Tue, 21 Jul 2026 06:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615587; cv=none; b=bLPenCfyMp1+1Ine7W3jhKBJPyQ4ja4s4rgbSjPIe6Eyx6Z1QwUOKzCprxLOsZ3oQHNOPNZBVSAmK0ozuFpxza+i2berjCdr16ZvnbDPsLNiSoOJ5sA6p1jXSZcu4uch4v1iLLeKkfwuUXyCLkBIJfjV/2qZY9zF7Gqj9RxX420=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615587; c=relaxed/simple;
	bh=q7EfxZhxk9GaeSrbQBbNNUxLXU7Pe+i2cmbda4q+0wk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qvNBsxVVmyQv5qD5MFcaeKcbZYxsxi2RsH8CZP1QVEEhBDZwz31EQpvgXkr5142oPmH+yCycWHXFrsuvkXZ/4NKP01R8qoV07I5nbP9sd/977MI3XPSI0MrDM1Ra00EDw264iUTVr4MuryaBcpMWmYTErbF7lKbuMbietYGntL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0/c48u/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0/c48u/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784615586; x=1816151586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q7EfxZhxk9GaeSrbQBbNNUxLXU7Pe+i2cmbda4q+0wk=;
  b=N0/c48u/hyQKIHuG6f4hYw7VeWJz5/zreGXW4VmlRp27f82luDIqzz/r
   aXYZ34ZJP7aRHtimMhmrGa6AwFeB/YEZezRSsHd41EEyiMlDSHeBb9YB2
   tV4AAZ/cg+uWT/m0l6MEdSAzWhxragDrpAhPQvGLfiCD1NtwrNcQdHVur
   Za1kb6b8nxsZRMQl9DT1DHJFVcrLYLbWaeeN0TEeQMYvYQyvMQZ5F+pYR
   vz3GTkg0W8KbcJABew+wJimQLez1SlfpxODajx/Rxgg/uR846RmYcYN2f
   itbE1OrZsFz+Z4q0W6s49p2N+5QDnK5WDVL1nQfVZaS+ELqbszVtItt51
   w==;
X-CSE-ConnectionGUID: dGurNPAgR+evP8nkIx1MAw==
X-CSE-MsgGUID: 06hWn7MbQdS7sihWr4HSzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95565441"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="95565441"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 23:33:06 -0700
X-CSE-ConnectionGUID: 51fSS27kQK+lpoJu88UBvw==
X-CSE-MsgGUID: hJurwxPgTOqVnbZJxMuigg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="259656011"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jul 2026 23:32:59 -0700
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
Subject: [Patch v10 09/23] perf/x86/intel: Centralize PERF_PMU_CAP_EXTENDED_REGS updates
Date: Tue, 21 Jul 2026 14:24:52 +0800
Message-Id: <20260721062506.3745816-10-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
References: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PERF_PMU_CAP_EXTENDED_REGS is currently updated in multiple paths:
intel_ds_pebs_init() and __intel_update_pmu_caps() for adaptive and
architectural PEBS. This split makes the capability flow harder to
reason about and is awkward for upcoming XSAVES-based SIMD register
sampling, which also needs consistent capability setup and validation.

Refactor the update logic into a single helper,
__intel_update_pmu_xregs_caps(), so adaptive and architectural PEBS
share one implementation.

Call this helper from intel_update_pmu_caps() to keep PMU capability
handling centralized in one place and avoid duplicated or conflicting
updates.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 16 ++++++++--------
 arch/x86/events/intel/ds.c   |  1 -
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ee62b24d3fdf..aecaa109c31e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6187,11 +6187,14 @@ static inline bool intel_pmu_broken_perf_cap(void)
 	return false;
 }
 
-static inline void __intel_update_pmu_caps(struct pmu *pmu)
+static inline void __intel_update_pmu_xregs_caps(struct pmu *pmu)
 {
 	struct pmu *dest_pmu = pmu ? pmu : x86_get_pmu(smp_processor_id());
+	u64 caps = hybrid(pmu, arch_pebs_cap).caps;
 
-	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_VECR_XMM)
+	if ((x86_pmu.arch_pebs && (caps & ARCH_PEBS_VECR_XMM)) ||
+	    (!x86_pmu.arch_pebs && x86_pmu.intel_cap.pebs_format >= 4 &&
+	     x86_pmu.intel_cap.pebs_baseline))
 		dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 }
 
@@ -6263,12 +6266,10 @@ static void update_pmu_cap_from_perfmonext(struct pmu *pmu)
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
@@ -6292,6 +6293,7 @@ static void intel_update_pmu_caps(struct pmu *pmu)
 		    hybrid_pmu(pmu)->pmu_type == hybrid_big)
 			hybrid(pmu, intel_cap).perf_metrics = 1;
 	}
+	__intel_update_pmu_xregs_caps(pmu);
 }
 
 static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
@@ -6445,8 +6447,6 @@ static void intel_pmu_cpu_starting(int cpu)
 		}
 	}
 
-	__intel_update_pmu_caps(cpuc->pmu);
-
 	if (!cpuc->shared_regs)
 		return;
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 9355744a9258..d50d9de6c17f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -3389,7 +3389,6 @@ static void __init intel_ds_pebs_init(void)
 				x86_pmu.flags |= PMU_FL_PEBS_ALL;
 				x86_pmu.pebs_capable = ~0ULL;
 				pebs_qual = "-baseline";
-				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 			} else {
 				/* Only basic record supported */
 				x86_pmu.large_pebs_flags &=
-- 
2.34.1

