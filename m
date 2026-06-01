Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9090534752B
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294501; cv=none; b=kxCY+6O1OjykcB9vBJYmA5MhtEyp7mvSlS/0VDZJDyi8sdKiNYnyzPhKp055fOmYW9BA6eJ3KJN6Ajb0WKGb5qktbabiGEA2N0ZDVuJguW/iwgHnlgml1S6znx0DqWH2i7D1Jt7jIVtk3q7y9/hc6AtSwzMl6Iio5Br6G4WgBjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294501; c=relaxed/simple;
	bh=CSIO2Y0sg41/cu9R1dFtAHHzhJKrNoNKDs13LTZFHYs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OJLlikPYv1RA7vgPKaouupktg307t6iP/WxtWc+dC0nou7t6n0lcpjzqOgYFTebuENqB5c481p36vI5R6umIfUgSSq/KE3Cj5gENSA+TvTsXaMKh8Cqe4i90AMiRlqK+3KUSXAceC9P2d92at5YW1yL9/hcaAakbeJJfBO0yAWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sPT05zWk; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPT05zWk"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137dbe27199so169501c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 23:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780294499; x=1780899299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KKoQkAWAzKW5rOAQ0dJK5YvEF2dAkJqpt7cQ5fkwsmQ=;
        b=sPT05zWkZpF9huN6D+Blg86oZSB3JJK19bQeO7E3owT5QkgzVKQwVVhjkm8y92Z0+U
         5uLKlUJYu3vuRyrBZmgZgDVeQmaiX7LFIi7yUUT5nFZvLdBM+x/SIRKh7bfpP+swmDoU
         hrWysmtTU1RAkq1PUJ6DF8tk39P8plMWp6ZMSZg25w4Y3j/thoA35tdIJogVU1OSorSZ
         7XhKiMLV1EFRiwGdmCCJSvsj5FOcbRTePQzrbJ4WrAnoAVFMA+f1p0eI82djtrzyn0P9
         kSHIt02DD3NY9sh9T4cd851sydm626rTHNPdygPnEi+J3peOaQPcosDMFUKjdcHq4lMs
         /IrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780294499; x=1780899299;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKoQkAWAzKW5rOAQ0dJK5YvEF2dAkJqpt7cQ5fkwsmQ=;
        b=giuTdiAj4pM46hOUalcN7xgo+yYLTJKXfpqTEypVyfAH5uvAcKwoWYamyrOIvJim5O
         jeZ6qC3InPHZq1KZmz70KSZDr3D8R0BYdTeC5H2zbxNkWv8a9RZ5KEo23G4SEeruKW6w
         p+GJIJfA4PkhOQu15WwZUal7nuQR673sIb4NNMkcXpEzkIfiONIyZ2TsQtyPczF46NbD
         3/EDPFbjrKAuXmvzejtnR4umsB43K2n6ixNu1GvHAU7mrkxkyms4pUza9E0bd/c8abd+
         Vy0yxuNeTnUn1mZ1wFVMhYfGFuulXTzwyaD5B6r1PCsctpGT/HuyJrCiHF9tkqZdWEsE
         O4Ew==
X-Forwarded-Encrypted: i=1; AFNElJ8ctlYmAE91ldnWxsVzi4NH2+fmPKAUHsor3nGWlKXSGXEKDMqtrLgCXn7c9pN9MWWH2oTVR4qITwXjTjzxcLEW@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi8uCM+mtNVZ0rWtP2ah2GCYbzmhLWhF8ZSAhNLFLV92GzdPj6
	reuDoXo0KOi/r8lXVAWoSSHZ/j0AvbnMYs0K/+cLc7r9nmWH4/Yz4WLc4psJ+p4Tcgg4JTMWpLL
	EKy+oSA4tsA==
X-Received: from dlk13.prod.google.com ([2002:a05:7022:10d:b0:137:dd82:5b70])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4393:b0:137:e532:f53f
 with SMTP id a92af1059eb24-137e532f5f8mr519302c88.34.1780294498559; Sun, 31
 May 2026 23:14:58 -0700 (PDT)
Date: Sun, 31 May 2026 23:13:51 -0700
In-Reply-To: <20260601061401.1541457-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601000548.1195604-1-irogers@google.com> <20260601061401.1541457-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601061401.1541457-6-irogers@google.com>
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

