Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE2C19DF75
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jan 2025 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736287322; cv=none; b=EyV46qfUPWKSAi4anQx/lsmENFMnk5BA6kgzBbVRtMiJrcKfuTaGnMFXC+/IO8IHmC1iKTNVOM7+rctTKvsqBsa/b7Fsvbz5towBx6bv09IZMjyspmosXfaKoouL0RKU0oUj7mjQJgy3a54rQlyUfy+0m9E1LiLt1S9pDj12xQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736287322; c=relaxed/simple;
	bh=SN+I17RDaZh8oc6X/iRBk7GMORcptVGS1eILZ2DUaL4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=KfqkcfT65pyTXE2Gv1er2TMazd2srzPMe0e+NzDIlxs1I+7Br8JhBp9z0GD9Hory0riG25v6kErjPYf3TLbEV8pcvo7Gs/PUuOR3EubADtdHGHtumycCevP8t8v21i+OBrDOgQJYQt4fio9emHqERf5YAgrdIfrVqsYcNrSIgmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1p7xzz2s; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1p7xzz2s"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e4c27270591so13743934276.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jan 2025 14:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736287320; x=1736892120; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ELN3tE1PcOELRVYFu0oyotf1UYI5umGCfo/xf2c5iT4=;
        b=1p7xzz2sOcQR1yuOUNrcprw/ytTwuMTmRLOJg0DKjkTKnm9GMZjsjUJHkJJfMNodWG
         MIezmnhFbGCUzl1o1eTy1N2ees6JrUuCKtz54GGqc+4tZOPgyfJyKDFEhgcYnwzPlpXd
         swCHL4SK0xDI7IRUprINzgHi4HEjDdtuwpbQwyzFCUFFXaFGhS5fNeTcl+cxJylt0R2e
         r0Ab2+yOXNkjEO3L/A6m8xJ90sZGJOEivmX6ZYT1veyag6HjL+nCzZdPI3R+mMo006zH
         3Y5TvDUfgoAy7bYsnqbbf/e4dbrDrB6FkjL94usCQh4+zvrIf7bUM0L22E8A5Gio/LSO
         F34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736287320; x=1736892120;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELN3tE1PcOELRVYFu0oyotf1UYI5umGCfo/xf2c5iT4=;
        b=XJbieKXeXTp/3F4mnZYHSv7r2DCtns45tdGDceSkiPrabu0WWFe+1QasRtN/ZqrbSb
         bvf1ipV0gesgYC7mAfFIcKbaKGq98g7tW/3V59e+cM6eIlgTl8Tz1G9Suw6TC8MRtQd3
         Lxa9UjllsKi+p1dVKu9EoRQ7IPakYJ+5FAcxXGsUR0bUXqxZXcYJuj2gOOVOMCjPLIyr
         bfrirVlhUQ772WcKMv/8wTzQlmpvXeX+kGX4eEwovDkJRXdGBo0Lh7g1Pwe6WsBIGRmP
         a6VKEDKH/uvAQBCkJyMzGg/qDZALiUwRPiI6X3hFamG5rzd0A3vQOFY1OVzstgkMK+dg
         SDXA==
X-Forwarded-Encrypted: i=1; AJvYcCVA9xM/Zf7n6pl6bBSqC/06o9wrAyscAZwilAtIz5rQUKEIGZ116s04rYYCTy4mF3u6Pw9SXVGehSi3CQgSZiXl@vger.kernel.org
X-Gm-Message-State: AOJu0YyQoHVJ+V4VpHbxPRGX7x8eTh/gohezoIP5icG6D9da09ntVjVQ
	2blBoFOF6HY3qRIlgvKjoUfoSV4foAbpjGTp0EaMbx9SBOMiqJKNVb6Jou3TEyDKALDr7Q000cS
	5xegFXQ==
X-Google-Smtp-Source: AGHT+IE8P6bmaO8doUvT/6uD/b37PBCLCmV+KIT5XSAnBrwgk7A1oi/pS5ozt8t21Hsv6kaldx29z/38qyXq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ae:a887:5504:e3ca])
 (user=irogers job=sendgmr) by 2002:a81:b104:0:b0:6e3:8562:fbf with SMTP id
 00721157ae682-6f5312ed968mr16727b3.3.1736287320178; Tue, 07 Jan 2025 14:02:00
 -0800 (PST)
Date: Tue,  7 Jan 2025 14:01:51 -0800
In-Reply-To: <20250107220152.1213959-1-irogers@google.com>
Message-Id: <20250107220152.1213959-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250107220152.1213959-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v2 2/3] perf test: Send list output to stdout rather than stderr
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

