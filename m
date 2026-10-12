Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020142.outbound.protection.outlook.com [52.101.196.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008323C39A;
	Mon, 12 Oct 2026 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791765030; cv=fail; b=IXyxi+TINnzFBumPFGUNhElL6u6Qi+Zhb8WRwr1pvptdQM4XwFvN230+D1teXju894h+l8JmP8Ye3jSDuI9Ww24NAz4Nv72j1dl2Xu7nAWnpYThF896JpMonPbjtH5Kzu6UZK0LZMqnZbu6sXA3LizR7d3966UOv78fnrEvTgeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791765030; c=relaxed/simple;
	bh=sJ0HtXGif0kaOpfHHNqzjGUvHaToLZbLAejSYE7b3yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ieIgjyhY7WFOU0co5BTCO82Hkhm8NELs3yvxrOcy4A6ZKghkFTz09PhL0Io3iu+PB1P3CHRZpAg+j6w/pViojdjuhFpN34pQb7SB2p+i0vK7hwg/FK3oAGpPi+E98wGq6XjTVWr5FBGoSzxLiw4ZTOVLM2zGbBifpSFHZ1UHafc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuhceFiJpIAX/z7+LXj8W7xQN8rVo/6LLTgF90DlSm3+4uv2ScKgnTLXSeKNoUw6oh5M1x3betD2SCxmzarSrnwGXA4mJMXiZ0s9A0nq2sataGGJSoR/2+Dmd07tLEFkQDQF6J4VGPpVESJpCKkzeXK2a52vybBOs4iUli8+S/tUZvMONckYPs19m9R7iwDLH9Yi0fQxYLwFuOfVazuDPaKIgQLpiYtAAaP8olt6vdiGG3MvXo2+dS7kjfhyxaNRiyy8tITkKOIM/kGxQU5Mmebsfga19dtRrZkpKyT6Lih7gMoa3KLqr9Kb/Cqf00eYtKWZJ/v7XBXjA3unRa4cQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=1LlTx2bF9xJbxYKmzK3O11wSonwIEocSZAOeO3B4Gnc=;
 b=PkJ/nzWUrHiSjz+i+8az4N+QcGF988kOqOsUrbFD5OEIp3kxAJ2gfGKVGy5P9FpHlgNT3rgQYUzGuZUtCwng8FNIDrQrVFEbxywEA9RdfFfDRfiOH4qnQue/bbIsiGYwtRhj2I6/yMkDOHWf/asnTQfk+I+aapOgIUx0J0u0dJk1zh3uuwnnqi2WJDJpVuUeEEDyy7+LpQ0//OAep6d0/kY62RRwrOZUQIB8PevL0xvh8XOoB77XFgPBJjo4va6cNqcJeqeNCOSNjMQwg3YI4GLP/5heLdkfUpAu82/XxzauOHktoOXgIuzcJS2e+Bd4JEn0uTCDUYGOjSjh758uyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOVP123MB8542.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:48a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 00:30:27 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 00:30:26 +0000
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
Subject: [PATCH perf-tools-next v3 2/5] perf ftrace: Support filtering return address comments
Date: Sun, 11 Oct 2026 20:30:12 -0400
Message-ID: <20261012003016.263063-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012003016.263063-1-atomlin@atomlin.com>
References: <20261012003016.263063-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0923.namprd03.prod.outlook.com
 (2603:10b6:408:107::28) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOVP123MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d64d7f-35c7-4188-c974-08df27f80314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|10067099003|18002099003|22082099003|3023799007|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	0ZVOPSs72M/7DAPDmv2E+7c41VCSQ1GPPIEPdgwzgITJlb7RKx4ytf5+hKvW3JHKIM2l9jTy7siZ8ZXVeKIGiHjMZycJ0Hj4F8/KCJRZ6Te8WxtlOBJug45gh2gHp7+aUMMT2uCWUSI2ee4FOeZ90KJs2mnwbaCwxJZwVNZfSD0yHwuGJl4r+lJ1hdn695cX0tYW4Nuv0tsqdyh9hzAmSRfh4zAzdwIWZB4t4lRh0srYB4h5q8a0yiiwo0xuz1UZ5JH0P0cURej0UoUTqSIP5EYvKamTL7X71uNYVYH1zux5xXQvODm5wQoDeFN8kppoULCqrUSqUqSAbPKOmDQuZAOB30U2YnOtq2mG0lKD6xD+oRB2Q157U3PXS2Zdl/9BXqYf8a+rCV5vAzX2E0ZtgEdy3TF9Ki35slcKn4AxsNe5d9LUdYRlTKPlLQaLkZiuQBkK9i/ZwsPZf/HLfOT9qlBnziwJoc0RHO5zun2SLk/3yF3bj7gfR5/nJCWf0kSuZWUWJuyi9AQ6yLc1YEeh3PeZkXCwzRCb0rr8Yn7GteScrVIJhkxuDh4C2wgSsH3SDIqO8CexUFR6dbt/k8DzQCIMhvuT4nCEB+TpwpJThRNSl4qIa7nYMDlGl6YUdqBpmW0VCN/xQIqy1j6+rlB5vJYSEeX2/Om4pD7B6bMnPYA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gtV0CVVZ3Pr8jBgC+sikohKUBbHnuD7fLbedxkKIzszwitQPMyVu070YqS2z?=
 =?us-ascii?Q?/AVqHK/L9e4tlQDaHi8cYbMxovLiqLGImyptoTm6jlQCBtkWS4oiqMnzKyHJ?=
 =?us-ascii?Q?uFPxjpzNlD1kSQycKyILwqEPM8//5rwmxa7rmQ2I50piVXC7sfwQ5ETC6ZHc?=
 =?us-ascii?Q?1o8/BK3S5ygEUrpgS/T+8HdoKEPDSkegWVsivXymUk93xHivRiABJcR26gcd?=
 =?us-ascii?Q?y5g0JKEOtxx5i/1GQZNQJpAcl/780pMqaZ6vXc3EcKxhvnB13Czk/LsP71ev?=
 =?us-ascii?Q?Q1wBqSIhfSEjGg8i1lr5+TzKa55X5YdF8Dn/fWqXlczHMOomGwCH5QXgz2OM?=
 =?us-ascii?Q?rn0qYA7ih3YIa5EZphUPGOx6trgfmuDwjrtuhTs1cqg3hMz+pL7kTGljA1u0?=
 =?us-ascii?Q?8tsdiYE2v1iuST8PUHI/3KESyPDqbBq1acviGVajGDVuF6FfQDoKBj0apO7T?=
 =?us-ascii?Q?XI30o857Kri0A0eKYxu/gV+d4C701U6l4UFrlIijPfIsz+leZOlmibtFuuQp?=
 =?us-ascii?Q?9rKckwOkqdLxI4NqyT/0xidl7pU7jB4igVaapGtSGH33VQzqH0/YI6MgvJMs?=
 =?us-ascii?Q?GBrihj0spoLmf1SDm1/OS22ztQFM7wd2D1e3o2bH7Z+uFIFGWoBLwzd6t0C6?=
 =?us-ascii?Q?8JQnPiYbHj8Rc4TVB2l+/oag0qL/zK75QXXQnrwXtgBxsjt5KMDXJhvyfM4C?=
 =?us-ascii?Q?TmNK7JV2dMLKvuw0LgBibZb7YbmtldKYFs5BzF3yF6zj8vFEYTeoPZn7wjbf?=
 =?us-ascii?Q?ySqDUYb3xATXb04xDyx/dfBLzZmzWl/LtvT99wJj3wzwApudtTQbcJJDqSh0?=
 =?us-ascii?Q?5SrzZ+7/+krEKQ553h7i/Qr5UBtKkYUV9E3tMg6qDqVVc4p/MpSB+hWj87ag?=
 =?us-ascii?Q?QGjut4qSoBvE+Qa3WYN82R6hft6WkL3BIGfEa2kUboBwmp2Az3/i8O1aGP/L?=
 =?us-ascii?Q?PUJemvcBWl8hXtLBKiUGwzJTDAWnw4gQvoBdQ//LL8/mep4+SN8ubEV+PShR?=
 =?us-ascii?Q?eWGD8UyZk5mF1ba4VonGIdKYkkGHpG35jkodS260XqKAxEBCv66ExsxJhZ9R?=
 =?us-ascii?Q?azCkDOQJTJJr7VO74RrZaEpu0JrkbkyGgmcWX4gok7wX+obRptmezgyksSOR?=
 =?us-ascii?Q?Bns7ogZju5IcA64ev+VD8q5llt0pNUx8J6mgTRShRMPSEmBESlaaetbJova7?=
 =?us-ascii?Q?6reIIjbtP5DIVduotEp7qR1HaVHYWqvDT87W2No87ok/Ih7nrrJCZvli5zUI?=
 =?us-ascii?Q?M985Tqf3sGNIee8ba8snrr2h4hi8+UbtNb00Wz8aoVqoaK4xK2dFDDM3tCFu?=
 =?us-ascii?Q?oGSgianUppL3OmIj9RkhURDm/i4hGCNa8dhyyOY/vjJRzo2xHBG6R+Wk19y/?=
 =?us-ascii?Q?mZ7cWRJmfeg7sVqTGbyB7tK2KrDTa3t0w7HeEVw+F2wCpZGZ5GSaf82Gfrzw?=
 =?us-ascii?Q?BThQchRDeOskH+vep8doMn/vXT93iSh1yLVUT6dA3JBYAkY++jTmUjdP6klR?=
 =?us-ascii?Q?U5znejWTRXikfzi2vw6MtzqgB1aWNRli+BPuyitoFyVDbu9ERhZ487yyfSUK?=
 =?us-ascii?Q?SiqCAiYnEHqVirbAq/8ydnqseyQmwDYCeiacVcos+WuI9bPn13m/EX46/DY5?=
 =?us-ascii?Q?1kZynaO1TsADvBrQTbRDESSbxYyV2kgAGGhXOOOQa52yMItAqriA8uqQqCS2?=
 =?us-ascii?Q?zP6Qdu/YqbqlW67umqvE5GUG1xLP+ciwuKbRgYx3ZcaLyPFZurC66bctcA1r?=
 =?us-ascii?Q?CUlBYXYx2g=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d64d7f-35c7-4188-c974-08df27f80314
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 00:30:26.8688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LAmQeP8u+Bw/EBJPtA47yX0kKKLSmexIOqwY9XAzJSDzp+Mme7iDJA/CZF9ZNap1MJzWaEwe4xc1TZACB4k6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP123MB8542

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

        Implement ftrace_parse_retaddr() and ftrace_filter_retaddr() in
        tools/perf/util/ftrace.c to robustly match return address
        comments across diverse output styles (standard format, return
        values, and bracketed addresses) and strip them in-place with
        memmove(3).

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
 tools/perf/Documentation/perf-ftrace.txt |  5 +-
 tools/perf/builtin-ftrace.c              |  9 +++
 tools/perf/tests/Build                   |  1 +
 tools/perf/tests/builtin-test.c          |  1 +
 tools/perf/tests/ftrace.c                | 80 ++++++++++++++++++++++
 tools/perf/tests/tests.h                 |  1 +
 tools/perf/util/Build                    |  1 +
 tools/perf/util/ftrace.c                 | 87 ++++++++++++++++++++++++
 tools/perf/util/ftrace.h                 |  5 ++
 9 files changed, 189 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/ftrace.c
 create mode 100644 tools/perf/util/ftrace.c

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 3f3808e513fe..3dbb7e8e783e 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -1,5 +1,4 @@
 perf-ftrace(1)
-==============
 
 NAME
 ----
@@ -134,6 +133,10 @@ OPTIONS for 'perf ftrace trace'
 	  - depth=<n>    - Set max depth for function graph tracer to follow.
 	  - tail         - Print function name at the end.
 
+--filter-retaddr::
+	Filter out function return address comments (`/* <-caller+offset */`)
+	from function_graph output.
+
 
 OPTIONS for 'perf ftrace latency'
 ---------------------------------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index d6604be593a3..f3221089a479 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -827,6 +827,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 				break;
 			for (int i = 0; i < n; i++) {
 				if (buf[i] == '\n') {
+					if (ftrace->filter_retaddr)
+						ftrace_filter_retaddr(linebuf.buf);
 					fprintf(stdout, "%s\n", linebuf.buf);
 					strbuf_setlen(&linebuf, 0);
 				} else {
@@ -857,6 +859,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 			break;
 		for (int i = 0; i < n; i++) {
 			if (buf[i] == '\n') {
+				if (ftrace->filter_retaddr)
+					ftrace_filter_retaddr(linebuf.buf);
 				fprintf(stdout, "%s\n", linebuf.buf);
 				strbuf_setlen(&linebuf, 0);
 			} else {
@@ -867,6 +871,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	}
 
 	if (linebuf.len > 0) {
+		if (ftrace->filter_retaddr)
+			ftrace_filter_retaddr(linebuf.buf);
 		fprintf(stdout, "%s\n", linebuf.buf);
 		strbuf_setlen(&linebuf, 0);
 	}
@@ -1827,11 +1833,14 @@ int cmd_ftrace(int argc, const char **argv)
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
 		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>",
+		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,noduration,verbose,thresh=<n>,depth=<n>,tail",
 		     parse_graph_tracer_opts),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
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

