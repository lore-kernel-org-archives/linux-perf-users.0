Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457E73C7DF8
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935079; cv=none; b=pLjDgErlrxxEs0vLB4Qehchvrkezq8jtu4o+hnv+flhoG1k8fNk7xluwxUm/ne8HyEy6mWdS8hzfzcNdCaWvSe+wY6TAYt1YitCt+5VjKHlKQMCB5PeLX8xyhKOUs+mxM0Y8t/EGHqaFJCu+kMgt8wuTxs06m/ovzST1q3mkssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935079; c=relaxed/simple;
	bh=Im4bWCGAqHMTYy4uyecGi/SwW+6BOc827mw/qVwWBKA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VcVvUXIyVpG1iv1MLrZ996DgQvnhMmpp6OJaZegWsehrrL3M+rCbKUOzB6BKoTWlicPFxEjovtDkdEn2qyrqqa8Dy1AKFtgrfCc17chHa46WcrB4y6G/waroknODYHIE8rs5yJV8SlTuu6GBV6UxdpFRFluqymHdJ57FkawIXdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CtQlzrXz; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CtQlzrXz"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so4446514eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775935077; x=1776539877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V875rdm+fYN7H67duT8OOY3KvL0xtVelt87jMl+YDgg=;
        b=CtQlzrXz+E4E6YQtcXnNj3gkbGjmK6q/Lny762KyB6ebesc80OVNHRKWH0PRSlPVfi
         OblcNg4m7gdmTIqxvJ6JHx1ukNA2EJ1nko5rJmIaPRX9B75ZQ7JTPzU+k6FgLkwj905E
         9Eorey99TTZUyI3vowPMOxXnacJNY+ZKRNZThMnF2BGV/8i4u1NkMYApC056cBB8apzg
         eXgfv4sPTVzPSc0PI0HYfjkQ2qev3t1FvkzhVFXPN6soc9uRBYeGOjOl5rzykFCCLMy9
         taPq0OLfTTHruBr+3+59tXsePbt5r8A/rleQY8LwV7JumZf8LcygvVULHWHc98Dl0vIu
         /1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775935077; x=1776539877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V875rdm+fYN7H67duT8OOY3KvL0xtVelt87jMl+YDgg=;
        b=WOFuuzU3qTi+UsXqPXSHjSDlmi0Z0pLeBcg+FqxpYPAohhg/MOJ4C/6NZAuXDKkJDM
         uPFuGC4838PLIx5Pq58Ql+FIROaY7G8VfpfOCGzwhgCfQNoSRWLguC9bmSmawIZKZdUh
         3K0RFbJe3cl4qNo3bFylaybAOcGO/qNQIwEcebomb3qbZNiPczlpyXmO8WGK653DBGna
         qVTeEp2xZnwpTARbQVqgpAvuZ2u3xTucY+W1/rj7108Eb9ks583vbxuYhF/d64uWAzsk
         I78mxqrjzP7CpLhfkWiMgPDNekFxAlf6y6346XK23Kz6J0YrLwCxG6/gJJ1qSBn5FxuA
         ouvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+F6RrXKs1eDPRxwYiUcFq7sjDuFZ+GrYxzpq9EqjxTXCWBTWF9Neu2lynDFqQIpK7u0hiohPOlcrVW/B0QJ7aL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2EJvU8an46wKl977guCKxsbQ0qAW6bXnU1OVrO9NrRbRtLmSD
	AougxWplJKClkJDcFQS+5khUmSJSlapCTnkm0eSRZH8nVimOxFPVJqaHitLisHb1mEiM02V0NTO
	nNgDsKLbbDw==
