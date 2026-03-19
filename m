Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8090C407583
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 23:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773962663; cv=none; b=h8jRM4N0cJBt3UkQzggg3y+A8Z1kEO70809DqY/F331Lka/hlMHEH2dnHqv4zD0Lnu6bwDoaHx0i2+CoBntMvfAyhtY7w+DizL81tqS8oXycxbUxpZOWjfQIGfdAycuyzRNnQ/KM1S4Z5hFzNDeig7JlQK4W9lB+gmNe39yiUUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773962663; c=relaxed/simple;
	bh=19yi0++eVPW89pl3buX6d/PyThRne9kD8qxMvttHRQU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GJMoyg4t32gaTRnHvirQUUVoMlPlJkYDtGCxHLiNsPriZZlZorpupsljKIdbQnj9rLfdsV/TqDXRXW7gooWdrLGBDyRRcIj9gu+6XwDPEW0V+lo2H1R6yM1bTgiqZ389TsfS3jUlN4i4erMG5wZnee7OQI1x6dETIQnH0EgZSSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ANDdIHNf; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ANDdIHNf"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-128e8ac314eso19391c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 16:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773962661; x=1774567461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X4aFDGz+ocU8pLrA7jQQlv23G1GT6rQZLR8GkVLQCjI=;
        b=ANDdIHNfYHMhG4hfNqzhVtUVPK88iz/S2pnvZlhp8SOlUQIt0r/1fbndCCj/GCvvZq
         slVp0vNqOQIyi4vEmLoziDYynrQpCdcOLiBnytKlTD5xLfn4EnaV8tXMK+oqzIuBDIkv
         uAEjnU5XcxneM1Tn1bjnhPbbZzc3WanexOL1dSaQ0E4UVaQJQjUfCz8oaRCta4QhKOG4
         v6OhY2r2qjquht/BPrJJIXG7i+DFzrBNP3WqVG4FzKHpCesnKIUx2ki32J8TTaK7Jz2d
         uBLv/IUOplVGSB8oGRoZRE4Di9944o0GAuDsQr6Y1gMS23jR2WlR7FmjhTzk2fP0m//c
         wu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773962661; x=1774567461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4aFDGz+ocU8pLrA7jQQlv23G1GT6rQZLR8GkVLQCjI=;
        b=HKfQPbYodq5zec5TpgRuAJ5EGTn1Rk0ISn7cp9chhJ+mgOt7W9rLPKq7TCGLntZS5y
         8/bOGhbfGtecktQAJ2+MVzBuwp1nRx29z3f6b+wFIys709I1uNy0nVzAY5FVAfVEOsZD
         DLEMBegL2h7zfM2Uxog03GRETJEerBBtLBfgl1RiAspmk6ep7CVye3dwnO3CAJr+AAlb
         0is7Fa8CH0mu8TXTs55ENR9Zjxa6MxtmJSBIdvBAgAHwyRznWh0mFA8iEvWs7OJEyvoX
         odToo6+4Dri7qkIuD9M+OF7CfOji75xis263D4qTW43/fBX6wIgkeNG7v3mZpF1jfdF0
         e4tw==
X-Forwarded-Encrypted: i=1; AJvYcCVGJWgPwaAwPmHR/FDKkvI88MNZfo8/tcb7HPz2RyFAW2oxC569QtNa84ZfhQOqm8ZzjZfrUcdVfiP/Wrtw71ND@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2GuvQ84yXhkW4nvIzN6QrSSYZXfcvCrNkfnpKzjzXr4A2diuD
	2Qjx3Xg05RX9ZdMUjzEIH1McvQ+YNWWremcGTuw5HUngAZ+yqCJ3TK7rgkVep6QSFIUaiRuAVgb
	wgT7dQowmJg==
X-Received: from dybnj1.prod.google.com ([2002:a05:7300:d081:b0:2c0:db56:eddb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6606:b0:127:33e0:ea40
 with SMTP id a92af1059eb24-12a726600aamr502694c88.15.1773962660461; Thu, 19
 Mar 2026 16:24:20 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:23:18 -0700
In-Reply-To: <20260319232334.287517-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209174032.4142096-1-irogers@google.com> <20260319232334.287517-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260319232334.287517-10-irogers@google.com>
Subject: [PATCH v2 09/25] perf lock: Only pass sample to handlers
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 65 ++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 39 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index a35e8ea4e2ef..78fb39d06e7c 100644
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
2.53.0.959.g497ff81fa9-goog

