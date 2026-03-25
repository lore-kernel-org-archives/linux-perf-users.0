Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822D31EE00A
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774463463; cv=none; b=NFEhW8f6z7OKX0QyO11RMPZn5UHgUq9FkNVCMQRICk1T3Ui2Ak9KjhvWODWN80v/sCYnKr3f1w20mJFK6EOtgOXaXH/PdEvaeyPGlBB99dQteuPDgcMQvqO1QyK/VztOwkK+APUoliVyYyRbfCWC/JsjEsuQua9GbYwSI2gt4WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774463463; c=relaxed/simple;
	bh=0WOy2NZ8brl4GT27BE3KFiJ/dvJfyupGxapI//1TW38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=PPTJ05Hnc0vvA7si76WSWu8SmzLMPrdjlCNbcjshI9/lP0TCx1lnwDRyVVPB6E8K4Cs+7zwYB7gZ5nhN/zpXbOGVtPK48EnAkh0xUQDtBeYch2UkPx2LxnsAcZ7I/rr5M+WFtXL7kvfrXsfP5JXnVl8CsKf5qJoViNC74lA4RX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vz12U0Ow; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vz12U0Ow"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1275c6fc58aso151120c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774463462; x=1775068262; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aPgOPsAhWCfNO17xOm73Nfj9+10gwnemPMV7tmJj/Rg=;
        b=vz12U0OwkPgLymbAyyI2ce161cxKyDpdtlLfe1vsJxk4QJ0uGL357WzL4HdM+XiVZH
         +VZXM5Zvmi1cAseOxGITbj4PA+X9DNzTezbRReSLab6NgbnRIUMVpbv3vGt3ZLZRcBxV
         ulfu7XHr84v72snKmSnnAS3jIBiJDWWhoh9w0lVaSa/zd2tyBSF47Z1BNJ0/QkCWK1IX
         jyqULv3rutnjWb1RWW2XpWxITa/3qPQ1Es+Y6oUDfddv2rnBmvTaFwsgci4PlI+ZbTA/
         8T55P+xIfntNer2Ar9UL1wl1sa1BtOMilD5gbcERNLxkdAjTL2Og1X5cca9InSVNzj6Y
         cedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774463462; x=1775068262;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPgOPsAhWCfNO17xOm73Nfj9+10gwnemPMV7tmJj/Rg=;
        b=LBoJtRUvsl6qsmpsHhqVqMb1Gv8disxjY/zOp5e+ScO4wdxbxule4lYgW3z8Dbv1fo
         qX/VLysaSYK7WisTIT36Gf5T2ek6DQvv9gaa9Sdq//a7r+EBsjdQ9G6X5OpLgZw+ULLE
         nkeH9TqLflk39n11PqT2U5NussThfk1HBGFIMxdrUk7eQBueVLuZbfcYVJgGyyLn/znh
         oVm7lToV5sHU9c2nh0zeUTZqqm93wrwgSGQccfSsd3XlKCaw7wlBEPaPe0xLyajDyAkz
         TvCS42tS0EB2i0Fqi198h8a7O0XCkXs1L42PvOcQktamURzUWtv6xrJXfzWLPCM+ALEt
         s9zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqTFfps0IWPB//kMHkfTnO1sVlxeuyzTKbTTY78eUcy2wNu9rV2vIsBKwc+q3/5DXAjdeGEpgOAqFn0B7vjP8r@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+ALVvzYutDp40H2+W9j7xvGb1w5majYN62PV7eATaYdp7kFI
	56gRPP1cu6iPgWcbSi9gaTk21NtYfaVMk2HfKtrRuAAvMjM9R/V6iqgc+hEouDdGXQch48ZuhgB
	A6gBX3UB4Tg==
