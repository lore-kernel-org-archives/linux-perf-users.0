Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A51A3890F8
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129569; cv=none; b=E3zyqPdzkQ947vgsvD0VT9TTacbGhEvnTpOIhU4eVxJ6WK+QXDpqvQcKb4HfeXQR1JqA/e8ZQrXmay2+2q2e3b2EEe7pRtM++KtSMyZL5dKYLykWiBInjdi+WPHALipZPTlnfl1Dv2okrMcOIqViLgS6upM+AWsxGUqmkV8UvCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129569; c=relaxed/simple;
	bh=LsBQXsSiB/GKoRhEFwa3JkDTcgSVcFo6Ml3134QUq6Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=TjaYHAN3fk7rCI+5YcgUJ+ch86AVVPClpIWvMzIkzOTB6UMr1n/rusMUg4BdWrULpO1WVgBMBPeojKhE8GYP7EoFKXhjVTIOp0z8JwS47LIdHlZwDYdmEQaHpPb1uZfItnnoRdqrUFSrJ2AK3idN1sFqDM1NODYpNdQpYF+OlhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJZJVlsJ; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJZJVlsJ"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dc1c0b7ccso2549780c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 11:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779129567; x=1779734367; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RanyjF1WhhXjyMap27LhI/CwQlITPbD9ctkTROJXpOg=;
        b=hJZJVlsJE3CR2aWT2BsEz4YM2/eTrCgrUETtWGnkdv8giRgO4fGZ1SxOfvWr1fHTkx
         R9dIiiAkItAgPuanWxAiN1U2fYKr2LUHGgRzu/i7yOMMjmFv0sZ1VBGe1fxA3tl6bhl/
         0XThexmbXlFxLKEWmsLgehnVPMAlDhjrpBjhkcyCZJMD94IHrpWJMki39OXyrRAiOu8q
         hY7dbs3a+p8gKt4YjteF6fCyhUm+7GEqX+D/MrvSIFsJD6PsDP18q5KmsOymIriAzdwn
         0rZZUi8k2ObF8f0MQERCRVms7iMCYK9gmZXLR9s06u/MP8nAyIT+FqqsQvDAbUhcv+F5
         CGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779129567; x=1779734367;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RanyjF1WhhXjyMap27LhI/CwQlITPbD9ctkTROJXpOg=;
        b=Z5y5RsUsRzlpCnVblFqZliI7lkTOwnCr3+Tt1Wg47pduhrFTdRafSugnORiRViLxrf
         B0sgakgLvfuDQVFcetoW5FngficSuJAeBaCvGm6jn7iJjmZVw9kzO9XXuGDGo6rH55qJ
         r+h3auoIiRZRWmvLSHetB6cBcq1eMXkhNBbo0r6T6Lk1qPjYsqMRcqoZb++gvcFwHCm+
         uRj8OfPyuny7xR0Tll10fVnausZwOqE+Yj3xWfsipQI0fkfWR9NhYCvSZgUQQnSCvc3N
         1a4pX5/vuV0o1Se0y4xnkydVoCyh+idQuGhWSOW6J1+K93krwVMWd99/vYC/y8iXTlYs
         TEjA==
X-Forwarded-Encrypted: i=1; AFNElJ9qOvmOEyS1XBx2dRTrpfcwTT5LcUqazA1oabD4ERCgcETirzWuchCiauHos/vho/K3VYhnwWL6YhqNErxlQZRc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvc+1jqhUXC+WaOeJFpEYzXAVJzgveTCp4aTemIzhxMU5ooccM
	leqLTSxewGSX0B4Ebv8Ld+6eQcIpSMAyScM0UB60N6beZyZ9YeQlLHBzZm1W1zHuqctroRiGX/L
	kNNF14lCZgQ==
