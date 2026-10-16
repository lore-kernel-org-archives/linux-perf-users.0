Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021088.outbound.protection.outlook.com [52.101.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4982C370D4F;
	Fri, 16 Oct 2026 04:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123416; cv=fail; b=pctD/o8W2lTF9OJMgFWCtdDgomtjAZAUj+rKKr4JrWU8ItXVjadqWXn2aq0UWXeeKBid2ocdRot/WbD58q9pTwGb7sNQ6uvebDMHTqJbxC1G3IMmmlz3I9lMcvf/vUPkVEZBGLsHRq6fl3iLxVp7SIVcWkinNl8VLkZE8seeNxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123416; c=relaxed/simple;
	bh=G7YMDci4IQMLXnN923lMkGBE+tIlkPFOzvfC8FnTHCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VhBIGjCKPLnoQ8dvL9ITq1eDobRziQZUcSOveuF1YqLsyevSvbJzkxKT1BacAZEhn4sKaaCY0Pl7rwBUh188EZRwZ++AwbFvPTM4T2LOlqkqWkkAT4tFBhVDF/xF1EDswtCxtcQYr8GYRUqDmome9klJjkZv7tsDiOmenyKpzEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a45grN5aNwZPP8JxjuquSEfYxI2SlVbKJSlyzpWqEeQ7rJqgwK6HvTJkO9cslFADFs9n/GRGnYkFKEKwuXOlWwknBl3vXy1W+kHH0QN9OAJ72sjOCs0i5m16Ca+nzzhMGIQtSqif7Hbbu1GzvBRReIh8A1n4vd9an7o/c/4M3noiWgUw3rV28ttA4CE0evUT+6hx8KoKIKSBCUAbL0szR2asFPtrTu6qDo+Vpn88OoNFlme4AGrJn9EIH4/lG8Hy6pz4p7tP52pgXlxoQv8IXGlW2r9F92Fm92tQX4tqDLshQMogDOYumRXMKgAiz/UYbThWOVT7bEQ6ALdNNu2V8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=TX/2yRhP5LFzMVsgJhnDlWoSjuJTNcJwx1U8JbBp2d8=;
 b=pb8dpAUbawqndM9Iy2oTs5EfD93wSrA1RfecbIAY4FbZVlEfyW2IYCk3rIBO7TpS2DHtzeiN7XYuovOcrgfsLNX+RBmM6L5L3Zc1QuMWaUFvVaxTVAKmCZem0E1w6Rl4+XfNkdmOzr2J2sKTSSt3ByrikAb8q2LOIFAJHY4ncL+2dmqSp6W4l9Mbzr0+mai9Y5MnL9/42K5FReDDQaJEzQeCQdzVKHG/yfEV31rL6ttzVLHJhoa0VSaUy5acRjmrrWiWFFQAEU/Co7wTVBr55Dp3HwVSkjs5rTERsYz3wBjdAighVcDIpwqRUdgYVDpaJSt2a228DvQw6w+Nh5ROKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOAP123MB8944.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 04:03:29 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 04:03:29 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	atomlin@atomlin.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH perf-tools-next v6 2/5] perf ftrace: Support filtering return address comments
