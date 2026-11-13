Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597191;
	b=AJH90Jzba3gsBT60lDdmNVdADeqR6g1fEQLgiB2mEC7UCh7fdCnuPX4tW36NEdx0PMUR
	 cE3geKck3elunuqrbsfkotjZDPVh34gRLVXjbtXUdjvWO2Wxb+W5PPFkTdjAIrXlI+wM7
	 eInf3C6gbKZevESZB2TzaRY5xcHzmgnFTVen0qqMmZqhsb6zQf5us2DW8anjloOovKMrC
	 5bVReOmkLkSsCLZ13J4+sXkDUIK1uRnEB0590TfqhhY+HCM/tr/FCxnqDPVEZucbtLnx1
	 A9+ZZC8z5pWDYIfIBlyymEAwrV+zatvGri+XsW0zBLmFaYOr505pYVSQDFJqy5nCsjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=WfUO+QAnUhk3kJEbZLZWOhsMR7Pb1ynIqJCBQIT9iaw=;
	b=11+2EvA2Y/amPuvX3LPkZoRFSdq8JBdi41mOrUmJQV4dOcl1qlQBPkeJbpfBcvVkHo5C
	 aY9so5IE7LJCLZhrcdcKlwr0UdVO4CEhWIshREywUlqQC/UkO8XXmmttrI5AbtBjP50DK
	 KksaPvad5Ng94GqPq2aQJX12rJxhvCNaovoJgnRQnEVGKzKZM4amC9Z+znUZKmhY4U3Xr
	 Pk8+i7PY/XXaBucFLEfdc3Ncbiae4OFfJevYjd0aLJ5nCRuB6q7py67qahNl9ttT/VaAS
	 7xxllXhAKSJZltugJvAiZ501/1iVF1xkeTpX0q8nZ5S+uzXDmXdl6jYkHnaC1D/q1UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YoKcexpO;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8111D606A8A3
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8111D606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YoKcexpO
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b3a348a6dbso2291900c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794597190; x=1795201990; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WfUO+QAnUhk3kJEbZLZWOhsMR7Pb1ynIqJCBQIT9iaw=;
        b=YoKcexpOR5w2vNql6/F/0el5+VymS9wMYTnu6cqeDrlOaRAbTYm1EXMCHrN/vyeZ1L
         EuUYbL1T+VGNkVVWB4aguu+zO8dFkah60hSZqVfEc7YFbXChigX997CSpNVc2t81Svmo
         iOmqZCtiPOL4TnmbBgNpNyTooieWQ8pUlnovh42UdL6UNcc+a+FdSAT07fsmCRj7kAi/
         HzoEaT+u3VHWKAJd6XgxgqJmGBWkfmbpDSCatDyhQ9z/50GLckKqcOhPRMBkgYxL5tyK
         dIudPcfBho55HTV1kapO+2j2wAwGD8L9kNopBTJrA/isxL38yyOxeXhnjXM/8fgxX4mS
         /L4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794597190; x=1795201990;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WfUO+QAnUhk3kJEbZLZWOhsMR7Pb1ynIqJCBQIT9iaw=;
        b=FUByp4RkvDK3PD/VnFxtIKnK1MmXatJjagfty1YQTteHP23kxhMhKJM9G0b7huC5B7
         aELk7JGr/QwkaunKsqrjfgNHnaxwGpzmiOz8BDurLRMcbZi4R/5Ma2LHKQFabx+1WwvS
         VSFEOrMOPihyKOtS0jkEiaEHpxApqmWrYjbdNvwV5mJaPutOcxRxzsCuMPsBAo3z+sac
         mXPtXauu39RJnSJBKl0+5gzgvOIdHcDiH3ELrKCIaDhLTKij3c9VxX2ouvxlA1VmYPAK
         cmWgN122KJW1OnHycv288gpTLtIsHk7P+yLgzFcFd8Iad8x5vEnlndkK7mulB+sfFvz7
         hHAw==
