Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053481C6A0;
	Mon, 15 Jul 2024 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059674; cv=none; b=S5IVch9nWJyWn5X1uFhvJVDKd9QBiozAX3efUr3MGjbpgy6CZTV2B6qrOaQcbO1RyTeTjYXRL4UPEqQTyk7qLubnzb3ZhfO9jHDL5esKjMElZcMCeGvctB3w/P5wLZciIxn5miyQj0jfRCjVAGZwGo8inxRMmDO/t6cnJcAyDA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059674; c=relaxed/simple;
	bh=oOkDDeUx/n+Lq5bVckCYJl3CbyFQTcVhY0IliwMf27w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rL5esAN7B5UlCeV5Kdek3u4osSlLg7IayiV4IvY/PMqm1nuU1zE7JomfRLaw5MfXT45msYaFLzWUczQLUTyQxj9fw7uqbOUcb/BYf+DkDRnQUVRAQX/4LHJp2C0u9Be2seHM66cE0P61JiSRMbsBJ68tutKg1ARdw5fdhbVH7JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bv19QQ8M; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bv19QQ8M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721059673; x=1752595673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oOkDDeUx/n+Lq5bVckCYJl3CbyFQTcVhY0IliwMf27w=;
  b=bv19QQ8McGBYtIvYqcCQYIjhX6915XptwnAfWlPkAWnQNLr9LYAgfgkS
   CVSrPsoGJcCsfjPBHRNu87LHxW2QxN3XAPMkr+j1Seg0DL+WBe8iNOioG
   Gja77MF2ApKcPIjdzgr7DX0qspz0K9irDiE+f2qot6pwm1zl/sp4/JIXg
   Axd1lr2QEQ3qQGEVKCLcszCJCaJjwcyasXJ5X4+4r3222a30h5FE9KLc8
   9uCZw7/7oj1JLXkhCSJ1FgqjjGSTGBK0glCk8LpA8mh1On8GoGoOb4VmY
   qC7lTz8NGSmEScip+6zjxCOsWNNDVwxaGudst74+VAIGP9dnDQ34oC76i
   Q==;
X-CSE-ConnectionGUID: CLK6yBNIQ9mkPzYxbxNZrA==
X-CSE-MsgGUID: af9bhs7aSmiaTx2oHYKH1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="21361180"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="21361180"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 09:07:44 -0700
X-CSE-ConnectionGUID: Ys1p0wjjT2WeI8YJoRSeqg==
X-CSE-MsgGUID: zoJ4CK+PRlugFmokXQe4Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="49413521"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.246.49.253])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 09:07:39 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V9 03/13] perf/x86/intel/pt: Add support for pause / resume
Date: Mon, 15 Jul 2024 19:07:02 +0300
Message-Id: <20240715160712.127117-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715160712.127117-1-adrian.hunter@intel.com>
References: <20240715160712.127117-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Prevent tracing to start if aux_paused.

Implement support for PERF_EF_PAUSE / PERF_EF_RESUME. When aux_paused, stop
tracing. When not aux_paused, only start tracing if it isn't currently
meant to be stopped.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---


Changes in V9:
	Add more comments and barriers for resume_allowed and
	pause_allowed
	Always use WRITE_ONCE with resume_allowed


 arch/x86/events/intel/pt.c | 69 ++++++++++++++++++++++++++++++++++++--
 arch/x86/events/intel/pt.h |  4 +++
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 6aaa21729589..bfc83d0df720 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -418,6 +418,9 @@ static void pt_config_start(struct perf_event *event)
 	struct pt *pt = this_cpu_ptr(&pt_ctx);
 	u64 ctl = event->hw.config;
 
+	if (READ_ONCE(event->hw.aux_paused))
+		return;
+
 	ctl |= RTIT_CTL_TRACEEN;
 	if (READ_ONCE(pt->vmx_on))
 		perf_aux_output_flag(&pt->handle, PERF_AUX_FLAG_PARTIAL);
@@ -534,7 +537,21 @@ static void pt_config(struct perf_event *event)
 	reg |= (event->attr.config & PT_CONFIG_MASK);
 
 	event->hw.config = reg;
+
+	/*
+	 * Allow resume before starting so as not to overwrite a value set by a
+	 * PMI.
+	 */
+	barrier();
+	WRITE_ONCE(pt->resume_allowed, 1);
+	barrier();
 	pt_config_start(event);
+	barrier();
+	/*
+	 * Allow pause after starting so its pt_config_stop() doesn't race with
+	 * pt_config_start().
+	 */
+	WRITE_ONCE(pt->pause_allowed, 1);
 }
 
 static void pt_config_stop(struct perf_event *event)
@@ -1511,6 +1528,7 @@ void intel_pt_interrupt(void)
 		buf = perf_aux_output_begin(&pt->handle, event);
 		if (!buf) {
 			event->hw.state = PERF_HES_STOPPED;
+			WRITE_ONCE(pt->resume_allowed, 0);
 			return;
 		}
 
