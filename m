Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020095.outbound.protection.outlook.com [52.101.195.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D15934CFA1;
	Sun, 18 Oct 2026 02:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792291089; cv=fail; b=dgfiI/RHJyTYFXI2efvu/q1B7SmYvxxz1YZNlKJN2L0mW5I/288J8XboZ6L8Sg9s/5uW5gGtkBjmktjb4mmN/I2NnbiZMD00+cYOKf9PEXZuV4PWelCaoEd883vuffODWr9MntHGDOx5DosOoWqWEtR7rSNPF0HIHIL2go6UzkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792291089; c=relaxed/simple;
	bh=SDw0XFJEiBQ85T97KUbjr3B7TusocoG/rVkvbWhQVTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ko4saHQ7laL+D5h1rYLsqxScwNBcNapd3uetYHSa2CXdTNfAC7cxH5PhP8Wp7Km1oxqINJxw6Y2nLE06bUbk0epaF5e205YFxcZFqx4qv2+SFhQJ81TXLbiVASJ3Bq01WbqZcxuPQyWWyn4SCP1B6GIQaqBVmDJLv3VKGxOUHao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/1W7lbQ5tkaDZnooNxnUHECns6VahB8Q5TfNt/syIsHSqWzcMEgvGgwZqofVe6wTS7oY60Vam+eEp+2F38Ru9mpzdaoGYzgvkqPAk/HSZgwnbbQl8cQ0k5WUDHkfZIPRGuTh/l+V98/ISm3+b2OqpvjdEr/KuEdAuuHaA1YJBzYS5bEW770Ck9XjnjTQgJcvDz1Zj0hy6c41lXZOljTt1Fqde/NcfOOb64WIZlwo91obr4sZvqQWFPej2N37n3YLImPoi8T67vpFqtn/e9GUFajl0rMBSpRJovZfVALIL5Gfu1GIx+3fFOvRDf8ZerXkQzJwzrfq+lWdn1qQTVByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=UkaP/wgCXdvMM8lZWBuQfIBtRXLbr9gna9Yd5AB2tSY=;
 b=lBNEq4qHzPVfcexcNyW5TeG1KiK2uno8WY81HL8jmp44oUvILAab8Af5gIz4ZpLU+o7AsZSRdlsWpaPhWcST6PxiXJJIsXcZTUSBQBqNs3oDVSyroCIA1P/9rZgi5A5xxDEyi90TU8qs2veTnZ1jUIfjaryp17jFF73Y7oFiTSY080DkDtb+AsriolNU5fFGyGRCKLXMn8XbDBne8v1OSWdIaDREjhhlHW/hNC+WanRQW6PdQ++blnD1lDK36gGLpievRPoIUSgZwVZPetR3h80lidgl5ORmI6Wb4RQE3s7iI9UdP4wZYqUl4OaMqpnE9sIuoWVe3/PSiJ5S+OrT8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB4333.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Sun, 18 Oct
 2026 02:38:05 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 02:38:05 +0000
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
Subject: [PATCH perf-tools-next v8 2/6] perf ftrace: Support filtering return address comments
Date: Sat, 17 Oct 2026 22:37:49 -0400
Message-ID: <20261018023753.584873-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018023753.584873-1-atomlin@atomlin.com>
References: <20261018023753.584873-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:208:36e::7) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e682d0-9e6b-4f8f-9264-08df2cc0d62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|261009223027099003|22082099003|6133799003|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	cPKSDfDEYd7cB6wWjJAwZM/bAyWkc/aJSHSkRQDh21IhfLkUtZRz9ZxTOUJag3q37X4JOXZd/M65/4PM04sKVXZUjp86FSlfNsn+Ym8yOb0YQFp/IqEWDESM//3ct9SttrhsUJo3fvXUevLEq0jQEi2JdH17ZR4F8IalemdemfnE3C+1ttH/SwRy6/Afu2QtbMZWKTbJ15f3uSNb2tfTwjkc6uaod9QLI4CHs2dyc9nXGhE37sIWiUW1P+4UpuRVhB9xmnb9RilD9u7Nx+IylqahkshyYoBPa03q895WRSQTyu7I9fk0m+9k4fj9VKcD9hasbvfUKPDBUzXL3aPXSUcWIQBqkMywj1DW2HVo7U/O1AXNmtFnYDa15PiAmt6aRSAHSDaIYJz8GTBeGuvUGhEKWrpBMNYYzz0aAzSizGnvA4thNFevUgj85UhOvZKLv3xOwWEc1UVCgQNsAzFcWRCauz6VTXxYN5+YrMngt9bMlbk+gvanoauidIRWr/5LYl3CdHdXsUc9BXUzb10tKCl1TeuIhLVv+LzRWbz9dqHlZ8hiaL9xxeRtjbktAqM8YHSpyN5i4NO2PTCq75r64TU1A78mZZKZYzNKDVhQ31M83To64k0aAAx/DV4mERCdqiYrjpSAaRQgWk5AgykjgO1CTfTvt84YBekHmOzjM2I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(261009223027099003)(22082099003)(6133799003)(10067099003)(3023799007)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?26uQT/i/ZwkR/Rqb4+IxIvfBQMXBGvy8iHd1Yl9OZMNfCiOAFqM5L5CRi9AJ?=
 =?us-ascii?Q?2qyRcuIqkOdMC5kKlvpS5z4XUc4oWDx6GOBUGL2AGGz5cBR11ZomnwYOt9U5?=
 =?us-ascii?Q?kN5e4xeHriBPdgs2ENPWYy2CnqMkYDJqk3hzXAye/+XSirdtgi1VSh0/fYfZ?=
 =?us-ascii?Q?gQVevjWZaNdszIvbUOnhYZuPoKH2UfHrBs80p/5r9hWVed4o8yMa1oMo2dkc?=
 =?us-ascii?Q?QAHslRzW+BtKHgFg819u5NLI4yTlIje2diFZ2wSs0PTuRHCLBp7K1fM2oPn5?=
 =?us-ascii?Q?Cfqn7fdiYIAiEDnI23Fni7AnBFr+PXxzYAyu9pynK/oPQ8w8iV59v5M4E+yB?=
 =?us-ascii?Q?LBxuMtiUc1AGL8PsbuhD08tfYhboNg+wFvA489NgSZDcJWW5Kw/Ds40Z0/zQ?=
 =?us-ascii?Q?etsR+CbVGgR6/as/0tqQ+gI+nfYJ2cSJR7KxpRjxGpVKxlPpyTLh9UHMdvkJ?=
 =?us-ascii?Q?WQJ/In1O9hfkHhA+FobgQXrhLPTMIN4UCk8lfWl9XPfDgP2SSoGq2vHdNzgj?=
 =?us-ascii?Q?xjPDa1IUYE9/7pKR5V/3XbXmR0yDHgthnemK2L6VNMn/MGxS94oJ10N7HSQG?=
 =?us-ascii?Q?7gplonTwUiYF+uG+H6zvVzKhf6jGpM6FyK3zLZq2cBe3fWeEkt4WpnBOexJ4?=
 =?us-ascii?Q?GDFE7dsB0Ig1YVOrZKyTjUzxL9BfQ9kUX2wxz33yNceEW1BuvHu16+osWtId?=
 =?us-ascii?Q?qgnWXqBJooTajHQAqopCrE97CzwFPEyS7+FC9fZtSD43ZrKHJFmddvO8KJTH?=
 =?us-ascii?Q?xMSWd8ob6VfPu8zoiuVl7xRuDwCVHXLOP8blj4nYI+D8CLQBsSBv+PmFUHz6?=
 =?us-ascii?Q?b7MzrihZFxLZ8bYQSmj9UkaNa9pVREBUjIN5mKfJ5GzDn4acQlvlGMjEvqhB?=
 =?us-ascii?Q?aqBF4rUfyuttdWJaF6Qd6cM2+Var7auwX2kGsRZUEc+EaNZzKZygOoqXW5DI?=
 =?us-ascii?Q?g1H8nZqE7ZfmwBIn2g1f7Sj88Qui7ZA5aUdVpFvhgYqQT8LKYCLPkhiIVON6?=
 =?us-ascii?Q?XZDnwILgtiGEjA6aR/8cro/2j+3gpUpMx3Jj3qbhNMD4rav06Hk4Rwyu/cyS?=
 =?us-ascii?Q?1vi2I+dSbuADfuk0FiEAmAesB5VyBjlfoXSTLt9OmDEQc1IHZxytFkWswtd5?=
 =?us-ascii?Q?antk8tUCRvsTd/hdEe0L7heSENtlxOjssu8KhwRSJfjHEaQt5GR5lDLa21C0?=
 =?us-ascii?Q?J7g7kdEeEzol99e2TkdFM4vfcYZH47MDRi00jz5wzyIc7+eUPYNd+wKZRsvp?=
 =?us-ascii?Q?B5Yyj/fobR6v6Ia7CT5z32GwQPYJ6Uq5M+yxvnMiZ+uCchzM86RDWSENv27T?=
 =?us-ascii?Q?9KOZ5RPU4Dg/Njt8j0Lwd+ehPtbRe99T6Zp+RImyer/qnfydrJw0KQ4D0ufU?=
 =?us-ascii?Q?C1upSux//J04tFXWoftQThfoAUjARmXMFEYaHH1YAepgUAkwjgowU8aQBUTf?=
 =?us-ascii?Q?plBiWfdsm/m8htlpQCK2YXivBfTg1LNpIuPvVH8IGds85YJt/0VmkS4fcnRD?=
 =?us-ascii?Q?JoPlbKEmcuCDQYGQoKplMO2fTrpP5ilgSvxmEOflcYFsbj1WkfsXTuRFQSEu?=
 =?us-ascii?Q?/V+mwrILNLJpgN+h553K4FZTIJMmc4WcoeKE1v6TGbpxtbtOlgwx1eFnEx9Q?=
 =?us-ascii?Q?ZBrBEU/RiAeX/4edSOoDE3F8kSAWK9K3WTgjfLrheyRESP2rdG5L9lT0eqbb?=
 =?us-ascii?Q?WKRxenQXdYrDnJPF5BdnfTAHP5vST6g8WnXPJcyIVpKsMun+JqObQTGPUg46?=
 =?us-ascii?Q?WtIfwaSESg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e682d0-9e6b-4f8f-9264-08df2cc0d62d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 02:38:05.0372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8Sq9OZQ6LVK6Z0W0gtC+6w5t838FghFXX2M3gYbc7zJgnymH6DEAvrsrda49+Dqb15H+LoYFEXWvyOw//TZbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB4333

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
index 880eece0bc12..640d6d327215 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -156,6 +156,7 @@ static struct test_suite *generic_tests[] = {
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
index 5982c4e62cd3..cd12ae85ccfa 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -180,6 +180,7 @@ DECLARE_SUITE(perf_hooks);
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

