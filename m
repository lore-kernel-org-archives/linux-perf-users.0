Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E796A3A6EED
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779085755; cv=none; b=cwgsVJ9HyomVbdQqFtP3yljyzkK2imlmKxTwEachPrf28hMCYTKBg/3XsovygWuonGC9S3/H+7D4aw//eGycJukvejQYbb0QK4an1M2BKw8tkdkcEnMbiLlL/FBGY8RQkWJvC1mxhEEm2Wm6EBvSz9IQmJ8d4NXtPpDCZmLW3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779085755; c=relaxed/simple;
	bh=5AEb8CpNcgxavaj0/Q2pbaNnCmXK3dZvd3aKtjUJhWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bzUigj40sk4ccOBbKhIbNs1CjJp6KRKQl/R8oe/F5wV7fgH+OUX4Si3NOjUANJ8mY3GVgiK/TEoNH/352XEJPK7SZGdoeOAWCWOXjB/gFX8gk5WnW8tcwdb0tigWteO6oACCAk4Cl0nU+H70wweITugFo2GHMkxnqS863DXYFmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JXFEaWTM; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXFEaWTM"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f1383b7439so2233946eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 23:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779085750; x=1779690550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/Zd7KLf77p5kYlpKwaADZD2UKBsJqwfYby1zpdvu0s=;
        b=JXFEaWTMQ7ojMRucRCW11q2SlKvv6oi/AiAjPfTtohWhJCwp1eKB86149ZA/pcvJpP
         v5fIMDwiUP0Tav9NL1hqQwtNysnnsur813ZXLpbcSeZ4j5BJnijYdO1mPOn8bO6+8ddN
         ilPnofXSOljUxtb5Ib4aJqtljJ7gRQsXAkFBzWfozPDmH371dMM9DtB9isxPI+s06irr
         FG/YwxvP2afRhZYZS7ZPn6Vc+1kbJULOdDPZ3Z7RLITgcN7LmfaTpXib+eJ0u8D1HJN6
         xZpQWx9TbhwGTsCVfjNOlF3UG7eN7ZmIlxAbXalQUcHBrUROg8//VNUqChGdI/NKowqP
         hW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779085750; x=1779690550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/Zd7KLf77p5kYlpKwaADZD2UKBsJqwfYby1zpdvu0s=;
        b=MSyTU+ViohdUS7KDShWT0ku0ZKpuBlwFxsIjQYmpF/4Xi1BnBMkBrTmkKG732sJ9ca
         x/6KYyJy9ITxwDZeWP8kzmw0wTnaO3v3PhI4UwyLSCLUNykFk2U5VyfNB4svFpeQBPhx
         PjSBJVvkJXwel+yV7Kh09L8PAb/gmN5KnSQqYOyw1FKGHXUSOVhUC1IS/DmcsNMb+vKF
         LTDqVR6A+T9L/aSMuIqie4IMUxagHN1znSpzVv30hr4LpsRWYjvrYpAlAWdqvPq1dp7z
         BnJv6UOsvH9Nz2Wkw/RjtluLelAsAIPCJI18AbM/eeQ+6Zv1ropuIcJXdtyA7j9DaKo8
         RmFg==
X-Forwarded-Encrypted: i=1; AFNElJ/2K9VZ4N8/flG7ccTWCb+W4qvvYL2vfW3dsI2LzFSNguCRmIbQqeHA8akQ6X/RGB+gaoSphhGqPTQM4yeYGapQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Jid6cHlNQegwGkqvlYbC9eKpahRH5faQpkTJ8X/T/Dg8vT8L
	8qiJGc3zRWcq9lDRk9lEpRduLMtV1u5i4C6lHCCqRX11WTrrPUyLJ2cEhPXW8nuVX6dQKbISxQQ
	8yUJUX+J8Fg==
X-Received: from dlbbu10.prod.google.com ([2002:a05:7022:220a:b0:12c:1ff3:9fa4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:427:b0:135:2588:6314
 with SMTP id a92af1059eb24-135258863a8mr4112384c88.8.1779085750028; Sun, 17
 May 2026 23:29:10 -0700 (PDT)
Date: Sun, 17 May 2026 23:29:03 -0700
In-Reply-To: <20260518062904.2591616-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518043140.2522141-1-irogers@google.com> <20260518062904.2591616-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518062904.2591616-2-irogers@google.com>
Subject: [PATCH v8 1/2] perf tests: Add test for uncore event sorting
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
 tools/perf/tests/uncore-event-sorting.c | 176 ++++++++++++++++++++++++
 4 files changed, 179 insertions(+)
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
index 000000000000..7d2fc304e21f
--- /dev/null
+++ b/tools/perf/tests/uncore-event-sorting.c
@@ -0,0 +1,176 @@
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
+	} else {
+		if (strcmp(m->event1, clean_name)) {
+			m->event2 = clean_name;
+			return 1;
+		}
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