@@ -1519,6 +1537,7 @@ void intel_pt_interrupt(void)
 		ret = pt_buffer_reset_markers(buf, &pt->handle);
 		if (ret) {
 			perf_aux_output_end(&pt->handle, 0);
+			WRITE_ONCE(pt->resume_allowed, 0);
 			return;
 		}
 
@@ -1573,6 +1592,26 @@ static void pt_event_start(struct perf_event *event, int mode)
 	struct pt *pt = this_cpu_ptr(&pt_ctx);
 	struct pt_buffer *buf;
 
+	if (mode & PERF_EF_RESUME) {
+		if (READ_ONCE(pt->resume_allowed)) {
+			u64 status;
+
+			/*
+			 * Only if the trace is not active and the error and
+			 * stopped bits are clear, is it safe to start, but a
+			 * PMI might have just cleared these, so resume_allowed
+			 * must be checked again also.
+			 */
+			rdmsrl(MSR_IA32_RTIT_STATUS, status);
+			if (!(status & (RTIT_STATUS_TRIGGEREN |
+					RTIT_STATUS_ERROR |
+					RTIT_STATUS_STOPPED)) &&
+			   READ_ONCE(pt->resume_allowed))
+				pt_config_start(event);
+		}
+		return;
+	}
+
 	buf = perf_aux_output_begin(&pt->handle, event);
 	if (!buf)
 		goto fail_stop;
@@ -1601,6 +1640,12 @@ static void pt_event_stop(struct perf_event *event, int mode)
 {
 	struct pt *pt = this_cpu_ptr(&pt_ctx);
 
+	if (mode & PERF_EF_PAUSE) {
+		if (READ_ONCE(pt->pause_allowed))
+			pt_config_stop(event);
+		return;
+	}
+
 	/*
 	 * Protect against the PMI racing with disabling wrmsr,
 	 * see comment in intel_pt_interrupt().
@@ -1608,6 +1653,15 @@ static void pt_event_stop(struct perf_event *event, int mode)
 	WRITE_ONCE(pt->handle_nmi, 0);
 	barrier();
 
+	/*
+	 * Prevent a resume from attempting to restart tracing, or a pause
+	 * during a subsequent start. Do this after clearing handle_nmi so that
+	 * pt_event_snapshot_aux() will not re-allow them.
+	 */
+	WRITE_ONCE(pt->pause_allowed, 0);
+	WRITE_ONCE(pt->resume_allowed, 0);
+	barrier();
+
 	pt_config_stop(event);
 
 	if (event->hw.state == PERF_HES_STOPPED)
@@ -1657,6 +1711,10 @@ static long pt_event_snapshot_aux(struct perf_event *event,
 	if (WARN_ON_ONCE(!buf->snapshot))
 		return 0;
 
+	/* Prevent pause/resume from attempting to start/stop tracing */
+	WRITE_ONCE(pt->pause_allowed, 0);
+	WRITE_ONCE(pt->resume_allowed, 0);
+	barrier();
 	/*
 	 * There is no PT interrupt in this mode, so stop the trace and it will
 	 * remain stopped while the buffer is copied.
@@ -1676,8 +1734,13 @@ static long pt_event_snapshot_aux(struct perf_event *event,
 	 * Here, handle_nmi tells us if the tracing was on.
 	 * If the tracing was on, restart it.
 	 */
-	if (READ_ONCE(pt->handle_nmi))
+	if (READ_ONCE(pt->handle_nmi)) {
+		WRITE_ONCE(pt->resume_allowed, 1);
+		barrier();
 		pt_config_start(event);
+		barrier();
+		WRITE_ONCE(pt->pause_allowed, 1);
+	}
 
 	return ret;
 }
@@ -1793,7 +1856,9 @@ static __init int pt_init(void)
 	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
 		pt_pmu.pmu.capabilities = PERF_PMU_CAP_AUX_NO_SG;
 
-	pt_pmu.pmu.capabilities	|= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE;
+	pt_pmu.pmu.capabilities		|= PERF_PMU_CAP_EXCLUSIVE |
+					   PERF_PMU_CAP_ITRACE |
+					   PERF_PMU_CAP_AUX_PAUSE;
 	pt_pmu.pmu.attr_groups		 = pt_attr_groups;
 	pt_pmu.pmu.task_ctx_nr		 = perf_sw_context;
 	pt_pmu.pmu.event_init		 = pt_event_init;
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 96906a62aacd..b9527205e028 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -117,6 +117,8 @@ struct pt_filters {
  * @filters:		last configured filters
  * @handle_nmi:		do handle PT PMI on this cpu, there's an active event
  * @vmx_on:		1 if VMX is ON on this cpu
+ * @pause_allowed:	PERF_EF_PAUSE is allowed to stop tracing
+ * @resume_allowed:	PERF_EF_RESUME is allowed to start tracing
  * @output_base:	cached RTIT_OUTPUT_BASE MSR value
  * @output_mask:	cached RTIT_OUTPUT_MASK MSR value
  */
@@ -125,6 +127,8 @@ struct pt {
 	struct pt_filters	filters;
 	int			handle_nmi;
 	int			vmx_on;
+	int			pause_allowed;
+	int			resume_allowed;
 	u64			output_base;
 	u64			output_mask;
 };
-- 
2.34.1