X-Forwarded-Encrypted: i=1; AL+hErHOIOH6a8QBuQWcY+niJjdmjUXPG/Jg9FgN0N1dpDcARrN1NBoesjUGHkFRQ3KGG/3AC+zYyQLjD6UBU29PFoeU@vger.kernel.org
X-Gm-Message-State: APuU4Z+/ZgIvascPKV3p/Hzdby6YNPO54S54TrlGb/mAPUdbdIoan0nk
	eadYAcfsByiP7iUkd/N9U4FYYrzef3D7KmrDWRy1FkPfrMId2KrJCzYQdm8b5/f6OtfyaInM/t6
	ZI+krwGbOdQ==
X-Received: from dlbuj4.prod.google.com ([2002:a05:7022:3d84:b0:15f:5ef4:b896])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2513:b0:1ab:faad:cc9
 with SMTP id a92af1059eb24-1b503115806mr4410106c88.11.1794597189054; Fri, 13
 Nov 2026 11:13:09 -0800 (PST)
Date: Fri, 13 Nov 2026 11:12:34 -0800
In-Reply-To: <20261113191234.2509964-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113191234.2509964-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113191234.2509964-4-irogers@google.com>
Subject: [PATCH v3 3/3] perf tests: Add NVMe PMU event parsing test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Daniel Wagner <dwagner@suse.de>, Yuzhuo Jing <yuzhuo@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Tomas Glozar <tglozar@redhat.com>, Michael Jeanson <mjeanson@efficios.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Leo Yan <leo.yan@arm.com>, German Gomez <german.gomez@arm.com>, 
	Anubhav Shelat <ashelat@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce a unit test suite for the NVMe tool PMU event parser. The test
registers a mock test NVMe PMU ('nvme_a_test_nvme_pmu' with alias
'nvme1234') and verifies:
- Event parsing without a PMU prefix and with both PMU name and alias.
- Event config encoding, unit, and scale across SMART, Endurance, FDP,
  Error, and ZNS log events (including Kelvin temperature scaling).
- Support for 'event=<name>', raw 'config=0x...', and 'name=' qualifiers.
- Clean rejection of unknown event names, invalid raw configs, duplicate
  event terms, and unsupported string terms where term->config is NULL.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   1 +
 tools/perf/tests/nvme_pmu.c     | 303 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 tools/perf/util/pmus.c          |   5 +
 tools/perf/util/pmus.h          |   1 +
 6 files changed, 312 insertions(+)
 create mode 100644 tools/perf/tests/nvme_pmu.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 5eebb2ec5dde..336bad77c8f4 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -71,6 +71,7 @@ perf-test-y += hybrid-merge.o
 perf-test-y += symbols.o
 perf-test-y += util.o
 perf-test-y += hwmon_pmu.o
+perf-test-y += nvme_pmu.o
 perf-test-y += tool_pmu.o
 perf-test-y += subcmd-help.o
 perf-test-y += kallsyms-split.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 327483f96401..0b88018c7036 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -124,6 +124,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__pmu,
 	&suite__pmu_events,
 	&suite__hwmon_pmu,
+	&suite__nvme_pmu,
 	&suite__tool_pmu,
 	&suite__dso_data,
 	&suite__perf_evsel__roundtrip_name_test,
