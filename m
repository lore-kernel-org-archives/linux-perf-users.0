Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E6A3C1F24;
	Fri,  5 Jun 2026 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780702759; cv=none; b=GX64BN+Lkfmvm5n15re8S8dCjpWV7wfxHPx4fTQTqkBMIj1tBDfMTZ1tuu0E0A/bgeUyzmS9Awz3jFn9JBQ+L/ux+lUabozd/ULPnZfCjlw1UL/LaRVdEb2o5lv43SLHGoMourTTHcJBdJmzbXcUCUu7Z4Ulfz1mwFdIIi8iXmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780702759; c=relaxed/simple;
	bh=Cbrq3cpZwD+oX414J8jZItla5ek07lji+9WiZWkNi8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGx+OTvSfi61Ry6GO320iJGxECr4WaQrQntU8ecsMwykBFGZ+R5xPwmEwtpy/8eQ6P8xdjYIoioUJtGd3HTVAb/Z89rORvEbOnlSYfaop6VM0E1B/3RJMzZVTgMW1fEujwYgXqSaW8LR/mjzt+LhZ8wVNrtKw+/LeI+Kjp6a+gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2XzSsTV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2XzSsTV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D591F00893;
	Fri,  5 Jun 2026 23:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780702758;
	bh=Z5o78F2Stfbj/pKDui8rLKqKq0bLY5NdYhdB/BC5DCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C2XzSsTVwEg5lCtAAstChDWOedxJQXG+KK8OhzLfdWtmLi3b6ZhodEHE+810TNPJj
	 DhbXJ8uEFXGEwMIbBfCU0bPLv0c4d2g+kD6G8OTWxQTAZ/1KpZzFwPw3nY0uj3m9j5
	 o3Y4c0CMYDv8d6PbqwzXrEy164MfwcC0SJNPOpgqlMgRchUHitfnpooOcjmY8ksgkc
	 THKcoUfJgzc5MpoLPHOE9p7lwbnqvfX7fHXU0suKbNx2GgBmox/S0VNMTaasRSRISF
	 Dr0zAeZlk/9TdQV1//63+4s6JjdwL0pUE5wEfzplD90Uah6gZR/b0JJfo0y50AyUv7
	 Kk1X5yP6cXNFA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 6/9] perf sched: Use is_idle_sample() for idle thread runtime cast guard
Date: Fri,  5 Jun 2026 20:38:34 -0300
Message-ID: <20260605233837.1773732-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605233837.1773732-1-acme@kernel.org>
References: <20260605233837.1773732-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

timehist_sched_change_event() uses thread__tid(thread) == 0 to decide
whether to cast thread_runtime to idle_thread_runtime.  However, a
crafted perf.data can set common_pid=0 and common_tid=0 (the perf_sample
fields) while prev_pid != 0 (the tracepoint field).  is_idle_sample()
returns false (it checks prev_pid for sched_switch), so
timehist_get_thread() goes through machine__findnew_thread() and returns
the machine's TID 0 thread — whose priv data is a regular thread_runtime,
not the larger idle_thread_runtime allocated by init_idle_thread().

The subsequent cast to idle_thread_runtime reads past the thread_runtime
allocation, accessing itr->last_thread, itr->cursor, and itr->callchain
from adjacent heap memory.  Writing to itr->last_thread corrupts the
heap; calling thread__put() on the OOB value frees an arbitrary pointer.

Replace the thread__tid() == 0 check with is_idle_sample(), which uses
the tracepoint-specific prev_pid field and correctly identifies whether
the sample originated from an idle thread with idle_thread_runtime priv.

Fixes: 5d8f17fb5822 ("perf sched timehist: Add -I/--idle-hist option")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index e4378cc9ab3ed48b..4600d70b486104dd 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2902,7 +2902,13 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
 			t = ptime->end;
 	}
 
-	if (!sched->idle_hist || thread__tid(thread) == 0) {
+	/*
+	 * Use is_idle_sample() not thread__tid() == 0: a crafted perf.data
+	 * can set common_pid=0 with prev_pid!=0, giving us a machine thread
+	 * whose priv is thread_runtime, not idle_thread_runtime — the cast
+	 * below would read past the allocation.
+	 */
+	if (!sched->idle_hist || is_idle_sample(sample)) {
 		if (!cpu_list || (sample->cpu < MAX_NR_CPUS &&
 				 test_bit(sample->cpu, cpu_bitmap)))
 			timehist_update_runtime_stats(tr, t, tprev);
-- 
2.54.0

