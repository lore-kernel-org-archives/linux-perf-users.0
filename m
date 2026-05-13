Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E593CAA3B
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713531; cv=none; b=fZn1JrnHemKxz7j17DiA7GzcPHk4UU1op3zh5D1WgrrBRAoN/mMqEzKPy/rhMCvOTNwv14goCOKP7t6/WZUiXL6SJ1tVFGfRMSGTHK6RAPE2yL834/B8NX2kIYj8U00w+TBLCt2gb6/scUey4gVL9IhDZKAdU33gxvqwH8kMrIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713531; c=relaxed/simple;
	bh=3JyidBKbyQaUU7z2Q3fUd5lyDc8xUkZ8FQlJisuH++I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HJxM9lsnMaY884azm19Womre1fx1Sj5aXA9k6hpUVedo7mtGdDUpc1hrs78bdkGFNx4f+55njufUGcywSeuEfTNWgVJRDLP0OPd9dcCJ363LckHM3myh3q36Q+rWAvhnMimGV2bxRL+BTVnhYfbYy5gIolVb7yHCHSxgzKSs1Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jpEOJIUu; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jpEOJIUu"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13367aca29aso1055301c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778713527; x=1779318327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pw58YhNiSJggKohMqKIsVOKLvq7okjwquhtgBlkzQs8=;
        b=jpEOJIUu6y5vOaAZNfZzxMOi0L92TXsHe90D+gIKl8QYHCKJ4JM+nPyyd8fhtAcoI/
         8qj4cZPo6bJWvgZpghK6OS3NxnQKsNLRTexzx0rj24HXfRRwb9+2LZValV8YiS1iY3ve
         PeXAlQhp8cNjDPAFfjcUpOSeNBnVpkuKZIXwmD1n2l05DlWLo5bza0KTAdcYlSF2lpqe
         /UZLPyAKO1zjjfOjug4GZW2W21HVMseWf5C14MDL0wk5u0JjGFM6qPVYUDUUq9hyqxta
         i7dBDJ5nVEoYYSBHMwzPxr0prS6f0Ol58QOeE2QdnL8CIPrHlUQe8UQLLvsGIk+f43TX
         mdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778713527; x=1779318327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pw58YhNiSJggKohMqKIsVOKLvq7okjwquhtgBlkzQs8=;
        b=ExSnYjox9FZqfPWa96yzDRjG2bcrbqrW+lrcZY7yohyax88R9g72fxDIiTvmG0qTgX
         C5f3SzwFy9LyAE3mGzw9IFeJMKeuHDyhV41kkP3MeLEbDVNH5ehBPsr02RZKtl0J8lUD
         j+EMuzJNgkV0FdfnrJfGc3bxdca3dvnmHen5lgtBSDiVVJl8q8hrTXeGdF8j39EdlVwU
         sVqcx8ITV6i/3i/MgtZdShbrrRWF4zGigCsL0FWGSemVWEE5yziYYo1e3wyMnnMF/Ypj
         dgADYfov6jick4Et5bJJyIt9iUu/d5J9xPPe/uLiSK/1ACWXLqwtYlscmqXgnYGXH4CW
         IjJQ==
X-Forwarded-Encrypted: i=1; AFNElJ8C4coQrjoFON4kPINBtbYlGHswnWpn+MODkuIUhbuBV4t+MJYO6z9lidWWPJ/R1Lkv3MOJ7ShIhDAN7wPz9FKe@vger.kernel.org
X-Gm-Message-State: AOJu0YyuhcHkyS2+ohHEOMWulazAIJOcG0XquYLlXuOmRy8+iWzd1O3c
	w4vdfB/8UV6wSM2Qq6oqESeJ05cJHWbdiHhObkd9KHPwci9GvwdNaLhmObImEYn3Li15JNKrZVi
	N0PsOa7AQ4Q==
X-Received: from dlbvv17.prod.google.com ([2002:a05:7022:5f11:b0:132:8d92:4d6f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:128e:b0:133:3bb1:8d41
 with SMTP id a92af1059eb24-1349ab4b325mr2928300c88.28.1778713526619; Wed, 13
 May 2026 16:05:26 -0700 (PDT)
Date: Wed, 13 May 2026 16:04:47 -0700
In-Reply-To: <20260513230450.529380-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513230450.529380-12-irogers@google.com>
Subject: [PATCH v1 11/14] perf test: Split monolithic 'util' test suite into sub-tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
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
2.54.0.563.g4f69b47b94-goog

