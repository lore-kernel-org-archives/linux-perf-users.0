Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C26932ED4E;
	Wed, 12 Aug 2026 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786547917; cv=none; b=oMOc2mJ36RhJVOsxWsoVje+EEX1uW4e2A4+TbXUGtKf0YAy988mAZifaVZAdiQJyEE5D/b6oLvFkV8UFbZSAvMDtSzb2izDbEWBmsUNABTuz8UqJ9M9lKhjBsTXrfZryvqta4WafeU0xS1ORybduqTZbafAFdB3nvakNJMWycvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786547917; c=relaxed/simple;
	bh=xBW43TQwgdm8BiXhpGXUds+mLFq2lNUbvCKRoaXqzUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZpGcub86ny4pRS2kcvPXK1sb9bVq7uDs+dBG4XnDJFhT9Tfmd9KF7FG+3+Zy9yO1o9+D8fiXR7LY5Y5mT++f6YX4egAPa+q/466seaP65eaOcU4Eh9GbULV3vAVEZoniGn+/myZG/ejtGNYio5a4UbqAgFzdfodtFVv0o0Kw2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ooUm2xTX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ooUm2xTX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=/d8HbpDkMNw7meJtOM/wsCvS+/RWmzVjrDPvceng5Rg=; b=ooUm2xTXaq0NSX3bb9xPTlC2EI
	CR3YbE2r49aerzxkjCsFT93ktEVlS1cyHCma5sBWiXrgcmFVXhxBdMdDik/rrJTxubE+QNvWlPDHm
	S3R7NWpN4Kwyj9zqWgtzXUNXiVtAOuA65Lmh5v624otPi51Kx42sjvjPVNT0lY5EM5jE1sMvbxC6w
	wxgm1pyM4UZ72EZuZsmqomIvFyiurGJSwP/gXavFFf1PHZWIqhHJUpS+ZFq1rGyyGsJPb7aEYGfRm
	b3Biti6DwnMsSaETOETIZcsYmDxtQwazV8qp/Dgphl9E8oWZ6cKqD241NyWMjKaJWraGwVeZ1/PEv
	bmQJtU5Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuAiq-00000002ALW-0KSL;
	Wed, 12 Aug 2026 15:18:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1BA3A302FFB; Wed, 12 Aug 2026 17:18:27 +0200 (CEST)
Date: Wed, 12 Aug 2026 17:18:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v3 8/8] perf/x86/intel: Prevent drain_pebs() reentry
Message-ID: <20260812151827.GO776954@noisy.programming.kicks-ass.net>
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
 <20260717080342.1879573-9-dapeng1.mi@linux.intel.com>
 <20260810130130.GX776954@noisy.programming.kicks-ass.net>
 <da08527f-642b-4f77-89a6-43f42e12d114@linux.intel.com>
 <20260811082256.GT48970@noisy.programming.kicks-ass.net>
 <8a1b03a0-c45e-4a86-af20-bcd15ccb7f8e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a1b03a0-c45e-4a86-af20-bcd15ccb7f8e@linux.intel.com>

On Tue, Aug 11, 2026 at 06:00:43PM +0800, Mi, Dapeng wrote:

> > So what specific callchain is going sideways?

> But for the helper __intel_pmu_pebs_disable(), it seems the whole PMU is
> not disabled, only the target counter has been stopped. Here is one call-chain.
> 
> __perf_addr_filters_adjust()
>   perf_event_stop()
>     __perf_event_stop()
>       x86_pmu_stop() (event->pmu->stop)
>         intel_pmu_disable_event()
>           intel_pmu_pebs_disable()
>             __intel_pmu_pebs_disable()
>               intel_pmu_drain_large_pebs()
>                 intel_pmu_drain_pebs_buffer()
> 

Right, so that needs to be included in the changelog. Also, lets target
that more specifically.

How about something like so?

---
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index db92ded774dd..e092ef6e37f4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3125,6 +3125,27 @@ static void intel_pmu_del_event(struct perf_event *event)
 		this_cpu_ptr(&cpu_hw_events)->n_late_setup--;
 }
 
+int __intel_pmu_quiesce(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int pmu_enabled = cpuc->enabled;
+
+	cpuc->enabled = 0;
+	if (pmu_enabled)
+		intel_pmu_disable_all();
+
+	return pmu_enabled;
+}
+
+void __intel_pmu_resume(bool pmu_enabled)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	cpuc->enabled = pmu_enabled;
+	if (pmu_enabled)
+		intel_pmu_enable_all(0);
+}
+
 static int icl_set_topdown_event_period(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -3316,16 +3337,13 @@ static void intel_pmu_read_event(struct perf_event *event)
 	if (event->hw.flags & (PERF_X86_EVENT_AUTO_RELOAD | PERF_X86_EVENT_TOPDOWN) ||
 	    is_pebs_counter_event_group(event)) {
 		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-		bool pmu_enabled = cpuc->enabled;
+		int pmu_enabled;
 
 		/* Only need to call update_topdown_event() once for group read. */
 		if (is_metric_event(event) && (cpuc->txn_flags & PERF_PMU_TXN_READ))
 			return;
 
-		cpuc->enabled = 0;
-		if (pmu_enabled)
-			intel_pmu_disable_all();
-
+		pmu_enabled = __intel_pmu_quiesce();
 		/*
 		 * If the PEBS counters snapshotting is enabled,
 		 * the topdown event is available in PEBS records.
@@ -3334,10 +3352,7 @@ static void intel_pmu_read_event(struct perf_event *event)
 			static_call(intel_pmu_update_topdown_event)(event, NULL);
 		else
 			intel_pmu_drain_pebs_buffer();
-
-		cpuc->enabled = pmu_enabled;
-		if (pmu_enabled)
-			intel_pmu_enable_all(0);
+		__intel_pmu_resume(pmu_enabled);
 
 		return;
 	}
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e86e4ba91e1b..54890dda0589 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1242,8 +1242,11 @@ int intel_pmu_drain_bts_buffer(void)
 
 void intel_pmu_drain_pebs_buffer(void)
 {
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_sample_data data;
 
+	WARN_ON_ONCE(cpuc->enabled);
+
 	static_call(x86_pmu_drain_pebs)(NULL, &data);
 }
 
@@ -1864,8 +1867,11 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
 static inline void intel_pmu_drain_large_pebs(struct cpu_hw_events *cpuc)
 {
 	if (cpuc->n_pebs == cpuc->n_large_pebs &&
-	    cpuc->n_pebs != cpuc->n_pebs_via_pt)
+	    cpuc->n_pebs != cpuc->n_pebs_via_pt) {
+		int enabled = __intel_pmu_quiesce();
 		intel_pmu_drain_pebs_buffer();
+		__intel_pmu_resume(enabled);
+	}
 }
 
 static void __intel_pmu_pebs_enable(struct perf_event *event)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 8c0b32ffab35..c7848c4cabae 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1644,6 +1644,9 @@ static __always_inline void __intel_pmu_lbr_disable(void)
 	wrmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
 }
 
+extern int __intel_pmu_quiesce(void);
+extern void __intel_pmu_resume(bool pmu_enabled);
+
 int intel_pmu_save_and_restart(struct perf_event *event);
 
 struct event_constraint *
