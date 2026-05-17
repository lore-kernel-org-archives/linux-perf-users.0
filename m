Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770EA3CBE89
	for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 23:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779060544; cv=none; b=p1Kav0FzCqlbRgqixJVyni2mZgHIyCRxx64W/npCqvOo6NQ4r56fe3UMM/eVdlo7BP20TGSFAbq8WFsrAmMzapqcE9DP94AFvhLLe4s1i6ch/tneZwsk3ioTlWHF1ZFFhJFkwtUp5ZjC3WVZfbKhWtGgSxxVo4F1bZ2WQHRBBEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779060544; c=relaxed/simple;
	bh=emUhUChSYDRXlw7iXbh5f3JKcZHGMSGpt/sy6nitpiA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WTk5HYFCy0KBOnSEJgZRUte0x1DhiFqs09PiIRC1B4Vu++8+ODt74P+3oa5OE3RKdjwVUfTeCCeLB0w7S6cumqk4U9/HpOy+KtgF0hZxRLfe2sVEd6nycZJ/dx7A3AAdiFO4EOdbnIGvbZPdzeBXXHNVyDpTIpii914omigqXiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sIACUF/n; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sIACUF/n"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f2d983d109so5396674eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 16:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779060543; x=1779665343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/Y9zHLy4qsTi58K9h5pWrwlGq0WZMWoaLX4Qejjaq8=;
        b=sIACUF/nymQ4GdPkFmK2S2gVb7qGTo2wcrNhc8oms4YmLjN5Sxubp8Jq55z8lHVTXJ
         bzGaKcmb2k8/oeUtdmQZ/H5+tP9wtzB1CDUWrjmjuJOXfDUjMQq1nYHszdiP4kV8ddCW
         N72OIuq7vQ1YIxK3nXSwYc4+IdYE/Z5OUgGhfNhTm2n1U2IzHoVKLIDwD/Z5HfNLC9z3
         /nT/JE+BN1cNA/6Qkk8MCuQ7Dh70BHNN9gbsEfYFJ1amfFz/CI/3x9OsYmjr3tmJw6/K
         qEhCoscl8/+b37GJeV7QsT6KCn0s3n4j3KFCjwuigV2CmmhCQaOqYW8LQ2r2JYm2LCw3
         dPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779060543; x=1779665343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/Y9zHLy4qsTi58K9h5pWrwlGq0WZMWoaLX4Qejjaq8=;
        b=F/ISUaaya+aXQkdc9rEk65P3ZcOml3TlQmzMcTGMoa+4cnS6NNdR+AUb5V/VXxxA32
         Ef9PyhosmbQ+foR6Cb4knPR2FBjNxwdqOZ5DGLV9bqM2CPOWSkbehWxWUTUke0H29OvO
         R/y9/JIG9ZCKeTpY7F5UnGEg0ChC5fPchBiSGpB7iODjBCe6OgQiShVqucfxHxZc6pGp
         kL+frcqeUKcbbt9ZtMLRM/3xomvw2xuWAYeRhOYSfHhqihCFYgpYNwSnvvoTsN7M6rpX
         FVEbaolwKFPVgDTg2jiX0VRA82NxWnIDKlWdoHuBgS7SYFR96lcePlUKHVyEqKA4lrPc
         O8rQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9nUygbC4BOE7NyHv2WhoJlqco4b8tEtYUkvxu8WGHVm0EtF6gc8qXuKzU4vqNQXkUwAW2HYnWrVveb33CkyFu@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp4oh4KlKxH5Ki9r4wG+CN0+Us4XdQqP3MtedoapAIrLJfzvXI
	nfdl0gSGAJ4UdmQR5Xq6Y599mmhQiq8ZNkcVdDSa2APlZdpUKz03GYgMFPdek6Z8R/qY+bIrPA6
	4w4qZj4X1gw==
X-Received: from dybmw18.prod.google.com ([2002:a05:7300:cd92:b0:2d8:36c2:7c59])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a145:b0:2d9:6373:ad22
 with SMTP id 5a478bee46e88-30398172c1emr6008727eec.12.1779060542408; Sun, 17
 May 2026 16:29:02 -0700 (PDT)
Date: Sun, 17 May 2026 16:28:48 -0700
In-Reply-To: <20260517232849.2391357-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331185419.4085479-1-irogers@google.com> <20260517232849.2391357-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260517232849.2391357-2-irogers@google.com>
Subject: [PATCH v4 1/2] perf tests: Add test for uncore event sorting
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
 tools/perf/tests/uncore-event-sorting.c | 155 ++++++++++++++++++++++++
 4 files changed, 158 insertions(+)
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
index 000000000000..cab5ef49e2be
--- /dev/null
+++ b/tools/perf/tests/uncore-event-sorting.c
@@ -0,0 +1,155 @@
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
+	snprintf(buf, sizeof(buf), "{%s/%s/,%s/%s/}", pmu_prefix, m.event1, pmu_prefix, m.event2);
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
2.54.0.563.g4f69b47b94-goog

