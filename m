Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599642;
	b=NX2LRn+xX/Q1h0Es+Px7w2iOm9IHH7OOKrpX0JhQchOwxIqkTpre0PD64pROXXKQ1EAh
	 hHCi/vSv2333ZMWLPpIeQHpEYDHaZxTxkyPrR2a8f1ALDdHietx6rmVplQIjkvCzebBei
	 Ht0MLgFOLU3BRi7OpKiSfqCFoi3HDzo5nEZy5NFKVa/jVFMGtZMfe9la1ZMxJSg0/tXjE
	 bh9j1lpvGvp5l+ezK8sn09dHqDm2nCe17q8eps7HIR7X5wY9OviN1f+fVzYguLevNBLda
	 Dat/05PupcoIWv8OKj59ZsfjDyC/DRhiytJtFEnfSgHtkEgEL9QJv0KLsXycydKHQNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=4M1NJxWrif9huLxFGkR+npQdyRLiySSnIKhnenQdwmQ=;
	b=l6pGjxO2VZS2FW5/cSG06Ub6ApouTDC2BIobAp3B1lTvwx/r05/ic2TEQcjySN5U9slB
	 dp0tpu3cAiU6mlEOx+8zCCY3iKq4a8/SGdlFCytfjjUDnUwwWfc2I5u5fy94/gd/NERHd
	 KDDEut9s/tXjf+dExTumXwf1PdECETpaKs743pWf8pT5z/Q3mT8OTRtqGa/DcYajss2Ha
	 B/xw4P53OLxuEmwhmIyZs/SxhymLo+4iZ9CxKTTZkp9/GtsEujQNLOjn/6Etx6WcS+0Tu
	 ahtxJv4Pgp6+tTyKXNDhE7nSe/JxlXnDwhO82nDvaGCDayKAd5Iy25rt5o/LcKY29wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n7geHiYH;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E809A60A380E
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E809A60A380E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=n7geHiYH
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36fa5673fccso2859397eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599640; x=1795204440; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4M1NJxWrif9huLxFGkR+npQdyRLiySSnIKhnenQdwmQ=;
        b=n7geHiYHJRujaYfGCudERZx3RDH3LON8zxtmUE7PmVgYQQtZz1NTneRNp+RcIlycXx
         wHNF7dybFsCTgintV9RG1B192tRIZSb9yqCP8bh4qGMQ/JpzsuDUbgZ6CwlUNaWV1TrO
         U/vmddGErbKX7Kbd9NIhvG5zVvtiOFs3PTo5HUQtvuDp7hnRtKUfu6qIXPtQn9dQK49s
         UECtp5L41SynDSbGmjzEV3N9kM9pJflhCrUAN44i1o+MajjloF9tDjAt4Hvy54kMkCk9
         Qb3qgUPRsolDdtYPAPBcB2lRI7xMbvqM44el3oRgMl9pKpLKWKDc/k4UwslkppBu7uU3
         FF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599640; x=1795204440;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4M1NJxWrif9huLxFGkR+npQdyRLiySSnIKhnenQdwmQ=;
        b=bieUGCyZ00nArHXxgtm7vNCKO7dCtRSzpvFZZT6nYqkycoYyL4i3mOB7WTQ0OJLQ3m
         XPTsUMQdq61QK/eiZwwcqAK4ol/6n2+NlB5Sx1CEKH5faSRZXWHZM92VObO3BnTqSPMR
         W6Ei/QMZuiBd2dw6NsPdePAv3N51vhGByAEQaNjFVGbg0VhIXZiapaZk1j80Ivd1mUYE
         oJr3J/z4f0z7mKva632LqXEIQ87waRx2DtD+ZEbDOvfHB4wuMk9Jou3kvwYpiuVCazBn
         80GO256Wyl7U62iJxP0HSto+24IYIJagEQPH5ugnjmKjfKnPC1EkHzgKf5wYZnTY5kKh
         C5LQ==
X-Gm-Message-State: APuU4Z/ilJY8A2HLJlJRX9lzNtIcbm/vAfJVShyKlvYvIhZLMXyiI9Uh
	vpTFxOxnGujL++JzuiywQpySGCcWWyoDMDKbC3rsXnojTJonsYCD9l6xY19cmeRjg1SYkgRnQI7
	CeSqtM327aA==
X-Received: from dykp42.prod.google.com ([2002:a05:7300:caa:b0:36a:209:2e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:d192:b0:369:1084:8ee3
 with SMTP id 5a478bee46e88-37966e3a6eamr2444007eec.23.1794599639185; Fri, 13
 Nov 2026 11:53:59 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:13 -0800
In-Reply-To: <20261113195335.2865725-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195335.2865725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195335.2865725-9-irogers@google.com>
Subject: [PATCH v2 08/30] perf pmus: Introduce struct perf_pmus and perf_env__pmus()
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move the static global core_pmus, other_pmus, read_pmu_types,
num_core_pmus, and extended_type state from pmus.c into a new
struct perf_pmus embedded in struct perf_env and accessed via
perf_env__pmus().

Rename perf_pmus__destroy() to perf_pmus__exit() to match the
perf_env__init()/perf_env__exit() naming convention, and update it
along with perf_pmus__find_by_attr(), perf_pmus__scan_for_event(),
perf_pmus__scan_matching_wildcard(), perf_pmus__scan_for_uncore_id(),
perf_pmus__pmu_for_pmu_filter(), perf_pmus__print_pmu_events(),
perf_pmus__print_raw_pmu_events(), perf_pmus__have_event(),
perf_pmus__num_core_pmus(), perf_pmus__supports_extended_type(),
perf_pmus__add_test_pmu(), and perf_pmus__add_test_hwmon_pmu() to take
struct perf_pmus *.

To keep this commit reviewable, the high-fanout perf_pmus__find(),
perf_pmus__find_by_type(), perf_pmus__find_core_pmu(),
perf_pmus__scan(), and perf_pmus__scan_core() helpers are updated to
take struct perf_pmus * in the next two commits.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/hybrid.c            |   3 +-
 tools/perf/bench/pmu-scan.c                   |   7 +-
 tools/perf/builtin-list.c                     |  19 +-
 tools/perf/builtin-record.c                   |   2 +-
 tools/perf/builtin-stat.c                     |   2 +-
 tools/perf/tests/hwmon_pmu.c                  |   4 +-
 tools/perf/tests/mmap-basic.c                 |   4 +-
 tools/perf/tests/parse-events.c               |  15 +-
 tools/perf/tests/pmu.c                        |   3 +-
 tools/perf/util/cputopo.c                     |   3 +-
 tools/perf/util/env.c                         |  12 +-
 tools/perf/util/env.h                         |  10 +
 tools/perf/util/evlist.c                      |  13 +-
 tools/perf/util/evlist.h                      |   2 +
 tools/perf/util/evsel.c                       |  14 +-
 .../util/kvm-stat-arch/kvm-stat-powerpc.c     |   3 +-
 tools/perf/util/metricgroup.c                 |   6 +-
 tools/perf/util/parse-events.c                |  44 ++-
 tools/perf/util/parse-events.h                |   3 +
 .../perf/util/perf-regs-arch/perf_regs_x86.c  |   7 +-
 tools/perf/util/pmu.c                         |   9 +-
 tools/perf/util/pmu.h                         |   3 +
 tools/perf/util/pmus.c                        | 343 +++++++++++-------
 tools/perf/util/pmus.h                        | 205 ++++++++++-
 tools/perf/util/print-events.c                |   7 +-
 tools/perf/util/session.c                     |  11 +
 tools/perf/util/stat-display.c                |   4 +-
 tools/perf/util/stat-shadow.c                 |   3 +-
 28 files changed, 560 insertions(+), 201 deletions(-)

diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests/hybrid.c
index 0477e17b8e53..011217998a3e 100644
--- a/tools/perf/arch/x86/tests/hybrid.c
+++ b/tools/perf/arch/x86/tests/hybrid.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "arch-tests.h"
 #include "debug.h"
+#include "env.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "pmu.h"
@@ -303,7 +304,7 @@ static int test_events(const struct evlist_test *events, int cnt)
 
 int test__hybrid(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
-	if (perf_pmus__num_core_pmus() == 1)
+	if (perf_pmus__num_core_pmus(perf_env__pmus(host_env())) == 1)
 		return TEST_SKIP;
 
 	return test_events(test__hybrid_events, ARRAY_SIZE(test__hybrid_events));
diff --git a/tools/perf/bench/pmu-scan.c b/tools/perf/bench/pmu-scan.c
index 14a464ad8cea..1d7dd4b203e0 100644
--- a/tools/perf/bench/pmu-scan.c
+++ b/tools/perf/bench/pmu-scan.c
@@ -8,6 +8,7 @@
 #include <stdio.h>
 #include "bench.h"
 #include "util/debug.h"
+#include "util/env.h"
 #include "util/pmu.h"
 #include "util/pmus.h"
 #include "util/stat.h"
@@ -42,6 +43,7 @@ static struct pmu_scan_result *results;
 
 static int save_result(void)
 {
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	struct perf_pmu *pmu = NULL;
 	struct list_head *list;
 	struct pmu_scan_result *r;
@@ -69,7 +71,7 @@ static int save_result(void)
 		nr_pmus++;
 	}
 
-	perf_pmus__destroy();
+	perf_pmus__exit(pmus);
 	return 0;
 }
 
@@ -128,6 +130,7 @@ static void delete_result(void)
 
 static int run_pmu_scan(void)
 {
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	struct stats stats;
 	struct timeval start, end, diff;
 	double time_average, time_stddev;
@@ -158,7 +161,7 @@ static int run_pmu_scan(void)
 			update_stats(&stats, runtime_us);
 
 			ret = check_result(core_only);
-			perf_pmus__destroy();
+			perf_pmus__exit(pmus);
 			if (ret < 0)
 				break;
 		}
diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 47668d66c395..573d13baa7fd 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -11,6 +11,7 @@
 #include "builtin.h"
 
 #include "util/print-events.h"
+#include "util/env.h"
 #include "util/pmus.h"
 #include "util/pmu.h"
 #include "util/debug.h"
@@ -567,6 +568,7 @@ static int list__tui(int argc, const char **argv)
 
 int cmd_list(int argc, const char **argv)
 {
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	int i, ret = 0;
 	struct print_state default_ps = {
 		.fp = stdout,
@@ -660,7 +662,8 @@ int cmd_list(int argc, const char **argv)
 		if (unit_name)
 			ps->pmu_glob = strdup(unit_name);
 		else if (cputype) {
-			const struct perf_pmu *pmu = perf_pmus__pmu_for_pmu_filter(cputype);
+			const struct perf_pmu *pmu =
+				perf_pmus__pmu_for_pmu_filter(pmus, cputype);
 
 			if (!pmu) {
 				pr_err("ERROR: cputype is not supported!\n");
@@ -692,7 +695,7 @@ int cmd_list(int argc, const char **argv)
 				ret = -1;
 				goto out;
 			}
-			perf_pmus__print_pmu_events(&print_cb, ps);
+			perf_pmus__print_pmu_events(pmus, &print_cb, ps);
 			zfree(&default_ps.pmu_glob);
 			default_ps.pmu_glob = old_pmu_glob;
 		} else if (strcmp(argv[i], "hw") == 0 ||
@@ -704,7 +707,7 @@ int cmd_list(int argc, const char **argv)
 				ret = -1;
 				goto out;
 			}
-			perf_pmus__print_pmu_events(&print_cb, ps);
+			perf_pmus__print_pmu_events(pmus, &print_cb, ps);
 			zfree(&ps->event_glob);
 			ps->event_glob = old_event_glob;
 		} else if (strcmp(argv[i], "sw") == 0 ||
@@ -718,7 +721,7 @@ int cmd_list(int argc, const char **argv)
 					ret = -1;
 					goto out;
 				}
-				perf_pmus__print_pmu_events(&print_cb, ps);
+				perf_pmus__print_pmu_events(pmus, &print_cb, ps);
 				zfree(&ps->pmu_glob);
 			}
 			ps->pmu_glob = old_pmu_glob;
@@ -731,12 +734,12 @@ int cmd_list(int argc, const char **argv)
 				ret = -1;
 				goto out;
 			}
-			perf_pmus__print_pmu_events(&print_cb, ps);
+			perf_pmus__print_pmu_events(pmus, &print_cb, ps);
 			zfree(&ps->event_glob);
 			ps->event_glob = old_event_glob;
 		} else if (strcmp(argv[i], "pmu") == 0) {
 			ps->exclude_abi = true;
-			perf_pmus__print_pmu_events(&print_cb, ps);
+			perf_pmus__print_pmu_events(pmus, &print_cb, ps);
 			ps->exclude_abi = false;
 		} else if (strcmp(argv[i], "sdt") == 0)
 			print_sdt_events(&print_cb, ps);
