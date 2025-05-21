Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE3622F757
	for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846424; cv=none; b=ie2tg+EoPqXZAylqLKEzT40UQmQK323l+hnrQDF3kFu4CXrjGJVasEGMIUQTbqZ6MJKTrdHr4rkhu69dT30VvxdFEM7LwijdT4YhycAXYKoNr5CQm1lbcyH1tbpiHryEw7gnp9dGRr4f9FpQjL2idsiBXHcURYLFoq2wZ5zAfJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846424; c=relaxed/simple;
	bh=bFWlZowvZiYprSbmmyKLSfYFC/1vXEHs/kP0XcWnDcM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fVH0tbB+q6dmh05wyRKG8AmojdXulT+qW83tIVAqq/pHtftoGTyI9DKt2rJ6cQ3uwxctCMv0LEYCsmhcpPHNh+UtUGbmd3AOzfmr3dwNshO1GJFWjj0n9BchexVNc6nCYARZKKK07JBKaucYmKIberSSYqeL5sBn4FKEDmD3EHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oa4v4sA6; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oa4v4sA6"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b0e0c573531so4857282a12.3
        for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 09:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747846422; x=1748451222; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0QWUNzvUTNlEHiSxnNTwOU7e00AdrN0Mxw/n6tUwGI=;
        b=oa4v4sA6rQYQqg9rwueXL8LXq7QD8zLXpNNA5ZbsbwCzcojluJN4rOT8fuAbPfWHP1
         iIWMF6uUGregjEpPj5KYiFWinrXo/2aFvi90fKs7KyPMwJ7BuM1euL2dUP/WziiCT2F9
         6bGn45L9yv82afa/YVCEIfTYvgklG5J7RxXopR/jr5sDjUh+O4Pd+eskDOE5ok2AKzEP
         WEhCRxkxFjgEcz/l59LWeEuCQG5veG931enLz7S0+KOfUFzP85RSEzDlAKU/wQgE01H/
         ISXxhiqv2gWrMR0Odr2nppiUev2tDrU9UPi4xPSGmOWbyQpi08wzc+PSM2mKxQI6I3Sv
         9qaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747846422; x=1748451222;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0QWUNzvUTNlEHiSxnNTwOU7e00AdrN0Mxw/n6tUwGI=;
        b=Nwho4iIHthbTlErV81jj7jlTqZWLy7sil3gPnyBQfDOSWLFNOgYuJ4ywSSCT56gJfK
         ESz3gcIlSBs3a/wyWvQHti/c1gcVzfZBIEOMMolne+5RnCcJDJX3RzGwmRKZs2aHTVI6
         rUvhd9wPIv21ABxfyiSrZzzJZLc6uj2Jnv54I6mifTfC/IdhFIUOK2Jwfq/VC0FPPRdW
         shMamSwikDZKh0ghlRZ9b+6PQ+Eu8aQ2N43mUVipdPCOpDU/aisgvaZVag5dSVMCRuSy
         bnphyXCAML/c4OGixuvGnzdeFU4LdaJR+sX0wfYdS32/ux+Kyf1ct4Y9HejhQmZV2wDg
         GZ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUC+JLCXBS+Gz2+YXmvaxOJUYVpPLSLNvClG/CefeTNGhb+qp2ka06DZPyFZkstJh4seX8qQ1rIXSW7DUhTW79V@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcs6KxAdnGtJngJaAVr676CjRfv+RlzIsJBy0k1tfmON01h+2P
	+KAtSnzrS5xXwM333b/mEJBT0smfJOEFoe9UT0FxkfmTaPpeERTBglQGyd7gs+lFfTEi41FF+7p
	MZKw3Bfe8wA==
X-Google-Smtp-Source: AGHT+IH7Pk+tnM+InzOdSMzxqUrBtK+bPU3fUtn2T0ktnQO8fcYiY6FXYUv70SKDJ0QwkiyiHGE1sAia3L/d
X-Received: from pjbpb2.prod.google.com ([2002:a17:90b:3c02:b0:2ff:8471:8e53])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a50:b0:2fa:157e:c790
 with SMTP id 98e67ed59e1d1-30e7d4fe8c3mr29052873a91.5.1747846421733; Wed, 21
 May 2025 09:53:41 -0700 (PDT)
