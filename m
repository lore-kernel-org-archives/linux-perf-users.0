Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796992F5A07
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057151; cv=none; b=RtuolpC8+qo8Y9y/elhbk8P/Xez01NM6achyZihsGw76MF+YNMAMDv5evlldMcmQX3FezdtIacUyLQVQ8a6H7MKBN8RxsmED7PF6y/SHUFL68u5pVLIM1Wt6YAo0QdL+nSYID8XqvzgBuLAhLLE4Nn1qKZQ2qUUKKiORQUteGpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057151; c=relaxed/simple;
	bh=74ic2NR19Qj1jkhqoFr5/GAzNGfc9K6j6Uwf4Hjc/ss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KYLQJincppqa5OLzqY1o93rAUggqNx+fjWVPfZTps+GwJ8evpA/b2yaInnfUYgXUIL6p6sdkN+V1rhAHD+SPW8gxDQop6h24L9NXmRSkSceTooFVrUuQ1OiuLhiwT369AT7rieysgknoABFDkt/XTCKrKjkadVvoaBVCDljgNtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mri/KYzG; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mri/KYzG"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b5533921eb2so930859a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 10:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763057149; x=1763661949; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JvaqfEqqQj/hZXmBgRInugRb7NiwpIIhCyLsGdqnH4o=;
        b=mri/KYzGgwNibHkgXkR6nA8YW7d7+yF4GCCymoKxubSUAMemno6qhBFsk+x6Ng8MC3
         bo2W5Har5/+mQrt0JDaTCT12rV1YUFBsWYdIjOUcZWi9Vr8NqNt1jtIAdsT8VbTbVaKI
         wacYDUBBMHc4uUPMrwT6nbe3oMhW1J58g8FcHCkYNW4XSsrq6CPQlUzkw6IS3K9Gz6Ol
         LusZ43K+033Pm3IEKJcZQj7FKCCDrEy6p8DU7cS67OECI6hg5VgmZhQl+8yHIanof7Og
         zSbHeeItWQhY4XNFAXabmDIlUSAQBB6yaC85ZRIexyofaEWG2Jb54tWA5F73ztpXbBaF
         dzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057149; x=1763661949;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JvaqfEqqQj/hZXmBgRInugRb7NiwpIIhCyLsGdqnH4o=;
        b=T5w+3otzTsg/mQShWczfFDGFpIXH1ajaKEHDPsSwKefyU1t7hQ5Jc8KIA5hQdLD3q7
         THC9k/MkkVZICSpOkwStUszcOdNLkm41sIeUUpPaqacPEHe1u7lOP93u3sTqwJNiMGnT
         88HuLwJcSrT8v9EcthR/d50DCiNHbN0BM/K4WHwL7jpQIc442BhO4VG0fAky/u7BbZ3J
         mGfcjTJ8PRApeDotj4dWVpMwdlu5+spNqJ4jxw6fu2Qu8qbel+0uCXYTHyks7dYcQ/dy
         d3a1E4xaMF7ky2BgV36GfPCsbbaVb2AFOTbjV/G8r8mDuTbn0Hfk3zDJabPBTKDAL8gg
         xASQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSQgiSo51bnoyH3nt8bSotnqRoaDyjnNpvJP1Zc+nW0jdhKjSNFzCadzeh2nU7SgxfrqPSYur9taGpZwiDTcBr@vger.kernel.org
X-Gm-Message-State: AOJu0YxcWWnZsISKSY/Pk4w8k4KAY4FRs8LWdEkKb0YXd5xl4ydEALfe
	uD5tCtFXyHdDrsGTCO0AA/eVhGupzsRX1rH3UclrU+KPmsSsWfEwQfJLa3O3l4hK2QEtjFoTzgd
	tQB7H2Zmi8w==
X-Google-Smtp-Source: AGHT+IF0NwPOIq3TmGs4pfWbaVyz7eK77f2zPBftHfCowiKCgIk6oaj+NWaIDUfX61uCgGqUhOiGvhsMQt2A
X-Received: from dycne3.prod.google.com ([2002:a05:7301:c83:b0:2a4:51e8:c5c8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:bc1a:b0:2a4:3593:6466
 with SMTP id 5a478bee46e88-2a4abb1cf05mr160511eec.22.1763057148729; Thu, 13
 Nov 2025 10:05:48 -0800 (PST)
Date: Thu, 13 Nov 2025 10:05:09 -0800
In-Reply-To: <20251113180517.44096-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113180517.44096-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251113180517.44096-4-irogers@google.com>
Subject: [PATCH v4 03/10] perf tool_pmu: Use old_count when computing count
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
index 095016b2209e..654f840f7a2f 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -283,17 +283,27 @@ static int read_single_counter(struct evsel *counter, int cpu_map_idx, int threa
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
index a72c665ee644..6a9df3dc0e07 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -446,16 +446,39 @@ bool tool_pmu__read_event(enum tool_pmu_event ev,
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
@@ -466,12 +489,11 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	case TOOL_PMU__EVENT_NUM_PACKAGES:
 	case TOOL_PMU__EVENT_SLOTS:
 	case TOOL_PMU__EVENT_SMT_ON:
-	case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ:
 	case TOOL_PMU__EVENT_CORE_WIDE:
 	case TOOL_PMU__EVENT_TARGET_CPU:
-		if (evsel->prev_raw_counts)
-			old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
-		val = 0;
+	case TOOL_PMU__EVENT_SYSTEM_TSC_FREQ: {
+		u64 val = 0;
+
 		if (cpu_map_idx == 0 && thread == 0) {
 			if (!tool_pmu__read_event(ev, evsel,
 						  stat_config.system_wide,
@@ -481,16 +503,9 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
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
@@ -506,9 +521,9 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	case TOOL_PMU__EVENT_USER_TIME:
 	case TOOL_PMU__EVENT_SYSTEM_TIME: {
 		bool system = evsel__tool_event(evsel) == TOOL_PMU__EVENT_SYSTEM_TIME;
+		int fd = FD(evsel, cpu_map_idx, thread);
 
 		start_time = xyarray__entry(evsel->start_times, cpu_map_idx, thread);
-		fd = FD(evsel, cpu_map_idx, thread);
 		lseek(fd, SEEK_SET, 0);
 		if (evsel->pid_stat) {
 			/* The event exists solely on 1 CPU. */
@@ -542,17 +557,9 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
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

