Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212896;
	b=Nt9I2UQN9Q3Ckac/hwDAPIMkOW1a7mc7sC57XwlMe0EU819r3651HmsjGb5etd1qToZW
	 7KsVbA9P2NUi8MT/goVatUsawPKysq4rQUZ/RVLcZhjs99eQKsviMDYnKysoElEuZdYJl
	 Bvt78uEqzG5Tc4XhKH5qSLc7BK6XpoK/HkpQRgMkuMIr/nGSWKZdOKKtw2Eq0JU5tD+xU
	 /910L3rY15sBmhoQuv1Vz4P2XQ9OSI6sJMchespwq56YkTTJ7kFKIwhzLsPUnvhvBg0W1
	 9X4U0eebgN7Z2ojrtWW1UkBLRtSilef397IuMeSvzbxD6lYDGBigCxyqzTxKdjs6CQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=6oqDW4vAUxH3I7e8ByJaKQ6OdqEOOK+wWOWaZxa4T08=;
	b=bceBpU5NjA6k8GvTk+GDcKuB3hNLL6Pen6U/t+28nLq3LlZecH+WOhzF8Qv/+/aF5Vds
	 Q1iY9B0mqewVLD44VSSht1O7Hkyr8BHQl4oip5/YOfzuieBZowRlgev/3sXmdSE78GG9z
	 z1lVGfqAkY0d2JrjqWx+pIHIoER3+fQJFAGuMIoeNywQuAUo+QjTqzTgWLCIJ6c4LV0EQ
	 Ju/IIOi1mWR9a94LDGwuNNh6w2tgbJw6hbpSIvWw0K4sWztqUz3CzXWrYS5VXS3acBEX2
	 /Ck0x0tr7PaHt62KI7AZPzIuxA13wrCqVU53GNSRYvEqq6Wx0cTWrZMD/tDeuNcILpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HnrCX2f7;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DB8606A332
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92DB8606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HnrCX2f7
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-383435e46f9so1161713eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212892; x=1795817692; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6oqDW4vAUxH3I7e8ByJaKQ6OdqEOOK+wWOWaZxa4T08=;
        b=HnrCX2f7Hkk8C5Z5JUfLlyzqFWh9Cb/zOoN6pnxrwHyWK+QsntDf3mVpKrBI0+Va6W
         A31rSoARlEIaFu4FUoXZLNIDwd3mdSGjqnxSXN6SeFnreItqxDRjXP9rpOJXsQq9LL4O
         mDgEJ4COWsXUYA/8iQj8/GXFcGYYRpr+97qN87hyPPWByMKRr+K0ZX8z4C3GEY1DEqVr
         I4Icvg9HhDtqO3qWeAW6zpO09+PbQ87w4nd5u5DZlQ2S6xWggCCikUB9HuXjUdyPadnM
         HD6LsTXOHJLgsqppLVnTudK/LYdFGEid1u9LxFlFFYXZQQWxJ4xBT9IbeRXvEfH5KwVX
         v5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212892; x=1795817692;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6oqDW4vAUxH3I7e8ByJaKQ6OdqEOOK+wWOWaZxa4T08=;
        b=h5bNh/+sC12CIKzZgYKQloWD6hb55nK938cWMNkAlLYZEzYdgQCrrHxGJ40VcVrEbU
         UPzLpw3ly7pWSSEtxQjNXJaKduIUBnmWPMzwoxocgEmWa3jGnMiPpErEICBwnBJF2hSK
         8al0an9DioMmzWlNtNGTJ9BXU7lg1n7gQR3FtnOOt/RCXtHlxAIC5xwBvsZm+QF7y3a0
         AMxG8k+VwdPZfvHIup1CDG51yl8R/eLCmYKNwxiSauDPKC0FPvonhCtDWo8fbLG1eCB5
         0g0CrHEX1JVfWWCkN0WcHPbbfNM0pMCTc8NvBhtRdQg7eq3ANaRSQze3dVlzRj+4b2wk
         A5WQ==
X-Gm-Message-State: APuU4Z+bb4ctNbC58miHUs2MQsgA6V3ygavXtf9LibnTvkYXfaZuD8rh
	GgUXv+X4y5DwXRZrEtlQX0SgmC/i1mKHjd4HY2rO2BePQHol447WQW3CtU3bH7AlnbV97UoiqNe
	wuByNZfy6/A==