diff --git a/tools/perf/tests/nvme_pmu.c b/tools/perf/tests/nvme_pmu.c
new file mode 100644
index 000000000000..c3c17ccc9ea0
--- /dev/null
+++ b/tools/perf/tests/nvme_pmu.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "nvme_pmu.h"
+
+#include <errno.h>
+#include <inttypes.h>
+#include <stdio.h>
+#include <string.h>
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/string.h>
+
+#include "debug.h"
+#include "evlist.h"
+#include "evsel.h"
+#include "parse-events.h"
+#include "pmus.h"
+#include "tests.h"
+
+#ifdef HAVE_LIBNVME_SUPPORT
+
+enum test_encoding_mode {
+	TEST_ENCODING_NAME,
+	TEST_ENCODING_ALIAS_PMU,
+	TEST_ENCODING_EVENT_TERM,
+	TEST_ENCODING_RAW_CONFIG,
+	TEST_ENCODING_WITH_NAME_QUALIFIER,
+};
+
+static const struct test_event {
+	const char *name;
+	const char *unit;
+	double scale;
+	uint64_t config;
+} test_events[] = {
+	{
+		"smart_temperature",
+		"K",
+		1.0,
+		NVME_SMART(2, temperature),
+	},
+	{
+		"smart_data_units_read",
+		"B",
+		512000.0,
+		NVME_SMART(16, data_units_read),
+	},
+	{
+		"endurance_percent_used",
+		"",
+		1.0,
+		NVME_ENDURANCE(1, percent_used),
+	},
+	{
+		"endurance_data_units_read",
+		"B",
+		1000000000.0,
+		NVME_ENDURANCE(16, data_units_read),
+	},
+	{
+		"fdp_hbmw",
+		"B",
+		1.0,
+		NVME_FDP(16, hbmw),
+	},
+	{
+		"error_count",
+		"",
+		1.0,
+		NVME_ERROR(8, error_count),
+	},
+	{
+		"zns_nrzid",
+		"",
+		1.0,
+		NVME_ZNS(2, nrzid),
+	},
+};
+
+static int do_test(size_t i, bool with_pmu, enum test_encoding_mode mode)
+{
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
+	if (!with_pmu) {
+		strlcpy(str, test_events[i].name, sizeof(str));
+	} else {
+		switch (mode) {
+		case TEST_ENCODING_NAME:
+			snprintf(str, sizeof(str), "nvme_a_test_nvme_pmu/%s/",
+				 test_events[i].name);
+			break;
+		case TEST_ENCODING_ALIAS_PMU:
+			snprintf(str, sizeof(str), "nvme1234/%s/", test_events[i].name);
+			break;
+		case TEST_ENCODING_EVENT_TERM:
+			snprintf(str, sizeof(str), "nvme_a_test_nvme_pmu/event=%s/",
+				 test_events[i].name);
+			break;
+		case TEST_ENCODING_RAW_CONFIG:
+			snprintf(str, sizeof(str), "nvme_a_test_nvme_pmu/config=0x%" PRIx64 "/",
+				 test_events[i].config);
+			break;
+		case TEST_ENCODING_WITH_NAME_QUALIFIER:
+			snprintf(str, sizeof(str),
+				 "nvme_a_test_nvme_pmu/%s,name=custom_nvme_event/",
+				 test_events[i].name);
+			break;
+		default:
+			ret = TEST_FAIL;
+			goto out_put;
+		}
+	}
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
+	if (with_pmu ? (evlist__nr_entries(evlist) != 1)
+		     : (evlist__nr_entries(evlist) < 1)) {
+		pr_debug("FAILED %s:%d Unexpected number of events for '%s' of %d\n",
+			 __FILE__, __LINE__, str, evlist__nr_entries(evlist));
+		ret = TEST_FAIL;
+		goto out;
+	}
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (!evsel->pmu || !evsel->pmu->name ||
+		    strcmp(evsel->pmu->name, "nvme_a_test_nvme_pmu"))
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
+		if (!evsel->unit || strcmp(evsel->unit, test_events[i].unit) != 0 ||
+		    evsel->scale != test_events[i].scale) {
+			pr_debug("FAILED %s:%d Unexpected unit/scale for '%s', '%s'/%g != '%s'/%g\n",
+				 __FILE__, __LINE__, str,
+				 evsel->unit ?: "(null)", evsel->scale,
+				 test_events[i].unit, test_events[i].scale);
+			ret = TEST_FAIL;
+			goto out;
+		}
+		if (mode == TEST_ENCODING_WITH_NAME_QUALIFIER &&
+		    strcmp(evsel__name(evsel), "custom_nvme_event") != 0) {
+			pr_debug("FAILED %s:%d Unexpected custom name '%s'\n",
+				 __FILE__, __LINE__, evsel__name(evsel));
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
+out_put:
+	evlist__put(evlist);
+	return ret;
+}
+
+static int test__nvme_pmu(bool with_pmu)
+{
+	struct perf_pmu *pmu = perf_pmus__add_test_nvme_pmu("nvme1234", "a_test_nvme_pmu");
+	int ret = TEST_OK;
+
+	if (!pmu)
+		return TEST_FAIL;
+
+	for (size_t i = 0; i < ARRAY_SIZE(test_events); i++) {
+		ret = do_test(i, with_pmu, TEST_ENCODING_NAME);
+		if (ret != TEST_OK)
+			break;
+
+		if (with_pmu) {
+			ret = do_test(i, with_pmu, TEST_ENCODING_ALIAS_PMU);
+			if (ret != TEST_OK)
+				break;
+
+			ret = do_test(i, with_pmu, TEST_ENCODING_EVENT_TERM);
+			if (ret != TEST_OK)
+				break;
+
+			ret = do_test(i, with_pmu, TEST_ENCODING_RAW_CONFIG);
+			if (ret != TEST_OK)
+				break;
+
+			ret = do_test(i, with_pmu, TEST_ENCODING_WITH_NAME_QUALIFIER);
+			if (ret != TEST_OK)
+				break;
+		}
+	}
+
+	list_del(&pmu->list);
+	perf_pmu__delete(pmu);
+	return ret;
+}
+
+static int test__nvme_pmu_invalid_terms(struct test_suite *test __maybe_unused,
+					int subtest __maybe_unused)
+{
+	static const char * const invalid_events[] = {
+		"nvme_a_test_nvme_pmu/nonexistent_event/",
+		"nvme_a_test_nvme_pmu/call-graph=fp/",
+		"nvme_a_test_nvme_pmu/config=0xffffffff/",
+		"nvme_a_test_nvme_pmu/name=only_name/",
+		"nvme_a_test_nvme_pmu/smart_temperature,error_count/",
+		"nvme_a_test_nvme_pmu/smart_temperature=2/",
+	};
+	struct perf_pmu *pmu = perf_pmus__add_test_nvme_pmu("nvme1234", "a_test_nvme_pmu");
+	int ret = TEST_OK;
+
+	if (!pmu)
+		return TEST_FAIL;
+
+	for (size_t i = 0; i < ARRAY_SIZE(invalid_events); i++) {
+		struct evlist *evlist = evlist__new();
+		struct parse_events_error err;
+		int parse_ret;
+
+		if (!evlist) {
+			ret = TEST_FAIL;
+			break;
+		}
+		parse_events_error__init(&err);
+		parse_ret = parse_events(evlist, invalid_events[i], &err);
+		if (parse_ret == 0 || list_empty(&err.list)) {
+			pr_debug("FAILED %s:%d Unexpected parse result %d for invalid event '%s'\n",
+				 __FILE__, __LINE__, parse_ret, invalid_events[i]);
+			parse_events_error__exit(&err);
+			evlist__put(evlist);
+			ret = TEST_FAIL;
+			break;
+		}
+		parse_events_error__exit(&err);
+		evlist__put(evlist);
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
+	TEST_CASE("Rejecting invalid event terms", nvme_pmu_invalid_terms),
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
index af822885890d..5a77bc5ecf7a 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -133,6 +133,7 @@ DECLARE_SUITE(syscall_openat_tp_fields);
 DECLARE_SUITE(pmu);
 DECLARE_SUITE(pmu_events);
 DECLARE_SUITE(hwmon_pmu);
+DECLARE_SUITE(nvme_pmu);
 DECLARE_SUITE(tool_pmu);
 DECLARE_SUITE(attr);
 DECLARE_SUITE(dso_data);
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 980035b640dc..66626ce3494b 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -925,6 +925,11 @@ struct perf_pmu *perf_pmus__add_test_hwmon_pmu(const char *hwmon_dir,
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
2.56.1.703.gf848ed807c-goog

