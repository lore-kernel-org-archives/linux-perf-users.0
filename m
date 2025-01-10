Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD549206F04
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 04:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736485071; cv=none; b=lVQ+JZAUTJgMfdDA88dwICJ7NtsvUPayTP5NF1hHtRoPKNpCWil9H05D+Nzkgqb1O0Txd9ZpyqVzzRPsi53T7NiGYSjn3vQQr088pWcFTcjR0zM9KlNUIxi40dsTmsykOY2AvTbx9tz3TP0SxZH1a9yLRWNDvoi06DIb8F8PhEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736485071; c=relaxed/simple;
	bh=mh40pFTVB78EoqC5lTfrKoFSR+pG9AjMFlTEGuREGAA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XTdA6RopDAUIbmCbjt47goizYM/iaAx85yAKv7rnOaXoOAIh57asowX+EvEned9lt6lemOJD0JMNBh6gwWLaBwkxBM7tAcRgbAbJ7lPLMg4OPlBVoXnxwxxB3nUcsSgdFv8PheEINsIcfHOkpQrB8TzmDy/3i5dt3gV/Qw2laI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hf/MMVhi; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hf/MMVhi"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e399d4ef55cso4427541276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 20:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736485069; x=1737089869; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nki34OflXNMOF1Pr+0EwWgqUSzPdOTYpV9z5+MVXOF8=;
        b=Hf/MMVhi4BNAyVzcYsSvWc0o9nv42vb/pU2lPItsdgz6b6G40K9f8ndpnDbfSZ3whS
         +oHR6navbu9BOenkKiyn0wMNcFcxXjqYr3DiDmhT81PzDRJ6N6dv+mJmHecG40onAQvO
         IagHyx3LvMq5B++OcyBjLU+FyHnBi8DT7eRTQj9Hcwm9wed59yOdVom8axhgXrxodrGN
         kXkZRkP1+maxj/QY1rtR2H/3oJ+W8iVSFpK/ysaka3MCW0QpVjga8LzuuRWQWT88FAjF
         9FuATrwC1lbMNnrku5cX+slUXM+I7I2w8Hy6GtDkFfuM9ss5wVrLgY4oZk7H/h3jmRYy
         LcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736485069; x=1737089869;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nki34OflXNMOF1Pr+0EwWgqUSzPdOTYpV9z5+MVXOF8=;
        b=PUQyxR4xbBcoJhi6w7zPy7clyLtwQIq/RroNwVzVPtL4shWuUD734wNDvzPkREUHln
         +2+0RbMz4fzOlq1xTu+ch4u3LNTHqWnFFePIJa8mIYSCIAV4wntAWwVo150yIUzKzhHW
         8KGpOqJYiINXEUzm0M+qxXrKPo/X8g1Sug036h+3KEyFROHjOdFUg06molMEy1u/RNuR
         FSfAtckhnUTgFT3+aGI2hJk9Xvcl0YY5V5k/XDSwq0Ft/Y8XHsjGVvq4H+RJcHR4W5r3
         5hBEpwL4ZX7fdzGH89+frzbK+GIhXl7cbQuEEfY14DZQJflKlpj0Vr2s0+LOZtXAmhM6
         /09g==
X-Forwarded-Encrypted: i=1; AJvYcCX3Kg2sMJl78G6ObYQEvYboWvH45cAq2+fQNG01/eC7tAMyu+wJH6m1zvZmnqsdaEeTl9WqBUJnYEnaby1/mIG2@vger.kernel.org
X-Gm-Message-State: AOJu0YyRw2+JK9cakXI0YWXQjVA4g/1TV1opIWoGqXI0aRAJJZujzHbc
	F/xNAn58zBhJE7bCj0vkYYX03ZL97J26hLvL+o5xmdu/4lfL7uui0IofjRY0NfYnsM4nnsRaTm6
	ICuH0Kw==
X-Google-Smtp-Source: AGHT+IG+7QSa4MxOrxEvtHfaHE5rSZStaue4MuFj0zlZuGNWqvyRZkXaMX6e/DPHFkfLYo0+RSempBi5e4YB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a05:690c:c99:b0:6ef:c86b:af2c with SMTP id
 00721157ae682-6f530f0591emr303017b3.0.1736485068790; Thu, 09 Jan 2025
 20:57:48 -0800 (PST)
Date: Thu,  9 Jan 2025 20:57:35 -0800
In-Reply-To: <20250110045736.598281-1-irogers@google.com>
Message-Id: <20250110045736.598281-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110045736.598281-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v5 4/5] perf test: Add a runs-per-test flag
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To detect flakes it is useful to run tests more than once. Add a
runs-per-test flag that will run each test multiple times. Example
output:

```
$ perf test -r 3 lbr -v
122: perf record LBR tests                                           : Ok
122: perf record LBR tests                                           : Ok
122: perf record LBR tests                                           : Ok
```

Update the documentation for the runs-per-test option.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-test.txt |  5 +++++
 tools/perf/tests/builtin-test.c        | 28 ++++++++++++++++----------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 2e40869b64de..85f868c324ff 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -37,6 +37,11 @@ OPTIONS
 	tests are run sequentially, but other tests are run in
 	parallel to speed execution.
 
+-r::
+--runs-per-test::
+	Run each test the given number of times, by default once. This
+	option can be useful to determine if a test is flaky.
+
 -F::
 --dont-fork::
 	Do not fork child for each test, run all tests within single process, this
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c6071c4db741..14d30a5053be 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -42,6 +42,8 @@
 static bool dont_fork;
 /* Fork the tests in parallel and wait for their completion. */
 static bool sequential;
+/* Number of times each test is run. */
+static unsigned int runs_per_test = 1;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 
@@ -485,7 +487,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 			len = strlen(test_description(*t, i));
 			if (width < len)
 				width = len;
-			num_tests++;
+			num_tests += runs_per_test;
 		}
 	}
 	child_tests = calloc(num_tests, sizeof(*child_tests));
@@ -549,16 +551,18 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 				continue;
 			}
 
-			test_suite__for_each_test_case(*t, curr_test_case) {
-				if (!perf_test__matches(test_description(*t, curr_test_case),
-							curr_suite, argc, argv))
-					continue;
-
-				err = start_test(*t, curr_suite, curr_test_case,
-						 &child_tests[child_test_num++],
-						 width, pass);
-				if (err)
-					goto err_out;
+			for (unsigned int run = 0; run < runs_per_test; run++) {
+				test_suite__for_each_test_case(*t, curr_test_case) {
+					if (!perf_test__matches(test_description(*t, curr_test_case),
+								curr_suite, argc, argv))
+						continue;
+
+					err = start_test(*t, curr_suite, curr_test_case,
+							 &child_tests[child_test_num++],
+							 width, pass);
+					if (err)
+						goto err_out;
+				}
 			}
 		}
 		if (!sequential) {
@@ -698,6 +702,8 @@ int cmd_test(int argc, const char **argv)
 		    "Do not fork for testcase"),
 	OPT_BOOLEAN('S', "sequential", &sequential,
 		    "Run the tests one after another rather than in parallel"),
+	OPT_UINTEGER('r', "runs-per-test", &runs_per_test,
+		     "Run each test the given number of times, default 1"),
 	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '--list-workloads' to list the available ones."),
 	OPT_BOOLEAN(0, "list-workloads", &list_workloads, "List the available builtin workloads to use with -w/--workload"),
 	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
-- 
2.47.1.613.gc27f4b7a9f-goog

