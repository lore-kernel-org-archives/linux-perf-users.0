Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A2121A4AF
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884101; cv=none; b=fP4NkdbXDGGWNR64YY02Chkc0Ud1uanV34Gwg5WyRcE9yI/0HrVOwut/nWESrqWFDiz7vmNzice4uTHgbsvnWvo6/nDIPRdo9bwbMgUmyrg9ze6oCveb8FsG17q+Ml+EcQMWQvtiH5dPHr1H5p+96nty1hIs37lJMhTtnTmz9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884101; c=relaxed/simple;
	bh=rNAcF8wM8gvz4H8uQaNqviqYDP2ME6uNIt9wV+wjHHQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=UBdKtlRGW+jDUgg+q7NsT6pkVczU710S19W9HKm38fNws9N8ZA9ci91iX4V2blfYCyDLU9d0xZwVOmRHX/vAhYLSHfHvK8DzG4hZFn0Hz4xEAdoIUviYsB+toTC5mSp7C/ceAU/x6mogw6I50yeVeN1FXUJl5YOWtz3otodpBdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2HBFvx0v; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2HBFvx0v"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e29205f6063so4259917276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729884098; x=1730488898; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/dxz2W/8vDBHa448LZ9Sd6x6HeOGt9H5wdrppWaYtKk=;
        b=2HBFvx0v8xJCI17kERjyrZMzHpPctIb37U77ct8HhkDj+0YJ97Qo8Z6sOxHXPZrTJ8
         ca834jwrKT0dwAac7k0vj4gEyxRVfc9wor2VFc0lAjXKQuDBfbcSqiyuA0VYSqPUQhQw
         zmtHSXha5QCh+DETmk3W92DQme6WPoroRQsF/2VZdwGOMfiYXP8rUt/UCkydHAaybL31
         BxPP4fOyQhjNpEVFt/zTBvE+mB9eAXne2I86Dt2ycOeCzgZmeqVjxpn33+o2Je5+JvJQ
         p8o8VMMnSRgRrR2KpXF4DFgL6nO01F/iKBHkr0OCM+Ie2hjP0CYu9clQCbnNo8kPS4WP
         zo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729884098; x=1730488898;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dxz2W/8vDBHa448LZ9Sd6x6HeOGt9H5wdrppWaYtKk=;
        b=IhNhVp8kWVMoy6Bfnd91TaBS9HBaU5PeRaVzw+XaqfGuKpPhoEtEs5MlpLtCIqs8rX
         lERby5A4OolXZy40l2GLy19FwgsP7ixuKoNvygtT4LH7XUhtNpqWkBEvwKKblKJ2A9HR
         em5xbupIH3eHnJGYquoKeYTcrO8S3JDAsVF6mfLAlg7VBEHLB5dWI4/0ekWQBf1wXcGl
         n4CTGnG7kpEtLbtdaY6iANI1LY5ddqDB7x3lWHqchgQOYk6h6RArerkBkFgRutAolEyi
         qd8UfbSDmw9gQtR6vm7We1RtbuEnT03vNhhAy5WCriPCioWhOS4lQGvjd9VQ2rpZ9OBF
         f0UA==
X-Forwarded-Encrypted: i=1; AJvYcCUCkCwVczi6t9VX4l6YvYixIKDRmkPFzDCeJ8xOgQPJYjisU+KWHTHi9kXH/f07lVfUOZLiGjQ3JF5wM8KNNN0A@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1tNhG2YHxNX5xDzKw4XT2isIXGF8/Avp4/NsH6YoVpc61ZaTr
	cINvn+xTzAL/80OflTZT1zts4ONnP4X24k6j0uttXwxecXTqPkZ7okw4vzGrJLO9/KNMavihnyt
	3ljIvMg==
X-Google-Smtp-Source: AGHT+IEUKi5wV3YEZPlz2DurrhYIqR/SpWkQ+hDi0Tx37uRYxgfi+MljIzUcCfqShJ1/JNUl8DrAvdnw/RfC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a25:c78a:0:b0:e17:8e4f:981a with SMTP id
 3f1490d57ef6-e3087c2d8b1mr1832276.11.1729884097267; Fri, 25 Oct 2024 12:21:37
 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:21:09 -0700
