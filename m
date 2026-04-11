Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A1A3195FB
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935053; cv=none; b=qztsW84lcmXT+oeTuQbWuzKOwjrWbtmexH6zaSV0yVS0MhDTCq7A4vKiszEj+4oNLaY3AespWD9Aq9TCNf3Xm1O+/WG6KJgjdJ2Fx/CHjTvwvZ6h+ZNndsrY23cXsCqLB3tCTXpk70K8s4I8Wk8VnFD4Z5f8N1yZrsp6bWu+oG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935053; c=relaxed/simple;
	bh=srft1YpHVgvrU4YwBw1nklafUGnhS7BQiyv9cKKsyjk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CYtM6nSt/kzH4ZehvAMSqcp3we7Fl7/KS+CctV6H12n0pHNTVaaUHLhbCkQoP3n6hxvJ5q2afWTdiuZrPRPUS0cAqBMnxAJs2IpCotlJtz4D+Qtin0a5VEaL5cbrXSu6qwtJnkMdxxJn+H/87cZpXd5nYlnhlpeSSJI9/wDOsgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ig6SJGXh; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ig6SJGXh"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12711ec96fbso8571042c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 12:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775935051; x=1776539851; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I8kdyhopRVI6sp+LKwScoQa/JfvPSDXt9W/za6nwsjI=;
        b=ig6SJGXhF2RkJ0xqCqRtM2mFjeYTK3x6K4Sq8DcAVmpceYeZZMJrj8qvGpJvNV9oQi
         VARCGODNXWedTMuMIPMjE/5TFg/NpXjkHBP5royQNYjm+wAXTyjf6shxKoAEEJdKMDyd
         MPDKoCgcLJDNmrL0ygIubqCtB2xYA0oyVCmkpci4zUdWXnk47fNHQxHMrgkj9kagGc87
         JCk21CY6pQO/uk/zaxRVVhl4rNKB8aduwTEi+W355Sg0+52XRPG7yCVYCdCN4AGRV88n
         X3uMEQ6lsL0oSGNNA5RZkQ3sII0ckC4owSdJk5PNAPsgtUrCbG/Q1WLR9XLCKp29v3CJ
         TKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775935051; x=1776539851;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8kdyhopRVI6sp+LKwScoQa/JfvPSDXt9W/za6nwsjI=;
        b=S9e3g2BBTBsFUFONij89+yBZPfyE5vo9f2ef2Mhki7JV149Ly73vu62AF1AZm02Cou
         AU8GEU2q1eYaECpFN2Ej8B240Z3rtCINbdVEdz2KK6uAvIMPGd6gY57ZmDrIvTo696cs
         6ThBY5z3Aqml/vbKtNSJH/vsMcf02H19v+ZSI8wycuKmKAgUthAd7ORsiLPkWnw9G3Au
         uXDFcmkumPXes/TbQHC+vW8uW1+XEHbVsV/lj8eQKKfRXzfk9O3NMfEi0XHSTadoqzZ9
         kAdAFGqy2dcPVs8Ezla8xlBZXKByxhFf2q4u7/u1/knrMFOJFPNBkxQghp43iTTwKiMQ
         Ev9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtP0wm+vzM0/CAvZKOhPucFlh3vVXwCIDkJxdyy7vjOGAxPsDdpMPp+ko3WMYsiscR0zfeRg31uUPJg0LTQYOA@vger.kernel.org
X-Gm-Message-State: AOJu0YzHViuXX1i2CDH2cwglGCwk63MOnWKCj9yyucQzgR5aTOdfelbZ
	thrACPwRvMGl5CCGlNhPDiWUcClILfXbWvZSlhuZFsB+X1RreiJwRkMgr95mdmGHvtqC2t+4KMe
	qsrNsY9EGgw==
X-Received: from dlbvg4.prod.google.com ([2002:a05:7022:7f04:b0:12c:18c1:703c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:699a:b0:12a:72af:83d1
 with SMTP id a92af1059eb24-12c34ea9cffmr4349640c88.11.1775935050610; Sat, 11
 Apr 2026 12:17:30 -0700 (PDT)
Date: Sat, 11 Apr 2026 12:16:48 -0700
In-Reply-To: <20260411191710.524998-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411065718.372240-1-irogers@google.com> <20260411191710.524998-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411191710.524998-8-irogers@google.com>
Subject: [PATCH v9 07/29] perf lock: Only pass sample to handlers
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

The evsel is within the sample and so only the sample needs to be
passed. Remove the parameter and fix call site.

Add an additional NULL check in get_callstack, as prompted by Sashiko
during review.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 69 ++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 41 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index e2b585e528ac..2a6fc4c97dcd 100644
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
@@ -949,8 +939,8 @@ static u64 *get_callstack(struct perf_sample *sample, int max_stack)
 	int c;
 
 	callstack = calloc(max_stack, sizeof(*callstack));
-	if (callstack == NULL)
-		return NULL;
+	if (callstack == NULL || !sample->callchain)
+		return callstack;
 
 	for (i = 0, c = 0; i < sample->callchain->nr && c < max_stack; i++) {
 		u64 ip = sample->callchain->ips[i];
@@ -963,8 +953,7 @@ static u64 *get_callstack(struct perf_sample *sample, int max_stack)
 	return callstack;
 }
 
-static int report_lock_contention_begin_event(struct evsel *evsel __maybe_unused,
-					      struct perf_sample *sample)
+static int report_lock_contention_begin_event(struct perf_sample *sample)
 {
 	struct lock_stat *ls;
 	struct thread_stat *ts;
@@ -1127,8 +1116,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel __maybe_unused
 	return 0;
 }
 
-static int report_lock_contention_end_event(struct evsel *evsel __maybe_unused,
-					    struct perf_sample *sample)
+static int report_lock_contention_end_event(struct perf_sample *sample)
 {
 	struct lock_stat *ls;
 	struct thread_stat *ts;
@@ -1208,45 +1196,45 @@ static struct trace_lock_handler contention_lock_ops  = {
 
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
 
@@ -1424,8 +1412,7 @@ static int process_event_update(const struct perf_tool *tool,
 	return 0;
 }
 
-typedef int (*tracepoint_handler)(struct evsel *evsel,
-				  struct perf_sample *sample);
+typedef int (*tracepoint_handler)(struct perf_sample *sample);
 
 static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 				union perf_event *event,
@@ -1445,7 +1432,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 
 	if (evsel->handler != NULL) {
 		tracepoint_handler f = evsel->handler;
-		err = f(evsel, sample);
+		err = f(sample);
 	}
 
 	thread__put(thread);
-- 
2.53.0.1213.gd9a14994de-goog

