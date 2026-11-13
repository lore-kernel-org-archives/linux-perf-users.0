Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599660;
	b=u/5hgrJPLUMFC4gI5prGna4vc0Xk0FBDAczU53tnUHzhQgLRvXLmgMcIGDbxZLWHHEAr
	 m47w3kzfPXqiyA9DwojlCppRr4xgyBsp1G0yqHXu60GrwSreSZ3ip13XfBJYicYBqUW7j
	 wW2RC2vt4Q5tu35Kwg2I95fBA8BhfxvEIkQokBNrUIG7YsNq+t3wOFpgbLRKClIy3gx+Q
	 QVHWCp19Ox8JH9iKhzHMUtYsNlyAWDductvgzfed6CDZHV/+/ECu6k+ymfScQyzvgaUFE
	 X4xPNN9+vESApXiUxvv4JXK6JLRQ7/NddFr44pfwucE+fp1FUWLohlTgiAp2ZUP8aOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=WTaRk4meTM8E++jaWjjdEZnlb40hyvo7ApKbOE03G8M=;
	b=blyIQhxEaYmzMJaHAI8mkvyVh77Lyw7I83lyVzhHUR9NnGOBirp2E5Uu3z1Zjov5SMq8
	 zPMFSJdOzaAdPr9e8/DVv/9E5v/E9gsK2F44MlnBheeIXIVrmKo6uB7tMZXe5zfyfIIEU
	 0Ik4t/z8N6u0vVmg0XBb7LfrhVwqyZNsqCr0QkvduIpG34TiAKpahYj1SGZ7qHiJs/x2x
	 OUPEOzycLB4heyMu/QvUPPNIO6oecsZ2g5icuQb0NbIYyvC5RocHZLjdskwTnHmk8ggi8
	 e5/cpAy6Tb0cut/4cW4iEWAkuj03SAuXYp387dgfmJvannrddr8/VHhVP65VBfz9uqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wuk4DfhX;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AED60A5BE8
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85AED60A5BE8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wuk4DfhX
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36f479b9819so1584050eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599659; x=1795204459; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WTaRk4meTM8E++jaWjjdEZnlb40hyvo7ApKbOE03G8M=;
        b=Wuk4DfhX+Pizf4BdAAWiCAItJgoPw98IRjh2LL+w39iFxTKoBAEmzg3U0UTaU9952L
         T/VTMR2xnidFawIMFHHUQFw3U7jrM8mqGRd2daxgovh2EEnWV70ingolBLnrvpCAzGCi
         Il31I4c3NMNR4ZfnjRaJKPToaTBPMXqznxaFoze0m//a/SEZt9e5+NqBoTJ6dLJ0cvZa
         pxZb0mZce/7rqgo+DTwtYIXU+hbaYjb6SvkxlJxxO/oAT4BwdUdomw8jIx95qm71k0J0
         yd9ep12a7rKS1UnKefAH5eyxwZBNCd/rmZqSs17SlxCWPYQ6D6AOuZ/aDeUlq7ky2n80
         4joA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599659; x=1795204459;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WTaRk4meTM8E++jaWjjdEZnlb40hyvo7ApKbOE03G8M=;
        b=bwnLl8AAnb2Mf19jZtM/2v5S0EZgZq+w0H9xSnbc3iCg2d0UbG3QBbRcnP9Vey8f3Z
         XZg+oarRM0aMObsTEbX2AedQLa21/927FkspqahKYBfcrjjkH1/Wjh5xhbmwFrjAIv71
         y1vvL38gVoj7kI5DYyNJEzi+caoqgYQhf6Zgv7yDXyBgvN8kIXE6+BiscxWArj7UaP2p
         2OWUSNNuBZVBhbVGVALZkxi2Y9PDfjhbgJKotRQ+/rXO1HNVXJMCncW4UEVrQ/x+MK/0
         tEV/xPEu9rZu7Xp3aZBPwJ151slRU7E7tYfZE1K6dqEXhhJ4SC6v69ymKzkaxhZjOQOD
         QhVw==
X-Gm-Message-State: APuU4Z+TogN3WJjz5C2A0n7mcUMded3x+nEUIk/FSfIMUhor7M6SvAIt
	UBZsr4KmRYDyujONFk5yhgdVTawfWbTZ1BaKyLQxTM0bVVz9Dv3f84iR0HtxE6cl42JhjKMxZ9R
	UZ0MgJixeEA==
X-Received: from dybme45.prod.google.com ([2002:a05:7301:18ad:b0:36a:10f5:840])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:66d5:20b0:368:4acb:f8a
 with SMTP id 5a478bee46e88-37966e3b866mr3003730eec.17.1794599658369; Fri, 13
 Nov 2026 11:54:18 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:20 -0800
In-Reply-To: <20261113195335.2865725-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195335.2865725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195335.2865725-16-irogers@google.com>
Subject: [PATCH v2 15/30] perf test: Make the CPUID matching test architecture independent
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
index 327483f96401..e8ce94321239 100644
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
2.56.1.703.gf848ed807c-goog

