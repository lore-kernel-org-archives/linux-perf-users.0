Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE253D811B
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988643; cv=none; b=ZfTTJ42tmZdNOR0ZYuzPQpiHJE9xJRbZ3uN9HhwPmGeme5Cl2BPBVn46q2NbYrO5C0zEBzw+8brNTN04GosvL/YXQdizzQwXdTFllBp0XhdpQA0835gDBsQCo67AY5/i9IVlkw/fNSBeI8xYuu4VJz3s8RO+iPTe27696PxMxhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988643; c=relaxed/simple;
	bh=Dqs7Hs37Bo555p42TSP+D2LM+z3IWwZs9RZBKE9daMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PcgSCLKbL38b4mS7AujAU5kWFCOquazPGWbI83DQVU/1ih7qe+8UovqIJMRQ0gdBtudO5MjRnFmkNaWSmKbp6B06tiMr2IxARWvuBdQqqO82ncUlsyf6S49151gZ8G2QfFDY8Hv3pGkN0qIUooUVTI0aivxqvwyUVk4ojpjcjrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gl1p7032; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gl1p7032"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13815e0e6baso2114596c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 00:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780988641; x=1781593441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JqifOfdVc95h96Q4UZJnIrnFSeB34LFLKmiuA9pWjLg=;
        b=gl1p70325+XzYjjs8SSrG4myb++ZYN/5/DiBcCuhEgDit3d5K7yOqe+gWFbiVQXcfi
         Mo6LRwquHB7l9VmYeq8bPCpLUtVil6wq9HpiBrn/sJCVqr+blA197KMX6ju/SAkUBggU
         futvX2jCgJEoKp0wOyPubHQUWwewo1t9P1tJpxrm9R48HOm7IUYD359Qk3FioDBk54i6
         +ckSzCF5XC3kSPAH2ZLz8s8sKD4A5qI50o16JbCGn4OrQaw67JnO7ofu7QCZHF+bKuDV
         SVN1AmnxNWAsTuPBrj5UdePaX9znnlXPLmmQZZgx7HWd1xy6Rd0pbqn2eQxlq0Xgf/A8
         O7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780988641; x=1781593441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JqifOfdVc95h96Q4UZJnIrnFSeB34LFLKmiuA9pWjLg=;
        b=AKu/Pe+td8Iq8Pspxn3nKyvKVfZFdZGbi8ASr68/jIBKXoF8+k/fxI7M+PFWVfLfwK
         Xdwnc8vR4XuHKjFOs48vEIhXybSj6yWLeEK7+V2qfhlVE1ytVO20LjpwlVvsTsT7opPN
         9K368pkrjwu4EjevYz/uS+pMWqviHyCGxpGRX8JMI0NRfEuKBRb1t0yuK84uHLXlwvgo
         eON/ErPW+1l+u3vrkEkArfiT1rxb9ZXtdUYn7k1oAhYUltPMr1yqG1JzUtAgFNBQ0SRJ
         1lHkA/Gm7DT7MX4YmlMYf19Kyrr306jns/oQWUk4BAYwS3isefZ+T/eH4awF8VT8xn34
         dhNw==
X-Forwarded-Encrypted: i=1; AFNElJ9pMvnEFaZHFC9/+oUFb+YsGZLGNmtLpRXsPtvYM+jZAR1aHrRb0LI3rfGcFqRxPqFGHLdQPVFkBYqtMCDSuPXU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9wW6ImmBgCkAgOZ55I7yCR5cMeTDJXgwUdwYUKR3UcmbTrTQu
	B4scY+p3Wx4UbXLo6DE2l/L0F3eeqZzCJh/dpc1F9iHxS/yUYxXhg64rzPvMPFyhnUh3/wDb6HL
	5odecByBlKA==
X-Received: from dled13-n2.prod.google.com ([2002:a05:701b:42cd:20b0:138:14f4:c975])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ebc3:b0:138:30b1:4c09
 with SMTP id a92af1059eb24-13830b1502cmr1247788c88.10.1780988640669; Tue, 09
 Jun 2026 00:04:00 -0700 (PDT)
