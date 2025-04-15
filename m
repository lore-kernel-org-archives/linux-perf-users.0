Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D010192D97;
	Tue, 15 Apr 2025 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705412; cv=none; b=R5mhlyX/8ol6kgnKuPOa6tgRfEPkgrcF0+3P5KZzd+0UabH9CWPBmym2u/mxxHErEISoFpIcYNwj4d2h/clfFcCgbH76Eq8JHAyEn/nt8GFFNclmzanEbwvJbmUWgmQx3GwrfQ1Cbf/TblTjBj2/IhEd9Woy0pa+eJsgnAfDQ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705412; c=relaxed/simple;
	bh=DA8J2sfyRVygucdeoqkkf9u6QbFkCguW9hWQTxxOuqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OcAOb9FnTAJqfuolMwl9s6mt+/eUwJYHtmYtwuJpXH9vZHzSl1jh9qPEhBIp3b4f+lbTrsxABQfYvS5qk7vXFlq6uXKV5l+uuJl1bYLWzRbZfVUwwIsjyxxGWR+XFsr9exfFolG/87ZpMkqqwyHpH6rQJ2vcQSuKSeoj7s+P3L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzR2tI3P; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzR2tI3P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705412; x=1776241412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DA8J2sfyRVygucdeoqkkf9u6QbFkCguW9hWQTxxOuqs=;
  b=gzR2tI3PYNQosFdvT3UpKZKWzDxdkwQ+TF3G9wEqTcUaPVxDl3d89Upq
   9QjanWXhPXUrhBByTHEwR3QbwiN9pb+pt/6VLHSl75Ds9eXRyvo8jZL+P
   oKBc7DscnQRrzK5rYul1Ipfj0AOno7ILPGJskrd8IMVwjUVKFDzx+v2BK
   1nR3s/HYEtdiaEGz/GyuIsqVXNWTlSAaenSvkfM5nzRGIWYPsWFY9G4b/
   3JobjVgtAwfJo0tG31zxb8RZ6VIuIcEKVeR9bYuj5HbFp6aodOrBt5ny7
   iETVEGO1oZn3LydbobcKrYbcLUturHNFSoqevL2mHL8913gOTatEzBGzG
   Q==;
X-CSE-ConnectionGUID: MEkurpI+QIO3dtBFEDreEA==
X-CSE-MsgGUID: 8NPHGJt6QZ65KpMCZ58Wkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46115901"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46115901"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:23:31 -0700
X-CSE-ConnectionGUID: Il3a+jx0QF6k+N/PSXh39g==
X-CSE-MsgGUID: TmqoTpefT+aw/93lLiFCIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130055521"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2025 01:23:27 -0700
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
Subject: [Patch v3 06/22] perf/x86/intel: Introduce pairs of PEBS static calls
Date: Tue, 15 Apr 2025 11:44:12 +0000
Message-Id: <20250415114428.341182-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
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
index cae213296a63..995df8f392b6 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -95,6 +95,11 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_filter, *x86_pmu.filter);
 
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
index 7bbc7a740242..cd6329207311 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2306,7 +2306,7 @@ static __always_inline void __intel_pmu_disable_all(bool bts)
 static __always_inline void intel_pmu_disable_all(void)
 {
 	__intel_pmu_disable_all(true);
-	intel_pmu_pebs_disable_all();
+	static_call_cond(x86_pmu_pebs_disable_all)();
 	intel_pmu_lbr_disable_all();
 }
 
@@ -2338,7 +2338,7 @@ static void __intel_pmu_enable_all(int added, bool pmi)
 
 static void intel_pmu_enable_all(int added)
 {
-	intel_pmu_pebs_enable_all();
+	static_call_cond(x86_pmu_pebs_enable_all)();
 	__intel_pmu_enable_all(added, false);
 }
 
@@ -2595,7 +2595,7 @@ static void intel_pmu_disable_event(struct perf_event *event)
 	 * so we don't trigger the event without PEBS bit set.
 	 */
 	if (unlikely(event->attr.precise_ip))
-		intel_pmu_pebs_disable(event);
+		static_call(x86_pmu_pebs_disable)(event);
 }
 
 static void intel_pmu_assign_event(struct perf_event *event, int idx)
@@ -2948,7 +2948,7 @@ static void intel_pmu_enable_event(struct perf_event *event)
 	int idx = hwc->idx;
 
 	if (unlikely(event->attr.precise_ip))
-		intel_pmu_pebs_enable(event);
+		static_call(x86_pmu_pebs_enable)(event);
 
 	switch (idx) {
 	case 0 ... INTEL_PMC_IDX_FIXED - 1:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 1d6b3fa6a8eb..e216622b94dc 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2679,6 +2679,11 @@ void __init intel_pebs_init(void)
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
index 2ef407d0a7e2..d201e6ac2ede 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -808,6 +808,10 @@ struct x86_pmu {
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
@@ -1120,6 +1124,10 @@ DECLARE_STATIC_CALL(x86_pmu_set_period, *x86_pmu.set_period);
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

