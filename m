Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959F9399356;
	Thu,  4 Jun 2026 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600096; cv=none; b=IwX2FQ3Ko7g/eSMaXPrz6TvkACL/n5KElNOu42SVFHKmGMRjdw7tzI113YyHJn5do4bOgUTOF7GS7PlZV8t8QQrFzFTjyAlOg1Pu5wCVgBS/DUxKSK8MXGr9a67oORm3S1EhOn7OvRq2ceqqunCEI4A4Yss25WcsP7gqjxvo5ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600096; c=relaxed/simple;
	bh=iVvQK26xzewh/ezcla6riJcZNs4qsd6p4TMQrAhISHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MN8NlsLcng4TTd/5XJ3kirp75/hSCzon3MvaksD8hEuZYfihN5VnTzAqqbSQcLP2sn/PXeeV9qxsNePSbFJWSTM144wGu1SgdZwxJee6U6c4ybL9S0jS1sD5Uy3SuQZD3hp8FrM9iTRHmRTGuJm59AEUkih2oFHBC+BiW+4N+u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsghUPJQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsghUPJQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7C91F00898;
	Thu,  4 Jun 2026 19:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780600095;
	bh=9wFwJ5M3pONz8/3u/PgQq2F5W42CicFiZ39P0JfaKcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CsghUPJQCHys/GmfiisMmt3I1CzrHdLkVEoEb281m1amfyU0lsJQFHKJD/MoZCLlb
	 YmE0HCACIg5FtXEtZu+dE8/6kZZ4lOtqCknIrJkeqRuWqiz/x0u6Tr6hvOa1mZrmrX
	 f0aW5B1qLbxS2hCTRM3qhEb26MW3zizbkGS6E1/6Q0MtHZ0PcP3A4Ip2BFhp+/c0HJ
	 AYPw+wW1BffHN7fHZGRFUvqa8neR6oTExzfZKHgnI5dAZjJ31XU47K11M1TIiPtLZF
	 El5iQXoJFfUSlAVgEBjlxImHU8BjZN7Zzi01gCdVgUiqlkXfcOFRDHrqiiETDkkIJp
	 D0znCRcQoHLgQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 4/4] perf timechart: Remove unnecessary copy of backtrace
Date: Thu,  4 Jun 2026 12:08:10 -0700
Message-ID: <20260604190812.2168118-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260604190812.2168118-1-namhyung@kernel.org>
References: <20260604190812.2168118-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pattern of strdup() and free() is found, and I think it just can
use the original backtrace directly.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-timechart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 4efac73a714c5e5f..2fd24d3aaa837743 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -300,7 +300,7 @@ static void pid_put_sample(struct timechart *tchart, int pid, int type,
 	sample->type = type;
 	sample->next = c->samples;
 	sample->cpu = cpu;
-	sample->backtrace = backtrace ? strdup(backtrace) : NULL;
+	sample->backtrace = backtrace;
 	c->samples = sample;
 
 	if (sample->type == TYPE_RUNNING && end > start && start > 0) {
@@ -434,7 +434,7 @@ static void sched_wakeup(struct timechart *tchart, int cpu, u64 timestamp,
 
 	we->time = timestamp;
 	we->waker = waker;
-	we->backtrace = backtrace ? strdup(backtrace) : NULL;
+	we->backtrace = backtrace;
 
 	if ((flags & TRACE_FLAG_HARDIRQ) || (flags & TRACE_FLAG_SOFTIRQ))
 		we->waker = -1;
@@ -655,7 +655,6 @@ process_sample_sched_wakeup(struct timechart *tchart,
 
 	backtrace = cat_backtrace(sample, &tchart->session->machines.host);
 	sched_wakeup(tchart, sample->cpu, sample->time, waker, wakee, flags, backtrace);
-	free((char *)backtrace);
 	return 0;
 }
 
@@ -678,7 +677,6 @@ process_sample_sched_switch(struct timechart *tchart,
 	backtrace = cat_backtrace(sample, &tchart->session->machines.host);
 	sched_switch(tchart, sample->cpu, sample->time, prev_pid, next_pid,
 		     prev_state, backtrace);
-	free((char *)backtrace);
 	return 0;
 }
 
-- 
2.54.0.1032.g2f8565e1d1-goog

