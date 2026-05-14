Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CED426EB6;
	Thu, 14 May 2026 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771192; cv=none; b=s0KhnBUm5TpplHaCRaPHwJ8evjASHzbMS1JeMUj6UcmlbkE8FXIKWGENiGYS+J8Jv8k+GbHaEZW+GXoO36mSMmsD/QC/MszQk+f/7HbMQPw3IArcGlLkEtBM4pZpd0CuvV4yqYTL6UiDBfdpukWq0L+1k0cWIwcjOJlYHS++I8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771192; c=relaxed/simple;
	bh=U3PUcZ2F6a5gcpr9CFqE75dt6gx0phPxqETwxBn1HBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=js6J/sUaMEWDAVl53c5xt5fg1JW5T/k3tsUvOLEo0Q4f9HMGwrHgESYx3h/aNhyPHNefimy+7wGkqrogaNZNE1xuvE8IAozln5usxaFSCZEUjiAKEjSMeh3wJAqZg4XLD1BB1Pp8AjacrB6GT12LeAcBWottZW9p0h7v8xUo1cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=G959t9pC; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="G959t9pC"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1099A1C00;
	Thu, 14 May 2026 08:06:20 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9634C3F836;
	Thu, 14 May 2026 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778771185; bh=U3PUcZ2F6a5gcpr9CFqE75dt6gx0phPxqETwxBn1HBM=;
	h=From:Date:Subject:To:Cc:From;
	b=G959t9pCPw7KXHQuyiDAIWiks9+PllncCvEO5vwJPCFNOV6f+K9DYGa0xn2FANwY4
	 28RzWin+q/17w+SpfOmEO59o5SKjj1IbMeSYmsISRkwcPCT93ewtz6pocsGZn8UoAa
	 Se5P0noEKvsAGUcYpN840ed33bFORv1aIVw55tGY=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 14 May 2026 16:06:08 +0100
Subject: [PATCH] perf/core: Use AUX pause/resume for throttling
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-aux-throttle-fix-v1-1-92bdc84f5922@arm.com>
X-B4-Tracking: v=1; b=H4sIAN/kBWoC/x2MQQqAIBAAvxJ7bsHUCvpKdBBbayE01EKI/p50n
 IGZBxJFpgRT80CkmxMHX6FrG7C78Rshr5VBCjmIvtNoroJ5jyHng9BxwV5ZS1o5RXKEmp2Rqv6
 X8/K+H8CHP31iAAAA
X-Change-ID: 20260514-aux-throttle-fix-53cce43f3e27
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778771182; l=4912;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=U3PUcZ2F6a5gcpr9CFqE75dt6gx0phPxqETwxBn1HBM=;
 b=/PihVywh+oEe+jj64kuRztvKRIMNHShpZ46MZ74bQN/t0ZqqhYjvbCs+z76GziJVZrQ2Nikvp
 WWMwiCGinAwARlrGqNAdzghkgaHCMCkyWfV8nh7A2foGjX4uwYFgE6k
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Since commit 9734e25fbf5a ("perf: Fix the throttle logic for a group"),
perf throttles events in a group with pmu->stop(event, 0) and
unthrottles them with pmu->start(event, 0).

That is suitable for ordinary counter PMUs, where the zero flags mean
stop/start without updating the count. For AUX trace PMUs, however,
these two callbacks also manage AUX output state. A throttle/unthrottle
cycle can therefore stop tracing without ending AUX output, then try to
begin AUX output again when unthrottling.

