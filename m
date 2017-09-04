From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/13] perf test: Add test case for PERF_SAMPLE_PHYS_ADDR
Date: Mon,  4 Sep 2017 11:00:42 -0300
Message-ID: <20170904140044.22912-12-acme@kernel.org>
References: <20170904140044.22912-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753693AbdIDOFQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Sep 2017 10:05:16 -0400
In-Reply-To: <20170904140044.22912-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Kan Liang <kan.liang@intel.com>

Extend sample-parsing test cases to support new sample type
PERF_SAMPLE_PHYS_ADDR.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Tested-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Stephane Eranian <eranian@google.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1504026672-7304-6-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/sample-parsing.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 6d028f42b3cf..c3858487159d 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -141,6 +141,9 @@ static bool samples_same(const struct perf_sample *s1,
 		}
 	}
 
+	if (type & PERF_SAMPLE_PHYS_ADDR)
+		COMP(phys_addr);
+
 	return true;
 }
 
@@ -206,6 +209,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 			.mask	= sample_regs,
 			.regs	= regs,
 		},
+		.phys_addr	= 113,
 	};
 	struct sample_read_value values[] = {{1, 5}, {9, 3}, {2, 7}, {6, 4},};
 	struct perf_sample sample_out;
@@ -305,7 +309,7 @@ int test__sample_parsing(struct test *test __maybe_unused, int subtest __maybe_u
 	 * were added.  Please actually update the test rather than just change
 	 * the condition below.
 	 */
-	if (PERF_SAMPLE_MAX > PERF_SAMPLE_REGS_INTR << 1) {
+	if (PERF_SAMPLE_MAX > PERF_SAMPLE_PHYS_ADDR << 1) {
 		pr_debug("sample format has changed, some new PERF_SAMPLE_ bit was introduced - test needs updating\n");
 		return -1;
 	}
-- 
2.13.5
