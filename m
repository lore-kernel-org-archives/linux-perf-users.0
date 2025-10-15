Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202761DFE22;
	Wed, 15 Oct 2025 05:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760505622; cv=none; b=AK6TFwldlH9q5ZyIjnrywH4uloCx5zfDUBpoh8MNlj2BlPx5GkqB51HI2DFETA+o/By4j9ZKUr8gQKnqaI8ptzCEqhlFu3ZLbzrLS4PUKoBu5ZDjCDt1uuTJ5qzx+1gwkGpUb1TbIVcr3vIHP5fR6QMd5F2Rb8p+W/jhHuTIVEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760505622; c=relaxed/simple;
	bh=lb8DEPjuEO/X+Y+/tZytyx3QgBM917fmrE4/Glvc+Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ISXKlUWy/khyOF5PmLRN0uRe//mxeJNzxAm6XAoDbo13yWLpxWoU/ivW+lSxZVnH2qlVee8NHaBaIIhzbMyUQj7j+wQuXZFRw7KHy9hk+WKZKK+VY0AUaB53l03EM0gSE/pibQH5/G2z2emLhGXcUfWWAC16mhcQLfCvM4biu2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rx59igDn; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rx59igDn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760505620; x=1792041620;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lb8DEPjuEO/X+Y+/tZytyx3QgBM917fmrE4/Glvc+Xk=;
  b=Rx59igDnn4heSbqgN9UNuf8Vrg2Lr8eMm2UB3KVp9oP+zcNGYqgurNvr
   66dBhe6H1jR3FD68xutxF4rMV1JH3uKxJhlwJyaFMrKk+bgXs0B4dLxOY
   nfZ3Q0gapfY3WdGZfsY0s/oqhdm07MuOFARRmSKu+GNlLGHaCfPKB4VN0
   VvjYi+n1/t9k8/pf2b7xPRLguFsztrTSDWnZW3YNHQlPRaiaw8Aq6g5vD
   61H6gOGkPxZgGuh2031pZNc3D+QNRhFoWIRomWeiiK2AsLWXNv3NivbsE
   shLzsL0dkn7vjh4JE0Me6b8aHa7cPRG+Grg/RPXzbiFBBwbj9fhBD12e0
   g==;
X-CSE-ConnectionGUID: ThVmTQfJSpahl9Sf+fYyfg==
X-CSE-MsgGUID: d0RF9Md9TPSEjd5skxaBpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="62823445"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="62823445"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 22:20:19 -0700
X-CSE-ConnectionGUID: GM4uPHDVRjaRnLyK8DLq2w==
X-CSE-MsgGUID: RxORUPVbQDmy6x3AcBs8qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="182503930"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 14 Oct 2025 22:20:16 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Octavia Togami <octavia.togami@gmail.com>
Subject: [PATCH] perf: Fix system hang caused by cpu-clock
Date: Wed, 15 Oct 2025 13:18:28 +0800
Message-Id: <20251015051828.12809-1-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A system hang issue caused by cpu-clock is reported and bisection
indicates the commit 18dbcbfabfff ("perf: Fix the POLL_HUP delivery
 breakage") causes this issue.

The root cause of the hang issue is that cpu-clock is a specific SW
event which relies on the hrtimer. The __perf_event_overflow()
is invoked from the hrtimer handler for cpu-clock event, and
__perf_event_overflow() tries to call event stop callback
(cpu_clock_event_stop()) to stop the event, and cpu_clock_event_stop()
calls htimer_cancel() to cancel the hrtimer. But unfortunately the
hrtimer callback is currently executing and then traps into deadlock.

To avoid this deadlock, use hrtimer_try_to_cancel() instead of
hrtimer_cancel() to cancel the hrtimer, and set PERF_HES_STOPPED flag
for the stopping events. perf_swevent_hrtimer() would stop the event
hrtimer once it detects the PERF_HES_STOPPED flag.

Reported-by: Octavia Togami <octavia.togami@gmail.com>
Closes: https://lore.kernel.org/all/CAHPNGSQpXEopYreir+uDDEbtXTBvBvi8c6fYXJvceqtgTPao3Q@mail.gmail.com/
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Fixes: 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage")
Tested-by: Octavia Togami <octavia.togami@gmail.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 kernel/events/core.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7541f6f85fcb..f90105d5f26a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11773,7 +11773,8 @@ static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
 
 	event = container_of(hrtimer, struct perf_event, hw.hrtimer);
 
-	if (event->state != PERF_EVENT_STATE_ACTIVE)
+	if (event->state != PERF_EVENT_STATE_ACTIVE ||
+	    event->hw.state & PERF_HES_STOPPED)
 		return HRTIMER_NORESTART;
 
 	event->pmu->read(event);
@@ -11819,15 +11820,18 @@ static void perf_swevent_cancel_hrtimer(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 
 	/*
-	 * The throttle can be triggered in the hrtimer handler.
-	 * The HRTIMER_NORESTART should be used to stop the timer,
-	 * rather than hrtimer_cancel(). See perf_swevent_hrtimer()
+	 * The event stop can be triggered in the hrtimer handler.
+	 * So use hrtimer_try_to_cancel() instead of hrtimer_cancel()
+	 * to stop the hrtimer() to avoid trapping into a dead loop.
+	 * Simultaneously the event would be set PERF_HES_STOPPED flag,
+	 * perf_swevent_hrtimer() would stop the event hrtimer once it
+	 * detects the PERF_HES_STOPPED flag.
 	 */
 	if (is_sampling_event(event) && (hwc->interrupts != MAX_INTERRUPTS)) {
 		ktime_t remaining = hrtimer_get_remaining(&hwc->hrtimer);
 		local64_set(&hwc->period_left, ktime_to_ns(remaining));
 
-		hrtimer_cancel(&hwc->hrtimer);
+		hrtimer_try_to_cancel(&hwc->hrtimer);
 	}
 }
 
@@ -11871,12 +11875,14 @@ static void cpu_clock_event_update(struct perf_event *event)
 
 static void cpu_clock_event_start(struct perf_event *event, int flags)
 {
+	event->hw.state = 0;
 	local64_set(&event->hw.prev_count, local_clock());
 	perf_swevent_start_hrtimer(event);
 }
 
 static void cpu_clock_event_stop(struct perf_event *event, int flags)
 {
+	event->hw.state = PERF_HES_STOPPED;
 	perf_swevent_cancel_hrtimer(event);
 	if (flags & PERF_EF_UPDATE)
 		cpu_clock_event_update(event);
@@ -11950,12 +11956,14 @@ static void task_clock_event_update(struct perf_event *event, u64 now)
 
 static void task_clock_event_start(struct perf_event *event, int flags)
 {
+	event->hw.state = 0;
 	local64_set(&event->hw.prev_count, event->ctx->time);
 	perf_swevent_start_hrtimer(event);
 }
 
 static void task_clock_event_stop(struct perf_event *event, int flags)
 {
+	event->hw.state = PERF_HES_STOPPED;
 	perf_swevent_cancel_hrtimer(event);
 	if (flags & PERF_EF_UPDATE)
 		task_clock_event_update(event, event->ctx->time);

base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.34.1

