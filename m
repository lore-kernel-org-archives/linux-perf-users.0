Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7221437997E;
	Thu,  4 Jun 2026 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600095; cv=none; b=DqbRJyveyvSz/0mOy2/ib8a9IINbZw3WtqoveTq2kBKemq86SB/Q/XCbYUbRofkiVd7EmU/LyZ7mg4G8zTr8D/94cZH42stoXT2n57HW7M21F3E/ynbAerhvyvDeUsMZRjUPD32DX+AMkWPzNTmemjHlt2FOKaW2UKNTyLUdZ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600095; c=relaxed/simple;
	bh=MmD10+K+SOetY9s8vYbxiW2ds80rp9fUZttdunNkuZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTYPPDslKlUkA/Jlt7rfQz2djJ0N3k8FQ5e13oEXmFh/znOiz6GQTu4zsh632qp9udZvtGmA0IdLnHSr9xgvZaWzweO0G1ntyKGFl2MkubPKdHehFzIooQ4+x0lUDNFkIUFaCBMdk2/S20vRpZlSfwOZ6D7h5UZe96Sg8z7IQwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbhXE1sk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbhXE1sk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CBA1F0089A;
	Thu,  4 Jun 2026 19:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780600094;
	bh=XGd7nZPU7g+n5UU8EOXjz8Hg+yquzcf4PxcMBg6MSCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XbhXE1skzUaJM4//QhEdwym8yVL2lmgg6v0fJwbo3XU+XD9plvntA08tFgQarh1SC
	 JQ0HbIKnpG4EO42sy/Q+s94nIeFAShk8J6pgO/okOYV6hUs2iQHPFKuFJuxK5VYM3P
	 SocKRS0k8RVvIgMV1phXemfntBbc08eqy5lC9tS4f8KgzkBi9DlnmI4+3ciwfBc94T
	 xezuxm0XxUy+r0a4NjUKMwbzsDdoq8TSD2zlMWBqKEcjkoW5zHEndCuBF6evtqROpq
	 JovDlyW3uE7BW56nUL+9zd0gKo4CJ23JN9Y2fJtCi1ATzRHZXIgebKAu7byYaH5j09
	 ZuMjgRT1dhz7g==
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
Subject: [PATCH 2/4] perf timechart: Generate backtrace only if needed
Date: Thu,  4 Jun 2026 12:08:08 -0700
Message-ID: <20260604190812.2168118-3-namhyung@kernel.org>
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

The backtrace was used by sched-switch and sched-wakeup only.  No need
to call cat_backtrace() in the process_sample_event().  Let's pass NULL
backtrace and generate it from the sched events.

As it needs a pointer to the 'machine', let's save the session in the
timechart struct and use the host machine of the session instead of
passing the pointer to all handlers.  It should be fine to assume the
host machine as timechart command doesn't deal with guest machines and
there's no way to get tracepoints from the guest events.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-timechart.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index dafd361ecf9d8cd7..337ae547d008ea0b 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -56,6 +56,7 @@ struct timechart {
 	struct per_pid		*all_data;
 	struct power_event	*power_events;
 	struct wake_event	*wake_events;
+	struct perf_session	*session;
 	int			proc_num;
 	unsigned int		numcpus;
 	u64			min_freq,	/* Lowest CPU frequency seen */
@@ -578,7 +579,7 @@ typedef int (*tracepoint_handler)(struct timechart *tchart,
 static int process_sample_event(const struct perf_tool *tool,
 				union perf_event *event __maybe_unused,
 				struct perf_sample *sample,
-				struct machine *machine)
+				struct machine *machine __maybe_unused)
 {
 	struct timechart *tchart = container_of(tool, struct timechart, tool);
 	struct evsel *evsel = sample->evsel;
@@ -593,10 +594,8 @@ static int process_sample_event(const struct perf_tool *tool,
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
-		char *backtrace = cat_backtrace(sample, machine);
 
-		ret = f(tchart, sample, backtrace);
-		free(backtrace);
+		ret = f(tchart, sample, NULL);
 	}
 
 	return ret;
@@ -656,7 +655,10 @@ process_sample_sched_wakeup(struct timechart *tchart,
 			 sample->file_offset, sample->cpu);
 		return -1;
 	}
+
+	backtrace = cat_backtrace(sample, &tchart->session->machines.host);
 	sched_wakeup(tchart, sample->cpu, sample->time, waker, wakee, flags, backtrace);
+	free((char *)backtrace);
 	return 0;
 }
 
@@ -675,8 +677,11 @@ process_sample_sched_switch(struct timechart *tchart,
 			 sample->file_offset, sample->cpu);
 		return -1;
 	}
+
+	backtrace = cat_backtrace(sample, &tchart->session->machines.host);
 	sched_switch(tchart, sample->cpu, sample->time, prev_pid, next_pid,
 		     prev_state, backtrace);
+	free((char *)backtrace);
 	return 0;
 }
 
@@ -1661,6 +1666,7 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
+	tchart->session = session;
 	symbol__init(perf_session__env(session));
 
 	(void)perf_header__process_sections(&session->header,
-- 
2.54.0.1032.g2f8565e1d1-goog

