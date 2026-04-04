Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69E7337BA0
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Apr 2026 03:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775274241; cv=none; b=gj+d+uBO7kJXxisB+z1Effhe9JIimdp3+Bv9i+ZpomeZnyBUIThHZE0QDssYnezfRz2Go0uDp9XP+jIR73P/6bxzZ1SINhJyegdgS/crhFsus23+SGpC3UKpkNettr5WI/2xA4vAm0WXM9U+GHmMCg5Nxi/Hliv46B9A4DNceUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775274241; c=relaxed/simple;
	bh=R10gAxw23kSBK/h718oJExyOmJYEzsW//g5xoEppAlI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fbm/xlamnnwefzqEhouyYXMkiYfOpaZkkYbpqEHenbLZkyTPgzlbCJpJrIN1ddE/x6Gedwzebkye1wiAUkbBOdFPutOZINpe+wuqWqV5qH/J+PFOdhzEJQuGaOJPtWHn+VBsV9tmViOTeJ6zOtELZZvUIu72COvo55qd8Jw3bfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KqNwQ5SJ; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KqNwQ5SJ"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12bf9974587so7266595c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 20:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775274236; x=1775879036; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BStLNx8zvU11CILdD69lDCLupBLvf41S1zWL07N8khM=;
        b=KqNwQ5SJCfWneq1tWbM01DKlTIEuYsmC35LfCCYhvh6nbHnx2GShSG2tpJCAe1VIC3
         Kt/tlb6DJFJffUT1dhUIwOBc6CD1tF2+86bqQwqXBEtYWiTQthtzFTVMMBWo51Yz/N81
         8UfjpB20wy9MXcgVG85jb7S6laaYorHi+t3blb6Uubo3rwiyxt21JiTNBgaL0Wv7p+N1
         eT1CGZfkZGpOs0IAYABw59HNjqU/ctM7uveCxnnJ9ehg7eYolwLfQe/6Hb03a9p5+QFz
         NeQzLhMZg25/HPcIu7pZgm7rctGe8GtcsAiKHyTlz9YWUMGdVTiZ83vK3kvbwoNJ2pb7
         G/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775274236; x=1775879036;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BStLNx8zvU11CILdD69lDCLupBLvf41S1zWL07N8khM=;
        b=Ht50/hubVxWY3cX1283ovY5chovzamyr3bG1sn8D8bxg5hLgP8QEWgRc2rNfS9dInC
         zRvV12Og/nroWwgS0OIO0XHIHD0Y62FobTK/4NwxZ7WALNL3ASwkqzR3yKzBQ6cC5eKH
         +hNgBQdaGVHirrEUybCvm3nuCPJ4F3QWvGUEbb2Vst4KepeGPUUoEEpD6NUdRPIM3fVs
         /XyJGSOWF/VMUzQSICbVyFitJh3fsjl3bHuFGsHmylvxmaJBTgemE5jO5LGJOrovdEde
         0jnsXvBQ1wUHvIYlcj+YLqOiCX8ueI1uYc01L3w95vViYO6b5SAcmQUABejISzRSTwpF
         UZlA==
X-Forwarded-Encrypted: i=1; AJvYcCXGo8VytUcqC5pg3+ECYtYBzbFpMSHMaUBAAa1WL58qrLGrxS3+jNZC8fpMAYMBq7Osdg7DaHV7JuVbROa0bZh4@vger.kernel.org
X-Gm-Message-State: AOJu0YxEbwjBDMh6wOqetmWRzq4gxi536XluAIO+3MKwL3qG/OCRUzsM
	qNMvTB2Eq0JnMSFcf21sipSPyT7U9yB899eHEoqobuWmbNkOXOh4LDXSYR7IhHIY+MmcXf3gbZP
	btBSxjfO40A==
X-Received: from dlbts25-n2.prod.google.com ([2002:a05:7022:b059:20b0:12b:e1fe:a938])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e02:b0:12b:ebf6:a3bb
 with SMTP id a92af1059eb24-12bfb7089bfmr2529307c88.14.1775274236157; Fri, 03
 Apr 2026 20:43:56 -0700 (PDT)