X-Received: from dycc17.prod.google.com ([2002:a05:693c:60d1:b0:385:1a45:47b5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d0a8:b0:386:9957:752f
 with SMTP id 5a478bee46e88-386995777f4mr756348eec.25.1795212891371; Fri, 20
 Nov 2026 14:14:51 -0800 (PST)
Date: Fri, 20 Nov 2026 14:13:16 -0800
In-Reply-To: <20261120221332.2245191-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120221332.2245191-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120221332.2245191-16-irogers@google.com>
Subject: [PATCH v3 15/30] perf test: Make the CPUID matching test architecture independent
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The arm64 CPUID matching test called strcmp_cpuid_str(), whose arm64
MIDR comparison was only built for arm64. Now that strcmp_cpuid_str()
is given the ELF machine of the CPUIDs and all of its comparisons are
in util/header.c, the test can run on every architecture.

Move the test from arch/arm64/tests to tests, as a "CPUID matching"
suite with an "arm64 MIDR" test case.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm64/include/arch-tests.h      |  1 -
 tools/perf/arch/arm64/tests/Build               |  1 -
 tools/perf/arch/arm64/tests/arch-tests.c        |  4 ----
 tools/perf/tests/Build                          |  1 +
 tools/perf/tests/builtin-test.c                 |  1 +
 tools/perf/{arch/arm64 => }/tests/cpuid-match.c | 17 +++++++++++++----
 tools/perf/tests/tests.h                        |  1 +
 7 files changed, 16 insertions(+), 10 deletions(-)
 rename tools/perf/{arch/arm64 => }/tests/cpuid-match.c (75%)

diff --git a/tools/perf/arch/arm64/include/arch-tests.h b/tools/perf/arch/arm64/include/arch-tests.h
index 474d7cf5afbd..2b3834a5ddbb 100644
--- a/tools/perf/arch/arm64/include/arch-tests.h
+++ b/tools/perf/arch/arm64/include/arch-tests.h
@@ -4,7 +4,6 @@
 
 struct test_suite;
 
-int test__cpuid_match(struct test_suite *test, int subtest);
 extern struct test_suite *arch_tests[];
 
 #endif
diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
index d44c9de92d42..bd15c6bbc1b2 100644
--- a/tools/perf/arch/arm64/tests/Build
+++ b/tools/perf/arch/arm64/tests/Build
@@ -2,4 +2,3 @@ perf-test-y += regs_load.o
 perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
 perf-test-y += arch-tests.o
-perf-test-y += cpuid-match.o
diff --git a/tools/perf/arch/arm64/tests/arch-tests.c b/tools/perf/arch/arm64/tests/arch-tests.c
index 74932e72c727..ad16b4f8f63e 100644
--- a/tools/perf/arch/arm64/tests/arch-tests.c
+++ b/tools/perf/arch/arm64/tests/arch-tests.c
@@ -3,13 +3,9 @@
 #include "tests/tests.h"
 #include "arch-tests.h"
 
-
-DEFINE_SUITE("arm64 CPUID matching", cpuid_match);
-
 struct test_suite *arch_tests[] = {
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 	&suite__dwarf_unwind,
 #endif
-	&suite__cpuid_match,
 	NULL,
 };
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 5eebb2ec5dde..404da9804f48 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -45,6 +45,7 @@ perf-test-y += stat.o
 perf-test-y += event_update.o
 perf-test-y += event-times.o
 perf-test-y += expr.o
+perf-test-y += cpuid-match.o
 perf-test-y += backward-ring-buffer.o
 perf-test-y += sdt.o
 perf-test-y += is_printable_array.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 01c78ef20b97..94b54a786992 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -192,6 +192,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__util,
 	&suite__subcmd_help,
 	&suite__kallsyms_split,
+	&suite__cpuid_match,
 	NULL,
 };
 
diff --git a/tools/perf/arch/arm64/tests/cpuid-match.c b/tools/perf/tests/cpuid-match.c
similarity index 75%
rename from tools/perf/arch/arm64/tests/cpuid-match.c
rename to tools/perf/tests/cpuid-match.c
index b073ac33ea9b..e3d4a349f393 100644
--- a/tools/perf/arch/arm64/tests/cpuid-match.c
+++ b/tools/perf/tests/cpuid-match.c
@@ -2,12 +2,11 @@
 #include <linux/compiler.h>
 #include <elf.h>
 
-#include "arch-tests.h"
-#include "tests/tests.h"
+#include "tests.h"
 #include "util/header.h"
 
-int test__cpuid_match(struct test_suite *test __maybe_unused,
-			     int subtest __maybe_unused)
+static int test__cpuid_match_arm64(struct test_suite *test __maybe_unused,
+				   int subtest __maybe_unused)
 {
 	/* midr with no leading zeros matches */
 	if (strcmp_cpuid_str(EM_AARCH64, "0x410fd0c0", "0x00000000410fd0c0"))
@@ -36,3 +35,13 @@ int test__cpuid_match(struct test_suite *test __maybe_unused,
 
 	return 0;
 }
+
+static struct test_case tests__cpuid_match[] = {
+	TEST_CASE("arm64 MIDR", cpuid_match_arm64),
+	{ .name = NULL, }
+};
+
+struct test_suite suite__cpuid_match = {
+	.desc = "CPUID matching",
+	.test_cases = tests__cpuid_match,
+};
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index af822885890d..2306ffb20b57 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -203,6 +203,7 @@ DECLARE_SUITE(util);
 DECLARE_SUITE(uncore_event_sorting);
 DECLARE_SUITE(subcmd_help);
 DECLARE_SUITE(kallsyms_split);
+DECLARE_SUITE(cpuid_match);
 
 /*
  * PowerPC and S390 do not support creation of instruction breakpoints using the
-- 
2.56.1.750.gf70dc682cf-goog

