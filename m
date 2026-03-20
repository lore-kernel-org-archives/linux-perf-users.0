Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E467D3FA5ED
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034904; cv=none; b=elY8EEpQo3AzasC/6fNWf9U5YOokPHB+HHJsqLUvCjLPnBb8Hz28ZycpeReqTMV17BafhzAJtA5uQZt8yQzzVb2PlQfBqgR+NNAFU7aKtBNu5P4ldrIXd3TCuC4mPWJ0mr/T/FELlisdmiy+qvCd/NJDIkRNFD7l/u0tpaTVQAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034904; c=relaxed/simple;
	bh=19yi0++eVPW89pl3buX6d/PyThRne9kD8qxMvttHRQU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WSgpE1yt3gU+QpgU79pPJEZHKOXfHw6B3tBooFm+X4tr9PESMIJquziCOrzqxzPJI5v4epKjpG3DYeU35MMCAfnenpE8s7k10fen6nmj799/6whTy2HtAJr5WEuWBtzwhh5+1gXR/nhDoSeeMJB7uD3VCH1dlZO/vNF3/fYQnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MuhRnlZU; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MuhRnlZU"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1276e71652fso951267c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 12:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774034900; x=1774639700; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X4aFDGz+ocU8pLrA7jQQlv23G1GT6rQZLR8GkVLQCjI=;
        b=MuhRnlZUEtXYPDQrGB2E711vh8Ye/3yunQ1fcYSAiZngrSUN1XspJ03nSMpkpQ6Gjx
         W+yd738nTijGGtieoKnLqBWlpvF+YiA6hlsnHikk/In6RmFxPNVs0TeQIejmg0fsPYWV
         zf7DS9pA9u25tZzCiEbN+upmNWQZAmn54LFMyWwXfccglexpzFaFFmn9mWQW8hlxiTZS
         64b3zDYXmbvFIYGJvBgOoPswyIXnAXjWDL06ptqd2EILB83OoBMzw6ODXken/LzRNgLq
         GTuoAWsGy/GDF2fvFx0677P/hZCOtPmywrovRbh6XvWjr9O67VTvELCgIA9MqEMWP9jQ
         U6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034900; x=1774639700;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4aFDGz+ocU8pLrA7jQQlv23G1GT6rQZLR8GkVLQCjI=;
        b=f0g4sMq8LwBFiGXLb1XgncnSP+ElseT+S3OPvW2XGc9CRa9ypBLxZBuSiQqn3d4JXT
         Pl1LnzobAV1Kq98U0Nwr61KuUYdEA+q6tM6m54yF6+n+fqILvch5BhLfa/RfKCrvfbjH
         56SEJLFp2UksOL4LKwmd/BdwieJHazGq9vS24v2BrVG2bH/uL/xqpfKs9aaQj+ugfFAs
         PEZckp6Dw9NiE5fYq0Teqk5ooWSjOtYdbA1wtteqeer+nM0v+Dc675ijPs8ktMghkGKH
         DzILCPK379enze8fnhNuGcpc2V7QPOsSgIxIJ0efCg0wkjrfw/lk+7qh8D9tTBJcbk7r
         6crA==
X-Forwarded-Encrypted: i=1; AJvYcCWUGS02XHajHoJKVsTkLYQYh1ofVKiTDbzdjUSYbLjFrmCnl86Yko8TBz4w9ZJl5syWM5ZxVyF9kFFZiWWmR0l7@vger.kernel.org
X-Gm-Message-State: AOJu0YweZVUA1Z9T7uOqy6q2gacXBGrKdFEUpH+MjhZdawYPpjmMIWLq
	Ph19uJFDCSzmOSCKZWjxQjihU/6a7Js3eLoz9mFCfROKFZQDQKI/Mn3sJ76Gjcahd3cfyZZ2rUC
	f5DqALC2lXA==
X-Received: from dlag7.prod.google.com ([2002:a05:701b:2507:b0:128:dfaf:10ac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:31a:b0:123:3488:899f
 with SMTP id a92af1059eb24-12a726ce100mr1656605c88.32.1774034899653; Fri, 20
 Mar 2026 12:28:19 -0700 (PDT)
Date: Fri, 20 Mar 2026 12:26:11 -0700
In-Reply-To: <20260320192627.368357-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320080835.724836-1-irogers@google.com> <20260320192627.368357-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320192627.368357-10-irogers@google.com>
Subject: [PATCH v4 09/25] perf lock: Only pass sample to handlers
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

