Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB11F1B0403
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448056; cv=none; b=j4GnjACQaogUF2EaiGLmpifsoGuSbnxZdpo3Nz/v5mvFkeQMXdynH/6ZL6ZKLpVXKEwDwXeyM4IuErYCRTKKKj0A/9dEnQmNkcva4IQvHqnygLeNDNMSEfUCpuJZ/PfQHK33IS/96KxW5q7DUp1U/wAzm/H3ARRkic0Ho8jxESE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448056; c=relaxed/simple;
	bh=SN+I17RDaZh8oc6X/iRBk7GMORcptVGS1eILZ2DUaL4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bLggXyh6Ytvw+elntMWNks0znF03aV8IId/4UK8/CZR+nBOnhTytove0qWpNAt7kQ6L+pA2S5Lci+rCe2BXj545jNMAOMPXAcaa0F62aQ/mafsnwn1qkPE7TaxvbZuVdTjT91biT3TwulXo1eYuJB6T7kiwt2puOjamMfWYOi2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z2cVfc6N; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z2cVfc6N"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3a1bc0c875so3124457276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 10:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736448054; x=1737052854; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ELN3tE1PcOELRVYFu0oyotf1UYI5umGCfo/xf2c5iT4=;
        b=Z2cVfc6NUU+Im2/2Jt8c3C0ZiVqRo1H/2FByvBoknztgU8Nr+XUfXFQyTDB6Vr63GB
         xvmw6BUwtxWQ0eV9jria/03yf5IJ58sb5Ch6Y0CA4UsKXzBJ8mlms2xKjdGa61SpHDs2
         omUNLoIRbAqGJsZMIsgRaN7X3joEeMonBu5J9vp+8asIBoETQkqTq96Ggw0m68FmFOfc
         XtFoWUcqpmTYpysBF6grKhftgaFE3c5UMFx6bDerUrh5kGG6yj46pioUz/Tbzimjz7Wa
         CP04koBl4Y+h2woPMwA2X/rNeFiZLVDK7pqQbkMHvzqx4va9eGDHApOzg3SiyUaOC3in
         f5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736448054; x=1737052854;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELN3tE1PcOELRVYFu0oyotf1UYI5umGCfo/xf2c5iT4=;
        b=wWQmAMT/Mkt3tTCS29eZWR89Fr+BFrY+GOl4LvtCTJOoFJ10bhZLxPVqovfoy2gWp9
         IAkTnSq01WFKj2ftMhfE+GvXlHIZuMTYpmEvHYZDyo7If4hEl7U+1o3Oy3NVqMjLIN7o
         g/RDEz2dVIO998NhI9eCSvsBEAGnqnDcOT2BeOPcdpGUXesQwRxE2CP/0SSzWjqcR59K
         FrJJblV7KvnDvi4Xw6O07tRe3sZNn8iTpJYrr4eNBMb7clltUruxBiWI2rqPF8SRwL0h
         5ccnZmska5q80iWvl6Rst7UUCgkhhh7d7o0GflBurs99CMnyamzt28BGmwnRYygz2I9t
         UKXg==
X-Forwarded-Encrypted: i=1; AJvYcCWi8hOYY41RrlFNW5NR9grTw+RHczTXyq1/kYUco6Kp9H6zkISWa3xVUdRz4aJ7STta6SqkrniPUfB9hDdbqPai@vger.kernel.org
X-Gm-Message-State: AOJu0YyG4LwDBnxSqyCgxCG5vOLL7CkDeEbgFUS+KoNV7g+DWaWd1A8F
	rHvoPEiO/GA0NE3cJkqURx2U3LAKbCjNG1Q7qkNWML7k7vwtWGG/FL9IUp5mymyXkNtKW4/mGOn
	fD9OvEA==
X-Google-Smtp-Source: AGHT+IHA3Dli0QE8tWCoJZww07Sv8vM+fS066RHw4aYQHAGR4xnxAi4KMPfcxw9tLH35+QPuZCDlJ9uW8tC6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a25:361f:0:b0:e0e:8b26:484e with SMTP id
 3f1490d57ef6-e54ee20cc49mr17600276.8.1736448053935; Thu, 09 Jan 2025 10:40:53
 -0800 (PST)
Date: Thu,  9 Jan 2025 10:40:43 -0800
In-Reply-To: <20250109184046.193736-1-irogers@google.com>
Message-Id: <20250109184046.193736-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109184046.193736-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v3 2/5] perf test: Send list output to stdout rather than stderr
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Follow the workload listing in using stdout rather than
stderr. Correct the numbering of sub-tests to be 1.1 rather than 1:1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c3e082efb7f4..887f735da900 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -579,7 +579,7 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 	return err;
 }
 
-static int perf_test__list(struct test_suite **suites, int argc, const char **argv)
+static int perf_test__list(FILE *fp, struct test_suite **suites, int argc, const char **argv)
 {
 	int curr_suite = 0;
 
@@ -589,13 +589,13 @@ static int perf_test__list(struct test_suite **suites, int argc, const char **ar
 		if (!perf_test__matches(test_description(*t, -1), curr_suite, argc, argv))
 			continue;
 
-		pr_info("%3d: %s\n", curr_suite + 1, test_description(*t, -1));
+		fprintf(fp, "%3d: %s\n", curr_suite + 1, test_description(*t, -1));
 
 		if (test_suite__num_test_cases(*t) <= 1)
 			continue;
 
 		test_suite__for_each_test_case(*t, curr_test_case) {
-			pr_info("%3d:%1d: %s\n", curr_suite + 1, curr_test_case + 1,
+			fprintf(fp, "%3d.%1d: %s\n", curr_suite + 1, curr_test_case + 1,
 				test_description(*t, curr_test_case));
 		}
 	}
@@ -721,7 +721,7 @@ int cmd_test(int argc, const char **argv)
 	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
 	if (argc >= 1 && !strcmp(argv[0], "list")) {
 		suites = build_suites();
-		ret = perf_test__list(suites, argc - 1, argv + 1);
+		ret = perf_test__list(stdout, suites, argc - 1, argv + 1);
 		free(suites);
 		return ret;
 	}
-- 
2.47.1.613.gc27f4b7a9f-goog

