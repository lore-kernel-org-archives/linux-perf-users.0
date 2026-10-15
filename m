Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022118.outbound.protection.outlook.com [52.101.101.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D7A2F39B5;
	Thu, 15 Oct 2026 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792026732; cv=fail; b=qCLqKhB+UDgwmmeXhbXvMUVS0eWnhT5qqx2/9dqH/WhofWiaTb/qQnBy8bCPbtYM8Zi/bRHBTNQeBd9aazO6LTKHhfyB63xkYzfBBqqlvDdO5NqOcfJspoZqrjPbzMyJfRfyWNEVEmXwj+uJLQxX7Z4HYQ5LzCUILvRXg/347XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792026732; c=relaxed/simple;
	bh=tHqtaapMKnQuMUzJhveHz9mtdIGWLGVg2vIe89GDl54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dCSX07k3xghedA9PrawtBgxRQvaaK3afI3AQN8S3LUyOc1Vr+CWwPvGogFs3ocGGh3DVAy5HjLs4kDbclHWktL7v6cVh45/rUHtIsZHX5qjOdRr1WWNktazQ77ulph1rVf7FB9wstndb36R6zaM2dhts5bDGZD0JIzj4HjjZK/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLcpW1YvdlzxdufZk5e/gUHCmxrzI2Yx14Kd/Z6bT5fnvVBWRC7CYzg1SnI6U03snSVcQTZrqT6MAxX0U7OkuzbA9xwsdhwgsJcnMSYRSmYDnolQIQkLIzMWo6IXL8W78MDZJUsISRHBUFUXI7zr2XnhhXXLI7KyJK8DkS8YtmkZMfxb4N5srBwb9e+L+1DNWmc6AiPWscRFnIxLsTLWSz2WdMKJiqG8n9zfi39Fog85+efI/74V8t5r9ANwpwB84VcNUEnyOCmJ8XsOs51ZN2t5IP2fZ4MLn/IPjiyC6juCLZYuY0bIhoNtab8vkYLV9r74oL6vBLNJ+pi43HE4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=4M9JmIhxXJk514i2s9R0ftaqx83yMj8+I9WR6pnZr1E=;
 b=EIyBWbJ3Vz8TWjfz6CXNpg9Iw2lmSX+i7l/0RHuvvawVGfrep9e/nrK3VQ8pljlru1Q7HAxpGnAPSLUXQwpQZP/n68irHIS/4MwMPy5OY4cZJAU28fVN/xyAanhRvhXDhPTQnE0F6NQuAFyC2zmHkMrPBSwVXxr+FxBW4gLLsO9LMe42g3hOmQO2irzuuxpC4MVz99FtFOJrSvnggKnhiOVfRt51ZLXFE0IzRlJ59OWzFQQTDuggFOCRLnQXjgBt6hYVHvIn5DiPAi6X1BbAmpa+DtfYnVjXIwpP4h76itLpAA8Cpg+SnPt8P7xOG9tbUT3qz89LyMWNL6EqTRY2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB3927.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 01:12:06 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 01:12:06 +0000
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
Subject: [PATCH perf-tools-next v5 2/5] perf ftrace: Support filtering return address comments
Date: Wed, 14 Oct 2026 21:11:52 -0400
Message-ID: <20261015011155.414667-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015011155.414667-1-atomlin@atomlin.com>
References: <20261015011155.414667-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0955.namprd03.prod.outlook.com
 (2603:10b6:408:108::30) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB3927:EE_
X-MS-Office365-Filtering-Correlation-Id: b96b1364-0d54-4b6d-8496-08df2a59545d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	EoB8V+M8jcEY7q/RSIx73CKXEzopUeO3PxnZE9M5nAP04CSQG/zxBYH8+adr2t2ZivkkbX65ywjqGEgdkTDCO69dyGj3nOUZWKsmjA2A4/ivBt8TEtmvMzjrLtDVxzLf3wNbxgSUdGHSn1tYfDF7nGdQedWRcbzN7x1Tocqug/OuCnQwz7yPuW1f/oOcZFGQnqNDkWSgfTLEEPKBLMrIxNi4A4WY7KsP+sLJjmH52eDtNwDyy6r5lhfAjMDYt0kZyLM45ioYn1tnyJVRx97EnP9Sck+1vftAKs7Y2ek1L5pJNtZe8GNUR49/T7vNHQyJhFE91LiL/AQoMpx348F1MZEArRRs8IfwNHgrqJMJOYXOVVKhwQY2N8haTxAvoBe4k1+T4RvBY1NVXnTqIbeR9AWzIy1tW25TEHR6cIFAn7L004hcCRpbShTLqQqsvPaVq6MESFakFPrP3P89cir18QvBI4Oq2JYrlKDj3uI60xBJGq+3Nt/05H+WaX0NeFL+ioISD/FrWBqyP+fONHRlHi7tdwclhle4LaZYxvt0K9pTRBtmqTlbrqLttZXGGfDSpEtbBSfkLYTGPKXI4wZ3A46FK79fBO8/cNGIbwQMgbzT942BRyIAEd7rK4plyM50HGM+eeNHQyDltzqffNGfhF5KSaCDisQAooArpr8WKis=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wSMbjdmJOcmFmfIgzZD6a01iVp1Znyo+4tIdLZR73kWFejj9RNGG/si7MOtV?=
 =?us-ascii?Q?M2+vQCWpGSrRat4QXyIJXPRKF0mRzSiJyVnX7HPzQZb1o8FqK0iOLkLfJzhW?=
 =?us-ascii?Q?6kG3mCvKoljyZvSWAiKB00fZKcdwKcARfHPCHbKEXWc7h/GP1QlbPhfeoK5c?=
 =?us-ascii?Q?C0oHjsjTAzPjyFme9TEYKH2wi+Rz3axLKbbcKGHZJG3WRCh8DrQChwgSyky0?=
 =?us-ascii?Q?l/76IDSv5AIvlZSJJZzojUqiLVw8NJup+eDjLCvuPMOUo/YdNfQEfTOx3NvW?=
 =?us-ascii?Q?U55O+iyQ4dXs3Q5ybLFcwVbiwrlUyTqd2zLGToAXvt3Qzkmdxcdcv8K+9PnL?=
 =?us-ascii?Q?DXHbStYllv+u8CYL6jdNQ4RDIqYhgCD2P1aV4Nb2M/kpwYgQ27VvpkVXt2Ys?=
 =?us-ascii?Q?aS/B/6vUJM71sRo7Tc/qtUm68NzEc1qE/XvOmVCpers2OsXpPcxdKb9vemjw?=
 =?us-ascii?Q?3RcZRm5LvUFB1pkLUZPXEIMDZt8a6yDDSBAagPwQNIVIc3r4fBuVmO+G6ntx?=
 =?us-ascii?Q?8cOaeXzUBccYavOEMiuFiv830PLSiFxq5SNwN3erjpulydjBnZ1shaQ1d6ZT?=
 =?us-ascii?Q?mbzuFsFdTzlT1WBXA8PdcNAP2ura+V9GV3hfZG159zLVm/ca1x4Z0GOPql9m?=
 =?us-ascii?Q?FLTKsb6PlUNQCB6b+jTmef1sxy/MAB3TX9aKz+1eucDuCQk07AtiswvCsWY/?=
 =?us-ascii?Q?fPVyoy6YGvack8XlwLQ0Z4F3M5+DN1I4b9zAfX0C+Tiy19Oc+HfhWq+WSXUo?=
 =?us-ascii?Q?iywhBS96EfIxRoKP3k5VCcgucweGb9QNtrBDGq9uv+Rim1Y421No6Ceo+5Ne?=
 =?us-ascii?Q?o0brf9aQkB0KURHIIhI0xcTmslX7m4CSExI9Dlo/rUvkb+dR+wQwPZzzPAQu?=
 =?us-ascii?Q?3aqTkYCKg+9z4kY280HGyiFPUb4g/00c953ToE7yPCSzLPlArKnLczlHkNW6?=
 =?us-ascii?Q?5Fy9IgWJsxRyv7WSoGWRtqbRyzrAitecyfT/JGsKfnIdafw4ZlLCvyNLvAPD?=
 =?us-ascii?Q?M0e/9/WVmdxKU0v6FnKSyEKBnf3oUam5kCJJPeCnDhVKL7Sh9RnkOxvo7By0?=
 =?us-ascii?Q?/BHwENAElFTgWee6+yWf2j3yWbAjLdzoZjANG9Il8frbji3rPvsxHz19Je2n?=
 =?us-ascii?Q?nfACIHHg49KqWMYexYgGOCq7Cc6OKHwwtIAolgJtNT9pcAenhXUUcrCQo40E?=
 =?us-ascii?Q?fVkvKi98mdrk/80VL9ZNjn7WShAoUczhtAFHo2e3p9xahpMTNNZ59qK7mX/v?=
 =?us-ascii?Q?YcuJYkl66HxI6j7QB8JPS6XVJnNwnPpG+zolaRV3IalKrdwTRA33xGQMvUm6?=
 =?us-ascii?Q?zkUMPZ4IDp7ZKDBz5Gk1+2juIrRQwRa8XG2Gl97WMgYcBIXPBBVRAOA+hnKI?=
 =?us-ascii?Q?qw5rgN4AN9d9/N4i11TCeMPCrGkv174JSQxkU5TbT0Di/M6fNFCAlYmpF18B?=
 =?us-ascii?Q?3sLrP829LUbfcWDaiuG24+nXi6bfDaCuvt+tHy4PdxJlSn8f/bQZWTEHmbJE?=
 =?us-ascii?Q?ME0MQnrvmSGvjjZqCy0ADVtyHCxeOmDBJ06t6PGBmLhGWk9eCEAQdvolgPo2?=
 =?us-ascii?Q?ybIupJ3Cr/dlxUPsUaHMbxb5N/fo3zD/df/rZ9w+S8Fmf1ytTMRdwFkXe2gg?=
 =?us-ascii?Q?AHpj1xchBg+CsRZ1h3jRWw/d4Ys/xgWWSx3rdq8pxHtQhseeN67GwVEuOpEr?=
 =?us-ascii?Q?FfCy8lCREmso7Y+r05+/kadBH8MhARdS4TZRATVJ8tz8LxpiJNTNJNV+uf0O?=
 =?us-ascii?Q?5r06Zqriyg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96b1364-0d54-4b6d-8496-08df2a59545d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 01:12:06.7381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5N2ozkalakrmzCwetZ8Ms63ByIiWKrGxGuTKmsZ3XwK2hpa/xaRyx8QJzxecijTT7s5zfSjCMVFb4+JtMdfhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3927

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
index 6ee72ae90f67..802e31122770 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -836,6 +836,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 				break;
 			for (int i = 0; i < n; i++) {
 				if (buf[i] == '\n') {
+					if (ftrace->filter_retaddr)
+						ftrace_filter_retaddr(linebuf.buf);
 					if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
 						break;
 					strbuf_setlen(&linebuf, 0);
@@ -873,6 +875,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 			break;
 		for (int i = 0; i < n; i++) {
 			if (buf[i] == '\n') {
+				if (ftrace->filter_retaddr)
+					ftrace_filter_retaddr(linebuf.buf);
 				if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
 					break;
 				strbuf_setlen(&linebuf, 0);
@@ -884,6 +888,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	}
 
 	if (!ferror(stdout) && linebuf.len > 0) {
+		if (ftrace->filter_retaddr)
+			ftrace_filter_retaddr(linebuf.buf);
 		fprintf(stdout, "%s\n", linebuf.buf);
 		strbuf_setlen(&linebuf, 0);
 	}
@@ -1849,6 +1855,8 @@ int cmd_ftrace(int argc, const char **argv)
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

