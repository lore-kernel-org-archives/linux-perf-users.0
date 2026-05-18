Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F0C392836
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135275; cv=none; b=sHrr3Z4z3BOryKJ44wFFH5TQhvNC7DhvXmCMaMjQU+cx7zB/dgQiFbyLpYDhD8dHCxm4fv9lrtfKS7F14itimqOZs6SN/h3g/DPjnRp/jxDlCYsgXvczCdgHSaSrkLLiop0/V0WiNxJP3kzRwzzRZye6Q4f7fbQ88jjJKcvmgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135275; c=relaxed/simple;
	bh=IjQpx23TT2al9Ew+UmvJuIv86PdRBHcEC+CieppgCEI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kmhdoNfgYXyZQI1EK80suJxBG9dcyJBUKAF3OjWZl+2Cxav3fWxiATI6OBzjnMRxHjZAgnAKrfuLIWZU/qAjLPWzMt4wvA2d/d41HtosTnBUUSWPBcilFSBRMWr4U71MeVlp3QAOxziCFk1j3oV2bh3XO488tYHQX22eDojOra4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gt+virpF; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gt+virpF"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-135916eefa0so11241288c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779135272; x=1779740072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xe2bM9nnKE/PY7F0qPFua0eXxZKM5lremDBfaHiyg2A=;
        b=gt+virpF5cj+Cszi4kSiN+unbHfPHyYv8RGgbww3y1cxH44B5Rwdx/WujCbJ18g8si
         WXXK/30/AhZtWgzl9JYSpzTDyhaUwfN3IUp8XZSsmJ+vYr2nlQtMaJC1DMiNMjfmVfMH
         OItSeA8KhsDdaYWG4ZPTK1wVrilhkvqQlkfNgIUlUj7XaT2hYYKVn5ZY9bvBTt8c2YJu
         tUksABa+yaieMMgP38gFICA+o0Rw/Yc+Rdklz5OFyXFHrHZPiKQjoOaPzfEF2Ky8ASlm
         gXXuHPwP5mh4vBIEBsF8l9ucTJQ+9S426j+R89DXPVT/BV78COS7g6da6JpDqpkRk/Ic
         LMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135272; x=1779740072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xe2bM9nnKE/PY7F0qPFua0eXxZKM5lremDBfaHiyg2A=;
        b=dLZmXsdP0t22hARVogYUQ3rnbriZ1KW3uiZDeyHrWaFJkEe2Wd8V+EfJQhUa0SzP3H
         6qzCxx5FWxoUYWjRY4fRX+yWQG4w/NjamMk9zRb4h80KaeF3L5WSzinX8NXS7skrkEHG
         8en97kRG0NWGFa7wEkBHqfcCBAaq2IVHL3PVGWr0ng0iMZ5ZKBigzzKtb+j8j1bgPEGc
         iBC0gTSgN/uHzUN/rO1hg4QV6h5BiOMOW05YEvtxoHSeNJqQQoVV82iV+WycvpHj9wzV
         LRJCTYAika6M2mQ8AVc3RmoZRJu1Bdh/O9OKFErIzXiUYhxne2qEKJZnNwykqf9rjmy9
         ZuaA==
X-Forwarded-Encrypted: i=1; AFNElJ8Rs4LmGh7rcXFzr2RWKUZ6x5aHzYgBZ7FJWCPqhlUYrW+ck3ttFT4o98C8e30Avh3LFJWzWv8o09+ndLdALExx@vger.kernel.org
X-Gm-Message-State: AOJu0YwKm/jUvPsWfa5qiBghBXhbtveW+THFeH85HtUZCM0KD6M9gR6u
	2o+H4nGBANvNBktob1weXA9+OVPtsy6IQw7PP7JhYc3XERmUXnIuq5A0aR67WDBugo1gjBfjCsZ
	7k4QQ7RWf5Q==
X-Received: from dlbtu23.prod.google.com ([2002:a05:7022:3c17:b0:12d:f9c6:4512])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7f04:b0:135:512f:850c
 with SMTP id a92af1059eb24-135512f857dmr2621124c88.29.1779135271688; Mon, 18
 May 2026 13:14:31 -0700 (PDT)
