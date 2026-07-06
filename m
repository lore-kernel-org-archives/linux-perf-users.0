Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFD737C926;
	Mon,  6 Jul 2026 02:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303391; cv=none; b=jY9WIWXsPf5JrckfzW7/aDJ8SRFsfd8ZP8rXYy2g8Gs2i9F2EWUovN7jQwZDTiuXMqfT+WrmxiJZwnDyYFD7aOyhZtVmoWT6Zv+i/CUrWSZYTwISkLQoen3o+Zcg8XpKNxdrTwBLecNMsVlrbmz9K7EJL+T31KkIH/q+quiltV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303391; c=relaxed/simple;
	bh=dZi2f/N4te4xkySh9oCduYPPMVgT9b9YCHWEy//vr7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s1AXDRSRdrQ805NrN7/UX0n0UgyWeoanKGFjfa9nECDPv6gdzGCCLf6XdlUvyPc3XG9rY8uwAlmznEfdttNDBQCAnnpUOg32tA8kWFT33tdbL5d1+WTB9qxYyV1ym1KyqCcNAQQHjp7aQSOkp3yIV8fnJYJi2YB9jO0Nt8Lfn2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n584yQIE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n584yQIE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783303391; x=1814839391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dZi2f/N4te4xkySh9oCduYPPMVgT9b9YCHWEy//vr7s=;
  b=n584yQIEzN9zAj+bszSwccZ4HoCuKoWu2rphd+Nc5ZsI3jlCBCzAfATf
   PUMIisBaKDM26ViZEcCg4AVKfFKDKgts1ZLTKBG36PBpmZFQaqMi/2+zn
   rPKVxNIPpfENx5R3v9rCwj5HJwisgx5I/8ydw1ar7UnGFJ8C3KkXOer0I
   tZlyoQpObNlhchFF7WeIWorXA3tmEHIPCHDQ//v0ZPkf0w7Wt/eOR/PPD
   8DXeY5mq0GkQN6g9BNgcVXf7/7O0oTNZkJtUzQ2Ul17sAmoiAJunFCwTj
   XzMuXUL7tlOdSOzPkk0EaI2fd27ej4PTptNSPvXC3NgtUWuNk5HTiQhQd
   g==;
X-CSE-ConnectionGUID: Q3Vb621zRBe8z/5pc14UsQ==
X-CSE-MsgGUID: tYwiop+hSBi22Sf1VD8wuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83911811"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83911811"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:03:10 -0700
X-CSE-ConnectionGUID: EYDyYRfKSYeNTu7/3W0JlQ==
X-CSE-MsgGUID: yud398u8RjySTYmEI2vp8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="247191522"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jul 2026 19:03:05 -0700
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
Subject: [Patch v9 24/24] perf/x86/intel: Add sanity check for PEBS fragment size
Date: Mon,  6 Jul 2026 09:54:39 +0800
Message-Id: <20260706015439.3040804-25-dapeng1.mi@linux.intel.com>
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

Prevent potential infinite loops by adding a sanity check for the
corrupted PEBS fragment sizes which could happen in theory.

If a corrupted PEBS fragment is detected, the entire PEBS record
including the corrupted fragment and all subsequent records will be
dropped and a NULL PEBS record is reported to user space. This ensures
the integrity of PEBS data and prevents infinite loops in
setup_arch_pebs_sample_data() again.

