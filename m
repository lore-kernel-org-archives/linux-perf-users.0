Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2153815D1
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780215794; cv=none; b=FG3IS9a/uqowxJasRpwSFvYNYxxN4RXD8X2ts3h13/3htBppy3BFn1w4X5jjYXzDz2lLQJjF8nrYYHNS42RQ7pJdvL7oeO2zVIyzy7SpF8rFGJtRzolezgifNZB8Ubdx6uBpDRZVZRawZ3XRGIRXQKcNrk5WrLSA5ZONmzLCLj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780215794; c=relaxed/simple;
	bh=kwIpUas8CmAyFq9rUING30MN44XBQkAG67T0YWFq4oc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L44IjpZbMnm4yyj+rB4GfG8ARNTYWrP2W5CtgN81oeIpdpbVPr1mgg2+E/WJz4KGepfO0M7S8EU7AZWYZSAUOwdrtx/Z4AWzwKqk2xtd+l7/jijXFJoMoTJyGf4O3QdaH7ljpkTlkTiD6A3O9gk5DfAQAW0FHbo03j5PlsAPG1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hG+v0xWz; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hG+v0xWz"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137dbe27199so2464945c88.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 01:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780215791; x=1780820591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1IOal3hqFXb7r1up/rx+u30ZeQHjxIhWl995ZJvn/b8=;
        b=hG+v0xWzCidgpaKEmiSgjV0LcOTAypT2lvqMYlhpNFyQVF/TVMcamqZVhthdccFUck
         9yN2un4XZFeZv8Yib7kFaU+nf3qSiwxxxUCJa7Hn0u6X5/oLcn3Miiof7mSBEBBOja4O
         0/779qmY2MKBfJLSdo7gfBl3utGgRShmxCZXn/30GVpe/bgKHymxJOYSON3ckRDGMmZ0
         J15OUKSYm0+J+cGOupgkUxdrXoSIfNCkjVikSZdmVMMiQcYURCvXjaUywhON3GaPjZa/
         MPGc2kfL3ChvFNN0vWwcBJWkEnm7NxNdkyD/paxkc9yAC0nTkvM4zQe01QK1ADDMfSjG
         jdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780215791; x=1780820591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IOal3hqFXb7r1up/rx+u30ZeQHjxIhWl995ZJvn/b8=;
        b=pVibZ5s+BY44oztpoE60WNzkYkxMIw9FRnYy4kpaOoP02gZmhqbZ/ZDX87masuuxYA
         9IPyYkfa4NkhG7mQkn34OsKSA7gk2I27Z43Lr9ihOCoYIo/cJ2e+9YUHC2Fu0BsPmaRE
         LOgeRNfJaZdOerONcMRSRN1uJWR9QtnFIRJrl5ox2W4ISFijEB54GKBdpzwqMszHW5Vi
         EWSK+nxVLbm7y0vDkL0grYRAHTatbQ97Zwb776WQT02ar6Ezk4UVZ664sW73LNR94lKu
         hAqwMMw46AMCEE0crGbCDa80Ry4tmPFDZOtFC4KaSMDv77je0gaFCrALMNrcR2nTqcEC
         VWVg==
X-Forwarded-Encrypted: i=1; AFNElJ/IoIrQngvcNRuxS9oBg3kuMD9UXFsskdTdsEakQy0GvBwkAdtL6JwcAfhBF0BQGuajgcTh/bUbGCzsQbvsrY9E@vger.kernel.org
X-Gm-Message-State: AOJu0YyKy7+xsGtZOSiHbLNFAKdFdDpPCpJvLWNyoRVSYZGb78MK0mCr
	RUjmuzcUYYFZqadndNVxkYEUWtic6XBEda5MBv9BAZlA/hbUMw1hq+3mX1WFScskiR54Ocf4mjG
	1liezKR7W3A==
X-Received: from dled8-n1.prod.google.com ([2002:a05:701b:42c8:10b0:12d:bbdf:edcb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:78c:b0:134:c6ab:a512
 with SMTP id a92af1059eb24-137d42a7879mr2309057c88.36.1780215790738; Sun, 31
 May 2026 01:23:10 -0700 (PDT)
Date: Sun, 31 May 2026 01:22:32 -0700
In-Reply-To: <20260531082235.940833-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531063736.871777-1-irogers@google.com> <20260531082235.940833-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531082235.940833-13-irogers@google.com>
Subject: [PATCH v4 12/15] perf test: Split monolithic 'util' test suite into sub-tests
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Refactor the monolithic 'util' test suite into distinct 'String
replacement' and 'BLAKE2s hash' sub-tests using the struct test_case
framework. This improves test reporting granularity and is used in a
subsequent perf test for JUnit XML test result reporting.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/util.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/util.c b/tools/perf/tests/util.c
index bf2c5b133884..f9abd9911e6c 100644
--- a/tools/perf/tests/util.c
+++ b/tools/perf/tests/util.c
@@ -86,7 +86,12 @@ static int test_blake2s(void)
 	return 0;
 }
 
-static int test__util(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
+static int test__blake2s_case(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
+{
+	return test_blake2s();
+}
+
+static int test__strreplace(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
 {
 	TEST_ASSERT_VAL("empty string", test_strreplace(' ', "", "123", ""));
 	TEST_ASSERT_VAL("no match", test_strreplace('5', "123", "4", "123"));
@@ -95,7 +100,16 @@ static int test__util(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	TEST_ASSERT_VAL("replace long", test_strreplace('a', "abcabc", "longlong",
 							"longlongbclonglongbc"));
 
-	return test_blake2s();
+	return 0;
 }
 
-DEFINE_SUITE("util", util);
+static struct test_case tests__util[] = {
+	TEST_CASE("String replacement", strreplace),
+	TEST_CASE("BLAKE2s hash", blake2s_case),
+	{ .name = NULL, }
+};
+
+struct test_suite suite__util = {
+	.desc = "util",
+	.test_cases = tests__util,
+};
-- 
2.54.0.823.g6e5bcc1fc9-goog

