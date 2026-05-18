Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257FC35836E
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 04:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779078716; cv=none; b=b7tcevlRAAo3jaLMLDjpm7tBF5DX5dKHjIWOQKv2gx9DdFXCcyrRK/xYRL2ZZ136R4xcEyNfKr6clXHqbqZr3HbjzgTiFpndNhrCMtqrRrf6ElyZSiivfQmpWLjVmQlaUcbwjdIOCcr56rvi0OIyqxt6nzDo2bzRqhojmJWRqNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779078716; c=relaxed/simple;
	bh=MC0apQYF85j3TEweHcfBKqRQbO2appaCBP/O5NDlFo0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iBHGwDex6z+cEaXSaffT2JNksEOWqTYyklpL/uh2jawB3U1iSVr7osE7cjRHOJMlrEPjpkE51wp+ZsVdm+vrMmyl1xp2RenZcKUlSQxA3h45tX3SSW1gnnkp1GtjAvuGryZpgmXfaF4Z+Ek2ouIUV9J7uTbO5YNlj4gQ8MFMhHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bpqCy7lN; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpqCy7lN"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13536592ebeso2688123c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 21:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779078709; x=1779683509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5aCwUis7hcNvoBcusHclileUNp7B3j+0iZpWDTdHqro=;
        b=bpqCy7lNIqzRhbOw/XffD5ulmijjQoCy8SGlg04tsKOTNb34TPXdCSI0BN5Ozzn9qr
         tas77AMhUyidyP6Te+bT8FTWPpzUrEK0WLB+lcQonc3fOwQNexEW2sK0gP/BL0N0PL8B
         mX7bpNnj7iYuiQkedCtNOlH1czTZRS30lfglX3fBlwT/CINDs8IyzS9KTutqiUQxxDNQ
         CyD9D5M+v3+eacMAQEiax7CyeLyzlxXVEflT7oxPL3XCFxHxzCPLJSgnBKX+Q1VOFT+n
         9uYMXiCf2xYv+f9ZXEzoJDNYLmO+Iy9Te+KYc4QqvQw2SezagJq781cgLkmd6BAEqSb8
         SbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779078709; x=1779683509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aCwUis7hcNvoBcusHclileUNp7B3j+0iZpWDTdHqro=;
        b=gfuhXzO655qSpUYl+NCGKBkexSmB0Waxx0M9cMkhC1BO1kf0YtMbBxizA9MJujTmGp
         lp9L08TNyEY0PjnHxGN98TgipSVaAGZPdcIJbvaWgaYHAgiX19GFq2uK220R0/T1M2O7
         oR31xvpjQK3ZdZQjipad1zktCYqRB/m15Jatd01zS/1Ti1mHBrTmNVkwUoZ2kpGFuHXX
         gS8bcbOPjjr6OQ9b6QkN9unvKt/B2AEpANi/tGmZBXrODcxo4tgqSg/JxSFIXsSdsAN+
         atOaI1/F7i+5uyNNd3uqQJ0ku09xKD3U+oHICx3uKXW1BHopqjOPIUN0V8TnlpV7KFKj
         bNRQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Ce6G+gOFX2Ee48F2TDrSuVfvIrXFFctjBU0RTiWRfuYUG2i6Ebptz43xcgTGIrH8cEOgQZv1Hgo2ET3fUma/R@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2buf8KF1yGa/dHTlCRjxQxNvq8SVGE10OyNIROB/Xaa+CS2vZ
	1pGT7P2S5VxRoRUhg0ZAjkOdIjPnP//puTxir2qkvuiT8H0zoVSjuFO48DzU3j8pcPH9ELH2Slq
	+R2R9k1Q34A==
