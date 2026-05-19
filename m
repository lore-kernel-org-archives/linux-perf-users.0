Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966E12F7AB0
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 01:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154896; cv=none; b=b3vVT9FYM0K3azinMSEt2CnxsjjMMHA42eauh7u7gRj50cQ/UeuEXarYG14q4WmfyIC1sMopFMDsF/Eo51AppSz8dj2kt21BH/hQHwOCAFEBHNBz3JZ2VNUnNEmsHo4/WU9Nk7DRs0/Mx8Ghvoa2O7V8t0dhkEtcfr79x5qZdZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154896; c=relaxed/simple;
	bh=5k84pslMb8NrEcdO2kSLiCWlRusEvKRpz1qDwCFPj3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V3zKqW3gIrILpfU+A7xhrkhbDK+3RN80FXlXhch78B3YUmpohjwn1QzqeSHmgSmA0Ne3oo8iK+GLOAElScFquJmRARj40U20t+Fz4gYtV5PD/eUvM+ZV/PQolOk6QQsW0PvjuG5fQ9X6GrYtIOHpjvcL8tYla+iQG6DTTtCKxIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LZiwoSqZ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZiwoSqZ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ee5b73c5f2so1621663eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 18:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779154894; x=1779759694; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOE29DGtQ0d+tfimCwLxe/PsFfFtpHc9lU56F7WmtFM=;
        b=LZiwoSqZHKa4dlYqIlOUsU3iFinEtl70mo4iWopYBO/U6G+QdTthoN1yUdDPEavV6U
         HCh4FB8ubRqm/+iXXHlB+9M2dCC/F0GK+WQZMK3pCPhtkb1Wip4IGQ6+rfApjEmU6J4W
         NI65tyOjm8jZQixW6zX1QcVvV6WU2kq4xLa93f4YRozUIMmQuXIsEHiT5485+Dh9rG72
         7x8bEtF/3zHaNDIBeybIK+3R65AIuJXu5v7tXgO3ha8JVaRMgxRgYtgQJvmISzvnqXow
         49drwi8AOkfbtq8MO0/MeSUggU8gqBm+kfcWbhZAcjOEZVDvfy5RCdAgvmjsSJwDOF6V
         PFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779154894; x=1779759694;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOE29DGtQ0d+tfimCwLxe/PsFfFtpHc9lU56F7WmtFM=;
        b=D6O1oELL8nJuXOnGWbKIS6ugDX+XGqkzQhuQ7E/mDCBkzd59krTa6kKl9EryMzKwNB
         O+31mMuG61aBfa15V7hJgd9gHOsEpVgMaqyivKtQrTRr6am0bLIzJ4Ssz4it6v3ZJdi5
         gFla/LU/Lo/uJrSL1ddTcq4tRTaNaC3Qu+DI7puQW1jIhcDAnAu8Hj5vrlrWQZw2jtN2
         5GnmgaSv6VMRlUlOTZsAe29GgB5z1utvVkPA+vJ0KSd83zNvZaY4LhY/lNvUjJoRGWuq
         JAHR9vparwYZdp6DEEDxCysQNgxST++LV5454LvP2HOixSC97MQpfgd9WrYNZP1MfMO8
         77Sw==
X-Forwarded-Encrypted: i=1; AFNElJ9yV61gBKR1SUgSXZ8CLfwTj+Dbw/KUjbViLIyom3aP8VIurweJlgr1I7ChjsDWCWnbYtCkOEc8dto9Y2Xe1SAX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5/4oqcwQJgvc1kH5cB31Rb3D+1xaoUcWECEsOMC6d95oVUZJS
	ZENt+ubBQKOwZmeFWd5xwrhdcd62uws3xgVJ9BwoabkJ9Fwn8TByGF/rZP+qmrK2qXtWEQfE65J
	moEbBczu9Ag==
