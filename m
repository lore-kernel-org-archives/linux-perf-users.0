Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022105.outbound.protection.outlook.com [52.101.96.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73D03F9287;
	Wed, 14 Oct 2026 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994512; cv=fail; b=P6nzJn5zaypp6u4VJhoQdez+KSiKz5GvDtiKjtNfaDmK8aVKD7/CIxi/s7qch8oCEuZi1rU521rdYOxW4pbF7VTTVkO+Cw0DyI70TZxU9FVbuFIeN0xwl5/IBifRjHlS3nBl8t8OT/5I9XLJyl7eB9yz5jCrIcNrC6fkuC/Mq0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994512; c=relaxed/simple;
	bh=9Zypbs0li1xS9euiteCnpd+GqAEpJ170Vkm3Wzs4Zb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B9GXxCPELMgu1FVT2lRwupOZC1BP02ebjgYKuMpT2D7P3Ml5xieZ2tkkc2xyefubf/Z3caMvyCiNAhAECJgx4BnDDQ2yOjs2h6zJxBuWKVs7P11Tq2M3YtF1+bZzyNPp739MU01ix+8Ij+fOgMW8sZr1dv7Jroab1q2QDs1h/Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4LJQds8qVd5e5aqSIoCKl15avM5d1g6SleiV0PTcT20MgLyIVnZM41G8eUbA2osztg4/AFyBx1QAduCN5bgsoYuYTaLjS/+vFdMI2fjM36Ppp2OKKcXecLIc5onFWLcWHgDGnteQC/qXmjzr105wQuvab4Kz9i1VTRMg3UmoML+vG3rKKPA7uJ8mcc92rOXaSApMrTiWBehMlps67CCSaRf5pfN7OivOkJByU+ZWEi2a/acIIOl/Hvl+R0ctt0fRjqSyrY2SLYX/6eHMz5mNQLOdFkUw/uUzwyk9q/5OpYIbd6nnwqF7iSiNbGnhtqkUU3rivuKk8r6qtMWPERm1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=tpwXyKlzaVGydRb2rtj4aEdEasEsz2fhRGo01PU8T7A=;
 b=artUy9kIpBUaQXVlq5uKiPOp+XnXLLfbjtN4EAwXZ4g5qzkvXdeOGP9HkCj+4jReFyLZqjlfLQlPoEbg+b/qOxQoRBJGPsp1ZMuKPJeJiNLPHDoQT39AviCxFNpBN/PW/X49OljB8Gyj8kiGt/NfEkrSaOVtcQLXEoQ3oFcgoY20l7tn4RquYEfXFma3xRT2ao9RZXRJyQ6PyQcTaI1yldrjzLmBeZL9Q70kMeUWBEOSqb5Em9uLiV1CTxt8h5m1gYwjjyBSjbLIPAMHyS+TWCXrNWZoQdf6x2FUFHCVK353GsbjvBa5cJe0EhEbErFP9BLotDMeWs2VExtCYE31Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB3299.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:64::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 16:15:08 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 16:15:08 +0000
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
Subject: [PATCH perf-tools-next v4 2/5] perf ftrace: Support filtering return address comments
Date: Wed, 14 Oct 2026 12:14:54 -0400
Message-ID: <20261014161457.373253-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014161457.373253-1-atomlin@atomlin.com>
References: <20261014161457.373253-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:208:236::14) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB3299:EE_
X-MS-Office365-Filtering-Correlation-Id: cb934bcc-0271-4240-3ef8-08df2a0e50fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	PPuIdbmbN2+vKpjECsnCO/B4R/zcTK6OZ7TzHdsXyuSVok7qn9ZNyrnfQRPicZjQzr4yxllGDsLD6X0MMXl1/ps1/ERTQ/sfo2/CDB/xZR+jgTW6tameC/Wn5HY0AgSmIb5A8nDP40h8yw0ZlKf19cgKanhlbW2M2IwZD3RoAqOwWGpYgdSKiyJfLvi/+33sjyzZB+lepM0YnM5KBJmJC05/1ka+ETgClM1dxh3+yhM1H6a9sT6B4DGUHgvZB0XIKBp45Vr75AJ++gXLW1dO1G+haFbpdNEXNuMZucR/dL5+hdKF6QXNkqbhYwq+xR+5On9ypsxZDQuOGTXecpjhk9Asq/JpSOOj9gE7fMQu+pDRZk0mafULXXYDX/YLT1v+sDvbZFbxczwHW4/kiqtGOfzPB8dQIK00VhSUCMNktdKF3OguMFk2GhDEWAHYV/qrZXP/r0n+N3DMLhNsVxD0q/a42AMA7qj9hm0zVzS/pi84AfnfnB/y9tlcWYFHTr3rNA69yjEbHOPBPMdD4LNz5YIZrvhBwl3CB+B2PSz3kXsH6bzwk4tRTQtavv+TV8JaGmlqmPp/Nihfqzmud3JWCL7/ZRMPwsSJxcKkCPEQ2sAr82Hw6gO60xuJXeOCJ+tXZ6t9eoK2wfTQb2dOhcRrs3YsTRSKqwQgUMON6228nxM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CIWyBRhfutfub0zwtYRQIQ8X2p/q6cnWYpbpFsakCTMEtrmumS/6+Kvjx+3V?=
 =?us-ascii?Q?u/5Mg9AsH1JJWuCp3/I/7oI89fBoyIjt5jmMmYg+Y8EWlJtnDMI+EA0A3qMS?=
 =?us-ascii?Q?cfFLVfmbGwL/vKytGY1CUwkqe/YblJkFdc3bMRBF8XcsYVy2wl0iFpG63vt/?=
 =?us-ascii?Q?j6N54vVbmB27iGB6UGBMRTJtHUs/0XIoX+r2d1L4mBNVeTQqt6CukakAWZWX?=
 =?us-ascii?Q?OQNGAche903a2oLh/KUZhTnqcjcA8DRWs7b1jYWic0uy2A8CJdMAmAqWvZod?=
 =?us-ascii?Q?B9dT/NlQga3eSKoIVvt+Pu1FJuQelRbhp1S5Dfbdv0GW5M/6/gIGZ5wF8trY?=
 =?us-ascii?Q?TMChd/k/1Zr0D7+xVZoHXnP/YCiolhQx/lGd+GgTPrlWxoiQ373pE7M3rD1A?=
 =?us-ascii?Q?6qqLAk16O5S0GM0eHwl79PiYNEfqcHw4C/eqzcm8EZFYTssPG0u92lFrwCG3?=
 =?us-ascii?Q?5yU7C5mlMi/PuuZ9mCYYtY916e1KRPIfHLOrcaJxXFSz2zxnktdHIiKvTdcZ?=
 =?us-ascii?Q?jI/Q9yQevtUHAqJDPuVw0s9oNlMLLJ3VLIorw352ExGVXWY3w8JQkaUErtqz?=
 =?us-ascii?Q?CDScHtPu3T44hPnnsijAappZKbTz7STuFPTlfp5nq1Ro5KtQtt1jqNqOYEpr?=
 =?us-ascii?Q?WxhnCtmdxj3m1slFN1LQQCh6nMZWc0ngFthsL2sKTcwqpIYEwgwh4lpeS4R4?=
 =?us-ascii?Q?i5FC1g2GMRR4H56P3HRE406q+GoL3BGIHgmDEivqxpkDU5fZ39ginxAfhrFv?=
 =?us-ascii?Q?8WGpNV1nW/CRog1ZCZ7t+Qto4CCC/TdJ5k5/4rbFxsFUvEmuwFJHC1AQVbYR?=
 =?us-ascii?Q?ncR+s5ZLxJFddIEdOwa0TMrVnMpFUlkL75H2CmqhL53c20l7BHC3eI/DCrX5?=
 =?us-ascii?Q?U5yeSK1xWDTNsTCoTceEQI5uIPCzExOHRMpC58zq8y49XFZUaykjguok6Fn2?=
 =?us-ascii?Q?AyfvSPfytxQJ6DeEYavzHjDi8G1NtdFeHDqx6zhW0S97OpaIG+eSl88fuBqN?=
 =?us-ascii?Q?hS3osuby8d1akEaJ4GU73DcsqFsy/ghBCmcVNvHU5hDhZ1rnD18GNEgbRhUN?=
 =?us-ascii?Q?3KjoB5DlR1DsdUVc0/HG3qN5ulGB+ZkgOqC35XPrNGkawZDzA8UzqOfeTNJV?=
 =?us-ascii?Q?VQyiygICsEFy7bsReuYMMzcKkBLbw0GiWssDGTXXiM4XzFth443QTpRDJAJf?=
 =?us-ascii?Q?3pSUKmQl05O72NimtHrSXkyw6+9BmG9KOYzhsQqg+uQBHI1t4+2mhl5qpZ39?=
 =?us-ascii?Q?Q+/TgNg66vBrEzcHymmQGsmhjrD46jdWWx+zmDo5f6ebmI+POQ3btLEbhbm0?=
 =?us-ascii?Q?jIqTBxx5hZgyKTvBF2qWjtFzhyiPFBZ8WPkdAW5hBcGyupgy7aAFchH0MLw1?=
 =?us-ascii?Q?cqQQmfl6FqgPsJq3g+kUwgOPBWk7PE5xGxTFQZziEwWPcSHybZJyxK9j8+U1?=
 =?us-ascii?Q?ac8aEiq+aAJ/SspMEgKb+WCrTdNinQyUi86laCMZWOzEC3T0/E2KTPAaGJQP?=
 =?us-ascii?Q?ywFae0iZz/A+fk+S5NnnRURi5pQwDD3LYAznr6OWPU+S3kYyKeZhAT/CKN8D?=
 =?us-ascii?Q?Jj4+aQoMOgW3oS7sH1IBn967mMxi/Sju28OtyNz2+KgNlpkDnfe/GmzM2CET?=
 =?us-ascii?Q?AFbIqzb3YP8DjScF8E8UIIJed1WxgAmPecamBLWNXRdDG0NipYlkrjcdDH2C?=
 =?us-ascii?Q?qzbwwGx/DkqakBFnLjv1M14UyqZo+Kek2xNwR44m7kmgNxpBAfL0JLvl7ChI?=
 =?us-ascii?Q?gC2vWLNCyA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb934bcc-0271-4240-3ef8-08df2a0e50fe
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:15:08.8213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bPDY2kwUSrVCjdDRvzZkhemgSbmIAk5pnvh7o7rmTb2aPeTcc4eRkhrG+Ng5UNL4vvYYb2hxq4on2p2JRMKDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3299

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
 tools/perf/util/ftrace.c                 | 87 ++++++++++++++++++++++++
 tools/perf/util/ftrace.h                 |  5 ++
 9 files changed, 188 insertions(+)
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
index efd5343dc9ad..b8ab76912a0e 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -828,6 +828,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 				break;
 			for (int i = 0; i < n; i++) {
 				if (buf[i] == '\n') {
+					if (ftrace->filter_retaddr)
+						ftrace_filter_retaddr(linebuf.buf);
 					if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
 						break;
 					strbuf_setlen(&linebuf, 0);
@@ -860,6 +862,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 			break;
 		for (int i = 0; i < n; i++) {
 			if (buf[i] == '\n') {
+				if (ftrace->filter_retaddr)
+					ftrace_filter_retaddr(linebuf.buf);
 				if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
 					break;
 				strbuf_setlen(&linebuf, 0);
@@ -871,6 +875,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	}
 
 	if (!ferror(stdout) && linebuf.len > 0) {
+		if (ftrace->filter_retaddr)
+			ftrace_filter_retaddr(linebuf.buf);
 		fprintf(stdout, "%s\n", linebuf.buf);
 		strbuf_setlen(&linebuf, 0);
 	}
@@ -1836,6 +1842,8 @@ int cmd_ftrace(int argc, const char **argv)
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
index 000000000000..344d36293f5c
--- /dev/null
+++ b/tools/perf/util/ftrace.c
@@ -0,0 +1,87 @@
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
+	char *endptr;
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
+	*offset = strtoull(plus + 1, &endptr, 16);
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