X-Received: from dlboy10.prod.google.com ([2002:a05:7022:128a:b0:134:feba:1ec8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:41c:b0:135:246d:c4f5
 with SMTP id a92af1059eb24-135246de58emr4635967c88.18.1779129566840; Mon, 18
 May 2026 11:39:26 -0700 (PDT)
Date: Mon, 18 May 2026 11:39:19 -0700
In-Reply-To: <20260518183920.2894502-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518183920.2894502-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260518183920.2894502-2-irogers@google.com>
Subject: [PATCH v1 1/2] perf tool_pmu: Make tool PMU events respect enable/disable
From: Ian Rogers <irogers@google.com>
To: Francesco Nigro <nigro.fra@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Tool PMU events (duration_time, user_time, system_time) currently
count from when the event is opened to when it is read. This causes
issues with features like the delay option (-D) or control fd, where
events are opened but should not start counting immediately.

Make these events behave more like regular counters by implementing
proper enable and disable support. Add accumulated_time to struct
evsel to track time while enabled, and implement enable/disable CPU
callbacks to start/stop counting.

Fixes: b71f46a6a708 ("perf stat: Remove hard coded shadow metrics")
Reported-by: Francesco Nigro <nigro.fra@gmail.com>
Closes: https://lore.kernel.org/linux-perf-users/20260517093650.2540920-1-nigro.fra@gmail.com/
Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3-flash
---
 tools/perf/util/evsel.c    |  85 ++++++++-------
 tools/perf/util/evsel.h    |  10 +-
 tools/perf/util/tool_pmu.c | 212 +++++++++++++++++++++++++++----------
 tools/perf/util/tool_pmu.h |   2 +
 4 files changed, 216 insertions(+), 93 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2ee87fd84d3e..3646156500f6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -11,68 +11,71 @@
  */
 #define __SANE_USERSPACE_TYPES__
 
-#include <byteswap.h>
+#include "evsel.h"
+
 #include <errno.h>
 #include <inttypes.h>
+#include <stdlib.h>
+
+#include <dirent.h>
 #include <linux/bitops.h>
-#include <api/fs/fs.h>
-#include <api/fs/tracing_path.h>
-#include <linux/hw_breakpoint.h>
-#include <linux/perf_event.h>
 #include <linux/compiler.h>
+#include <linux/ctype.h>
 #include <linux/err.h>
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
 #include <linux/zalloc.h>
 #include <sys/ioctl.h>
 #include <sys/resource.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
-#include <dirent.h>
-#include <stdlib.h>
+
+#include <api/fs/fs.h>
+#include <api/fs/tracing_path.h>
+#include <byteswap.h>
+#include <internal/lib.h>
+#include <internal/threadmap.h>
+#include <internal/xyarray.h>
+#include <perf/cpumap.h>
 #include <perf/evsel.h>
+
+#include "../perf-sys.h"
 #include "asm/bug.h"
+#include "bpf-filter.h"
 #include "bpf_counter.h"
 #include "callchain.h"
 #include "cgroup.h"
 #include "counts.h"
+#include "debug.h"
+#include "drm_pmu.h"
 #include "dwarf-regs.h"
+#include "env.h"
 #include "event.h"
-#include "evsel.h"
-#include "time-utils.h"
-#include "util/env.h"
-#include "util/evsel_config.h"
-#include "util/evsel_fprintf.h"
 #include "evlist.h"
-#include <perf/cpumap.h>
-#include "thread_map.h"
-#include "target.h"
+#include "evsel_config.h"
+#include "evsel_fprintf.h"
+#include "hashmap.h"
+#include "hist.h"
+#include "hwmon_pmu.h"
+#include "intel-tpebs.h"
+#include "memswap.h"
+#include "off_cpu.h"
+#include "parse-branch-options.h"
 #include "perf_regs.h"
+#include "pmu.h"
+#include "pmus.h"
 #include "record.h"
-#include "debug.h"
-#include "trace-event.h"
+#include "rlimit.h"
 #include "session.h"
 #include "stat.h"
 #include "string2.h"
-#include "memswap.h"
-#include "util.h"
-#include "util/hashmap.h"
-#include "off_cpu.h"
-#include "pmu.h"
-#include "pmus.h"
-#include "drm_pmu.h"
-#include "hwmon_pmu.h"
+#include "target.h"
+#include "thread_map.h"
+#include "time-utils.h"
 #include "tool_pmu.h"
 #include "tp_pmu.h"
-#include "rlimit.h"
-#include "../perf-sys.h"
-#include "util/parse-branch-options.h"
-#include "util/bpf-filter.h"
-#include "util/hist.h"
-#include <internal/xyarray.h>
-#include <internal/lib.h>
-#include <internal/threadmap.h>
-#include "util/intel-tpebs.h"
-
-#include <linux/ctype.h>
+#include "trace-event.h"
+#include "util.h"
 
 #ifdef HAVE_LIBTRACEEVENT
 #include <event-parse.h>
@@ -1795,6 +1798,8 @@ int evsel__append_addr_filter(struct evsel *evsel, const char *filter)
 /* Caller has to clear disabled after going through all CPUs. */
 int evsel__enable_cpu(struct evsel *evsel, int cpu_map_idx)
 {
+	if (evsel__is_tool(evsel))
+		return evsel__tool_pmu_enable_cpu(evsel, cpu_map_idx);
 	return perf_evsel__enable_cpu(&evsel->core, cpu_map_idx);
 }
 
@@ -1810,6 +1815,8 @@ int evsel__enable(struct evsel *evsel)
 /* Caller has to set disabled after going through all CPUs. */
 int evsel__disable_cpu(struct evsel *evsel, int cpu_map_idx)
 {
+	if (evsel__is_tool(evsel))
+		return evsel__tool_pmu_disable_cpu(evsel, cpu_map_idx);
 	return perf_evsel__disable_cpu(&evsel->core, cpu_map_idx);
 }
 
@@ -1885,8 +1892,10 @@ void evsel__exit(struct evsel *evsel)
 		evsel__priv_destructor(evsel->priv);
 	perf_evsel__object.fini(evsel);
 	if (evsel__tool_event(evsel) == TOOL_PMU__EVENT_SYSTEM_TIME ||
-	    evsel__tool_event(evsel) == TOOL_PMU__EVENT_USER_TIME)
-		xyarray__delete(evsel->start_times);
+	    evsel__tool_event(evsel) == TOOL_PMU__EVENT_USER_TIME) {
+		xyarray__delete(evsel->process_time.start_times);
+		xyarray__delete(evsel->process_time.accumulated_times);
+	}
 }
 
 void evsel__delete(struct evsel *evsel)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 339b5c08a33d..0b6a6df0e4ef 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -190,12 +190,18 @@ struct evsel {
 			double max;
 		} retirement_latency;
 		/* duration_time is a single global time. */