In-Reply-To: <20241025192109.132482-1-irogers@google.com>
Message-Id: <20241025192109.132482-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025192109.132482-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 10/10] perf test: Sort tests placing exclusive tests last
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This allows a uniform test numbering even though two passes are used
to execute them.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 125 +++++++++++++++++++++-----------
 1 file changed, 84 insertions(+), 41 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 2f880f48cdc5..d2cabaa8ad92 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -137,12 +137,6 @@ static struct test_suite *generic_tests[] = {
 	NULL,
 };
 
-static struct test_suite **tests[] = {
-	generic_tests,
-	arch_tests,
-	NULL, /* shell tests created at runtime. */
-};
-
 static struct test_workload *workloads[] = {
 	&workload__noploop,
 	&workload__thloop,
@@ -468,10 +462,6 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 	return start_command(&(*child)->process);
 }
 
-#define for_each_test(j, k, t)					\
-	for (j = 0, k = 0; j < ARRAY_SIZE(tests); j++, k = 0)	\
-		while ((t = tests[j][k++]) != NULL)
-
 /* State outside of __cmd_test for the sake of the signal handler. */
 
 static size_t num_tests;
@@ -483,22 +473,21 @@ static void cmd_test_sig_handler(int sig)
 	siglongjmp(cmd_test_jmp_buf, sig);
 }
 