Date: Fri, 16 Oct 2026 00:03:07 -0400
Message-ID: <20261016040310.482876-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016040310.482876-1-atomlin@atomlin.com>
References: <20261016040310.482876-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CP4P284CA0012.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:128::10) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOAP123MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: d4bd8961-3946-4c52-9f41-08df2b3a6fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	L5XMsDwWH6RLnAG/07XmScwAXzV/QNn5pAWJoud5ciDpb2GTvYXX38zFlnGi420yexZvLH74v4LfjU5RfbtQW0EiDoggwzXm8fapa30qUDoxphcvCwKF/jaTIjqYxsS/OeJ9zCAQb5WZ9W+eKf885++yChsXHB/rwb2XMUsjvKqbS4oHkioAUdJWkyUSo7rimnYNOXaxCQZKHouRKdjrHDZBj8tlGCykn1LZIzcJugC0iEFbLDZ+k5KMGCC/noNspACQjNeN5HVjPiIA55orPvLyVf8Zd04DbICdDvelX+czrINfXyzpFssZxoPpkkDqpWvwVSQVO3m7qUn4Wt3j/W4pqwJ1A0MOvmh64/FRsU68D9Lim+Y7bfBHSV3TyccC2pz9V3ZRTHe3I3TgGKJRT8ZyGH8dlHNRDdfl7E8GDOBznaqbUzBHax8QTc1H290vC0bTsEuFF6IFx4oB/OOLNvMWVHpKkFY0noU0gz9EtcY7ze0bBjx05yMMj1V8NWI5F91zajx1yZcJQ0R8EX4bYQC1tGEKi/vpJNqBc9scxF2PILi/K5gZo3qNprzh0uBrV0VqwLNzk8eaLo3lSHawGjwvgmA6DUE667915mnTIDrMBSi7zkOQS7kHPbMLbvMTnvcpV6x2yvMCKRsxtm6nSOdNUUixo2HthRyZeOeBaO8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Da8oS3Kvirs1Z582l1x3B3njGowQFj58ozkJ8PX6DgS34mA6vnWBwHeUKha?=
 =?us-ascii?Q?dWw6n6QLvzqElwC49y5ZLg37yHyALF0wkXV789QRni+Q56oxAqNaYazdxNu/?=
 =?us-ascii?Q?kI07tix6v8dmuVjARNp7kR0dyHmRp6NZDrXPTDQ0ahZGWOgDkuHGWejKSuGd?=
 =?us-ascii?Q?CmFc7/5Gr+EoMwAmOOaM8BNBf2cCzlAt08/8WGw+Lb+oZWGTGfADpZBlwFsu?=
 =?us-ascii?Q?MbTl8somWcfbawuNTJGYxbxT6r3O/8bfUffrOpfbuPd+F14+5GFMCsfak16l?=
 =?us-ascii?Q?FcOifoXilglKXO4PFI7A9NP4Gn9gPQwGG17KYvKS0CX8HCp6400fRcrbiz/+?=
 =?us-ascii?Q?k7Hz5Bi/kzS0HQmhaHJk4uO+1H8Y955Jqr2/lY0tpZapda+WEcAZD05y6NW3?=
 =?us-ascii?Q?+kT9pM0TpUPZiSJavuauUKkzkxry87qbG3JcKQxy2lV4cUo6rDG0l2gkLiAi?=
 =?us-ascii?Q?BlJfJJn+j8kT6lI0J7n327AE4pBquwneD7XNkEz08sPZBA4ZuhS04wQ301gb?=
 =?us-ascii?Q?fKt4g6/0COPeebdl/sFo9ATliAvyeuXTkc8AKk2S8rL9/5muicuyFobH1D/6?=
 =?us-ascii?Q?iKxH0QEdQxADksfjB82lqEgoJO8zYbHnXQyzziwE0MkcuWX1Cdsch07E7x81?=
 =?us-ascii?Q?R7r+vSOix42zHnIuMILfSZ3G/59S53U6qvI5OMuHLjWhEpxTeNlKHs2fYMzM?=
 =?us-ascii?Q?qYcnuZJRucftn3N49N0BsO4r2yEtrdUrF7qthgnB7Jy5lWmt0jcsxY8oNDqU?=
 =?us-ascii?Q?DLaDzzEp8RXQwSUl7U8/Pv2Ux3mhCy2s/MNBX54gM2mCPb5Km4xg/oMl6L1O?=
 =?us-ascii?Q?4E1nYHz5npwn27eynWxU1w864PHRquatdTL//9Tix8k8weZcywr7esAe9it0?=
 =?us-ascii?Q?fz9foARIEjw2rE5CIH8sNrkOmsNwCNJoShtzRbEwPU6mxKQHf18x2WWWgLtd?=
 =?us-ascii?Q?uWsi/5p5o/8aWtC4r8PffQfSfmWo1oxlmgeKwWEVLITs6bvzAm8Ep/gk0dmX?=
 =?us-ascii?Q?tP7KBHLnHYcDduVySX5ZHLg++/8it8n7EWDieX3bqpuMLJYEKcuY76Ae0XW2?=
 =?us-ascii?Q?GUMJ4rTH6Ujir4t7qFT65k0bV7gzoWi0JkMidBiWGpleJ3P13FY1SsGDmUe3?=
 =?us-ascii?Q?lQ6IO0pta8Pa9Qsxz/Q+SDYGo6diHhUR0vvXf50Os4m0EEQsyTHGTXEPwut9?=
 =?us-ascii?Q?K4jpx/gj7xzvo0U3NmjVjZ/7uue1oeAqX56lgU/h6D9pMR0eJbXb5KpTHc6E?=
 =?us-ascii?Q?SNjpHNLdzMC/CDtVmUQKnzi4ao5f/xTcjSO6NsxB0vvpYDOOxBIL9hDMNL0X?=
 =?us-ascii?Q?bDosrODhJdjeDTVoDAaOqRRJvK7iaaVqlUwnd5wrNNvfqsJ/bY/mudTDbLt6?=
 =?us-ascii?Q?Ku8d7phFR5/W3QIoSJsoxdjrDWNX/IPbfKJ9Og7WmxUOSDiBGNi3OUQx9VMb?=
 =?us-ascii?Q?3kbHpGeszKStto0KK+2juVrxBuc2splGou8zGFtd2sDl4BXzvf5VfLDtIYn5?=
 =?us-ascii?Q?U6N1fMuJJlLHg/Di6HFmi+tChkSH6kLAO4n1dkz8NfCWQU4Ezd2CMh719lE/?=
 =?us-ascii?Q?x/jBni8EibMLd0rF4U6j9IFlSJzKroJxdcG4/BBMui2TlHlUoaHtlOWmoAra?=
 =?us-ascii?Q?sb0u344VfcaMJxEHgLvFFx/uE5avy+IBxVYZMo+e38xZfQKpflqExlaCtV1h?=
 =?us-ascii?Q?jEMiLcc3hiB7T7XLj13rRXolpYr4RFEieaXl/gAvQDCNz9ImMEfSChXwUx8C?=
 =?us-ascii?Q?ijeiqKUORA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4bd8961-3946-4c52-9f41-08df2b3a6fb2
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 04:03:29.3838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Re/z75Y3CTzKJIKy2ewut68ys7yD9IQtJe3ETql9ygt5P6fHK08j0utBdKw+uKAtFsiehnhiU4nHUYrPz/eiiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8944

