Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508342F6596
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780209481; cv=none; b=OorOIFGRTGOgTd6bNhUSM9G8z39G3v2fqjQMemqZqerPo/3T50jFMJzmDaX3POdLiD9pUFS8jNusXbQ5OnG8jfXKlsRAEcp1Iaak7wQzWCslIHB0noI271zsodoP2YUuB4KAp3OhhfTEq9iAJFFPzjw47NE2/GFjT9O7SzmPVgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780209481; c=relaxed/simple;
	bh=CSIO2Y0sg41/cu9R1dFtAHHzhJKrNoNKDs13LTZFHYs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PDWWUIyuBlLJtHUcj0VXAwfl3b29X1rKFtp7I82zdVbN0uiW+8eOFC61GDbiUb2BTJ08V9IFHOYPWTLhaoPlbBe7iBU3p1aVuZS2kRhwnJmgc25Oyjh9PYZnNIgzAxejYxFkCZ5Q/h/lv5Yx63XNXODMXP/N02vu7lmKs1GCCg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PKBXhlrE; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PKBXhlrE"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137d003cf09so4353379c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 23:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780209479; x=1780814279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KKoQkAWAzKW5rOAQ0dJK5YvEF2dAkJqpt7cQ5fkwsmQ=;
        b=PKBXhlrEIoThp4tz8DarSApnNDW+Kd2s21GyIKOzG4AYrFD12axrMCnRTvZUFaLN8P
         RHxrlwdo28Y/A8PFwUcjJnTcMfeOVpnvNVw2jpjQA5WxY887ynitsgbm/mIEgrKvPdg8
         HG4GKyBJFDF9xGqxWQXe9HF3hSZlMmI9p96dpoRsrBr/hn8jELW1OeKj6AkPmKrHyAEJ
         yqOA8yedRRYW6aP5DHWJvTJDrSWw3Nnoh2wHboZYHFSDmawzd3ntVWHTTTKyr6wY77MC
         mj7W5rET516DjxMHAvj97ZxmgPGt9nrwZReqWwdk88SQErHfpZBvu2oGvdorFUg20l3f
         9icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780209479; x=1780814279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKoQkAWAzKW5rOAQ0dJK5YvEF2dAkJqpt7cQ5fkwsmQ=;
        b=oav0CR4G57GZ/zqwouBu+cNAV0eLzvJJOuHrhXm5jHilrNN3IiYibPkoPC9i1hpwLe
         WfgK/xDBWfh7tyO2V0nziDR8Gf1RGPmdw4ix5soQUP/Ozf2ClaBh6ffhpLiO4wbj0AlJ
         TO/6nvjDxsGnMEooc6Q4V/fsHVrFUzBJnIWUERyhb11maPQqivYIPkDZY9oFqnm4hug8
         9lcoH5HOBZ9shgzzWi07Kr0MeJYox1QBVmYZsdDXZ1woCjDzuM0olkFlbTrsGCLGabVv
         OG+6iKIaPpEg19uBU8IxmAYtXfczYEO0CgSNnTqQE3uQ6WBAwrU/+DtKTwjdevImfwqX
         jmEw==
X-Forwarded-Encrypted: i=1; AFNElJ/QxVBef2jTZVt4Ik81zmtqS+0APRMKy7zs/0kSwZi04MaU3a2GmrfBrJ0AoEnXyJANf0+QG/HVjuuYD4xMqmIq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8N9qwlv3mvFwqtMdyV1WssKGew0b7EB8y0mxooK9SO6zDhN81
	MbTvwFmD6bB/bfCmx51hVo9YHVGadOmO2HBO0KXe0reBy1GR20PW3habOrUUtNVZLhzypDeaa9D
	tnrqCTr07sg==
X-Received: from dlag9.prod.google.com ([2002:a05:701b:2509:b0:136:9e6c:868b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:607:b0:135:fda2:a56b
 with SMTP id a92af1059eb24-137d412fb49mr2693470c88.18.1780209479294; Sat, 30
 May 2026 23:37:59 -0700 (PDT)
Date: Sat, 30 May 2026 23:37:27 -0700
In-Reply-To: <20260531063736.871777-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531052740.796087-1-irogers@google.com> <20260531063736.871777-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531063736.871777-6-irogers@google.com>
Subject: [PATCH v3 05/14] perf test pmu-events: A sub-test per metric table
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