-static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
+static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
+		      struct intlist *skiplist)
 {
-	struct test_suite *t;
 	static int width = 0;
-	unsigned int j, k;
 	int err = 0;
 
-	for_each_test(j, k, t) {
-		int len = strlen(test_description(t, -1));
+	for (struct test_suite **t = suites; *t; t++) {
+		int len = strlen(test_description(*t, -1));
 
 		if (width < len)
 			width = len;
 
-		if (has_subtests(t)) {
-			for (int subi = 0, subn = num_subtests(t); subi < subn; subi++) {
-				len = strlen(test_description(t, subi));
+		if (has_subtests(*t)) {
+			for (int subi = 0, subn = num_subtests(*t); subi < subn; subi++) {
+				len = strlen(test_description(*t, subi));
 				if (width < len)
 					width = len;
 				num_tests++;
@@ -540,18 +529,18 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 		int child_test_num = 0;
 		int i = 0;
 
-		for_each_test(j, k, t) {
+		for (struct test_suite **t = suites; *t; t++) {
 			int curr = i++;
 
-			if (!perf_test__matches(test_description(t, -1), curr, argc, argv)) {
+			if (!perf_test__matches(test_description(*t, -1), curr, argc, argv)) {
 				/*
 				 * Test suite shouldn't be run based on
 				 * description. See if subtest should.
 				 */
 				bool skip = true;
 
-				for (int subi = 0, subn = num_subtests(t); subi < subn; subi++) {
-					if (perf_test__matches(test_description(t, subi),
+				for (int subi = 0, subn = num_subtests(*t); subi < subn; subi++) {
+					if (perf_test__matches(test_description(*t, subi),
 								curr, argc, argv))
 						skip = false;
 				}
@@ -561,24 +550,24 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 			}
 
 			if (intlist__find(skiplist, i)) {
-				pr_info("%3d: %-*s:", curr + 1, width, test_description(t, -1));
+				pr_info("%3d: %-*s:", curr + 1, width, test_description(*t, -1));
 				color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
 				continue;
 			}
 
-			if (!has_subtests(t)) {
-				err = start_test(t, curr, -1, &child_tests[child_test_num++],
+			if (!has_subtests(*t)) {
+				err = start_test(*t, curr, -1, &child_tests[child_test_num++],
 						 width, pass);
 				if (err)
 					goto err_out;
 				continue;
 			}
-			for (int subi = 0, subn = num_subtests(t); subi < subn; subi++) {
-				if (!perf_test__matches(test_description(t, subi),
+			for (int subi = 0, subn = num_subtests(*t); subi < subn; subi++) {
+				if (!perf_test__matches(test_description(*t, subi),
 							curr, argc, argv))
 					continue;
 
-				err = start_test(t, curr, subi, &child_tests[child_test_num++],
+				err = start_test(*t, curr, subi, &child_tests[child_test_num++],
 						 width, pass);
 				if (err)
 					goto err_out;
@@ -602,27 +591,25 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 	return err;
 }
 
-static int perf_test__list(int argc, const char **argv)
+static int perf_test__list(struct test_suite **suites, int argc, const char **argv)
 {
-	unsigned int j, k;
-	struct test_suite *t;
 	int i = 0;
 
-	for_each_test(j, k, t) {
+	for (struct test_suite **t = suites; *t; t++) {
 		int curr = i++;
 
-		if (!perf_test__matches(test_description(t, -1), curr, argc, argv))
+		if (!perf_test__matches(test_description(*t, -1), curr, argc, argv))
 			continue;
 
-		pr_info("%3d: %s\n", i, test_description(t, -1));
+		pr_info("%3d: %s\n", i, test_description(*t, -1));
 
-		if (has_subtests(t)) {
-			int subn = num_subtests(t);
+		if (has_subtests(*t)) {
+			int subn = num_subtests(*t);
 			int subi;
 
 			for (subi = 0; subi < subn; subi++)
 				pr_info("%3d:%1d: %s\n", i, subi + 1,
-					test_description(t, subi));
+					test_description(*t, subi));
 		}
 	}
 	return 0;
@@ -661,6 +648,55 @@ static int perf_test__config(const char *var, const char *value,
 	return 0;
 }
 
+static struct test_suite **build_suites(void)
+{
+	/*
+	 * TODO: suites is static to avoid needing to clean up the scripts tests
+	 * for leak sanitizer.
+	 */
+	static struct test_suite **suites[] = {
+		generic_tests,
+		arch_tests,
+		NULL,
+	};
+	struct test_suite **result;
+	struct test_suite *t;
+	size_t n = 0, num_suites = 0;
+
+	if (suites[2] == NULL)
+		suites[2] = create_script_test_suites();
+
+#define for_each_test(t)						\
+	for (size_t i = 0, j = 0; i < ARRAY_SIZE(suites); i++, j = 0)	\
+		while ((t = suites[i][j++]) != NULL)
+
+	for_each_test(t)
+		num_suites++;
+
+	result = calloc(num_suites + 1, sizeof(struct test_suite *));
+
+	for (int pass = 1; pass <= 2; pass++) {
+		for_each_test(t) {
+			bool exclusive = false;
+
+			if (!has_subtests(t)) {
+				exclusive = test_exclusive(t, -1);
+			} else {
+				for (int subi = 0, subn = num_subtests(t); subi < subn; subi++) {
+					if (test_exclusive(t, subi)) {
+						exclusive = true;
+						break;
+					}
+				}
+			}
+			if ((!exclusive && pass == 1) || (exclusive && pass == 2))
+				result[n++] = t;
+		}
+	}
+	return result;
+#undef for_each_test
+}
+
 int cmd_test(int argc, const char **argv)
 {
 	const char *test_usage[] = {
@@ -688,6 +724,7 @@ int cmd_test(int argc, const char **argv)
 	const char * const test_subcommands[] = { "list", NULL };
 	struct intlist *skiplist = NULL;
         int ret = hists__init();
+	struct test_suite **suites;
 
         if (ret < 0)
                 return ret;
@@ -697,10 +734,13 @@ int cmd_test(int argc, const char **argv)
 	/* Unbuffered output */
 	setvbuf(stdout, NULL, _IONBF, 0);
 
-	tests[2] = create_script_test_suites();
 	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
-	if (argc >= 1 && !strcmp(argv[0], "list"))
-		return perf_test__list(argc - 1, argv + 1);
+	if (argc >= 1 && !strcmp(argv[0], "list")) {
+		suites = build_suites();
+		ret = perf_test__list(suites, argc - 1, argv + 1);
+		free(suites);
+		return ret;
+	}
 
 	if (workload)
 		return run_workload(workload, argc, argv);
@@ -728,5 +768,8 @@ int cmd_test(int argc, const char **argv)
 	 */
 	rlimit__bump_memlock();
 
-	return __cmd_test(argc, argv, skiplist);
+	suites = build_suites();
+	ret = __cmd_test(suites, argc, argv, skiplist);
+	free(suites);
+	return ret;
 }
-- 
2.47.0.163.g1226f6d8fa-goog

