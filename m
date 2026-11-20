Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212875;
	b=geRjX2HvtP8qTSg2IDtPZ3RCxHl6v5g3IHck/acxUSAQTk/MCLKqpuwrhTx0Z+OcfCwb
	 6evKK+bMg4smi0/wNycsiTCzM5oazYCNZDs1S+CLG1MRtm/ep3uKTQrlmShN4+WgKpcx1
	 jjIEbJ8C55Bh7S0jN7DcADfOqHO8z/z7NLYUPaqIKhDE9vItpimiNWGxtT+WC1vQosWOr
	 hSHaKTrGbnGKEn6SCcUvwfpSFGU7yjCmB7WVU3hMWfQWvUoOZ7+E1/Q2nRTY1Y6cJN3GU
	 Sl1Atl2IS/0zx6qAJSFBndQq5+S7e3QsAipq+ab2K/h4867CQyABLT5TsV6yzKs/E+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=B9WPOTPjhDL+M80CZ64TPj/bjH8xsPtM1MlBXOc0jCw=;
	b=qOttbLa4DtvQ3D/99MM4zDOdao7TRiMlMOUJBYSe02og6u041bfu9G9dEaBrQZp1qdlx
	 /I4pE39yiNzAfAfjCBXSYKNligpdH/FSc/chdLghKiSAdabZFmz1pTI2PHlK8BufUPpFL
	 ustvUSlZ2swzQaqNf8iywhsK6NTdOvW5UHO03ftjZf8LPRmQgDTUzF93bEic5Ce1OuL/0
	 i2FD3L1GaONDM3DhL8QEPu7xOpYqBpG/iiMVjIdjRT5gDQFgd/lJiTH5oVCdy0DVeITxE
	 ccBKQuUA29sPOLFmJf1l/FT6NlRPuZeGWqNbFXN2n28ZfyMuGgpia+ta7FADq6B4Axw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i9SESWcr;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD00606A6A8
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CD00606A6A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i9SESWcr
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-139b62317d0so3608154c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212866; x=1795817666; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B9WPOTPjhDL+M80CZ64TPj/bjH8xsPtM1MlBXOc0jCw=;
        b=i9SESWcr72eV5x28DK+ndFDUrzt4wPwK+zWLPvVAunWaB1hJ5EMGET/r7tnhzmN6d0
         k6ZwwZ2vZFYtWk7Y7GH7lXZCxhF/cPWo9molb+3F1rxt7tHjXNmRbqPnnyoHgyX9w5Ik
         ov9K434WnDBzteuZItvn7YMyyqnIr+vaUCJjER6yB8vjsJWvEHVPgioT4c3X+s5GDl8v
         IdZ31P8sPvs2SpjbleVF9x1velCJ+1JDcx927jTHJbJNXbVv+foeivtldl9UtXmje0/R
         ypI64GZe6t5ZRiZPE4RlfxnIKluTIxSvUG8XJaMfn063SKRRapft9imYVWOZes3Mq0or
         oVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212866; x=1795817666;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B9WPOTPjhDL+M80CZ64TPj/bjH8xsPtM1MlBXOc0jCw=;
        b=OBzQCuCCmpxGNJcFggmzLhMkNhj6ZzJFpOz11I5kuOBDOVIfbj7sanbSEkvT8BoGzR
         gfiSdlGtqTeeL7HLtJ/pPZKntBfY6Mkgq6FY3aJOsL3dhjvpxi9v9J/26V4ClSTxtqUU
         v7o1JLyF8mM1L8kRSkYVhAAxI41EQ29Qf7654iO47fcsG+rWX2w5gHKQfOU/HK6sX7qz
         3yw0YzYHZFiNjLu41AuKUAQ7AChdoRjnbgjh+gPBhN/s59szWyD2rXriMOT5B/t8M8LV
         +UKlknPIt4gATEyuiABBh3CYZlBck2lFg2AGEpLsLRcxd5cjFdHx/lML/wHyQQfXzUs4
         IoQw==
X-Gm-Message-State: APuU4Z/xFz5y9sLVQZBVIq1CNKc6Z5Ib5WVSt39cmRRWt88oCyznEp6I
	eFP/Rn9EjjblbYwxLJsdQol6PcYyIxJWmVzbah5hqJ7wmhY/CT9YXd1f9L9vzMkRzErM/oz8J5T
	s5EbxiL8nUw==
