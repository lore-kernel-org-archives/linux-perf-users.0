Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C3F1C4631;
	Tue, 22 Oct 2024 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612819; cv=none; b=QZpvLcDG6diN9zj0fWYKGAYNEEI5VEjmroj5UTX1DFUWekj+6BGgRQaEN/+dE1OJIzTVwmhtScZOWvDTMuX6v2MLexuxIQalv+7zMjUTszXZSZZyC7WDHFNX4RJC28z2uHhAiSzsz/cnGaCoBdNqNDdMjBXwIa6y//qJXWutWyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612819; c=relaxed/simple;
	bh=dS2yrVog4bsUnRdVpo51/O2BDTiSXA2RQgJZXN4Motk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2eLy7AfnjytMhdSSWZitw+o9AnzDLOYtCvKJJ/6OTuhB1SzYrJ/EreL/VJLgC2Vwwlp5gp3tcja6Aq+7tyT2rTmzXleE77aI7x2ZqWhEVFXRCX24Ch6DjeC8E15O1IiFCQAZqVUZH9He49jzveodcZhPhl9ae73xa/NFtJJauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dOESwb+8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dOESwb+8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729612818; x=1761148818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dS2yrVog4bsUnRdVpo51/O2BDTiSXA2RQgJZXN4Motk=;
  b=dOESwb+8q+6+K0VsB3YYIobzVMEo/7fnSVxzjG9iwgyVfEv/tI6eO6RG
   zZnfdq8NOCS+LCGMK2kp46x+eXbZMVeSTtuCmHnwlGKByKbKgbNYyG6vY
   s9oWFTkcDFXf4oZNWF2SoKr8tP2n4QEeFp0OVu5JJH+1tUPD8ZAjdf2k3
   /4FCsZ/VRNHSQU9dsKdLWCeJYXKoLmXLGbF0xNwCEixQo9D55uLERr6T2
   sOqY84jZ+5+v1PDKJe1gXGLqFU1GoYjwD+hgBVl8NM6lKJs7plyg+YUxO
   CLyGIvxc1BE7StpcQwJERChFpKe6Q8ej+8Hu9O4BMfSmNltKiSwqn7HuX
   Q==;
X-CSE-ConnectionGUID: 7KwBm2TQSRepr/T0zFmc+w==
X-CSE-MsgGUID: a0NKv3i/TVuzq7IL+Js9cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29270883"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="29270883"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 09:00:07 -0700
X-CSE-ConnectionGUID: BPDjSIHXSau8VZDN2O2SdA==
X-CSE-MsgGUID: EKhiBmAVSzqQAX2Uz0maew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79858489"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.ger.corp.intel.com) ([10.246.16.81])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 08:59:58 -0700
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
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V14 03/11] perf/x86/intel/pt: Add support for pause / resume
Date: Tue, 22 Oct 2024 18:59:09 +0300
Message-ID: <20241022155920.17511-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022155920.17511-1-adrian.hunter@intel.com>
References: <20241022155920.17511-1-adrian.hunter@intel.com>
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


Changes in V14:
	Set pt->handle_nmi after configuration is completed instead of during

Changes in V12:
	Rebase on current tip plus patch set "KVM: x86: Fix Intel PT Host/Guest
	mode when host tracing"

Changes in V9:
	Add more comments and barriers for resume_allowed and
	pause_allowed
	Always use WRITE_ONCE with resume_allowed


 arch/x86/events/intel/pt.c | 73 ++++++++++++++++++++++++++++++++++++--
 arch/x86/events/intel/pt.h |  4 +++
 2 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index a087bc0c5498..4b0373bc8ab4 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -418,6 +418,9 @@ static void pt_config_start(struct perf_event *event)
 	struct pt *pt = this_cpu_ptr(&pt_ctx);
 	u64 ctl = event->hw.aux_config;
 
+	if (READ_ONCE(event->hw.aux_paused))
+		return;
+
 	ctl |= RTIT_CTL_TRACEEN;
 	if (READ_ONCE(pt->vmx_on))
 		perf_aux_output_flag(&pt->handle, PERF_AUX_FLAG_PARTIAL);
@@ -534,7 +537,24 @@ static void pt_config(struct perf_event *event)
 	reg |= (event->attr.config & PT_CONFIG_MASK);
 
 	event->hw.aux_config = reg;
+
+	/*
+	 * Allow resume before starting so as not to overwrite a value set by a
+	 * PMI.
+	 */
+	barrier();
+	WRITE_ONCE(pt->resume_allowed, 1);
+	/* Configuration is complete, it is now OK to handle an NMI */
+	barrier();
+	WRITE_ONCE(pt->handle_nmi, 1);
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
@@ -1516,6 +1536,7 @@ void intel_pt_interrupt(void)
 		buf = perf_aux_output_begin(&pt->handle, event);
 		if (!buf) {
 			event->hw.state = PERF_HES_STOPPED;
+			WRITE_ONCE(pt->resume_allowed, 0);
 			return;
 		}
 
@@ -1524,6 +1545,7 @@ void intel_pt_interrupt(void)
 		ret = pt_buffer_reset_markers(buf, &pt->handle);
 		if (ret) {
 			perf_aux_output_end(&pt->handle, 0);
+			WRITE_ONCE(pt->resume_allowed, 0);
 			return;
 		}
 
@@ -1578,6 +1600,26 @@ static void pt_event_start(struct perf_event *event, int mode)
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
@@ -1588,7 +1630,6 @@ static void pt_event_start(struct perf_event *event, int mode)
 			goto fail_end_stop;
 	}
 
-	WRITE_ONCE(pt->handle_nmi, 1);
 	hwc->state = 0;
 
 	pt_config_buffer(buf);
@@ -1606,6 +1647,12 @@ static void pt_event_stop(struct perf_event *event, int mode)
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
@@ -1613,6 +1660,15 @@ static void pt_event_stop(struct perf_event *event, int mode)
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
@@ -1662,6 +1718,10 @@ static long pt_event_snapshot_aux(struct perf_event *event,
 	if (WARN_ON_ONCE(!buf->snapshot))
 		return 0;
 
+	/* Prevent pause/resume from attempting to start/stop tracing */
+	WRITE_ONCE(pt->pause_allowed, 0);
+	WRITE_ONCE(pt->resume_allowed, 0);
+	barrier();
 	/*
 	 * There is no PT interrupt in this mode, so stop the trace and it will
 	 * remain stopped while the buffer is copied.
@@ -1681,8 +1741,13 @@ static long pt_event_snapshot_aux(struct perf_event *event,
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
@@ -1798,7 +1863,9 @@ static __init int pt_init(void)
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
index a1b6c04b7f68..7ee94fc6d7cb 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -119,6 +119,8 @@ struct pt_filters {
  * @filters:		last configured filters
  * @handle_nmi:		do handle PT PMI on this cpu, there's an active event
  * @vmx_on:		1 if VMX is ON on this cpu
+ * @pause_allowed:	PERF_EF_PAUSE is allowed to stop tracing
+ * @resume_allowed:	PERF_EF_RESUME is allowed to start tracing
  * @output_base:	cached RTIT_OUTPUT_BASE MSR value
  * @output_mask:	cached RTIT_OUTPUT_MASK MSR value
  */
@@ -127,6 +129,8 @@ struct pt {
 	struct pt_filters	filters;
 	int			handle_nmi;
 	int			vmx_on;
+	int			pause_allowed;
+	int			resume_allowed;
 	u64			output_base;
 	u64			output_mask;
 };
-- 
2.43.0