-		__u64 start_time;
+		struct {
+			__u64 start_time;
+			__u64 accumulated_time;
+		} duration_time;
 		/*
 		 * user_time and system_time read an initial value potentially
 		 * per-CPU or per-pid.
 		 */
-		struct xyarray *start_times;
+		struct {
+			struct xyarray *start_times;
+			struct xyarray *accumulated_times;
+		} process_time;
 	};
 	/* Is the tool's fd for /proc/pid/stat or /proc/stat. */
 	bool pid_stat;
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 6a9df3dc0e07..cfefd97cb95b 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -205,20 +205,57 @@ int evsel__tool_pmu_prepare_open(struct evsel *evsel,
 				 struct perf_cpu_map *cpus,
 				 int nthreads)
 {
-	if ((evsel__tool_event(evsel) == TOOL_PMU__EVENT_SYSTEM_TIME ||
-	     evsel__tool_event(evsel) == TOOL_PMU__EVENT_USER_TIME) &&
-	    !evsel->start_times) {
-		evsel->start_times = xyarray__new(perf_cpu_map__nr(cpus),
-						  nthreads,
-						  sizeof(__u64));
-		if (!evsel->start_times)
-			return -ENOMEM;
+	enum tool_pmu_event ev = evsel__tool_event(evsel);
+
+	if (ev == TOOL_PMU__EVENT_SYSTEM_TIME || ev == TOOL_PMU__EVENT_USER_TIME) {
+		if (!evsel->process_time.start_times) {
+			evsel->process_time.start_times =
+				xyarray__new(perf_cpu_map__nr(cpus), nthreads, sizeof(__u64));
+			if (!evsel->process_time.start_times)
+				return -ENOMEM;
+		}
+		if (!evsel->process_time.accumulated_times) {
+			evsel->process_time.accumulated_times =
+				xyarray__new(perf_cpu_map__nr(cpus), nthreads, sizeof(__u64));
+			if (!evsel->process_time.accumulated_times)
+				return -ENOMEM;
+		}
 	}
 	return 0;
 }
 
 #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
 
+static int tool_pmu__read_stat(struct evsel *evsel, int cpu_map_idx, int thread, __u64 *val)
+{
+	enum tool_pmu_event ev = evsel__tool_event(evsel);
+	bool system = ev == TOOL_PMU__EVENT_SYSTEM_TIME;
+	int fd = FD(evsel, cpu_map_idx, thread);
+	int err = 0;
+
+	if (fd < 0) {
+		*val = 0;
+		return 0;
+	}
+
+	lseek(fd, SEEK_SET, 0);
+	if (evsel->pid_stat) {
+		if (cpu_map_idx == 0)
+			err = read_pid_stat_field(fd, system ? 15 : 14, val);
+		else
+			*val = 0;
+	} else {
+		if (thread == 0) {
+			struct perf_cpu cpu = perf_cpu_map__cpu(evsel->core.cpus, cpu_map_idx);
+
+			err = read_stat_field(fd, cpu, system ? 3 : 1, val);
+		} else {
+			*val = 0;
+		}
+	}
+	return err;
+}
+
 int evsel__tool_pmu_open(struct evsel *evsel,
 			 struct perf_thread_map *threads,
 			 int start_cpu_map_idx, int end_cpu_map_idx)
@@ -232,7 +269,14 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 	if (ev == TOOL_PMU__EVENT_DURATION_TIME) {
 		if (evsel->core.attr.sample_period) /* no sampling */
 			return -EINVAL;
-		evsel->start_time = rdclock();
+		evsel->duration_time.accumulated_time = 0;
+		if (evsel->core.attr.disabled) {
+			evsel->disabled = true;
+			evsel->duration_time.start_time = 0;
+		} else {
+			evsel->disabled = false;
+			evsel->duration_time.start_time = rdclock();
+		}
 		return 0;
 	}
 
@@ -246,8 +290,8 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 				pid = perf_thread_map__pid(threads, thread);
 
 			if (ev == TOOL_PMU__EVENT_USER_TIME || ev == TOOL_PMU__EVENT_SYSTEM_TIME) {
-				bool system = ev == TOOL_PMU__EVENT_SYSTEM_TIME;
 				__u64 *start_time = NULL;
+				__u64 *accumulated_time = NULL;
 				int fd;
 
 				if (evsel->core.attr.sample_period) {
@@ -269,21 +313,22 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 					err = -errno;
 					goto out_close;
 				}
-				start_time = xyarray__entry(evsel->start_times, idx, thread);
-				if (pid > -1) {
-					err = read_pid_stat_field(fd, system ? 15 : 14,
-								  start_time);
+				start_time = xyarray__entry(evsel->process_time.start_times, idx,
+							    thread);
+				accumulated_time = xyarray__entry(
+					evsel->process_time.accumulated_times, idx, thread);
+				*accumulated_time = 0;
+
+				if (evsel->core.attr.disabled) {
+					evsel->disabled = true;
+					*start_time = 0;
 				} else {
-					struct perf_cpu cpu;
-
-					cpu = perf_cpu_map__cpu(evsel->core.cpus, idx);
-					err = read_stat_field(fd, cpu, system ? 3 : 1,
-							      start_time);
+					evsel->disabled = false;
+					err = tool_pmu__read_stat(evsel, idx, thread, start_time);
+					if (err)
+						goto out_close;
 				}
-				if (err)
-					goto out_close;
 			}
-
 		}
 	}
 	return 0;
