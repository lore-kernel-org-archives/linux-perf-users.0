Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946302580F2
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Oct 2025 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761411025; cv=none; b=fLsWR7VI7pYYC9V/+0l7EDuPNg1le6a23VmWNPfhwjqlaSkLmFgBf3kxaduWYYBSk0//LkGOaPrNZ8kc95BGy6EgTSN8LkZsJAaHp8bRDoV+Bo7GbuI6mV2+cA4LLppRRn0TSpF4xNd8TuyLBmBGnThjWzr4TSbI93y8Qz13YyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761411025; c=relaxed/simple;
	bh=vUX0wnR3ltklvYoGUreDdvADl4EBrcQf02nJyAaX7m0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=CeI0fYp7yatToJVyATtQeTbdO2HRN7g9b1bYfYpWPA3VJGTw5NXcTNHRyv98CDIX1iXJP0RcA4NKEihDqUbldptuGIHE9A/5i3eOS5rYGYEKnaB+SAi2pbsPTLyzKtzEO9pLlEnBujOhl0qcfYR2cd7s1Z4PBgn0QLSvP6PPzgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SafOhGIb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SafOhGIb"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28eb14e3cafso58768075ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Oct 2025 09:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761411023; x=1762015823; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PbGkxjOXGWrEgTp5QakCt0It50nbJEvjwnjbwD1ks4c=;
        b=SafOhGIb+rtbQejTpyfqwat+A22ARr17D3vJCrwhxB6ltFmcCOPM2r+TRsKCaQmORB
         shyTl1Np17qf5ol21Sx1Q+PTlpt3xhiEebdO6yNDNnthRql000OLXy8xJLU42EZA1hKJ
         ETUmfNNwCmgpm9HBXlsaAyDIvTz5Ld/l/KFUETTuXcs5/Px03Wv9+Tzkm0CHbAlZY32B
         STjbWI3mztTSxl0wxGmH1KR3XQShfqdZdFZyU4SvNlulET8QzdJ7w03XZRj6myWSbzmV
         19EVoHsW4aW4/PItRNv40GveU7+dcprnqH7xAhCO0xWH0OErSNIAuBgX1JGSpml0t4nu
         bwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761411023; x=1762015823;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PbGkxjOXGWrEgTp5QakCt0It50nbJEvjwnjbwD1ks4c=;
        b=hNynYceYUPmd/EiwtJE4VcquIuI9cPEQrOtR7svbXk3hbzepb5ezcjazpVdjCgU23z
         ox/OU1JeYpUvGuwhCvwx7XHKbcrcJnB/9PV6gfGRZrKn8qV9DLvHEi5CA2IG2GM+zi7/
         LRKYmz/Q6BsTMFJnwccOfDEMj492s7i9GiM/CdNQtNbb9YxR1/lpFqJWA0d07eTJS8yE
         yG8CyeaWh1Le+92UOZOeiiUQPTHXxkLmlkTMVW5eWoa8QHWlo4BbUdxCCXeFoCYebDWy
         shAEVShhOrOfJ7DBg07uBnsk21ROseHxz0je6mFZuSBl9G2CyW6YFHEeTwio5ggXe+8h
         GhZw==
X-Forwarded-Encrypted: i=1; AJvYcCU+PW5c6kfcye8emuglkEDYgRazN1VP56eSiGHVQTJygJQQBSrCILgdKATtwXtX6Ma42T3a4r0WfY+92oSGMyHG@vger.kernel.org
X-Gm-Message-State: AOJu0YxA9L3IVZ/ynQh1k18tMDSdKZ6gDO4HzOWqT0P53sjZe9MK0rfM
	UX20q052iENA5PoJGgY/DfiC07mT7dw/+AXZB/2DT/VCurACdbfrA5+aHneF6MejRbhpAi2v+kJ
	2aofRbAvhig==
