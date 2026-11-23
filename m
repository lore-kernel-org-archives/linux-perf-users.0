Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795418386;
	b=4GjGCLxnhqxk/fx4ux9ixwwAkFh4kBpcm9pR8X6bezt5I8HTn4gG+b7/O9OsemEG48cG
	 GFBhiuoWQNXkO+m9YEGo4YdCIs4R/yKKKTRTibfTZQV/RVCjX1PdpneX0oZ9/abWkxUJR
	 helUc8N6sBDgcYmjI1DvOrLsgkv5+QFPuU0HhcNwLcDqWd3mZFQY+NstLVbMssDkLAW5T
	 49qn5TNftVs/HWSEVXwxuf1EjK6v957ObgUl112oVJ5vB0/rJoNHfBN2a/pKanIhb+9J2
	 Xj+Da7O8wEJB+ImxJm1qX+mE8H4LESCitzDYIUTOoDlgw7uMFEh3ZG3o0CR1A10yRrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=uUik2QpbhM20Rc2adhMxY4bt3Xj1uba6ieJfcuhtQ5k=;
	b=IAghgIRC1F2N7ofTzyE3BUcDu1wq5uRhiHonT066L816gUJWtFixG3SRMgkjZFrY4uKV
	 QhpHOkNv6oQhWZTjOPAM6Zp2iXLul0/qnd7UxsHrR49u8uO5VV7r8Uzz0mYjwHjzofA5j
	 n0a/+qHvmHmlVgbj6WEYIaPHY7NQaJzbm8d1xr3/1gzwGBHdwpBpcpSr7wum2GB3xG4Hw
	 vCuxoKpbaN2UKotG0o6xAXmVhNSxcu2UQ+NZy8CasoOQnfB5Qy/L+z2BMFeKEd89YGUJz
	 UHue++1lbmZjVwZOj7t198TOaKGzBPyrUIKyWTW9nvn/eX/2eH+AllctXw+zxw9dJ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O71O27ef;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425E4606A336
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 07:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 425E4606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=O71O27ef
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3aed37745bcso3251049a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 22 Nov 2026 23:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795418384; x=1796023184; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uUik2QpbhM20Rc2adhMxY4bt3Xj1uba6ieJfcuhtQ5k=;
        b=O71O27efqwUA8tE8hD5ntss+eWJEBW3b9RfdoUZjYh5XDqzGwp4ubj0122eXExWg53
         kdtG4Od9PjgpTytG527C1QF6YeyoEpFWWg7v96Zmv2KppwraXevXWQbvbiIipBDvJ51u
         /B/QZFIqFGperEp5Ud1OtsVEyOd1r/rasVV/asyH7gWOD20xTna/xw7C1wOvEgVVIsZ4
         FX+lwScviuToBhYIFm2atetHBchh8mQ2vQsV2pafMHcWAwZ4jgKgHb/wXjz3zK8Yasgy
         4OvVwKtG+m6ZDILZcqoAN1skmFpPZQ+xlMbgpIE9yrGBLBtmMLEaTwfcvixgrHwgskbj
         byBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795418384; x=1796023184;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uUik2QpbhM20Rc2adhMxY4bt3Xj1uba6ieJfcuhtQ5k=;
        b=nS/IrualaGTu+1rLpC+kxbiLpKNqPrmauziDkKGvC+WXvZlnAk/h9G2+r2KJPXI/AE
         AC/78xqGzPEfrJR5+EWzVsVS5icwrcJBnEVff6bFjcfkr6jVg4gRn0OShFaR9mXHZXMC
         JGzX8Hb8oz3k4vuPF5FpRatMwTt64SX9j4e0U965ZE84f2Rvr78YepnxzlMl+ayauI7n
         VyL/LJIj/85uFEmqrbQ7BPqKOyTCC/ATmn9+BqvuFzwoXTuLndfphnCWtCixO2bspk1q
         Nc8LrcOOey6VDVXwYXjcmOwcjobDso2WRshAD1OY5YZWTr5r84/FTJvIMUwZzze0ML4X
         JXzg==