@@ -467,10 +512,79 @@ static void perf_counts__update(struct perf_counts_values *count,
 		count->lost = 0;
 	}
 }
+int evsel__tool_pmu_enable_cpu(struct evsel *evsel, int cpu_map_idx)
+{
+	enum tool_pmu_event ev = evsel__tool_event(evsel);
+	int thread, nthreads;
+
+	if (!evsel->disabled)
+		return 0;
+
+	if (ev == TOOL_PMU__EVENT_DURATION_TIME) {
+		if (cpu_map_idx == 0) {
+			evsel->duration_time.start_time = rdclock();
+			evsel->disabled = false;
+		}
+		return 0;
+	}
+
+	if (ev == TOOL_PMU__EVENT_USER_TIME || ev == TOOL_PMU__EVENT_SYSTEM_TIME) {
+		nthreads = xyarray__max_y(evsel->process_time.start_times);
+		for (thread = 0; thread < nthreads; thread++) {
+			__u64 *start_time = xyarray__entry(evsel->process_time.start_times,
+							   cpu_map_idx, thread);
+			__u64 val;
+			int err;
+
+			err = tool_pmu__read_stat(evsel, cpu_map_idx, thread, &val);
+			if (!err)
+				*start_time = val;
+		}
+	}
+	return 0;
+}
+
+int evsel__tool_pmu_disable_cpu(struct evsel *evsel, int cpu_map_idx)
+{
+	enum tool_pmu_event ev = evsel__tool_event(evsel);
+	int thread, nthreads;
+
+	if (evsel->disabled)
+		return 0;
+
+	if (ev == TOOL_PMU__EVENT_DURATION_TIME) {
+		if (cpu_map_idx == 0) {
+			__u64 delta = rdclock() - evsel->duration_time.start_time;
+
+			evsel->duration_time.accumulated_time += delta;
+			evsel->disabled = true;
+		}
+		return 0;
+	}
+
+	if (ev == TOOL_PMU__EVENT_USER_TIME || ev == TOOL_PMU__EVENT_SYSTEM_TIME) {
+		nthreads = xyarray__max_y(evsel->process_time.start_times);
+		for (thread = 0; thread < nthreads; thread++) {
+			__u64 *start_time = xyarray__entry(evsel->process_time.start_times,
+							   cpu_map_idx, thread);
+			__u64 *accumulated_time = xyarray__entry(
+				evsel->process_time.accumulated_times, cpu_map_idx, thread);
+			__u64 val;
+			int err;
+
+			err = tool_pmu__read_stat(evsel, cpu_map_idx, thread, &val);
+			if (!err) {
+				if (val >= *start_time)
+					*accumulated_time += (val - *start_time);
+			}
+		}
+	}
+	return 0;
+}
 
 int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 {
-	__u64 *start_time, cur_time, delta_start;
+	__u64 delta_start = 0;
 	int err = 0;
 	struct perf_counts_values *count, *old_count = NULL;
 	bool adjust = false;
@@ -507,39 +621,32 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 		return 0;
 	}
 	case TOOL_PMU__EVENT_DURATION_TIME:
