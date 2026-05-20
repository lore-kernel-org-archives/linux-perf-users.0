Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4326C33C536
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303958; cv=none; b=aCn8LJLpo7vuVMH7otgFeHArx7YjX2iziPxLZVD+BUbFrpI3GMZCR5mLzYDXPtuTjvnwRZiScwD+0lGVHZi4HBdWoo9K2xAIHq853UJ+/wvESjHvV2Mp/oap1jrUz50ATEy71kWEGi3vudvW5MSWW3uvvnQtHdDaqtSoiA6KpfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303958; c=relaxed/simple;
	bh=DgzHmOYSYn2uLT+fYBJPm5OlTiBBHNnSiqK+ZCjElQo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wbu8h26hASR42aA6FacQJhsWeLFchDDZzae1lWBiJpKYkAnAD/qvYcfywHHQvnSEwEeEEzNB67qX2haNfut8OA9aAAoKlejTg8dtq5ljXrvwZcSTibfX4vQ/NxRZodwTmWpJ+K6V/ZlBtZcCy0qC+iOsdjJkT55FSrvEF/A8tPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R9U9Jijs; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R9U9Jijs"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13537722193so5205370c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303955; x=1779908755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r92aXxEoXgfeSuGnD4Sdyf7/sfrwS2JHQy+tgwbWlMs=;
        b=R9U9JijsATaC7VIyNfjxw28Qu9ANoPuhB+RmGCEYoLLgjCHE09aNUMeaDZcaSj+vjr
         dtvYK8CNGh+3i5hzXaKwO3G6vBbFT7+eHqEsEArcsF2KmyNUiDKAvClza01WGGJO+x2j
         y/+8Gb52AzwkutXJdefnbhEuRQnkLwH35YYl77eAT6Hep+3WMS2rqP+sDWQqnUydrMRZ
         /eG6Hrtf+06kD1yKoOnKXXGXSGFB5sjJPrzlpDaR179LzDyarXovZHIzR5DUFHqD8CNw
         kHZo7UOLIS6X4SkhI40b+o//9Y16UsKhRfd9ER0bwhQmHrSdw/UijQ849tl5BkOW7SHc
         j31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303955; x=1779908755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r92aXxEoXgfeSuGnD4Sdyf7/sfrwS2JHQy+tgwbWlMs=;
        b=l08Bnpqwk68cgSA/Vf1Hw8a2+9JZuHnSl32hi0V6D/04u5+XoWeJWICVn/WPPErq0D
         ZzivjK/SnGLn9hx0hPHKvSHt/ng+BRTkHnkVZRNIo352QiOe1LAgVbFuRXFxATdwZZTq
         g2cBwgwyIKuSwybB8+6VEeBGS5q16qjPBk5RCV5p0rzLG3g1SVak7hSDBYhI2j0/8cd+
         14uf8EuFVAMtwJB+XS1iJSTcgVwqgRhRwpwqmwufhKNNZmTpPdkB/fFBP5WZvbbMo21o
         XCtqq1/2A3p3eKuwXfIMO9bV32W8TH7YhKFujWm6kNmqrEWy7BXIzV8lMCBFW/VWf2EP
         LLqw==
X-Forwarded-Encrypted: i=1; AFNElJ/HGTKsdWCKjNfzv2809wZ8N1CXgznO/QnENGqr/FVG0aeF6awec2ZOQTkKgRjFvzHJ5Zo/UjvY7QfbyulDDBl+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Iq62KWQ4fnYjivhcZh/BBTjsHYPPFkw01dUxTP79LMmG/lus
	FRVF5sx0VBcttAe51RnSrSyDBiyfxUDwH5zmEQN4L9xCmr+9/PvIBZr1IyMoffvywLhE+EpQ1Ew
	WP8RVdxyiFg==
X-Received: from dlbsj7.prod.google.com ([2002:a05:7022:f907:b0:135:dc3d:ab61])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1e11:b0:12d:de3f:d843
 with SMTP id a92af1059eb24-1350494e25cmr11444471c88.38.1779303955080; Wed, 20
 May 2026 12:05:55 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:12 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-7-irogers@google.com>
Subject: [PATCH v14 06/32] perf lock: Only pass sample to handlers
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

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 65 ++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 39 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index e2b585e528ac..b6533483ba64 100644
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
2.54.0.746.g67dd491aae-goog

