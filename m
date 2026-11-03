Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749530;
	b=opmSIOQxMbZvz7iuDjnnH/6O5CJkArHhxtxBbHIvcTbTo7UPG3K2WBB3KWU2Z5pb9Yk1
	 i8GMy6vaj7V8DM2FqCLmsGMySO9v8Cdygg3yvF7fG7yZNItRnIlYT4IGl/4LLghOfWxeu
	 Jl5Ksrn6+XnAthcBJ2x1eD+QRNY9iTaGPGtkaI3zOD1ni5Fll3/2+BizjL5TW5cex2mEy
	 g0r/psO4hcn3nlrxPXYzxT3fd2iP00mIQZOiQAVCj12JTG9cLZ3PI2FSsABAqwYrBzAzz
	 QN8yQP7M25hXPTNbo49hvNSqWWAtG1PKDD6iuxGDY+IW2ltUs+TZwAz4ve4IvOpOMAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=AKexw+Mj1QakEDgc+N/XalBajnVlsS7U5es63W8TH0A=;
	b=HLSTovclNWD70Fd1TtXBQIvQkOrrXekGlDv4+1nrACtPlNzO0PTlJIKHevMlKm0DsFEb
	 XJXW3Ngpn6BbOhq/F0YVQVeptzwSIGoBkYkzQOHsFjTSE6t/1Cvyh2f//PK62ZnFqXqN2
	 f8KYoU0Y5RxCHDkGJv5/W3GH2XTxkM5EYlz2l50ZgV3uUSh9uDsIzp1oq5eL6qSw7Ozt8
	 9hWmjeOg/Xs9M8e1ANWzzsEtqJY0jJJSANNG1zgA4DL8Hos/zXV3Ca1P8bSkZF3v9hUpA
	 C0aFX/KFktW//SBm1hvlgj2MpSKaMqKS8y1kbnysmbuexWm5qcLUmT+MtiJqZDtShrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Y/3PSHpI";
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CBE606A328
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22CBE606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y/3PSHpI
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-351788121cfso430605eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749529; x=1794354329; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AKexw+Mj1QakEDgc+N/XalBajnVlsS7U5es63W8TH0A=;
        b=Y/3PSHpIkdIlczEhiIytyplFetemnMYv++96KzwQrUvw15H0SsQniwDsGHFLfPfbzi
         Rxaa6DwswudOOfZE7T1bINUtMsMLXMUiv7AHsPFbUiIYd7D1B2H9lWpM4Vzu0MVkC3YG
         tgjGitOERP1wGQAKuqETDMLq4DbFay+1ugS4PdQQ0aDBjbrpYTEnlbBdNWQ1HLQGr3Pk
         e3baMFbBnVwscQqqm2m7tp915Utc8DQD6aNa2YncwGzUkeya7iTYFLARUC0IIBLx6SxP
         QNBkhNtkWFpQozZ0F4UQgc+5pa2pE+2KIsoqnPRBzmbYn+Y/ND39Tq4j7BF1JubJTuZo
         N9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749529; x=1794354329;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AKexw+Mj1QakEDgc+N/XalBajnVlsS7U5es63W8TH0A=;
        b=iIh60gQM2SqOmhx/H6N253jJ/tDV9vvmhDK/r1nPuhv5WAPx4cQTjwBNxKyRVVU/mr
         mpd5Px0nOGjyGv0XJl2ikJzF4XyggKyPg21DLPClRxI7jwniakXAhteW2n13I8LelglZ
         6o8wIA9iX9tbO8C2Ythu5rH0SEX/rPtvIg53fI01d7qnxVa0ROzYzImGuRH0HuMqeK06
         D0O84ZQPDHtLX9COmvbEDRbhgyM2l970BpNdYdLOBMQ+uQjYnGpSIhDuhkf5bfZBFmO4
         YxZZSXVHHEmf0dlTTY1eTETDw3e7USF08vDtXGcDXYFHluTmmLrhZbW8Ds4yUfWSoejR
         m5IA==
X-Gm-Message-State: APuU4Z/7zf8m6bF92lpYb8MJ4fQLv7g+1LaSuejCvLoSDJRMe9qPKce9
	rQvEfFamKmECpVEbeTMM16dwLS8KTXdj5/JxcNL0PXGMuruP9jZWvR+G0NNz3BHZHMROyBcB+NF
	t4oNBH/aWImfkVte3Kybp+Hk8h1OoDj88TnaZbpT5AciKTiGxxHnFJm7vTPHrv7oBDGc5KomJWm
	a2kk4jCLTCCVVhXsDV3PAWvzYrIPGfAOdEW3Cq7IJzBJzleK32sbV0QyU=