-		/*
-		 * Pretend duration_time is only on the first CPU and thread, or
-		 * else aggregation will scale duration_time by the number of
-		 * CPUs/threads.
-		 */
-		start_time = &evsel->start_time;
-		if (cpu_map_idx == 0 && thread == 0)
-			cur_time = rdclock();
-		else
-			cur_time = *start_time;
+		if (cpu_map_idx == 0 && thread == 0) {
+			delta_start = evsel->duration_time.accumulated_time;
+			if (!evsel->disabled)
+				delta_start += (rdclock() - evsel->duration_time.start_time);
+		} else {
+			delta_start = 0;
+		}
 		break;
 	case TOOL_PMU__EVENT_USER_TIME:
 	case TOOL_PMU__EVENT_SYSTEM_TIME: {
-		bool system = evsel__tool_event(evsel) == TOOL_PMU__EVENT_SYSTEM_TIME;
-		int fd = FD(evsel, cpu_map_idx, thread);
-
-		start_time = xyarray__entry(evsel->start_times, cpu_map_idx, thread);
-		lseek(fd, SEEK_SET, 0);
-		if (evsel->pid_stat) {
-			/* The event exists solely on 1 CPU. */
-			if (cpu_map_idx == 0)
-				err = read_pid_stat_field(fd, system ? 15 : 14, &cur_time);
-			else
-				cur_time = 0;
-		} else {
-			/* The event is for all threads. */
-			if (thread == 0) {
-				struct perf_cpu cpu = perf_cpu_map__cpu(evsel->core.cpus,
-									cpu_map_idx);
+		__u64 accumulated = *(__u64 *)xyarray__entry(evsel->process_time.accumulated_times,
+							     cpu_map_idx, thread);
 
-				err = read_stat_field(fd, cpu, system ? 3 : 1, &cur_time);
-			} else {
-				cur_time = 0;
+		if (evsel->disabled) {
+			delta_start = accumulated;
+		} else {
+			__u64 *start_time = xyarray__entry(evsel->process_time.start_times,
+							   cpu_map_idx, thread);
+			__u64 cur_time;
+
+			err = tool_pmu__read_stat(evsel, cpu_map_idx, thread, &cur_time);
+			if (!err) {
+				if (cur_time >= *start_time)
+					delta_start = accumulated + (cur_time - *start_time);
+				else
+					delta_start = accumulated;
 			}
 		}
 		adjust = true;
@@ -553,7 +660,6 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	if (err)
 		return err;
 
-	delta_start = cur_time - *start_time;
 	if (adjust) {
 		__u64 ticks_per_sec = sysconf(_SC_CLK_TCK);
 
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index f1714001bc1d..f06ef5bce1c1 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -56,6 +56,8 @@ int evsel__tool_pmu_prepare_open(struct evsel *evsel,
 int evsel__tool_pmu_open(struct evsel *evsel,
 			 struct perf_thread_map *threads,
 			 int start_cpu_map_idx, int end_cpu_map_idx);
+int evsel__tool_pmu_enable_cpu(struct evsel *evsel, int cpu_map_idx);
+int evsel__tool_pmu_disable_cpu(struct evsel *evsel, int cpu_map_idx);
 int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread);
 
 struct perf_pmu *tool_pmu__new(void);
-- 
2.54.0.631.ge1b05301d1-goog