Date: Wed, 21 May 2025 09:53:16 -0700
In-Reply-To: <20250521165317.713463-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250521165317.713463-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1143.g0be31eac6b-goog
Message-ID: <20250521165317.713463-3-irogers@google.com>
Subject: [PATCH v3 2/3] perf test: Move PERF_SAMPLE_WEIGHT_STRUCT parsing to
 common test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Chun-Tse Shao <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>, Song Liu <song@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"

test__x86_sample_parsing is identical to test__sample_parsing except
it explicitly tested PERF_SAMPLE_WEIGHT_STRUCT. Now the parsing code
is common move the PERF_SAMPLE_WEIGHT_STRUCT to the common sample
parsing test and remove the x86 version.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/include/arch-tests.h   |   1 -
 tools/perf/arch/x86/tests/Build            |   1 -
 tools/perf/arch/x86/tests/arch-tests.c     |   2 -
 tools/perf/arch/x86/tests/sample-parsing.c | 125 ---------------------
 tools/perf/tests/sample-parsing.c          |  14 +++
 5 files changed, 14 insertions(+), 129 deletions(-)
 delete mode 100644 tools/perf/arch/x86/tests/sample-parsing.c

diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
index 4fd425157d7d..957934417b26 100644
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@ -12,7 +12,6 @@ int test__insn_x86(struct test_suite *test, int subtest);
 int test__intel_pt_pkt_decoder(struct test_suite *test, int subtest);
 int test__intel_pt_hybrid_compat(struct test_suite *test, int subtest);
 int test__bp_modify(struct test_suite *test, int subtest);
-int test__x86_sample_parsing(struct test_suite *test, int subtest);
 int test__amd_ibs_via_core_pmu(struct test_suite *test, int subtest);
 int test__amd_ibs_period(struct test_suite *test, int subtest);
 int test__hybrid(struct test_suite *test, int subtest);
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 5e00cbfd2d56..4c27b85b960a 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -2,7 +2,6 @@ perf-test-$(CONFIG_DWARF_UNWIND) += regs_load.o
 perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
 perf-test-y += arch-tests.o
-perf-test-y += sample-parsing.o
 perf-test-y += hybrid.o
 perf-test-$(CONFIG_AUXTRACE) += intel-pt-test.o
 ifeq ($(CONFIG_EXTRA_TESTS),y)
diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index bfee2432515b..1023c83684ce 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -23,7 +23,6 @@ struct test_suite suite__intel_pt = {
 #if defined(__x86_64__)
 DEFINE_SUITE("x86 bp modify", bp_modify);
 #endif
-DEFINE_SUITE("x86 Sample parsing", x86_sample_parsing);
 DEFINE_SUITE("AMD IBS via core pmu", amd_ibs_via_core_pmu);
 DEFINE_SUITE_EXCLUSIVE("AMD IBS sample period", amd_ibs_period);
 static struct test_case hybrid_tests[] = {
@@ -49,7 +48,6 @@ struct test_suite *arch_tests[] = {
 #if defined(__x86_64__)
 	&suite__bp_modify,
 #endif
-	&suite__x86_sample_parsing,
 	&suite__amd_ibs_via_core_pmu,
 	&suite__amd_ibs_period,
 	&suite__hybrid,
diff --git a/tools/perf/arch/x86/tests/sample-parsing.c b/tools/perf/arch/x86/tests/sample-parsing.c
deleted file mode 100644
index 95d8f7f1d2fb..000000000000
--- a/tools/perf/arch/x86/tests/sample-parsing.c
+++ /dev/null
@@ -1,125 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#include <stdbool.h>
-#include <inttypes.h>
-#include <stdlib.h>
-#include <string.h>
-#include <linux/bitops.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-
-#include "event.h"
-#include "evsel.h"
-#include "debug.h"
-#include "util/sample.h"
-#include "util/synthetic-events.h"
-
-#include "tests/tests.h"
-#include "arch-tests.h"
-
-#define COMP(m) do {					\
-	if (s1->m != s2->m) {				\
-		pr_debug("Samples differ at '"#m"'\n");	\
-		return false;				\
-	}						\
-} while (0)
-
-static bool samples_same(const struct perf_sample *s1,
-			 const struct perf_sample *s2,
-			 u64 type)
-{
-	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
-		COMP(ins_lat);
-		COMP(p_stage_cyc_or_retire_lat);
-	}
-
-	return true;
-}
-
-static int do_test(u64 sample_type)
-{
-	struct evsel evsel = {
-		.needs_swap = false,
-		.core = {
-			. attr = {
-				.sample_type = sample_type,
-				.read_format = 0,
-			},
-		},
-	};
-	union perf_event *event;
-	struct perf_sample sample = {
-		.weight		= 101,
-		.ins_lat        = 102,
-		.p_stage_cyc_or_retire_lat = 103,
-	};
-	struct perf_sample sample_out;
-	size_t i, sz, bufsz;
-	int err, ret = -1;
-
-	sz = perf_event__sample_event_size(&sample, sample_type, 0);
-	bufsz = sz + 4096; /* Add a bit for overrun checking */
-	event = malloc(bufsz);
-	if (!event) {
-		pr_debug("malloc failed\n");
-		return -1;
-	}
-
-	memset(event, 0xff, bufsz);
-	event->header.type = PERF_RECORD_SAMPLE;
-	event->header.misc = 0;
-	event->header.size = sz;
-
-	err = perf_event__synthesize_sample(event, sample_type, 0, &sample);
-	if (err) {
-		pr_debug("%s failed for sample_type %#"PRIx64", error %d\n",
-			 "perf_event__synthesize_sample", sample_type, err);
-		goto out_free;
-	}
-
-	/* The data does not contain 0xff so we use that to check the size */
-	for (i = bufsz; i > 0; i--) {
-		if (*(i - 1 + (u8 *)event) != 0xff)
-			break;
-	}
-	if (i != sz) {
-		pr_debug("Event size mismatch: actual %zu vs expected %zu\n",
-			 i, sz);
-		goto out_free;
-	}
-
-	evsel.sample_size = __evsel__sample_size(sample_type);
-
-	err = evsel__parse_sample(&evsel, event, &sample_out);
-	if (err) {
-		pr_debug("%s failed for sample_type %#"PRIx64", error %d\n",
-			 "evsel__parse_sample", sample_type, err);
-		goto out_free;
-	}
-
-	if (!samples_same(&sample, &sample_out, sample_type)) {
-		pr_debug("parsing failed for sample_type %#"PRIx64"\n",
-			 sample_type);
-		goto out_free;
-	}
-
-	ret = 0;
-out_free:
-	free(event);
-
-	return ret;
-}
-
-/**
- * test__x86_sample_parsing - test X86 specific sample parsing
- *
- * This function implements a test that synthesizes a sample event, parses it
- * and then checks that the parsed sample matches the original sample. If the
- * test passes %0 is returned, otherwise %-1 is returned.
- *
- * For now, the PERF_SAMPLE_WEIGHT_STRUCT is the only X86 specific sample type.
- * The test only checks the PERF_SAMPLE_WEIGHT_STRUCT type.
- */
-int test__x86_sample_parsing(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
-{
-	return do_test(PERF_SAMPLE_WEIGHT_STRUCT);
-}
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 72411580f869..ad57e34bda19 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -152,6 +152,12 @@ static bool samples_same(struct perf_sample *s1,
 	if (type & PERF_SAMPLE_WEIGHT)
 		COMP(weight);
 
+	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
+		COMP(weight);
+		COMP(ins_lat);
+		COMP(p_stage_cyc_or_retire_lat);
+	}
+
 	if (type & PERF_SAMPLE_DATA_SRC)
 		COMP(data_src);
 
@@ -269,6 +275,8 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		.cgroup		= 114,
 		.data_page_size = 115,
 		.code_page_size = 116,
+		.ins_lat	= 117,
+		.p_stage_cyc_or_retire_lat = 118,
 		.aux_sample	= {
 			.size	= sizeof(aux_data),
 			.data	= (void *)aux_data,
@@ -439,6 +447,12 @@ static int test__sample_parsing(struct test_suite *test __maybe_unused, int subt
 		if (err)
 			return err;
 	}
+	sample_type = (PERF_SAMPLE_MAX - 1) & ~PERF_SAMPLE_WEIGHT_STRUCT;
+	for (i = 0; i < ARRAY_SIZE(rf); i++) {
+		err = do_test(sample_type, sample_regs, rf[i]);
+		if (err)
+			return err;
+	}
 
 	return 0;
 }
-- 
2.49.0.1143.g0be31eac6b-goog

