Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41FE31AABF
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205276; cv=none; b=R14m+/NHuG69J+UZoNM7UqNrCOB/eTuoAaeDLQS0FiZAdg2++55Jvoa/FdNXo8BQm4+nfGFqNuh4Y2bX1alstohEbPDxbx/LWusiY7rnnlSL+G2Ee7N8z/xQreE5klFnytZm8aQo5+UELPVg7r/looMxy+rEzvJ5Pr1FoIeaArs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205276; c=relaxed/simple;
	bh=CSIO2Y0sg41/cu9R1dFtAHHzhJKrNoNKDs13LTZFHYs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M/dWpkU1uua/erTjCZNtzLNkfKYUOiex2JlBObGcQ6rMI1oUxb9Sp/GDUB2Jivt+Q7IRzjxEAG5HMN5JgGJtkK7TTPphW+Va+Q2fCDDENibjk6alfyYJskQspFDtBs3VPXBwCMb83gWQWdRXNlXE2zP3NcjYca8A+wOXDKk46T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hdFDQzIW; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdFDQzIW"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304e4636205so5940722eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 22:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780205274; x=1780810074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KKoQkAWAzKW5rOAQ0dJK5YvEF2dAkJqpt7cQ5fkwsmQ=;
        b=hdFDQzIWIZLHGHmk2Vwys3cj7CYSqxg4XRCXcv/Tq0VSB3KEeEfKMvLIbV9qVFJniU
         xfJ+DRO1ATGRr1jB3ajmirM7rpIe7B50jtZuFrAswNrazgyKM4Pm0aJD/tEYUToIUl5l
         QCykFv3hgX68OM18dHXu/IKsneO00rBnN9sotVhgXEBC+l05FKMT084O0Gw1OniSwy+F
         3gibB8e6HSdrfXi6O603P4mq+6BSY9VeWeGfUFdLdM25IpBN1VKutZo7T2WIWdf506BW
         qCLOvK1uuyIclGw1R2/1We7rVQXl7pdeUFIZqYVFXqGaDBaspjIf+hH4Zmv7uRpp27yt
         nFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780205274; x=1780810074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKoQkAWAzKW5rOAQ0dJK5YvEF2dAkJqpt7cQ5fkwsmQ=;
        b=aOQfeZG/tM+xDDIr0O+qajjm0rMe0ipc89RbxnpdX+/pZg8IcWaA/iFfCrQ/ECTkJw
         vz+2nx3yulMw3LU5shCAnk/349wrEiPhBT/jjYmUwkKr4ggCbqWncHH+kn528KGztLNJ
         r/1FQYdpP1gOkd0W7PjFqaQK7Ja/8GP3W0dWuzImJlFarqbc/Si1kIRWvSOUKtEXq1hu
         CBBXu/aPXcm/BGfvpw9dFVU9e29dFCw1vVxTShZQSUf+2qzntJ+VjF/B9TXcNNNrQyOy
         suhw2saf/YBGS3PP/ROb5inz6GB8M8QTLxcV8nfSDh/QIU6Bs7mZRRwJq5mUHEkIYQNg
         eYOw==
X-Forwarded-Encrypted: i=1; AFNElJ9ySuy6DMTCbD7oIodwQLTJB/ofhBWfIiZYh7kOkd6HTVQHmZbh+hICUZ5u4nU5SvZadlQXUE/AQE6bodMSrvZj@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn0RbKg6orASXUv/XT1iglvJhPWc+mMeWqZgQy0Y+Sk9pgtL8a
	8d2lqtGLrB1QvKL1Yl9J8rOO5tppeATsofNpJ0OuNFRBVaPYHgzZJ0Kd5L5JRYuSK+D2UZ65UEp
	NGWSWCheb0Q==
X-Received: from dyfv8.prod.google.com ([2002:a05:7300:8248:b0:304:ab3:5b73])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7243:b0:304:eaa8:11ea
 with SMTP id 5a478bee46e88-304fa781775mr3338197eec.34.1780205273744; Sat, 30
 May 2026 22:27:53 -0700 (PDT)