Date: Fri,  3 Apr 2026 20:43:09 -0700
In-Reply-To: <20260404034325.3172592-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260403204017.2919994-1-irogers@google.com> <20260404034325.3172592-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260404034325.3172592-10-irogers@google.com>
Subject: [PATCH v6 09/25] perf lock: Only pass sample to handlers
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

The evsel is within the sample and so only the sample needs to be
passed. Remove the parameter and fix call site.

Add an additional NULL check in get_callstack, as prompted by Sashiko
during review.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 68 +++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 39 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index e2b585e528ac..8ccb64415d3b 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -473,28 +473,22 @@ static struct lock_stat *pop_from_result(void)
 
 struct trace_lock_handler {
 	/* it's used on CONFIG_LOCKDEP */
-	int (*acquire_event)(struct evsel *evsel,
-			     struct perf_sample *sample);
+	int (*acquire_event)(struct perf_sample *sample);
 
 	/* it's used on CONFIG_LOCKDEP && CONFIG_LOCK_STAT */
-	int (*acquired_event)(struct evsel *evsel,
-			      struct perf_sample *sample);
+	int (*acquired_event)(struct perf_sample *sample);
 
 	/* it's used on CONFIG_LOCKDEP && CONFIG_LOCK_STAT */
-	int (*contended_event)(struct evsel *evsel,
-			       struct perf_sample *sample);
+	int (*contended_event)(struct perf_sample *sample);
 
 	/* it's used on CONFIG_LOCKDEP */
-	int (*release_event)(struct evsel *evsel,
-			     struct perf_sample *sample);
+	int (*release_event)(struct perf_sample *sample);
 
 	/* it's used when CONFIG_LOCKDEP is off */
-	int (*contention_begin_event)(struct evsel *evsel,
-				      struct perf_sample *sample);
+	int (*contention_begin_event)(struct perf_sample *sample);
 
 	/* it's used when CONFIG_LOCKDEP is off */
-	int (*contention_end_event)(struct evsel *evsel,
-				    struct perf_sample *sample);
+	int (*contention_end_event)(struct perf_sample *sample);
 };
 
 static struct lock_seq_stat *get_seq(struct thread_stat *ts, u64 addr)
@@ -563,8 +557,7 @@ static int get_key_by_aggr_mode(u64 *key, u64 addr,
 	return get_key_by_aggr_mode_simple(key, addr, sample->tid);
 }
 