X-Forwarded-Encrypted: i=1; AL+hErH7abP3sKALTTvLGagJLKKXZkXI59ijyKfzqWEgswxz4xRBUSvBxfhXFXU8aFLvLrj//6fY4vOwJJVar/feX08e@vger.kernel.org
X-Gm-Message-State: APuU4Z/Wsy2+7Z1kXy5fNTOWRt6lSNOZeiDW8B9BUMjOS/0zagBtzxYS
	gSs0UOF+maWPLtZ/yYuQlmgPjJ9uNDq6TSsGFM766qv5mtQXOydCXrlJxO3xZUlEit8XvED8nfE
	TDfIfKDxZdA==
X-Received: from pgij18.prod.google.com ([2002:a05:6a02:8412:b0:cde:7fbd:d614])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fc4:b0:3b4:2353:5f89
 with SMTP id 98e67ed59e1d1-3b42353601emr7365922a91.6.1795418384383; Sun, 22
 Nov 2026 23:19:44 -0800 (PST)
Date: Sun, 22 Nov 2026 23:19:05 -0800
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
Message-ID: <20261123071913.653315-6-irogers@google.com>
Subject: [PATCH v1 05/13] perf stat: Preserve per-evsel CPU maps across stat
 record and report
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Song Liu <songliubraving@fb.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 6d765f5f7ec6 ("libperf evsel: Rename own_cpus to pmu_cpus") and
commit 811082e4b668 ("perf parse-events: Support user CPUs mixed with
threads/processes") separated an evsel's PMU cpumask (pmu_cpus) from the
actual CPUs on which the event is opened (cpus) and taught
__perf_evlist__propagate_maps() to collapse evsel->cpus to the "any CPU"
(-1) map when user_requested_cpus is -1 and !evsel->requires_cpu.

However, perf_event__synthesize_event_update_cpus() continued to
serialize evsel->core.pmu_cpus instead of evsel->core.cpus, and
perf_event__process_event_update() only populated evsel->core.pmu_cpus
without setting evsel->core.cpus or evsel->core.requires_cpu. This broke
perf stat record/report (and perf script) in two ways:

1. When recording an event opened per-CPU alongside a workload target
   (where user_requested_cpus is -1), such as an event with a cpu= term,
   an uncore counter, --bpf-counters, or a BPF-filtered counter,
   PERF_RECORD_STAT events are written with concrete CPU numbers, but
   perf stat report's perf_evlist__set_maps() collapses evsel->cpus to
   -1 and fails with:

     $ perf stat record -e 'task-clock/cpu=0/,task-clock' -- true
     $ perf stat report
     Invalid CPU 0 for event task-clock/cpu=0/.

2. In system-wide mode (-a), per-evsel CPU restrictions such as cpu=0
   were overwritten by the full PMU cpumask during report, causing
   perf stat report -A to report bogus <not counted> entries on every
   other CPU.

Fix perf_event__synthesize_event_update_cpus() to serialize
evsel->core.cpus, and update perf_event__process_event_update() to
populate evsel->core.cpus and set requires_cpu when the recorded CPU map
does not use the "any CPU" (-1) placeholder. For backward compatibility
with data files recorded by older perf binaries that wrote pmu_cpus for
per-task (-1) counters, fall back to the "any CPU" map in
perf_event__process_stat_event() if a -1 CPU stat event arrives for an
evsel without -1 in its CPU map.

Update the event_update unit test and stat.sh record/report/script tests
to cover per-evsel CPU maps on workload targets.

Fixes: 6d765f5f7ec6 ("libperf evsel: Rename own_cpus to pmu_cpus")
Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed with threads/processes")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/event_update.c    | 43 ++++++++++++++++++++++++++----
 tools/perf/tests/shell/stat.sh     | 16 +++++++++++
 tools/perf/util/evsel.c            |  2 +-
 tools/perf/util/header.c           |  5 ++++
 tools/perf/util/stat.c             | 18 +++++++++++++
 tools/perf/util/synthetic-events.c |  7 +++--
 6 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index 220cc0347747..bacf3c44c8e2 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
 #include <perf/cpumap.h>
+#include <perf/evlist.h>
 #include <string.h>
 #include "cpumap.h"
 #include "evlist.h"
@@ -58,13 +59,20 @@ static int process_event_name(const struct perf_tool *tool,
 	return 0;
 }
 
-static int process_event_cpus(const struct perf_tool *tool __maybe_unused,
+struct event_cpus {
+	struct perf_tool tool;
+	struct evlist *evlist;
+};
+
+static int process_event_cpus(const struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample __maybe_unused,
 			      struct machine *machine __maybe_unused)
 {
+	struct event_cpus *tmp = container_of(tool, struct event_cpus, tool);
 	struct perf_record_event_update *ev = (struct perf_record_event_update *)event;
-	struct perf_cpu_map *map;
+	struct perf_cpu_map *map, *any_cpu;
+	struct evsel *evsel;
 
 	map = cpu_map__new_data(&ev->cpus.cpus);
 
@@ -75,6 +83,26 @@ static int process_event_cpus(const struct perf_tool *tool __maybe_unused,
 	TEST_ASSERT_VAL("wrong cpus", perf_cpu_map__cpu(map, 1).cpu == 2);
 	TEST_ASSERT_VAL("wrong cpus", perf_cpu_map__cpu(map, 2).cpu == 3);
 	perf_cpu_map__put(map);
+
+	evsel = evlist__first(tmp->evlist);
+	perf_cpu_map__put(evsel->core.cpus);
+	evsel->core.cpus = NULL;
+	perf_cpu_map__put(evsel->core.pmu_cpus);
+	evsel->core.pmu_cpus = NULL;
+	evsel->core.requires_cpu = false;
+
+	TEST_ASSERT_VAL("failed to process attr update cpus",
+			!perf_event__process_event_update(tool, event, &tmp->evlist));
+
+	any_cpu = perf_cpu_map__new_any_cpu();
+	TEST_ASSERT_VAL("failed to allocate any_cpu map", any_cpu);
+	perf_evlist__set_maps(evlist__core(tmp->evlist), any_cpu, NULL);
+	perf_cpu_map__put(any_cpu);
+
+	TEST_ASSERT_VAL("wrong processed cpus", perf_cpu_map__nr(evsel->core.cpus) == 3);
+	TEST_ASSERT_VAL("wrong processed cpus", perf_cpu_map__cpu(evsel->core.cpus, 0).cpu == 1);
+	TEST_ASSERT_VAL("wrong processed cpus", perf_cpu_map__cpu(evsel->core.cpus, 1).cpu == 2);
+	TEST_ASSERT_VAL("wrong processed cpus", perf_cpu_map__cpu(evsel->core.cpus, 2).cpu == 3);
 	return 0;
 }
 
@@ -82,6 +110,7 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
 {
 	struct evsel *evsel;
 	struct event_name tmp;
+	struct event_cpus tmp_cpus;
 	struct target target = {};
 	struct evlist *evlist = evlist__new_default(&target, /*sample_callchains=*/false);
 
@@ -111,11 +140,15 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
 	TEST_ASSERT_VAL("failed to synthesize attr update name",
 			!perf_event__synthesize_event_update_name(&tmp.tool, evsel, process_event_name));
 
-	perf_cpu_map__put(evsel->core.pmu_cpus);
-	evsel->core.pmu_cpus = perf_cpu_map__new("1,2,3");
+	perf_cpu_map__put(evsel->core.cpus);
+	evsel->core.cpus = perf_cpu_map__new("1,2,3");
+
+	perf_tool__init(&tmp_cpus.tool, /*ordered_events=*/false);
+	tmp_cpus.evlist = evlist;
 
 	TEST_ASSERT_VAL("failed to synthesize attr update cpus",
-			!perf_event__synthesize_event_update_cpus(&tmp.tool, evsel, process_event_cpus));
+			!perf_event__synthesize_event_update_cpus(&tmp_cpus.tool, evsel,
+								  process_event_cpus));
 
 	evlist__put(evlist);
 	return 0;
diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index ac9e031831da..43a158ee3609 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -77,6 +77,14 @@ test_stat_record_report() {
     err=1
     return
   fi
+  cpu=$(sed 's/[-,].*//' /sys/devices/system/cpu/online)
+  if ! perf stat record -e "task-clock/cpu=${cpu}/,task-clock" -o - true | \
+    perf stat report -i - 2>&1 | grep -E -q "task-clock/cpu=${cpu}/"
+  then
+    echo "stat record and report test [Failed per-evsel CPU]"
+    err=1
+    return
+  fi
   echo "stat record and report test [Success]"
 }
 
@@ -89,6 +97,14 @@ test_stat_record_script() {
     err=1
     return
   fi
+  cpu=$(sed 's/[-,].*//' /sys/devices/system/cpu/online)
+  if ! perf stat record -e "task-clock/cpu=${cpu}/,task-clock" -o - true | \
+    perf script -i - 2>&1 | grep -E -q "task-clock/cpu=${cpu}/"
+  then
+    echo "stat record and script test [Failed per-evsel CPU]"
+    err=1
+    return
+  fi
   echo "stat record and script test [Success]"
 }
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1f96c170d277..64daef4cc345 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1822,7 +1822,7 @@ void evsel__config(struct evsel *evsel, const struct record_opts *opts,
 		attr->exclude_user   = 1;
 	}
 
-	if (evsel->core.pmu_cpus || evsel->unit)
+	if (evsel->core.cpus || evsel->core.pmu_cpus || evsel->unit)
 		evsel->core.attr.read_format |= PERF_FORMAT_ID;
 
 	/*
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9eec6deee190..e9af99b8c0f8 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -5962,6 +5962,11 @@ int perf_event__process_event_update(const struct perf_tool *tool __maybe_unused
 		if (map) {
 			perf_cpu_map__put(evsel->core.pmu_cpus);
 			evsel->core.pmu_cpus = map;
+			if (!evsel->counts) {
+				perf_cpu_map__put(evsel->core.cpus);
+				evsel->core.cpus = perf_cpu_map__get(map);
+				evsel->core.requires_cpu = !perf_cpu_map__has_any_cpu(map);
+			}
 		} else
 			pr_err("failed to get event_update cpus\n");
 		break;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 6da3dbbde0e2..429bfc339308 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -8,6 +8,7 @@
 
 #include <linux/err.h>
 #include <linux/zalloc.h>
+#include <perf/cpumap.h>
 
 #include "counts.h"
 #include "cpumap.h"
@@ -674,6 +675,23 @@ int perf_event__process_stat_event(const struct perf_tool *tool __maybe_unused,
 		return -EINVAL;
 	}
 	cpu_map_idx = perf_cpu_map__idx(evsel__cpus(counter), (struct perf_cpu){.cpu = st->cpu});
+	if (cpu_map_idx == -1 && (s32)st->cpu == -1 && counter->counts &&
+	    evsel__nr_cpus(counter) > 0) {
+		/*
+		 * Older perf tools wrote pmu_cpus instead of cpus in
+		 * PERF_EVENT_UPDATE__CPUS, leaving per-task counters with a
+		 * CPU list instead of the "any CPU" (-1) map used by their
+		 * PERF_RECORD_STAT events.
+		 */
+		struct perf_cpu_map *any_cpu = perf_cpu_map__new_any_cpu();
+
+		if (any_cpu) {
+			perf_cpu_map__put(counter->core.cpus);
+			counter->core.cpus = any_cpu;
+			counter->core.requires_cpu = false;
+			cpu_map_idx = 0;
+		}
+	}
 	if (cpu_map_idx == -1) {
 		pr_err("Invalid CPU %d for event %s.\n", st->cpu, evsel__name(counter));
 		return -EINVAL;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 3c8d29f27fd9..b87d15a5be6a 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2234,10 +2234,13 @@ int perf_event__synthesize_event_update_name(const struct perf_tool *tool, struc
 int perf_event__synthesize_event_update_cpus(const struct perf_tool *tool, struct evsel *evsel,
 					     perf_event__handler_t process)
 {
-	struct synthesize_cpu_map_data syn_data = { .map = evsel->core.pmu_cpus };
+	struct synthesize_cpu_map_data syn_data = { .map = evsel->core.cpus };
 	struct perf_record_event_update *ev;
 	int err;
 
+	if (!evsel->core.cpus)
+		return 0;
+
 	ev = cpu_map_data__alloc(&syn_data, sizeof(struct perf_event_header) + 2 * sizeof(u64));
 	if (!ev)
 		return -ENOMEM;
@@ -2315,7 +2318,7 @@ int perf_event__synthesize_extra_attr(const struct perf_tool *tool, struct evlis
 			}
 		}
 
-		if (evsel->core.pmu_cpus) {
+		if (evsel->core.cpus) {
 			err = perf_event__synthesize_event_update_cpus(tool, evsel, process);
 			if (err < 0) {
 				pr_err("Couldn't synthesize evsel cpus.\n");
-- 
2.56.1.750.gf70dc682cf-goog