On Arm CoreSight this can trigger:

  perf record -a -e cs_etm/aux-action=start-paused/k \
	-e cycles/aux-action=pause,period=3000/ \
	-e cycles/aux-action=resume,period=1500/ -- sleep 10

  [  181.161897] ------------[ cut here ]------------
  [  181.161906] WARNING: kernel/events/ring_buffer.c:415 at perf_aux_output_begin+0x1dc/0x1f0, CPU#0:2
  [  181.234120] arm-scmi arm-scmi.1.auto: timed out in resp(caller: do_xfer+0x1a0/0x558)
  [  181.234223] cpufreq: __target_index: Failed to change cpu frequency: -110
  [  181.286675] Modules linked in: panfrost tda9950 hdlcd tda998x drm_shmem_helper drm_client_lib cect
  [  181.314139] CPU: 0 UID: 0 PID: 352 Comm: perf Not tainted 7.1.0-rc1-00058-gdca922e019dd-dirty #11
  [  181.323915] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, B5
  [  181.334732] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  [  181.341721] pc : perf_aux_output_begin+0x1dc/0x1f0
  [  181.346547] lr : perf_aux_output_begin+0x9c/0x1f0
  [  181.351280] sp : ffff800080003be0
  [  181.354606] x29: ffff800080003be0 x28: ffff0008023fc000 x27: ffff4b45d287f000
  [  181.361789] x26: ffff0009764787a8 x25: 0000000000000000 x24: ffff00080dc99710
  [  181.368970] x23: ffffb4c334553000 x22: 0000000000000001 x21: ffff00080dc99710
  [  181.376151] x20: ffff0009764787a8 x19: ffff000801cc6000 x18: 00000000ffffffff
  [  181.383332] x17: 0000000000000000 x16: ffffb4c3a118c998 x15: 0000000000000000
  [  181.390512] x14: 00003d0900000000 x13: 00000001ffff006e x12: 696765625f747570
  [  181.397692] x11: ffffb4c3a52758d8 x10: 0000000000000108 x9 : ffffb4c3a117f620
  [  181.404873] x8 : ffff800080003a58 x7 : ffff000808de4000 x6 : 00000000000fffff
  [  181.412053] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
  [  181.419232] x2 : 0000000000000007 x1 : 0000000000000000 x0 : 0000000000000007
  [  181.426411] Call trace:
  [  181.428868]  perf_aux_output_begin+0x1dc/0x1f0 (P)
  [  181.433692]  etm_event_start+0xdc/0x290 [coresight]
  [  181.438665]  perf_event_unthrottle+0x70/0xa8
  [  181.442964]  perf_event_unthrottle_group+0x40/0x170
  [  181.447871]  perf_adjust_freq_unthr_events+0x178/0x1a8
  [  181.453038]  perf_adjust_freq_unthr_context+0x74/0xf8
  [  181.458120]  perf_event_task_tick+0xa8/0x290
  [  181.462418]  sched_tick+0x144/0x2c8
  [  181.465937]  update_process_times+0xc0/0x198

Use perf_event_aux_pause() for throttling and unthrottling when the PMU
has PERF_PMU_CAP_AUX_PAUSE capability. This uses the pause/resume path
for fast AUX enable and disable, and uses the existing serialization
against pause/resume recursion.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 kernel/events/core.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7935d5663944ee1cbaf38cf8018c3347635e8d31..33d049b9cccfa32d4c6f5c8bd41b866c9ee33e65 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2756,6 +2756,7 @@ void perf_event_disable_inatomic(struct perf_event *event)
 
 static void perf_log_throttle(struct perf_event *event, int enable);
 static void perf_log_itrace_start(struct perf_event *event);
+static void perf_event_aux_pause(struct perf_event *event, bool pause);
 
 static void perf_event_unthrottle(struct perf_event *event, bool start)
 {
@@ -2763,8 +2764,14 @@ static void perf_event_unthrottle(struct perf_event *event, bool start)
 		return;
 
 	event->hw.interrupts = 0;
-	if (start)
-		event->pmu->start(event, 0);
+
+	if (start) {
+		if (event->pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE)
+			perf_event_aux_pause(event, false);
+		else
+			event->pmu->start(event, 0);
+	}
+
 	if (event == event->group_leader)
 		perf_log_throttle(event, 1);
 }
@@ -2775,7 +2782,12 @@ static void perf_event_throttle(struct perf_event *event)
 		return;
 
 	event->hw.interrupts = MAX_INTERRUPTS;
-	event->pmu->stop(event, 0);
+
+	if (event->pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE)
+		perf_event_aux_pause(event, true);
+	else
+		event->pmu->stop(event, 0);
+
 	if (event == event->group_leader)
 		perf_log_throttle(event, 0);
 }

---
base-commit: e1914add2799225a87502051415fc5c32aeb02ae
change-id: 20260514-aux-throttle-fix-53cce43f3e27

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