X-Google-Smtp-Source: AGHT+IFsh9IbMsV3ZBy5lXdEkLrpnjU6Yx4V1KOWGFeRMyFC4jJXCj1hGL69/mC5cPdK+spLVhVRs6yi3QDl
X-Received: from pjbsb7.prod.google.com ([2002:a17:90b:50c7:b0:33b:51fe:1a94])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d482:b0:267:44e6:11d3
 with SMTP id d9443c01a7336-2948b9a162bmr89107795ad.21.1761411022891; Sat, 25
 Oct 2025 09:50:22 -0700 (PDT)
Date: Sat, 25 Oct 2025 09:50:19 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251025165019.1109315-1-irogers@google.com>
Subject: [PATCH v2] perf stat: Add/fix bperf cgroup max events workarounds
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit b8308511f6e0 bumped the max events to 1024 but this results in
BPF verifier issues if the number of command line events is too
large. Workaround this by:

1) moving the constants to a header file to share between BPF and perf
   C code,
2) testing that the maximum number of events doesn't cause BPF
   verifier issues in debug builds,
3) lower the max events from 1024 to 128,
4) in perf stat, if there are more events than the BPF counters can
   support then disable BPF counter usage.

The rodata setup is factored into its own function to avoid
duplicating it in the testing code.

Signed-off-by: Ian Rogers <irogers@google.com>
Fixes: b8308511f6e0 ("perf stat bperf cgroup: Increase MAX_EVENTS from 32 to 1024")
---
v2: Add missing header file
---
 tools/perf/builtin-stat.c                   | 13 +++-
 tools/perf/util/bpf_counter_cgroup.c        | 79 +++++++++++++++------
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c | 18 +++--
 tools/perf/util/bpf_skel/bperf_cgroup.h     | 15 ++++
 4 files changed, 91 insertions(+), 34 deletions(-)
 create mode 100644 tools/perf/util/bpf_skel/bperf_cgroup.h

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3c3188a57016..130515f87ee0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -96,6 +96,10 @@
 #include <perf/evlist.h>
 #include <internal/threadmap.h>
 
+#ifdef HAVE_BPF_SKEL
+#include "util/bpf_skel/bperf_cgroup.h"
+#endif
+
 #define DEFAULT_SEPARATOR	" "
 #define FREEZE_ON_SMI_PATH	"bus/event_source/devices/cpu/freeze_on_smi"
 
@@ -2852,7 +2856,14 @@ int cmd_stat(int argc, const char **argv)
 			goto out;
 		}
 	}