Please note software has no way to figure out which events are impacted
by the corrupted record, so the last record of each event would be
discarded for all events if corrupted record is detected even though
it may be a well-formed record for some events.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c |  2 +-
 arch/x86/events/intel/ds.c   | 70 ++++++++++++++++++++++++++----------
 2 files changed, 52 insertions(+), 20 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a2d08f405a57..7fb0b53ed8b4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3797,7 +3797,7 @@ static int x86_pmu_handle_guest_pebs(struct pt_regs *regs,
 
 static int handle_pmi_common(struct pt_regs *regs, u64 status)
 {
-	struct perf_sample_data data;
+	struct perf_sample_data data = {};
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int bit;
 	int handled = 0;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index b38aed4f62b4..7a8e61905539 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1242,7 +1242,7 @@ int intel_pmu_drain_bts_buffer(void)
 
 void intel_pmu_drain_pebs_buffer(void)
 {
-	struct perf_sample_data data;
+	struct perf_sample_data data = {};
 
 	static_call(x86_pmu_drain_pebs)(NULL, &data);
 }
@@ -2659,6 +2659,9 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 
 again:
 	header = at;
+	if (!header->size)
+		return;
+
 	next_record = at + sizeof(struct arch_pebs_header);
 	if (header->basic) {
 		struct arch_pebs_basic *basic = next_record;
@@ -2940,13 +2943,21 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
 			    struct pt_regs *iregs,
 			    struct pt_regs *regs,
 			    struct perf_sample_data *data,
-			    void *at,
-			    int count,
+			    void *at, int count, bool corrupted,
 			    setup_fn setup_sample)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	setup_sample(event, iregs, at, data, regs);
+	/* Skip parsing corrupted PEBS record. */
+	if (corrupted) {
+		/* Clear stale register states in previous records. */
+		memset(regs, 0, sizeof(*regs));
+		x86_pmu_clear_perf_regs(regs);
+		perf_sample_data_init(data, 0, event->hw.last_period);
+	} else {
+		setup_sample(event, iregs, at, data, regs);
+	}
+
 	if (iregs == &dummy_iregs) {
 		/*
 		 * The PEBS records may be drained in the non-overflow context,
@@ -2964,12 +2975,16 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
 	}
 
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
-		if ((is_pebs_counter_event_group(event))) {
-			/*
-			 * The value of each sample has been updated when setup
-			 * the corresponding sample data.
-			 */
-			perf_event_update_userpage(event);
+		if (is_pebs_counter_event_group(event)) {
+			if (corrupted) {
+				intel_pmu_save_and_restart_reload(event, 1);
+			} else {
+				/*
+				 * The value of each sample has been updated
+				 * when setup the corresponding sample data.
+				 */
+				perf_event_update_userpage(event);
+			}
 		} else {
 			/*
 			 * Now, auto-reload is only enabled in fixed period mode.
@@ -2993,7 +3008,7 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
 		 * counters-snapshotting record, only needs to set the new
 		 * period for the counter.
 		 */
-		if (is_pebs_counter_event_group(event))
+		if (is_pebs_counter_event_group(event) && !corrupted)
 			static_call(x86_pmu_set_period)(event);
 		else
 			intel_pmu_save_and_restart(event);
@@ -3022,13 +3037,15 @@ __intel_pmu_pebs_events(struct perf_event *event,
 		iregs = &dummy_iregs;
 
 	while (cnt > 1) {
-		__intel_pmu_pebs_event(event, iregs, regs, data, at, setup_sample);
+		__intel_pmu_pebs_event(event, iregs, regs, data,
+				       at, setup_sample);
 		at += cpuc->pebs_record_size;
 		at = get_next_pebs_record_by_bit(at, top, bit);
 		cnt--;
 	}
 
-	__intel_pmu_pebs_last_event(event, iregs, regs, data, at, count, setup_sample);
+	__intel_pmu_pebs_last_event(event, iregs, regs, data, at,
+				    count, false, setup_sample);
 }
 
 static int intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
@@ -3244,7 +3261,8 @@ static __always_inline void
 __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
 				    struct pt_regs *regs,
 				    struct perf_sample_data *data,
-				    u64 mask, short *counts, void **last,
+				    u64 mask, short *counts,
+				    void **last, bool corrupted,
 				    setup_fn setup_sample)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -3258,7 +3276,7 @@ __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
 		event = cpuc->events[bit];
 
 		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
-					    counts[bit], setup_sample);
+					    counts[bit], corrupted, setup_sample);
 	}
 
 }
@@ -3301,6 +3319,8 @@ static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_da
 		u64 pebs_status;
 
 		basic = at;
+		if (WARN_ON_ONCE(!basic->format_size))
+			break;
 		if (basic->format_size != cpuc->pebs_record_size)
 			continue;
 
@@ -3312,7 +3332,7 @@ static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_da
 	}
 
 	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask, counts, last,
-					    setup_pebs_adaptive_sample_data);
+					    false, setup_pebs_adaptive_sample_data);
 
 	return hweight64(events_bitmap);
 }
@@ -3328,6 +3348,7 @@ static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 	struct pt_regs *regs = &perf_regs->regs;
 	void *base, *at, *top;
 	u64 events_bitmap = 0;
+	bool corrupted = false;
 	u64 mask;
 
 	rdmsrq(MSR_IA32_PEBS_INDEX, index.whole);
@@ -3362,8 +3383,10 @@ static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 
 		header = at;
 
-		if (WARN_ON_ONCE(!header->size))
-			break;
+		if (WARN_ON_ONCE(!header->size)) {
+			corrupted = true;
+			goto done;
+		}
 
 		/* 1st fragment or single record must have basic group */
 		if (!header->basic) {
@@ -3383,15 +3406,24 @@ static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 			if (!header->size)
 				break;
 			at += header->size;
+			if (WARN_ON_ONCE(at >= top)) {
+				corrupted = true;
+				goto done;
+			}
 			header = at;
 		}
 
 		/* Skip last fragment or the single record */
 		at += header->size;
+		if (WARN_ON_ONCE(at > top)) {
+			corrupted = true;
+			goto done;
+		}
 	}
 
+done:
 	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask,
-					    counts, last,
+					    counts, last, corrupted,
 					    setup_arch_pebs_sample_data);
 
 	return hweight64(events_bitmap);
-- 
2.34.1