When tracing with the Linux kernel's function graph tracer, enabling
funcgraph-retaddr records the return address of each function entry as
a comment in the trace stream (e.g. /* <-load_elf_phdrs+0x6c/0xb0 */).
While valuable for tracing execution origins, these trailing comments
can add considerable visual clutter to the call graph, particularly
when examining deeply nested call trees or when synthesising higher-level
abstractions.

Introduce support for filtering out return address comments from
function graph trace output. Provide a standalone --filter-retaddr
flag.

Key aspects of this implementation:

    1.  Return address parsing and filtering

        Implement ftrace_filter_retaddr() in tools/perf/util/ftrace.c
        to locate return address comments and strip them in-place with
        memmove(3).

        Additionally, introduce ftrace_parse_retaddr() to parse caller
        symbol names and offsets across diverse output styles (standard
        format, return values, and bracketed addresses), establishing
        the parsing foundation for subsequent inlined callchain
        resolution.

    2.  Command-line interface

        Expose --filter-retaddr in
        tools/perf/builtin-ftrace.c, updating the documentation in
        tools/perf/Documentation/perf-ftrace.txt accordingly.

    3.  Automated verification

        Add a dedicated unit test suite ("Ftrace return address
        processing") in tools/perf/tests/ftrace.c to validate comment
        parsing and string filtering across all supported formats.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  4 ++
 tools/perf/builtin-ftrace.c              |  8 +++
 tools/perf/tests/Build                   |  1 +
 tools/perf/tests/builtin-test.c          |  1 +
 tools/perf/tests/ftrace.c                | 80 ++++++++++++++++++++++
 tools/perf/tests/tests.h                 |  1 +
 tools/perf/util/Build                    |  1 +
 tools/perf/util/ftrace.c                 | 86 ++++++++++++++++++++++++
 tools/perf/util/ftrace.h                 |  5 ++
 9 files changed, 187 insertions(+)
 create mode 100644 tools/perf/tests/ftrace.c
 create mode 100644 tools/perf/util/ftrace.c

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 3f3808e513fe..e8105083e67c 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -134,6 +134,10 @@ OPTIONS for 'perf ftrace trace'
 	  - depth=<n>    - Set max depth for function graph tracer to follow.
 	  - tail         - Print function name at the end.
 
+--filter-retaddr::
+	Filter out function return address comments (`/* <-caller+offset */`)
+	from function_graph output.
+
 
 OPTIONS for 'perf ftrace latency'
 ---------------------------------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 65983259b07e..c715cbebaabe 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -837,6 +837,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 				break;
 			for (int i = 0; i < n; i++) {
 				if (buf[i] == '\n') {
+					if (ftrace->filter_retaddr)
+						ftrace_filter_retaddr(linebuf.buf);
 					if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
 						break;
 					strbuf_setlen(&linebuf, 0);
@@ -874,6 +876,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 			break;
 		for (int i = 0; i < n; i++) {
 			if (buf[i] == '\n') {
+				if (ftrace->filter_retaddr)
+					ftrace_filter_retaddr(linebuf.buf);
 				if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
 					break;
 				strbuf_setlen(&linebuf, 0);
@@ -885,6 +889,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	}
 
 	if (!ferror(stdout) && linebuf.len > 0) {
+		if (ftrace->filter_retaddr)
+			ftrace_filter_retaddr(linebuf.buf);
 		fprintf(stdout, "%s\n", linebuf.buf);
 		strbuf_setlen(&linebuf, 0);
 	}
@@ -1850,6 +1856,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", parse_buffer_size),
 	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
 		    "Trace children processes"),
+	OPT_BOOLEAN_SET(0, "filter-retaddr", &ftrace.filter_retaddr, &ftrace.filter_retaddr_set,
+			"Filter out funcgraph return address comments"),
 	OPT_INTEGER('D', "delay", &ftrace.target.initial_delay,
 		    "Number of milliseconds to wait before starting tracing after program start"),
 	OPT_PARENT(common_options),
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 395f2866094a..136138932fcb 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -72,6 +72,7 @@ perf-test-y += hwmon_pmu.o
 perf-test-y += tool_pmu.o
 perf-test-y += subcmd-help.o
 perf-test-y += kallsyms-split.o
+perf-test-y += ftrace.o
 
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc riscv))
 perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d2f594921e25..9663f48afb92 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -137,6 +137,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__perf_hooks,
 	&suite__unit_number__scnprint,
 	&suite__mem2node,
+	&suite__ftrace,
 	&suite__time_utils,
 	&suite__jit_write_elf,
 	&suite__pfm,
diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
new file mode 100644
index 000000000000..596cecee844e
--- /dev/null
+++ b/tools/perf/tests/ftrace.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include "tests.h"
+#include "debug.h"
+#include "util/ftrace.h"
+
+static int test_parse_retaddr(void)
+{
+	char sym[128];
+	u64 offset = 0;
+
+	/* Standard format */
+	TEST_ASSERT_VAL("parse standard retaddr",
+			ftrace_parse_retaddr("kernel_read() { /* <-load_elf_phdrs+0x6c/0xb0 */",
+					     sym, sizeof(sym), &offset));
+	TEST_ASSERT_EQUAL("sym name", strcmp(sym, "load_elf_phdrs"), 0);
+	TEST_ASSERT_VAL("offset", offset == 0x6c);
+
+	/* With return value */
+	TEST_ASSERT_VAL("parse retaddr with ret",
+			ftrace_parse_retaddr(
+				"__cond_resched(); /* <-load_elf_phdrs+0x6c/0xb0 ret=0x0 */",
+				sym, sizeof(sym), &offset));
+	TEST_ASSERT_EQUAL("sym name", strcmp(sym, "load_elf_phdrs"), 0);
+	TEST_ASSERT_VAL("offset", offset == 0x6c);
+
+	/* Bracketed address */
+	TEST_ASSERT_VAL("parse bracketed retaddr",
+			ftrace_parse_retaddr("foo() { /* <-[0xffffffff818534c8] bar+0x20/0x40 */",
+					     sym, sizeof(sym), &offset));
+	TEST_ASSERT_EQUAL("sym name", strcmp(sym, "bar"), 0);
+	TEST_ASSERT_VAL("offset", offset == 0x20);
+
+	/* No return address */
+	TEST_ASSERT_VAL("no retaddr",
+			!ftrace_parse_retaddr("do_filp_open();", sym, sizeof(sym), &offset));
+
+	return TEST_OK;
+}
+
+static int test_filter_retaddr(void)
+{
+	char line1[] = "kernel_read() { /* <-load_elf_phdrs+0x6c/0xb0 */";
+	char line2[] = "__cond_resched(); /* <-load_elf_phdrs+0x6c/0xb0 ret=0x0 */";
+	char line3[] = "do_filp_open();";
+
+	ftrace_filter_retaddr(line1);
+	TEST_ASSERT_EQUAL("filter standard retaddr", strcmp(line1, "kernel_read() {"), 0);
+
+	ftrace_filter_retaddr(line2);
+	TEST_ASSERT_EQUAL("filter retaddr with ret", strcmp(line2, "__cond_resched();"), 0);
+
+	ftrace_filter_retaddr(line3);
+	TEST_ASSERT_EQUAL("filter line without retaddr unchanged",
+			  strcmp(line3, "do_filp_open();"), 0);
+
+	return TEST_OK;
+}
+
+static int test__ftrace(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	int ret;
+
+	ret = test_parse_retaddr();
+	if (ret != TEST_OK)
+		return ret;
+
+	ret = test_filter_retaddr();
+	if (ret != TEST_OK)
+		return ret;
+
+	return TEST_OK;
+}
+
+DEFINE_SUITE("Ftrace return address processing", ftrace);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 9c96f33483d1..1aec32e094c8 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -163,6 +163,7 @@ DECLARE_SUITE(perf_hooks);
 DECLARE_SUITE(unit_number__scnprint);
 DECLARE_SUITE(mem2node);
 DECLARE_SUITE(maps);
+DECLARE_SUITE(ftrace);
 DECLARE_SUITE(time_utils);
 DECLARE_SUITE(jit_write_elf);
 DECLARE_SUITE(api_io);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2c1f880c4c47..5b082d09006d 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -169,6 +169,7 @@ perf-util-y += list_sort.o
 perf-util-y += mutex.o
 perf-util-y += sharded_mutex.o
 perf-util-y += intel-tpebs.o
+perf-util-y += ftrace.o
 
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
new file mode 100644
index 000000000000..aaf108369c36
--- /dev/null
+++ b/tools/perf/util/ftrace.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <ctype.h>
+#include "util/ftrace.h"
+
+/**
+ * ftrace_parse_retaddr - Parse return address comment from trace line
+ * @str: The trace line containing the comment
+ * @sym_name: Buffer to store the parsed symbol name
+ * @sym_len: Length of the @sym_name buffer
+ * @offset: Pointer to store the parsed offset
+ *
+ * Extract the function name and offset from a funcgraph-retaddr comment
+ * (e.g. "<-load_elf_phdrs+0x6c/0xb0").
+ *
+ * Return: true if successfully parsed, false otherwise.
+ */
+bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset)
+{
+	const char *p = strstr(str, "<-");
+	const char *plus;
+	const char *bracket;
+	size_t name_len;
+
+	if (!p)
+		return false;
+
+	p += 2;
+	while (*p == ' ')
+		p++;
+
+	if (*p == '[') {
+		bracket = strchr(p, ']');
+		if (bracket)
+			p = bracket + 1;
+		while (*p == ' ')
+			p++;
+	}
+
+	plus = strchr(p, '+');
+	if (!plus)
+		return false;
+
+	name_len = plus - p;
+	if (name_len == 0 || name_len >= sym_len)
+		return false;
+
+	memcpy(sym_name, p, name_len);
+	sym_name[name_len] = '\0';
+
+	*offset = strtoull(plus + 1, NULL, 16);
+	return true;
+}
+
+/**
+ * ftrace_filter_retaddr - Remove return address comment from trace line
+ * @str: The trace line to modify
+ *
+ * Find and strip the funcgraph-retaddr comment from the trace line
+ * in-place, removing trailing spaces where applicable.
+ */
+void ftrace_filter_retaddr(char *str)
+{
+	char *start = strstr(str, "/* <-");
+	char *end;
+
+	if (!start)
+		return;
+
+	end = strstr(start, "*/");
+	if (!end)
+		return;
+
+	end += 2; /* skip end-of-comment delimiter */
+
+	/* Also backtrack any spaces before comment */
+	while (start > str && *(start - 1) == ' ')
+		start--;
+
+	memmove(start, end, strlen(end) + 1);
+}
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 950f2efafad2..50216d3fef64 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -39,6 +39,8 @@ struct perf_ftrace {
 	int			graph_verbose;
 	int			graph_thresh;
 	int			graph_tail;
+	bool			filter_retaddr;
+	bool			filter_retaddr_set;
 };
 
 struct filter_entry {
@@ -93,4 +95,7 @@ perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
 
 #endif  /* HAVE_BPF_SKEL */
 
+bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset);
+void ftrace_filter_retaddr(char *str);
+
 #endif  /* __PERF_FTRACE_H__ */
-- 
2.55.0