@@ -770,7 +773,7 @@ int cmd_list(int argc, const char **argv)
 				ret = -1;
 				goto out;
 			}
-			perf_pmus__print_pmu_events(&print_cb, ps);
+			perf_pmus__print_pmu_events(pmus, &print_cb, ps);
 			zfree(&ps->pmu_glob);
 			ps->pmu_glob = old_pmu_glob;
 			print_sdt_events(&print_cb, ps);
@@ -785,7 +788,7 @@ int cmd_list(int argc, const char **argv)
 				continue;
 			}
 			ps->event_glob = s;
-			perf_pmus__print_pmu_events(&print_cb, ps);
+			perf_pmus__print_pmu_events(pmus, &print_cb, ps);
 			print_sdt_events(&print_cb, ps);
 			ps->metrics = true;
 			ps->metricgroups = true;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ad81458989b5..7de04919d194 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -936,7 +936,7 @@ static int record__config_tracking_events(struct record *rec)
 	 * delay of waiting or event synthesis.
 	 */
 	if (opts->target.initial_delay || target__has_cpu(&opts->target) ||
-	    perf_pmus__num_core_pmus() > 1) {
+	    perf_pmus__num_core_pmus(perf_env__pmus(host_env())) > 1) {
 		/*
 		 * User space tasks can migrate between CPUs, so when tracing
 		 * selected CPUs, sideband for all CPUs is still needed.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 37752d6bfef4..8706798290eb 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1209,7 +1209,7 @@ static int parse_cputype(const struct option *opt,
 		return -1;
 	}
 
-	pmu = perf_pmus__pmu_for_pmu_filter(str);
+	pmu = perf_pmus__pmu_for_pmu_filter(perf_env__pmus(host_env()), str);
 	if (!pmu) {
 		fprintf(stderr, "--cputype %s is not supported!\n", str);
 		return -1;
diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
index e26b3fe3fab1..8f3d09d3f2a1 100644
--- a/tools/perf/tests/hwmon_pmu.c
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -11,6 +11,7 @@
 #include <sys/stat.h>
 
 #include "debug.h"
+#include "env.h"
 #include "evlist.h"
 #include "parse-events.h"
 #include "pmus.h"
@@ -137,7 +138,8 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
 	}
 
 	/* Make the PMU reading the files created above. */
-	hwm = perf_pmus__add_test_hwmon_pmu(dir, "hwmon1234", test_hwmon_name);
+	hwm = perf_pmus__add_test_hwmon_pmu(perf_env__pmus(host_env()),
+					    dir, "hwmon1234", test_hwmon_name);
 	if (!hwm)
 		pr_err("Test hwmon creation failed\n");
 
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 602a78d48b10..dada4af5fb68 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -17,6 +17,7 @@
 
 #include "cpumap.h"
 #include "debug.h"
+#include "env.h"
 #include "event.h"
 #include "evlist.h"
 #include "evsel.h"
@@ -264,6 +265,7 @@ static enum user_read_state set_user_read(struct perf_pmu *pmu,
 
 static int test_stat_user_read(u64 event, enum user_read_state enabled)
 {
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	struct perf_pmu *pmu = NULL;
 	struct perf_thread_map *threads = perf_thread_map__new_dummy();
 	int ret = TEST_OK;
@@ -279,7 +281,7 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
 		enum user_read_state saved_user_read_state = set_user_read(pmu, enabled);
 		struct perf_event_attr attr = {
 			.type	= PERF_TYPE_HARDWARE,
-			.config	= perf_pmus__supports_extended_type()
+			.config	= perf_pmus__supports_extended_type(pmus)
 			? event | ((u64)pmu->type << PERF_PMU_TYPE_SHIFT)
 				: event,
 		};
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 5f6f95c8a5b4..8969bcf004ea 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "parse-events.h"
+#include "env.h"
 #include "evsel.h"
 #include "evsel_fprintf.h"
 #include "evlist.h"
@@ -68,7 +69,7 @@ static int num_core_entries(struct evlist *evlist)
 		if (!evsel->pmu->is_core)
 			continue;
 		if (core_pmu != evsel->pmu && core_pmu != NULL)
-			return perf_pmus__num_core_pmus();
+			return perf_pmus__num_core_pmus(perf_env__pmus(host_env()));
 		core_pmu = evsel->pmu;
 	}
 	return 1;
@@ -1022,7 +1023,8 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	struct evsel *evsel, *group1_leader = NULL, *group2_leader = NULL;
 
 	TEST_ASSERT_EVLIST("wrong number of entries",
-			   evlist__nr_entries(evlist) == (3 * perf_pmus__num_core_pmus() + 2),
+			   evlist__nr_entries(evlist) ==
+			   (3 * perf_pmus__num_core_pmus(perf_env__pmus(host_env())) + 2),
 			   evlist);
 	/*
 	 * Currently the software event won't be grouped with the hardware event
@@ -1582,6 +1584,7 @@ static int test__checkevent_pinned_modifier(struct evlist *evlist)
 
 static int test__pinned_group(struct evlist *evlist)
 {
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	struct evsel *evsel = NULL, *leader;
 
 	TEST_ASSERT_EVLIST("wrong number of entries",
@@ -1597,7 +1600,7 @@ static int test__pinned_group(struct evlist *evlist)
 		TEST_ASSERT_EVSEL("wrong group name", !evsel->group_name, evsel);
 		TEST_ASSERT_EVSEL("wrong leader", evsel__has_leader(evsel, leader), evsel);
 		/* TODO: The group modifier is not copied to the split group leader. */
-		if (perf_pmus__num_core_pmus() == 1)
+		if (perf_pmus__num_core_pmus(pmus) == 1)
 			TEST_ASSERT_EVSEL("wrong pinned", evsel->core.attr.pinned, evsel);
 
 		/* cache-misses - can not be pinned, but will go on with the leader */
@@ -1635,6 +1638,7 @@ static int test__checkevent_exclusive_modifier(struct evlist *evlist)
 
 static int test__exclusive_group(struct evlist *evlist)
 {
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	struct evsel *evsel = NULL, *leader;
 
 	TEST_ASSERT_EVLIST("wrong number of entries",
@@ -1650,7 +1654,7 @@ static int test__exclusive_group(struct evlist *evlist)
 		TEST_ASSERT_EVSEL("wrong group name", !evsel->group_name, evsel);
 		TEST_ASSERT_EVSEL("wrong leader", evsel__has_leader(evsel, leader), evsel);
 		/* TODO: The group modifier is not copied to the split group leader. */
-		if (perf_pmus__num_core_pmus() == 1)
+		if (perf_pmus__num_core_pmus(pmus) == 1)
 			TEST_ASSERT_EVSEL("wrong exclusive", evsel->core.attr.exclusive, evsel);
 
 		/* cache-misses - can not be pinned, but will go on with the leader */
@@ -1803,7 +1807,8 @@ static int test__ratio_to_prev(struct evlist *evlist)
 	struct evsel *evsel, *leader;
 
 	TEST_ASSERT_VAL("wrong number of entries",
-			2 * perf_pmus__num_core_pmus() == evlist__nr_entries(evlist));
+			2 * perf_pmus__num_core_pmus(perf_env__pmus(host_env())) ==
+			evlist__nr_entries(evlist));
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel != evsel__leader(evsel) ||
diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index f208932590df..fc731857ec71 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "evlist.h"
+#include "env.h"
 #include "evsel.h"
 #include "parse-events.h"
 #include "pmu.h"
@@ -143,7 +144,7 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
 	close(file);
 
 	/* Make the PMU reading the files created above. */
-	pmu = perf_pmus__add_test_pmu(dirfd, "perf-pmu-test");
+	pmu = perf_pmus__add_test_pmu(perf_env__pmus(host_env()), dirfd, "perf-pmu-test");
 	if (!pmu)
 		pr_err("Test PMU creation failed\n");
 
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index e0091804fe98..04ab4d010149 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -470,9 +470,10 @@ static int load_hybrid_node(struct hybrid_topology_node *node,
 
 struct hybrid_topology *hybrid_topology__new(void)
 {
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	struct perf_pmu *pmu = NULL;
 	struct hybrid_topology *tp = NULL;
-	int nr = perf_pmus__num_core_pmus(), i = 0;
+	int nr = perf_pmus__num_core_pmus(pmus), i = 0;
 
 	if (nr <= 1)
 		return NULL;
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 1fe6ce84e607..5f16920f0a89 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -261,6 +261,7 @@ static struct perf_env __host_env = {
 	},
 	.kernel_is_64_bit = -1,
 	.lock = { .lock = __PERF_MUTEX_INITIALIZER },
+	.pmus = PERF_PMUS_INIT(__host_env.pmus),
 };
 
 void perf_env__exit(struct perf_env *env)
@@ -316,6 +317,8 @@ void perf_env__exit(struct perf_env *env)
 	zfree(&env->pmu_caps);
 	zfree(&env->memory_ranges);
 	free_cpu_domain_info(env->cpu_domain, env->schedstat_version, env->nr_cpus_avail);
+	perf_pmus__exit(&env->pmus);
+	mutex_destroy(&env->pmus.lock);
 }
 
 void perf_env__init(struct perf_env *env)
@@ -328,6 +331,7 @@ void perf_env__init(struct perf_env *env)
 #endif
 	env->kernel_is_64_bit = -1;
 	mutex_init(&env->lock);
+	perf_pmus__init(&env->pmus);
 }
 
 struct perf_env *host_env(void)
@@ -335,6 +339,11 @@ struct perf_env *host_env(void)
 	return &__host_env;
 }
 
+struct perf_pmus *perf_env__pmus(struct perf_env *env)
+{
+	return &env->pmus;
+}
+
 static const char *uts_machine(void)
 {
 	static struct utsname uts;
@@ -595,12 +604,13 @@ static int __perf_env__read_core_pmu_caps(const struct perf_pmu *pmu,
 
 int perf_env__read_core_pmu_caps(struct perf_env *env)
 {
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	struct pmu_caps *pmu_caps;
 	struct perf_pmu *pmu = NULL;
 	int nr_pmu, i = 0, j;
 	int ret;
 
-	nr_pmu = perf_pmus__num_core_pmus();
+	nr_pmu = perf_pmus__num_core_pmus(pmus);
 
 	if (!nr_pmu)
 		return -ENODEV;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 134102148a5c..e38e953060c9 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/rbtree.h>
 #include "cpumap.h"
+#include "pmus.h"
 #include "rwsem.h"
 #include "mutex.h"
 
@@ -169,6 +170,7 @@ struct perf_env {
 	} clock;
 	/* Protects lazy environment initialization (e.g. os_release, e_machine). */
 	struct mutex		lock;
+	struct perf_pmus	pmus;
 };
 
 enum perf_compress_type {
@@ -231,6 +233,14 @@ void perf_env__init(struct perf_env *env);
  * Return: Pointer to the live host's struct perf_env.
  */
 struct perf_env *host_env(void);
+
+/**
+ * perf_env__pmus() - Return the struct perf_pmus associated with @env.
+ * @env: Environment whose PMU collection to retrieve.
+ *
+ * Return: Pointer to the struct perf_pmus for @env.
+ */
+struct perf_pmus *perf_env__pmus(struct perf_env *env);
 #ifdef HAVE_LIBBPF_SUPPORT
 bool __perf_env__insert_bpf_prog_info(struct perf_env *env,
 				      struct bpf_prog_info_node *info_node);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c2402e4791b6..4e641ccc176f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -64,6 +64,7 @@
 #include "pmus.h"
 #include "record.h"
 #include "sample.h"
+#include "session.h"
 #include "stat.h"
 #include "strbuf.h"
 #include "string2.h"
@@ -2941,11 +2942,14 @@ static bool evlist__disable_uniquify(struct evlist *evlist)
 			return false;
 		first = false;
 		if (counter->pmu) {
+			struct perf_pmus *pmus =
+				counter->pmu->pmus ?: perf_env__pmus(host_env());
+
 			/* Allow uniquify for uncore PMUs. */
 			if (!counter->pmu->is_core)
 				return false;
 			/* Keep hybrid event names uniquified for clarity. */
-			if (perf_pmus__num_core_pmus() > 1)
+			if (perf_pmus__num_core_pmus(pmus) > 1)
 				return false;
 		}
 		last_pmu = counter->pmu;
@@ -3006,3 +3010,10 @@ bool evlist__needs_bpf_sb_event(struct evlist *evlist)
 
 	return false;
 }
+
+struct perf_env *evlist__env(struct evlist *evlist)
+{
+	struct perf_session *session = evlist ? evlist__session(evlist) : NULL;
+
+	return session ? perf_session__env(session) : NULL;
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 0f380421e03d..fc32979e08b8 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -23,6 +23,7 @@
 #include "rblist.h"
 
 struct perf_cpu_map;
+struct perf_env;
 struct perf_stat_config;
 struct pollfd;
 struct record_opts;
@@ -684,5 +685,6 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
 void evlist__uniquify_evsel_names(struct evlist *evlist, const struct perf_stat_config *config);
 bool evlist__has_bpf_output(struct evlist *evlist);
 bool evlist__needs_bpf_sb_event(struct evlist *evlist);
+struct perf_env *evlist__env(struct evlist *evlist);
 
 #endif /* __PERF_EVLIST_H */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6d69f63b7fb1..2fa8a0036375 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2290,9 +2290,12 @@ bool __evsel__match(const struct evsel *evsel, u32 type, u64 config)
 		return true;
 	if (type != PERF_TYPE_HARDWARE && type != PERF_TYPE_HW_CACHE)
 		return false;
-	if ((e_type == PERF_TYPE_HARDWARE || e_type == PERF_TYPE_HW_CACHE) &&
-		perf_pmus__supports_extended_type())
-		e_config &= PERF_HW_EVENT_MASK;
+	if (e_type == PERF_TYPE_HARDWARE || e_type == PERF_TYPE_HW_CACHE) {
+		struct perf_env *env = evsel__env((struct evsel *)evsel) ?: host_env();
+
+		if (perf_pmus__supports_extended_type(perf_env__pmus(env)))
+			e_config &= PERF_HW_EVENT_MASK;
+	}
 	if (e_type == type && e_config == config)
 		return true;
 	if (type == PERF_TYPE_HARDWARE && evsel->pmu && evsel->pmu->is_core &&
@@ -4779,10 +4782,13 @@ void evsel__zero_per_pkg(struct evsel *evsel)
  */
 bool evsel__is_hybrid(const struct evsel *evsel)
 {
+	struct perf_env *env;
+
 	if (!evsel->core.is_pmu_core)
 		return false;
 
-	return perf_pmus__num_core_pmus() > 1;
+	env = evsel__env((struct evsel *)evsel) ?: host_env();
+	return perf_pmus__num_core_pmus(perf_env__pmus(env)) > 1;
 }
 
 struct evsel *evsel__leader(const struct evsel *evsel)
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c b/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
index 315b24f9a592..d3435174106b 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
@@ -3,6 +3,7 @@
 #include "../kvm-stat.h"
 #include "../parse-events.h"
 #include "../debug.h"
+#include "../env.h"
 #include "../evsel.h"
 #include "../evlist.h"
 #include "../pmus.h"
@@ -178,7 +179,7 @@ int __kvm_add_default_arch_event_powerpc(int *argc, const char **argv)
 {
 	int j = *argc;
 
-	if (!perf_pmus__have_event("trace_imc", "trace_cycles"))
+	if (!perf_pmus__have_event(perf_env__pmus(host_env()), "trace_imc", "trace_cycles"))
 		return -EINVAL;
 
 	argv[j++] = "-e";
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 98f3ba8f9533..63aa326944d7 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -297,8 +297,10 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 	const char *metric_id;
 	struct evsel *ev;
 	size_t ids_size, matched_events, i;
+	struct perf_pmus *pmus = perf_env__pmus(evlist__env(metric_evlist) ?: host_env());
 	bool all_pmus = !strcmp(pmu, "all") || !strcmp(pmu, "default_core") ||
-			perf_pmus__num_core_pmus() == 1 || !is_pmu_core(pmu);
+			perf_pmus__num_core_pmus(pmus) == 1 ||
+			!is_pmu_core(pmu);
 
 	*out_metric_events = NULL;
 	ids_size = hashmap__size(ids);
@@ -419,7 +421,7 @@ static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
 		return 0;
 
 	/* Only process with the iterator if there is a a PMU that matches the ID. */
-	pmu = perf_pmus__scan_for_uncore_id(pmu, pm->compat);
+	pmu = perf_pmus__scan_for_uncore_id(perf_env__pmus(host_env()), pmu, pm->compat);
 	return pmu ? d->fn(pm, table, d->data) : 0;
 }
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 5ca6b93d8a2a..b56f0e2d1542 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -174,7 +174,8 @@ static struct evsel *
 __add_event(struct list_head *list, int *idx,
 	    struct perf_event_attr *attr,
 	    bool init_attr,
-	    const char *name, const char *metric_id, struct perf_pmu *pmu,
+	    const char *name, const char *metric_id,
+	    struct perf_pmus *pmus, struct perf_pmu *pmu,
 	    struct list_head *config_terms, struct evsel *first_wildcard_match,
 	    struct perf_cpu_map *user_cpus, u64 alternate_hw_config)
 {
@@ -224,7 +225,7 @@ __add_event(struct list_head *list, int *idx,
 	 * warnings won't be generated.
 	 */
 	if (!pmu)
-		pmu = perf_pmus__find_by_attr(attr);
+		pmu = perf_pmus__find_by_attr(pmus, attr);
 
 	if (pmu) {
 		is_pmu_core = pmu->is_core;
@@ -298,19 +299,21 @@ struct evsel *parse_events__add_event(int idx, struct perf_event_attr *attr,
 				      const char *name, const char *metric_id,
 				      struct perf_pmu *pmu)
 {
+	struct perf_pmus *pmus = pmu && pmu->pmus ? pmu->pmus : perf_env__pmus(host_env());
+
 	return __add_event(/*list=*/NULL, &idx, attr, /*init_attr=*/false, name,
-			   metric_id, pmu, /*config_terms=*/NULL,
+			   metric_id, pmus, pmu, /*config_terms=*/NULL,
 			   /*first_wildcard_match=*/NULL, /*cpu_list=*/NULL,
 			   /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
 }
 
-static int add_event(struct list_head *list, int *idx,
+static int add_event(struct list_head *list, struct parse_events_state *parse_state,
 		     struct perf_event_attr *attr, const char *name,
 		     const char *metric_id, struct list_head *config_terms,
 		     u64 alternate_hw_config)
 {
-	return __add_event(list, idx, attr, /*init_attr*/true, name, metric_id,
-			   /*pmu=*/NULL, config_terms,
+	return __add_event(list, &parse_state->idx, attr, /*init_attr*/true, name, metric_id,
+			   parse_state->pmus, /*pmu=*/NULL, config_terms,
 			   /*first_wildcard_match=*/NULL, /*cpu_list=*/NULL,
 			   alternate_hw_config) ? 0 : -ENOMEM;
 }
@@ -415,7 +418,7 @@ int parse_events__decode_legacy_cache(const char *name, int extended_pmu_type, _
 		cache_result = PERF_COUNT_HW_CACHE_RESULT_ACCESS;
 
 	*config = cache_type | (cache_op << 8) | (cache_result << 16);
-	if (perf_pmus__supports_extended_type())
+	if (perf_pmus__host_supports_extended_type())
 		*config |= (__u64)extended_pmu_type << PERF_PMU_TYPE_SHIFT;
 	return 0;
 }
@@ -671,7 +674,7 @@ int parse_events_add_breakpoint(struct parse_events_state *parse_state,
 
 	name = get_config_name(head_config);
 
-	return add_event(list, &parse_state->idx, &attr, name, /*mertic_id=*/NULL,
+	return add_event(list, parse_state, &attr, name, /*mertic_id=*/NULL,
 			&config_terms, /*alternate_hw_config=*/PERF_COUNT_HW_MAX);
 }
 
@@ -1012,7 +1015,7 @@ static int config_term_pmu(struct perf_event_attr *attr,
 		if (!check_pmu_is_core(attr->type, term, parse_state->error))
 			return -EINVAL;
 		attr->config = term->val.num;
-		if (perf_pmus__supports_extended_type())
+		if (perf_pmus__supports_extended_type(parse_state->pmus))
 			attr->config |= (__u64)attr->type << PERF_PMU_TYPE_SHIFT;
 		attr->type = PERF_TYPE_HARDWARE;
 		return 0;
@@ -1037,7 +1040,7 @@ static int config_term_pmu(struct perf_event_attr *attr,
 		if (!check_pmu_is_core(attr->type, term, parse_state->error))
 			return -EINVAL;
 		attr->config = term->val.num;
-		if (perf_pmus__supports_extended_type())
+		if (perf_pmus__supports_extended_type(parse_state->pmus))
 			attr->config |= (__u64)attr->type << PERF_PMU_TYPE_SHIFT;
 		attr->type = PERF_TYPE_HW_CACHE;
 		return 0;
@@ -1412,7 +1415,7 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 	attr.type = type;
 	attr.config = config;
 	if (extended_type && (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)) {
-		assert(perf_pmus__supports_extended_type());
+		assert(perf_pmus__supports_extended_type(parse_state->pmus));
 		attr.config |= (u64)extended_type << PERF_PMU_TYPE_SHIFT;
 	}
 
@@ -1428,8 +1431,9 @@ static int __parse_events_add_numeric(struct parse_events_state *parse_state,
 	metric_id = get_config_metric_id(head_config);
 	cpus = get_config_cpu(head_config, parse_state->fake_pmu);
 	ret = __add_event(list, &parse_state->idx, &attr, /*init_attr*/true, name,
-			metric_id, pmu, &config_terms, first_wildcard_match,
-			cpus, /*alternate_hw_config=*/PERF_COUNT_HW_MAX) ? 0 : -ENOMEM;
+			metric_id, parse_state->pmus, pmu, &config_terms,
+			first_wildcard_match, cpus,
+			/*alternate_hw_config=*/PERF_COUNT_HW_MAX) ? 0 : -ENOMEM;
 	perf_cpu_map__put(cpus);
 	free_config_terms(&config_terms);
 	return ret;
@@ -1445,7 +1449,7 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 	bool found_supported = false;
 
 	/* Wildcards on numeric values are only supported by core PMUs. */
-	if (wildcard && perf_pmus__supports_extended_type()) {
+	if (wildcard && perf_pmus__supports_extended_type(parse_state->pmus)) {
 		struct evsel *first_wildcard_match = NULL;
 		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
 			int ret;
@@ -1524,7 +1528,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	if (!const_parsed_terms || list_empty(&const_parsed_terms->terms)) {
 		evsel = __add_event(list, &parse_state->idx, &attr,
 				    /*init_attr=*/true, /*name=*/NULL,
-				    /*metric_id=*/NULL, pmu,
+				    /*metric_id=*/NULL, parse_state->pmus, pmu,
 				    /*config_terms=*/NULL, first_wildcard_match,
 				    /*cpu_list=*/NULL, alternate_hw_config);
 		return evsel ? 0 : -ENOMEM;
@@ -1591,7 +1595,7 @@ static int parse_events_add_pmu(struct parse_events_state *parse_state,
 	term_cpu = get_config_cpu(&parsed_terms, parse_state->fake_pmu);
 	evsel = __add_event(list, &parse_state->idx, &attr, /*init_attr=*/true,
 			    get_config_name(&parsed_terms),
-			    get_config_metric_id(&parsed_terms), pmu,
+			    get_config_metric_id(&parsed_terms), parse_state->pmus, pmu,
 			    &config_terms, first_wildcard_match, term_cpu, alternate_hw_config);
 	perf_cpu_map__put(term_cpu);
 	if (!evsel) {
@@ -1661,7 +1665,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 
 	INIT_LIST_HEAD(list);
 
-	while ((pmu = perf_pmus__scan_for_event(pmu, event_name)) != NULL) {
+	while ((pmu = perf_pmus__scan_for_event(parse_state->pmus,
+						pmu, event_name)) != NULL) {
 
 		if (parse_events__filter_pmu(parse_state, pmu))
 			continue;
@@ -1739,7 +1744,8 @@ int parse_events_multi_pmu_add_or_add_pmu(struct parse_events_state *parse_state
 
 	pmu = NULL;
 	/* Failed to add, try wildcard expansion of event_or_pmu as a PMU name. */
-	while ((pmu = perf_pmus__scan_matching_wildcard(pmu, event_or_pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan_matching_wildcard(parse_state->pmus,
+							pmu, event_or_pmu)) != NULL) {
 
 		if (parse_events__filter_pmu(parse_state, pmu))
 			continue;
@@ -1964,6 +1970,7 @@ int parse_events_terms(struct parse_events_terms *terms, const char *str)
 {
 	struct parse_events_state parse_state = {
 		.terms  = NULL,
+		.pmus   = perf_env__pmus(host_env()),
 		.stoken = PE_START_TERMS,
 	};
 	int ret;
@@ -2296,6 +2303,7 @@ int __parse_events(struct evlist *evlist, const char *str,
 		.list			= LIST_HEAD_INIT(parse_state.list),
 		.idx			= evlist__nr_entries(evlist),
 		.error			= err,
+		.pmus			= perf_env__pmus(evlist__env(evlist) ?: host_env()),
 		.stoken			= PE_START_EVENTS,
 		.fake_pmu		= fake_pmu,
 		.fake_tp		= fake_tp,
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index b14c832b03a1..57eabdb97890 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -18,6 +18,7 @@ struct parse_events_error;
 
 struct option;
 struct perf_pmu;
+struct perf_pmus;
 struct strbuf;
 
 const char *event_type(size_t type);
@@ -156,6 +157,8 @@ struct parse_events_state {
 	struct parse_events_error *error;
 	/* Holds returned terms for term parsing. */
 	struct parse_events_terms *terms;
+	/* The PMUs to search during parsing. */
+	struct perf_pmus	  *pmus;
 	/* Start token. */
 	int			   stoken;
 	/* Use the fake PMU marker for testing. */
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
index ea1d402b0893..2d80f119629a 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
@@ -9,6 +9,7 @@
 #include <linux/zalloc.h>
 
 #include "../debug.h"
+#include "../env.h"
 #include "../event.h"
 #include "../pmu.h"
 #include "../pmus.h"
@@ -248,6 +249,7 @@ static uint64_t __arch__reg_mask(u64 sample_type, u64 mask, bool has_simd_regs)
 		.exclude_kernel			= 1,
 		.sample_simd_regs_enabled	= has_simd_regs,
 	};
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	int fd;
 	/*
 	 * In an unnamed union, init it here to build on older gcc versions
@@ -258,7 +260,7 @@ static uint64_t __arch__reg_mask(u64 sample_type, u64 mask, bool has_simd_regs)
 	else
 		attr.sample_regs_user = mask;
 
-	if (perf_pmus__num_core_pmus() > 1) {
+	if (perf_pmus__num_core_pmus(pmus) > 1) {
 		struct perf_pmu *pmu = NULL;
 		__u64 type = PERF_TYPE_RAW;
 
@@ -512,6 +514,7 @@ __support_simd_reg_class(uint64_t sample_type, uint16_t qwords,
 		.exclude_kernel			= 1,
 		.sample_simd_regs_enabled	= 1,
 	};
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	int fd;
 
 	attr.sample_period = 1;
@@ -530,7 +533,7 @@ __support_simd_reg_class(uint64_t sample_type, uint16_t qwords,
 			attr.sample_simd_pred_reg_user = PERF_X86_SIMD_PRED_MASK;
 	}
 
-	if (perf_pmus__num_core_pmus() > 1) {
+	if (perf_pmus__num_core_pmus(pmus) > 1) {
 		__u64 type = perf_pmus__find_core_pmu()->type;
 
 		attr.config |= type << PERF_PMU_TYPE_SHIFT;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 531641e66ef4..ee6a217dde91 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1552,7 +1552,8 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 			assert(term->val.num < PERF_COUNT_HW_MAX);
 			assert(pmu->is_core);
 			attr->config = term->val.num;
-			if (perf_pmus__supports_extended_type())
+			if (pmu->pmus ? perf_pmus__supports_extended_type(pmu->pmus)
+				      : perf_pmus__host_supports_extended_type())
 				attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
 			attr->type = PERF_TYPE_HARDWARE;
 			break;
@@ -1570,7 +1571,8 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 			assert((term->val.num & ~0xFFFFFF) == 0);
 			assert(pmu->is_core);
 			attr->config = term->val.num;
-			if (perf_pmus__supports_extended_type())
+			if (pmu->pmus ? perf_pmus__supports_extended_type(pmu->pmus)
+				      : perf_pmus__host_supports_extended_type())
 				attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
 			attr->type = PERF_TYPE_HW_CACHE;
 			break;
@@ -2109,7 +2111,8 @@ bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu)
 
 bool perf_pmu__auto_merge_stats(const struct perf_pmu *pmu)
 {
-	return !pmu->is_core || perf_pmus__num_core_pmus() == 1;
+	return !pmu->is_core ||
+	       perf_pmus__num_core_pmus(pmu->pmus ?: perf_env__pmus(host_env())) == 1;
 }
 
 bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index ea55882ce670..7605c3859337 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -17,6 +17,7 @@ struct evsel_config_term;
 struct hashmap;
 struct perf_cpu_map;
 struct perf_env;
+struct perf_pmus;
 struct print_callbacks;
 
 enum {
@@ -163,6 +164,8 @@ struct perf_pmu {
 	bool sysfs_aliases_loaded;
 	/** @from_env: Was the PMU reconstructed from a perf_env header? */
 	bool from_env;
+	/** @pmus: The PMU collection this PMU belongs to. */
+	struct perf_pmus *pmus;
 	/**
 	 * @cpu_aliases_added: Have all json events table entries for the PMU
 	 * been added?
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 4f4632f48e16..3adb297636b6 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -14,6 +14,7 @@
 #include "cpumap.h"
 #include "debug.h"
 #include "drm_pmu.h"
+#include "env.h"
 #include "evsel.h"
 #include "pmus.h"
 #include "pmu.h"
@@ -38,8 +39,6 @@
  *             are captured under other_pmus. PMUs belonging to other_pmus
  *             must have pmu->is_core=0 but pmu->is_uncore could be 0 or 1.
  */
-static LIST_HEAD(core_pmus);
-static LIST_HEAD(other_pmus);
 enum perf_tool_pmu_type {
 	PERF_TOOL_PMU_TYPE_PE_CORE,
 	PERF_TOOL_PMU_TYPE_PE_OTHER,
@@ -59,9 +58,8 @@ enum perf_tool_pmu_type {
 					PERF_TOOL_PMU_TYPE_HWMON_MASK | \
 					PERF_TOOL_PMU_TYPE_DRM_MASK)
 };
-static unsigned int read_pmu_types;
 
-static void pmu_read_sysfs(unsigned int to_read_pmus);
+static void pmu_read_sysfs(struct perf_pmus *pmus, unsigned int to_read_pmus);
 
 size_t pmu_name_len_no_suffix(const char *str)
 {
@@ -109,33 +107,50 @@ int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name)
 	return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
 }
 
-void perf_pmus__destroy(void)
+void perf_pmus__init(struct perf_pmus *pmus)
+{
+	INIT_LIST_HEAD(&pmus->core_pmus);
+	INIT_LIST_HEAD(&pmus->other_pmus);
+	pmus->read_pmu_types = 0;
+	pmus->num_core_pmus = 0;
+	pmus->extended_type = PERF_PMUS_EXTENDED_TYPE_UNKNOWN;
+	mutex_init(&pmus->lock);
+}
+
+void perf_pmus__exit(struct perf_pmus *pmus)
 {
 	struct perf_pmu *pmu, *tmp;
 
-	list_for_each_entry_safe(pmu, tmp, &core_pmus, list) {
+	if (!pmus->core_pmus.next || !pmus->other_pmus.next) {
+		perf_pmus__init(pmus);
+		return;
+	}
+
+	list_for_each_entry_safe(pmu, tmp, &pmus->core_pmus, list) {
 		list_del(&pmu->list);
 
 		perf_pmu__delete(pmu);
 	}
-	list_for_each_entry_safe(pmu, tmp, &other_pmus, list) {
+	list_for_each_entry_safe(pmu, tmp, &pmus->other_pmus, list) {
 		list_del(&pmu->list);
 
 		perf_pmu__delete(pmu);
 	}
-	read_pmu_types = 0;
+	pmus->read_pmu_types = 0;
+	pmus->num_core_pmus = 0;
+	pmus->extended_type = PERF_PMUS_EXTENDED_TYPE_UNKNOWN;
 }
 
-static struct perf_pmu *pmu_find(const char *name)
+static struct perf_pmu *pmu_find(struct perf_pmus *pmus, const char *name)
 {
 	struct perf_pmu *pmu;
 
-	list_for_each_entry(pmu, &core_pmus, list) {
+	list_for_each_entry(pmu, &pmus->core_pmus, list) {
 		if (!strcmp(pmu->name, name) ||
 		    (pmu->alias_name && !strcmp(pmu->alias_name, name)))
 			return pmu;
 	}
-	list_for_each_entry(pmu, &other_pmus, list) {
+	list_for_each_entry(pmu, &pmus->other_pmus, list) {
 		if (!strcmp(pmu->name, name) ||
 		    (pmu->alias_name && !strcmp(pmu->alias_name, name)))
 			return pmu;
@@ -144,7 +159,7 @@ static struct perf_pmu *pmu_find(const char *name)
 	return NULL;
 }
 
-struct perf_pmu *perf_pmus__find(const char *name)
+static struct perf_pmu *__perf_pmus__find(struct perf_pmus *pmus, const char *name)
 {
 	struct perf_pmu *pmu;
 	int dirfd;
@@ -158,24 +173,26 @@ struct perf_pmu *perf_pmus__find(const char *name)
 	 * so we keep us from multiple reading/parsing
 	 * the pmu format definitions.
 	 */
-	pmu = pmu_find(name);
+	pmu = pmu_find(pmus, name);
 	if (pmu)
 		return pmu;
 
-	if (read_pmu_types == PERF_TOOL_PMU_TYPE_ALL_MASK)
+	if (pmus->read_pmu_types == PERF_TOOL_PMU_TYPE_ALL_MASK)
 		return NULL;
 
 	core_pmu = is_pmu_core(name);
-	if (core_pmu && (read_pmu_types & PERF_TOOL_PMU_TYPE_PE_CORE_MASK))
+	if (core_pmu && (pmus->read_pmu_types & PERF_TOOL_PMU_TYPE_PE_CORE_MASK))
 		return NULL;
 
 	dirfd = perf_pmu__event_source_devices_fd();
-	pmu = perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirfd, name,
+	pmu = perf_pmu__lookup(core_pmu ? &pmus->core_pmus : &pmus->other_pmus, dirfd, name,
 			       /*eager_load=*/false);
 	close(dirfd);
 
-	if (pmu)
+	if (pmu) {
+		pmu->pmus = pmus;
 		return pmu;
+	}
 
 	/* Looking up an individual perf event PMU failed, check if a tool PMU should be read. */
 	if (!strncmp(name, "hwmon_", 6))
@@ -186,8 +203,8 @@ struct perf_pmu *perf_pmus__find(const char *name)
 		to_read_pmus |= PERF_TOOL_PMU_TYPE_TOOL_MASK;
 
 	if (to_read_pmus) {
-		pmu_read_sysfs(to_read_pmus);
-		pmu = pmu_find(name);
+		pmu_read_sysfs(pmus, to_read_pmus);
+		pmu = pmu_find(pmus, name);
 		if (pmu)
 			return pmu;
 	}
@@ -195,11 +212,16 @@ struct perf_pmu *perf_pmus__find(const char *name)
 	to_read_pmus = PERF_TOOL_PMU_TYPE_PE_CORE_MASK;
 	if (!core_pmu)
 		to_read_pmus |= PERF_TOOL_PMU_TYPE_PE_OTHER_MASK;
-	pmu_read_sysfs(to_read_pmus);
-	return pmu_find(name);
+	pmu_read_sysfs(pmus, to_read_pmus);
+	return pmu_find(pmus, name);
+}
+
+struct perf_pmu *perf_pmus__find(const char *name)
+{
+	return __perf_pmus__find(perf_env__pmus(host_env()), name);
 }
 
-static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
+static struct perf_pmu *perf_pmu__find2(struct perf_pmus *pmus, int dirfd, const char *name)
 {
 	struct perf_pmu *pmu;
 	bool core_pmu;
@@ -209,19 +231,22 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
 	 * so we keep us from multiple reading/parsing
 	 * the pmu format definitions.
 	 */
-	pmu = pmu_find(name);
+	pmu = pmu_find(pmus, name);
 	if (pmu)
 		return pmu;
 
-	if (read_pmu_types == PERF_TOOL_PMU_TYPE_ALL_MASK)
+	if (pmus->read_pmu_types == PERF_TOOL_PMU_TYPE_ALL_MASK)
 		return NULL;
 
 	core_pmu = is_pmu_core(name);
-	if (core_pmu && (read_pmu_types & PERF_TOOL_PMU_TYPE_PE_CORE_MASK))
+	if (core_pmu && (pmus->read_pmu_types & PERF_TOOL_PMU_TYPE_PE_CORE_MASK))
 		return NULL;
 
-	return perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirfd, name,
-				/*eager_load=*/false);
+	pmu = perf_pmu__lookup(core_pmu ? &pmus->core_pmus : &pmus->other_pmus, dirfd, name,
+			       /*eager_load=*/false);
+	if (pmu)
+		pmu->pmus = pmus;
+	return pmu;
 }
 
 static int pmus_cmp(void *priv __maybe_unused,
@@ -234,11 +259,11 @@ static int pmus_cmp(void *priv __maybe_unused,
 }
 
 /* Add all pmus in sysfs to pmu list: */
-static void pmu_read_sysfs(unsigned int to_read_types)
+static void pmu_read_sysfs(struct perf_pmus *pmus, unsigned int to_read_types)
 {
-	struct perf_pmu *tool_pmu;
+	struct perf_pmu *pmu, *tool_pmu;
 
-	if ((read_pmu_types & to_read_types) == to_read_types) {
+	if ((pmus->read_pmu_types & to_read_types) == to_read_types) {
 		/* All requested PMU types have been read. */
 		return;
 	}
@@ -259,60 +284,68 @@ static void pmu_read_sysfs(unsigned int to_read_types)
 				continue;
 			if (core_only && !is_pmu_core(dent->d_name))
 				continue;
-			/* add to static LIST_HEAD(core_pmus) or LIST_HEAD(other_pmus): */
-			perf_pmu__find2(fd, dent->d_name);
+			/* add to core_pmus or other_pmus: */
+			perf_pmu__find2(pmus, fd, dent->d_name);
 		}
 
 		close(fd);
 	}
 skip_pe_pmus:
-	if ((to_read_types & PERF_TOOL_PMU_TYPE_PE_CORE_MASK) && list_empty(&core_pmus)) {
-		if (!perf_pmu__create_placeholder_core_pmu(&core_pmus))
+	if ((to_read_types & PERF_TOOL_PMU_TYPE_PE_CORE_MASK) && list_empty(&pmus->core_pmus)) {
+		pmu = perf_pmu__create_placeholder_core_pmu(&pmus->core_pmus);
+		if (!pmu)
 			pr_err("Failure to set up any core PMUs\n");
+		else
+			pmu->pmus = pmus;
 	}
-	list_sort(NULL, &core_pmus, pmus_cmp);
+	list_sort(NULL, &pmus->core_pmus, pmus_cmp);
 
 	if ((to_read_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) != 0 &&
-	    (read_pmu_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) == 0) {
+	    (pmus->read_pmu_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) == 0) {
 		tool_pmu = tool_pmu__new();
-		if (tool_pmu)
-			list_add_tail(&tool_pmu->list, &other_pmus);
+		if (tool_pmu) {
+			tool_pmu->pmus = pmus;
+			list_add_tail(&tool_pmu->list, &pmus->other_pmus);
+		}
 	}
 	if ((to_read_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) != 0 &&
-	    (read_pmu_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) == 0)
-		perf_pmus__read_hwmon_pmus(&other_pmus);
+	    (pmus->read_pmu_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) == 0)
+		perf_pmus__read_hwmon_pmus(&pmus->other_pmus);
 
 	if ((to_read_types & PERF_TOOL_PMU_TYPE_DRM_MASK) != 0 &&
-	    (read_pmu_types & PERF_TOOL_PMU_TYPE_DRM_MASK) == 0)
-		perf_pmus__read_drm_pmus(&other_pmus);
+	    (pmus->read_pmu_types & PERF_TOOL_PMU_TYPE_DRM_MASK) == 0)
+		perf_pmus__read_drm_pmus(&pmus->other_pmus);
+
+	list_for_each_entry(pmu, &pmus->other_pmus, list)
+		pmu->pmus = pmus;
 
-	list_sort(NULL, &other_pmus, pmus_cmp);
+	list_sort(NULL, &pmus->other_pmus, pmus_cmp);
 
-	read_pmu_types |= to_read_types;
+	pmus->read_pmu_types |= to_read_types;
 }
 
-static struct perf_pmu *__perf_pmus__find_by_type(unsigned int type)
+static struct perf_pmu *__perf_pmus__find_by_type(struct perf_pmus *pmus, unsigned int type)
 {
 	struct perf_pmu *pmu;
 
-	list_for_each_entry(pmu, &core_pmus, list) {
+	list_for_each_entry(pmu, &pmus->core_pmus, list) {
 		if (pmu->type == type)
 			return pmu;
 	}
 
-	list_for_each_entry(pmu, &other_pmus, list) {
+	list_for_each_entry(pmu, &pmus->other_pmus, list) {
 		if (pmu->type == type)
 			return pmu;
 	}
 	return NULL;
 }
 
-struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
+static struct perf_pmu *pmu_find_by_type(struct perf_pmus *pmus, unsigned int type)
 {
 	unsigned int to_read_pmus;
-	struct perf_pmu *pmu = __perf_pmus__find_by_type(type);
+	struct perf_pmu *pmu = __perf_pmus__find_by_type(pmus, type);
 
-	if (pmu || (read_pmu_types == PERF_TOOL_PMU_TYPE_ALL_MASK))
+	if (pmu || (pmus->read_pmu_types == PERF_TOOL_PMU_TYPE_ALL_MASK))
 		return pmu;
 
 	if (type >= PERF_PMU_TYPE_PE_START && type <= PERF_PMU_TYPE_PE_END) {
@@ -325,48 +358,64 @@ struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
 	} else {
 		to_read_pmus = PERF_TOOL_PMU_TYPE_TOOL_MASK;
 	}
-	pmu_read_sysfs(to_read_pmus);
-	pmu = __perf_pmus__find_by_type(type);
+	pmu_read_sysfs(pmus, to_read_pmus);
+	pmu = __perf_pmus__find_by_type(pmus, type);
 	return pmu;
 }
 
+struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
+{
+	return pmu_find_by_type(perf_env__pmus(host_env()), type);
+}
+
 /*
  * pmu iterator: If pmu is NULL, we start at the begin, otherwise return the
  * next pmu. Returns NULL on end.
  */
-struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu)
+static struct perf_pmu *pmu_scan(struct perf_pmus *pmus, struct perf_pmu *pmu)
 {
 	bool use_core_pmus = !pmu || pmu->is_core;
 
 	if (!pmu) {
-		pmu_read_sysfs(PERF_TOOL_PMU_TYPE_ALL_MASK);
-		pmu = list_prepare_entry(pmu, &core_pmus, list);
+		pmu_read_sysfs(pmus, PERF_TOOL_PMU_TYPE_ALL_MASK);
+		pmu = list_prepare_entry(pmu, &pmus->core_pmus, list);
 	}
 	if (use_core_pmus) {
-		list_for_each_entry_continue(pmu, &core_pmus, list)
+		list_for_each_entry_continue(pmu, &pmus->core_pmus, list)
 			return pmu;
 
 		pmu = NULL;
-		pmu = list_prepare_entry(pmu, &other_pmus, list);
+		pmu = list_prepare_entry(pmu, &pmus->other_pmus, list);
 	}
-	list_for_each_entry_continue(pmu, &other_pmus, list)
+	list_for_each_entry_continue(pmu, &pmus->other_pmus, list)
 		return pmu;
 	return NULL;
 }
 
-struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu)
+struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu)
+{
+	return pmu_scan(perf_env__pmus(host_env()), pmu);
+}
+
+static struct perf_pmu *pmu_scan_core(struct perf_pmus *pmus, struct perf_pmu *pmu)
 {
 	if (!pmu) {
-		pmu_read_sysfs(PERF_TOOL_PMU_TYPE_PE_CORE_MASK);
-		return list_first_entry_or_null(&core_pmus, typeof(*pmu), list);
+		pmu_read_sysfs(pmus, PERF_TOOL_PMU_TYPE_PE_CORE_MASK);
+		return list_first_entry_or_null(&pmus->core_pmus, typeof(*pmu), list);
 	}
-	list_for_each_entry_continue(pmu, &core_pmus, list)
+	list_for_each_entry_continue(pmu, &pmus->core_pmus, list)
 		return pmu;
 
 	return NULL;
 }
 
-struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *event)
+struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu)
+{
+	return pmu_scan_core(perf_env__pmus(host_env()), pmu);
+}
+
+struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmus *pmus,
+					   struct perf_pmu *pmu, const char *event)
 {
 	bool use_core_pmus = !pmu || pmu->is_core;
 
@@ -390,22 +439,23 @@ struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *eve
 		if (strlen(event) > 4 && strncmp("drm-", event, 4) == 0)
 			to_read_pmus |= PERF_TOOL_PMU_TYPE_DRM_MASK;
 
-		pmu_read_sysfs(to_read_pmus);
-		pmu = list_prepare_entry(pmu, &core_pmus, list);
+		pmu_read_sysfs(pmus, to_read_pmus);
+		pmu = list_prepare_entry(pmu, &pmus->core_pmus, list);
 	}
 	if (use_core_pmus) {
-		list_for_each_entry_continue(pmu, &core_pmus, list)
+		list_for_each_entry_continue(pmu, &pmus->core_pmus, list)
 			return pmu;
 
 		pmu = NULL;
-		pmu = list_prepare_entry(pmu, &other_pmus, list);
+		pmu = list_prepare_entry(pmu, &pmus->other_pmus, list);
 	}
-	list_for_each_entry_continue(pmu, &other_pmus, list)
+	list_for_each_entry_continue(pmu, &pmus->other_pmus, list)
 		return pmu;
 	return NULL;
 }
 
-struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const char *wildcard)
+struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmus *pmus,
+						   struct perf_pmu *pmu, const char *wildcard)
 {
 	bool use_core_pmus = !pmu || pmu->is_core;
 
@@ -434,33 +484,33 @@ struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const c
 			to_read_pmus |= PERF_TOOL_PMU_TYPE_HWMON_MASK;
 		}
 
-		pmu_read_sysfs(to_read_pmus);
-		pmu = list_prepare_entry(pmu, &core_pmus, list);
+		pmu_read_sysfs(pmus, to_read_pmus);
+		pmu = list_prepare_entry(pmu, &pmus->core_pmus, list);
 	}
 	if (use_core_pmus) {
-		list_for_each_entry_continue(pmu, &core_pmus, list) {
+		list_for_each_entry_continue(pmu, &pmus->core_pmus, list) {
 			if (perf_pmu__wildcard_match(pmu, wildcard))
 				return pmu;
 		}
 		pmu = NULL;
-		pmu = list_prepare_entry(pmu, &other_pmus, list);
+		pmu = list_prepare_entry(pmu, &pmus->other_pmus, list);
 	}
-	list_for_each_entry_continue(pmu, &other_pmus, list) {
+	list_for_each_entry_continue(pmu, &pmus->other_pmus, list) {
 		if (perf_pmu__wildcard_match(pmu, wildcard))
 			return pmu;
 	}
 	return NULL;
 }
 
-static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
+static struct perf_pmu *pmu_scan_skip_duplicates(struct perf_pmus *pmus, struct perf_pmu *pmu)
 {
 	bool use_core_pmus = !pmu || pmu->is_core;
 	int last_pmu_name_len = 0;
 	const char *last_pmu_name = (pmu && pmu->name) ? pmu->name : "";
 
 	if (!pmu) {
-		pmu_read_sysfs(PERF_TOOL_PMU_TYPE_ALL_MASK);
-		pmu = list_prepare_entry(pmu, &core_pmus, list);
+		pmu_read_sysfs(pmus, PERF_TOOL_PMU_TYPE_ALL_MASK);
+		pmu = list_prepare_entry(pmu, &pmus->core_pmus, list);
 	} else
 		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
 
@@ -470,13 +520,13 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 		 * may differ only by a suffix but have different events, so
 		 * they are never duplicates.
 		 */
-		list_for_each_entry_continue(pmu, &core_pmus, list)
+		list_for_each_entry_continue(pmu, &pmus->core_pmus, list)
 			return pmu;
 
 		pmu = NULL;
-		pmu = list_prepare_entry(pmu, &other_pmus, list);
+		pmu = list_prepare_entry(pmu, &pmus->other_pmus, list);
 	}
-	list_for_each_entry_continue(pmu, &other_pmus, list) {
+	list_for_each_entry_continue(pmu, &pmus->other_pmus, list) {
 		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "");
 
 		if (last_pmu_name_len == pmu_name_len &&
@@ -488,27 +538,28 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
 	return NULL;
 }
 
-struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, const char *compat)
+struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmus *pmus,
+					       struct perf_pmu *pmu, const char *compat)
 {
 	if (!pmu) {
 		/* Only uncore PMUs can have identifiers. */
 		unsigned int to_read_pmus = PERF_TOOL_PMU_TYPE_PE_OTHER_MASK;
 
-		pmu_read_sysfs(to_read_pmus);
-		pmu = list_prepare_entry(pmu, &other_pmus, list);
+		pmu_read_sysfs(pmus, to_read_pmus);
+		pmu = list_prepare_entry(pmu, &pmus->other_pmus, list);
 	}
-	list_for_each_entry_continue(pmu, &other_pmus, list) {
+	list_for_each_entry_continue(pmu, &pmus->other_pmus, list) {
 		if (pmu->id && pmu_uncore_identifier_match(compat, pmu->id))
 			return pmu;
 	}
 	return NULL;
 }
 
-const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
+const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(struct perf_pmus *pmus, const char *str)
 {
 	struct perf_pmu *pmu = NULL;
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+	while ((pmu = pmu_scan(pmus, pmu)) != NULL) {
 		if (!strcmp(pmu->name, str))
 			return pmu;
 		/* Ignore "uncore_" prefix. */
@@ -629,7 +680,8 @@ static int perf_pmus__print_pmu_events__callback(void *vstate,
 	return 0;
 }
 
-void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *print_state)
+void perf_pmus__print_pmu_events(struct perf_pmus *pmus,
+				 const struct print_callbacks *print_cb, void *print_state)
 {
 	struct perf_pmu *pmu;
 	int printed = 0;
@@ -637,16 +689,16 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 	struct sevent *aliases;
 	struct events_callback_state state;
 	bool skip_duplicate_pmus = print_cb->skip_duplicate_pmus(print_state);
-	struct perf_pmu *(*scan_fn)(struct perf_pmu *);
+	struct perf_pmu *(*scan_fn)(struct perf_pmus *p, struct perf_pmu *cur);
 
 	if (skip_duplicate_pmus)
-		scan_fn = perf_pmus__scan_skip_duplicates;
+		scan_fn = pmu_scan_skip_duplicates;
 	else
-		scan_fn = perf_pmus__scan;
+		scan_fn = pmu_scan;
 
 	pmu = NULL;
 	len = 0;
-	while ((pmu = scan_fn(pmu)) != NULL)
+	while ((pmu = scan_fn(pmus, pmu)) != NULL)
 		len += perf_pmu__num_events(pmu);
 
 	aliases = calloc(len, sizeof(struct sevent));
@@ -660,7 +712,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 		.aliases_len = len,
 		.index = 0,
 	};
-	while ((pmu = scan_fn(pmu)) != NULL) {
+	while ((pmu = scan_fn(pmus, pmu)) != NULL) {
 		perf_pmu__for_each_event(pmu, skip_duplicate_pmus, &state,
 					 perf_pmus__print_pmu_events__callback);
 	}
@@ -744,18 +796,19 @@ static int build_format_string(void *state, const char *name, int config,
 	return ret1 < 0 ? ret1 : (ret2 < 0 ? ret2 : 0);
 }
 
-void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print_cb, void *print_state)
+void perf_pmus__print_raw_pmu_events(struct perf_pmus *pmus,
+				     const struct print_callbacks *print_cb, void *print_state)
 {
 	bool skip_duplicate_pmus = print_cb->skip_duplicate_pmus(print_state);
-	struct perf_pmu *(*scan_fn)(struct perf_pmu *);
+	struct perf_pmu *(*scan_fn)(struct perf_pmus *p, struct perf_pmu *cur);
 	struct perf_pmu *pmu = NULL;
 
 	if (skip_duplicate_pmus)
-		scan_fn = perf_pmus__scan_skip_duplicates;
+		scan_fn = pmu_scan_skip_duplicates;
 	else
-		scan_fn = perf_pmus__scan;
+		scan_fn = pmu_scan;
 
-	while ((pmu = scan_fn(pmu)) != NULL) {
+	while ((pmu = scan_fn(pmus, pmu)) != NULL) {
 		struct build_format_string_args format_args = {
 			.short_string = STRBUF_INIT,
 			.long_string = STRBUF_INIT,
@@ -797,67 +850,79 @@ void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print_cb, voi
 	}
 }
 
-bool perf_pmus__have_event(const char *pname, const char *name)
+bool perf_pmus__have_event(struct perf_pmus *pmus, const char *pname, const char *name)
 {
-	struct perf_pmu *pmu = perf_pmus__find(pname);
+	struct perf_pmu *pmu = __perf_pmus__find(pmus, pname);
 
 	return pmu && perf_pmu__have_event(pmu, name);
 }
 
-int perf_pmus__num_core_pmus(void)
+int perf_pmus__num_core_pmus(struct perf_pmus *pmus)
 {
-	static int count;
-
-	if (!count) {
+	if (!pmus->num_core_pmus) {
 		struct perf_pmu *pmu = NULL;
 
-		while ((pmu = perf_pmus__scan_core(pmu)) != NULL)
-			count++;
+		while ((pmu = pmu_scan_core(pmus, pmu)) != NULL)
+			pmus->num_core_pmus++;
 	}
-	return count;
+	return pmus->num_core_pmus;
 }
 
-static bool __perf_pmus__supports_extended_type(void)
+static bool __perf_pmus__supports_extended_type(struct perf_pmus *pmus)
 {
 	struct perf_pmu *pmu = NULL;
 
-	if (perf_pmus__num_core_pmus() <= 1)
+	if (perf_pmus__num_core_pmus(pmus) <= 1)
 		return false;
 
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
-		if (!is_event_supported(PERF_TYPE_HARDWARE, PERF_COUNT_HW_CPU_CYCLES | ((__u64)pmu->type << PERF_PMU_TYPE_SHIFT)))
+	while ((pmu = pmu_scan_core(pmus, pmu)) != NULL) {
+		if (!pmu->from_env &&
+		    !is_event_supported(PERF_TYPE_HARDWARE,
+					PERF_COUNT_HW_CPU_CYCLES |
+					((__u64)pmu->type << PERF_PMU_TYPE_SHIFT)))
 			return false;
 	}
 
 	return true;
 }
 
-static bool perf_pmus__do_support_extended_type;
-
-static void perf_pmus__init_supports_extended_type(void)
+bool perf_pmus__supports_extended_type(struct perf_pmus *pmus)
 {
-	perf_pmus__do_support_extended_type = __perf_pmus__supports_extended_type();
-}
+	enum perf_pmus_extended_type extended_type =
+		__atomic_load_n(&pmus->extended_type, __ATOMIC_ACQUIRE);
 
-bool perf_pmus__supports_extended_type(void)
-{
-	static pthread_once_t extended_type_once = PTHREAD_ONCE_INIT;
+	if (extended_type == PERF_PMUS_EXTENDED_TYPE_UNKNOWN) {
+		mutex_lock(&pmus->lock);
+		extended_type = pmus->extended_type;
+		if (extended_type == PERF_PMUS_EXTENDED_TYPE_UNKNOWN) {
+			extended_type = __perf_pmus__supports_extended_type(pmus)
+				? PERF_PMUS_EXTENDED_TYPE_SUPPORTED
+				: PERF_PMUS_EXTENDED_TYPE_NOT_SUPPORTED;
+			__atomic_store_n(&pmus->extended_type, extended_type,
+					 __ATOMIC_RELEASE);
+		}
+		mutex_unlock(&pmus->lock);
+	}
 
-	pthread_once(&extended_type_once, perf_pmus__init_supports_extended_type);
+	return extended_type == PERF_PMUS_EXTENDED_TYPE_SUPPORTED;
+}
 
-	return perf_pmus__do_support_extended_type;
+bool perf_pmus__host_supports_extended_type(void)
+{
+	return perf_pmus__supports_extended_type(perf_env__pmus(host_env()));
 }
 
-struct perf_pmu *perf_pmus__find_by_attr(const struct perf_event_attr *attr)
+struct perf_pmu *perf_pmus__find_by_attr(struct perf_pmus *pmus,
+					 const struct perf_event_attr *attr)
 {
-	struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
+	struct perf_pmu *pmu = pmu_find_by_type(pmus, attr->type);
 	u32 type = attr->type;
 	bool legacy_core_type = type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE;
 
-	if (!pmu && legacy_core_type && perf_pmus__supports_extended_type()) {
+	if (!pmu && legacy_core_type && perf_pmus__supports_extended_type(pmus)) {
 		type = attr->config >> PERF_PMU_TYPE_SHIFT;
 
-		pmu = perf_pmus__find_by_type(type);
+		pmu = pmu_find_by_type(pmus, type);
 	}
 	if (!pmu && (legacy_core_type || type == PERF_TYPE_RAW)) {
 		/*
@@ -868,7 +933,7 @@ struct perf_pmu *perf_pmus__find_by_attr(const struct perf_event_attr *attr)
 		 * PERF_TYPE_RAW, assume the RAW events are going to be handled
 		 * by the first core PMU.
 		 */
-		pmu = perf_pmus__find_core_pmu();
+		pmu = pmu_scan_core(pmus, NULL);
 	}
 	return pmu;
 }
@@ -876,11 +941,13 @@ struct perf_pmu *perf_pmus__find_by_attr(const struct perf_event_attr *attr)
 struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 {
 	struct perf_pmu *pmu = evsel->pmu;
+	struct perf_env *env;
 
 	if (pmu)
 		return pmu;
 
-	pmu = perf_pmus__find_by_attr(&evsel->core.attr);
+	env = evsel__env((struct evsel *)evsel) ?: host_env();
+	pmu = perf_pmus__find_by_attr(perf_env__pmus(env), &evsel->core.attr);
 	((struct evsel *)evsel)->pmu = pmu;
 	return pmu;
 }
@@ -890,21 +957,37 @@ struct perf_pmu *perf_pmus__find_core_pmu(void)
 	return perf_pmus__scan_core(NULL);
 }
 
-struct perf_pmu *perf_pmus__add_test_pmu(int test_sysfs_dirfd, const char *name)
+struct perf_pmu *perf_pmus__add_test_pmu(struct perf_pmus *pmus,
+					 int test_sysfs_dirfd, const char *name)
 {
+	struct perf_pmu *pmu;
+
+	if (!pmus->core_pmus.next || !pmus->other_pmus.next)
+		perf_pmus__init(pmus);
 	/*
 	 * Some PMU functions read from the sysfs mount point, so care is
 	 * needed, hence passing the eager_load flag to load things like the
 	 * format files.
 	 */
-	return perf_pmu__lookup(&other_pmus, test_sysfs_dirfd, name, /*eager_load=*/true);
+	pmu = perf_pmu__lookup(&pmus->other_pmus, test_sysfs_dirfd, name, /*eager_load=*/true);
+	if (pmu)
+		pmu->pmus = pmus;
+	return pmu;
 }
 
-struct perf_pmu *perf_pmus__add_test_hwmon_pmu(const char *hwmon_dir,
+struct perf_pmu *perf_pmus__add_test_hwmon_pmu(struct perf_pmus *pmus,
+					       const char *hwmon_dir,
 					       const char *sysfs_name,
 					       const char *name)
 {
-	return hwmon_pmu__new(&other_pmus, hwmon_dir, sysfs_name, name);
+	struct perf_pmu *pmu;
+
+	if (!pmus->core_pmus.next || !pmus->other_pmus.next)
+		perf_pmus__init(pmus);
+	pmu = hwmon_pmu__new(&pmus->other_pmus, hwmon_dir, sysfs_name, name);
+	if (pmu)
+		pmu->pmus = pmus;
+	return pmu;
 }
 
 struct perf_pmu *perf_pmus__fake_pmu(void)
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 0d55edb3f2fc..45f4bd8b6aa6 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -2,41 +2,220 @@
 #ifndef __PMUS_H
 #define __PMUS_H
 
+#include <linux/list.h>
 #include <stdbool.h>
 #include <stddef.h>
+#include "mutex.h"
 
 struct perf_event_attr;
 struct perf_pmu;
 struct print_callbacks;
 
+/**
+ * enum perf_pmus_extended_type - Tri-state cache for extended PMU type support.
+ * @PERF_PMUS_EXTENDED_TYPE_UNKNOWN: Support has not been checked yet.
+ * @PERF_PMUS_EXTENDED_TYPE_SUPPORTED: Multiple core PMUs / extended type supported.
+ * @PERF_PMUS_EXTENDED_TYPE_NOT_SUPPORTED: Extended type not supported.
+ */
+enum perf_pmus_extended_type {
+	PERF_PMUS_EXTENDED_TYPE_UNKNOWN = 0,
+	PERF_PMUS_EXTENDED_TYPE_SUPPORTED,
+	PERF_PMUS_EXTENDED_TYPE_NOT_SUPPORTED,
+};
+
+/**
+ * struct perf_pmus - Collection of core and non-core PMUs for an environment.
+ */
+struct perf_pmus {
+	/**
+	 * @core_pmus: In-order list of core PMUs (e.g. "cpu", "cpu_core",
+	 * "cpu_atom").
+	 */
+	struct list_head core_pmus;
+	/**
+	 * @other_pmus: In-order list of non-core PMUs (uncore, software,
+	 * tracepoint, tool, hwmon, drm, etc.).
+	 */
+	struct list_head other_pmus;
+	/**
+	 * @read_pmu_types: Bitmask of enum perf_tool_pmu_type values whose PMU
+	 * lists have been populated.
+	 */
+	unsigned int read_pmu_types;
+	/** @num_core_pmus: Cached count of entries in @core_pmus. */
+	int num_core_pmus;
+	/**
+	 * @extended_type: Cached result of checking whether extended PMU type
+	 * encoding in perf_event_attr::config is supported.
+	 */
+	enum perf_pmus_extended_type extended_type;
+	/** @lock: Protects lazy initialization of @extended_type. */
+	struct mutex lock;
+};
+
+#define PERF_PMUS_INIT(name) {					\
+	.core_pmus = LIST_HEAD_INIT((name).core_pmus),		\
+	.other_pmus = LIST_HEAD_INIT((name).other_pmus),	\
+	.lock = { .lock = __PERF_MUTEX_INITIALIZER },		\
+}
+
 size_t pmu_name_len_no_suffix(const char *str);
 /* Exposed for testing only. */
 int pmu_name_cmp(const char *lhs_pmu_name, const char *rhs_pmu_name);
 
-void perf_pmus__destroy(void);
+/**
+ * perf_pmus__init() - Initialize an empty struct perf_pmus.
+ * @pmus: The PMU collection to initialize.
+ */
+void perf_pmus__init(struct perf_pmus *pmus);
+
+/**
+ * perf_pmus__exit() - Free all PMUs in @pmus and reset its state.
+ * @pmus: The PMU collection to clean up.
+ */
+void perf_pmus__exit(struct perf_pmus *pmus);
 
 struct perf_pmu *perf_pmus__find(const char *name);
 struct perf_pmu *perf_pmus__find_by_type(unsigned int type);
-struct perf_pmu *perf_pmus__find_by_attr(const struct perf_event_attr *attr);
+
+/**
+ * perf_pmus__find_by_attr() - Find the PMU corresponding to @attr.
+ * @pmus: The PMU collection to search.
+ * @attr: The perf_event_attr whose type/config identifies the PMU.
+ *
+ * Return: Pointer to the matching struct perf_pmu, or NULL if not found.
+ */
+struct perf_pmu *perf_pmus__find_by_attr(struct perf_pmus *pmus,
+					 const struct perf_event_attr *attr);
 
 struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
-struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *event);
-struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const char *wildcard);
-struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, const char *compat);
 
-const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
+/**
+ * perf_pmus__scan_for_event() - Iterate over PMUs in @pmus that have @event.
+ * @pmus: The PMU collection to scan.
+ * @pmu: Previous matching PMU returned, or NULL to start.
+ * @event: Event name to search for.
+ *
+ * Return: Next struct perf_pmu supporting @event, or NULL when done.
+ */
+struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmus *pmus,
+					   struct perf_pmu *pmu, const char *event);
+
+/**
+ * perf_pmus__scan_matching_wildcard() - Iterate over PMUs matching @wildcard.
+ * @pmus: The PMU collection to scan.
+ * @pmu: Previous matching PMU returned, or NULL to start.
+ * @wildcard: Wildcard/prefix pattern to match against PMU names.
+ *
+ * Return: Next matching struct perf_pmu, or NULL when done.
+ */
+struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmus *pmus,
+						   struct perf_pmu *pmu, const char *wildcard);
+
+/**
+ * perf_pmus__scan_for_uncore_id() - Iterate over uncore PMUs matching @compat.
+ * @pmus: The PMU collection to scan.
+ * @pmu: Previous matching PMU returned, or NULL to start.
+ * @compat: Uncore identifier string to match.
+ *
+ * Return: Next matching uncore struct perf_pmu, or NULL when done.
+ */
+struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmus *pmus,
+					       struct perf_pmu *pmu, const char *compat);
+
+/**
+ * perf_pmus__pmu_for_pmu_filter() - Find PMU matching a pmu_filter string.
+ * @pmus: The PMU collection to search.
+ * @str: Filter string to match against PMU names.
+ *
+ * Return: Matching struct perf_pmu, or NULL if none matches.
+ */
+const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(struct perf_pmus *pmus, const char *str);
 
-void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *print_state);
-void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print_cb, void *print_state);
-bool perf_pmus__have_event(const char *pname, const char *name);
-int perf_pmus__num_core_pmus(void);
-bool perf_pmus__supports_extended_type(void);
+/**
+ * perf_pmus__print_pmu_events() - Print formatted PMU events via @print_cb.
+ * @pmus: The PMU collection whose events to print.
+ * @print_cb: Callbacks for printing event entries.
+ * @print_state: Caller state passed to @print_cb.
+ */
+void perf_pmus__print_pmu_events(struct perf_pmus *pmus,
+				 const struct print_callbacks *print_cb, void *print_state);
 
-struct perf_pmu *perf_pmus__add_test_pmu(int test_sysfs_dirfd, const char *name);
-struct perf_pmu *perf_pmus__add_test_hwmon_pmu(const char *hwmon_dir,
+/**
+ * perf_pmus__print_raw_pmu_events() - Print raw PMU event descriptors.
+ * @pmus: The PMU collection whose raw events to print.
+ * @print_cb: Callbacks for printing event entries.
+ * @print_state: Caller state passed to @print_cb.
+ */
+void perf_pmus__print_raw_pmu_events(struct perf_pmus *pmus,
+				     const struct print_callbacks *print_cb, void *print_state);
+
+/**
+ * perf_pmus__have_event() - Check whether @pname in @pmus has event @name.
+ * @pmus: The PMU collection to search.
+ * @pname: PMU name.
+ * @name: Event name.
+ *
+ * Return: true if the PMU exists and has @name, false otherwise.
+ */
+bool perf_pmus__have_event(struct perf_pmus *pmus, const char *pname, const char *name);
+
+/**
+ * perf_pmus__num_core_pmus() - Return the number of core PMUs in @pmus.
+ * @pmus: The PMU collection to query.
+ *
+ * Return: Number of core PMUs.
+ */
+int perf_pmus__num_core_pmus(struct perf_pmus *pmus);
+
+/**
+ * perf_pmus__supports_extended_type() - Check whether extended PMU type
+ *                                       encoding is supported in @pmus.
+ * @pmus: The PMU collection to query.
+ *
+ * Return: true if extended type encoding is supported, false otherwise.
+ */
+bool perf_pmus__supports_extended_type(struct perf_pmus *pmus);
+
+/**
+ * perf_pmus__host_supports_extended_type() - Check whether extended PMU type
+ *                                            encoding is supported on the host.
+ *
+ * Return: true if extended type encoding is supported on the live host.
+ */
+bool perf_pmus__host_supports_extended_type(void);
+
+/**
+ * perf_pmus__add_test_pmu() - Add a sysfs-backed test PMU to @pmus.
+ * @pmus: The PMU collection to add the test PMU to.
+ * @test_sysfs_dirfd: Directory fd of the synthetic sysfs root.
+ * @name: Name of the test PMU.
+ *
+ * Return: Pointer to the created struct perf_pmu, or NULL on failure.
+ */
+struct perf_pmu *perf_pmus__add_test_pmu(struct perf_pmus *pmus,
+					 int test_sysfs_dirfd, const char *name);
+
+/**
+ * perf_pmus__add_test_hwmon_pmu() - Add a synthetic hwmon test PMU to @pmus.
+ * @pmus: The PMU collection to add the test hwmon PMU to.
+ * @hwmon_dir: Path to the synthetic hwmon directory.
+ * @sysfs_name: Directory entry name (e.g. "hwmon0").
+ * @name: Logical name of the hwmon device.
+ *
+ * Return: Pointer to the created struct perf_pmu, or NULL on failure.
+ */
+struct perf_pmu *perf_pmus__add_test_hwmon_pmu(struct perf_pmus *pmus,
+					       const char *hwmon_dir,
 					       const char *sysfs_name,
 					       const char *name);
+
+/**
+ * perf_pmus__fake_pmu() - Return the singleton fake PMU used for metric tests.
+ *
+ * Return: Pointer to the fake struct perf_pmu.
+ */
 struct perf_pmu *perf_pmus__fake_pmu(void);
 struct perf_pmu *perf_pmus__find_core_pmu(void);
 
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 77428d9e73c4..fe48efe9aefb 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -17,6 +17,7 @@
 
 #include "build-id.h"
 #include "debug.h"
+#include "env.h"
 #include "evsel.h"
 #include "metricgroup.h"
 #include "parse-events.h"
@@ -320,7 +321,9 @@ void metricgroup__print(const struct print_callbacks *print_cb, void *print_stat
  */
 void print_events(const struct print_callbacks *print_cb, void *print_state)
 {
-	perf_pmus__print_pmu_events(print_cb, print_state);
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
+
+	perf_pmus__print_pmu_events(pmus, print_cb, print_state);
 
 	print_cb->print_event(print_state,
 			/*topic=*/NULL,
@@ -335,7 +338,7 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 			/*long_desc=*/NULL,
 			/*encoding_desc=*/NULL);
 
-	perf_pmus__print_raw_pmu_events(print_cb, print_state);
+	perf_pmus__print_raw_pmu_events(pmus, print_cb, print_state);
 
 	print_cb->print_event(print_state,
 			/*topic=*/NULL,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 6ff8d97dcf7d..d22f6e8e504a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -26,6 +26,7 @@
 #include "env.h"
 #include "evlist.h"
 #include "evsel.h"
+#include "pmu.h"
 #include "memswap.h"
 #include "map.h"
 #include "symbol.h"
@@ -264,6 +265,16 @@ void perf_session__delete(struct perf_session *session)
 	debuginfo_cache__delete();
 	perf_session__destroy_kernel_maps(session);
 	perf_decomp__release_events(session->decomp_data.decomp);
+	if (session->data && perf_data__is_read(session->data) && session->evlist) {
+		struct evsel *evsel;
+
+		evlist__for_each_entry(session->evlist, evsel) {
+			if (evsel->pmu && evsel->pmu->pmus == &session->header.env.pmus)
+				evsel->pmu = NULL;
+		}
+		if (evlist__session(session->evlist) == session)
+			evlist__set_session(session->evlist, NULL);
+	}
 	perf_env__exit(&session->header.env);
 	machines__exit(&session->machines);
 	if (session->data) {
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index b337cc23f413..288f98a323e9 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -770,7 +770,9 @@ static bool evlist__has_hybrid_pmus(struct evlist *evlist)
 	struct evsel *evsel;
 	struct perf_pmu *last_core_pmu = NULL;
 
-	if (perf_pmus__num_core_pmus() == 1)
+	struct perf_pmus *pmus = perf_env__pmus(evlist__env(evlist) ?: host_env());
+
+	if (perf_pmus__num_core_pmus(pmus) == 1)
 		return false;
 
 	evlist__for_each_entry(evlist, evsel) {
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 525a3fe4a46e..f5ae399bf336 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -236,7 +236,8 @@ static void perf_stat__print_metricgroup_header(struct perf_stat_config *config,
 						const char *name,
 						struct perf_stat_output_ctx *out)
 {
-	bool need_full_name = perf_pmus__num_core_pmus() > 1;
+	bool need_full_name =
+		perf_pmus__num_core_pmus(perf_env__pmus(evsel__env(evsel) ?: host_env())) > 1;
 	static const char *last_name;
 	static const struct perf_pmu *last_pmu;
 	char full_name[64];
-- 
2.56.1.703.gf848ed807c-goog