X-Received: from dlb34.prod.google.com ([2002:a05:7022:622:b0:12a:78f6:c8f6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:618b:b0:128:d715:b717
 with SMTP id a92af1059eb24-12a96e5ea93mr2281132c88.13.1774463461518; Wed, 25
 Mar 2026 11:31:01 -0700 (PDT)
Date: Wed, 25 Mar 2026 11:30:44 -0700
In-Reply-To: <20260325183045.1229502-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260325183045.1229502-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325183045.1229502-2-irogers@google.com>
Subject: [PATCH v1 1/2] perf tests: Add test for uncore event sorting
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, German Gomez <german.gomez@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
---
 tools/perf/tests/Build                  |   1 +
 tools/perf/tests/builtin-test.c         |   1 +
 tools/perf/tests/tests.h                |   1 +
 tools/perf/tests/uncore-event-sorting.c | 125 ++++++++++++++++++++++++
 4 files changed, 128 insertions(+)
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
index 000000000000..91e1a580709b
--- /dev/null
+++ b/tools/perf/tests/uncore-event-sorting.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+#include "tests.h"
+#include "debug.h"
+#include "parse-events.h"
+#include "pmu.h"
+#include "pmus.h"
+#include "evlist.h"
+#include <string.h>
+
+struct match_state {
+	char *event1;
+	char *event2;
+};
+
+static int event_cb(void *state, struct pmu_event_info *info)
+{
+	struct match_state *m = state;
+
+	if (!m->event1) {
+		m->event1 = strdup(info->name);
+	} else if (!m->event2) {
+		if (strcmp(m->event1, info->name)) {
+			m->event2 = strdup(info->name);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static int test__uncore_event_sorting(struct test_suite *test __maybe_unused,
+				      int subtest __maybe_unused)
+{
+	struct evlist *evlist;
+	struct parse_events_error err;
+	struct evsel *evsel;
+	struct perf_pmu *pmu = NULL;
+	char *pmu_prefix = NULL;
+	struct match_state m = { NULL, NULL };
+	char buf[1024];
+	int ret;
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
+		free(m.event1);
+	}
+
+	if (!pmu_prefix) {
+		pr_debug("No suitable uncore PMU found\n");
+		return TEST_SKIP;
+	}
+
+	evlist = evlist__new();
+	if (!evlist)
+		return TEST_FAIL;
+
+	snprintf(buf, sizeof(buf), "{%s/%s/,%s/%s/}",
+		 pmu_prefix, m.event1, pmu_prefix, m.event2);
+	pr_debug("Parsing: %s\n", buf);
+
+	parse_events_error__init(&err);
+	ret = parse_events(evlist, buf, &err);
+	if (ret) {
+		pr_debug("parse_events failed\n");
+		goto out_err;
+	}
+
+	TEST_ASSERT_VAL("Number of events is > 0", evlist->core.nr_entries > 0);
+	TEST_ASSERT_EQUAL("Number of events is a multiple of 2", evlist->core.nr_entries % 2, 0);
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_group_leader(evsel)) {
+			struct evsel *next = evsel__next(evsel);
+
+			TEST_ASSERT_EQUAL("Group size is 2", evsel->core.nr_members, 2);
+			TEST_ASSERT_VAL("PMU match", evsel->pmu == next->pmu);
+			TEST_ASSERT_VAL("First event name", strstr(evsel->name, m.event1) != NULL);
+			TEST_ASSERT_VAL("Second event name", strstr(next->name, m.event2) != NULL);
+		}
+	}
+
+	evlist__delete(evlist);
+	parse_events_error__exit(&err);
+	free(pmu_prefix);
+	free(m.event1);
+	free(m.event2);
+	return TEST_OK;
+
+out_err:
+	evlist__delete(evlist);
+	parse_events_error__exit(&err);
+	free(pmu_prefix);
+	free(m.event1);
+	free(m.event2);
+	return TEST_FAIL;
+}
+
+DEFINE_SUITE("Uncore event sorting", uncore_event_sorting);
-- 
2.53.0.1018.g2bb0e51243-goog

