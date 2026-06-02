Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F953FF884
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422145; cv=none; b=bx8JVYN1a1j1pnQ0ckSXGOpN32gnOk3X2yj51FU2CzTbEPqlEFm+8V1xTDYwj5sk84zcG14LANfQaJlQVNgADu/MvB+kSQw2V5g7Sv9tSQ2KAK9QDa1drN66aNh1XgKp4JrQ5JQ/+QNLnWJ5Dx79WEXgSGdkpF6CoBoTsmtBmaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422145; c=relaxed/simple;
	bh=VCvZZOPl0PnHKw3y9FptUV/R1CXqUa0az01RQlDyamg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sVzEdLXez76QBVl2vS37B/nILX2A9kDbVjTHj6juGvlwmN0J/zYMxtYQTMyKL7YTLsy7B645BRbD4OFH+8lWJ1AWGUZ8R2SVStLsK5xcJzNZqLFtYAafysyZThBjkD5nXPJM7gr1yLSJPNg6mhx8fqxEm+l07GA1PCNGBoULcEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OggHudZm; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OggHudZm"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304df51ff3eso5702842eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 10:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780422143; x=1781026943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g6/pn7OpFDoDOMJGR8y4harS+WqtNci/6qa5LqKicOU=;
        b=OggHudZmuMoG9CB8MC5j66S2DPFJ+OVRM3dCSwqsozd7uegmmFjsZ3sXsLbHRNZzKZ
         yPDqOvllpt48bvKxLzYhW3yRJnn8IDYTx7/gidiv8GRtrdwsPl/TlO9iq1pyefezPaWY
         uQb6DVRm07ydL9OfXJAX7iH6vu1sq9XMgGFKqUnWP/g2F+2Fz1QlpdX5FKJtMaPNIUGp
         q+eiGQ7qyI344/nynB7h+VROe/n1PqDZQ0K2XJ0k1ieQ+yjI/NjF28h3Xt5DAAVFEP0Z
         cBRBWJ3jhyoCGYNkwSPw1AVcjNUP/PvZ/EZr0nYvFf+0dVYYjhYoC5IzlEqaqyyiNrFC
         /SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780422143; x=1781026943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6/pn7OpFDoDOMJGR8y4harS+WqtNci/6qa5LqKicOU=;
        b=cedMDVs1z5Gf6YV6lQRTXMD0Bhw8kaoUIcjgA4spwLk9qTvjHGL8NLJ8wcP1YI7xRf
         KskK/qtpecQvD21NPO1VgVYOTyxZtIm3AbQQjUMjeOHfjqHTls18xYcvcjX3S/0UwfXC
         sOPtVQhVtf4qZtRultvSQ/UswN1t7p46OYxXcn1Cmn84XECN5ETxt88wX2f3TfmFCTbm
         xRiaztEJBYePgGyFJCCfSgJHhjgICysN855xHcN0cxJLyC4qQUlEMaEg4of56MxCLzlm
         jVcve5PnD4JFdxV7p3wK7G613GwtO4anlgVjxMiH6NrXl7UnAjig0b6pA6XfBtoAO8Fb
         7hbg==
X-Forwarded-Encrypted: i=1; AFNElJ+lYqS7iagPVL10bITqtpCZCY6UTBtaOMSigo/qqiOwaLEVrL+unRiMy1w7IOQ6lajidmHlLu0VjqFLsWr/sz9u@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37DddYQ1nH5EjErTN6T3hhB3eEbgQtkKUbqo/2mW3JjsGvwE0
	bQ+1RZ9Gc1HD0bpTKSQOvgA/vjIfBm2OZi9pqbTABt5+rBdiAlXnkwztaHU5d3A+ekfQQdPoC10
	l8qRv/8X7+g==
X-Received: from dlea3-n2.prod.google.com ([2002:a05:701b:4203:20b0:135:dd6a:be57])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f305:b0:137:f10d:dfb8
 with SMTP id a92af1059eb24-137f10de354mr673280c88.20.1780422142701; Tue, 02
 Jun 2026 10:42:22 -0700 (PDT)
Date: Tue,  2 Jun 2026 10:41:24 -0700
In-Reply-To: <20260602174129.3192312-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602073132.2653307-1-irogers@google.com> <20260602174129.3192312-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602174129.3192312-14-irogers@google.com>
Subject: [PATCH v8 13/18] perf test: Split monolithic 'util' test suite into sub-tests
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
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
2.54.0.1013.g208068f2d8-goog

