Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE8C403EA1;
	Thu,  3 Sep 2026 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428134; cv=none; b=PO0OQgkBHRjQgMstDfdlyAJPsu7Mxkq6blSwDhrjYjONOJB5GBiiRNyns7tYeBhrbZsLoYIszoA31Lxvrhp1rUWgXIsEHpQnyclyRyv313C+T6G7kF9rjaNP+uMNN0ddku5ISpyvWJFWf4Clmn/uJ8TAefvwWv8/ukHUah9yGDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428134; c=relaxed/simple;
	bh=P/gApI/jTGDCX/7W6Htuiuu7577T7jl7mGMwxwH5xcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Rn2aSTcSczOvHDrF/jBxFVAkQn4/mefmOGtwbZ80k1SzZWw/DKpYUf20+z7tjr3+kNm6C4Kkf+HzbdSh3uAtJRlyvbTqiD4QLBUdsLImbAcGuaHvbG3ws46B6HwUR/C01ECord5V4lBpUb89tB5wFuht32WwN8bLxHhyCzLW51k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CWSreIME; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CWSreIME"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 403A21596;
	Thu,  3 Sep 2026 02:35:27 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 385E53F7D8;
	Thu,  3 Sep 2026 02:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788428131; bh=P/gApI/jTGDCX/7W6Htuiuu7577T7jl7mGMwxwH5xcM=;
	h=From:Date:Subject:To:Cc:From;
	b=CWSreIMEuFcfa6KgwoQQVDfM2rqzA3Nh7LUthlB3EX5gpnkxeOtdAcwmyYoLg8dSt
	 2fUOOvFRcyO/sCsoq7blJRu88dRyDP8ZL7LANuEiIJAWIyPztrzAjEHMyx8Nw+eZth
	 ClGbEgo7p+ujAWKvADMzUB/oW5iB/2HrsF7YzrYc=
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 03 Sep 2026 10:35:12 +0100
Subject: [PATCH] perf/core: Fix ITRACE start suppression for inherited
 events
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-perf_core_itrace_start_fix_inherit_event-v1-1-6bff7e675af5@arm.com>
X-B4-Tracking: v=1; b=H4sIAE8/mWoC/x2N0QqDMAwAf0XyvEJXQc1+ZYxQapx5qZIGEcR/X
 9jjwXF3QWMVbvDqLlA+pMlWHZ6PDsqa65eDzM6QYhoixj7srAuVTZnENBemZlmNFjlJ6uoxIz6
 4WsgT9nEeMU2I4Lld2aX/6v257x8C9B6wegAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788428129; l=1944;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=P/gApI/jTGDCX/7W6Htuiuu7577T7jl7mGMwxwH5xcM=;
 b=7AToI7D2MoDKTHUcW/Lhn7qNF5k4sJ/nXZCHpXwQZrQNqrvnaxX0R3eTorRoSMLVuIqQBl1oe
 4Tk9aZEOiWTBUNOQEqvf7bB51kd3G5OWnFAaoVlQCbHsWnELWQv7v0q
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

PMU drivers call perf_event_itrace_started() for the event that has
started tracing. This sets PERF_ATTACH_ITRACE in that event's
attach_state.

For inherited events, however, perf_log_itrace_start() replaces the
child event with its parent before checking PERF_ATTACH_ITRACE. The
setter and checker therefore operate on different events. If the
parent's flag is clear, the child continues to emit ITRACE_START
records on subsequent schedule-ins. If the parent has already started,
its flag can instead suppress the child's initial record.

Remove the parent substitution so that perf_log_itrace_start() checks
the same event that the PMU driver marks as started.

This is safe for tool consumers. Intel PT uses the ITRACE_START record
to set the current thread context. CoreSight ETM uses the record only
to find or create the corresponding thread. Neither decoder depends on
the parent event.

Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/20260901164705.042781F000E9@smtp.kernel.org/
Fixes: 9a6694cfa239 ("perf/x86/intel/pt: Do not force sync packets on every schedule-in")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 kernel/events/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a6c8e38a311042afab6b65814a84c67b87ba929b..991ae214d46ebe8b0d9de497255f25a4ad12397f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10572,9 +10572,6 @@ static void perf_log_itrace_start(struct perf_event *event)
 	} rec;
 	int ret;
 
-	if (event->parent)
-		event = event->parent;
-
 	if (!(event->pmu->capabilities & PERF_PMU_CAP_ITRACE) ||
 	    event->attach_state & PERF_ATTACH_ITRACE)
 		return;

---
base-commit: 940de590b839f71d6dc846160534bf202401b8b7
change-id: 20260903-perf_core_itrace_start_fix_inherit_event-a8930d792899

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

