Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12CA372069;
	Thu,  4 Jun 2026 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600096; cv=none; b=i1LVnJP2mMj3gaJgt48WGOiXz9u8/fB0ZP3Dgve1JBq6f4NfgKD+zt2TsaXr4cGKJt9/7mMc0t3SV8h4BpIZpJSTHxLaT5MsEK/L7+oZgOYiFJd4EmEmSNsXr0uTYhQJuuf16lJzY+fyt6HYQtJDZspsV1OEzhnBZzXIzNNVvww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600096; c=relaxed/simple;
	bh=I09/5Vx7pX70v3M6E8LVuJiEffdvMyax+D/hwDY7iJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJwO85G+n6TVVL3WTlQW1IRG7C1Qca7oQ4SYkK7DHzvqLOsaFPN/Zs7AH4R5IYNJfy2PkDhjTRdFq8Xt5nKdolorgd+zk8peTj1do6PWUyYmrZapbbqy+E5ufdzkF93F1c0AugPMuBRO2ohA+RYSJQSaTJbpvk2CF410CA6VD/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIK6icBn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIK6icBn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C87B1F0089D;
	Thu,  4 Jun 2026 19:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780600094;
	bh=N+VvgQE3Pcoy6/O8RxZuhyvDE6MlJ/x53ALB+DgYqaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lIK6icBngI7gJ8KwsqVy3dIa61s1eUe8e9LquXU45O1tRoAz8QvFuH3JnU+NoIURj
	 8TSBSa6q9jAdIKJ3cGbj7C4hLWc1Ua2B+3VL0zaiptduiyqadDe8KKeiK+SQKgiINd
	 B0tUzliNeQAQ1wN1vrw5UXZN1qNgMgewmC1dHxELREJg82W2oOt220ntczWG9LZSL/
	 9MsLMuvmzcor6dPAxS386ytOCWvV8UTGY1vpBlhksGWicY44xmdAx4l01AJ7Pdoixi
	 ssNGIhtM7Yw7oeC3AJEGkHUrc5kpOb93ix3p/7c24+P1O1QkXElYN9xwZa3uwaYVxp
	 hK3W9w2w6+s6w==
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
Subject: [PATCH 3/4] perf timechart: Remove unused backtrace in trace_handler
Date: Thu,  4 Jun 2026 12:08:09 -0700
Message-ID: <20260604190812.2168118-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260604190812.2168118-1-namhyung@kernel.org>
References: <20260604190812.2168118-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now the backtrace argument is not used in any handler.  Let's get rid of
it.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-timechart.c | 64 ++++++++++++----------------------
 1 file changed, 23 insertions(+), 41 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 337ae547d008ea0b..4efac73a714c5e5f 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -573,8 +573,7 @@ static char *cat_backtrace(struct perf_sample *sample,
 }
 
 typedef int (*tracepoint_handler)(struct timechart *tchart,
-				  struct perf_sample *sample,
-				  const char *backtrace);
+				  struct perf_sample *sample);
 
 static int process_sample_event(const struct perf_tool *tool,
 				union perf_event *event __maybe_unused,
@@ -595,7 +594,7 @@ static int process_sample_event(const struct perf_tool *tool,
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
 
-		ret = f(tchart, sample, NULL);
+		ret = f(tchart, sample);
 	}
 
 	return ret;
@@ -603,8 +602,7 @@ static int process_sample_event(const struct perf_tool *tool,
 
 static int
 process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
-			struct perf_sample *sample,
-			const char *backtrace __maybe_unused)
+			struct perf_sample *sample)
 {
 	u32 state  = perf_sample__intval(sample, "state");
 	u32 cpu_id = perf_sample__intval(sample, "cpu_id");
@@ -624,8 +622,7 @@ process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
 
 static int
 process_sample_cpu_frequency(struct timechart *tchart,
-			     struct perf_sample *sample,
-			     const char *backtrace __maybe_unused)
+			     struct perf_sample *sample)
 {
 	u32 state  = perf_sample__intval(sample, "state");
 	u32 cpu_id = perf_sample__intval(sample, "cpu_id");
@@ -642,12 +639,12 @@ process_sample_cpu_frequency(struct timechart *tchart,
 
 static int
 process_sample_sched_wakeup(struct timechart *tchart,
-			    struct perf_sample *sample,
-			    const char *backtrace)
+			    struct perf_sample *sample)
 {
 	u8 flags  = perf_sample__intval(sample, "common_flags");
 	int waker = perf_sample__intval(sample, "common_pid");
 	int wakee = perf_sample__intval(sample, "pid");
+	char *backtrace;
 
 	/* perf.data is untrusted input — CPU may be absent or corrupted */
 	if (sample->cpu >= MAX_CPUS) {
@@ -664,12 +661,12 @@ process_sample_sched_wakeup(struct timechart *tchart,
 
 static int
 process_sample_sched_switch(struct timechart *tchart,
-			    struct perf_sample *sample,
-			    const char *backtrace)
+			    struct perf_sample *sample)
 {
 	int prev_pid   = perf_sample__intval(sample, "prev_pid");
 	int next_pid   = perf_sample__intval(sample, "next_pid");
 	u64 prev_state = perf_sample__intval(sample, "prev_state");
+	char *backtrace;
 
 	/* perf.data is untrusted input — CPU may be absent or corrupted */
 	if (sample->cpu >= MAX_CPUS) {
@@ -688,8 +685,7 @@ process_sample_sched_switch(struct timechart *tchart,
 #ifdef SUPPORT_OLD_POWER_EVENTS
 static int
 process_sample_power_start(struct timechart *tchart __maybe_unused,
-			   struct perf_sample *sample,
-			   const char *backtrace __maybe_unused)
+			   struct perf_sample *sample)
 {
 	u64 cpu_id = perf_sample__intval(sample, "cpu_id");
 	u64 value  = perf_sample__intval(sample, "value");
@@ -706,8 +702,7 @@ process_sample_power_start(struct timechart *tchart __maybe_unused,
 
 static int
 process_sample_power_end(struct timechart *tchart,
-			 struct perf_sample *sample,
-			 const char *backtrace __maybe_unused)
+			 struct perf_sample *sample)
 {
 	/* perf.data is untrusted input — CPU may be absent or corrupted */
 	if (sample->cpu >= MAX_CPUS) {
@@ -721,8 +716,7 @@ process_sample_power_end(struct timechart *tchart,
 
 static int
 process_sample_power_frequency(struct timechart *tchart,
-			       struct perf_sample *sample,
-			       const char *backtrace __maybe_unused)
+			       struct perf_sample *sample)
 {
 	u64 cpu_id = perf_sample__intval(sample, "cpu_id");
 	u64 value  = perf_sample__intval(sample, "value");
@@ -895,8 +889,7 @@ static int pid_end_io_sample(struct timechart *tchart, int pid, int type,
 
 static int
 process_enter_read(struct timechart *tchart,
-		   struct perf_sample *sample,
-		   const char *backtrace __maybe_unused)
+		   struct perf_sample *sample)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_READ,
@@ -905,8 +898,7 @@ process_enter_read(struct timechart *tchart,
 
 static int
 process_exit_read(struct timechart *tchart,
-		  struct perf_sample *sample,
-		  const char *backtrace __maybe_unused)
+		  struct perf_sample *sample)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_READ,
@@ -915,8 +907,7 @@ process_exit_read(struct timechart *tchart,
 
 static int
 process_enter_write(struct timechart *tchart,
-		    struct perf_sample *sample,
-		    const char *backtrace __maybe_unused)
+		    struct perf_sample *sample)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_WRITE,
@@ -925,8 +916,7 @@ process_enter_write(struct timechart *tchart,
 
 static int
 process_exit_write(struct timechart *tchart,
-		   struct perf_sample *sample,
-		   const char *backtrace __maybe_unused)
+		   struct perf_sample *sample)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_WRITE,
@@ -935,8 +925,7 @@ process_exit_write(struct timechart *tchart,
 
 static int
 process_enter_sync(struct timechart *tchart,
-		   struct perf_sample *sample,
-		   const char *backtrace __maybe_unused)
+		   struct perf_sample *sample)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_SYNC,
@@ -945,8 +934,7 @@ process_enter_sync(struct timechart *tchart,
 
 static int
 process_exit_sync(struct timechart *tchart,
-		  struct perf_sample *sample,
-		  const char *backtrace __maybe_unused)
+		  struct perf_sample *sample)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_SYNC,
@@ -955,8 +943,7 @@ process_exit_sync(struct timechart *tchart,
 
 static int
 process_enter_tx(struct timechart *tchart,
-		 struct perf_sample *sample,
-		 const char *backtrace __maybe_unused)
+		 struct perf_sample *sample)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_TX,
@@ -965,8 +952,7 @@ process_enter_tx(struct timechart *tchart,
 
 static int
 process_exit_tx(struct timechart *tchart,
-		struct perf_sample *sample,
-		const char *backtrace __maybe_unused)
+		struct perf_sample *sample)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_TX,
@@ -975,8 +961,7 @@ process_exit_tx(struct timechart *tchart,
 
 static int
 process_enter_rx(struct timechart *tchart,
-		 struct perf_sample *sample,
-		 const char *backtrace __maybe_unused)
+		 struct perf_sample *sample)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_RX,
@@ -985,8 +970,7 @@ process_enter_rx(struct timechart *tchart,
 
 static int
 process_exit_rx(struct timechart *tchart,
-		struct perf_sample *sample,
-		const char *backtrace __maybe_unused)
+		struct perf_sample *sample)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_RX,
@@ -995,8 +979,7 @@ process_exit_rx(struct timechart *tchart,
 
 static int
 process_enter_poll(struct timechart *tchart,
-		   struct perf_sample *sample,
-		   const char *backtrace __maybe_unused)
+		   struct perf_sample *sample)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_POLL,
@@ -1005,8 +988,7 @@ process_enter_poll(struct timechart *tchart,
 
 static int
 process_exit_poll(struct timechart *tchart,
-		  struct perf_sample *sample,
-		  const char *backtrace __maybe_unused)
+		  struct perf_sample *sample)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_POLL,
-- 
2.54.0.1032.g2f8565e1d1-goog