X-Received: from dlbdt19.prod.google.com ([2002:a05:7022:2593:b0:135:db69:f5db])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e430:b0:2f1:3aa8:f2c
 with SMTP id 5a478bee46e88-303981914bdmr8044930eec.4.1779154893511; Mon, 18
 May 2026 18:41:33 -0700 (PDT)
Date: Mon, 18 May 2026 18:41:05 -0700
In-Reply-To: <20260519014106.3089452-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518223733.3034897-1-irogers@google.com> <20260519014106.3089452-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260519014106.3089452-2-irogers@google.com>
Subject: [PATCH v4 1/2] perf tool_pmu: Make tool PMU events respect enable/disable
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

Also generalize userspace PMU mixed group handling. Userspace synthetic
PMUs (type > PERF_PMU_TYPE_PE_END) do not have kernel implementations and
cannot be grouped in the kernel (opened with group_fd = -1), and are
skipped by kernel enable/disable calls. Iterate over group members in
userspace and manually enable/disable any members if the leader or the
member is a non-perf-event open PMU, and synchronize their disabled flags.

Fixes: b71f46a6a708 ("perf stat: Remove hard coded shadow metrics")
Reported-by: Francesco Nigro <nigro.fra@gmail.com>
Closes: https://lore.kernel.org/linux-perf-users/20260517093650.2540920-1-nigro.fra@gmail.com/
Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3-flash
---
 tools/perf/util/evlist.c   |  10 +-
 tools/perf/util/evsel.c    | 197 ++++++++++++++++++++++-------
 tools/perf/util/evsel.h    |  15 ++-
 tools/perf/util/tool_pmu.c | 250 +++++++++++++++++++++++++++++--------
 tools/perf/util/tool_pmu.h |   4 +
 5 files changed, 377 insertions(+), 99 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ee971d15b3c6..1a238b245b3a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -529,7 +529,7 @@ static int evlist__is_enabled(struct evlist *evlist)
 
 static void __evlist__disable(struct evlist *evlist, char *evsel_name, bool excl_dummy)
 {
-	struct evsel *pos;
+	struct evsel *pos, *member;
 	struct evlist_cpu_iterator evlist_cpu_itr;
 	bool has_imm = false;
 
@@ -561,6 +561,9 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name, bool excl
 		if (excl_dummy && evsel__is_dummy_event(pos))
 			continue;
 		pos->disabled = true;
+
+		for_each_group_member(member, pos)
+			member->disabled = true;
 	}
 
 	/*
@@ -590,7 +593,7 @@ void evlist__disable_evsel(struct evlist *evlist, char *evsel_name)
 
 static void __evlist__enable(struct evlist *evlist, char *evsel_name, bool excl_dummy)
 {
-	struct evsel *pos;
+	struct evsel *pos, *member;
 	struct evlist_cpu_iterator evlist_cpu_itr;
 
 	evlist__for_each_cpu(evlist_cpu_itr, evlist) {
@@ -611,6 +614,9 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name, bool excl_
 		if (excl_dummy && evsel__is_dummy_event(pos))
 			continue;
 		pos->disabled = false;
+
+		for_each_group_member(member, pos)
+			member->disabled = false;
 	}
 
 	/*
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2ee87fd84d3e..8a80d2e15f5c 100644
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
@@ -1795,27 +1798,114 @@ int evsel__append_addr_filter(struct evsel *evsel, const char *filter)
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
+			if (evsel__is_non_perf_event_open_pmu(evsel) ||
+			    evsel__is_non_perf_event_open_pmu(member)) {
+				/*
+				 * In a mixed PMU group, userspace PMUs are not
+				 * grouped in the kernel (opened with group_fd = -1)
+				 * and are skipped by the kernel when enabling the
+				 * group leader. We must manually enable them in
+				 * userspace.
+				 */
+				int mem_err = evsel__enable_cpu(member, cpu_map_idx);
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
 
 	if (!err)
 		evsel->disabled = false;
