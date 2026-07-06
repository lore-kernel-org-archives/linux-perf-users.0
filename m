Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E2361667;
	Mon,  6 Jul 2026 02:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303275; cv=none; b=TSF04FuUsBBHZ/zFhnQnqFUGcFtfcUuL60NdPoVhg5vPCT/B0ilqksO5SyEQ/kyXg6d7x9Wl5oLlvEaAvxl2gHG5oM5UHPL6szwCSCKTzFPX1SyMo9s7DP9WpYgGeqvkL0ImPWsnie+UgXtzVJHOCCnNjaI9xCg6Pbxo2G6abg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303275; c=relaxed/simple;
	bh=PnwZq7CpvwIYtDXRF8Um/Ylge+RQ63Z6Nw24x/YpL8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mBPL/pbUZKDYFhthT21rjdB/Oe6OYLM6rjr4R3VFxoVyRku2aCyXLipuGWJFEAwYsExkF8Wryt5ol4v5pGg0SD2kmn27AG0KoQ4WeEw/jBzxPh+8QPjMwAi7dRqrGjcmZ8CV+XSutQv4o1avSXQqP2+2a8PZ9M7PYP99IhpNd14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RyDm49ur; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RyDm49ur"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783303274; x=1814839274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PnwZq7CpvwIYtDXRF8Um/Ylge+RQ63Z6Nw24x/YpL8k=;
  b=RyDm49urv4AwLPmSOz5hVFvQA/Vgi/SQFqXnOQ6oa5EEVlYVwSaVgqrP
   xoYU68zYeqEPSGW27i7ldEHfOLnwX8CFqRm071d+MfqSOaj/zDwH5v6vQ
   EGGKwgJ/Y5AuBIksRtThU4ZabcOYtjh8m4f5XYwSZ5iEI2YnViZq1s/+o
   MQSiSep+Y4FXxdTGAhrfGHwsiOu5rFf2wRJ9+cKcK6ATPEF431UQbX5aN
   rDnnguc0vMU1W+LRkWg7TOC/mC/QMtZdkBladHTGcbsuKznhFx3r6Nkhv
   qSEqD2DVqNzqVePFUHIKLbiJIwpogF7DuVGWpHUtJoUhpUnRFA5byqOft
   w==;
X-CSE-ConnectionGUID: bg9TxbqCRgWUL8E+prETFw==
X-CSE-MsgGUID: wTJKToQhRLm/TT1xOiwc1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83911543"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83911543"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:01:14 -0700
X-CSE-ConnectionGUID: t1u8eNAcTJaOgUff6E9lpw==
X-CSE-MsgGUID: xavTVBZwQv+GXB6uEireWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="247191249"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jul 2026 19:01:09 -0700
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
Subject: [Patch v9 01/24] perf/x86: Fix two error-path and hybrid PMU guard issues
Date: Mon,  6 Jul 2026 09:54:16 +0800
Message-Id: <20260706015439.3040804-2-dapeng1.mi@linux.intel.com>
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

Fix an NMI handler leak in init_hw_perf_events(). When PMU
initialization fails after register_nmi_handler(), the error path
exits without calling unregister_nmi_handler(), leaving a stale
NMI_LOCAL "PMI" handler registered. Add the missing call before
clearing x86_pmu state.

Also guard the hybrid PMU cpumask update in intel_pmu_cpu_dead()
with a check on x86_pmu.num_hybrid_pmus. Without this, hybrid_pmu()
may be called when the hybrid PMU array has not been allocated,
leading to an out-of-bounds access.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c       | 4 +++-
 arch/x86/events/intel/core.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index af0b67ffb43d..872d07a5fa80 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2219,7 +2219,7 @@ static int __init init_hw_perf_events(void)
 	err = cpuhp_setup_state(CPUHP_PERF_X86_PREPARE, "perf/x86:prepare",
 				x86_pmu_prepare_cpu, x86_pmu_dead_cpu);
 	if (err)
-		return err;
+		goto pmi_unregister;
 
 	err = cpuhp_setup_state(CPUHP_AP_PERF_X86_STARTING,
 				"perf/x86:starting", x86_pmu_starting_cpu,
@@ -2273,6 +2273,8 @@ static int __init init_hw_perf_events(void)
 	cpuhp_remove_state(CPUHP_AP_PERF_X86_STARTING);
 out:
 	cpuhp_remove_state(CPUHP_PERF_X86_PREPARE);
+pmi_unregister:
+	unregister_nmi_handler(NMI_LOCAL, "PMI");
 out_bad_pmu:
 	memset(&x86_pmu, 0, sizeof(x86_pmu));
 	return err;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b39c6ce0efb5..b8a6382dbb82 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6479,7 +6479,7 @@ static void intel_pmu_cpu_dead(int cpu)
 	release_arch_pebs_buf_on_cpu(cpu);
 	intel_cpuc_finish(cpuc);
 
-	if (is_hybrid() && cpuc->pmu)
+	if (is_hybrid() && x86_pmu.num_hybrid_pmus && cpuc->pmu)
 		cpumask_clear_cpu(cpu, &hybrid_pmu(cpuc->pmu)->supported_cpus);
 }
 
-- 
2.34.1

