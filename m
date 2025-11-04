Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22A4348891
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Nov 2025 23:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299721; cv=none; b=u0zYp2FSlI1NU1hHoc+wsYNkfjaNJAGGIlOOP4lKCsBRsd6xJbIXA/yUj250gV8r53W/s0AyZ/WFNHv8uXOf7sx+vhA8SgXE4woQxmOZzXEi9LCtECi5hf3iasRKkLv7IkZHWv8UgkrAmGKdQcsb29b2tcwlsdDgNCKz18mUMbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299721; c=relaxed/simple;
	bh=bJbxS9bBatxeYgFbkEtaODM1/57yTM4qiiWIKLBpyXA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=hhC9NzbfmneS8xPYDXDEdMipe/Uo4x4YhCq0RKtGs8f6TN9sgokaizZiKOKe9UNPG0mNW2ZQlBuJRFIwB5gABgB4ijlLQcfdSJgeIyGg0kM0m4wxVZhRBZlCG6gVJnD3DScdAKEXqtQBc+XfqJiJsvK0t3lfrs4OILkcACJTDkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xzZGNcdk; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xzZGNcdk"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b969f3f5bb1so7625393a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Nov 2025 15:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762299719; x=1762904519; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GDR4fNhLPPj2XAMnNCUJwi9KHHqZBJ1VgCgYtFssSHU=;
        b=xzZGNcdkpwuDyh2MQ1ZLAv10zyHlu9+5C5CZAu+iSGYU7b0tyLiYRH7gNeDhDMVckE
         ml2gIHiY6PZ7mKu3PWrRVir7SxGyGGG1xChUuKwiCzxHQMrw6wJGngODYJZI0qIDr9EL
         LtDHmWRCqnHxrHTcjQiEPF91uduJeu68kOs9dqfgz12GrNKgU+2lOfD9jw6Xoo/NRn0U
         ECjsO5YMwCCzSzZFpveyEeba5FDG/C9/GfexUjk6AdPadQfHEnhKeAKyNQuEk6v5jUzu
         VgI9/LcsWqnZbYG1oyApjwVRSUasONph3qMU24js0Z0lBEdfrYTnU24WY+hiQ3dpQumQ
         ckBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762299719; x=1762904519;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GDR4fNhLPPj2XAMnNCUJwi9KHHqZBJ1VgCgYtFssSHU=;
        b=RC+cxTkJCkFnjenR+i2aoNOANOkfCF0BSNEGKznz57+pkPKXBi0kZtpWkqB1d3eJ17
         lmYXa3bAkp63nSkA4mo74xM1goDHGEkv2KfVP0N/vvmMammXJ9ZH5kg2cndGvGMgni/z
         UW6HczrJ/oPiO1VFqLjE1iJF4Po9u1px8ziDjBILpXVqvErIscZumJiWIyIfJL9garRV
         KA8cevWMCRl//iFc35ZAEra4ygIP/mOGiG0VUon8gkP7ZzbqVekc6y3odgm3VTU/Lf0L
         xAtgteXzhMXCOAh+liMigUS4+ZRezCyLAZynkGu32QPiJ+GkgSmhAMMkCAMAj0hsUkg6
         ro8w==
X-Forwarded-Encrypted: i=1; AJvYcCUF5B0aIaufrvSEAHY66yuvKI4sD0y3fFIKzN8aCzI9fLgS26D2dji2UJVsyJ43v1YD2EkBcHEsEo8j4EhGaXtc@vger.kernel.org
X-Gm-Message-State: AOJu0YyYZZ/xdguD7VeV/Cp1dbcfH+FYz7qwLdSBuVcQMGTkOgO0xmyS
	1RTdqGUd4NoC6idgWCaXIznA92k7iDgjn2PPFR+2+7Y198gtRWlRBeLvZE/PkOchO+HNBikkFBY
	HJWZfWAok/A==
X-Google-Smtp-Source: AGHT+IGQKFWkbw/0w02HmgEtGqNY5xF/QMNYbw7JTx6i8rZxEONlur5j1kykfmfyFQbKqO6q0uvP85j7pdho
X-Received: from dlag5.prod.google.com ([2002:a05:701b:2505:b0:119:49ca:6ba2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a03:b0:341:3b91:69c7
 with SMTP id adf61e73a8af0-34f8450a80bmr1483585637.11.1762299719222; Tue, 04
 Nov 2025 15:41:59 -0800 (PST)
Date: Tue,  4 Nov 2025 15:41:46 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <20251104234148.3103176-1-irogers@google.com>
Subject: [PATCH v2 1/3] perf tool_pmu: Use old_count when computing count
 values for time events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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
2.51.2.1006.ga50a493c49-goog

