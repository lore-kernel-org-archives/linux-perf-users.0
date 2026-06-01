Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967425B1EB
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780272388; cv=none; b=b5zTCfmS/R8M7FsuTVUU9IcWHne8CQdoZ9QDuO7vSgK/pDIGDSRB5+1vClPhPvEMPCADgPWmgwBBjOOgCq4FifalJ4CJlkaNQE/Mi4nNGT3VjFG+XGi5Xgm0quvOo+HNzGomYPRhsDtv2BaWog+lPZ7mQDXLj5ImrQDC1/LBIok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780272388; c=relaxed/simple;
	bh=kwIpUas8CmAyFq9rUING30MN44XBQkAG67T0YWFq4oc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gzvX3zsLs+xBSj5t3MjeuiCIXNDysLe6zuhaUaLlHq8YlbYWB+a5c4Yzw9XUV6a8Is5I1QUQQ1575crxDD3Lfd3WdKnnFa+ENiuHh6vztBTmTIOQz2aVssApOLPMYWAWxOENojxtMA89N8eLUhCwotInCs4/De0CYfUy4uhz4/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LrShGWuf; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LrShGWuf"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-305fe3b697cso556321eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 17:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780272381; x=1780877181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1IOal3hqFXb7r1up/rx+u30ZeQHjxIhWl995ZJvn/b8=;
        b=LrShGWufFkoltPpLN0bvLAwgSrkdvp4YyvXBEVaXPyaEOK5AzSFYTOprmQvZ0xyc00
         BcJZ8th4eK5q131NJuvYc50idF/BkNz03DD6DoTTWIxdp/hKr8os1nRn1ZetLFDnyH1Q
         8/oFfv/CnNbHEuekllRKzR9WmNpI2ZNrbB1DeDhaL2ePdGaHNL6021g+2gP9otKtT1HI
         gqvk5trnOXCk02tVujVIBdFP2jo+HnAu8jFmNiXOpWGotEYyGZESJl0MUzpDwZT/floB
         u6+75+bBA8dlOfVX6fj4Pol1igAE/cYq+c2867gVO90G5fEs8I2Spb/k/lYxpozLrYWv
         vSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780272381; x=1780877181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IOal3hqFXb7r1up/rx+u30ZeQHjxIhWl995ZJvn/b8=;
        b=gAjZJ4DnGvILoTbE8tCF6NAe7EaKzwSnKIh1U7E/QB/zeCFCSXFi7Gh1MwqWt57iVw
         M8WWl7IVHXglKFw3YfU8Lieh3XByyAhtikgP5ouNNzz+pM5rP/3N3NIQu4cedJvdrdke
         yIjSsS+MjGq4OCyI/yeQPpifl4+ErN49mWI+DGtf/AzhF7/dgXYscCjW2NU79ziS+sVx
         6tYZ+xu62Ahrd9mLp0BxMym2ee/PX4rAoV/eBdyHlK4WGMbpxil2ME2y4iGeOpY+k9EN
         phLKleztV/h2qlwVvE6BE2TWanQSBCjvdJjoTWG43wFk8L7OrYNZFS98+l413mtIJiqX
         /7LA==
X-Forwarded-Encrypted: i=1; AFNElJ/25H+yUbcA/fxrUOL2lnpSautREZ5N8d1SSEuav0OO+cOuWziOaUach4TPJpfEieDiIvEFxyUeKNQEacwypS8A@vger.kernel.org
X-Gm-Message-State: AOJu0YyQpfY5mgyqzSUVfBUya8SP2KKAkVy2f0p6hLwiOlO6jftscO+z
	m7onwmOxUlZJ+BjfW8qQG2K7AhMz4Ym4gNQw1WEz4fOJBsfpndke6fmtcHPUgUTzQkxVTTrkY8j
	mdNAAVH/x6Q==
X-Received: from dlee6.prod.google.com ([2002:a05:7022:6286:b0:135:7fdc:4c00])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f96:b0:136:5c88:d928
 with SMTP id a92af1059eb24-137d426d0e5mr3126630c88.19.1780272380346; Sun, 31
 May 2026 17:06:20 -0700 (PDT)
Date: Sun, 31 May 2026 17:05:45 -0700
In-Reply-To: <20260601000548.1195604-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531082235.940833-1-irogers@google.com> <20260601000548.1195604-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601000548.1195604-13-irogers@google.com>
Subject: [PATCH 12/15] perf test: Split monolithic 'util' test suite into sub-tests
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

