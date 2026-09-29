Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4640C516174;
	Tue, 29 Sep 2026 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790694553; cv=none; b=MUxVvWOquzMMnByhXahFkS2DGPY3Ex4nv9Ch998z6xPSgERKwGICeOmBhTMc9mRyDUUIuwo6W74YHo8Q2Zbck/54V4g7uUFRLMMTWIiHRqE7yhIelFHSf8SwGdho7ArZzySF4b9Iz0ZTCUKmRIxRH7XX7h9iDC46lujfnlAVt3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790694553; c=relaxed/simple;
	bh=gpgdTcKKkQ2T93h4ye/efBPzAsnfbZjwW5J01PoQ3tY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GpucgsfP3mg65d/m56NPlENsnnQ0Lj7pZxP99RRZdN2J6LEOQg/Xm2DHQrpJlP3vc85H1GW+DbqIiCvMX1J2xwFX3qsnw6TBjqhGpMJJihAmGMKrl0fXLcggiwG7HDd4G6erj+UCoSQPAbis6wZmWrF9AdX2lDtYshzPbsJGhWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YM0tHVm9; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YM0tHVm9"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 568751516;
	Tue, 29 Sep 2026 08:08:41 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9C993F85F;
	Tue, 29 Sep 2026 08:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790694524; bh=gpgdTcKKkQ2T93h4ye/efBPzAsnfbZjwW5J01PoQ3tY=;
	h=From:Date:Subject:To:Cc:From;
	b=YM0tHVm9z3VNtJkABsoO6KmV6xZ/52v6cdwuEd5fBZOUujUDw+b6Dsg81UEYT/jsW
	 7SyN1XK52kKQ9oeY9xqG/XyvvwBuxgLL1cVZOBrwWnW/ynXfzVbizUQGad+RIaMd21
	 28DTjFf/LcTRW+GKDiNGwyNvKHWTdag3sD7ZoSb4=
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 29 Sep 2026 16:08:32 +0100
Subject: [PATCH v2] perf/core: Fix ITRACE start suppression for inherited
 events
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-perf_core_itrace_start_fix_inherit_event-v2-1-9361a946ed56@arm.com>
X-B4-Tracking: v=1; b=H4sIAG/Uu2oC/52NQQ6DIBBFr2JYlwYxonTVezSGUBzqLAQzENLGe
 PdSj9Dl+/l5b2cJCCGxW7MzgoIJY6ggLw1ziw0v4DhXZlJIJbTo+AbkjYsEBjNZByZlS9l4fBs
 MS5VlAwVC5nbUnZgHLUetWdVtBPV0ph5T5QVTjvQ5y6X9rX9ESstbrp7eD6CG3vr+bmm9uriy6
 TiOL+C5QXreAAAA
X-Change-ID: 20260903-perf_core_itrace_start_fix_inherit_event-a8930d792899
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sashiko AI <sashiko-bot@kernel.org>, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790694522; l=1913;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=gpgdTcKKkQ2T93h4ye/efBPzAsnfbZjwW5J01PoQ3tY=;
 b=TuAGK+c5/qhIpC/WOIH+7K3yWavAUKRc50/vsn3LndQHNJdnMrNDOaJe0UVyQNzrDi8t7YulE
 aqbEJX2wt+pCiIBx16dF5gXlAuyI5tBX3n8msK6zhUmp1Xdc3CZOZ5N
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

perf_log_itrace_start() follows event->parent before checking
PERF_ATTACH_ITRACE, but perf_event_itrace_started() sets the flag on the
event passed by the PMU driver. If an inherited event starts tracing
before its parent, the parent's flag remains clear and the child emits
redundant ITRACE_START records on subsequent schedule-ins.

Follow event->parent in perf_event_itrace_started() as well, so that the
setter and checker use the same event. This preserves the original
suppression policy: ITRACE_START supplies the initial task context when
tracing begins, while subsequent task switches are tracked through
context-switch records or trace context packets.

Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/20260901164705.042781F000E9@smtp.kernel.org/
Fixes: 9a6694cfa239 ("perf/x86/intel/pt: Do not force sync packets on every schedule-in")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v2:
- Changed setter to fetch parent event instead (James).
- Link to v1: https://lore.kernel.org/r/20260903-perf_core_itrace_start_fix_inherit_event-v1-1-6bff7e675af5@arm.com
---
 kernel/events/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 634d2ccbab82d8bfe9d1bd7f8c6745f60260dbd9..85d924cce387f88de0c1efe6c22754d38430c9d6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10568,6 +10568,9 @@ void perf_event_text_poke(const void *addr, const void *old_bytes,
 
 void perf_event_itrace_started(struct perf_event *event)
 {
+	if (event->parent)
+		event = event->parent;
+
 	WRITE_ONCE(event->attach_state, event->attach_state | PERF_ATTACH_ITRACE);
 }
 

---
base-commit: 6f8319e3e9a44dd537d17f41565a8453c560a581
change-id: 20260903-perf_core_itrace_start_fix_inherit_event-a8930d792899

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

