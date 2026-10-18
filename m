Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021134.outbound.protection.outlook.com [52.101.100.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD033F5B3;
	Sun, 18 Oct 2026 02:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289643; cv=fail; b=Avq4zug7234KZuqrvzSd/HM7ZCsN4sJptFkO8um8Pm5qPUjJcsjpDhhJfKCOC4wwEQcjzwPANj4AtghOID+3dCh0Ym/Gf70Zq/GYgDjIx20sXCn+SkUW4JN/W3YOhfgncetoBIOfGZmf0FRW8eTLj6iU+LAfkmejyw7mxkuSKZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289643; c=relaxed/simple;
	bh=G7YMDci4IQMLXnN923lMkGBE+tIlkPFOzvfC8FnTHCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fen2Wt6RKn+FBVAgS4C5IuxxdFPsm2a5ekgbVB3T9oeK4m7zPTFsfMWE2oEshu5EBwUHDPwXJhnHOY1I18wniZwDE7MRtV3SGMidmnFS7z+3FoD8r1lmc7NptkTGQ0vFIeYQLv/Sn5dYohP72lEL4Fqyq7YVL62oxxjASKbYjW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idLFUui6uecHcgp92GdTz4NCsU+a9FTXdMnR9lBUzIqXzi174yw3z4PQa0adbLusIm+Hwc3FMLSdrLGzwF06XCa0l0ZpjdWrcSephTfpCxCy6tv/APkkib5tXv5nYG28zxdhH9ovkNjgRIm6n5nbasbS61B+lbNR7TVccVZbniIcLg8OlvkvhxLUKc9dn2plQi6OgMRl4+BCRIN7z73LxeOFmiNqkWWyHN/ovpLmgY+F33N33XIn9Fsqa6DyEODSwfWtNyHT7EdJP7m15byj3vAozMPk7IYHF9emYaAAmyWenuCj+RWG/w5d5vGe7wuVVZIXx5D0BpjNw8KmYUR9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=TX/2yRhP5LFzMVsgJhnDlWoSjuJTNcJwx1U8JbBp2d8=;
 b=OQY9KPDn2WgjYeiBbA7fw2+tEFAKM4ziTFisygzqxM16devfY1y8Pq73BqMIxjET1OTlxnyR2SxcSLWkYf5/9K2Ex2D4hh8wYdaL1h3/N8L5J7RpparTNvU4rpPtBww7TPmPaRX1dg/68QRiETSXpO67CvZouv9K9ikYBwGGy7rOiUmb8XoczDO3zT4o/lUX6lTsYP4d9R8EEEo69+X/U3B0yjOXlIZGFIOuk0ZCAPupvHeF3hwSC1nyuWm/IKXYaPFzYI/LXK9wt5kk0p1Rl2w+vGtvtxdF/UYbaC943CdW1sZhY2bNmyWV3EwmhI453eEhd5XaFkBPjT54TIEZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO8P123MB986281.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:805::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 02:13:59 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 02:13:58 +0000
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
Subject: [PATCH perf-tools-next v7 2/6] perf ftrace: Support filtering return address comments
Date: Sat, 17 Oct 2026 22:13:42 -0400
Message-ID: <20261018021346.582845-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018021346.582845-1-atomlin@atomlin.com>
References: <20261018021346.582845-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:408:e4::28) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO8P123MB986281:EE_
X-MS-Office365-Filtering-Correlation-Id: aa820e74-e368-43a2-39a8-08df2cbd783b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|6133799003|18002099003|22082099003|10067099003|3023799007|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	QG8i5MhS37Z4FV+lFQE6ZbriFvUFlr5FjmlY3o+bSB1CH9hlofDrKpLJMCItF36baVSwCfiEqdboK/L8SCLj/krqGKcbFnHTALcxmcJISAramklNpizskxF4ARzs9ev+14Y0Aei03vJaCvK3qBUOJAPB8OezNO+NkeqiTrqGjrbr+z6QtZJG+v5C/js6w5GMVV7xQcG/4dPMgUuGUGVW2RvOCU1oaOP1ObZBGnv3KM5JH0DVr2SkMmYNwRQmRzk4HNqCadlQSeg0yyaXji6+ZnE6GRMV59Mj9+aSODVB/a50hBq3OQoZOI+fX2QfXlONsszNxradbfiPl3yFymcf7raGDvQGB/zszJIl6ZuiUZRXrrk2v6O0qgdbyZlnufbU6TfCumsR22i0FRUdHHEXBzu6ic2ydMZRqP9wJSHYqlM4EuCgQHzMaq9Z4atoYNZdVy+F9+wlTouw8w1MwtNi8aPXEXaKo9ZMqYdB+uSAdfDpF1TURaMSnE5kB7At0fDJtJMzM0LoP3w+IxWgv6uvE6X8Bs2jBVVxot9L4dQzedVS8GvohjMiFxjw2dc4hRfwv7P84192qkGN2qRikNyWx7b8+pkAh1X53DR/OFONkYqsBUmae884PFLXWfWvwP87g2llAlcklFWLiu6nJdl2wspmXWLLwLoth+9vMAAi/yw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v6dGxjjYUZLDcwPWnCS4bHmpmcmjlkA/AEhPlRvRkvJuWl7SPzPNFaqQr4Mu?=
 =?us-ascii?Q?Wa5hJfXeT2JcWQ8BXJAxxjxyIJoKjjs4F3g2vsVByUQPTW6MV6w/Z+4UiVZ2?=
 =?us-ascii?Q?dLK0bUqF1w9HrBHkUQmz7I5uDnftJeUWhSPmZqbkX9QbVrO3yicn3YRG50jy?=
 =?us-ascii?Q?YJlD8hGW2+YghoLdx/KKauLTe/KnKn6p1erdTJBBENu7157CTfhSZP/uFjvU?=
 =?us-ascii?Q?MXR2PWB5YExPHm2OB2ZTsOxa8B8ii23UcJcuGmxCNWkmbyq30bzfldPVfMYY?=
 =?us-ascii?Q?a2C5lfhXeRr9X3TLRs/32uTSY2e+GzEiyr7Q0AHQEcD8P4DF2z+Kinfx5WQo?=
 =?us-ascii?Q?/R4FFDtAB5E/PxZ2IjIjs9L3vxeZOmQBR7n9ItoO6oOCOv9PlRoXIJTbdu7o?=
 =?us-ascii?Q?qeQt7t9exTHMqjwOk8Sxj4V0rWGz0GZzlfF7jBkmLZ9W3K9+zjEjyFJSlAxw?=
 =?us-ascii?Q?g6gp5rVlpxJjBNSgyLy0qetCPgpOYhgSuOjV0bZrFy2phdqlwGFLsHrxkmNL?=
 =?us-ascii?Q?qUgZTBs6UsBYKOUeYwCfTK3dplyJYJ6KYyC+wDcTQQRodhO1FbjWCPxxZUTh?=
 =?us-ascii?Q?jz6hOA0F4Z+Rr6o1PG3jDu0R7ie+n4MgrtLAwWRE13oDzLMUo9/4/yHufE5o?=
 =?us-ascii?Q?MsRlAgYnGYX3YsaSUTOD5TMEBgVjQJfUch5JdHp9A3UFd6AfSU6sXlZ75RX/?=
 =?us-ascii?Q?arOO6gAUJrq+nynoGmiw6OlUc53yMn6J2z3Z9OoeE47rTpLx7XHttWbkMNm4?=
 =?us-ascii?Q?x4o2lGKA7nq46nxrSySlfVEzhmU5rmSuuNPjPZTUT/l1UWtWXLjGqfPtwMUc?=
 =?us-ascii?Q?0EiuF69ZmJcopC4J5+sGTF6CgyRfq+WHt0NkXqmXG2VNwt9fGo/e2fAs72di?=
 =?us-ascii?Q?UyCeJdD1I5fQtPkcfW4JGhZ8YYrSXykxEnBb9cZZs9XcrFqIeCttRajzY8Ul?=
 =?us-ascii?Q?aHVMY7uRPWFFvsWNz9HXLPRBmTdmACdQqMvPzEfV23gx41FoYz8EgocGt7lY?=
 =?us-ascii?Q?L3LlKcPe90Cu8JpmPQ/4EyWz4Z8w3ntxgSIKO0vsjdxGC/oyaxzPDxuqjz98?=
 =?us-ascii?Q?LxbksoYZFTyvbC97gGKrdX1pzvNLwEu+yHUDTtLtt6UusdWxMNW/bNy7seJ6?=
 =?us-ascii?Q?svaSFkwKS5ZDC1dFWyZUkWC7ivnk7T9NhGG4CWbuu+ALWc4oCJE1OVAOeEEM?=
 =?us-ascii?Q?cEmZkZAEqiMC0kfq7yzocWiajKWasgqgYIVznr3lVlfMx+nvFNcDCvby3+Hn?=
 =?us-ascii?Q?40OICd3Zob5gzMEjFMwDKD6EVX4Zs/wGhXD7x4MxN6h9ckMfa68vYP5qOMyR?=
 =?us-ascii?Q?Dh/93diKXQRipnP3wn4wQgsi41Zu/bafHt1r1wbQgwTvs+sP/cr+QC063pq1?=
 =?us-ascii?Q?vaVLto1xi3HLmNLjD1h1NjCIw2Gq1VVh55bPdPAEPDOg0pU/ekSQCtLWVHrc?=
 =?us-ascii?Q?r9XrCxCJ50U9Kjg9yUHaFsOLv1JKl6JzQ/JsUF8iMxXWXlyZOmyxH8BpPu8f?=
 =?us-ascii?Q?mF0bm8kdfymWHZww2/wWbzFpqvnn9gcLtxEXTkOLqCiAchNxhrWPdH5gs+va?=
 =?us-ascii?Q?x7QPSpVi06j6KXkmt3ek57ZQWpQsJQXuhw0wsDTZy0Q1T7CU3Yr2g9tYxyi/?=
 =?us-ascii?Q?MbZZc+wcICTrQNgEY9X7v6Ef9ax2jiq0sab8GIF+BtBX59Zcuy1dyAAQFnPK?=
 =?us-ascii?Q?Wu688EahA9pwzwKUuDfcZyk6JdwG6t857nvim3BEeeOPwh4eCh3wPhn/2YiS?=
 =?us-ascii?Q?N9I6dBMBsA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa820e74-e368-43a2-39a8-08df2cbd783b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 02:13:58.9105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iaYNzvr3vus8iYkcFsuTNnzcB6/P6JDNTZXVhNo/gFsrdXuVaCtnHcCWG0z2prHGzJXf4gAc20Mu1L/VkWhWDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB986281

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