Date: Tue,  9 Jun 2026 00:03:48 -0700
In-Reply-To: <20260609070348.541964-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609070348.541964-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609070348.541964-4-irogers@google.com>
Subject: [PATCH v1 3/3] perf tests: Add NVMe PMU event parsing test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Tomas Glozar <tglozar@redhat.com>, 
	Michael Jeanson <mjeanson@efficios.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Leo Yan <leo.yan@arm.com>, German Gomez <german.gomez@arm.com>, 
	Anubhav Shelat <ashelat@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Introduce a unit test suite for the NVMe PMU event parser.
The test registers a mock 'nvme_nvme0' PMU and checks that all of
our mapped events (SMART, Endurance, FDP, Error, ZNS) parse into the
correctly configured configs.

To support this, moved the NVMe event config encoding macros and the
'nvme_log_type' enum from nvme_pmu.c to nvme_pmu.h.

Signed-off-by: Ian Rogers <irogers@google.com>
CONV=ca4c5d09-4ef8-405a-80bb-aa988020b436
TAG=agy
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/nvme_pmu.c     | 176 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 tools/perf/util/nvme_pmu.c      |  27 -----
 tools/perf/util/nvme_pmu.h      |  31 ++++++
 tools/perf/util/pmus.c          |   5 +
 tools/perf/util/pmus.h          |   1 +
 8 files changed, 216 insertions(+), 27 deletions(-)
 create mode 100644 tools/perf/tests/nvme_pmu.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 66944a4f4968..acaf5e3e728b 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -68,6 +68,7 @@ perf-test-y += event_groups.o
 perf-test-y += symbols.o
 perf-test-y += util.o
 perf-test-y += hwmon_pmu.o
+perf-test-y += nvme_pmu.o
 perf-test-y += tool_pmu.o
 perf-test-y += subcmd-help.o
 perf-test-y += kallsyms-split.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index b64fc2204f22..9a2fb706c2bc 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -83,6 +83,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__pmu,
 	&suite__pmu_events,
 	&suite__hwmon_pmu,
+	&suite__nvme_pmu,
 	&suite__tool_pmu,
 	&suite__dso_data,
 	&suite__perf_evsel__roundtrip_name_test,
