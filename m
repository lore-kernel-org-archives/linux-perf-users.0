Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795418409;
	b=BWOO+LiNEHcXExUfBq2x3WSElN2ehjag6VejGdQAjDzDPtJrgnqFpMERBx7ZHzgMcrFH
	 hwfcjWoIQlVNTJ1FIMT18pLkahPL+RljXTAgeMf70S3lsP2ae+W1Piwg8VIQmwV4QMGqW
	 MsYHGN/yNSpskqDuUVjKIIU8fp7n9edMDZcYfpnDeBxWU4Hhj82JDEsC6lMZs1MsG6c4H
	 aysb0jeChG7tfUqLFIBwiLYEvmsFfAhvWOXtjiJkhVUZ/5Dw6k6wxpnax3KThXPp6H8kb
	 BbCTHlTjKXVh1e1I7Ipnkrad9h7WG/3N2bR87U3Gnky0gzfnDMqP+TJRWOIYkxK4bFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=+yMHdu8ZU+gDZ3LcDiJBOlO1BMwKVmt8Xr9NpwRp3Vs=;
	b=kN3XGveN8f4eZUeDFWmTCwp/uSDzso8gRbbfHehn2D3qMAvgICp+WcvQwPNp3e+/Kul1
	 voItFbQLQrrvQYuDT55+4pgiWRofT4gAF5JPGN8vFsXpvqw+R99H5v7fNChTJ15QDedKq
	 Vlsu1pIuX4V+4fkh7OsK2gYgKLJYddD+nYzn9Gc1+Rz5keBZgdTVX/c4FEBR05ikC2tq7
	 82BxAKSOImLSBj1gnveQV3jIy+5JrxXw0zfl6Y/I3bzQvJksW/7Uerek2RRe3BYBApDPW
	 y680IUNUJx+KYIDsRBVHmGEeXpUmOyicBLa8M0gK5AnadtP/GMz1MXgwDUnweMJWHDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vq9Lu+7f;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D96606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 07:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2D96606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Vq9Lu+7f
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso3385173eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 23:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795418408; x=1796023208; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+yMHdu8ZU+gDZ3LcDiJBOlO1BMwKVmt8Xr9NpwRp3Vs=;
        b=Vq9Lu+7fvozy2VhGuSDZEVOy5UsNgh2apKmMsn+FIeVkZ50cFP/hBSaXQnOqZzH+kQ
         ak2YaJEbP8LzPhwLDNG5UQ9td4jrxlRST39KmqXXd9hX822tqzj3Qra22skZW2V9PmC/
         P+cnNNrey4jBe5cE8WZzoCoBy9toYe2jB7pX7lNi8weT1T2SGUBOZQP6w3LIPW3ttr5f
         +a64q3UJGx/54I8/4wsSZ0zuCT0SllEDLW2ts3UzITnn/xgE/fumjDtrfdE0cK2Gkx4G
         +/g/zQfXrF0UBfp1PMUd8HTkJhwVnkzJMYOoIw5NniAMSirrReQFqTjZp65kwwHQl0HP
         BEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795418408; x=1796023208;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+yMHdu8ZU+gDZ3LcDiJBOlO1BMwKVmt8Xr9NpwRp3Vs=;
        b=2mhZg0I751OfkE9zSOfOxZaHn736jRHpoijLwwtCT1pULOCkPVVtQZLtvSkNyEljfO
         H2IpceU16dFrF+WfMTFi3zfgMb9L1OKokqZULkc/MiCawF751WMnvqccRNmZh63/cjkL
         K3CBcrM9TSInGAq5VJnxGaQMkELC9SyLoPRNdKrcJ2X65Pvr4Jm2y5uvzfHwFWsjHYNc
         lwjE3VLFI/WtMgLi2V/XatXLYTRAdlqfBVzm+n9eUC2f5Gk/HkJcLOP/cgMa6YCGrkhO
         dr8hsdY60txYKHYinUGvmY/2IDNtpJRExunZPfjhxvbEAbyPSLWGIj9Q7kodXt314pUB
         0/qA==
X-Forwarded-Encrypted: i=1; AL+hErGwF7Z1113e2Yl4wmKLGHJMQY6ZSrtfk/z+XzhWYWH+CghCMFYE6Yi8rc+R+p1JJnAgZspWnZ3XHivYiUBhC80u@vger.kernel.org
X-Gm-Message-State: APuU4Z/li16vQG3KGQNO1jt0mkQWidYz5ZRfhMPgproaXY0453aca5E0
	ckDxqSpJiswgbMEnyEuYfUTrfrGTk6EYac/e/XPKNhZ2WZcCw4h1+F+b2l3bDbUmpDZ2ozagVpT
	yrV205FTJaw==
