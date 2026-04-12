Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47D82C0296
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959737; cv=none; b=XbisemmzSHwW7rpZ3I1iZjf3TR2XYcsiphDZxbCkO7sLcsrdV7xduTIjZLuJkRX1uwzszvkkx41rIqANOif/3IH2D9B28LG8sayFWJLlGHS6HDBur5lrAtEaRDrdQfej1D9J4QCWGBtybBcOnZHgpe6VpBkgO/+/vqd4SFRv7J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959737; c=relaxed/simple;
	bh=prBz7H5bPPlrwyBSAROWCo/Ll26E8LcFo8xgs78Vbuc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=meKJVPMno6v3gThBN/2M05jKT3RnJDNVHB+NM8LuZKVneeNWYcHdOp69AOr2VUrg5MD2aH719V50UcwR/Atr4k4+fv2UGWg4uJu9dG5HpbvCyIiz6JT6xPC4X12WlZ+GEE2Ns8aaLLI/6fR0m78BdHvC9uXvNmjOrJBPCL9grcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ro5SL9Dc; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ro5SL9Dc"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c16233ee11so4424657eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775959735; x=1776564535; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0hURWYdBxgdHgsqOj9+Yqb4bXTIq+qPK0X2PdODRxIQ=;
        b=Ro5SL9DcXqNhDqxg1C696rePgNt3El6k6Lz+8hjz2ztZsETnsixbJ6cMTHd/57izER
         uPfwtZWpAZ67NTQp373vzxXC2MOE/C7fJg8VKditsESapXO2c3rMnGN1lMDK4BxpA5U4
         vlxk+TEJKgoRQ4iqjnYIKOQ966yjcjs6pxXVxEhJCayFjcllvdysmERA/fC2SQoI3Y8M
         1Tvw7ALvFhL0U0x1bSUjOqY4ukEKX+GbXX+6aC0Z7I2LzrCSJfRKSmljpz9RyThR6e4m
         CRkzVT+oPC5g+sbAcejHucA7/qyjpbSRv0zXMqiYL0Dw7pCkpzupDHlFXaKxHIwDmV9T
         ct6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959735; x=1776564535;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hURWYdBxgdHgsqOj9+Yqb4bXTIq+qPK0X2PdODRxIQ=;
        b=kRypIBmAQitZajCLon+5nKu83xXrwL+t+YEvhWqulKc4JMuhokmO1Dju6IScqyr36j
         rBCLSgcqGMiIuxHGbjdzw0GdYWtgKdeoI1oB5f3vtWE7PF0Yd/Xx2fMlhOIPr28Cel+K
         BFXxpXmtF16iQx06pav2lGkN87Z+EKkVpgzKAFipoHauienbMZ1ncs50L97MRLCoL5rr
         VsfY6lETdxt43nDi/2C8AG7UTrgBYBW1Htsb76Ft9hO68JEs0nCHwv0kfrSPja9VaiQc
         qcyFb1g/T+LP7gWtgKEET05S1eDJZNHh18LsbbSAZXr+Bluf7P2wUwxvssrOJy3v5l6D
         VHSg==
X-Forwarded-Encrypted: i=1; AFNElJ/vuC1m6t4fGCIUqoxOj3uc7lP/YyPfKcTfLPM1EqBQ5ovSeCSssbsGlt7QmdmsgIrdTlci6ZX46CCtd+djfR66@vger.kernel.org
X-Gm-Message-State: AOJu0YyE/Z23m3IFN03Nz49bh+16t0AJXNoWinGL8nMf3MYHkgCZ+PEJ
	t2HvBTC4J5z+qV7GfQhrnoIRMw2QK1ewngC9G3MatgSvS4af6TFojWdrKJda7klXh98yo5WtdNY
	+N1mbTQRKyA==
X-Received: from dycou11.prod.google.com ([2002:a05:7300:dc8b:b0:2c6:8e1:498d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6da3:b0:2d4:afb3:7b06
 with SMTP id 5a478bee46e88-2d5874a85e1mr5113606eec.8.1775959734676; Sat, 11
 Apr 2026 19:08:54 -0700 (PDT)
Date: Sat, 11 Apr 2026 19:08:10 -0700
In-Reply-To: <20260412020833.641177-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260412020833.641177-8-irogers@google.com>
Subject: [PATCH v10 07/29] perf lock: Only pass sample to handlers
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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

The evsel is within the sample and so only the sample needs to be
passed. Remove the parameter and fix call site.

Add an additional NULL check in get_callstack, as prompted by Sashiko
during review.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 76 ++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 41 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index e2b585e528ac..fcc33089b945 100644
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
@@ -948,9 +938,16 @@ static u64 *get_callstack(struct perf_sample *sample, int max_stack)
 	u64 i;
 	int c;
 
+	if (!sample->callchain) {
+		pr_debug("Sample unexpectedly missing callchain\n");
+		return NULL;
+	}
+
 	callstack = calloc(max_stack, sizeof(*callstack));
-	if (callstack == NULL)
+	if (callstack == NULL) {
+		pr_debug("Failed to allocate callstack\n");
 		return NULL;
+	}
 
 	for (i = 0, c = 0; i < sample->callchain->nr && c < max_stack; i++) {
 		u64 ip = sample->callchain->ips[i];
@@ -963,8 +960,7 @@ static u64 *get_callstack(struct perf_sample *sample, int max_stack)
 	return callstack;
 }
 
-static int report_lock_contention_begin_event(struct evsel *evsel __maybe_unused,
-					      struct perf_sample *sample)
+static int report_lock_contention_begin_event(struct perf_sample *sample)
 {
 	struct lock_stat *ls;
 	struct thread_stat *ts;
@@ -1070,7 +1066,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel __maybe_unused
 	if (needs_callstack()) {
 		u64 *callstack = get_callstack(sample, max_stack_depth);
 		if (callstack == NULL)
-			return -ENOMEM;
+			return 0;
 
 		if (!match_callstack_filter(machine, callstack, max_stack_depth)) {
 			free(callstack);
@@ -1127,8 +1123,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel __maybe_unused
 	return 0;
 }
 
-static int report_lock_contention_end_event(struct evsel *evsel __maybe_unused,
-					    struct perf_sample *sample)
+static int report_lock_contention_end_event(struct perf_sample *sample)
 {
 	struct lock_stat *ls;
 	struct thread_stat *ts;
@@ -1208,45 +1203,45 @@ static struct trace_lock_handler contention_lock_ops  = {
 
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
 
@@ -1424,8 +1419,7 @@ static int process_event_update(const struct perf_tool *tool,
 	return 0;
 }
 
-typedef int (*tracepoint_handler)(struct evsel *evsel,
-				  struct perf_sample *sample);
+typedef int (*tracepoint_handler)(struct perf_sample *sample);
 
 static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 				union perf_event *event,
@@ -1445,7 +1439,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
-		err = f(evsel, sample);
+		err = f(sample);
 	}
 
 	thread__put(thread);
-- 
2.53.0.1213.gd9a14994de-goog

