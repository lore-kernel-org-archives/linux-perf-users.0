Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A236607C;
	Thu,  4 Jun 2026 21:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780609774; cv=none; b=bLJSK7dJ/awahMUdtCoS92eDtiqTIwd0p+1CXb1svyfY6Xnef9Jvs+djTNnlyfXaox8gjm1RyGtMHyjK0EGxB6pEC9HDLXaHlqKND7I2x5346uvIpWUIkmFeo0qfimcGXwzAmnzatBZyAr10iOU5ACCXuDEdc4l0FP1mhj1xNew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780609774; c=relaxed/simple;
	bh=I09/5Vx7pX70v3M6E8LVuJiEffdvMyax+D/hwDY7iJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3nC+rLeR+449EhN8AXYnutIPgwHI1r0vyvrTuug+ZlchWshTuOV/NQWWOlwP/UBFD2QFfGg8vItxsi9nEbzpIJQL94kYTZ0VQ7TWwuWK6Iy4HnmkOQAz173BsH3QGctCGYyhCsT3JOk3HmsdZhXIngNEfM1JTxEXAmYFAVDWeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2z/5ADI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2z/5ADI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7D41F0089C;
	Thu,  4 Jun 2026 21:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780609773;
	bh=N+VvgQE3Pcoy6/O8RxZuhyvDE6MlJ/x53ALB+DgYqaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n2z/5ADI4c2LeondsstBA/Kq18KoHuv1gdFdixoYPNBrszQPvUNOEeOHJJ44UXeFN
	 C3Pgru60BJrupRERWTbsedaO7bEBFFNTaG8BW1C5FS3nVd49gQXk9+qtiR35yxKwe0
	 rZCialWAm/zi8wpqLb/ZpAqZXnZk7AbywgVnR7OWjWAGnRxot/9B3Hf+hgewedMNoN
	 lTK30vSTIzPzJWAbS9esOMqquanQfAeTJGtLVMIkAzFXCJdHmyQFVYVOex4Y0t+XN6
	 j5oL49Unqw4ID+qTcX/WNY/Giji6WPNreS+iGjCMRGg9QQLfrTIvg0FEAA/6wMcjY3
	 +2Yjw4bReMDGw==
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
Subject: [PATCH v2 3/4] perf timechart: Remove unused backtrace in trace_handler
Date: Thu,  4 Jun 2026 14:49:29 -0700
Message-ID: <20260604214931.2202322-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260604214931.2202322-1-namhyung@kernel.org>
References: <20260604214931.2202322-1-namhyung@kernel.org>
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