X-Received: from dyff26.prod.google.com ([2002:a05:693c:805a:b0:386:9be5:2d95])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6e9a:b0:383:71a:2b14
 with SMTP id 5a478bee46e88-3856f14bb69mr10306411eec.10.1795418407468; Sun, 22
 Nov 2026 23:20:07 -0800 (PST)
Date: Sun, 22 Nov 2026 23:19:09 -0800
In-Reply-To: <20261123071913.653315-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123071913.653315-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123071913.653315-10-irogers@google.com>
Subject: [PATCH v1 09/13] perf stat: Fix --bpf-counters with non-bperf,
 hybrid, and mixed events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Song Liu <songliubraving@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When `perf stat` runs with `--bpf-counters` (`target.use_bpf`), the `:b`
event modifier (`evsel->bpf_counter`), or `stat.bpf-counter-events`,
`bpf_counter__load()` unconditionally assigns `bperf_ops` (or
`bperf_cgrp_ops` for `--for-each-cgroup`) and `__run_perf_stat()` skips
`create_perf_stat_counter()` whenever `target.use_bpf` is set. This
causes several failures when events that cannot be read through bperf's
shared per-CPU `PERF_EVENT_ARRAY` are present:

1. Non-`perf_event_open` PMU events (`tool` events such as
   `duration_time` and `user_time`, `bpf`, `hwmon`, and `drm` PMUs),
   uncore PMUs, and retirement latency (`:R`) events have no CPU-local
   `perf_event` file descriptor for `bpf_perf_event_read_value()`, so
   bperf either reads 0, leaves `tool` state uninitialized (reading
   system uptime for `duration_time` on secondary cgroups or
   dereferencing NULL `process_time` xyarrays), or skips opening them.
2. Events with tracepoint, address, or BPF filters (`evsel->filter` or
   `evsel->bpf_filters`) and `-G` cgroup events share bperf's global
   pinned `/sys/fs/bpf/perf_attr_map` keyed solely on
   `struct perf_event_attr`, ignoring filters/cgroups or skipping
   `perf_bpf_filter__prepare()` in `evlist__apply_filters()`.
3. Grouped events under `--bpf-counters` (such as `Default` topdown
   metric groups) fail `bperf_check_target()` instead of falling back to
   regular grouped counters.
4. On hybrid systems, `-C <cpus>` can leave one PMU's `evsel->core.cpus`
   empty (hitting `assert()` in `bperf_reload_leader_program()` or
   dereferencing NULL `evsel->core.fd` in `store_evsel_ids()`) or give
   different hybrid evsels different CPU counts (clobbering the
   file-static `filter_entry_cnt` in `bpf_counter.c`).
5. In mixed sessions (`!all_counters_use_bpf`), `__evlist__disable()`
   and `__evlist__enable()` run `PERF_EVENT_IOC_DISABLE` / `ENABLE` on
   `evsel->core.fd` of the session that loaded `bperf_leader`, disabling
   the globally shared hardware PMCs for concurrent and repeat (`-r`)
   runs. Repeat runs also leaked `bperf_follower` `fexit` links and
   leader FDs, and left `bperf_cgrp` `cgrp_readings` accumulating across
   runs.

Fix these issues by:
- Adding `bpf_counter__can_use_bperf()` and
  `bpf_counter__can_use_bperf_cgrp()` to restrict `bperf` to compatible
  counters and fall back cleanly otherwise, rejecting explicit `:b` on
  grouped events before `evlist__create_maps()` splits mismatched group
  CPU maps, and leaving `tool` PMU events out of `bperf_cgrp_ops` so
  they open, toggle (`-D`), and reset (`-r`) through the regular tool
  PMU paths.
- Gating the `create_perf_stat_counter()` loop on `!all_counters_use_bpf`
  instead of `!target.use_bpf`, resetting `all_counters_use_bpf` on each
  run, and only setting `requires_cpu` on counters that will use bperf.
- Skipping `evsel__is_bperf()` counters in `evlist__is_enabled()`,
  `__evlist__disable()`, and `__evlist__enable()`, and guarding NULL
  `evsel->core.fd` in `evlist__apply_filters()` and `store_evsel_ids()`.
- Reading per-evsel `accum_readings` map max entries instead of a global
  `filter_entry_cnt`, clearing `evsel->leader_skel` before freeing it,
  storing `skel->links.fexit_XXX`, closing `cgrp_switch` on teardown,
  and resetting follower / `bperf_cgrp` / `bpf_prog_profiler` state on
  repeat loads.

