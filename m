Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD172DFF1D
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413173; cv=none; b=r3uUclsunFOmClq4pUePj+4/6kesBoNfWs3UfajFYfQaZZasWjDina2qZVSuc570fxas6r5B4esKxjy8T1339OB08vK76ERsttzhYmqLSuB63FYvAy+ZjhJLgLz8c3JAb5109SVhFfpMLX6Wnaht92MP8j9vHNom7wfFb2w6038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413173; c=relaxed/simple;
	bh=LNyMR/FxzeM/nBYJ1n7Go6LoKgm+Jmbzge6v2T7XY8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fe24csulSmE9Vpgf4ENLki/4bT4sZxA3SniGYA7uiUqNYrbIGhuC78knxzXlPNhx0ynSsDj8lTf33veTo5lQXfl3/JjJBylGwSkGdGRHEDwtMbVIx6hILAHnDmOQ0S9NsuNuM6GrYMmOhLhgTZ3QCf877HPvHX6BZ/CUs5FVsxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g563hXW2; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g563hXW2"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7ae70693579so101473b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Nov 2025 23:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762413171; x=1763017971; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e+Pdd5axpxJgS59kogXuDTxSRBSKUwiMlRaE/rJ5GNI=;
        b=g563hXW2VU3eiWiSWB+PNbhQA6k4KPCd3uKyfIPgPI7mSfsWlQq1Aw9FoT6olqRMlV
         GhiZX45hOVC0bhuDr0sV668ATE35iwn6k7+maiTdh0dBqSPV8EBNcF0Zl7REeCtn/m0q
         l28bzOYNHxcXg4l/lZG8GjvKPbOj3Q5kgly5x4n2r6hOjIOz9Sdbt/eV4BGt7lKHkJP/
         20pitox59WvDHZUlYXdQ7Ah8H6WCemyi3dgutcl2hfvz2SjEY/nLPRCSIY+j59EwBPMS
         1O1B57Xts3urxrztU+xusW8P/IQ0SXVQFt0/EE8+swgHH6dCmgVODLSXFB9m6csxDGls
         oXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762413171; x=1763017971;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+Pdd5axpxJgS59kogXuDTxSRBSKUwiMlRaE/rJ5GNI=;
        b=hDWVFunff9d+77hsB0am/DwqErm41ndM17sU9OA8/mnPNF5NMKewqtZrJFE/yqGSRA
         i0rWa5KJaAltTX4khCt6Fq0WAFGFJDa+EaNvP9d7yIoxAK61gSq/rt3kPgj6BZfTIf2q
         v4sOP4Q1v/0Ue72GRnjz2L7NlKuRPAd7MfIKggiAW/6RYhls4chzsjkj4gF2kQViqSXv
         3Vy5tOo8QJ3wak99Chp3oEvjBBsz4bp/AJLOx6+xUtXgC8JUSk7mLo6ndI9HMs7Mx98c
         RsvHbk224ZXvUkAqrVta1/N0KdkIsDSoO1tzw+ZOQ+uHX46cVk3hqqbvEIlBdgyrKXmK
         uusQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb84i14n+b5y1ygR2TJUppwadgQbTIY2eIPvTRqtrL1Yl7Hu+kzfGVR0BJhInnfVXbtfYYzu2+x8NIhT6Ydlbz@vger.kernel.org
X-Gm-Message-State: AOJu0YwcS+EQjlMPjS5qj1gt7bBrqTaRZ4HRz3pw2N/TCKSplRZOqGF5
	sRHRqW1sGLYPhIBAqTxveoPF2GWtW1x36cqfT5rFuNdtqFaMaaAKLaqosl6KUzSazH+zpnfv50I
	Eh89W7hB96w==
