Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918FE3A3828
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983268; cv=none; b=FslM7ucufj0QWwkErIvAbnKLrM9hSS3k1nq/Mh1GE/pB4VF1NFSTWiBX/jX6+bkx/0mobyDlqMbsUpDTQAcCcJ5f2bqzE3tLRpbryzeYLDgryXGkB2Qlup+9Wco47cXo0YrYb2+k0946Lfz3a00glUBJTaHy1P5EXLE3hwtGrdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983268; c=relaxed/simple;
	bh=3orYPD3QB4yX6PQ15sf5HywGOqRWxIKnyo2pIzYK8Kk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hhELVal4vfJuNo5NUEUGt1fdwpXIiqqcicONcYZ2hYJumEnBQxJpDnnPIRnnL5neDna+Fe3llwcnohWPAPs+ge9hzKBkYaIQDe2tcskfs4yocTOsVg6HN7BAVCch46yxu5mbfHK9JB2x+in96xzS/89j8QQHGjQp2SKmPl2WYKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jtsC+s3/; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtsC+s3/"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so7696965eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 11:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774983267; x=1775588067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzMILqX/Y0yJuUZYZeWmrcmvp8X/JhTFsXpLylvsAF8=;
        b=jtsC+s3/QL8FHL+majkR60NcHz7N1cSRhzG7EFCVJd6Fdj0EFGI1IN2D4NgJX+g8Qi
         4nY5Er44Mvi8OXnsjaXNplMQq0aLiPPc85ttKV2BeL1+u69wP1LiAATpCT7thh+OUkz/
         m2rQeBfsVZ5gVkQfCjKDmvcwcfPZ7Tzf6R/SWJS9j1TFNMLvo+iVZ2plvXIscGKhnfgY
         IdHGea2LQHu/R8pLJwjmz4NXBHrSX/m5GEOj+sBg/sYkLrNEeV3hDWJV9Tlua/B+B9NT
         8XGZmgpGmIMsVdY77s5XEath0KbbFWbDgwLByyH7Bkg12ZvhJll5CgO7weLpuGWhQR5x
         DEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774983267; x=1775588067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzMILqX/Y0yJuUZYZeWmrcmvp8X/JhTFsXpLylvsAF8=;
        b=RGisYrUj5WlBBcboGvIKj4SFdVvTCGbfZkg5f8M7iZvxgHdfcCgA8/KPP79NIFZXaz
         5u2WEb+IlppdMsb/PDfhNe1g59ATd/jJEGO59+CBb+JWGc1Vb1trETY6al3kW1LDHw9+
         CcqCPoQE7O4d3/uXpkW2Sg1m3iPqdZAarXx5MXDbfWmvyLgAuc2GeTqJTeX3pQ1sK6mc
         ycLqmTNaRPBVH1G8UBRvrpkfZJrc4MxPEPYlQNViCpRxXys1a4ayhkB2iOdHz8xylRUI
         0WtxbKeUFAvf8Dh01W+4pr/V05nqDKPh4RzACkZP+qAM6WPROR6oKRPbVyb6iXSTXcyx
         v0+A==
X-Forwarded-Encrypted: i=1; AJvYcCX7Bgqf18NW9Ev1QIbbIOrs87fQm+XYjH9CS21Ht+ktTkRD43fDPx7GoO/+r9GCIlY4qPLbNkNCOT9ZE0bjBgmY@vger.kernel.org
X-Gm-Message-State: AOJu0YyuhQ891PxwtulgJvcmHrDTnTdN2TFuS9RsSFZFqF7+IZkXBBZs
	E+IYaAXbyatBwcG8B/hkqzXoRKJKFqcg0dNGVDNNuQsSLqZMY/wQd69/fcFJMGWzIZY54+7XVgB
	e8YMVeVhkpA==
X-Received: from dycng19.prod.google.com ([2002:a05:7300:ce13:b0:2c6:6824:b731])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6085:b0:2c7:8e1c:9566
 with SMTP id 5a478bee46e88-2c9326aa4a0mr223577eec.16.1774983266429; Tue, 31
 Mar 2026 11:54:26 -0700 (PDT)
Date: Tue, 31 Mar 2026 11:54:18 -0700
In-Reply-To: <20260331185419.4085479-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331165207.4016392-1-irogers@google.com> <20260331185419.4085479-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331185419.4085479-2-irogers@google.com>
Subject: [PATCH v3 1/2] perf tests: Add test for uncore event sorting
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, 9erthalion6@gmail.com, acme@kernel.org, 
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	collin.funk1@gmail.com, german.gomez@arm.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	zide.chen@intel.com
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
 tools/perf/tests/uncore-event-sorting.c | 122 ++++++++++++++++++++++++
 4 files changed, 125 insertions(+)
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
index 000000000000..7e61e46283d5
--- /dev/null
+++ b/tools/perf/tests/uncore-event-sorting.c
@@ -0,0 +1,122 @@
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
+		ret = TEST_FAIL;
+		goto out_err;
+	}
+
+	TEST_ASSERT_VAL("Number of events is > 0", evlist->core.nr_entries > 0);
+	TEST_ASSERT_EQUAL("Number of events is a multiple of 2", evlist->core.nr_entries % 2, 0);
+
+	evlist__for_each_entry(evlist, evsel) {
+		struct evsel *next;
+
+		if (!evsel__is_group_leader(evsel))
+			continue;
+
+		next = evsel__next(evsel);
+		TEST_ASSERT_EQUAL("Group size is 2", evsel->core.nr_members, 2);
+		TEST_ASSERT_VAL("PMU match", evsel->pmu == next->pmu);
+		TEST_ASSERT_VAL("First event name", strstr(evsel__name(evsel), m.event1) != NULL);
+		TEST_ASSERT_VAL("Second event name", strstr(evsel__name(next), m.event2) != NULL);
+	}
+	ret = TEST_OK;
+
+out_err:
+	evlist__delete(evlist);
+	parse_events_error__exit(&err);
+	free(pmu_prefix);
+	free(m.event1);
+	free(m.event2);
+	return ret;
+}
+
+DEFINE_SUITE("Uncore event sorting", uncore_event_sorting);
-- 
2.53.0.1118.gaef5881109-goog

