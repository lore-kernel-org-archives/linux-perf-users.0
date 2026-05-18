Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02751A6823
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 00:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779064647; cv=none; b=V50cgn7scPRuLQeYXtnfRvbAGxpnPFugpwAVCAYa75QxpZlD2gKiJvQ/JLg79/uV2Ur2xr98/wJZqfttNYa/o9wjKrc6eUgH/kNKGCaiikygD1gUR3vf8Ahdr3Hd8iAGrlNxlf9DeaszyKNe3L4ORKoUBs1tt97dPofkhZl8ijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779064647; c=relaxed/simple;
	bh=ZDQs8kbb0wO+VIdA+TDCzfqHt/8dJvmAbe5q7SMHvV4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t+JE3TaeXljEB9sAnfuNFTj2K2sBTZ3wuzniBqmw9l9Ez/LmYi78BMe8nw8FZnRt04c28PBHRIXIg2k1RzYO1OjP852rLKiEe3FQqMBxImX1Hr+MfZcnqYcmZWudqgU/9FMzqqG3hjM6vrmpzgYi3aM08kwFM04bx6gzVxcxa7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JMhUq7iJ; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JMhUq7iJ"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so3460174eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 17:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779064645; x=1779669445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bDy/Ssc371Qm+hxVHDzphRc0ariV7XlzRk4o/94P0LU=;
        b=JMhUq7iJJmj+ISSZgsCs13eOwJE77IsdGikyQ4jyEYj3FAdS6CaKDI1Wr72SMaVbEA
         Gdr07ZCmICR491KLQrI+0dOCE5Q1QVTBCDOTAzMppqBHprflmJpbPG1ABMbWU1MUXhsw
         3cViN6kDzQS0eBUfj3T6dR24L/dnxkx0Q6+aW1JrHmojhgS1TlL9IMfSVGN+nMK6WWFm
         GS2I2A/s/ARzq/d0o8kB49mBc78lAOicYsABqJKoraJF+xGgYu4fQfvW6ggo13zMgmcR
         jFLiSVMGdrDS5zaz5H8YeY4CufOhT/km+vFtDMX1h9gxR9+MtlCbBG7RtUbXt8eM38/A
         01lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779064645; x=1779669445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bDy/Ssc371Qm+hxVHDzphRc0ariV7XlzRk4o/94P0LU=;
        b=IIS51YbwyOGK/lS+Io7jaTB/1pgCJkf7o0bNGDoxTFx8EBZYA78KU9aAC5GBhrbPv1
         JeHkjpNfPeb5JwEtq+SfDUCImEeHxL4+1NEnCE72+NLYo/3cUHLkjDNJ0MkzgXnCQJ3R
         ECD8GnDDZqchhwONA19KCxHtZtY8fN2XTLAwhQjqFYjX+rn3x472Kswvt5P42WT3QGn+
         tbGPoamyAzeJ3Qd0fbpnJR5iRilfAjCpIxNLv0+BWwhzVWwTJUmipZ6w4rEvtKuzYH9V
         yklb7CjSKjRWmgM5/IzJT3Vb+VoFaGZm2nPs3iIa7nmTSK/qkHkG2DKUDmvB9PHDWIHK
         QIoA==
X-Forwarded-Encrypted: i=1; AFNElJ+6ZIIR9tD5pryDq96fatx6GYVpgEahWYndK4VpWWGq+V+CqStk+R6sdFuVIfTwwCovRA0UQdIIIIf5KriiKwDc@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ7NuxN68O+Gr/W3pDcBg2nhEmk1rWgzdiX+v+SBliA8B4BoZD
	9/IHncfKCuPp0HQlhC0qWYAQGUaGCw01+MpljyqQSk/jP1+ldL+GbhTDlK1VK+/GJE+59x5smmG
	IUmNL34wykA==
X-Received: from dlbeg39.prod.google.com ([2002:a05:7022:fa7:b0:135:68e0:f3ac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6628:b0:128:d5bd:3572
 with SMTP id a92af1059eb24-1350484c6dbmr5864223c88.31.1779064644638; Sun, 17
 May 2026 17:37:24 -0700 (PDT)
Date: Sun, 17 May 2026 17:37:03 -0700
In-Reply-To: <20260518003704.2434308-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260517232849.2391357-1-irogers@google.com> <20260518003704.2434308-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518003704.2434308-2-irogers@google.com>
Subject: [PATCH v5 1/2] perf tests: Add test for uncore event sorting
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
 tools/perf/tests/uncore-event-sorting.c | 174 ++++++++++++++++++++++++
 4 files changed, 177 insertions(+)
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
index 000000000000..8d10b0d84fe7
--- /dev/null
+++ b/tools/perf/tests/uncore-event-sorting.c
@@ -0,0 +1,174 @@
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
+	free(pmu_prefix);
+	free(m.event1);
+	free(m.event2);
+	return ret;
+}
+
+DEFINE_SUITE("Uncore event sorting", uncore_event_sorting);
-- 
2.54.0.563.g4f69b47b94-goog

