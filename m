Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A56C43333
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6C2564E56
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359274AbhCDAYD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:24:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:18298 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230184AbhCCQJd (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 Mar 2021 11:09:33 -0500
IronPort-SDR: ipZCrbiPH85e5SHLfm/S6ML2Qm5l5TzXK/3UBB0TNgl1NcUD52NI9JS7/4DTgwKEq5ApjpEvQ8
 jGdiAzYsXPKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="187282240"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="187282240"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 08:06:37 -0800
IronPort-SDR: YzOqIgZ2/BFKkVh1AXdukGVrlMQRHVkxRvdNw4tmWoaUWVh/hCHDIYL81lpq1BzD7lbh88SBu8
 YYGo8mM96zvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="586398901"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga005.jf.intel.com with ESMTP; 03 Mar 2021 08:06:37 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, linux-kernel@vger.kernel.org
Cc:     tmricht@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, heiko.carstens@de.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/2] perf test: Support the ins_lat check in the X86 specific test
Date:   Wed,  3 Mar 2021 08:01:25 -0800
Message-Id: <1614787285-104151-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614787285-104151-1-git-send-email-kan.liang@linux.intel.com>
References: <1614787285-104151-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The ins_lat of PERF_SAMPLE_WEIGHT_STRUCT stands for the instruction
latency, which is only available for X86. Add a X86 specific test for
the ins_lat and PERF_SAMPLE_WEIGHT_STRUCT type.

The test__x86_sample_parsing() uses the same way as the
test__sample_parsing() to verify a sample type. Since the ins_lat and
PERF_SAMPLE_WEIGHT_STRUCT are the only X86 specific sample type for now,
the test__x86_sample_parsing() only verify the PERF_SAMPLE_WEIGHT_STRUCT
type. Other sample types are still verified in the generic test.

$perf test 77 -v
77: x86 Sample parsing                                              :
--- start ---
test child forked, pid 102370
test child finished with 0
---- end ----
x86 Sample parsing: Ok

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/include/arch-tests.h   |   1 +
 tools/perf/arch/x86/tests/Build            |   1 +
 tools/perf/arch/x86/tests/arch-tests.c     |   4 +
 tools/perf/arch/x86/tests/sample-parsing.c | 121 +++++++++++++++++++++++++++++
 4 files changed, 127 insertions(+)
 create mode 100644 tools/perf/arch/x86/tests/sample-parsing.c

diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
index 6a54b94..0e20f3d 100644
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@ -10,6 +10,7 @@ int test__rdpmc(struct test *test __maybe_unused, int subtest);
 int test__insn_x86(struct test *test __maybe_unused, int subtest);
 int test__intel_pt_pkt_decoder(struct test *test, int subtest);
 int test__bp_modify(struct test *test, int subtest);
+int test__x86_sample_parsing(struct test *test, int subtest);
 
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 struct thread;
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 36d4f24..28d7933 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -3,5 +3,6 @@ perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
 perf-y += arch-tests.o
 perf-y += rdpmc.o
+perf-y += sample-parsing.o
 perf-$(CONFIG_AUXTRACE) += insn-x86.o intel-pt-pkt-decoder-test.o
 perf-$(CONFIG_X86_64) += bp-modify.o
diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index bc25d72..71aa673 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -31,6 +31,10 @@ struct test arch_tests[] = {
 	},
 #endif
 	{
+		.desc = "x86 Sample parsing",
+		.func = test__x86_sample_parsing,
+	},
+	{
 		.func = NULL,
 	},
 
diff --git a/tools/perf/arch/x86/tests/sample-parsing.c b/tools/perf/arch/x86/tests/sample-parsing.c
new file mode 100644
index 0000000..c92db87
--- /dev/null
+++ b/tools/perf/arch/x86/tests/sample-parsing.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stdbool.h>
+#include <inttypes.h>
+#include <stdlib.h>
+#include <string.h>
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include "event.h"
+#include "evsel.h"
+#include "debug.h"
+#include "util/synthetic-events.h"
+
+#include "tests/tests.h"
+#include "arch-tests.h"
+
+#define COMP(m) do {					\
+	if (s1->m != s2->m) {				\
+		pr_debug("Samples differ at '"#m"'\n");	\
+		return false;				\
+	}						\
+} while (0)
+
+static bool samples_same(const struct perf_sample *s1,
+			 const struct perf_sample *s2,
+			 u64 type)
+{
+	if (type & PERF_SAMPLE_WEIGHT_STRUCT)
+		COMP(ins_lat);
+
+	return true;
+}
+
+static int do_test(u64 sample_type)
+{
+	struct evsel evsel = {
+		.needs_swap = false,
+		.core = {
+			. attr = {
+				.sample_type = sample_type,
+				.read_format = 0,
+			},
+		},
+	};
+	union perf_event *event;
+	struct perf_sample sample = {
+		.weight		= 101,
+		.ins_lat        = 102,
+	};
+	struct perf_sample sample_out;
+	size_t i, sz, bufsz;
+	int err, ret = -1;
+
+	sz = perf_event__sample_event_size(&sample, sample_type, 0);
+	bufsz = sz + 4096; /* Add a bit for overrun checking */
+	event = malloc(bufsz);
+	if (!event) {
+		pr_debug("malloc failed\n");
+		return -1;
+	}
+
+	memset(event, 0xff, bufsz);
+	event->header.type = PERF_RECORD_SAMPLE;
+	event->header.misc = 0;
+	event->header.size = sz;
+
+	err = perf_event__synthesize_sample(event, sample_type, 0, &sample);
+	if (err) {
+		pr_debug("%s failed for sample_type %#"PRIx64", error %d\n",
+			 "perf_event__synthesize_sample", sample_type, err);
+		goto out_free;
+	}
+
+	/* The data does not contain 0xff so we use that to check the size */
+	for (i = bufsz; i > 0; i--) {
+		if (*(i - 1 + (u8 *)event) != 0xff)
+			break;
+	}
+	if (i != sz) {
+		pr_debug("Event size mismatch: actual %zu vs expected %zu\n",
+			 i, sz);
+		goto out_free;
+	}
+
+	evsel.sample_size = __evsel__sample_size(sample_type);
+
+	err = evsel__parse_sample(&evsel, event, &sample_out);
+	if (err) {
+		pr_debug("%s failed for sample_type %#"PRIx64", error %d\n",
+			 "evsel__parse_sample", sample_type, err);
+		goto out_free;
+	}
+
+	if (!samples_same(&sample, &sample_out, sample_type)) {
+		pr_debug("parsing failed for sample_type %#"PRIx64"\n",
+			 sample_type);
+		goto out_free;
+	}
+
+	ret = 0;
+out_free:
+	free(event);
+
+	return ret;
+}
+
+/**
+ * test__x86_sample_parsing - test X86 specific sample parsing
+ *
+ * This function implements a test that synthesizes a sample event, parses it
+ * and then checks that the parsed sample matches the original sample. If the
+ * test passes %0 is returned, otherwise %-1 is returned.
+ *
+ * For now, the PERF_SAMPLE_WEIGHT_STRUCT is the only X86 specific sample type.
+ * The test only checks the PERF_SAMPLE_WEIGHT_STRUCT type.
+ */
+int test__x86_sample_parsing(struct test *test __maybe_unused, int subtest __maybe_unused)
+{
+	return do_test(PERF_SAMPLE_WEIGHT_STRUCT);
+}
-- 
2.7.4