X-Received: from dys21.prod.google.com ([2002:a05:693c:8015:b0:2be:4118:56f1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e2cc:b0:2d3:4252:b127
 with SMTP id 5a478bee46e88-2d5898a5246mr5065762eec.26.1775935077130; Sat, 11
 Apr 2026 12:17:57 -0700 (PDT)
Date: Sat, 11 Apr 2026 12:16:59 -0700
In-Reply-To: <20260411191710.524998-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411065718.372240-1-irogers@google.com> <20260411191710.524998-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411191710.524998-19-irogers@google.com>
Subject: [PATCH v9 18/29] perf timechart: Don't pass evsel with sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The sample contains the evsel and so it is unnecessary to pass the
evsel as well. Add missing backtrace argument to tracepoint_handler
functions and mark them unused. Fix missing free from cat_backtrace,
which requires copies of the backtrace being made in functions that
save it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-timechart.c | 81 ++++++++++++++++------------------
 1 file changed, 39 insertions(+), 42 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 034e0ba3f9cb..64f69bd67c6b 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -299,7 +299,7 @@ static void pid_put_sample(struct timechart *tchart, int pid, int type,
 	sample->type = type;
 	sample->next = c->samples;
 	sample->cpu = cpu;
-	sample->backtrace = backtrace;
+	sample->backtrace = backtrace ? strdup(backtrace) : NULL;
 	c->samples = sample;
 
 	if (sample->type == TYPE_RUNNING && end > start && start > 0) {
@@ -433,7 +433,7 @@ static void sched_wakeup(struct timechart *tchart, int cpu, u64 timestamp,
 
 	we->time = timestamp;
 	we->waker = waker;
-	we->backtrace = backtrace;
+	we->backtrace = backtrace ? strdup(backtrace) : NULL;
 
 	if ((flags & TRACE_FLAG_HARDIRQ) || (flags & TRACE_FLAG_SOFTIRQ))
 		we->waker = -1;
@@ -489,9 +489,9 @@ static void sched_switch(struct timechart *tchart, int cpu, u64 timestamp,
 	}
 }
 
-static const char *cat_backtrace(union perf_event *event,
-				 struct perf_sample *sample,
-				 struct machine *machine)
+static char *cat_backtrace(union perf_event *event,
+			   struct perf_sample *sample,
+			   struct machine *machine)
 {
 	struct addr_location al;
 	unsigned int i;
@@ -544,8 +544,10 @@ static const char *cat_backtrace(union perf_event *event,
 				 * It seems the callchain is corrupted.
 				 * Discard all.
 				 */
-				zfree(&p);
-				goto exit;
+				addr_location__exit(&al);
+				fclose(f);
+				free(p);
+				return NULL;
 			}
 			continue;
 		}
@@ -567,7 +569,6 @@ static const char *cat_backtrace(union perf_event *event,
 }
 
 typedef int (*tracepoint_handler)(struct timechart *tchart,
-				  struct evsel *evsel,
 				  struct perf_sample *sample,
 				  const char *backtrace);
 
@@ -578,6 +579,7 @@ static int process_sample_event(const struct perf_tool *tool,
 {
 	struct timechart *tchart = container_of(tool, struct timechart, tool);
 	struct evsel *evsel = sample->evsel;
+	int ret = 0;
 
 	if (evsel->core.attr.sample_type & PERF_SAMPLE_TIME) {
 		if (!tchart->first_time || tchart->first_time > sample->time)
@@ -588,16 +590,17 @@ static int process_sample_event(const struct perf_tool *tool,
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
-		return f(tchart, evsel, sample,
-			 cat_backtrace(event, sample, machine));
+		char *backtrace = cat_backtrace(event, sample, machine);
+
+		ret = f(tchart, sample, backtrace);
+		free(backtrace);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int
 process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
-			struct evsel *evsel __maybe_unused,
 			struct perf_sample *sample,
 			const char *backtrace __maybe_unused)
 {
@@ -613,7 +616,6 @@ process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
 
 static int
 process_sample_cpu_frequency(struct timechart *tchart,
-			     struct evsel *evsel __maybe_unused,
 			     struct perf_sample *sample,
 			     const char *backtrace __maybe_unused)
 {
@@ -626,7 +628,6 @@ process_sample_cpu_frequency(struct timechart *tchart,
 
 static int
 process_sample_sched_wakeup(struct timechart *tchart,
-			    struct evsel *evsel __maybe_unused,
 			    struct perf_sample *sample,
 			    const char *backtrace)
 {
@@ -640,7 +641,6 @@ process_sample_sched_wakeup(struct timechart *tchart,
 
 static int
 process_sample_sched_switch(struct timechart *tchart,
-			    struct evsel *evsel __maybe_unused,
 			    struct perf_sample *sample,
 			    const char *backtrace)
 {
@@ -656,7 +656,6 @@ process_sample_sched_switch(struct timechart *tchart,
 #ifdef SUPPORT_OLD_POWER_EVENTS
 static int
 process_sample_power_start(struct timechart *tchart __maybe_unused,
-			   struct evsel *evsel __maybe_unused,
 			   struct perf_sample *sample,
 			   const char *backtrace __maybe_unused)
 {
@@ -669,7 +668,6 @@ process_sample_power_start(struct timechart *tchart __maybe_unused,
 
 static int
 process_sample_power_end(struct timechart *tchart,
-			 struct evsel *evsel __maybe_unused,
 			 struct perf_sample *sample,
 			 const char *backtrace __maybe_unused)
 {
@@ -679,7 +677,6 @@ process_sample_power_end(struct timechart *tchart,
 
 static int
 process_sample_power_frequency(struct timechart *tchart,
-			       struct evsel *evsel __maybe_unused,
 			       struct perf_sample *sample,
 			       const char *backtrace __maybe_unused)
 {
@@ -849,8 +846,8 @@ static int pid_end_io_sample(struct timechart *tchart, int pid, int type,
 
 static int
 process_enter_read(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
-		   struct perf_sample *sample)
+		   struct perf_sample *sample,
+		   const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_READ,
@@ -859,8 +856,8 @@ process_enter_read(struct timechart *tchart,
 
 static int
 process_exit_read(struct timechart *tchart,
-		  struct evsel *evsel __maybe_unused,
-		  struct perf_sample *sample)
+		  struct perf_sample *sample,
+		  const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_READ,
@@ -869,8 +866,8 @@ process_exit_read(struct timechart *tchart,
 
 static int
 process_enter_write(struct timechart *tchart,
-		    struct evsel *evsel __maybe_unused,
-		    struct perf_sample *sample)
+		    struct perf_sample *sample,
+		    const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_WRITE,
@@ -879,8 +876,8 @@ process_enter_write(struct timechart *tchart,
 
 static int
 process_exit_write(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
-		   struct perf_sample *sample)
+		   struct perf_sample *sample,
+		   const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_WRITE,
@@ -889,8 +886,8 @@ process_exit_write(struct timechart *tchart,
 
 static int
 process_enter_sync(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
-		   struct perf_sample *sample)
+		   struct perf_sample *sample,
+		   const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_SYNC,
@@ -899,8 +896,8 @@ process_enter_sync(struct timechart *tchart,
 
 static int
 process_exit_sync(struct timechart *tchart,
-		  struct evsel *evsel __maybe_unused,
-		  struct perf_sample *sample)
+		  struct perf_sample *sample,
+		  const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_SYNC,
@@ -909,8 +906,8 @@ process_exit_sync(struct timechart *tchart,
 
 static int
 process_enter_tx(struct timechart *tchart,
-		 struct evsel *evsel __maybe_unused,
-		 struct perf_sample *sample)
+		 struct perf_sample *sample,
+		 const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_TX,
@@ -919,8 +916,8 @@ process_enter_tx(struct timechart *tchart,
 
 static int
 process_exit_tx(struct timechart *tchart,
-		struct evsel *evsel __maybe_unused,
-		struct perf_sample *sample)
+		struct perf_sample *sample,
+		const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_TX,
@@ -929,8 +926,8 @@ process_exit_tx(struct timechart *tchart,
 
 static int
 process_enter_rx(struct timechart *tchart,
-		 struct evsel *evsel __maybe_unused,
-		 struct perf_sample *sample)
+		 struct perf_sample *sample,
+		 const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_RX,
@@ -939,8 +936,8 @@ process_enter_rx(struct timechart *tchart,
 
 static int
 process_exit_rx(struct timechart *tchart,
-		struct evsel *evsel __maybe_unused,
-		struct perf_sample *sample)
+		struct perf_sample *sample,
+		const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_RX,
@@ -949,8 +946,8 @@ process_exit_rx(struct timechart *tchart,
 
 static int
 process_enter_poll(struct timechart *tchart,
-		   struct evsel *evsel __maybe_unused,
-		   struct perf_sample *sample)
+		   struct perf_sample *sample,
+		   const char *backtrace __maybe_unused)
 {
 	long fd = perf_sample__intval(sample, "fd");
 	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_POLL,
@@ -959,8 +956,8 @@ process_enter_poll(struct timechart *tchart,
 
 static int
 process_exit_poll(struct timechart *tchart,
-		  struct evsel *evsel __maybe_unused,
-		  struct perf_sample *sample)
+		  struct perf_sample *sample,
+		  const char *backtrace __maybe_unused)
 {
 	long ret = perf_sample__intval(sample, "ret");
 	return pid_end_io_sample(tchart, sample->tid, IOTYPE_POLL,
-- 
2.53.0.1213.gd9a14994de-goog