Date: Mon, 18 May 2026 13:14:13 -0700
In-Reply-To: <20260518201419.2943132-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518183920.2894502-1-irogers@google.com> <20260518201419.2943132-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260518201419.2943132-2-irogers@google.com>
Subject: [PATCH v2 1/2] perf tool_pmu: Make tool PMU events respect enable/disable
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, nigro.fra@gmail.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
 tools/perf/util/evsel.c    | 190 ++++++++++++++++++++++-------
 tools/perf/util/evsel.h    |  10 +-
 tools/perf/util/tool_pmu.c | 244 +++++++++++++++++++++++++++++--------
 tools/perf/util/tool_pmu.h |   4 +
 4 files changed, 351 insertions(+), 97 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2ee87fd84d3e..63bfb03b6b13 100644
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
@@ -1795,12 +1798,63 @@ int evsel__append_addr_filter(struct evsel *evsel, const char *filter)
 /* Caller has to clear disabled after going through all CPUs. */
 int evsel__enable_cpu(struct evsel *evsel, int cpu_map_idx)
 {
-	return perf_evsel__enable_cpu(&evsel->core, cpu_map_idx);
+	int err;
+
+	if (evsel__is_tool(evsel))
+		err = evsel__tool_pmu_enable_cpu(evsel, cpu_map_idx);
+	else
+		err = perf_evsel__enable_cpu(&evsel->core, cpu_map_idx);
+
+	if (!err && evsel__is_group_leader(evsel)) {
+		struct evsel *member;
+
+		for_each_group_member(member, evsel) {
+			if (evsel__is_tool(member)) {
+				/*
+				 * In a mixed PMU group, tool PMU events are not
+				 * grouped in the kernel (opened with group_fd = -1)
+				 * and are skipped by the kernel when enabling the
+				 * group leader. We must manually enable them in
+				 * userspace.
+				 */
+				int mem_err = evsel__tool_pmu_enable_cpu(member, cpu_map_idx);
+
+				if (mem_err)
+					return mem_err;
+			}
+		}
+	}
+	return err;
 }
 
 int evsel__enable(struct evsel *evsel)
 {
-	int err = perf_evsel__enable(&evsel->core);
+	int err;
+
+	if (evsel__is_tool(evsel))
+		err = evsel__tool_pmu_enable(evsel);
+	else
+		err = perf_evsel__enable(&evsel->core);
+
+	if (!err && evsel__is_group_leader(evsel)) {
+		struct evsel *member;
+
+		for_each_group_member(member, evsel) {
+			if (evsel__is_tool(member)) {
+				/*
+				 * In a mixed PMU group, tool PMU events are not
+				 * grouped in the kernel (opened with group_fd = -1)
+				 * and are skipped by the kernel when enabling the
+				 * group leader. We must manually enable them in
+				 * userspace.
+				 */
+				int mem_err = evsel__tool_pmu_enable(member);
+
+				if (mem_err)
+					return mem_err;
+			}
+		}
+	}
 
 	if (!err)
 		evsel->disabled = false;
@@ -1810,12 +1864,62 @@ int evsel__enable(struct evsel *evsel)
 /* Caller has to set disabled after going through all CPUs. */
 int evsel__disable_cpu(struct evsel *evsel, int cpu_map_idx)
 {
-	return perf_evsel__disable_cpu(&evsel->core, cpu_map_idx);
+	int err;
+
+	if (evsel__is_tool(evsel))
+		err = evsel__tool_pmu_disable_cpu(evsel, cpu_map_idx);
+	else
+		err = perf_evsel__disable_cpu(&evsel->core, cpu_map_idx);
+
+	if (!err && evsel__is_group_leader(evsel)) {
+		struct evsel *member;
+
+		for_each_group_member(member, evsel) {
+			if (evsel__is_tool(member)) {
+				/*
+				 * In a mixed PMU group, tool PMU events are not
+				 * grouped in the kernel and are skipped by the
+				 * kernel when disabling the group leader. We must
+				 * manually disable them in userspace.
+				 */
+				int mem_err = evsel__tool_pmu_disable_cpu(member, cpu_map_idx);
+
+				if (mem_err)
+					return mem_err;
+			}
+		}
+	}
+	return err;
 }
 
 int evsel__disable(struct evsel *evsel)
 {
-	int err = perf_evsel__disable(&evsel->core);
+	int err;
+
+	if (evsel__is_tool(evsel))
+		err = evsel__tool_pmu_disable(evsel);
+	else
+		err = perf_evsel__disable(&evsel->core);
+
+	if (!err && evsel__is_group_leader(evsel)) {
+		struct evsel *member;
+
+		for_each_group_member(member, evsel) {
+			if (evsel__is_tool(member)) {
+				/*
+				 * In a mixed PMU group, tool PMU events are not
+				 * grouped in the kernel and are skipped by the
+				 * kernel when disabling the group leader. We must
+				 * manually disable them in userspace.
+				 */
+				int mem_err = evsel__tool_pmu_disable(member);
+
+				if (mem_err)
+					return mem_err;
+			}
+		}
+	}
+
 	/*
 	 * We mark it disabled here so that tools that disable a event can
 	 * ignore events after they disable it. I.e. the ring buffer may have
@@ -1885,8 +1989,10 @@ void evsel__exit(struct evsel *evsel)
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
index 6a9df3dc0e07..bb398fe82f6d 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -17,6 +17,8 @@
 #include <fcntl.h>
 #include <strings.h>
 
+#define INVALID_START_TIME ~0ULL
+
 static const char *const tool_pmu__event_names[TOOL_PMU__EVENT_MAX] = {
 	NULL,
 	"duration_time",
@@ -205,20 +207,57 @@ int evsel__tool_pmu_prepare_open(struct evsel *evsel,
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
+	lseek(fd, 0, SEEK_SET);
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
@@ -232,7 +271,14 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 	if (ev == TOOL_PMU__EVENT_DURATION_TIME) {
 		if (evsel->core.attr.sample_period) /* no sampling */
 			return -EINVAL;
-		evsel->start_time = rdclock();
+		evsel->duration_time.accumulated_time = 0;
+		if (evsel->core.attr.disabled) {
+			evsel->disabled = true;
+			evsel->duration_time.start_time = INVALID_START_TIME;
+		} else {
+			evsel->disabled = false;
+			evsel->duration_time.start_time = rdclock();
+		}
 		return 0;
 	}
 
@@ -246,8 +292,8 @@ int evsel__tool_pmu_open(struct evsel *evsel,
 				pid = perf_thread_map__pid(threads, thread);
 
 			if (ev == TOOL_PMU__EVENT_USER_TIME || ev == TOOL_PMU__EVENT_SYSTEM_TIME) {
-				bool system = ev == TOOL_PMU__EVENT_SYSTEM_TIME;
 				__u64 *start_time = NULL;
+				__u64 *accumulated_time = NULL;
 				int fd;
 
 				if (evsel->core.attr.sample_period) {
@@ -269,21 +315,22 @@ int evsel__tool_pmu_open(struct evsel *evsel,
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
+					*start_time = INVALID_START_TIME;
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
@@ -467,10 +514,108 @@ static void perf_counts__update(struct perf_counts_values *count,
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
+			else
+				*start_time = INVALID_START_TIME;
+		}
+	}
+	return 0;
+}
+
+int evsel__tool_pmu_enable(struct evsel *evsel)
+{
+	unsigned int idx;
+	int err = 0;
+
+	for (idx = 0; idx < perf_cpu_map__nr(evsel->core.cpus); idx++) {
+		err = evsel__tool_pmu_enable_cpu(evsel, idx);
+		if (err)
+			break;
+	}
+	return err;
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
+				if (*start_time != INVALID_START_TIME && val >= *start_time)
+					*accumulated_time += (val - *start_time);
+				*start_time = INVALID_START_TIME;
+			}
+		}
+	}
+	return 0;
+}
+
+int evsel__tool_pmu_disable(struct evsel *evsel)
+{
+	unsigned int idx;
+	int err = 0;
+
+	for (idx = 0; idx < perf_cpu_map__nr(evsel->core.cpus); idx++) {
+		err = evsel__tool_pmu_disable_cpu(evsel, idx);
+		if (err)
+			break;
+	}
+	return err;
+}
 
 int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 {
-	__u64 *start_time, cur_time, delta_start;
+	__u64 delta_start = 0;
 	int err = 0;
 	struct perf_counts_values *count, *old_count = NULL;
 	bool adjust = false;
@@ -507,39 +652,33 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
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
+			if (!evsel->disabled &&
+			    evsel->duration_time.start_time != INVALID_START_TIME)
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
+				if (*start_time != INVALID_START_TIME && cur_time >= *start_time)
+					delta_start = accumulated + (cur_time - *start_time);
+				else
+					delta_start = accumulated;
 			}
 		}
 		adjust = true;
@@ -553,7 +692,6 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
 	if (err)
 		return err;
 
-	delta_start = cur_time - *start_time;
 	if (adjust) {
 		__u64 ticks_per_sec = sysconf(_SC_CLK_TCK);
 
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index f1714001bc1d..f66d24cf3502 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -56,6 +56,10 @@ int evsel__tool_pmu_prepare_open(struct evsel *evsel,
 int evsel__tool_pmu_open(struct evsel *evsel,
 			 struct perf_thread_map *threads,
 			 int start_cpu_map_idx, int end_cpu_map_idx);
+int evsel__tool_pmu_enable_cpu(struct evsel *evsel, int cpu_map_idx);
+int evsel__tool_pmu_enable(struct evsel *evsel);
+int evsel__tool_pmu_disable_cpu(struct evsel *evsel, int cpu_map_idx);
+int evsel__tool_pmu_disable(struct evsel *evsel);
 int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread);
 
 struct perf_pmu *tool_pmu__new(void);
-- 
2.54.0.631.ge1b05301d1-goog

