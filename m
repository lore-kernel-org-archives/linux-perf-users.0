Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53161547C5
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731168146; cv=none; b=r6Zl0IRV255m4YawNBnOkM3mcKiRlj2R6WUFDK2l22SrSftgILH127uCJd0YzJBftobzXcZeQ61Mv+EeD5GBRDZuF6bRZBVmwkrURWr13jrJ/lyJ4bI+g7o0opnVMqp1H8Ui8lg5jy88mhETa7GGCZ5XKY653LJtPoFyKmnjBbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731168146; c=relaxed/simple;
	bh=J/G+GK5A6r/3LWlVQx8WCEHZt004alpDLzh/cC/43kw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=AvWfO54iLkCouJ7JssGvTEzRUsPs7XKc2J8eEzVEJwn8uFZaR3XvWsAw/2rRmiw0NUSK3K0y/P5q96QZo580b7Z+svSJ9NjAy+zPUtGGGxQv2+MBrGJUzxR+9fGHNdU+jeXriflxeDg/REy0FmKzHIsanbaJXFt3kzSaVMhsL+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sNRGJLZ0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sNRGJLZ0"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e293b3e014aso4855909276.3
        for <linux-perf-users@vger.kernel.org>; Sat, 09 Nov 2024 08:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731168143; x=1731772943; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=myihIh0U0JAwI6hYWqHsU4WyoIg2aePskZq+v84soew=;
        b=sNRGJLZ0UPaYZ9qp4CeHnLUBbkLSiAeNLt/JeUEB1iDWbTF7kiCagd0eOM86U7n/dP
         vCOWoBMhNk2fX8m17E0jdVnr7/mKV4rUgHfih4MWgoTn/c9OfY+4jpZrAmkDSaG8JLWy
         3+Qu9B2r9AvohQp0Qkw1S814x5bpUGGlHgBPlGC1FfMMGj2CIrT334j2SPqC4h6BayFp
         giNbsJVYiOVeyAQZ7oS/o/IZMTxqi5mrO+rtalomqQhG2A0SU5RwI9YYCHvuWtXs7yh7
         2MrWYpongT2XM5cfRO2/OKoD91n0A8X0UZgTflM26aYGdeaXm/FVSDmrP/7iTU69ayuh
         IV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731168143; x=1731772943;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myihIh0U0JAwI6hYWqHsU4WyoIg2aePskZq+v84soew=;
        b=X3l1D8GWWt1W0nFqBTl/3ZZrDdp/BgXmPBvGkOoXbn3C2mslxJMG7xqbtbkKV52wSq
         zJaFMiOwOEgk8yp+XqTZnjR5jDIgiM7sMtvDgq5nHXP7FiUjeEYzkDo9PotfapkLcp72
         XyufAh303i8SjwO6uozqKozETlT0H9OigYt0c9VAJjs+wwLGfQJUEDcyNwzxO5gRKcr3
         FZl4xw5T5sF4VySo+Z/l7t3Va+FRD0ysBYWVD3UEhjW+s67/c88Xwfb3FAcT7Dj8U2Gr
         hz39PJg3FPUfTu5QHFM/rg4UEezPvkRE1K2prmwsHa/GMfV5JPeLdVA3+BWFNqrky/rx
         +22g==
X-Forwarded-Encrypted: i=1; AJvYcCUk/kU9x8XGbuTR1jTlYTgTDdhE81wt7KxlzDpvuh6QmPlSlEXPj2CyFQ6UUhu1fnDBWC/YcORIzChgoQEaXH/O@vger.kernel.org
X-Gm-Message-State: AOJu0YwF8intbBlSpGXdZO4ZqLNA0VmR7ZNjSzi+Ls43rCl/4DDoQoYH
	nWLX4yJnCVMXIxkTjRODC76jiqhACGz0FYKMrjw38foFaMuDXUhKObeV2CM+KLMbb5s5fRnGZr7
	XO+uZiw==
X-Google-Smtp-Source: AGHT+IHYzZ5I9NuvOBIJjrVSWWfMoguJtT9xedtPSduE1h6lWzS33Fs7ybK99uBj+p3In+hAcavMeoyMLczH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a25:dc4a:0:b0:e25:5cb1:77d8 with SMTP id
 3f1490d57ef6-e337f8ed8bbmr4583276.6.1731168143667; Sat, 09 Nov 2024 08:02:23
 -0800 (PST)
Date: Sat,  9 Nov 2024 08:02:18 -0800
Message-Id: <20241109160219.49976-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v1] perf test: Add a runs-per-test flag
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
runs-per-test flag that will run each test multiple times.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 38 ++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d2cabaa8ad92..574fbd5caff0 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -42,6 +42,8 @@
 static bool dont_fork;
 /* Fork the tests in parallel and wait for their completion. */
 static bool sequential;
+/* Numer of times each test is run. */
+static unsigned int runs_per_test = 1;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 
@@ -490,10 +492,10 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 				len = strlen(test_description(*t, subi));
 				if (width < len)
 					width = len;
-				num_tests++;
+				num_tests += runs_per_test;
 			}
 		} else {
-			num_tests++;
+			num_tests += runs_per_test;
 		}
 	}
 	child_tests = calloc(num_tests, sizeof(*child_tests));
@@ -556,21 +558,25 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 			}
 
 			if (!has_subtests(*t)) {
-				err = start_test(*t, curr, -1, &child_tests[child_test_num++],
-						 width, pass);
-				if (err)
-					goto err_out;
+				for (unsigned int run = 0; run < runs_per_test; run++) {
+					err = start_test(*t, curr, -1, &child_tests[child_test_num++],
+							width, pass);
+					if (err)
+						goto err_out;
+				}
 				continue;
 			}
-			for (int subi = 0, subn = num_subtests(*t); subi < subn; subi++) {
-				if (!perf_test__matches(test_description(*t, subi),
-							curr, argc, argv))
-					continue;
-
-				err = start_test(*t, curr, subi, &child_tests[child_test_num++],
-						 width, pass);
-				if (err)
-					goto err_out;
+			for (unsigned int run = 0; run < runs_per_test; run++) {
+				for (int subi = 0, subn = num_subtests(*t); subi < subn; subi++) {
+					if (!perf_test__matches(test_description(*t, subi),
+									curr, argc, argv))
+						continue;
+
+					err = start_test(*t, curr, subi, &child_tests[child_test_num++],
+							width, pass);
+					if (err)
+						goto err_out;
+				}
 			}
 		}
 		if (!sequential) {
@@ -714,6 +720,8 @@ int cmd_test(int argc, const char **argv)
 		    "Do not fork for testcase"),
 	OPT_BOOLEAN('S', "sequential", &sequential,
 		    "Run the tests one after another rather than in parallel"),
+	OPT_UINTEGER('r', "runs-per-test", &runs_per_test,
+		     "Run each test the given number of times, default 1"),
 	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '--list-workloads' to list the available ones."),
 	OPT_BOOLEAN(0, "list-workloads", &list_workloads, "List the available builtin workloads to use with -w/--workload"),
 	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
-- 
2.47.0.277.g8800431eea-goog

