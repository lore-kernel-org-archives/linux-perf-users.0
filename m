Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368B722B8AA;
	Tue, 18 Feb 2025 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866456; cv=none; b=h/O/l7n0dqLwhhPxA+aMibOdvuT6VakNwhiKlHRlsY9SJbAet4jGIwP6iY9oVp7H9W/j73uh9i3P45jCOI3cwwPF90nl2ib8N91ytWSvk0YOQA71JmcaU6JCYkLgGGyuRkXm+fZR9nddPqHm23LsaEyM5hxQ0Gio/u2c9Z/A7nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866456; c=relaxed/simple;
	bh=jWLet2wrtoUWjmfoTwtF7/G2riMhMfoYKYV6FHLV/AQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y3vcUT0QWuO6PZkuy2I/3iIzPyIeBmot9pmlILDu6NoeQgZCHEiTrJHSPzJtkqNuMIN/HJDszXvEJ0l+FZjkumX5LxGTcfC4wLlYw+uuVHE2u3DRYJqDX4tcdyw4xuVSKfvYMLTaVbREQ8TFpccKjE1MnWNLeTTfCtxeBUbzkyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGMhmsOu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGMhmsOu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866455; x=1771402455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jWLet2wrtoUWjmfoTwtF7/G2riMhMfoYKYV6FHLV/AQ=;
  b=aGMhmsOuZTLB89quEo1FuD7WtHi6pMY44EoPzASMXCTAO94muqyEikWV
   MCrZlFPceWO5KO6SpB9t+KA9BgkCKT5e34an+qZxDjskvVAXwNsEq7Kul
   Xt50nZbpo5LmiSF2yZXH69BSM9CNfMElqri15WPjjAo9+MPNEJ5zJcYZx
   J8AnaKxk+0W5eI00DlsFPZjM/m8AjC/8dwK3M3lRhniVJfbgPPX7ao6do
   GZyVRLYEZ/JGbjh7Mwk59bvamq7oxsrABhWW1XSzjhDyE+fmwfObyOK9z
   qiSMG/HfnySu46rL4QmDrwYzgwK6TzivPj07Gd11BSuhSRpNA5SvWNOz6
   A==;
X-CSE-ConnectionGUID: 6PVqSNH/R6ySP/w+mxLBsw==
X-CSE-MsgGUID: J7XubUuDR46WYpV+51SUww==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200770"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200770"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:14:14 -0800
X-CSE-ConnectionGUID: OD7kVZgDSCGgYXOMlzVYyw==
X-CSE-MsgGUID: RIR/HFc9RjOupMX17XOcTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166186"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:14:08 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 07/24] perf/x86/intel: Introduce pairs of PEBS static calls
Date: Tue, 18 Feb 2025 15:28:01 +0000
Message-Id: <20250218152818.158614-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arch-PEBS retires IA32_PEBS_ENABLE and MSR_PEBS_DATA_CFG MSRs, so
intel_pmu_pebs_enable/disable() and intel_pmu_pebs_enable/disable_all()
are not needed to call for ach-PEBS.

To make code cleaner, introduces static calls
x86_pmu_pebs_enable/disable() and x86_pmu_pebs_enable/disable_all()
instead of adding "x86_pmu.arch_pebs" check directly in these helpers.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c       | 10 ++++++++++
 arch/x86/events/intel/core.c |  8 ++++----
 arch/x86/events/intel/ds.c   |  5 +++++
 arch/x86/events/perf_event.h |  8 ++++++++
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 883e0ee893cb..1c2ff407ef17 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -96,6 +96,11 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_filter, *x86_pmu.filter);
 
 DEFINE_STATIC_CALL_NULL(x86_pmu_late_setup, *x86_pmu.late_setup);
 
+DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_enable, *x86_pmu.pebs_enable);
+DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_disable, *x86_pmu.pebs_disable);
+DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_enable_all, *x86_pmu.pebs_enable_all);
+DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_disable_all, *x86_pmu.pebs_disable_all);
+
 /*
  * This one is magic, it will get called even when PMU init fails (because
  * there is no PMU), in which case it should simply return NULL.
@@ -2049,6 +2054,11 @@ static void x86_pmu_static_call_update(void)
 	static_call_update(x86_pmu_filter, x86_pmu.filter);
 
 	static_call_update(x86_pmu_late_setup, x86_pmu.late_setup);
+
+	static_call_update(x86_pmu_pebs_enable, x86_pmu.pebs_enable);
+	static_call_update(x86_pmu_pebs_disable, x86_pmu.pebs_disable);
+	static_call_update(x86_pmu_pebs_enable_all, x86_pmu.pebs_enable_all);
+	static_call_update(x86_pmu_pebs_disable_all, x86_pmu.pebs_disable_all);
 }
 
 static void _x86_pmu_read(struct perf_event *event)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f45296f30ec2..41c7243a4507 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2312,7 +2312,7 @@ static __always_inline void __intel_pmu_disable_all(bool bts)
 static __always_inline void intel_pmu_disable_all(void)
 {
 	__intel_pmu_disable_all(true);
-	intel_pmu_pebs_disable_all();
+	static_call_cond(x86_pmu_pebs_disable_all)();
 	intel_pmu_lbr_disable_all();
 }
 
@@ -2344,7 +2344,7 @@ static void __intel_pmu_enable_all(int added, bool pmi)
 
 static void intel_pmu_enable_all(int added)
 {
-	intel_pmu_pebs_enable_all();
+	static_call_cond(x86_pmu_pebs_enable_all)();
 	__intel_pmu_enable_all(added, false);
 }
 
@@ -2601,7 +2601,7 @@ static void intel_pmu_disable_event(struct perf_event *event)
 	 * so we don't trigger the event without PEBS bit set.
 	 */
 	if (unlikely(event->attr.precise_ip))
-		intel_pmu_pebs_disable(event);
+		static_call(x86_pmu_pebs_disable)(event);
 }
 
 static void intel_pmu_assign_event(struct perf_event *event, int idx)
@@ -2905,7 +2905,7 @@ static void intel_pmu_enable_event(struct perf_event *event)
 	int idx = hwc->idx;
 
 	if (unlikely(event->attr.precise_ip))
-		intel_pmu_pebs_enable(event);
+		static_call(x86_pmu_pebs_enable)(event);
 
 	switch (idx) {
 	case 0 ... INTEL_PMC_IDX_FIXED - 1:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 2a4dc0bbc4f7..ab4a9a01336d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2674,6 +2674,11 @@ void __init intel_pebs_init(void)
 		if (format < 4)
 			x86_pmu.intel_cap.pebs_baseline = 0;
 
+		x86_pmu.pebs_enable = intel_pmu_pebs_enable;
+		x86_pmu.pebs_disable = intel_pmu_pebs_disable;
+		x86_pmu.pebs_enable_all = intel_pmu_pebs_enable_all;
+		x86_pmu.pebs_disable_all = intel_pmu_pebs_disable_all;
+
 		switch (format) {
 		case 0:
 			pr_cont("PEBS fmt0%c, ", pebs_type);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 1e7884fdd990..4bc6c9d66b94 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -806,6 +806,10 @@ struct x86_pmu {
 	int		(*hw_config)(struct perf_event *event);
 	int		(*schedule_events)(struct cpu_hw_events *cpuc, int n, int *assign);
 	void		(*late_setup)(void);
+	void		(*pebs_enable)(struct perf_event *event);
+	void		(*pebs_disable)(struct perf_event *event);
+	void		(*pebs_enable_all)(void);
+	void		(*pebs_disable_all)(void);
 	unsigned	eventsel;
 	unsigned	perfctr;
 	unsigned	fixedctr;
@@ -1116,6 +1120,10 @@ DECLARE_STATIC_CALL(x86_pmu_set_period, *x86_pmu.set_period);
 DECLARE_STATIC_CALL(x86_pmu_update,     *x86_pmu.update);
 DECLARE_STATIC_CALL(x86_pmu_drain_pebs,	*x86_pmu.drain_pebs);
 DECLARE_STATIC_CALL(x86_pmu_late_setup,	*x86_pmu.late_setup);
+DECLARE_STATIC_CALL(x86_pmu_pebs_enable, *x86_pmu.pebs_enable);
+DECLARE_STATIC_CALL(x86_pmu_pebs_disable, *x86_pmu.pebs_disable);
+DECLARE_STATIC_CALL(x86_pmu_pebs_enable_all, *x86_pmu.pebs_enable_all);
+DECLARE_STATIC_CALL(x86_pmu_pebs_disable_all, *x86_pmu.pebs_disable_all);
 
 static __always_inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
 {
-- 
2.40.1