Date: Sat, 30 May 2026 22:27:31 -0700
In-Reply-To: <20260531052740.796087-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com> <20260531052740.796087-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531052740.796087-6-irogers@google.com>
Subject: [PATCH v2 05/14] perf test pmu-events: A sub-test per metric table
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Break apart the slow "Parsing of PMU event table metrics" tests into
one pair of tests (real and fake PMU) per metric table found, storing
the specific table pointer in priv data.
Implement setup_pmu_events_suite() to dynamically allocate and populate
these test cases.
Split static parser tests out into a separate test__parsing_fake_static()
test case.
Update test__parsing() and test__parsing_fake() to retrieve the specific
table from priv data and test only that table, maintaining fallback
compatibility if priv is NULL.

Running these individual tests in parallel significantly reduces
overall test execution time.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu-events.c | 156 ++++++++++++++++++++++++++++++++--
 1 file changed, 148 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index b1609a7e1d8c..5088ceae3dd6 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -923,13 +923,20 @@ static int test__parsing_callback(const struct pmu_metric *pm,
 	return err;
 }
 
-static int test__parsing(struct test_suite *test __maybe_unused,
-			 int subtest __maybe_unused)
+static int test__parsing(struct test_suite *test, int subtest)
 {
 	int failures = 0;
+	const struct pmu_metrics_table *table = NULL;
 
-	pmu_for_each_core_metric(test__parsing_callback, &failures);
-	pmu_for_each_sys_metric(test__parsing_callback, &failures);
+	if (test->test_cases)
+		table = test->test_cases[subtest].priv;
+
+	if (table) {
+		pmu_metrics_table__for_each_metric(table, test__parsing_callback, &failures);
+	} else {
+		pmu_for_each_core_metric(test__parsing_callback, &failures);
+		pmu_for_each_sys_metric(test__parsing_callback, &failures);
+	}
 
 	return failures == 0 ? TEST_OK : TEST_FAIL;
 }
