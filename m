Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC82B3C9895
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713517; cv=none; b=CnHstB+dAS4uVMd6AxEjMOb/Fxl1dRFtkZHJP0HZsFi/IY34c3LfgiXapvga6Br/ufqXJQQR3OYHS27HX7ApLGtt8Umz/5Hbi80q8o5J1Xz7GWqzgh7L1lQXSue32rBgTgFZSUVTjBNeapzkuDv5F20WgZNiYXygfz22yvnTnKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713517; c=relaxed/simple;
	bh=5j8yob6u+OsaM7BT+K5RebG8rafqYly3m0cz164sTfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E4JH6YSsORHbtxBP0jnnlsecifYetfl0k1TAS3EwjLXqW66DNdIb08Dh/sR2m3/7rSvzam6ytKlrf6WCjRpdDeAsRLGpjG9y04Sq03SAafX6RuzarB0wr4TWORTWTe0wKrnMKOixUXyG8lMSqvBPN2Xj1sM0AJIYkGPSJ9+CPOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Op8jxs0d; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Op8jxs0d"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so6749920eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778713515; x=1779318315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HQR0P7r1dJHXaxzYmzaqi8CHt4EwEeEOgm2qhJAUkiY=;
        b=Op8jxs0dTltxXLG9gwgvQDodfdQenv9ZjflB+Kat57yFK0W7X1YWT1Stn0de2+PMMr
         Dw3/1zVlaUqzn6NNOzEDv3lck4j0BUplaLSg+fhqOxrdgrQMv3B+7aeiO90fy8XaKS+P
         znkcNMhNgRx/2XhIEARGmvCHBApZtFRdbdY7Cqg10u1D/nQYTBvcwfbYHp5IepqP6zm9
         NQiyy1BDNWDBH+jP45fJDWBHKz3f91/7iizr/DnhMV/CAwF3CtcopIVI7L5ev0m7O/1t
         ycZjFcMScrB63dJ7I0rCK4S5Q25Q4Xq5IBoVEGxFK6noplwFbwiMSCA/UxdxxkAf6P+4
         XWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778713515; x=1779318315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQR0P7r1dJHXaxzYmzaqi8CHt4EwEeEOgm2qhJAUkiY=;
        b=i5j4ak49P+WJqF7fn+DHp7vqBMuE3XpgajYOqQkb8MmhfHAFmfEKyV0kj5qvwzJHLx
         PJ4gcEs4dC4jMBeL0/ttU/kN5g7DAp88PSuMwBeUAmxiJLN0OqR25Hy3arv67ZBexX8o
         G8eHF41tNMUuBQEoe1Kw6t2ZIOga2UsDmWYQ08mscGca63PoH0x6ofiQmsxI+CTe1Qbj
         4OCb53XmEmELcsWapcvsDTzVXJys3k7SNxnjdqxmxdGu0q0l9ehFKdh+H1hCyAxAJmCr
         kqTV64H9DICb2xRmDEW6pfjvi+E0URqSS2Oe9/1cJdylJLeBtAjtA6K82baal8ntDCoE
         +T3A==
X-Forwarded-Encrypted: i=1; AFNElJ+UJDcM7lOXd3gSVNE9QS8loy8EQupnlZCfziXhyZF7i9noBDJlxd7vPtb9Uj53IYA1gRMoPY++mj3o0rM3LuZ+@vger.kernel.org
X-Gm-Message-State: AOJu0YyHQTRLwJZsetJk2mbZQE7VC/xs9+6hs8WYM76eX1IIKWzhZlrn
	t4Hfcsm54K/BYdPsKS9mSJOh8q0vIR3f30fFjTL4GJ/5zvKcYN0YauZ0Mv3RbiAqfwDHslkUoQg
	GjPuTr/gEeg==
X-Received: from dycqw27-n2.prod.google.com ([2002:a05:7300:c01b:20b0:2d6:2fd7:91f8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:3b0c:b0:2d9:db50:c6a5
 with SMTP id 5a478bee46e88-3011508250cmr3371595eec.0.1778713514767; Wed, 13
 May 2026 16:05:14 -0700 (PDT)
Date: Wed, 13 May 2026 16:04:41 -0700
In-Reply-To: <20260513230450.529380-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513230450.529380-6-irogers@google.com>
Subject: [PATCH v1 05/14] perf test pmu-events: A sub-test per metric table
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
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
 tools/perf/tests/pmu-events.c | 155 ++++++++++++++++++++++++++++++++--
 1 file changed, 147 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index a99716862168..56277737a824 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -903,13 +903,20 @@ static int test__parsing_callback(const struct pmu_metric *pm,
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
@@ -1000,8 +1007,8 @@ static int test__parsing_fake_callback(const struct pmu_metric *pm,
  * Parse all the metrics for current architecture, or all defined cpus via the
  * 'fake_pmu' in parse_events.
  */
-static int test__parsing_fake(struct test_suite *test __maybe_unused,
-			      int subtest __maybe_unused)
+static int test__parsing_fake_static(struct test_suite *test __maybe_unused,
+				     int subtest __maybe_unused)
 {
 	int err = 0;
 
@@ -1011,6 +1018,26 @@ static int test__parsing_fake(struct test_suite *test __maybe_unused,
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
@@ -1039,17 +1066,129 @@ static int test__parsing_threshold(struct test_suite *test __maybe_unused,
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
2.54.0.563.g4f69b47b94-goog