X-Received: from dyay14.prod.google.com ([2002:a05:693c:62ce:b0:368:6c42:2a6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:824b:b0:36a:1c75:8ca3
 with SMTP id 5a478bee46e88-36a4221b3b9mr20254819eec.1.1793749528636; Tue, 03
 Nov 2026 15:45:28 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:24 -0800
In-Reply-To: <20261103234502.1008382-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103234502.1008382-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103234502.1008382-9-irogers@google.com>
Subject: [PATCH v1 08/41] perf pmu-events: Pass e_machine to find_core_*_table()
From: Ian Rogers <irogers@google.com>
To: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, John Garry <john.garry@linux.dev>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

find_core_events_table() and find_core_metrics_table() found tables by
an architecture name, such as from perf_env__arch(), that has to match
the pmu-events architecture directory name, for example "riscv" rather
than the "riscv64" from uname.

Instead find tables by the ELF machine of the CPUID's architecture,
using the e_machine recorded in struct pmu_events_map. The test and
common tables are found with EM_NONE.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 10 ++++++----
 tools/perf/pmu-events/jevents.py         | 10 ++++++----
 tools/perf/pmu-events/pmu-events.h       |  9 +++++++--
 tools/perf/tests/expand-cgroup.c         |  3 ++-
 tools/perf/tests/parse-metric.c          |  3 ++-
 tools/perf/tests/pmu-events.c            |  7 ++++---
 tools/perf/util/tool_pmu.c               |  3 ++-
 7 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 7428ffd4d70c..eba5446520c4 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -5927,23 +5927,25 @@ const struct pmu_metrics_table *pmu_metrics_table__default(void)
 	return NULL;
 }
 
-const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
+const struct pmu_events_table *find_core_events_table(uint16_t e_machine, const char *cpuid)
 {
 	for (const struct pmu_events_map *tables = &pmu_events_map[0];
 	     tables->arch;
 	     tables++) {
-		if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpuid))
+		if (pmu_events_map__e_machine_matches(tables, e_machine) &&
+		    !strcmp_cpuid_str(tables->cpuid, cpuid))
 			return &tables->event_table;
 	}
 	return NULL;
 }
 
-const struct pmu_metrics_table *find_core_metrics_table(const char *arch, const char *cpuid)
+const struct pmu_metrics_table *find_core_metrics_table(uint16_t e_machine, const char *cpuid)
 {
 	for (const struct pmu_events_map *tables = &pmu_events_map[0];
 	     tables->arch;
 	     tables++) {
-		if (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpuid))
+		if (pmu_events_map__e_machine_matches(tables, e_machine) &&
+		    !strcmp_cpuid_str(tables->cpuid, cpuid))
 			return &tables->metric_table;
 	}
 	return NULL;
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index db1b4749aec3..fc3de5fbda27 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1345,23 +1345,25 @@ const struct pmu_metrics_table *pmu_metrics_table__default(void)
 \treturn NULL;
 }
 
-const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid)
+const struct pmu_events_table *find_core_events_table(uint16_t e_machine, const char *cpuid)
 {
 \tfor (const struct pmu_events_map *tables = &pmu_events_map[0];
 \t     tables->arch;
 \t     tables++) {
-\t\tif (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpuid))
+\t\tif (pmu_events_map__e_machine_matches(tables, e_machine) &&
+\t\t    !strcmp_cpuid_str(tables->cpuid, cpuid))
 \t\t\treturn &tables->event_table;
 \t}
 \treturn NULL;
 }
 