X-Received: from dybut1.prod.google.com ([2002:a05:7301:e0c1:b0:2f1:5dbf:fd4e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3009:b0:2ea:b7a9:580d
 with SMTP id 5a478bee46e88-3039816dab4mr5748603eec.9.1779078709162; Sun, 17
 May 2026 21:31:49 -0700 (PDT)
Date: Sun, 17 May 2026 21:31:39 -0700
In-Reply-To: <20260518043140.2522141-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518023225.2472122-1-irogers@google.com> <20260518043140.2522141-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518043140.2522141-2-irogers@google.com>
Subject: [PATCH v7 1/2] perf tests: Add test for uncore event sorting
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, collin.funk1@gmail.com, 
	german.gomez@arm.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, zide.chen@intel.com
Content-Type: text/plain; charset="UTF-8"

Add a test for uncore event sorting matching multiple PMUs. Uncore
PMUs may have a common prefix, like the PMUs uncore_imc_free_running_0
and uncore_imc_free_running_1 have a prefix of
uncore_imc_free_running. Parsing an event group like
"{data_read,data_write}" for those PMUs should result with two groups
"{uncore_imc_free_running_0/data_read/,uncore_imc_free_running_0/data_write/},
{uncore_imc_free_running_1/data_read/,uncore_imc_free_running_1/data_write/}"
which means the evsels need resorting as when initially parsed the
evsels are ordered with mixed PMUs:
"{uncore_imc_free_running_0/data_read/,uncore_imc_free_running_1/data_read/,
uncore_imc_free_running_0/data_write/,uncore_imc_free_running_1/data_write/}".

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Zide Chen <zide.chen@intel.com>
---
 tools/perf/tests/Build                  |   1 +
 tools/perf/tests/builtin-test.c         |   1 +
 tools/perf/tests/tests.h                |   1 +
 tools/perf/tests/uncore-event-sorting.c | 178 ++++++++++++++++++++++++
 4 files changed, 181 insertions(+)
 create mode 100644 tools/perf/tests/uncore-event-sorting.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index c2a67ce45941..66944a4f4968 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -3,6 +3,7 @@
 perf-test-y += builtin-test.o
 perf-test-y += tests-scripts.o
 perf-test-y += parse-events.o
+perf-test-y += uncore-event-sorting.o
 perf-test-y += dso-data.o
 perf-test-y += vmlinux-kallsyms.o
 perf-test-y += openat-syscall.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 06507066213b..f2c135891477 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -71,6 +71,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__basic_mmap,
 	&suite__mem,
 	&suite__parse_events,
+	&suite__uncore_event_sorting,
 	&suite__expr,
 	&suite__PERF_RECORD,
 	&suite__pmu,
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index f5f1238d1f7f..ee00518bf36f 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -177,6 +177,7 @@ DECLARE_SUITE(sigtrap);
 DECLARE_SUITE(event_groups);
 DECLARE_SUITE(symbols);
 DECLARE_SUITE(util);
+DECLARE_SUITE(uncore_event_sorting);
 DECLARE_SUITE(subcmd_help);
 DECLARE_SUITE(kallsyms_split);
 
diff --git a/tools/perf/tests/uncore-event-sorting.c b/tools/perf/tests/uncore-event-sorting.c
new file mode 100644
index 000000000000..594fe7ff7bf6
--- /dev/null
+++ b/tools/perf/tests/uncore-event-sorting.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include <string.h>
+
+#include "debug.h"
+#include "evlist.h"
+#include "parse-events.h"
+#include "pmu.h"
+#include "pmus.h"
+#include "tests.h"
+
+struct match_state {
+	char *event1;
+	char *event2;
+};
+
+static char *clean_event_name(struct pmu_event_info *info)
+{
+	const char *name = info->name;
+	const char *pmu_name = info->pmu->name;
+	size_t pmu_len = strlen(pmu_name);
+	char *res;
+	size_t len;
+
+	if (!strncmp(name, pmu_name, pmu_len) && name[pmu_len] == '/')
+		name += pmu_len + 1;
+
+	res = strdup(name);
+	if (!res)
+		return NULL;
+
+	len = strlen(res);
+	if (len > 0 && res[len - 1] == '/')
+		res[len - 1] = '\0';
+
+	return res;
+}
+
+static int event_cb(void *state, struct pmu_event_info *info)
+{
+	struct match_state *m = state;
+	char *clean_name;
+
+	if (m->event1 && m->event2)
+		return 1;
+
+	clean_name = clean_event_name(info);
+	if (!clean_name)
+		return 0;
+
+	if (!m->event1) {
+		m->event1 = clean_name;
+	} else if (!m->event2) {
+		if (strcmp(m->event1, clean_name)) {
+			m->event2 = clean_name;
+			return 1;
+		}
+		free(clean_name);
+	} else {
+		free(clean_name);
+	}
+	return 0;
+}
+
+#define CHECK_COND(cond, text)					\
+do {								\
+	if (!(cond)) {						\
+		pr_debug("FAILED %s:%d %s\n", __FILE__, __LINE__, text); \
+		ret = TEST_FAIL;				\
+		goto out_err;					\
+	}							\
+} while (0)
+
+#define CHECK_EQUAL(val, expected, text)			\
+do {								\
+	if ((val) != (expected)) {				\
+		pr_debug("FAILED %s:%d %s (%d != %d)\n",	\
+			 __FILE__, __LINE__, text, (val), (expected)); \
+		ret = TEST_FAIL;				\
+		goto out_err;					\
+	}							\
+} while (0)
+
+static int test__uncore_event_sorting(struct test_suite *test __maybe_unused,
+				      int subtest __maybe_unused)
+{
+	struct evlist *evlist = NULL;
+	struct parse_events_error err;
+	struct evsel *evsel;
+	struct perf_pmu *pmu = NULL;
+	char *pmu_prefix = NULL;
+	struct match_state m = { NULL, NULL };
+	char buf[1024];
+	int ret;
+
+	parse_events_error__init(&err);
+
+	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+		size_t len;
+		struct perf_pmu *sibling;
+
+		if (pmu->is_core)
+			continue;
+
+		len = pmu_name_len_no_suffix(pmu->name);
+		if (len == strlen(pmu->name))
+			continue;
+
+		sibling = pmu;
+		while ((sibling = perf_pmus__scan(sibling)) != NULL) {
+			if (sibling->is_core)
+				continue;
+			if (pmu_name_len_no_suffix(sibling->name) == len &&
+			    !strncmp(pmu->name, sibling->name, len))
+				break;
+		}
+
+		if (!sibling)
+			continue;
+
+		m.event1 = m.event2 = NULL;
+		perf_pmu__for_each_event(pmu, false, &m, event_cb);
+
+		if (m.event1 && m.event2) {
+			pmu_prefix = strndup(pmu->name, len);
+			break;
+		}
+		zfree(&m.event1);
+	}
+
+	if (!pmu_prefix) {
+		pr_debug("No suitable uncore PMU found\n");
+		ret = TEST_SKIP;
+		goto out_err;
+	}
+
+	evlist = evlist__new();
+	if (!evlist) {
+		ret = TEST_FAIL;
+		goto out_err;
+	}
+
+	snprintf(buf, sizeof(buf), "{%s/%s/,%s/%s/}", pmu_prefix, m.event1, pmu_prefix, m.event2);
+	pr_debug("Parsing: %s\n", buf);
+
+	ret = parse_events(evlist, buf, &err);
+	if (ret) {
+		pr_debug("parse_events failed\n");
+		ret = TEST_FAIL;
+		goto out_err;
+	}
+
+	CHECK_COND(evlist->core.nr_entries >= 4, "Number of events is >= 4");
+	CHECK_EQUAL(evlist->core.nr_entries % 2, 0, "Number of events is a multiple of 2");
+
+	evlist__for_each_entry(evlist, evsel) {
+		struct evsel *next;
+
+		if (!evsel__is_group_leader(evsel))
+			continue;
+
+		next = evsel__next(evsel);
+		CHECK_EQUAL(evsel->core.nr_members, 2, "Group size is 2");
+		CHECK_COND(evsel->pmu == next->pmu, "PMU match");
+		CHECK_COND(strstr(evsel__name(evsel), m.event1) != NULL, "First event name");
+		CHECK_COND(strstr(evsel__name(next), m.event2) != NULL, "Second event name");
+	}
+	ret = TEST_OK;
+
+out_err:
+	evlist__delete(evlist);
+	parse_events_error__exit(&err);
+	zfree(&pmu_prefix);
+	zfree(&m.event1);
+	zfree(&m.event2);
+	return ret;
+}
+
+DEFINE_SUITE("Uncore event sorting", uncore_event_sorting);
-- 
2.54.0.563.g4f69b47b94-goog

