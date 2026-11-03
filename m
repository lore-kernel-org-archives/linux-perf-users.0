Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749538;
	b=US05LzksNU5GpNjxPRwU1ibVp0lSlxtuXAtedi7gUk8Wibkdou9QzGK8sl4fEhfvmmHU
	 LfMnNGKgJFc55Vmci7650RvQ2N6ZnkCbkN0tC4YSjysKAXGi1zDo97gv3PPpkp27O7hpv
	 /rCog/kqdh6TkDdyAQ+NYNy50PqT+EDLPIxtmhjJ7hJJ1S/Ag77YFCQXzbv8ELkdMnY/9
	 JAa6ZO5HQYs56cjTvx+lmQK1MlLuKv4lXcz4iDdk1oisqcj/qTj0C9zqWmqqGPx3O4k3z
	 GSdDywJwK8tuwJDJvuP5o1/OLTUfe7VIAgFOI2t9JRe7L0E/7W3TEQ/Rd+9nImAeLVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=f04SE8jtYJAS4lmqfAB8bp6af/1ppJs2us9i398YNlc=;
	b=MUnRq2esZIpVaVRIHVMLWGQxJ6/QB4hS62TAqdqA/+Se94r3t78XeZOTuSiDAjAwB28u
	 T3AAUPVCTtIU93+kt2+ZucQybIgRxeFvzwxax6I1xjI2+wC+slVsgNjmvBoT/+2joVWo6
	 v6l8CwZmRl3YrCXauiwGJg67RvLMf1koyg8Sge9wRhcvaZVbLcbweCvK09KrGbo4IJXiq
	 EJjcbNWVeK09ld+oWelR5s48yVZg58ro81686xYe+rsr+8NHH0xq0/QRRK+PnVVxQksyB
	 l/phmBh1BPH4YEsZkn5HiIKpAthIuKdQsRWnhZmMkXa+DN+x1nY8tMaZA7IIQeu0E8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BncyKMkV;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2437D606D80B
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 23:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2437D606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BncyKMkV
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-14373747468so374908c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 15:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793749537; x=1794354337; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f04SE8jtYJAS4lmqfAB8bp6af/1ppJs2us9i398YNlc=;
        b=BncyKMkVdt4jXMWiwPEG1jr85wLTQ6CSysk9cSRw9kXm57myovGWQpf8KpbnRtUIlj
         KnlNR0iyRprRolXRNXEZ/WdvYeXCBMW8x5JmJ1Nl42QWTUOovYdC3R0phwfuvC4Ah3wt
         MH+TxF5fnEW8Gci05fC1ZmpqJlHmIdU2aSn3o8THt+ub6Z3EBAggXUT980fYmQ9VbLNm
         07G9IKBilGedSAAngvHI5HareF/PO37T+s6fQb9eqOvNejEKDZ9ZywDV7BtLJsGUC00l
         zK4dL/g3amMhNg2vL8IGsJiAcPmlp6NxgcQY5yn6V9Fp+ql8r8E7ZpXHzujOASwPcoX9
         k9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793749537; x=1794354337;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f04SE8jtYJAS4lmqfAB8bp6af/1ppJs2us9i398YNlc=;
        b=SJYs0S8rEnmAF4MuN+3MtTW4RGTl3hUs0Unv9VqRt2KtNrL/vtUUsV9y4i8vcJrgan
         3tyNjiuR1yODqhPr5L/Bv5KtdxoDNlI0CIzGBkalgcxBeMQMd3d/ADfjBAxh4UZ3OmLx
         VosLvE9ZBJqsM5We0sOIKs2pWnoavt9MTtqxri7DHLs4Mj9HkkIx/T8yJomL7qyWMY+t
         667kBzSq6cqFRe7AnroGrgebpgRYo6CX6B3N+nfg4ntwDBruwPg7HFU0YUQRyeQVOIYr
         Rg5AHVLT588AuFdeG886llyz6KsKI3YvzHl8rbIq2kX9edQe5gMrlly4Ud6Rbag18l6N
         EFlw==
X-Gm-Message-State: APuU4Z+D3KL/Tr067n0rTHNeP7USxFcqlFXtXcYzO++CZv7JHaG9BbNM
	GVePDc39gRzKmpxXMlIcrJF3cT804URybfD2fUW2gzryrD87f843IEhiWBi8nER8L9hRn+YrSQn
	JBXwOZRMBh24cfm8OMN4cplrLhQ9OpsCbjVSJZG59A3Woxq8OSGC1dfdn/d9lFUCV7VdFC1kw+z
	C6CFAyI7t5M3tqr7HeAtuYK+AcENuyFqeJLsj6dNGZlBWzgHWRqabvq5s=
X-Received: from dlaj3.prod.google.com ([2002:a05:701b:2803:b0:1ab:7a71:e7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7f0b:b0:13b:3132:6e99
 with SMTP id a92af1059eb24-1ac5af2da84mr19796869c88.20.1793749536644; Tue, 03
 Nov 2026 15:45:36 -0800 (PST)
Date: Tue,  3 Nov 2026 15:44:27 -0800
In-Reply-To: <20261103234502.1008382-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103234502.1008382-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103234502.1008382-12-irogers@google.com>
Subject: [PATCH v1 11/41] perf test: Make the CPUID matching test architecture independent
From: Ian Rogers <irogers@google.com>
To: linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, John Garry <john.garry@linux.dev>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ian Rogers <irogers@google.com>
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
index 58858f3d2bf9..4a45b6740050 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -44,6 +44,7 @@ perf-test-y += stat.o
 perf-test-y += event_update.o
 perf-test-y += event-times.o
 perf-test-y += expr.o
+perf-test-y += cpuid-match.o
 perf-test-y += backward-ring-buffer.o
 perf-test-y += sdt.o
 perf-test-y += is_printable_array.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 0b8897fd42ca..67d162ec9ef2 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -177,6 +177,7 @@ static struct test_suite *generic_tests[] = {
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
index 20ae3609892b..0d54d1d5acd2 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -201,6 +201,7 @@ DECLARE_SUITE(util);
 DECLARE_SUITE(uncore_event_sorting);
 DECLARE_SUITE(subcmd_help);
 DECLARE_SUITE(kallsyms_split);
+DECLARE_SUITE(cpuid_match);
 
 /*
  * PowerPC and S390 do not support creation of instruction breakpoints using the
-- 
2.56.0.385.gac671c819a-goog