-const struct pmu_metrics_table *find_core_metrics_table(const char *arch, const char *cpuid)
+const struct pmu_metrics_table *find_core_metrics_table(uint16_t e_machine, const char *cpuid)
 {
 \tfor (const struct pmu_events_map *tables = &pmu_events_map[0];
 \t     tables->arch;
 \t     tables++) {
-\t\tif (!strcmp(tables->arch, arch) && !strcmp_cpuid_str(tables->cpuid, cpuid))
+\t\tif (pmu_events_map__e_machine_matches(tables, e_machine) &&
+\t\t    !strcmp_cpuid_str(tables->cpuid, cpuid))
 \t\t\treturn &tables->metric_table;
 \t}
 \treturn NULL;
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index cb55c9fbca43..c3f645c97ccd 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -4,6 +4,7 @@
 
 #include <stdbool.h>
 #include <stddef.h>
+#include <stdint.h>
 
 struct perf_pmu;
 
@@ -134,8 +135,12 @@ const struct pmu_events_table *perf_pmu__find_events_table(struct perf_pmu *pmu)
 const struct pmu_events_table *perf_pmu__default_core_events_table(void);
 const struct pmu_metrics_table *pmu_metrics_table__find(void);
 const struct pmu_metrics_table *pmu_metrics_table__default(void);
-const struct pmu_events_table *find_core_events_table(const char *arch, const char *cpuid);
-const struct pmu_metrics_table *find_core_metrics_table(const char *arch, const char *cpuid);
+/*
+ * Find the core events or metrics table for a CPUID of the architecture with
+ * ELF machine @e_machine. The test and common tables use EM_NONE.
+ */
+const struct pmu_events_table *find_core_events_table(uint16_t e_machine, const char *cpuid);
+const struct pmu_metrics_table *find_core_metrics_table(uint16_t e_machine, const char *cpuid);
 int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data);
 int pmu_for_each_core_metric(pmu_metric_iter_fn fn, void *data);
 
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index 04d62611766a..f5e092e8bb48 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -10,6 +10,7 @@
 #include "pfm.h"
 #include "target.h"
 #include <subcmd/parse-options.h>
+#include <elf.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -178,7 +179,7 @@ static int expand_metric_events(void)
 	evlist = evlist__new();
 	TEST_ASSERT_VAL("failed to get evlist", evlist);
 
-	pme_test = find_core_metrics_table("testarch", "testcpu");
+	pme_test = find_core_metrics_table(EM_NONE, "testcpu");
 	ret = metricgroup__parse_groups_test(evlist, pme_test, metric_str,
 					     /*cputype_filter=*/false);
 	if (ret < 0) {
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 872d9a7aa72f..6f91e64a4123 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/compiler.h>
+#include <elf.h>
 #include <errno.h>
 #include <string.h>
 #include <perf/cpumap.h>
@@ -91,7 +92,7 @@ static int __compute_metric(const char *name, struct value *vals,
 	perf_evlist__set_maps(evlist__core(evlist), cpus, NULL);
 
 	/* Parse the metric into metric_events list. */
-	pme_test = find_core_metrics_table("testarch", "testcpu");
+	pme_test = find_core_metrics_table(EM_NONE, "testcpu");
 	err = metricgroup__parse_groups_test(evlist, pme_test, name,
 					     /*cputype_filter=*/false);
 	if (err)
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index cb0c2b05c1e8..8e82f7af2aa6 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -4,6 +4,7 @@
 #include "pmu.h"
 #include "pmus.h"
 #include "tests.h"
+#include <elf.h>
 #include <errno.h>
 #include <stdio.h>
 #include <linux/kernel.h>
@@ -449,7 +450,7 @@ static int test__pmu_event_table(struct test_suite *test __maybe_unused,
 {
 	const struct pmu_events_table *sys_event_table =
 		find_sys_events_table("pmu_events__test_soc_sys");
-	const struct pmu_events_table *table = find_core_events_table("testarch", "testcpu");
+	const struct pmu_events_table *table = find_core_events_table(EM_NONE, "testcpu");
 	int map_events = 0, expected_events, err;
 
 	/* ignore 3x sentinels */
@@ -504,7 +505,7 @@ static int __test_core_pmu_event_aliases(const char *pmu_name, int *count)
 	struct perf_pmu_test_event const **test_event_table;
 	struct perf_pmu *pmu;
 	int res = 0;
-	const struct pmu_events_table *table = find_core_events_table("testarch", "testcpu");
+	const struct pmu_events_table *table = find_core_events_table(EM_NONE, "testcpu");
 
 	if (!table)
 		return -1;
@@ -559,7 +560,7 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 	const struct pmu_events_table *events_table;
 	int res = 0;
 
-	events_table = find_core_events_table("testarch", "testcpu");
+	events_table = find_core_events_table(EM_NONE, "testcpu");
 	if (!events_table)
 		return -1;
 
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 6054d5d5aece..d09361999b82 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -14,6 +14,7 @@
 #include <api/io.h>
 #include <internal/threadmap.h>
 #include <perf/threadmap.h>
+#include <elf.h>
 #include <fcntl.h>
 #include <strings.h>
 
@@ -718,6 +719,6 @@ struct perf_pmu *tool_pmu__new(void)
 		perf_pmu__delete(tool);
 		return NULL;
 	}
-	tool->events_table = find_core_events_table("common", "common");
+	tool->events_table = find_core_events_table(EM_NONE, "common");
 	return tool;
 }
-- 
2.56.0.385.gac671c819a-goog