X-Received: from dly1-n1.prod.google.com ([2002:a05:701b:2041:10b0:1b5:43fc:8107])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4502:10b0:1b2:539b:496c
 with SMTP id a92af1059eb24-1b5569050c8mr4719713c88.35.1795212865812; Fri, 20
 Nov 2026 14:14:25 -0800 (PST)
Date: Fri, 20 Nov 2026 14:13:11 -0800
In-Reply-To: <20261120221332.2245191-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120221332.2245191-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120221332.2245191-11-irogers@google.com>
Subject: [PATCH v3 10/30] perf pmus: Pass struct perf_pmus to scan helpers
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Update perf_pmus__scan() and perf_pmus__scan_core() to take a
struct perf_pmus * argument and update callers to pass the appropriate
environment's PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/topdown.c           |  3 +-
 tools/perf/bench/pmu-scan.c                   |  6 ++--
 tools/perf/tests/event_groups.c               |  4 ++-
 tools/perf/tests/mmap-basic.c                 |  2 +-
 tools/perf/tests/parse-events.c               |  9 +++--
 tools/perf/tests/pmu-events.c                 |  4 ++-
 tools/perf/tests/uncore-event-sorting.c       |  6 ++--
 tools/perf/util/cputopo.c                     |  2 +-
 tools/perf/util/env.c                         |  7 ++--
 tools/perf/util/evlist.c                      |  3 +-
 tools/perf/util/header.c                      | 10 +++---
 tools/perf/util/mem-events.c                  |  5 ++-
 tools/perf/util/metricgroup.c                 |  2 +-
 tools/perf/util/parse-events.c                | 28 ++++++++--------
 .../perf/util/perf-regs-arch/perf_regs_x86.c  |  2 +-
 tools/perf/util/perf_api_probe.c              |  3 +-
 tools/perf/util/pmu.c                         |  4 ++-
 tools/perf/util/pmus.c                        | 33 +++++++------------
 tools/perf/util/pmus.h                        | 19 +++++++++--
 tools/perf/util/python.c                      |  4 +--
 20 files changed, 92 insertions(+), 64 deletions(-)

diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
index 827169b60813..fec51274e76e 100644
--- a/tools/perf/arch/x86/tests/topdown.c
+++ b/tools/perf/arch/x86/tests/topdown.c
@@ -65,13 +65,14 @@ static int event_cb(void *state, struct pmu_event_info *info)
 
 static int test__x86_topdown(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	int ret = TEST_OK;
 	struct perf_pmu *pmu = NULL;
 
 	if (!topdown_sys_has_perf_metrics())
 		return TEST_OK;
 
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan_core(pmus, pmu)) != NULL) {
 		if (perf_pmu__for_each_event(pmu, /*skip_duplicate_pmus=*/false, &ret, event_cb))
 			break;
 	}