-
+#ifdef HAVE_BPF_SKEL
+	if (target.use_bpf &&
+	    (evsel_list->core.nr_entries / nr_cgroups) > BPERF_CGROUP__MAX_EVENTS) {
+		pr_warning("Disabling BPF counters due to more events (%d) than the max (%d)\n",
+			   evsel_list->core.nr_entries / nr_cgroups, BPERF_CGROUP__MAX_EVENTS);
+		target.use_bpf = false;
+	}
+#endif // HAVE_BPF_SKEL
 	evlist__warn_user_requested_cpus(evsel_list, target.cpu_list);
 
 	evlist__for_each_entry(evsel_list, counter) {
diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index 690be3ce3e11..68bd994c8880 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -27,6 +27,7 @@
 #include "cpumap.h"
 #include "thread_map.h"
 
+#include "bpf_skel/bperf_cgroup.h"
 #include "bpf_skel/bperf_cgroup.skel.h"
 
 static struct perf_event_attr cgrp_switch_attr = {
@@ -42,6 +43,55 @@ static struct bperf_cgroup_bpf *skel;
 
 #define FD(evt, cpu) (*(int *)xyarray__entry(evt->core.fd, cpu, 0))
 
+static void setup_rodata(struct bperf_cgroup_bpf *sk, int evlist_size)
+{
+	int map_size, total_cpus = cpu__max_cpu().cpu;
+
+	sk->rodata->num_cpus = total_cpus;
+	sk->rodata->num_events = evlist_size / nr_cgroups;
+
+	if (cgroup_is_v2("perf_event") > 0)
+		sk->rodata->use_cgroup_v2 = 1;
+
+	BUG_ON(evlist_size % nr_cgroups != 0);
+
+	/* we need one copy of events per cpu for reading */
+	map_size = total_cpus * evlist_size / nr_cgroups;
+	bpf_map__set_max_entries(sk->maps.events, map_size);
+	bpf_map__set_max_entries(sk->maps.cgrp_idx, nr_cgroups);
+	/* previous result is saved in a per-cpu array */
+	map_size = evlist_size / nr_cgroups;
+	bpf_map__set_max_entries(sk->maps.prev_readings, map_size);
+	/* cgroup result needs all events (per-cpu) */
+	map_size = evlist_size;
+	bpf_map__set_max_entries(sk->maps.cgrp_readings, map_size);
+}
+
+static void test_max_events_program_load(void)
+{
+#ifndef NDEBUG
+	/*
+	 * Test that the program verifies with the maximum number of events. If
+	 * this test fails unfortunately perf needs recompiling with a lower
+	 * BPERF_CGROUP__MAX_EVENTS to avoid BPF verifier issues.
+	 */
+	int err, max_events = BPERF_CGROUP__MAX_EVENTS * nr_cgroups;
+	struct bperf_cgroup_bpf *test_skel = bperf_cgroup_bpf__open();
+
+	if (!test_skel) {
+		pr_err("Failed to open cgroup skeleton\n");
+		return;
+	}
+	setup_rodata(test_skel, max_events);
+	err = bperf_cgroup_bpf__load(test_skel);
+	if (err) {
+		pr_err("Failed to load cgroup skeleton with max events %d.\n",
+			BPERF_CGROUP__MAX_EVENTS);
+	}
+	bperf_cgroup_bpf__destroy(test_skel);
+#endif
+}
+
 static int bperf_load_program(struct evlist *evlist)
 {
 	struct bpf_link *link;
@@ -50,35 +100,18 @@ static int bperf_load_program(struct evlist *evlist)
 	int i, j;
 	struct perf_cpu cpu;
 	int total_cpus = cpu__max_cpu().cpu;
-	int map_size, map_fd;
-	int prog_fd, err;
+	int map_fd, prog_fd, err;
+
+	set_max_rlimit();
+
+	test_max_events_program_load();
 
 	skel = bperf_cgroup_bpf__open();
 	if (!skel) {
 		pr_err("Failed to open cgroup skeleton\n");
 		return -1;
 	}
-
-	skel->rodata->num_cpus = total_cpus;
-	skel->rodata->num_events = evlist->core.nr_entries / nr_cgroups;
-
-	if (cgroup_is_v2("perf_event") > 0)
-		skel->rodata->use_cgroup_v2 = 1;
-
-	BUG_ON(evlist->core.nr_entries % nr_cgroups != 0);
-
-	/* we need one copy of events per cpu for reading */
-	map_size = total_cpus * evlist->core.nr_entries / nr_cgroups;
-	bpf_map__set_max_entries(skel->maps.events, map_size);
-	bpf_map__set_max_entries(skel->maps.cgrp_idx, nr_cgroups);
-	/* previous result is saved in a per-cpu array */
-	map_size = evlist->core.nr_entries / nr_cgroups;
-	bpf_map__set_max_entries(skel->maps.prev_readings, map_size);
-	/* cgroup result needs all events (per-cpu) */
-	map_size = evlist->core.nr_entries;
-	bpf_map__set_max_entries(skel->maps.cgrp_readings, map_size);
-
-	set_max_rlimit();
+	setup_rodata(skel, evlist->core.nr_entries);
 
 	err = bperf_cgroup_bpf__load(skel);
 	if (err) {
diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
index 18ab4d9b49ff..c2298a2decc9 100644
--- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
@@ -1,14 +1,12 @@
 // SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 // Copyright (c) 2021 Facebook
 // Copyright (c) 2021 Google
+#include "bperf_cgroup.h"
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
 
-#define MAX_LEVELS  10  // max cgroup hierarchy level: arbitrary
-#define MAX_EVENTS  1024  // max events per cgroup: arbitrary
-
 // NOTE: many of map and global data will be modified before loading
 //       from the userspace (perf tool) using the skeleton helpers.
 
@@ -97,7 +95,7 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
 	cgrp = BPF_CORE_READ(p, cgroups, subsys[perf_subsys_id], cgroup);
 	level = BPF_CORE_READ(cgrp, level);
 
-	for (cnt = 0; i < MAX_LEVELS; i++) {
+	for (cnt = 0; i < BPERF_CGROUP__MAX_LEVELS; i++) {
 		__u64 cgrp_id;
 
 		if (i > level)
@@ -123,7 +121,7 @@ static inline int get_cgroup_v2_idx(__u32 *cgrps, int size)
 	__u32 *elem;
 	int cnt;
 
-	for (cnt = 0; i < MAX_LEVELS; i++) {
+	for (cnt = 0; i < BPERF_CGROUP__MAX_LEVELS; i++) {
 		__u64 cgrp_id = bpf_get_current_ancestor_cgroup_id(i);
 
 		if (cgrp_id == 0)
@@ -148,17 +146,17 @@ static int bperf_cgroup_count(void)
 	register int c = 0;
 	struct bpf_perf_event_value val, delta, *prev_val, *cgrp_val;
 	__u32 cpu = bpf_get_smp_processor_id();
-	__u32 cgrp_idx[MAX_LEVELS];
+	__u32 cgrp_idx[BPERF_CGROUP__MAX_LEVELS];
 	int cgrp_cnt;
 	__u32 key, cgrp;
 	long err;
 
 	if (use_cgroup_v2)
-		cgrp_cnt = get_cgroup_v2_idx(cgrp_idx, MAX_LEVELS);
+		cgrp_cnt = get_cgroup_v2_idx(cgrp_idx, BPERF_CGROUP__MAX_LEVELS);
 	else
-		cgrp_cnt = get_cgroup_v1_idx(cgrp_idx, MAX_LEVELS);
+		cgrp_cnt = get_cgroup_v1_idx(cgrp_idx, BPERF_CGROUP__MAX_LEVELS);
 
-	for ( ; idx < MAX_EVENTS; idx++) {
+	for ( ; idx < BPERF_CGROUP__MAX_EVENTS; idx++) {
 		if (idx == num_events)
 			break;
 
@@ -186,7 +184,7 @@ static int bperf_cgroup_count(void)
 			delta.enabled = val.enabled - prev_val->enabled;
 			delta.running = val.running - prev_val->running;
 
-			for (c = 0; c < MAX_LEVELS; c++) {
+			for (c = 0; c < BPERF_CGROUP__MAX_LEVELS; c++) {
 				if (c == cgrp_cnt)
 					break;
 
diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.h b/tools/perf/util/bpf_skel/bperf_cgroup.h
new file mode 100644
index 000000000000..3fb84b19d39a
--- /dev/null
+++ b/tools/perf/util/bpf_skel/bperf_cgroup.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Data structures shared between BPF and tools. */
+#ifndef __BPERF_CGROUP_H
+#define __BPERF_CGROUP_H
+
+// These constants impact code size of bperf_cgroup.bpf.c that may result in BPF
+// verifier issues. They are exposed to control the size and also to disable BPF
+// counters when the number of user events is too large.
+
+// max cgroup hierarchy level: arbitrary
+#define BPERF_CGROUP__MAX_LEVELS  10
+// max events per cgroup: arbitrary
+#define BPERF_CGROUP__MAX_EVENTS  128
+
+#endif /* __BPERF_CGROUP_H */
-- 
2.51.1.821.gb6fe4d2222-goog

