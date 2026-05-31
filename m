Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF44931986C
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205290; cv=none; b=l3f8KW3GzO+cjpoCcXJCXaGbsHr0bW8gGouN3KsWQFaLkRf2FAEpY1VJJ/12RCuONwbQFb9C/j4U1rUJmEUpOoiACv/KpMTV9ri8k5cx0AZu8oEsAqP8LCpbUgDU/3EIkvQ7JFgb7joCVlQKd+O+ee7wg2e5L3XF8nP/P8HHWIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205290; c=relaxed/simple;
	bh=kwIpUas8CmAyFq9rUING30MN44XBQkAG67T0YWFq4oc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XHl5kva52Nj1OYjYHMaTy4t+2p4Oij9HG7PTDaLnChA+7Zf/PRhwL4DxSiJCrIZNjvNKJizuS/j0tTU0bQ6Rxx7BNiFiPZPVok/ne4PYMJS8V7zR4stU6CQhte6CNXjP2RPe1yS60ooSRAsP30jxgB3+v2ZW6UtkET/WWzj1hG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RU9/fiE6; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RU9/fiE6"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-135fe34cb98so17045534c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 22:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780205288; x=1780810088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1IOal3hqFXb7r1up/rx+u30ZeQHjxIhWl995ZJvn/b8=;
        b=RU9/fiE6FZm8/7EJodZtBmDwJeadDORsRLUZi6jLbcj76BSWCdn2G71AFLcpvMK1eT
         NzfFOsV836XRrwoq96NKfA7OE3uGr11xkCATxutkffQFd8MM7qIRFKqxD9UG4l44dgY8
         U+T/Qr2Uu81EhKVbATvUGPpiChe/zLV6AXjLGaJe0KRsBUKqE/l5LKklL0hcX4S102YF
         17+hmnir1rZ+4sUXOyxcn8u66P0uY4/NF/IwQqAg1WGMlz9hmQg525oXlrSKpXuIBM2r
         Wa9WQ59Sr/J3i6XlcDKYaLXEKCzS0BP96O/usUQCRdxGo3Q3Mhx4QBGrOeGb2HopHorO
         KGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780205288; x=1780810088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IOal3hqFXb7r1up/rx+u30ZeQHjxIhWl995ZJvn/b8=;
        b=ht/4NSYV3ZOxyqEi5CsM8Ok2NL7yoIfnXCb6Ae5bJDADfS+hnTZRLNYTlcXm+2GB/b
         7wA0bti4eCM3MxupOWoMw+5iCrys3SZsSnZtSLL4jRow/nJqbG54aroxuyUMf7DwipxN
         Nohxn8ENvtiwVg5iO1JGYZayNgas+GT3JJmFkjh0X/oxPL8xKwH93kqL27jjf31S4rPy
         Ma7ks/YOqrb7+LCYab7s7LrTcRzlE9fKI+o4XsS9R3+0B6qsbgDoDy2H1JeRiDiZ8O5E
         ZEiRbbkz9j3Kp3MjU4kKSdLiJ3THht495Hugx0fVcNew21PclJ69f8PNAPUvrNw1nElq
         bcAg==
X-Forwarded-Encrypted: i=1; AFNElJ9COLLhnOHjD1dEObZD96Cp2Mb/S/UaSF/7g1eXgVUlkPKRBCeyXk0cZU2fBIgE2ONxlFXG5Jv1Oyk7f/mFNlQt@vger.kernel.org
X-Gm-Message-State: AOJu0YyS6tfYF46hwozYZhpLnRqY4MJDU7Zdx3ifAhJlvHE004x+p1ar
	gTdczQuK31uhFasCHDIRZOeoVFC4YC2bNRsek5UkNnenAj8NkeeVdlujm7VUCRPPAjcvZsmL58z
	NOziO0BfEWw==
X-Received: from dlan21-n1.prod.google.com ([2002:a05:7022:eb55:10b0:136:82f:7282])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f8f:b0:136:ff02:d00b
 with SMTP id a92af1059eb24-137d412b6c5mr2442654c88.25.1780205287758; Sat, 30
 May 2026 22:28:07 -0700 (PDT)
Date: Sat, 30 May 2026 22:27:37 -0700
In-Reply-To: <20260531052740.796087-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com> <20260531052740.796087-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531052740.796087-12-irogers@google.com>
Subject: [PATCH v2 11/14] perf test: Split monolithic 'util' test suite into sub-tests
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

