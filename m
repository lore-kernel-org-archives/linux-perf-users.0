Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D129B200
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780209494; cv=none; b=I4BrrrUeDXtTNIb78xe3Od3sVBRv3edHXkNCF9PwxQjfTOnLeRmVB4nZREglN8ojnPdpKDhPE/Utpy6dsMtvmsV/7yF4jIB7xo/b0M18O+VCY2L5SNJaIpE7DDp8PegROCXbUYzb/EkQi8TFm1tBdT33zhAlAAB8XW6PxYjKuDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780209494; c=relaxed/simple;
	bh=kwIpUas8CmAyFq9rUING30MN44XBQkAG67T0YWFq4oc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eVQypC+JStSbIEOwL3t5lu5YqhUBzJIi/4dkHZLHfMbcWY2UAn+KEQqsb4PQsXJbJ0QjtOWXs+iMbbY/ifzEGXruN6MpKmZCDHEiVcOQOtA81sdK9ScevRTRbPVwywaaxnRs5wy6X8lVWKyG+Lc6Z/1k9wMFTvDxuzmEcRlE5UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vxblFMVc; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vxblFMVc"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13709ab38a8so8446418c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 23:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780209492; x=1780814292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1IOal3hqFXb7r1up/rx+u30ZeQHjxIhWl995ZJvn/b8=;
        b=vxblFMVcKmd11aOnMD/D6fZfzDfwLPxDoLCYODvfUevKRmW8d0GE/sRTTQXiPqYB1g
         AKnFkJWCY6qHj9qjEXAwWhvEZDS6sYiW1hy+YEaXZCUWJqlDogwxbaOBjDmnrsh4YNaF
         Ucm9nTOG7Jb1vZVqNz1duq7Qn70nCpwMRunaLzrtMBnfL/F9912IQVMGkYzroV29NL8Q
         76IvV9IulxLAi2n6ifmV3H6AP0/w9rUijDK7vdn/nKGdFO95CiZloEEH0NjBDukYJdYd
         BMORe9hiRlyhn9nwMVHrszhbRQ9CKSCsec5ls4GlB2QCJ5lcLjJlbiLv+Sf6yRHjMnod
         MC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780209492; x=1780814292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IOal3hqFXb7r1up/rx+u30ZeQHjxIhWl995ZJvn/b8=;
        b=R1IM5uTsp5XYuwmz55sTUX9TVs/dizvGKNTRMwP0OWdLg6kQAYk9pdCXkIt/jE86Wp
         5/27UVf7VWkPXm1NcHg4q4i+hngclxR/pPfn4fSKTl1cyDsjMCf8K7mg1dez5n2Vac2Z
         3nkbwRxpJEaWr5AFINVgYfgi0c4hdCO8fUS7+opxVqvb52+4pGh+1fzw7RVb8EP+R5Fo
         hABLzw5ZS9oqNP8BxSCV8Q8NEsT1RdwwQ4BhEZVY1g2kysH69gs/HxBQL05iFO1DT8RS
         RD/ZU8TTY54D/m/PaJMG3nFNDu0G7Blr2Hsj4odKQVbmr7F4CghVZBC0ky4CDI2pDAZi
         RehQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ZRskPmZoVmeSVY0nX7wWSWcjVoVEgi1VI34rdA4/mDM5k1x3CbkWGNOPP7iqrZuhN4yDm2kw8xANmK8trwbL7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9OOIDbugF2wrFf1uYfJJWYvHhiZHOAxsTKPcp2VXhVpVbo9rc
	23kQ5vwkC+iGiqueyga9PYXcZ94oHihHR4WsWwaPlrKS66X13/0R0L/2QrRdttejML5svVw0YjC
	mw9XLxl7Jxg==
X-Received: from dlbvg5.prod.google.com ([2002:a05:7022:7f05:b0:137:da5d:41de])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:238c:b0:136:60e7:53b
 with SMTP id a92af1059eb24-137d402694cmr2240359c88.1.1780209491607; Sat, 30
 May 2026 23:38:11 -0700 (PDT)
Date: Sat, 30 May 2026 23:37:33 -0700
In-Reply-To: <20260531063736.871777-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531052740.796087-1-irogers@google.com> <20260531063736.871777-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531063736.871777-12-irogers@google.com>
Subject: [PATCH v3 11/14] perf test: Split monolithic 'util' test suite into sub-tests
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