Fixes: 7fac83aaf2ee ("perf stat: Introduce 'bperf' to share hardware PMCs with BPF")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c            |  27 ++++-
 tools/perf/util/bpf_counter.c        | 115 ++++++++++++++++-----
 tools/perf/util/bpf_counter.h        |  14 +++
 tools/perf/util/bpf_counter_cgroup.c | 145 ++++++++++++++++++++-------
 tools/perf/util/evlist.c             |  17 +++-
 tools/perf/util/evsel.c              |   8 +-
 6 files changed, 254 insertions(+), 72 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 964bf0864796..267808e23e69 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -802,6 +802,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		child_pid = evlist__workload_pid(evsel_list);
 	}
 
+	all_counters_use_bpf = true;
+
 	evlist__for_each_entry(evsel_list, counter) {
 		counter->reset_group = false;
 		if (bpf_counter__load(counter, &target)) {
@@ -818,7 +820,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	 * bperf calls evsel__open_per_cpu() in bperf__load(), so
 	 * no need to call it again here.
 	 */
-	if (!target.use_bpf) {
+	if (!all_counters_use_bpf) {
 		evlist__for_each_cpu(evlist_cpu_itr, evsel_list) {
 			counter = evlist_cpu_itr.evsel;
 
@@ -2908,6 +2910,15 @@ int cmd_stat(int argc, const char **argv)
 			goto out;
 		}
 
+		if (target.use_bpf) {
+			evlist__for_each_entry(evsel_list, counter) {
+				if (!bpf_counter__can_use_bperf_cgrp(counter)) {
+					target.use_bpf = false;
+					break;
+				}
+			}
+		}
+
 		if (evlist__expand_cgroup(evsel_list, stat_config.cgroup_list,
 					  !target.use_bpf) < 0) {
 			parse_options_usage(stat_usage, stat_options,
@@ -2927,6 +2938,18 @@ int cmd_stat(int argc, const char **argv)
 	evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
 
 	evlist__for_each_entry(evsel_list, counter) {
+		bool needs_bperf_cpu =
+			(counter->bpf_counter || target.use_bpf ||
+			 evsel__match_bpf_counter_events(evsel__name(counter))) &&
+			(stat_config.cgroup_list ?
+			 (target.use_bpf && !evsel__is_non_perf_event_open_pmu(counter)) :
+			 bpf_counter__can_use_bperf(counter));
+
+		if (counter->bpf_counter && counter->core.leader->nr_members > 1) {
+			pr_err("bpf managed perf events do not yet support groups.\n");
+			goto out;
+		}
+
 		/*
 		 * Setup BPF counters to require CPUs as any(-1) isn't
 		 * supported. evlist__create_maps below will propagate this
@@ -2934,7 +2957,7 @@ int cmd_stat(int argc, const char **argv)
 		 * set up, and this change must happen early, so directly use
 		 * the bpf_counter variable and target information.
 		 */
-		if ((counter->bpf_counter || target.use_bpf) && !target__has_cpu(&target))
+		if (needs_bperf_cpu && !target__has_cpu(&target))
 			counter->core.requires_cpu = true;
 	}
 
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 9362e45e17ce..d2ab19ec4366 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -4,6 +4,7 @@
 
 #include <assert.h>
 #include <limits.h>
+#include <stdbool.h>
 #include <unistd.h>
 #include <sys/file.h>
 #include <sys/resource.h>
@@ -22,7 +23,9 @@
 #include "debug.h"
 #include "evsel.h"
 #include "evlist.h"
+#include "pmu.h"
 #include "target.h"
+#include "tool_pmu.h"
 #include "cgroup.h"
 #include "cpumap.h"
 #include "thread_map.h"
@@ -230,6 +233,9 @@ static int bpf_program_profiler__load(struct evsel *evsel, struct target *target
 	u32 prog_id;
 	int ret;
 
+	if (!list_empty(&evsel->bpf_counter_list))
+		bpf_program_profiler__destroy(evsel);
+
 	bpf_str_ = bpf_str = strdup(target->bpf_str);
 	if (!bpf_str)
 		return -1;
@@ -240,6 +246,7 @@ static int bpf_program_profiler__load(struct evsel *evsel, struct target *target
 		    (*p != '\0' && *p != ',')) {
 			pr_err("Failed to parse bpf prog ids %s\n",
 			       target->bpf_str);
+			bpf_program_profiler__destroy(evsel);
 			free(bpf_str_);
 			return -1;
 		}
@@ -454,8 +461,6 @@ static int bperf_check_target(struct evsel *evsel,
 	return 0;
 }
 
-static __u32 filter_entry_cnt;
-
 static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
 				       struct perf_event_attr_map_entry *entry)
 {
@@ -505,6 +510,7 @@ static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
 	perf_thread_map__put(threads);
 
 out:
+	evsel->leader_skel = NULL;
 	bperf_leader_bpf__destroy(skel);
 	bpf_link__destroy(link);
 	return err;
@@ -523,19 +529,38 @@ static int bperf_attach_follower_program(struct bperf_follower_bpf *skel,
 		err = bperf_follower_bpf__attach(skel);
 	else {
 		link = bpf_program__attach(skel->progs.fexit_XXX);
-		if (IS_ERR(link))
-			err = PTR_ERR(link);
+		err = libbpf_get_error(link);
+		if (!err)
+			skel->links.fexit_XXX = link;
 	}
 
 	return err;
 }
 
+static int bperf__destroy(struct evsel *evsel)
+{
+	bperf_follower_bpf__destroy(evsel->follower_skel);
+	evsel->follower_skel = NULL;
+	if (evsel->bperf_leader_prog_fd >= 0) {
+		close(evsel->bperf_leader_prog_fd);
+		evsel->bperf_leader_prog_fd = -1;
+	}
+	if (evsel->bperf_leader_link_fd >= 0) {
+		close(evsel->bperf_leader_link_fd);
+		evsel->bperf_leader_link_fd = -1;
+	}
+	return 0;
+}
+
 static int bperf__load(struct evsel *evsel, struct target *target)
 {
 	struct perf_event_attr_map_entry entry = {0xffffffff, 0xffffffff};
 	int attr_map_fd, diff_map_fd = -1, err;
 	enum bperf_filter_type filter_type;
-	__u32 i;
+	__u32 filter_entry_cnt, i;
+
+	if (evsel->follower_skel)
+		bperf__destroy(evsel);
 
 	if (bperf_check_target(evsel, target, &filter_type, &filter_entry_cnt))
 		return -1;
@@ -641,10 +666,18 @@ static int bperf__load(struct evsel *evsel, struct target *target)
 					    target->inherit);
 
 out:
-	if (err && evsel->bperf_leader_link_fd >= 0)
-		close(evsel->bperf_leader_link_fd);
-	if (err && evsel->bperf_leader_prog_fd >= 0)
-		close(evsel->bperf_leader_prog_fd);
+	if (err) {
+		bperf_follower_bpf__destroy(evsel->follower_skel);
+		evsel->follower_skel = NULL;
+		if (evsel->bperf_leader_link_fd >= 0) {
+			close(evsel->bperf_leader_link_fd);
+			evsel->bperf_leader_link_fd = -1;
+		}
+		if (evsel->bperf_leader_prog_fd >= 0) {
+			close(evsel->bperf_leader_prog_fd);
+			evsel->bperf_leader_prog_fd = -1;
+		}
+	}
 	if (diff_map_fd >= 0)
 		close(diff_map_fd);
 
@@ -697,11 +730,13 @@ static int bperf__read(struct evsel *evsel)
 	struct bpf_perf_event_value values[num_cpu_bpf];
 	struct perf_counts_values *counts;
 	int reading_map_fd, err = 0;
+	__u32 entry_cnt;
 
 	bperf_sync_counters(evsel);
 	reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
+	entry_cnt = bpf_map__max_entries(skel->maps.accum_readings);
 
-	for (__u32 i = 0; i < filter_entry_cnt; i++) {
+	for (__u32 i = 0; i < entry_cnt; i++) {
 		struct perf_cpu entry;
 		__u32 cpu;
 
@@ -750,14 +785,6 @@ static int bperf__read(struct evsel *evsel)
 	return err;
 }
 
-static int bperf__destroy(struct evsel *evsel)
-{
-	bperf_follower_bpf__destroy(evsel->follower_skel);
-	close(evsel->bperf_leader_prog_fd);
-	close(evsel->bperf_leader_link_fd);
-	return 0;
-}
-
 /*
  * bperf: share hardware PMCs with BPF
  *
@@ -856,18 +883,56 @@ int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd)
 	return evsel->bpf_counter_ops->install_pe(evsel, cpu_map_idx, fd);
 }
 
+bool bpf_counter__can_use_bperf(const struct evsel *evsel)
+{
+	return !evsel__is_non_perf_event_open_pmu(evsel) &&
+	       !evsel__is_retire_lat(evsel) &&
+	       !evsel->core.is_pmu_uncore &&
+	       !(evsel->pmu && evsel->pmu->is_uncore) &&
+	       !evsel->cgrp &&
+	       !evsel->filter &&
+	       list_empty(&evsel->bpf_filters) &&
+	       evsel->core.leader->nr_members <= 1;
+}
+
+bool bpf_counter__can_use_bperf_cgrp(const struct evsel *evsel)
+{
+	if (evsel__is_tool(evsel)) {
+		enum tool_pmu_event ev = evsel__tool_event(evsel);
+
+		return ev != TOOL_PMU__EVENT_USER_TIME &&
+		       ev != TOOL_PMU__EVENT_SYSTEM_TIME;
+	}
+
+	return !evsel__is_non_perf_event_open_pmu(evsel) &&
+	       !evsel__is_retire_lat(evsel) &&
+	       !evsel->core.is_pmu_uncore &&
+	       !(evsel->pmu && evsel->pmu->is_uncore) &&
+	       !evsel->filter &&
+	       list_empty(&evsel->bpf_filters);
+}
+
 int bpf_counter__load(struct evsel *evsel, struct target *target)
 {
-	if (target->bpf_str)
+	if (target->bpf_str) {
 		evsel->bpf_counter_ops = &bpf_program_profiler_ops;
-	else if (cgrp_event_expanded && target->use_bpf)
-		evsel->bpf_counter_ops = &bperf_cgrp_ops;
-	else if (target->use_bpf || evsel->bpf_counter ||
-		 evsel__match_bpf_counter_events(evsel->name))
+	} else if (cgrp_event_expanded && target->use_bpf) {
+		if (!evsel__is_tool(evsel))
+			evsel->bpf_counter_ops = &bperf_cgrp_ops;
+	} else if ((target->use_bpf || evsel->bpf_counter ||
+		    evsel__match_bpf_counter_events(evsel__name(evsel))) &&
+		   bpf_counter__can_use_bperf(evsel) &&
+		   !perf_cpu_map__has_any_cpu_or_is_empty(evsel->core.cpus)) {
 		evsel->bpf_counter_ops = &bperf_ops;
+	}
+
+	if (evsel->bpf_counter_ops) {
+		int err = evsel->bpf_counter_ops->load(evsel, target);
 
-	if (evsel->bpf_counter_ops)
-		return evsel->bpf_counter_ops->load(evsel, target);
+		if (err)
+			bpf_counter__destroy(evsel);
+		return err;
+	}
 	return 0;
 }
 
diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.h
index 658d8e7d507e..08056254264e 100644
--- a/tools/perf/util/bpf_counter.h
+++ b/tools/perf/util/bpf_counter.h
@@ -2,6 +2,8 @@
 #ifndef __PERF_BPF_COUNTER_H
 #define __PERF_BPF_COUNTER_H 1
 
+#include <stdbool.h>
+
 struct evsel;
 struct target;
 
@@ -30,6 +32,8 @@ int bpf_counter__disable(struct evsel *evsel);
 int bpf_counter__read(struct evsel *evsel);
 void bpf_counter__destroy(struct evsel *evsel);
 int bpf_counter__install_pe(struct evsel *evsel, int cpu_map_idx, int fd);
+bool bpf_counter__can_use_bperf(const struct evsel *evsel);
+bool bpf_counter__can_use_bperf_cgrp(const struct evsel *evsel);
 
 int bperf_trigger_reading(int prog_fd, int cpu);
 void set_max_rlimit(void);
@@ -70,6 +74,16 @@ static inline int bpf_counter__install_pe(struct evsel *evsel __maybe_unused,
 	return 0;
 }
 
+static inline bool bpf_counter__can_use_bperf(const struct evsel *evsel __maybe_unused)
+{
+	return false;
+}
+
+static inline bool bpf_counter__can_use_bperf_cgrp(const struct evsel *evsel __maybe_unused)
+{
+	return false;
+}
+
 #endif /* HAVE_BPF_SKEL */
 
 #endif /* __PERF_BPF_COUNTER_H */
diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index 4e5f4b9dd442..3b99b011b228 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -6,6 +6,8 @@
 #include <assert.h>
 #include <errno.h>
 #include <limits.h>
+#include <stdbool.h>
+#include <stdlib.h>
 #include <unistd.h>
 #include <sys/file.h>
 #include <sys/time.h>
@@ -14,6 +16,7 @@
 #include <linux/perf_event.h>
 #include <api/fs/fs.h>
 #include <bpf/bpf.h>
+#include <bpf/libbpf.h>
 #include <perf/bpf_perf.h>
 
 #include "affinity.h"
@@ -23,7 +26,9 @@
 #include "debug.h"
 #include "evsel.h"
 #include "evlist.h"
+#include "pmu.h"
 #include "target.h"
+#include "tool_pmu.h"
 #include "cpumap.h"
 #include "thread_map.h"
 
@@ -39,7 +44,9 @@ static struct perf_event_attr cgrp_switch_attr = {
 };
 
 static struct evsel *cgrp_switch;
+static struct evsel *bperf_cgrp_leader;
 static struct bperf_cgroup_bpf *skel;
+static bool bperf_loaded;
 
 #define FD(evt, cpu) (*(int *)xyarray__entry(evt->core.fd, cpu, 0))
 
@@ -150,25 +157,31 @@ static int bperf_load_program(struct evlist *evlist)
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (cgrp == NULL || evsel->cgrp == leader_cgrp) {
-			unsigned int j;
-
 			leader_cgrp = evsel->cgrp;
-			evsel->cgrp = NULL;
 
-			/* open single copy of the events w/o cgroup */
-			err = evsel__open_per_cpu(evsel, evsel->core.cpus, -1);
-			if (err == 0)
-				evsel->supported = true;
+			if (!evsel__is_tool(evsel) &&
+			    !perf_cpu_map__has_any_cpu_or_is_empty(evsel->core.cpus)) {
+				unsigned int j;
 
-			map_fd = bpf_map__fd(skel->maps.events);
-			perf_cpu_map__for_each_cpu(cpu, j, evsel->core.cpus) {
-				int fd = FD(evsel, j);
-				__u32 idx = evsel->core.idx * total_cpus + cpu.cpu;
+				evsel->cgrp = NULL;
 
-				bpf_map_update_elem(map_fd, &idx, &fd, BPF_ANY);
-			}
+				/* open single copy of the events w/o cgroup */
+				err = evsel__open_per_cpu(evsel, evsel->core.cpus, -1);
+				if (err == 0) {
+					evsel->supported = true;
+					map_fd = bpf_map__fd(skel->maps.events);
+					perf_cpu_map__for_each_cpu(cpu, j, evsel->core.cpus) {
+						int fd = FD(evsel, j);
+						__u32 idx = evsel->core.idx * total_cpus + cpu.cpu;
 
-			evsel->cgrp = leader_cgrp;
+						bpf_map_update_elem(map_fd, &idx, &fd, BPF_ANY);
+					}
+				} else {
+					evsel->supported = false;
+				}
+
+				evsel->cgrp = leader_cgrp;
+			}
 		}
 
 		if (evsel->cgrp == cgrp)
@@ -200,6 +213,8 @@ static int bperf_load_program(struct evlist *evlist)
 		int num_events = evlist__nr_entries(evlist) / nr_cgroups;
 
 		evlist__for_each_entry(evlist, evsel) {
+			if (evsel__is_tool(evsel))
+				continue;
 			leader = evlist__find_evsel(evlist, evsel->core.idx % num_events);
 			if (leader)
 				evsel->supported = leader->supported;
@@ -219,21 +234,81 @@ static int bperf_load_program(struct evlist *evlist)
 	}
 
 out:
+	if (err) {
+		bperf_cgroup_bpf__destroy(skel);
+		skel = NULL;
+		if (cgrp_switch) {
+			evsel__close(cgrp_switch);
+			evsel__put(cgrp_switch);
+			cgrp_switch = NULL;
+		}
+	}
+	return err;
+}
+
+/*
+ * trigger the leader prog on each cpu, so the cgrp_reading map could get
+ * the latest results.
+ */
+static int bperf_cgrp__sync_counters(struct evlist *evlist)
+{
+	struct perf_cpu cpu;
+	unsigned int idx;
+	int prog_fd = bpf_program__fd(skel->progs.trigger_read);
+
+	perf_cpu_map__for_each_cpu(cpu, idx, evlist__core(evlist)->all_cpus)
+		bperf_trigger_reading(prog_fd, cpu.cpu);
+
+	return 0;
+}
+
+static int bperf_cgrp__reset_readings(struct evlist *evlist)
+{
+	int nr_cpus = libbpf_num_possible_cpus();
+	int total_cpus = cpu__max_cpu().cpu;
+	struct bpf_perf_event_value *values;
+	int reading_map_fd, err = 0;
+	__u32 nr_entries = evlist__nr_entries(evlist);
+
+	if (nr_cpus > total_cpus)
+		total_cpus = nr_cpus;
+	if (total_cpus <= 0)
+		return -EINVAL;
+
+	skel->bss->enabled = 0;
+	bperf_cgrp__sync_counters(evlist);
+
+	values = calloc(total_cpus, sizeof(*values));
+	if (!values)
+		return -ENOMEM;
+
+	reading_map_fd = bpf_map__fd(skel->maps.cgrp_readings);
+	for (__u32 idx = 0; idx < nr_entries; idx++) {
+		err = bpf_map_update_elem(reading_map_fd, &idx, values, BPF_ANY);
+		if (err)
+			break;
+	}
+
+	free(values);
 	return err;
 }
 
 static int bperf_cgrp__load(struct evsel *evsel,
 			    struct target *target __maybe_unused)
 {
-	static bool bperf_loaded = false;
-
 	evsel->bperf_leader_prog_fd = -1;
 	evsel->bperf_leader_link_fd = -1;
 
-	if (!bperf_loaded && bperf_load_program(evsel->evlist))
-		return -1;
+	if (!bperf_loaded) {
+		if (bperf_load_program(evsel->evlist))
+			return -1;
+		bperf_loaded = true;
+		bperf_cgrp_leader = evsel;
+	} else if (evsel == bperf_cgrp_leader) {
+		if (bperf_cgrp__reset_readings(evsel->evlist))
+			return -1;
+	}
 
-	bperf_loaded = true;
 	/* just to bypass bpf_counter_skip() */
 	evsel->follower_skel = (struct bperf_follower_bpf *)skel;
 
@@ -248,25 +323,9 @@ static int bperf_cgrp__install_pe(struct evsel *evsel __maybe_unused,
 	return 0;
 }
 
-/*
- * trigger the leader prog on each cpu, so the cgrp_reading map could get
- * the latest results.
- */
-static int bperf_cgrp__sync_counters(struct evlist *evlist)
-{
-	struct perf_cpu cpu;
-	unsigned int idx;
-	int prog_fd = bpf_program__fd(skel->progs.trigger_read);
-
-	perf_cpu_map__for_each_cpu(cpu, idx, evlist__core(evlist)->all_cpus)
-		bperf_trigger_reading(prog_fd, cpu.cpu);
-
-	return 0;
-}
-
 static int bperf_cgrp__enable(struct evsel *evsel)
 {
-	if (evsel->core.idx)
+	if (evsel != bperf_cgrp_leader)
 		return 0;
 
 	bperf_cgrp__sync_counters(evsel->evlist);
@@ -277,7 +336,7 @@ static int bperf_cgrp__enable(struct evsel *evsel)
 
 static int bperf_cgrp__disable(struct evsel *evsel)
 {
-	if (evsel->core.idx)
+	if (evsel != bperf_cgrp_leader)
 		return 0;
 
 	bperf_cgrp__sync_counters(evsel->evlist);
@@ -294,7 +353,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
 	struct bpf_perf_event_value *values;
 	int reading_map_fd, err = 0;
 
-	if (evsel->core.idx)
+	if (evsel != bperf_cgrp_leader)
 		return 0;
 
 	bperf_cgrp__sync_counters(evsel->evlist);
@@ -310,6 +369,9 @@ static int bperf_cgrp__read(struct evsel *evsel)
 		unsigned int i;
 		struct perf_cpu cpu;
 
+		if (evsel__is_tool(evsel))
+			continue;
+
 		err = bpf_map_lookup_elem(reading_map_fd, &idx, values);
 		if (err) {
 			pr_err("bpf map lookup failed: idx=%u, event=%s, cgrp=%s\n",
@@ -332,11 +394,16 @@ static int bperf_cgrp__read(struct evsel *evsel)
 
 static int bperf_cgrp__destroy(struct evsel *evsel)
 {
-	if (evsel->core.idx)
+	if (evsel != bperf_cgrp_leader)
 		return 0;
 
 	bperf_cgroup_bpf__destroy(skel);
+	skel = NULL;
+	evsel__close(cgrp_switch);
 	evsel__put(cgrp_switch);  // it'll destroy on_switch progs too
+	cgrp_switch = NULL;
+	bperf_cgrp_leader = NULL;
+	bperf_loaded = false;
 
 	return 0;
 }
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ec26064183b6..638d501a7531 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -754,7 +754,7 @@ static bool evlist__is_enabled(struct evlist *evlist)
 	struct evsel *pos;
 
 	evlist__for_each_entry(evlist, pos) {
-		if (!pos->core.fd)
+		if (!pos->core.fd || evsel__is_bperf(pos))
 			continue;
 		if (!evsel__is_group_leader(pos) && !pos->merged_hybrid_group)
 			continue;
@@ -782,7 +782,8 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name, bool excl
 			if (!match)
 				continue;
 			if (pos->disabled || (!evsel__is_group_leader(pos) &&
-					      !pos->merged_hybrid_group) || !pos->core.fd)
+					      !pos->merged_hybrid_group) ||
+			    !pos->core.fd || evsel__is_bperf(pos))
 				continue;
 			if (excl_dummy && evsel__is_dummy_event(pos))
 				continue;
@@ -802,7 +803,8 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name, bool excl
 			match = !evsel__strcmp(evsel__leader(pos), evsel_name);
 		if (!match)
 			continue;
-		if ((!evsel__is_group_leader(pos) && !pos->merged_hybrid_group) || !pos->core.fd)
+		if ((!evsel__is_group_leader(pos) && !pos->merged_hybrid_group) ||
+		    !pos->core.fd || evsel__is_bperf(pos))
 			continue;
 		if (excl_dummy && evsel__is_dummy_event(pos))
 			continue;
@@ -847,7 +849,8 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name, bool excl_
 			match = !evsel__strcmp(evsel__leader(pos), evsel_name);
 		if (!match)
 			continue;
-		if ((!evsel__is_group_leader(pos) && !pos->merged_hybrid_group) || !pos->core.fd)
+		if ((!evsel__is_group_leader(pos) && !pos->merged_hybrid_group) ||
+		    !pos->core.fd || evsel__is_bperf(pos))
 			continue;
 		if (excl_dummy && evsel__is_dummy_event(pos))
 			continue;
@@ -859,7 +862,8 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name, bool excl_
 			match = !evsel__strcmp(evsel__leader(pos), evsel_name);
 		if (!match)
 			continue;
-		if ((!evsel__is_group_leader(pos) && !pos->merged_hybrid_group) || !pos->core.fd)
+		if ((!evsel__is_group_leader(pos) && !pos->merged_hybrid_group) ||
+		    !pos->core.fd || evsel__is_bperf(pos))
 			continue;
 		if (excl_dummy && evsel__is_dummy_event(pos))
 			continue;
@@ -1403,6 +1407,9 @@ int evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel,
 	int err = 0;
 
 	evlist__for_each_entry(evlist, evsel) {
+		if (!evsel->core.fd)
+			continue;
+
 		/*
 		 * filters only work for tracepoint event, which doesn't have cpu limit.
 		 * So evlist and evsel should always be same.
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d89087e295dc..e0f3ca79c9cc 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -477,6 +477,8 @@ static void evsel__init(struct evsel *evsel,
 	evsel->alternate_hw_config = PERF_COUNT_HW_MAX;
 	evsel->script_output_type = -1; // FIXME: OUTPUT_TYPE_UNSET, see builtin-script.c
 	evsel->probe_type = PROBE__UNKNOWN;
+	evsel->bperf_leader_prog_fd = -1;
+	evsel->bperf_leader_link_fd = -1;
 }
 
 struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
@@ -557,6 +559,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->core.requires_cpu = orig->core.requires_cpu;
 	evsel->core.is_pmu_core = orig->core.is_pmu_core;
 	evsel->core.is_pmu_uncore = orig->core.is_pmu_uncore;
+	evsel->core.reads_only_on_cpu_idx0 = orig->core.reads_only_on_cpu_idx0;
 
 	if (orig->name) {
 		evsel->name = strdup(orig->name);
@@ -4810,7 +4813,7 @@ static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
 {
 	int cpu_map_idx, thread;
 
-	if (evsel__is_retire_lat(evsel) ||
+	if (evsel__is_retire_lat(evsel) || evsel__is_bperf(evsel) ||
 	    perf_pmu__kind(evsel->pmu) != PERF_PMU_KIND_PE) {
 		struct xyarray *sample_id = evsel->core.sample_id;
 
@@ -4833,6 +4836,9 @@ static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
 		return 0;
 	}
 
+	if (!evsel->core.fd)
+		return 0;
+
 	for (cpu_map_idx = 0; cpu_map_idx < xyarray__max_x(evsel->core.fd); cpu_map_idx++) {
 		for (thread = 0; thread < xyarray__max_y(evsel->core.fd);
 		     thread++) {
-- 
2.56.1.750.gf70dc682cf-goog