diff --git a/tools/perf/bench/pmu-scan.c b/tools/perf/bench/pmu-scan.c
index 754486d1d87b..fe58fbfcf96d 100644
--- a/tools/perf/bench/pmu-scan.c
+++ b/tools/perf/bench/pmu-scan.c
@@ -48,7 +48,7 @@ static int save_result(void)
 	struct list_head *list;
 	struct pmu_scan_result *r;
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan(pmus, pmu)) != NULL) {
 		r = realloc(results, (nr_pmus + 1) * sizeof(*r));
 		if (r == NULL)
 			return -ENOMEM;
@@ -153,9 +153,9 @@ static int run_pmu_scan(void)
 		for (unsigned int i = 0; i < iterations; i++) {
 			gettimeofday(&start, NULL);
 			if (core_only)
-				perf_pmus__scan_core(NULL);
+				perf_pmus__scan_core(pmus, NULL);
 			else
-				perf_pmus__scan(NULL);
+				perf_pmus__scan(pmus, NULL);
 			gettimeofday(&end, NULL);
 			timersub(&end, &start, &diff);
 			runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
diff --git a/tools/perf/tests/event_groups.c b/tools/perf/tests/event_groups.c
index c119ff114948..f52d2fb08820 100644
--- a/tools/perf/tests/event_groups.c
+++ b/tools/perf/tests/event_groups.c
@@ -5,6 +5,7 @@
 #include "linux/perf_event.h"
 #include "tests.h"
 #include "debug.h"
+#include "env.h"
 #include "pmu.h"
 #include "pmus.h"
 #include "header.h"
@@ -51,10 +52,11 @@ static int event_open(int type, unsigned long config, int group_fd)
 
 static int setup_uncore_event(void)
 {
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	struct perf_pmu *pmu = NULL;
 	int i, fd;
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan(pmus, pmu)) != NULL) {
 		for (i = 0; i < NR_UNCORE_PMUS; i++) {
 			if (!strcmp(uncore_pmus[i].name, pmu->name)) {
 				pr_debug("Using %s for uncore pmu event\n", pmu->name);
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index dada4af5fb68..a542aadb46a0 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -277,7 +277,7 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
 	}
 	perf_thread_map__set_pid(threads, 0, 0);
 
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan_core(pmus, pmu)) != NULL) {
 		enum user_read_state saved_user_read_state = set_user_read(pmu, enabled);
 		struct perf_event_attr attr = {
 			.type	= PERF_TYPE_HARDWARE,
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 4b7551391b40..bcd831abdd90 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -142,6 +142,7 @@ static int test__checkevent_tracepoint_multi(struct evlist *evlist)
 
 static int test__checkevent_raw(struct evlist *evlist)
 {
+	struct perf_pmus *pmus __maybe_unused = perf_env__pmus(host_env());
 	struct evsel *evsel;
 	bool raw_type_match = false;
 
@@ -164,7 +165,7 @@ static int test__checkevent_raw(struct evlist *evlist)
 		 */
 		type_matched = raw_type_match = true;
 #else
-		while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+		while ((pmu = perf_pmus__scan(pmus, pmu)) != NULL) {
 			if (pmu->type == evsel->core.attr.type) {
 				TEST_ASSERT_EVSEL("PMU type expected once", !type_matched, evsel);
 				type_matched = true;
@@ -1800,9 +1801,10 @@ static int test__intel_pt(struct evlist *evlist)
 
 static bool test__acr_valid(void)
 {
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	struct perf_pmu *pmu = NULL;
 
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan_core(pmus, pmu)) != NULL) {
 		if (perf_pmu__has_format(pmu, "acr_mask"))
 			return true;
 	}
@@ -2711,10 +2713,11 @@ static int test__terms2(struct test_suite *test __maybe_unused, int subtest __ma
 
 static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	struct perf_pmu *pmu = NULL;
 	int ret = TEST_OK;
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan(pmus, pmu)) != NULL) {
 		struct stat st;
 		char path[PATH_MAX];
 		char pmu_event[PATH_MAX];
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index acf8e8ee1237..cb0c2b05c1e8 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include "debug.h"
+#include "env.h"
 #include "../pmu-events/pmu-events.h"
 #include <perf/evlist.h>
 #include "util/evlist.h"
@@ -726,10 +727,11 @@ static struct perf_pmu_test_pmu test_pmus[] = {
 static int test__aliases(struct test_suite *test __maybe_unused,
 			int subtest __maybe_unused)
 {
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	struct perf_pmu *pmu = NULL;
 	unsigned long i;
 
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan_core(pmus, pmu)) != NULL) {
 		int count = 0;
 
 		if (list_empty(&pmu->format)) {
diff --git a/tools/perf/tests/uncore-event-sorting.c b/tools/perf/tests/uncore-event-sorting.c
index 7756777c54c2..99af4d88bb81 100644
--- a/tools/perf/tests/uncore-event-sorting.c
+++ b/tools/perf/tests/uncore-event-sorting.c
@@ -2,6 +2,7 @@
 #include <string.h>
 
 #include "debug.h"
+#include "env.h"
 #include "evlist.h"
 #include "parse-events.h"
 #include "pmu.h"
@@ -84,6 +85,7 @@ static int test__uncore_event_sorting(struct test_suite *test __maybe_unused,
 	struct evlist *evlist = NULL;
 	struct parse_events_error err;
 	struct evsel *evsel;
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	struct perf_pmu *pmu = NULL;
 	char *pmu_prefix = NULL;
 	struct match_state m = { NULL, NULL };
@@ -92,7 +94,7 @@ static int test__uncore_event_sorting(struct test_suite *test __maybe_unused,
 
 	parse_events_error__init(&err);
 
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan(pmus, pmu)) != NULL) {
 		size_t len;
 		struct perf_pmu *sibling;
 
@@ -104,7 +106,7 @@ static int test__uncore_event_sorting(struct test_suite *test __maybe_unused,
 			continue;
 
 		sibling = pmu;
-		while ((sibling = perf_pmus__scan(sibling)) != NULL) {
+		while ((sibling = perf_pmus__scan(pmus, sibling)) != NULL) {
 			if (sibling->is_core)
 				continue;
 			if (pmu_name_len_no_suffix(sibling->name) == len &&
diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 04ab4d010149..2e8e8754bb3f 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -483,7 +483,7 @@ struct hybrid_topology *hybrid_topology__new(void)
 		return NULL;
 
 	tp->nr = nr;
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan_core(pmus, pmu)) != NULL) {
 		if (load_hybrid_node(&tp->nodes[i], pmu)) {
 			hybrid_topology__delete(tp);
 			return NULL;
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 4f4ec49b6a6b..fec6a5a8ecb6 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -499,11 +499,12 @@ int perf_env__read_cpu_topology_map(struct perf_env *env)
 
 int perf_env__read_pmu_mappings(struct perf_env *env)
 {
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	struct perf_pmu *pmu = NULL;
 	u32 pmu_num = 0;
 	struct strbuf sb;
 
-	while ((pmu = perf_pmus__scan(pmu)))
+	while ((pmu = perf_pmus__scan(pmus, pmu)))
 		pmu_num++;
 
 	if (!pmu_num) {
@@ -514,7 +515,7 @@ int perf_env__read_pmu_mappings(struct perf_env *env)
 	if (strbuf_init(&sb, 128 * pmu_num) < 0)
 		return -ENOMEM;
 
-	while ((pmu = perf_pmus__scan(pmu))) {
+	while ((pmu = perf_pmus__scan(pmus, pmu))) {
 		if (strbuf_addf(&sb, "%u:%s", pmu->type, pmu->name) < 0)
 			goto error;
 		/* include a NULL character at the end */
@@ -633,7 +634,7 @@ int perf_env__read_core_pmu_caps(struct perf_env *env)
 	if (!pmu_caps)
 		return -ENOMEM;
 
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan_core(pmus, pmu)) != NULL) {
 		if (perf_pmu__caps_parse(pmu) <= 0)
 			continue;
 		ret = __perf_env__read_core_pmu_caps(pmu, &pmu_caps[i].nr_caps,
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 4e641ccc176f..faf5ce62811b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -128,10 +128,11 @@ struct evlist *evlist__new_default(const struct target *target, bool sample_call
 		if (err)
 			goto out_err;
 	} else {
+		struct perf_pmus *pmus = perf_env__pmus(host_env());
 		struct evsel *leader = NULL;
 
 		/* Fallback for cross-platform file analysis missing the topology header */
-		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		while ((pmu = perf_pmus__scan_core(pmus, pmu)) != NULL) {
 			snprintf(buf, sizeof(buf), "%s/cycles/%s", pmu->name,
 				can_profile_kernel ? "P" : "Pu");
 			err = parse_event(evlist, buf);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 16e49baa9d5e..4d61451020f3 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -852,6 +852,7 @@ static int write_numa_topology(struct feat_fd *ff,
 static int write_pmu_mappings(struct feat_fd *ff,
 			      struct evlist *evlist __maybe_unused)
 {
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	struct perf_pmu *pmu = NULL;
 	u32 pmu_num = 0;
 	int ret;
@@ -860,14 +861,14 @@ static int write_pmu_mappings(struct feat_fd *ff,
 	 * Do a first pass to count number of pmu to avoid lseek so this
 	 * works in pipe mode as well.
 	 */
-	while ((pmu = perf_pmus__scan(pmu)))
+	while ((pmu = perf_pmus__scan(pmus, pmu)))
 		pmu_num++;
 
 	ret = do_write(ff, &pmu_num, sizeof(pmu_num));
 	if (ret < 0)
 		return ret;
 
-	while ((pmu = perf_pmus__scan(pmu))) {
+	while ((pmu = perf_pmus__scan(pmus, pmu))) {
 		ret = do_write(ff, &pmu->type, sizeof(pmu->type));
 		if (ret < 0)
 			return ret;
@@ -1717,11 +1718,12 @@ static int write_cpu_pmu_caps(struct feat_fd *ff,
 static int write_pmu_caps(struct feat_fd *ff,
 			  struct evlist *evlist __maybe_unused)
 {
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
 	struct perf_pmu *pmu = NULL;
 	int nr_pmu = 0;
 	int ret;
 
-	while ((pmu = perf_pmus__scan(pmu))) {
+	while ((pmu = perf_pmus__scan(pmus, pmu))) {
 		if (!strcmp(pmu->name, "cpu")) {
 			/*
 			 * The "cpu" PMU is special and covered by
@@ -1747,7 +1749,7 @@ static int write_pmu_caps(struct feat_fd *ff,
 	 * of perf_pmus__scan.
 	 */
 	pmu = NULL;
-	while ((pmu = perf_pmus__scan(pmu))) {
+	while ((pmu = perf_pmus__scan(pmus, pmu))) {
 		if (!strcmp(pmu->name, "cpu")) {
 			/* Skip as above. */
 			continue;
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 0cdcb47647bd..62543df0dca1 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -13,6 +13,7 @@
 #include "mem-events.h"
 #include "mem-info.h"
 #include "debug.h"
+#include "env.h"
 #include "evsel.h"
 #include "symbol.h"
 #include "pmu.h"
@@ -42,7 +43,9 @@ struct perf_mem_event *perf_pmu__mem_events_ptr(struct perf_pmu *pmu, int i)
 
 static struct perf_pmu *perf_pmus__scan_mem(struct perf_pmu *pmu)
 {
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+	struct perf_pmus *pmus = perf_env__pmus(host_env());
+
+	while ((pmu = perf_pmus__scan(pmus, pmu)) != NULL) {
 		if (pmu->mem_events)
 			return pmu;
 	}
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 593032197edd..80c2086555a8 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -934,7 +934,7 @@ static int __add_metric(struct list_head *metric_list,
 		if (pm->pmu && pm->pmu[0] != '\0')
 			pmu = perf_pmus__find(pmus, pm->pmu);
 		else
-			pmu = perf_pmus__scan_core(/*pmu=*/ NULL);
+			pmu = perf_pmus__scan_core(pmus, /*pmu=*/NULL);
 
 		ret = resolve_metric(metric_list, pmus, pmu, modifier, metric_no_group,
 				     metric_no_threshold, user_requested_cpu_list,
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index f38c83b24e6a..0044b6c27ea6 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1008,16 +1008,16 @@ do {											\
 }
 
 static bool check_pmu_is_core(__u32 type, const struct parse_events_term *term,
-			      struct parse_events_error *err)
+			      struct parse_events_state *parse_state)
 {
 	struct perf_pmu *pmu = NULL;
 
 	/* Avoid loading all PMUs with perf_pmus__find_by_type, just scan the core ones. */
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan_core(parse_state->pmus, pmu)) != NULL) {
 		if (pmu->type == type)
 			return true;
 	}
-	parse_events_error__handle(err, term->err_val,
+	parse_events_error__handle(parse_state->error, term->err_val,
 				strdup("needs a core PMU"),
 				NULL);
 	return false;
@@ -1036,7 +1036,7 @@ static int config_term_pmu(struct perf_event_attr *attr,
 						   NULL);
 			return -EINVAL;
 		}
-		if (!check_pmu_is_core(attr->type, term, parse_state->error))
+		if (!check_pmu_is_core(attr->type, term, parse_state))
 			return -EINVAL;
 		attr->config = term->val.num;
 		if (perf_pmus__supports_extended_type(parse_state->pmus))
@@ -1061,7 +1061,7 @@ static int config_term_pmu(struct perf_event_attr *attr,
 						   NULL);
 			return -EINVAL;
 		}
-		if (!check_pmu_is_core(attr->type, term, parse_state->error))
+		if (!check_pmu_is_core(attr->type, term, parse_state))
 			return -EINVAL;
 		attr->config = term->val.num;
 		if (perf_pmus__supports_extended_type(parse_state->pmus))
@@ -1475,7 +1475,7 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 	/* Wildcards on numeric values are only supported by core PMUs. */
 	if (wildcard && perf_pmus__supports_extended_type(parse_state->pmus)) {
 		struct evsel *first_wildcard_match = NULL;
-		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		while ((pmu = perf_pmus__scan_core(parse_state->pmus, pmu)) != NULL) {
 			int ret;
 
 			found_supported = true;
@@ -2009,7 +2009,8 @@ int parse_events_terms(struct parse_events_terms *terms, const char *str)
 }
 
 static int evsel__compute_group_pmu_name(struct evsel *evsel,
-					  const struct list_head *head)
+					  const struct list_head *head,
+					  struct perf_pmus *pmus)
 {
 	struct evsel *leader = evsel__leader(evsel);
 	struct evsel *pos;
@@ -2022,7 +2023,7 @@ static int evsel__compute_group_pmu_name(struct evsel *evsel,
 		 * is a core PMU, but in heterogeneous systems this is
 		 * unknown. For now pick the first core PMU.
 		 */
-		pmu = perf_pmus__scan_core(NULL);
+		pmu = perf_pmus__scan_core(pmus, NULL);
 	}
 	if (!pmu) {
 		pr_debug("No PMU found for '%s'\n", evsel__name(evsel));
@@ -2042,7 +2043,7 @@ static int evsel__compute_group_pmu_name(struct evsel *evsel,
 
 		if (!leader_pmu) {
 			/* As with determining pmu above. */
-			leader_pmu = perf_pmus__scan_core(NULL);
+			leader_pmu = perf_pmus__scan_core(pmus, NULL);
 		}
 		/*
 		 * Starting with the leader, find the first event with a named
@@ -2061,7 +2062,7 @@ static int evsel__compute_group_pmu_name(struct evsel *evsel,
 				pos_pmu = evsel__find_pmu(pos);
 				if (!pos_pmu) {
 					/* As with determining pmu above. */
-					pos_pmu = perf_pmus__scan_core(NULL);
+					pos_pmu = perf_pmus__scan_core(pmus, NULL);
 				}
 				if (pos_pmu && !perf_pmu__is_software(pos_pmu)) {
 					group_pmu_name = pos_pmu->name;
@@ -2151,7 +2152,8 @@ int __weak arch_evlist__add_required_events(struct list_head *list __always_unus
 	return 0;
 }
 
-static int parse_events__sort_events_and_fix_groups(struct list_head *list)
+static int parse_events__sort_events_and_fix_groups(struct list_head *list,
+						    struct perf_pmus *pmus)
 {
 	int idx = 0, force_grouped_idx = -1;
 	struct evsel *pos, *cur_leader = NULL;
@@ -2174,7 +2176,7 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 	list_for_each_entry(pos, list, core.node) {
 		const struct evsel *pos_leader = evsel__leader(pos);
 
-		ret = evsel__compute_group_pmu_name(pos, list);
+		ret = evsel__compute_group_pmu_name(pos, list, pmus);
 		if (ret)
 			return ret;
 
@@ -2345,7 +2347,7 @@ int __parse_events(struct evlist *evlist, const char *str,
 		return -1;
 	}
 
-	ret2 = parse_events__sort_events_and_fix_groups(&parse_state.list);
+	ret2 = parse_events__sort_events_and_fix_groups(&parse_state.list, parse_state.pmus);
 	if (ret2 < 0 && !ret)
 		ret = ret2;
 
diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
index 920f17b89659..8cb9dfa6c7d3 100644
--- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
+++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
@@ -268,7 +268,7 @@ static uint64_t __arch__reg_mask(u64 sample_type, u64 mask, bool has_simd_regs)
 		 * The same register set is supported among different hybrid PMUs.
 		 * Only check the first available one.
 		 */
-		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+		while ((pmu = perf_pmus__scan_core(pmus, pmu)) != NULL) {
 			type = pmu->type;
 			break;
 		}
diff --git a/tools/perf/util/perf_api_probe.c b/tools/perf/util/perf_api_probe.c
index f61c4ec52827..7a8b99f31985 100644
--- a/tools/perf/util/perf_api_probe.c
+++ b/tools/perf/util/perf_api_probe.c
@@ -6,6 +6,7 @@
 #include <perf/cpumap.h>
 
 #include "cloexec.h"
+#include "env.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "parse-events.h"
@@ -78,7 +79,7 @@ static bool perf_probe_api(setup_probe_fn_t fn)
 	if (!ret)
 		return true;
 
-	pmu = perf_pmus__scan_core(/*pmu=*/NULL);
+	pmu = perf_pmus__scan_core(perf_env__pmus(host_env()), /*pmu=*/NULL);
 	if (pmu) {
 		const char *try[] = {"cycles", "instructions", NULL};
 		char buf[256];
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 388070e670b6..fc4fa34fcb0d 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2080,6 +2080,7 @@ bool is_pmu_core(const char *name)
  */
 bool is_pmu_core_len(struct perf_env *env, const char *name, size_t len)
 {
+	struct perf_pmus *pmus;
 	struct perf_pmu *pmu = NULL;
 
 	if (env && env->hybrid_nodes) {
@@ -2106,7 +2107,8 @@ bool is_pmu_core_len(struct perf_env *env, const char *name, size_t len)
 		return false;
 	}
 
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+	pmus = perf_env__pmus(env ?: host_env());
+	while ((pmu = perf_pmus__scan_core(pmus, pmu)) != NULL) {
 		if (strlen(pmu->name) == len && !strncmp(name, pmu->name, len))
 			return true;
 	}
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 0cfdfc4a8a99..1c3cb53c3d4f 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -385,7 +385,7 @@ struct perf_pmu *perf_pmus__find_by_type(struct perf_pmus *pmus, unsigned int ty
  * pmu iterator: If pmu is NULL, we start at the begin, otherwise return the
  * next pmu. Returns NULL on end.
  */
-static struct perf_pmu *pmu_scan(struct perf_pmus *pmus, struct perf_pmu *pmu)
+struct perf_pmu *perf_pmus__scan(struct perf_pmus *pmus, struct perf_pmu *pmu)
 {
 	bool use_core_pmus = !pmu || pmu->is_core;
 
@@ -405,12 +405,7 @@ static struct perf_pmu *pmu_scan(struct perf_pmus *pmus, struct perf_pmu *pmu)
 	return NULL;
 }
 
-struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu)
-{
-	return pmu_scan(perf_env__pmus(host_env()), pmu);
-}
-
-static struct perf_pmu *pmu_scan_core(struct perf_pmus *pmus, struct perf_pmu *pmu)
+struct perf_pmu *perf_pmus__scan_core(struct perf_pmus *pmus, struct perf_pmu *pmu)
 {
 	if (!pmu) {
 		pmu_read_sysfs(pmus, PERF_TOOL_PMU_TYPE_PE_CORE_MASK);
@@ -422,11 +417,6 @@ static struct perf_pmu *pmu_scan_core(struct perf_pmus *pmus, struct perf_pmu *p
 	return NULL;
 }
 
-struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu)
-{
-	return pmu_scan_core(perf_env__pmus(host_env()), pmu);
-}
-
 struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmus *pmus,
 					   struct perf_pmu *pmu, const char *event)
 {
@@ -515,7 +505,8 @@ struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmus *pmus,
 	return NULL;
 }
 
-static struct perf_pmu *pmu_scan_skip_duplicates(struct perf_pmus *pmus, struct perf_pmu *pmu)
+static struct perf_pmu *
+perf_pmus__scan_skip_duplicates(struct perf_pmus *pmus, struct perf_pmu *pmu)
 {
 	bool use_core_pmus = !pmu || pmu->is_core;
 	int last_pmu_name_len = 0;
@@ -572,7 +563,7 @@ const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(struct perf_pmus *pmus, con
 {
 	struct perf_pmu *pmu = NULL;
 
-	while ((pmu = pmu_scan(pmus, pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan(pmus, pmu)) != NULL) {
 		if (!strcmp(pmu->name, str))
 			return pmu;
 		/* Ignore "uncore_" prefix. */
@@ -705,9 +696,9 @@ void perf_pmus__print_pmu_events(struct perf_pmus *pmus,
 	struct perf_pmu *(*scan_fn)(struct perf_pmus *p, struct perf_pmu *cur);
 
 	if (skip_duplicate_pmus)
-		scan_fn = pmu_scan_skip_duplicates;
+		scan_fn = perf_pmus__scan_skip_duplicates;
 	else
-		scan_fn = pmu_scan;
+		scan_fn = perf_pmus__scan;
 
 	pmu = NULL;
 	len = 0;
@@ -817,9 +808,9 @@ void perf_pmus__print_raw_pmu_events(struct perf_pmus *pmus,
 	struct perf_pmu *pmu = NULL;
 
 	if (skip_duplicate_pmus)
-		scan_fn = pmu_scan_skip_duplicates;
+		scan_fn = perf_pmus__scan_skip_duplicates;
 	else
-		scan_fn = pmu_scan;
+		scan_fn = perf_pmus__scan;
 
 	while ((pmu = scan_fn(pmus, pmu)) != NULL) {
 		struct build_format_string_args format_args = {
@@ -875,7 +866,7 @@ int perf_pmus__num_core_pmus(struct perf_pmus *pmus)
 	if (!pmus->num_core_pmus) {
 		struct perf_pmu *pmu = NULL;
 
-		while ((pmu = pmu_scan_core(pmus, pmu)) != NULL)
+		while ((pmu = perf_pmus__scan_core(pmus, pmu)) != NULL)
 			pmus->num_core_pmus++;
 	}
 	return pmus->num_core_pmus;
@@ -888,7 +879,7 @@ static bool __perf_pmus__supports_extended_type(struct perf_pmus *pmus)
 	if (perf_pmus__num_core_pmus(pmus) <= 1)
 		return false;
 
-	while ((pmu = pmu_scan_core(pmus, pmu)) != NULL) {
+	while ((pmu = perf_pmus__scan_core(pmus, pmu)) != NULL) {
 		if (!pmu->from_env &&
 		    !is_event_supported(PERF_TYPE_HARDWARE,
 					PERF_COUNT_HW_CPU_CYCLES |
@@ -967,7 +958,7 @@ struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 
 struct perf_pmu *perf_pmus__find_core_pmu(struct perf_pmus *pmus)
 {
-	return pmu_scan_core(pmus, NULL);
+	return perf_pmus__scan_core(pmus, NULL);
 }
 
 struct perf_pmu *perf_pmus__add_test_pmu(struct perf_pmus *pmus,
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index cd0c14f8e04b..6e7c9f857aaf 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -103,8 +103,23 @@ struct perf_pmu *perf_pmus__find_by_type(struct perf_pmus *pmus, unsigned int ty
 struct perf_pmu *perf_pmus__find_by_attr(struct perf_pmus *pmus,
 					 const struct perf_event_attr *attr);
 
-struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
-struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
+/**
+ * perf_pmus__scan() - Iterate over all PMUs (core then other) in @pmus.
+ * @pmus: The PMU collection to scan.
+ * @pmu: Previous PMU returned by perf_pmus__scan(), or NULL to start.
+ *
+ * Return: Next struct perf_pmu in @pmus, or NULL when iteration completes.
+ */
+struct perf_pmu *perf_pmus__scan(struct perf_pmus *pmus, struct perf_pmu *pmu);
+
+/**
+ * perf_pmus__scan_core() - Iterate over core PMUs in @pmus.
+ * @pmus: The PMU collection to scan.
+ * @pmu: Previous core PMU returned by perf_pmus__scan_core(), or NULL to start.
+ *
+ * Return: Next core struct perf_pmu in @pmus, or NULL when iteration completes.
+ */
+struct perf_pmu *perf_pmus__scan_core(struct perf_pmus *pmus, struct perf_pmu *pmu);
 
 /**
  * perf_pmus__scan_for_event() - Iterate over PMUs in @pmus that have @event.
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 18dfe21104f4..f1de03ee3e24 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -2160,7 +2160,7 @@ static PyObject *pyrf_pmu_iterator__new(PyTypeObject *type, PyObject *args __may
 	struct pyrf_pmu_iterator *itr = (void *)type->tp_alloc(type, 0);
 
 	if (itr != NULL)
-		itr->pmu = perf_pmus__scan(/*pmu=*/NULL);
+		itr->pmu = perf_pmus__scan(perf_env__pmus(host_env()), /*pmu=*/NULL);
 
 	return (PyObject *) itr;
 }
@@ -2185,7 +2185,7 @@ static PyObject *pyrf_pmu_iterator__iternext(PyObject *self)
 	if (ppmu) {
 		ppmu->pmu = itr->pmu;
 		// Advance iterator.
-		itr->pmu = perf_pmus__scan(itr->pmu);
+		itr->pmu = perf_pmus__scan(perf_env__pmus(host_env()), itr->pmu);
 	}
 	return (PyObject *)ppmu;
 }
-- 
2.56.1.750.gf70dc682cf-goog

