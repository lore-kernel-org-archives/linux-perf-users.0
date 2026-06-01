Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208342AEF5
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 00:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272368; cv=none; b=Zr9dJel8bm7Fbk9+GrF33QmXxT6bbL9uYu3Hxj9beAs3c5rdTA//Xbl3IH15IQFBFNhkY2qmPCrgMtXtttAxmHDkb+/2HMx336VW7q/fg0q7ZSzhQ/cp1tyX/sC18GsgND7vyS0o5UbPpI8zLLjzDdKLPCruSteltOEWDBbpeTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272368; c=relaxed/simple;
	bh=CSIO2Y0sg41/cu9R1dFtAHHzhJKrNoNKDs13LTZFHYs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UJdDQAoixZzTmLvcC70Ps5cwlXiqtvXqkPB+fwSzAkHpg3pNwyx1ZZrnlAlQaBLIRaC4+Mz9BPMC+YFXCUREV8P8+t6Pui+M6RaSw3b4/PApQCEDTYaoplriBRd9xLZm9S1VJU6Pc6zLr/BN1OCcvgJTPqNmOnfU53YSmZOsWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EFpRbwFP; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFpRbwFP"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13537722193so11832623c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 17:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780272366; x=1780877166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KKoQkAWAzKW5rOAQ0dJK5YvEF2dAkJqpt7cQ5fkwsmQ=;
        b=EFpRbwFP/+dPKXofUkRfHCLlB2QuFKYPBrtA0G5ZJ+IlWZgH2Fu4Il3vZNurtSOu6i
         0WPJjdvbDdkDwTU+K/YOT/tP1hGF4+qpdsiI1cNiAKZ9U7JtbRLcoiiKg58FI7fxL9Ej
         3eqShtMnLSnviKc5rtI5fI7o7LzzkvTjElcaYDivA7tdqLjzQvZCwc4C79VeWhD09WQI
         54I9+3+rE2HXmFHVxaMeQtq66ptik3MKsE5PxSCMZpasutaTMQmhkcxm7N5B91a3T3Aj
         /y6+S6Weo5t6bmIBP5ah0f3SCniW/1ovn10sRcc9JI0y0ohK2g6LM2gZEA8HSzZvyrFh
         mB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780272366; x=1780877166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKoQkAWAzKW5rOAQ0dJK5YvEF2dAkJqpt7cQ5fkwsmQ=;
        b=V46wvKWaH8m5Nwqm0dsNxqOCsBQ7a5EwPHXex+mXrcJk/Vmc0H+8i1bVJJcHvI7eek
         hIKF/l5cJm1Q8eyjMWLzlSIZ6W+EKdkSt+RjdD/Z1EsleBkiu4N0LWJeATdf8CrSNuYn
         XBzKLgvywk1plg1HwQEAJtNaLoxsXhYlEZxLMwDmbJDfBi7+7C6w+cOB+Q5h6pZw4vZz
         dCaKRAA1VxCtH8b1knTFJ+uCUl2jb7gEcFhxyR12EcS9hEMA+o+KWrtkXO0pJ1yE+G9Q
         EW0eQddKVlU7EmZsCDlJy+4LzxIFnhyc5o2SowP1JM8tkCrgq9KBlp//0Uqp/zD1Es8s
         NRRg==
X-Forwarded-Encrypted: i=1; AFNElJ/VeKQ7xmZN9bbk7k/CR8TuNfrZ3PxgzYgptJ/Lj712pcfTiCkNSc/IrGMP/IbRYxd6bJVU1BHLfUiT3tUlw42b@vger.kernel.org
X-Gm-Message-State: AOJu0YzhdQDMNValH1QqqOuWPwWsRUmUUmg40tTLr4A+0GiaIvAMbMTj
	1Ht1JAIshEF/czHKXHwvMkE5eEA1toW+syKYb4jlMJSXQJTAtgoSn5s7kb4DaYiujSKbczfe2/S
	QAKIUEIWJzw==
X-Received: from dlbcj19.prod.google.com ([2002:a05:7022:6993:b0:132:8d92:4d6c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6083:b0:12d:de3f:d847
 with SMTP id a92af1059eb24-137d42593a3mr4036456c88.42.1780272365978; Sun, 31
 May 2026 17:06:05 -0700 (PDT)
Date: Sun, 31 May 2026 17:05:38 -0700
In-Reply-To: <20260601000548.1195604-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531082235.940833-1-irogers@google.com> <20260601000548.1195604-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601000548.1195604-6-irogers@google.com>
Subject: [PATCH 05/15] perf test pmu-events: A sub-test per metric table
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