@@ -1020,8 +1027,8 @@ static int test__parsing_fake_callback(const struct pmu_metric *pm,
  * Parse all the metrics for current architecture, or all defined cpus via the
  * 'fake_pmu' in parse_events.
  */
-static int test__parsing_fake(struct test_suite *test __maybe_unused,
-			      int subtest __maybe_unused)
+static int test__parsing_fake_static(struct test_suite *test __maybe_unused,
+				     int subtest __maybe_unused)
 {
 	int err = 0;
 
@@ -1031,6 +1038,26 @@ static int test__parsing_fake(struct test_suite *test __maybe_unused,
 			return err;
 	}
 
+	return 0;
+}
+
+static int test__parsing_fake(struct test_suite *test, int subtest)
+{
+	int err = 0;
+	const struct pmu_metrics_table *table = NULL;
+
+	if (test->test_cases)
+		table = test->test_cases[subtest].priv;
+
+	if (table)
+		return pmu_metrics_table__for_each_metric(table, test__parsing_fake_callback, NULL);
+
+	for (size_t i = 0; i < ARRAY_SIZE(metrics); i++) {
+		err = metric_parse_fake("", metrics[i].str);
+		if (err)
+			return err;
+	}
+
 	err = pmu_for_each_core_metric(test__parsing_fake_callback, NULL);
 	if (err)
 		return err;
@@ -1059,17 +1086,130 @@ static int test__parsing_threshold(struct test_suite *test __maybe_unused,
 	return pmu_for_each_sys_metric(test__parsing_threshold_callback, NULL);
 }
 
+struct populate_cb_data {
+	struct test_case *test_cases;
+	size_t curr;
+};
+
+static int count_metrics_tables_cb(const struct pmu_metrics_table *table __maybe_unused, void *data)
+{
+	size_t *count = data;
+	(*count)++;
+	return 0;
+}
+
+static int populate_metrics_tables_cb(const struct pmu_metrics_table *table, void *data)
+{
+	struct populate_cb_data *cb_data = data;
+	const char *table_name = pmu_metrics_table__name(table);
+	char *desc_real, *desc_fake;
+
+	if (!table_name)
+		table_name = "unknown";
+
+	if (asprintf(&desc_real, "PMU metric parsing: %s", table_name) < 0)
+		return -ENOMEM;
+	if (asprintf(&desc_fake, "PMU metric parsing with fake PMU: %s", table_name) < 0) {
+		free(desc_real);
+		return -ENOMEM;
+	}
+
+	cb_data->test_cases[cb_data->curr++] = (struct test_case){
+		.name = "parsing",
+		.desc = desc_real,
+		.run_case = test__parsing,
+		.priv = (void *)table,
+		.skip_reason = "some metrics failed",
+	};
+
+	cb_data->test_cases[cb_data->curr++] = (struct test_case){
+		.name = "parsing_fake",
+		.desc = desc_fake,
+		.run_case = test__parsing_fake,
+		.priv = (void *)table,
+	};
+
+	return 0;
+}
+
+static struct test_case pmu_events_tests[];
+
+static int setup_pmu_events_suite(struct test_suite *suite)
+{
+	size_t num_tables = 0;
+	size_t num_fixed_tests = 4;
+	size_t tests_per_table = 2;
+	size_t total_tests;
+	struct test_case *test_cases;
+	size_t curr = 0;
+	struct populate_cb_data cb_data;
+	int ret;
+
+	if (suite->test_cases != pmu_events_tests)
+		return 0;
+
+	ret = pmu_metrics_table__for_each_table(count_metrics_tables_cb, &num_tables);
+	if (ret)
+		return ret;
+
+	total_tests = num_fixed_tests + (num_tables * tests_per_table) + 1;
+
+	test_cases = calloc(total_tests, sizeof(*test_cases));
+	if (!test_cases)
+		return -ENOMEM;
+
+	test_cases[curr++] = (struct test_case){
+		.name = "pmu_event_table",
+		.desc = "PMU event table sanity",
+		.run_case = test__pmu_event_table,
+	};
+	test_cases[curr++] = (struct test_case){
+		.name = "aliases",
+		.desc = "PMU event map aliases",
+		.run_case = test__aliases,
+	};
+	test_cases[curr++] = (struct test_case){
+		.name = "parsing_fake_static",
+		.desc = "Parsing of static metrics with fake PMU",
+		.run_case = test__parsing_fake_static,
+	};
+	test_cases[curr++] = (struct test_case){
+		.name = "parsing_threshold",
+		.desc = "Parsing of metric thresholds with fake PMU",
+		.run_case = test__parsing_threshold,
+	};
+
+	cb_data = (struct populate_cb_data){
+		.test_cases = test_cases,
+		.curr = curr,
+	};
+
+	ret = pmu_metrics_table__for_each_table(populate_metrics_tables_cb, &cb_data);
+	if (ret) {
+		size_t i;
+
+		for (i = num_fixed_tests; i < cb_data.curr; i++)
+			free((char *)test_cases[i].desc);
+		free(test_cases);
+		return ret;
+	}
+
+	suite->test_cases = test_cases;
+	return 0;
+}
+
 static struct test_case pmu_events_tests[] = {
 	TEST_CASE("PMU event table sanity", pmu_event_table),
 	TEST_CASE("PMU event map aliases", aliases),
 	TEST_CASE_REASON("Parsing of PMU event table metrics", parsing,
 			 "some metrics failed"),
-	TEST_CASE("Parsing of PMU event table metrics with fake PMUs", parsing_fake),
-	TEST_CASE("Parsing of metric thresholds with fake PMUs", parsing_threshold),
+	TEST_CASE("Parsing of PMU event table metrics with fake PMU", parsing_fake),
+	TEST_CASE("Parsing of metric thresholds with fake PMU", parsing_threshold),
 	{ .name = NULL, }
 };
 
 struct test_suite suite__pmu_events = {
 	.desc = "PMU JSON event tests",
 	.test_cases = pmu_events_tests,
+	.setup = setup_pmu_events_suite,
 };
-- 
2.54.0.823.g6e5bcc1fc9-goog