X-Google-Smtp-Source: AGHT+IHDBJfzNDXDcNCXyM0+krjWpqxKuX9/kAV9YiS3jz8dK8m2B7xctOqy+nX3koRLFJMTdGGi4sFyE9Pf
X-Received: from dlbrs16.prod.google.com ([2002:a05:7022:f690:b0:119:49ca:6baf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2589:b0:34f:2341:cbc6
 with SMTP id adf61e73a8af0-34f86409639mr8958653637.52.1762413171178; Wed, 05
 Nov 2025 23:12:51 -0800 (PST)
Date: Wed,  5 Nov 2025 23:12:34 -0800
In-Reply-To: <20251106071241.141234-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106071241.141234-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106071241.141234-4-irogers@google.com>
Subject: [PATCH v3 3/9] perf tool_pmu: Use old_count when computing count
 values for time events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

When running in interval mode every third count of a time event isn't
showing properly:
```
$ perf stat -e duration_time -a -I 1000
     1.001082862      1,002,290,425      duration_time
     2.004264262      1,003,183,516      duration_time
     3.007381401      <not counted>      duration_time
     4.011160141      1,003,705,631      duration_time
     5.014515385      1,003,290,110      duration_time
     6.018539680      <not counted>      duration_time
     7.022065321      1,003,591,720      duration_time
```
The regression came in with a different fix, found through bisection,
commit 68cb1567439f ("perf tool_pmu: Fix aggregation on
duration_time"). The issue is caused by the enabled and running time
of the event matching the old_count's and creating a delta of 0, which
is indicative of an error.

Fixes: 68cb1567439f ("perf tool_pmu: Fix aggregation on duration_time")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c  | 16 +++++++++--
 tools/perf/util/tool_pmu.c | 59 +++++++++++++++++++++-----------------
 2 files changed, 46 insertions(+), 29 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 886727ae8529..d89fa9468f89 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -282,17 +282,27 @@ static int read_single_counter(struct evsel *counter, int cpu_map_idx, int threa
 	if (err && cpu_map_idx == 0 &&
 	    (evsel__tool_event(counter) == TOOL_PMU__EVENT_USER_TIME ||
 	     evsel__tool_event(counter) == TOOL_PMU__EVENT_SYSTEM_TIME)) {
-		u64 val, *start_time;
 		struct perf_counts_values *count =
 			perf_counts(counter->counts, cpu_map_idx, thread);
+		struct perf_counts_values *old_count = NULL;
+		u64 val;
+
+		if (counter->prev_raw_counts)
+			old_count = perf_counts(counter->prev_raw_counts, cpu_map_idx, thread);
 
-		start_time = xyarray__entry(counter->start_times, cpu_map_idx, thread);
 		if (evsel__tool_event(counter) == TOOL_PMU__EVENT_USER_TIME)
 			val = ru_stats.ru_utime_usec_stat.mean;
 		else
 			val = ru_stats.ru_stime_usec_stat.mean;
-		count->ena = count->run = *start_time + val;
+
 		count->val = val;
+		if (old_count) {
+			count->run = old_count->run + 1;
+			count->ena = old_count->ena + 1;
+		} else {
+			count->run++;
+			count->ena++;
+		}
 		return 0;
 	}
 	return err;
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index f075098488ba..b895e88ff740 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -431,16 +431,39 @@ bool tool_pmu__read_event(enum tool_pmu_event ev, struct evsel *evsel, u64 *resu
 	}
 }
 
+static void perf_counts__update(struct perf_counts_values *count,
+				const struct perf_counts_values *old_count,
+				bool raw, u64 val)
+{
+	/*
+	 * The values of enabled and running must make a ratio of 100%. The
+	 * exact values don't matter as long as they are non-zero to avoid
+	 * issues with evsel__count_has_error.
+	 */
+	if (old_count) {
+		count->val = raw ? val : old_count->val + val;
+		count->run = old_count->run + 1;
+		count->ena = old_count->ena + 1;
+		count->lost = old_count->lost;
+	} else {
+		count->val = val;
+		count->run++;
+		count->ena++;
+		count->lost = 0;
+	}
+}
+
 int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 {
 	__u64 *start_time, cur_time, delta_start;
-	u64 val;
-	int fd, err = 0;
+	int err = 0;
 	struct perf_counts_values *count, *old_count = NULL;
 	bool adjust = false;
 	enum tool_pmu_event ev = evsel__tool_event(evsel);
 
 	count = perf_counts(evsel->counts, cpu_map_idx, thread);
+	if (evsel->prev_raw_counts)
+		old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
 
 	switch (ev) {
 	case TOOL_PMU__EVENT_HAS_PMEM:
@@ -451,26 +474,18 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	case TOOL_PMU__EVENT_NUM_PACKAGES:
 	case TOOL_PMU__EVENT_SLOTS:
 	case TOOL_PMU__EVENT_SMT_ON:
-	case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ:
-		if (evsel->prev_raw_counts)
-			old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
-		val = 0;
+	case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ: {
+		u64 val = 0;
+
 		if (cpu_map_idx == 0 && thread == 0) {
 			if (!tool_pmu__read_event(ev, evsel, &val)) {
 				count->lost++;
 				val = 0;
 			}
 		}
-		if (old_count) {
-			count->val = old_count->val + val;
-			count->run = old_count->run + 1;
-			count->ena = old_count->ena + 1;
-		} else {
-			count->val = val;
-			count->run++;
-			count->ena++;
-		}
+		perf_counts__update(count, old_count, /*raw=*/false, val);
 		return 0;
+	}
 	case TOOL_PMU__EVENT_DURATION_TIME:
 		/*
 		 * Pretend duration_time is only on the first CPU and thread, or
@@ -486,9 +501,9 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	case TOOL_PMU__EVENT_USER_TIME:
 	case TOOL_PMU__EVENT_SYSTEM_TIME: {
 		bool system = evsel__tool_event(evsel) == TOOL_PMU__EVENT_SYSTEM_TIME;
+		int fd = FD(evsel, cpu_map_idx, thread);
 
 		start_time = xyarray__entry(evsel->start_times, cpu_map_idx, thread);
-		fd = FD(evsel, cpu_map_idx, thread);
 		lseek(fd, SEEK_SET, 0);
 		if (evsel->pid_stat) {
 			/* The event exists solely on 1 CPU. */
@@ -522,17 +537,9 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	if (adjust) {
 		__u64 ticks_per_sec = sysconf(_SC_CLK_TCK);
 
-		delta_start *= 1000000000 / ticks_per_sec;
+		delta_start *= 1e9 / ticks_per_sec;
 	}
-	count->val    = delta_start;
-	count->lost   = 0;
-	/*
-	 * The values of enabled and running must make a ratio of 100%. The
-	 * exact values don't matter as long as they are non-zero to avoid
-	 * issues with evsel__count_has_error.
-	 */
-	count->ena++;
-	count->run++;
+	perf_counts__update(count, old_count, /*raw=*/true, delta_start);
 	return 0;
 }
 
-- 
2.51.2.1041.gc1ab5b90ca-goog