diff --git a/tools/perf/tests/nvme_pmu.c b/tools/perf/tests/nvme_pmu.c
new file mode 100644
index 000000000000..3c1de6e92efc
--- /dev/null
+++ b/tools/perf/tests/nvme_pmu.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "nvme_pmu.h"
+
+#include <errno.h>
+#include <inttypes.h>
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#include "debug.h"
+#include "evlist.h"
+#include "parse-events.h"
+#include "pmus.h"
+#include "tests.h"
+
+#ifdef HAVE_LIBNVME_SUPPORT
+
+static const struct test_event {
+	const char *name;
+	const char *alias;
+	uint64_t config;
+} test_events[] = {
+	{
+		"smart_temperature",
+		"smart_temperature",
+		NVME_SMART(2, temperature),
+	},
+	{
+		"smart_data_units_read",
+		"smart_data_units_read",
+		NVME_SMART(16, data_units_read),
+	},
+	{
+		"endurance_percent_used",
+		"endurance_percent_used",
+		NVME_ENDURANCE(1, percent_used),
+	},
+	{
+		"fdp_hbmw",
+		"fdp_hbmw",
+		NVME_FDP(16, hbmw),
+	},
+	{
+		"error_count",
+		"error_count",
+		NVME_ERROR(8, error_count),
+	},
+	{
+		"zns_nrzid",
+		"zns_nrzid",
+		NVME_ZNS(2, nrzid),
+	},
+};
+
+static int do_test(size_t i, bool with_pmu, bool with_alias)
+{
+	const char *test_event = with_alias ? test_events[i].alias : test_events[i].name;
+	struct evlist *evlist = evlist__new();
+	struct evsel *evsel;
+	struct parse_events_error err;
+	int ret;
+	char str[128];
+	bool found = false;
+
+	if (!evlist) {
+		pr_err("evlist allocation failed\n");
+		return TEST_FAIL;
+	}
+
+	if (with_pmu)
+		snprintf(str, sizeof(str), "nvme_nvme0/%s/", test_event);
+	else
+		strlcpy(str, test_event, sizeof(str));
+
+	pr_debug("Testing '%s'\n", str);
+	parse_events_error__init(&err);
+	ret = parse_events(evlist, str, &err);
+	if (ret) {
+		pr_debug("FAILED %s:%d failed to parse event '%s', err %d\n",
+			 __FILE__, __LINE__, str, ret);
+		parse_events_error__print(&err, str);
+		ret = TEST_FAIL;
+		goto out;
+	}
+
+	ret = TEST_OK;
+	if (with_pmu ? (evlist->core.nr_entries != 1) : (evlist->core.nr_entries < 1)) {
+		pr_debug("FAILED %s:%d Unexpected number of events for '%s' of %d\n",
+			 __FILE__, __LINE__, str, evlist->core.nr_entries);
+		ret = TEST_FAIL;
+		goto out;
+	}
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (!evsel->pmu || !evsel->pmu->name ||
+		    strcmp(evsel->pmu->name, "nvme_nvme0"))
+			continue;
+
+		if (evsel->core.attr.config != test_events[i].config) {
+			pr_debug("FAILED %s:%d Unexpected config for '%s', %"
+				 PRIu64 " != %" PRIu64 "\n",
+				 __FILE__, __LINE__, str,
+				 (uint64_t)evsel->core.attr.config,
+				 test_events[i].config);
+			ret = TEST_FAIL;
+			goto out;
+		}
+		found = true;
+	}
+
+	if (!found) {
+		pr_debug("FAILED %s:%d Didn't find nvme event '%s' in parsed evsels\n",
+			 __FILE__, __LINE__, str);
+		ret = TEST_FAIL;
+	}
+
+out:
+	parse_events_error__exit(&err);
+	evlist__delete(evlist);
+	return ret;
+}
+
+static int test__nvme_pmu(bool with_pmu)
+{
+	struct perf_pmu *pmu = perf_pmus__add_test_nvme_pmu("nvme0", "nvme0");
+	int ret = TEST_OK;
+
+	if (!pmu)
+		return TEST_FAIL;
+
+	for (size_t i = 0; i < ARRAY_SIZE(test_events); i++) {
+		ret = do_test(i, with_pmu, /*with_alias=*/false);
+		if (ret != TEST_OK)
+			break;
+
+		ret = do_test(i, with_pmu, /*with_alias=*/true);
+		if (ret != TEST_OK)
+			break;
+	}
+
+	list_del(&pmu->list);
+	perf_pmu__delete(pmu);
+	return ret;
+}
+
+static int test__nvme_pmu_without_pmu(struct test_suite *test __maybe_unused,
+				      int subtest __maybe_unused)
+{
+	return test__nvme_pmu(/*with_pmu=*/false);
+}
+
+static int test__nvme_pmu_with_pmu(struct test_suite *test __maybe_unused,
+				   int subtest __maybe_unused)
+{
+	return test__nvme_pmu(/*with_pmu=*/true);
+}
+
+static struct test_case tests__nvme_pmu[] = {
+	TEST_CASE("Parsing without PMU name", nvme_pmu_without_pmu),
+	TEST_CASE("Parsing with PMU name", nvme_pmu_with_pmu),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__nvme_pmu = {
+	.desc = "NVMe PMU",
+	.test_cases = tests__nvme_pmu,
+};
+
+#else
+
+struct test_suite suite__nvme_pmu = {
+	.desc = "NVMe PMU",
+	.test_cases = NULL,
+};
+
+#endif
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index bf8ff7d54727..abffa51c5937 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -115,6 +115,7 @@ DECLARE_SUITE(syscall_openat_tp_fields);
 DECLARE_SUITE(pmu);
 DECLARE_SUITE(pmu_events);
 DECLARE_SUITE(hwmon_pmu);
+DECLARE_SUITE(nvme_pmu);
 DECLARE_SUITE(tool_pmu);
 DECLARE_SUITE(attr);
 DECLARE_SUITE(dso_data);
diff --git a/tools/perf/util/nvme_pmu.c b/tools/perf/util/nvme_pmu.c
index 17ba758aec59..ee0e958ea6ef 100644
--- a/tools/perf/util/nvme_pmu.c
+++ b/tools/perf/util/nvme_pmu.c
@@ -25,33 +25,6 @@
 #ifdef HAVE_LIBNVME_SUPPORT
 #include <libnvme.h>
 
-
-#define NVME_CONFIG(log, size, offset) \
-	(((uint64_t)(log) << 24) | ((uint64_t)(size) << 16) | (offset))
-
-enum nvme_log_type {
-	NVME_LOG_SMART = 0,
-	NVME_LOG_ENDURANCE = 1,
-	NVME_LOG_FDP = 2,
-	NVME_LOG_ERROR = 3,
-	NVME_LOG_ZNS = 4,
-};
-
-#define NVME_SMART(size, field) \
-	NVME_CONFIG(NVME_LOG_SMART, size, offsetof(struct nvme_smart_log, field))
-
-#define NVME_ENDURANCE(size, field) \
-	NVME_CONFIG(NVME_LOG_ENDURANCE, size, offsetof(struct nvme_endurance_group_log, field))
-
-#define NVME_FDP(size, field) \
-	NVME_CONFIG(NVME_LOG_FDP, size, offsetof(struct nvme_fdp_stats_log, field))
-
-#define NVME_ERROR(size, field) \
-	NVME_CONFIG(NVME_LOG_ERROR, size, offsetof(struct nvme_error_log_page, field))
-
-#define NVME_ZNS(size, field) \
-	NVME_CONFIG(NVME_LOG_ZNS, size, offsetof(struct nvme_zns_changed_zone_log, field))
-
 struct nvme_event {
 	const char *name;
 	const char *desc;
diff --git a/tools/perf/util/nvme_pmu.h b/tools/perf/util/nvme_pmu.h
index 6d5d2bbe4167..9203f461f381 100644
--- a/tools/perf/util/nvme_pmu.h
+++ b/tools/perf/util/nvme_pmu.h
@@ -6,6 +6,37 @@
 #include <stdbool.h>
 #include <errno.h>
 
+#ifdef HAVE_LIBNVME_SUPPORT
+#include <libnvme.h>
+#include <stddef.h>
+
+#define NVME_CONFIG(log, size, offset) \
+	(((uint64_t)(log) << 24) | ((uint64_t)(size) << 16) | (offset))
+
+enum nvme_log_type {
+	NVME_LOG_SMART = 0,
+	NVME_LOG_ENDURANCE = 1,
+	NVME_LOG_FDP = 2,
+	NVME_LOG_ERROR = 3,
+	NVME_LOG_ZNS = 4,
+};
+
+#define NVME_SMART(size, field) \
+	NVME_CONFIG(NVME_LOG_SMART, size, offsetof(struct nvme_smart_log, field))
+
+#define NVME_ENDURANCE(size, field) \
+	NVME_CONFIG(NVME_LOG_ENDURANCE, size, offsetof(struct nvme_endurance_group_log, field))
+
+#define NVME_FDP(size, field) \
+	NVME_CONFIG(NVME_LOG_FDP, size, offsetof(struct nvme_fdp_stats_log, field))
+
+#define NVME_ERROR(size, field) \
+	NVME_CONFIG(NVME_LOG_ERROR, size, offsetof(struct nvme_error_log_page, field))
+
+#define NVME_ZNS(size, field) \
+	NVME_CONFIG(NVME_LOG_ZNS, size, offsetof(struct nvme_zns_changed_zone_log, field))
+#endif
+
 struct list_head;
 struct perf_thread_map;
 struct evsel;
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 83777f941e9a..1c45164ae244 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -909,6 +909,11 @@ struct perf_pmu *perf_pmus__add_test_hwmon_pmu(const char *hwmon_dir,
 	return hwmon_pmu__new(&other_pmus, hwmon_dir, sysfs_name, name);
 }
 
+struct perf_pmu *perf_pmus__add_test_nvme_pmu(const char *sysfs_name, const char *name)
+{
+	return nvme_pmu__new(&other_pmus, sysfs_name, name);
+}
+
 struct perf_pmu *perf_pmus__fake_pmu(void)
 {
 	static struct perf_pmu fake = {
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 0d55edb3f2fc..2045d4cf44d1 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -37,6 +37,7 @@ struct perf_pmu *perf_pmus__add_test_pmu(int test_sysfs_dirfd, const char *name)
 struct perf_pmu *perf_pmus__add_test_hwmon_pmu(const char *hwmon_dir,
 					       const char *sysfs_name,
 					       const char *name);
+struct perf_pmu *perf_pmus__add_test_nvme_pmu(const char *sysfs_name, const char *name);
 struct perf_pmu *perf_pmus__fake_pmu(void);
 struct perf_pmu *perf_pmus__find_core_pmu(void);
 
-- 
2.54.0.1064.gd145956f57-goog