+
+	if (!err && evsel__is_group_leader(evsel)) {
+		struct evsel *member;
+
+		for_each_group_member(member, evsel) {
+			if (evsel__is_non_perf_event_open_pmu(evsel) ||
+			    evsel__is_non_perf_event_open_pmu(member)) {
+				/*
+				 * In a mixed PMU group, userspace PMUs are not
+				 * grouped in the kernel (opened with group_fd = -1)
+				 * and are skipped by the kernel when enabling the
+				 * group leader. We must manually enable them in
+				 * userspace.
+				 */
+				int mem_err = evsel__enable(member);
+
+				if (mem_err)
+					return mem_err;
+			}
+			member->disabled = false;
+		}
+	}
+
 	return err;
 }
 
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
+			if (evsel__is_non_perf_event_open_pmu(evsel) ||
+			    evsel__is_non_perf_event_open_pmu(member)) {
+				/*
+				 * In a mixed PMU group, userspace PMUs are not
+				 * grouped in the kernel and are skipped by the
+				 * kernel when disabling the group leader. We must
+				 * manually disable them in userspace.
+				 */
+				int mem_err = evsel__disable_cpu(member, cpu_map_idx);
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
 	/*
 	 * We mark it disabled here so that tools that disable a event can
 	 * ignore events after they disable it. I.e. the ring buffer may have
@@ -1825,6 +1915,27 @@ int evsel__disable(struct evsel *evsel)
 	if (!err)
 		evsel->disabled = true;
 
+	if (!err && evsel__is_group_leader(evsel)) {
+		struct evsel *member;
+
+		for_each_group_member(member, evsel) {
+			if (evsel__is_non_perf_event_open_pmu(evsel) ||
+			    evsel__is_non_perf_event_open_pmu(member)) {
+				/*
+				 * In a mixed PMU group, userspace PMUs are not
+				 * grouped in the kernel and are skipped by the
+				 * kernel when disabling the group leader. We must
+				 * manually disable them in userspace.
+				 */
+				int mem_err = evsel__disable(member);
+
+				if (mem_err)
+					return mem_err;
+			}
+			member->disabled = true;
+		}
+	}
+
 	return err;
 }
 
@@ -1885,8 +1996,10 @@ void evsel__exit(struct evsel *evsel)
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
index 339b5c08a33d..7e3746480269 100644
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
@@ -350,6 +356,11 @@ void arch_evsel__apply_ratio_to_prev(struct evsel *evsel, struct perf_event_attr
 int evsel__set_filter(struct evsel *evsel, const char *filter);
 int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
 int evsel__append_addr_filter(struct evsel *evsel, const char *filter);
+static inline bool evsel__is_non_perf_event_open_pmu(const struct evsel *evsel)
+{
+	return evsel->pmu && evsel->pmu->type > PERF_PMU_TYPE_PE_END;
+}
+
 int evsel__enable_cpu(struct evsel *evsel, int cpu_map_idx);
 int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 6a9df3dc0e07..5c30854b4644 100644
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
@@ -269,21 +315,25 @@ int evsel__tool_pmu_open(struct evsel *evsel,
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
+					if (err) {
+						close(fd);
+						FD(evsel, idx, thread) = -1;
+						goto out_close;
+					}
 				}
-				if (err)
-					goto out_close;
 			}
-
 		}
 	}
 	return 0;
@@ -467,10 +517,111 @@ static void perf_counts__update(struct perf_counts_values *count,
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
+		if (cpu_map_idx == 0)
+			evsel->duration_time.start_time = rdclock();
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
+	if (!evsel->disabled)
+		return 0;
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
+			}
+			*start_time = INVALID_START_TIME;
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
+	if (evsel->disabled)
+		return 0;
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
@@ -507,39 +658,33 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
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
@@ -553,7 +698,6 @@ int evsel__tool_pmu_read(struct evsel *evsel, int cpu_map_idx, int thread)
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