-static int report_lock_acquire_event(struct evsel *evsel __maybe_unused,
-				     struct perf_sample *sample)
+static int report_lock_acquire_event(struct perf_sample *sample)
 {
 	struct lock_stat *ls;
 	struct thread_stat *ts;
@@ -638,8 +631,7 @@ static int report_lock_acquire_event(struct evsel *evsel __maybe_unused,
 	return 0;
 }
 
-static int report_lock_acquired_event(struct evsel *evsel __maybe_unused,
-				      struct perf_sample *sample)
+static int report_lock_acquired_event(struct perf_sample *sample)
 {
 	struct lock_stat *ls;
 	struct thread_stat *ts;
@@ -704,8 +696,7 @@ static int report_lock_acquired_event(struct evsel *evsel __maybe_unused,
 	return 0;
 }
 
-static int report_lock_contended_event(struct evsel *evsel  __maybe_unused,
-				       struct perf_sample *sample)
+static int report_lock_contended_event(struct perf_sample *sample)
 {
 	struct lock_stat *ls;
 	struct thread_stat *ts;
@@ -762,8 +753,7 @@ static int report_lock_contended_event(struct evsel *evsel  __maybe_unused,
 	return 0;
 }
 
-static int report_lock_release_event(struct evsel *evsel  __maybe_unused,
-				     struct perf_sample *sample)
+static int report_lock_release_event(struct perf_sample *sample)
 {
 	struct lock_stat *ls;
 	struct thread_stat *ts;
@@ -948,6 +938,9 @@ static u64 *get_callstack(struct perf_sample *sample, int max_stack)
 	u64 i;
 	int c;
 
+	if (!sample->callchain)
+		return NULL;
+
 	callstack = calloc(max_stack, sizeof(*callstack));
 	if (callstack == NULL)
 		return NULL;
@@ -963,8 +956,7 @@ static u64 *get_callstack(struct perf_sample *sample, int max_stack)
 	return callstack;
 }
 
-static int report_lock_contention_begin_event(struct evsel *evsel __maybe_unused,
-					      struct perf_sample *sample)
+static int report_lock_contention_begin_event(struct perf_sample *sample)
 {
 	struct lock_stat *ls;
 	struct thread_stat *ts;
@@ -1127,8 +1119,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel __maybe_unused
 	return 0;
 }
 
-static int report_lock_contention_end_event(struct evsel *evsel __maybe_unused,
-					    struct perf_sample *sample)
+static int report_lock_contention_end_event(struct perf_sample *sample)
 {
 	struct lock_stat *ls;
 	struct thread_stat *ts;
@@ -1208,45 +1199,45 @@ static struct trace_lock_handler contention_lock_ops  = {
 
 static struct trace_lock_handler *trace_handler;
 
-static int evsel__process_lock_acquire(struct evsel *evsel, struct perf_sample *sample)
+static int evsel__process_lock_acquire(struct perf_sample *sample)
 {
 	if (trace_handler->acquire_event)
-		return trace_handler->acquire_event(evsel, sample);
+		return trace_handler->acquire_event(sample);
 	return 0;
 }
 
-static int evsel__process_lock_acquired(struct evsel *evsel, struct perf_sample *sample)
+static int evsel__process_lock_acquired(struct perf_sample *sample)
 {
 	if (trace_handler->acquired_event)
-		return trace_handler->acquired_event(evsel, sample);
+		return trace_handler->acquired_event(sample);
 	return 0;
 }
 
-static int evsel__process_lock_contended(struct evsel *evsel, struct perf_sample *sample)
+static int evsel__process_lock_contended(struct perf_sample *sample)
 {
 	if (trace_handler->contended_event)
-		return trace_handler->contended_event(evsel, sample);
+		return trace_handler->contended_event(sample);
 	return 0;
 }
 
-static int evsel__process_lock_release(struct evsel *evsel, struct perf_sample *sample)
+static int evsel__process_lock_release(struct perf_sample *sample)
 {
 	if (trace_handler->release_event)
-		return trace_handler->release_event(evsel, sample);
+		return trace_handler->release_event(sample);
 	return 0;
 }
 
-static int evsel__process_contention_begin(struct evsel *evsel, struct perf_sample *sample)
+static int evsel__process_contention_begin(struct perf_sample *sample)
 {
 	if (trace_handler->contention_begin_event)
-		return trace_handler->contention_begin_event(evsel, sample);
+		return trace_handler->contention_begin_event(sample);
 	return 0;
 }
 
-static int evsel__process_contention_end(struct evsel *evsel, struct perf_sample *sample)
+static int evsel__process_contention_end(struct perf_sample *sample)
 {
 	if (trace_handler->contention_end_event)
-		return trace_handler->contention_end_event(evsel, sample);
+		return trace_handler->contention_end_event(sample);
 	return 0;
 }
 
@@ -1424,8 +1415,7 @@ static int process_event_update(const struct perf_tool *tool,
 	return 0;
 }
 
-typedef int (*tracepoint_handler)(struct evsel *evsel,
-				  struct perf_sample *sample);
+typedef int (*tracepoint_handler)(struct perf_sample *sample);
 
 static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 				union perf_event *event,
@@ -1445,7 +1435,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
-		err = f(evsel, sample);
+		err = f(sample);
 	}
 
 	thread__put(thread);
-- 
2.53.0.1213.gd9a14994de-goog

