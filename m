Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCC034A3C9
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294516; cv=none; b=lDBdWHI2F5rrf0c9KWAzczWP/HcpbwdAYaUY2IwhDZ/Wn0wlMCkro7fgipXBs35LH+ENvaCrmSEh/HqpCo3vJxP8LyD+vv4sX7i39zWS81AObzrFDq8tkoX3L2r/n8E036skL0iUq1trmJvRJo8mEgX6lDYRbwkBu/UIQQ2sbHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294516; c=relaxed/simple;
	bh=kwIpUas8CmAyFq9rUING30MN44XBQkAG67T0YWFq4oc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ntjd2Fb251XHpRMUZvnRoebJOauJtatPuCv8hC/FFlvldYa+4NwimCdaVG0NhF6tSOh6jIzfhFvQsWMWT+04a32ZQAK4eLN7jKPTrQ9xcD5AAQH29c0z7y4DqsIAynP1lR092RK5yXWYHjsg9SHO9z7WmKVAhcTfiY758iwVJ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=spXyPIUA; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="spXyPIUA"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84256bee9a9so314989b3a.1
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 23:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780294513; x=1780899313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1IOal3hqFXb7r1up/rx+u30ZeQHjxIhWl995ZJvn/b8=;
        b=spXyPIUAAc3jKPnZUnYlPCv2E/i5fy0WJiM8JzL3n/fhsqd8O4HYkhACP8sGuT6bBw
         P7NshWtwdMY3136Fv4uhsmwF5VKydL2OT3JPLUffMGJ6llJGyxAxamK2ksOJR3r+WoZs
         gkdmxQ1Pf4BtQi0bHU8tZam+gI/PiQGTlA4uTKn7T58EooqrJ9WsvJRqfC+i0F2IWBbw
         zr4X0lEBBYVnx9RreCStRQNZmW3MmHGijWOt+2RdkDT17Ij2HatSFZsZSv5+x9aHVqbH
         OHsoAj97XmSw08mRkEducK5IcQQzYFZpdBbpdgNBbApdVn324Negxe6+ztQalDT0hmxs
         Klog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780294513; x=1780899313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IOal3hqFXb7r1up/rx+u30ZeQHjxIhWl995ZJvn/b8=;
        b=qmjyblIIw9j1+zI5/UfWVJVYdMukBpJEV49D1PlYeFtBGHICMDQBa7W2Y2sgXuoGpW
         +VUIo1P4tj4dOtgNME1whqBWFujebII+907tZc91oIPpL6aGnuCnA7tuKeClGuyg+VRb
         SNOSBzuWytKaI52nLrPw8zaXy4P/+fgv5aldQ31HL2o0krbrZ7+WP0OMv3NUOcvB2che
         ShnnTcw5Ak6unjfBZ9GU1HP3TjOxpWThkbPaVfmQ37e7hlhAtMWLozVuKLKe6jn5604M
         GIgXgNAD1jyaO1P6714j3UoK01SLrWTlhu3HhDbl3blUcGdTofC8ndlbxMpYfWE0LUyC
         GOUA==
X-Forwarded-Encrypted: i=1; AFNElJ+92zO+1cNyyTqNa22uIFTzNtrhPllVe/a3xvGhcNiEuuU9mkjSugu9qbrVGkTEyXsV1XuJj7xVMWwGjsSSTdMA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6yHWviJ7Cvs+1neuVApP0kCU+HEI/3D4cvde/p4agaUjzX1Ya
	vVytglEKbEKVZothaPOn1bYRld1BDuvFJ5fk5H4gUBWDwa1mXt8oyROdDYd0mPP3Cv/CiWuftyj
	DT7gthUzTQg==
X-Received: from pfbki6.prod.google.com ([2002:a05:6a00:9486:b0:842:2121:d449])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3317:b0:82a:1529:2b4f
 with SMTP id d2e1a72fcca58-842257a6f20mr8731962b3a.44.1780294513013; Sun, 31
 May 2026 23:15:13 -0700 (PDT)
Date: Sun, 31 May 2026 23:13:58 -0700
In-Reply-To: <20260601061401.1541457-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601000548.1195604-1-irogers@google.com> <20260601061401.1541457-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601061401.1541457-13-irogers@google.com>
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

