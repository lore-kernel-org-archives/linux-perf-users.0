Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C65205E0A
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459474; cv=none; b=nO6nD+XkenXjtRkhM5VRR9+MyMnRi/8xX5vkryetA2ISzhil8WX+YiACTBAgEUvouMT+RGIzVfCq/Tyv78KMQY4EOHDHniMOVqEkBlDg/N7XReCx74MsAWxv2TaFfoYY/jDU5JiQyPZ4hCMLIe8Co/CTqeKdbNnhre9F6yyLlyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459474; c=relaxed/simple;
	bh=+7Yhxzt89Bt/FtZ0vYhkiBaegzjMmVsjRss0mqjtWOY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=P2XbtlbHo1oSCBEEJCE9qx4Bq5FRtXXjJHccmSsVKowo8d2TJpyQKKTpzfKUEZg87mqwN8pzfEn5lMQ9d92SwQPDCIhakXKVyh8ek0SkUybKB1SL5q7mV+mMXS25w+zTKyYLtAq8Dz+9+OyA4KvkEWlNdHyaAaBb8f/6D50rKfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T1tbGudC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T1tbGudC"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e5505f613e5so2762640276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 13:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736459472; x=1737064272; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLGfjWF8Dvwd5vX5dBqbXBJjQRQp0vBCnTiwsZVrhXw=;
        b=T1tbGudC77Ktw+8Nd6Bi7/6r+hkAU6d4362MSV3IOEyvEyQ+Qi+8KjAKj2JUbAJ5kH
         6WDyxFE5PUNQgk3cFFrjY8Sxui534lWQPRRvqwBpNPWVnHwHMifveFtN4PcdbkYG2JYM
         l2CQTPIGtax4EoVWCsLK/VETZ4kG9thz7Pds8FfQLZSopL9BvGiH/2VLhEe4FWI4wZV1
         Pysqm3Ku8LvYKYnAQEVHSrxDf703nTtjLFQHSPAl14jH9lodFH8xF1Yzo+HZYlOjSOAg
         BQXEAnUW/PTH0LBnuNF1d5UO9vhJc4UE7Zyp9XMNWqUjpYGjlwYAhnH9m3AVkS2BWklR
         vDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736459472; x=1737064272;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLGfjWF8Dvwd5vX5dBqbXBJjQRQp0vBCnTiwsZVrhXw=;
        b=tvIlbkMLj0JdMb2jc/I7NZum3Uhw/VfOcXyrU2rc5ULMFI8uqTuU5AR4m3ynt8CHLd
         gsjrq0G0icmn6s0b/T/ikCmXjQpJ+/+rWfOYofEjm7/+T7BGOsXnJ868OHlgMOg+lCm6
         av8J4iDl636rgZvJlNHMi9H++FsQByXu9Nz8naLwO2hyPZWVtfjek0jDSgsPiZ0edwK0
         cn4R/7+C7CCB/z7j8cjdCo/proNP2/MQ7WF4zvaMlbVReFr205BBSIJM4XTlCcIPdtwy
         mG33r7svU2w1spYg8vQdn4NpuuKtom6Mi+QouhsSCOt08X0lOaXpp1fEhjKnIjHAuKUR
         oflQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWP7pCAKleYCl/AdsuSmmAN4Y/EBNWWDhyX3zdAhmdlnnE9fraB/G3UN0TqJovLE0vlGrhYQP18KYTmq/nT8cg@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzo8YKW0vEeMGMnxd6CzYgedboZJkm7rhymL+P/VPqwrmEY821
	blqelvLjr+00acvN2BTyzJM/DKK3bTej6dU1DCdx2X4aBySzw8F+PntTEbJho7o1my0EsPd7UFF
	evGv8hg==
X-Google-Smtp-Source: AGHT+IFNBF8/b18TaeHOjZXwlLPSns4sJbrZYHGMf0g4LTtJa9asgt72dPYr9HcdZ/mkL+akKyCJgOUBs+Av
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a81:a985:0:b0:620:32ea:e1d4 with SMTP id
 00721157ae682-6f543c590b5mr198097b3.0.1736459472119; Thu, 09 Jan 2025
 13:51:12 -0800 (PST)
Date: Thu,  9 Jan 2025 13:50:54 -0800
In-Reply-To: <20250109215055.454888-1-irogers@google.com>
Message-Id: <20250109215055.454888-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109215055.454888-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v4 4/5] perf test: Add a runs-per-test flag
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
 tools/perf/Documentation/perf-test.txt |  9 ++++++++-
 tools/perf/tests/builtin-test.c        | 28 ++++++++++++++++----------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index 8f8a3c367570..85f868c324ff 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -33,7 +33,14 @@ OPTIONS
 
 -S::
 --sequential::
-	Run tests one after the other, this is the default mode.
+	Run all tests one after the other. By default "exclusive"
+	tests are run sequentially, but other tests are run in
+	parallel to speed execution.
+
+-r::
+--runs-per-test::
+	Run each test the given number of times, by default once. This
+	option can be useful to determine if a test is flaky.
 
 -F::
 --dont-fork::
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

