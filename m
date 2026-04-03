Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782783D8128
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 20:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248849; cv=none; b=hebAunjc6gymPuhIYgvp92aWEVs37lC04M50OzpBHok6yIJrRCCsPYigrQI15OCqBsU3mh///CUoTMAgP49+8K9TT06x8UTT3drLgnZjiNj0+8iGiPnaA+WVPkzMfA/NYqXSwosWc93BbfavaWG0BIuvCQErlmgyYLmGBDsxFck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248849; c=relaxed/simple;
	bh=R10gAxw23kSBK/h718oJExyOmJYEzsW//g5xoEppAlI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gy5cE5bhQErI8vw4VEVVFwSoUxvhb7PIXgK0oQ/eUicmN2yIBVSpTW1JgwwbIqr2XB0Bfkl/YK1uS8bkqFWwBh5ooQ7wtTTs/DC9O3YHodWBxXoMTaVCC6E+ImgWUCyKRS94Qq066RA4cfmq35ZQSwDhdk+Vpr2Nlw9WQHKhE/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rs9Y/iIy; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rs9Y/iIy"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1276e71652fso4452721c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 13:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775248846; x=1775853646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BStLNx8zvU11CILdD69lDCLupBLvf41S1zWL07N8khM=;
        b=Rs9Y/iIyOgBj6KNJrMT2qGBFpzEZbtZp/uIdIydlEaxC6/alC+gDaRVpOji8vcjuxp
         0Y9xpVvRjT08sHzDOh4dzNKkZ9evbvLWWsDwN4CXlMmCT8CwspzAsnw4ar2JZlxIA9tC
         M84BzctgG1sg1l7cX6+R7rF7ASqr7JD8GAX3uBYDCIqSOF+uQFMYM14hkXOIyq2VoGoF
         lR1tOvAY0CaGQgyWKt9mRJOTkFGXNXhbvYpcoHg4W7wwu/O0CRoW0oO1nbcsAWvnyzJ0
         F4n1250o0qyMGmkqlMO4BcQ/k7y0/1T7AoptP7F/BiArakpFfEnAip28ukJTh3HdKS2e
         F9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775248846; x=1775853646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BStLNx8zvU11CILdD69lDCLupBLvf41S1zWL07N8khM=;
        b=r+TiZpFTqe24dAHnlzrLz1uD8DUrepymHFJ1HUVgBhN0u6olEy2GFI24W9B7PLAM7i
         +TLC//a7g3c3LXv/FIeo6GabZAd/LjlB23cnWXeDQY+RWz6L48+m/VGC6pmyf/VbLlXl
         FVQ5QQ1RlTPKPqqOFrNUFSgk9X0sEe90KnrZZSPGZ0JQc7rycYrVC5HRmLzl3e82K4DK
         BuHqY1hDDW+ZBDSZsEzEV5tqX2qpVikBVvbEfRXlvqpu3adyom985r17q3qR0MME8Rtv
         bELVznEfXuRte4goU3hhYYwE6YXPaCto8z2kOS1MZkGk2Cw+s8d5vOzjdqiaIYs432ty
         S3Og==
X-Forwarded-Encrypted: i=1; AJvYcCUCidhyqmGIZxeNoWYg12td0V+ovJ5pJmgaatUWxMnSV4kwHEWk9VWEBId1rzZroANSQBGL+dxkg+Aoq3NergSV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/BjMyC79ckKldI+MaKO8bhfID19mo7blwyAw/FgndVFn844ka
	pH+hM6fk8ERZDimztfYNL7QZZjmjY1Zg1ektjG7w5Ju7XvzKel5FGvfgYzsS/66FX+j2/o107aE
	g+rdaie9dmQ==
X-Received: from dlak28.prod.google.com ([2002:a05:701b:291c:b0:128:f2cd:cb37])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:69a0:b0:12a:71ab:8235
 with SMTP id a92af1059eb24-12bfb6ed5c1mr1956832c88.6.1775248845302; Fri, 03
 Apr 2026 13:40:45 -0700 (PDT)
Date: Fri,  3 Apr 2026 13:40:01 -0700
In-Reply-To: <20260403204017.2919994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fXDd2_uqRHGOrbbjsAjbunsW67P-kONsmhm6UZWQUc-2w@mail.gmail.com>
 <20260403204017.2919994-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403204017.2919994-10-irogers@google.com>
Subject: [PATCH v5 09/25] perf lock: Only pass sample to handlers
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

