Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D191923098D
	for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 05:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747804846; cv=none; b=kUjaJsOhv9ceb3q/jHJYtrIfuDqcIXm9YQzb+A7H4RMwOEeTocwpFjn/M7ltOUf6Wwf//+Td+d22+t3m6jaOrDJs79TvDSTxqC9qp5pMefrHtU1kFPBgNN7NiE8JB8SWScyXgN+r0g5LfXZFPKwWLsaR3SShhMtHLEJFcFiFwSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747804846; c=relaxed/simple;
	bh=SU/zhua3xa27X+58HP7pYg365af4hTGs/rxoiCSK+P4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=BPG86bcBdW6Ypo8Aq3NG3/roI5N9X/mlh1zzWmO7JwYFzwspQqvBwm7JMCY96URLPXa3dyg9UudD0CT/rARsphgIIqkMoAiDyrFi2DdW0bDVtnePXZV9yZspq6pLXezkMQ2uDUXk4i6hp83Je/ArQH0+DMnXZXkeMB3dBncsVaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=czljydwz; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="czljydwz"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26e0fee53eso3759218a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 May 2025 22:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747804844; x=1748409644; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XLEd97eLycBLRrMYdGKv6zqrSBs+TaaO8Dx0WIFYaV8=;
        b=czljydwztrSxp26fs2T4QH75YRuVY6DJytr3rBo58pCWMz7jzp7Xt+8+CJ5TyJPtuK
         AIzPIx5ZoaeUvou3x9WXjeVBxu1YRXKEkrmzCEYhFBKyBfp9mIKg7AXzSok3VFd04W+K
         KG6kJ1AEMmoLsHfMPJPmyNPBZ5CbsQsKThiiytMhRO9Yw9C9AokRqQv3hX5cez587lij
         ZdNPxi3bpyOBcPHPa1y6aOM75ug21RGkwNuNkb0tDrobSpxmL5TIlATds505sMYrZxRA
         sv/xexPGR81rEUrrFgZ5tKsvVi8H3vPeh/bJAtmaBHzvx1uD3fmGx8OLdKcZJwmOGcgW
         b71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747804844; x=1748409644;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLEd97eLycBLRrMYdGKv6zqrSBs+TaaO8Dx0WIFYaV8=;
        b=fS8rEkaGa2Mk9xGlH4mrfGzfc6mnyUraMTnjDUKcKsfGM1cf57O7n1v6uOSvKsAu+v
         zUad5GtRk+m0b56RkEWXwHeufZDYtDYH7vUpbh5zir/NxlPd6sd15M6h5ZOK/w3wGnSt
         EOKT3b8Ea0TatN4E7+vSRDL6WqQ7i3J/18slWA9+x/c+4i3lGqc9mZxAxbJQBTiZMZDe
         i0icRH9ThcisrVhLV9UGbsMb1EnbdUHTo2oJAmt4GcHHoGju0NeQkmlGQtIwJstUxvDp
         SaJJeRyJSvcXbEuKCHyeiT55u3OS6L2CNSxFl9Q/nn3xMRXx7esybxrGe1n5ta2Zibdg
         bclA==
X-Forwarded-Encrypted: i=1; AJvYcCW+jHr260DgJ3nm6ur0MzCfwgvqcZ+s3e+LJ+4b0nyYNDoO6mfKO98RnkuTi/JvO7ileyyTvroir7hDq6BOVGQf@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/6WZjEw9sX3m4i9ep1/GsUPeFru4YGlG2/jzPE4xA/b1ayPG
	4qqQf5lajqTi0g0FRacKA6RNt7lrXFNMhbVFmGwAAaHSJDEpH0BR28lXhXpyuxFuRb+w+EXDWSi
	UXVOfo5iLvg==
X-Google-Smtp-Source: AGHT+IHaGUX3WqMSNpGH/DurGvhQ3Yn8N+y+4fs3IzvjR7p2c0gn9rhfZhT9qjoNpgoKZUiRL5GKyRwPG30e
X-Received: from pgac20.prod.google.com ([2002:a05:6a02:2954:b0:b1f:8cc1:95c1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7fa6:b0:20a:bde0:beb9
 with SMTP id adf61e73a8af0-2170cb07db0mr27772489637.1.1747804844047; Tue, 20
 May 2025 22:20:44 -0700 (PDT)
Date: Tue, 20 May 2025 22:20:28 -0700
In-Reply-To: <20250521052029.658800-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250521052029.658800-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250521052029.658800-3-irogers@google.com>
Subject: [PATCH v1 2/3] perf test: Move PERF_SAMPLE_WEIGHT_STRUCT parsing to
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
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
2.49.0.1112.g889b7c5bd8-goog

