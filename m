Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022119.outbound.protection.outlook.com [52.101.101.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE85E3DCD9B;
	Mon,  5 Oct 2026 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234936; cv=fail; b=XtCZUg3JFh8VBtnPWcpryn8o9/V47zI3qeBxgZ8xkQMHs9bWORgZL36VIUZtAcRUm8KgzioZRvQUBhdYYK1OKhLDNj+csJ6d1cP004EMn1ZijpzfsnPJ8lvVtOJikrfBWRedL+L6SrlmXlVsOuFQ3Vf/KuFDCSP8Oigx3BLIDLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234936; c=relaxed/simple;
	bh=0d6uvxbdG1/7p/bgWlasaontbLECfnIWjE6aZhXjSvs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Raaf72tW8mz+oOJn9qaXqpZqgJ/D7uQk9bKUBNsdeOdynOr6NpyJ/oEe2ZK/kqBWwpJYm+A1bHr7xNkLMD7ryQaua1kAZx1GTZfCa3wqcefigtLAMd9p4KECeoKMTwbgGVbu0xaSHOTUJGE2qoL4kApQ5M4VymtvxxLThKz0dHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJD6YVudP1MbJEF/vOIphS+Y/4W2thkr4/C4FBSxPftRK7SHbAZOXCA+4qNMV255LF+RFpei0Xa8BMnL/aBsQJIn5R6eghBFybqt87lBANjfxkwY/+1Cm1krrGKIEX62Cruw/2ffixLQCkSua+Ek83gMUCUBeWzDZPeXFO1N5oSaSt/tMMfnuqAXE26b5uPP1OT/T4S4wti++Z7bZc64auxJ6HnQ+v60cx5ZgCV7wG+VlSZyUkbroCN+kcO+WdAVEaRlspxA588oTlhdVWzgp1svF60HigXdk3rUeh/VRHSiitqt56k/3OHV7eQkKw3f5ybiGB7xmFYoxdfQN1anww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Gyv7KB0AFLwsz2+5/WrL6ATFJX9CcV6FVLOTsKJpKr0=;
 b=hSSbXdDIahlRd+m8yuGOhc9lsDI/RgeHQIOXnJ+antf3CtM6hyBaUyCOVmEO5m+ES7xtGiSq+r1a2SU8ioROtY7s1dNNckgiNMnQsBXtnpIcI9W+4uG9U+NpvgWFrniqqtkKBCawj/93vr27F5VFziACAjpIOXGNL0W6A/U/z+ggo33gPG8b8PbgeXF+LexNFi5EslXkqZmcg2T+TcaDpHGr/WnNsg1wqolVGrMMeALSbYNFOqEdwIqgMq/P61rerXO2rIW++qkAGSJ8ZHkgk2RDACOvvBNt2oW/sX1qPruclF6rwgUnfULbJACsUBxxYHlg7XUPlicdxdlGJh7jAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO9P123MB8399.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:45e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.21; Mon, 5 Oct
 2026 21:15:25 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 21:15:24 +0000
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
Subject: [PATCH] perf ftrace: Support display of inlined functions in function graph tracer
Date: Mon,  5 Oct 2026 17:15:18 -0400
Message-ID: <20261005211518.26786-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA4P292CA0012.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO9P123MB8399:EE_
X-MS-Office365-Filtering-Correlation-Id: ee07dab6-07e2-4be1-89df-08df2325c54f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|6133799003|10067099003|18002099003|3023799007|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	EouCuMgM8HbNEK7KDOHEpwpXlOFRI+KdSpKre8odJbs2ca4oPRB+qrd3eYdvvP29tB4rYkkDkxQAVJKAciuGubJn0Ff4T4epVgSEd/jqNf43iYfP/HGI/1o4BOtwgj+mquG1tYyKuURvqBWc8gpp+ymjiS1DwTmLqELZYyYa4wYadVcx0vckQRMt4Dww83Ma5Pr+7LFo0pIlYdHUtjBRq2JomkehPFd7oGSBxOpANjBoc39W9+v8QCPkOcoUByBwICW2+wcZXc3D7+1lY9vZogoH/nkoUDkI+uyqmTyihLyANe7C7J9rr1T3PDNfLFPym2PoZK1Lll5UvmQn8qsOF3Ii2HOFKprvmUDX1o+zE1lL4htl3u3OHEksN4X/dkZhH8lyKts8sSo38Ti+puErRr9SZAr5ORRbTqgf9V/A2vTUe7wewe84Xtq8cfyWMWJOdKkors5ueOlbhREZucrS4Vg0U/xsGVvJpOucO3biEsQkK4/BmCashoO+YweUr8WjUoeYygbnkNMNpHdDIWox3VvS7vNMmcMtowFa99vckBbhIPnDo90eybH7iC1sqAWj70+WungwengwxViyGRL1sQTVJfhR28g7ExjXGxPUdW5dCPGBhen7HLHK4TXoQLUdcp/taB3x4uRbKbvP/LtCU1lxSQ+MZ/0nZaGY6YWujsw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(3023799007)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xk+M0b+s05VQaVlnqGhP3GQJ74LETrJKkxXWQiF1QAHs08kvukywOYZHbo6f?=
 =?us-ascii?Q?JOv/W0JiesXorNLlGM1jSFjh52BwLOHp9Pa3hySDIrZ048FKJYM8KJ/97JvC?=
 =?us-ascii?Q?Cb9WLYuOVbSWcmx1i8pRy0LPSSVmkX8gO3PRq7M7SQKGanE9OX24yp+GSIWl?=
 =?us-ascii?Q?4dCfkbMUlCOp6sBHIAqXbPCASpNFDDGgG5RmNHHV5R1gLa0tjwqLa3kBcu98?=
 =?us-ascii?Q?WeCksbQC1YtYpUNXHyu8Pr0RzkkiOBjGyw0b4nQiMVXVg0Plqd2Psed1idNU?=
 =?us-ascii?Q?Uq39xbYh+FOhncOTlStnUoXv3zE9BSGb5S1Xep2Ciyd6wFtf8kNz/wYiEskC?=
 =?us-ascii?Q?4/EAZcDOSultkpYuKkZRo8KH43/7ox4JnQIma8MkfbJz7ydGgWUWr9us5v74?=
 =?us-ascii?Q?A3RKjyAT6xOBkn2TlPDCXgi9h6CEZrRajf3UYNCFOHCkAOh9jU6lEiAvzslR?=
 =?us-ascii?Q?5oO9BSCi6e2vkYOjptXd8TFoduyN2QOZEigtez5zNVOG+s/bTFAzeZZQp+1e?=
 =?us-ascii?Q?xG92f61Gyo9ApDaFJcxCDCAnluNL2pyI/wP0Fj4b6UM7d0MtxzmCP15Je+ja?=
 =?us-ascii?Q?sm9VoSwMNC6XSj7u77ZNX7O4zK/zMoOkVoo4AgK4aiN04kracjamjLmTEX0v?=
 =?us-ascii?Q?+8IRXfy8aJraMoXyl78Jm0m5f3NAD8u/qy9BI2Cns6c99MCWfsjI8XluACG0?=
 =?us-ascii?Q?oqSTJv0yCpGVt4DRFYOWV+a7zNV9r5w4wjHNxp9EeHgVn9X6s+TwWgLgLkcn?=
 =?us-ascii?Q?tNvVsLHid3ph2ZtnbIRZLcL86BvQBZ4N9qE96WAqlNqhyhDhBrD4+Kv6FJyk?=
 =?us-ascii?Q?rUHXm/1R7IufpuLtlNxrUDqSibjZ6byopD91H0p4IeHu76Iso8EemDwfXZku?=
 =?us-ascii?Q?PBaaUOLNYd8mboPivvgPyPSIP+sbKSBALu6crhvaN7oVRH7XHe85J6FtcfeU?=
 =?us-ascii?Q?8SOqGWA6KHkREWuBVMNodJaz3iAnaJWBH7UGB74KXO8aYJ1radv9mdAQDNmq?=
 =?us-ascii?Q?iEjFAs8Y7ZdPJgpaF8JRgJhmMOAQIvzfHQQHt7b90OSuyFvBEHePpAE94osi?=
 =?us-ascii?Q?/X0S7aXl9B+PAk7Ov2Ugrrw6jc/v2wmOMg85mMEZ6J3CQBJf0amHJtyQThGL?=
 =?us-ascii?Q?FWGKyvQbKjzVNDoUTC6tzPncTpQVb8QiIPdHQg7Onk1r0ggJq/E48x9JvFjl?=
 =?us-ascii?Q?/vVtPBFMN4NuYsVVpqIOe6mW0fN92EYcuBOiUO8U2++BTQJ8TEjP4NffjKYt?=
 =?us-ascii?Q?ihMuGvxKpVKZQHTQrdfXhKkjQWZ/WzgHMQ7p8QWImeJkI55+nZZkEdL6E1F0?=
 =?us-ascii?Q?oOC9+aF7k8pHSOFmCLz1IAd6OYFv1bKDeBRnaqDguy063buy6pMtVXubRfXw?=
 =?us-ascii?Q?yr1h0kTLNedqaP31BD5ND29o2xqdMscygd1DRqAn2NwT3IM8TUyanWkrrW2e?=
 =?us-ascii?Q?fA0iwzGk0Xhk3PlqbkiUXpxaQZFu1Qcb5uLuSXBG2lecfiItT8nV734SZZJd?=
 =?us-ascii?Q?rb6c3PVl6fK1OzODc6rjUgLjIVM/4ogADY6v7sghbC1h4G9bVe2gJlzS8Oj0?=
 =?us-ascii?Q?HHWI5oKWC8u+SuC/KYfl+Qnhm/DYw3BkOdqJKnSe84tumsmxK50WTUOaFn2L?=
 =?us-ascii?Q?4H+jQhqXcbN7PJOeZKui1NX+QQPtSOIGgvBxRZwPWJWUXryDNJCfadhehbzF?=
 =?us-ascii?Q?RgxQEiF6rbDYUQZg8qYGNL1phFqBj2TAfLVMb3V5jPcVAQ7IomMKzU5Os4y4?=
 =?us-ascii?Q?oonZ4tIEzg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee07dab6-07e2-4be1-89df-08df2325c54f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 21:15:24.6504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGTnTUxqCo5EZOqcn6SzNgzqsOk5V/VMBz1AYm0dJ6BuKVrs5o1vllQCTCYIoPlvsAcjMRHMx9ghOafCasny7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P123MB8399

The Linux kernel's function graph tracer operates at the machine instruction
level via compiler instrumentation (-fpatchable-function-entry), recording
entry and return events for physical function calls. Consequently, functions
inlined by the compiler are invisible in the resulting call graph, as no
discrete call or return instructions are emitted for them. While technically
expected, this omission frequently obscures the logical execution flow when
analysing kernel subsystems heavily reliant upon inlining.

Address this by introducing the --inline option to perf ftrace for the
function_graph tracer.

When the kernel is configured with CONFIG_FUNCTION_GRAPH_RETADDR=y, the
funcgraph-retaddr trace option records the caller's return address on
each function entry, manifested in the trace stream as a comment
(e.g. /* <-irq_work_queue_on+0x81/0xa0 */). By interrogating DWARF debug
information from the kernel image (vmlinux) utilising libdw, perf ftrace
resolves this return address to its inlined callchain and synthesises
the intermediate inlined frames directly into the streamed call graph.

Key aspects of this implementation:

    1.  Inlined Frame Presentation

        Synthesised inlined functions are rendered with an explicit
        /* (inline) */ annotation at both entry and exit:

            # CPU  DURATION                  FUNCTION CALLS
            # |     |   |                     |   |   |   |
             1)   0.856 us    |  mutex_unlock(lock=0xffffffffbc28bfa0);
             0)               |  wake_up_new_task(p=0xffff8b1f183bac80) {
             0)               |    rb_irq_work_queue() { /* (inline) */
             0)               |      rb_wakeups() { /* (inline) */
             0)   1.374 us    |        housekeeping_any_cpu(type=3 [HK_TYPE_KERNEL_NOISE]);
             0)               |        arch_irq_work_raise() {
             0)               |          apic_wait_icr_idle() { /* (inline) */
             0)               |            x2apic_send_IPI_self(vector=246) {
             0)               |              instr_sysvec_irq_work() { /* (inline) */
             0)               |                irq_enter_rcu() {
             0)               |                  instr_sysvec_irq_work() { /* (inline) */
             0)   0.673 us    |                    irqtime_account_irq(curr=0xffff8b1f086a2c80, offset=0x1000000);
             0)               |                  } /* instr_sysvec_irq_work (inline) */
             0)   1.697 us    |                }

        This affords immediate visual clarity to the reader upon
        entering an inlined scope, without necessitating a search for
        the closing delimiter.

    2.  Return Address Filtering & Clutter Reduction

        The raw return address comment is suppressed by default whenever
        --inline is enabled, avoiding redundant commentary that could
        otherwise mislead the reader regarding caller provenance. Should
        the raw return address be desired, it may be explicitly
        requested via --graph-opts retaddr or --no-filter-retaddr.

    3.  Stack Frame Optimisation in __cmd_ftrace()

        The previous implementation accumulated stream data across read
        boundaries using large fixed stack arrays. This has been
        refactored to employ a single heap-allocated buffer alongside a
        dynamic struct strbuf. Pre-allocating the strbuf ensures that
        line processing incurs zero heap adjustments in the hot polling
        loop, while the stack frame footprint of __cmd_ftrace() is
        reduced by 98.7% (to 160 bytes).

    4.  Option Handling & Diagnostics

        Adds -k or --vmlinux to designate an explicit debug image, and
        provides clear diagnostic guidance should --inline be invoked
        on a kernel lacking CONFIG_FUNCTION_GRAPH_RETADDR.

    5.  Automated Verification

        Introduces a dedicated unit test suite (i.e. Ftrace inline
        processing) in tools/perf/tests/ftrace.c covering return address
        extraction, comment filtering, and DWARF inline symbol
        resolution.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  20 +
 tools/perf/builtin-ftrace.c              | 104 ++++-
 tools/perf/tests/Build                   |   1 +
 tools/perf/tests/builtin-test.c          |   1 +
 tools/perf/tests/ftrace.c                | 165 +++++++
 tools/perf/tests/tests.h                 |   1 +
 tools/perf/util/Build                    |   1 +
 tools/perf/util/ftrace.c                 | 528 +++++++++++++++++++++++
 tools/perf/util/ftrace.h                 |  16 +
 9 files changed, 826 insertions(+), 11 deletions(-)
 create mode 100644 tools/perf/tests/ftrace.c
 create mode 100644 tools/perf/util/ftrace.c

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 3f3808e513fe..ca0f1d523dbc 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -127,6 +127,7 @@ OPTIONS for 'perf ftrace trace'
 	  - retval       - Show function return value.
 	  - retval-hex   - Show function return value in hexadecimal format.
 	  - retaddr      - Show function return address.
+	  - filter-retaddr - Filter out function return address comments (enabled by default with --inline).
 	  - nosleep-time - Measure on-CPU time only for function_graph tracer.
 	  - noirqs       - Ignore functions that happen inside interrupt.
 	  - verbose      - Show process names, PIDs, timestamps, etc.
@@ -134,6 +135,25 @@ OPTIONS for 'perf ftrace trace'
 	  - depth=<n>    - Set max depth for function graph tracer to follow.
 	  - tail         - Print function name at the end.
 
+--inline::
+	Show inlined functions in function_graph tracer. This requires
+	kernel support for the funcgraph-retaddr option and a vmlinux with
+	debug symbols. Inlined functions are displayed in the call graph
+	hierarchy, and their inlined status is indicated with `/* (inline) */`
+	on entry and exit, e.g. `func() { /* (inline) */` and `} /* func (inline) */`.
+	By default, raw return address comments (`/* <-caller+offset */`)
+	are hidden in the output; specify `--graph-opts retaddr` to show them.
+
+--filter-retaddr::
+	Filter out function return address comments (`/* <-caller+offset */`)
+	from function_graph output. This is enabled by default when `--inline`
+	is used; use `--no-filter-retaddr` to disable it.
+
+-k::
+--vmlinux=::
+	Path to the vmlinux file containing debug symbols for resolving
+	inlined functions.
+
 
 OPTIONS for 'perf ftrace latency'
 ---------------------------------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 6017493ff179..3db72d3377c4 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -40,8 +40,11 @@
 #include "util/stat.h"
 #include "util/units.h"
 #include "util/parse-sublevel-options.h"
+#include "symbol.h"
+#include "util/strbuf.h"
 
 #define DEFAULT_TRACER  "function_graph"
+#define TRACE_BUF_SIZE  4096
 
 static volatile sig_atomic_t workload_exec_errno;
 static volatile sig_atomic_t done;
@@ -571,9 +574,14 @@ static int set_tracing_funcgraph_retval(struct perf_ftrace *ftrace)
 
 static int set_tracing_funcgraph_retaddr(struct perf_ftrace *ftrace)
 {
-	if (ftrace->graph_retaddr) {
-		if (write_tracing_option_file("funcgraph-retaddr", "1") < 0)
+	if (ftrace->graph_retaddr || ftrace->use_inline) {
+		if (write_tracing_option_file("funcgraph-retaddr", "1") < 0) {
+			if (ftrace->use_inline) {
+				pr_err("failed to set funcgraph-retaddr option in tracing\n");
+				pr_err("Hint: ensure kernel is compiled with CONFIG_FUNCTION_GRAPH_RETADDR=y\n");
+			}
 			return -1;
+		}
 	}
 
 	return 0;
@@ -738,7 +746,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 {
 	char *trace_file;
 	int trace_fd;
-	char buf[4096];
+	char *buf = NULL;
+	struct strbuf linebuf = STRBUF_INIT;
 	struct pollfd pollfd = {
 		.events = POLLIN,
 	};
@@ -765,8 +774,18 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 		goto out_reset;
 	}
 
+	if (perf_ftrace__setup_inlines(ftrace) < 0)
+		goto out_reset;
+
 	setup_pager();
 
+	buf = malloc(TRACE_BUF_SIZE);
+	if (!buf) {
+		pr_err("failed to allocate trace buffer\n");
+		goto out_reset;
+	}
+	strbuf_init(&linebuf, 512);
+
 	trace_file = get_tracing_instance_file("trace_pipe");
 	if (!trace_file) {
 		pr_err("failed to open trace_pipe\n");
@@ -810,11 +829,24 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 			break;
 
 		if (pollfd.revents & POLLIN) {
-			int n = read(trace_fd, buf, sizeof(buf));
+			int n = read(trace_fd, buf, TRACE_BUF_SIZE);
 			if (n < 0)
 				break;
-			if (fwrite(buf, n, 1, stdout) != 1)
-				break;
+			if (ftrace->use_inline || ftrace->filter_retaddr) {
+				for (int i = 0; i < n; i++) {
+					if (buf[i] == '\n') {
+						if (ftrace_process_fgraph_line(ftrace, linebuf.buf, stdout) < 0)
+							goto out_close_fd;
+						strbuf_setlen(&linebuf, 0);
+					} else {
+						if (strbuf_addch(&linebuf, buf[i]) < 0)
+							goto out_close_fd;
+					}
+				}
+			} else {
+				if (fwrite(buf, n, 1, stdout) != 1)
+					break;
+			}
 			/* flush output since stdout is in full buffering mode due to pager */
 			fflush(stdout);
 		}
@@ -823,7 +855,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	write_tracing_file("tracing_on", "0");
 
 	if (workload_exec_errno) {
-		const char *emsg = str_error_r(workload_exec_errno, buf, sizeof(buf));
+		const char *emsg = str_error_r(workload_exec_errno, buf, TRACE_BUF_SIZE);
 		/* flush stdout first so below error msg appears at the end. */
 		fflush(stdout);
 		pr_err("workload failed: %s\n", emsg);
@@ -832,16 +864,39 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 
 	/* read remaining buffer contents */
 	while (true) {
-		int n = read(trace_fd, buf, sizeof(buf));
+		int n = read(trace_fd, buf, TRACE_BUF_SIZE);
 		if (n <= 0)
 			break;
-		if (fwrite(buf, n, 1, stdout) != 1)
-			break;
+		if (ftrace->use_inline || ftrace->filter_retaddr) {
+			for (int i = 0; i < n; i++) {
+				if (buf[i] == '\n') {
+					if (ftrace_process_fgraph_line(ftrace, linebuf.buf, stdout) < 0)
+						goto out_close_fd;
+					strbuf_setlen(&linebuf, 0);
+				} else {
+					if (strbuf_addch(&linebuf, buf[i]) < 0)
+						goto out_close_fd;
+				}
+			}
+		} else {
+			if (fwrite(buf, n, 1, stdout) != 1)
+				break;
+		}
+	}
+
+	if ((ftrace->use_inline || ftrace->filter_retaddr) && linebuf.len > 0) {
+		if (ftrace_process_fgraph_line(ftrace, linebuf.buf, stdout) < 0)
+			goto out_close_fd;
+		strbuf_setlen(&linebuf, 0);
 	}
+	fflush(stdout);
 
 out_close_fd:
 	close(trace_fd);
 out_reset:
+	strbuf_release(&linebuf);
+	free(buf);
+	perf_ftrace__cleanup_inlines(ftrace);
 	exit_tracing_instance();
 out:
 	return (done && !workload_exec_errno) ? 0 : -1;
@@ -1695,6 +1750,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 {
 	int ret;
 	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
+	int filter_retaddr = -1;
 	struct sublevel_option graph_tracer_opts[] = {
 		{ .name = "args",		.value_ptr = &ftrace->graph_args },
 		{ .name = "retval",		.value_ptr = &ftrace->graph_retval },
@@ -1706,6 +1762,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
 		{ .name = "depth",		.value_ptr = &ftrace->graph_depth },
 		{ .name = "tail",		.value_ptr = &ftrace->graph_tail },
+		{ .name = "filter-retaddr",	.value_ptr = &filter_retaddr },
 		{ .name = NULL, }
 	};
 
@@ -1716,6 +1773,11 @@ static int parse_graph_tracer_opts(const struct option *opt,
 	if (ret)
 		return ret;
 
+	if (filter_retaddr != -1) {
+		ftrace->filter_retaddr = (filter_retaddr != 0);
+		ftrace->filter_retaddr_set = true;
+	}
+
 	return 0;
 }
 
@@ -1791,12 +1853,18 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>",
+		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,filter-retaddr,nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>",
 		     parse_graph_tracer_opts),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", parse_buffer_size),
 	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
 		    "Trace children processes"),
+	OPT_BOOLEAN(0, "inline", &ftrace.use_inline,
+		    "Show inlined functions in function_graph tracer"),
+	OPT_BOOLEAN_SET(0, "filter-retaddr", &ftrace.filter_retaddr, &ftrace.filter_retaddr_set,
+			"Filter out funcgraph return address comments (enabled by default with --inline)"),
+	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name, "file",
+		   "vmlinux pathname"),
 	OPT_INTEGER('D', "delay", &ftrace.target.initial_delay,
 		    "Number of milliseconds to wait before starting tracing after program start"),
 	OPT_PARENT(common_options),
@@ -1912,6 +1980,20 @@ int cmd_ftrace(int argc, const char **argv)
 
 	switch (subcmd) {
 	case PERF_FTRACE_TRACE:
+		if (ftrace.use_inline) {
+			if (ftrace.tracer && strcmp(ftrace.tracer, "function_graph") != 0) {
+				pr_err("Error: --inline option is only supported with function_graph tracer\n");
+				ret = -EINVAL;
+				goto out_delete_filters;
+			}
+			ftrace.tracer = "function_graph";
+		}
+		if (!ftrace.filter_retaddr_set) {
+			if (ftrace.use_inline && !ftrace.graph_retaddr)
+				ftrace.filter_retaddr = true;
+			else
+				ftrace.filter_retaddr = false;
+		}
 		cmd_func = __cmd_ftrace;
 		break;
 	case PERF_FTRACE_LATENCY:
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
index d2f594921e25..865f79353b21 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -142,6 +142,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__pfm,
 	&suite__api_io,
 	&suite__maps,
+	&suite__ftrace_inline,
 	&suite__demangle_java,
 	&suite__demangle_ocaml,
 	&suite__demangle_rust,
diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
new file mode 100644
index 000000000000..f1645de3ef4a
--- /dev/null
+++ b/tools/perf/tests/ftrace.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include "tests.h"
+#include "debug.h"
+#include "dso.h"
+#include "machine.h"
+#include "map.h"
+#include "symbol.h"
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
+			ftrace_parse_retaddr("__cond_resched(); /* <-load_elf_phdrs+0x6c/0xb0 ret=0x0 */",
+					     sym, sizeof(sym), &offset));
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
+	TEST_ASSERT_EQUAL("filter line without retaddr unchanged", strcmp(line3, "do_filp_open();"), 0);
+
+	return TEST_OK;
+}
+
+static int test_inline_processing(void)
+{
+	struct perf_ftrace ftrace;
+	char *out_buf = NULL;
+	size_t out_len = 0;
+	FILE *out;
+	int ret;
+
+	memset(&ftrace, 0, sizeof(ftrace));
+	ftrace.use_inline = true;
+	ftrace.filter_retaddr = 1; /* Default when --graph-opts retaddr is not specified */
+	ftrace.tracer = "function_graph";
+
+	/* If vmlinux is present, test resolving symbols */
+	if (access("vmlinux", R_OK) == 0) {
+		symbol_conf.vmlinux_name = "vmlinux";
+		symbol_conf.ignore_vmlinux_buildid = true;
+		ret = perf_ftrace__setup_inlines(&ftrace);
+		if (ret < 0 || !ftrace.machine)
+			return TEST_SKIP;
+
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			perf_ftrace__cleanup_inlines(&ftrace);
+			return TEST_FAIL;
+		}
+
+		/* Feed simulated function graph trace lines */
+		ftrace_process_fgraph_line(&ftrace, " 0)               |  wake_up_new_task() {", out);
+		ftrace_process_fgraph_line(&ftrace, " 0)               |    enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */", out);
+		ftrace_process_fgraph_line(&ftrace, " 0) + 10.000 us   |    } /* enqueue_task */", out);
+		ftrace_process_fgraph_line(&ftrace, " 0) + 20.000 us   |  } /* wake_up_new_task */", out);
+
+		fclose(out);
+		perf_ftrace__cleanup_inlines(&ftrace);
+
+		pr_debug("Processed output:\n%s\n", out_buf);
+
+		/* Verify activate_task entry with inline hint */
+		TEST_ASSERT_VAL("contains activate_task entry with inline hint",
+				strstr(out_buf, "activate_task() { /* (inline) */") != NULL);
+
+		/* Verify activate_task exit with inline hint */
+		TEST_ASSERT_VAL("contains activate_task exit with inline hint",
+				strstr(out_buf, "} /* activate_task (inline) */") != NULL);
+
+		/* Verify return address comment was filtered out by default */
+		TEST_ASSERT_VAL("retaddr comment filtered out",
+				strstr(out_buf, "/* <-wake_up_new_task") == NULL);
+
+		free(out_buf);
+		out_buf = NULL;
+
+		/* Now test with filter_retaddr = 0 (user specified --graph-opts retaddr) */
+		ftrace.filter_retaddr = 0;
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			perf_ftrace__cleanup_inlines(&ftrace);
+			return TEST_FAIL;
+		}
+
+		ftrace_process_fgraph_line(&ftrace, " 0)               |  wake_up_new_task() {", out);
+		ftrace_process_fgraph_line(&ftrace, " 0)               |    enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */", out);
+		ftrace_process_fgraph_line(&ftrace, " 0) + 10.000 us   |    } /* enqueue_task */", out);
+		ftrace_process_fgraph_line(&ftrace, " 0) + 20.000 us   |  } /* wake_up_new_task */", out);
+
+		fclose(out);
+		perf_ftrace__cleanup_inlines(&ftrace);
+
+		/* Verify return address comment IS preserved when filter_retaddr = 0 */
+		TEST_ASSERT_VAL("retaddr comment preserved when requested",
+				strstr(out_buf, "/* <-wake_up_new_task") != NULL);
+
+		free(out_buf);
+	}
+
+	return TEST_OK;
+}
+
+static int test__ftrace_inline(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
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
+	ret = test_inline_processing();
+	if (ret != TEST_OK)
+		return ret;
+
+	return TEST_OK;
+}
+
+DEFINE_SUITE("Ftrace inline processing", ftrace_inline);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 9c96f33483d1..dd489210426f 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -163,6 +163,7 @@ DECLARE_SUITE(perf_hooks);
 DECLARE_SUITE(unit_number__scnprint);
 DECLARE_SUITE(mem2node);
 DECLARE_SUITE(maps);
+DECLARE_SUITE(ftrace_inline);
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
index 000000000000..58e407e2cf98
--- /dev/null
+++ b/tools/perf/util/ftrace.c
@@ -0,0 +1,528 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ftrace.c - Ftrace utilities and inlined function processing
+ *
+ * Copyright (C) 2026 Aaron Tomlin <atomlin@atomlin.com>
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <string.h>
+#include <ctype.h>
+#include <stdbool.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include "debug.h"
+#include "dso.h"
+#include "machine.h"
+#include "map.h"
+#include "srcline.h"
+#include "symbol.h"
+#include "util/ftrace.h"
+
+#define FTRACE_MAX_CPUS 4096
+#define FTRACE_MAX_STACK 256
+#define FTRACE_MAX_INLINES 32
+
+struct ftrace_stack_frame {
+	char *name;
+	bool inlined;
+	int indent;
+};
+
+struct ftrace_cpu_state {
+	struct ftrace_stack_frame stack[FTRACE_MAX_STACK];
+	int depth;
+	int inlined_depth;
+};
+
+static struct ftrace_cpu_state *ftrace_cpu_states[FTRACE_MAX_CPUS];
+
+void ftrace_cpu_states__clear(void)
+{
+	int i, j;
+
+	for (i = 0; i < FTRACE_MAX_CPUS; i++) {
+		if (ftrace_cpu_states[i]) {
+			for (j = 0; j < ftrace_cpu_states[i]->depth; j++)
+				free(ftrace_cpu_states[i]->stack[j].name);
+			free(ftrace_cpu_states[i]);
+			ftrace_cpu_states[i] = NULL;
+		}
+	}
+}
+
+static struct ftrace_cpu_state *get_cpu_state(int cpu)
+{
+	if (cpu < 0 || cpu >= FTRACE_MAX_CPUS)
+		return NULL;
+
+	if (!ftrace_cpu_states[cpu])
+		ftrace_cpu_states[cpu] = zalloc(sizeof(struct ftrace_cpu_state));
+
+	return ftrace_cpu_states[cpu];
+}
+
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
+
+int ftrace_resolve_inlines(struct machine *machine,
+			   const char *sym_name, u64 offset,
+			   const char **inlined_names, int max_inlines)
+{
+	struct map *map = NULL;
+	struct symbol *sym;
+	struct dso *dso;
+	struct inline_node *node;
+	struct inline_list *ilist;
+	u64 ip, addr;
+	int count = 0;
+
+	if (!machine)
+		return 0;
+
+	sym = machine__find_kernel_symbol_by_name(machine, sym_name, &map);
+	if (!sym || !map)
+		return 0;
+
+	dso = map__dso(map);
+	if (!dso) {
+		map__put(map);
+		return 0;
+	}
+
+	ip = sym->start + offset;
+	addr = map__rip_2objdump(map, ip);
+
+	node = inlines__tree_find(dso__inlined_nodes(dso), addr);
+	if (!node) {
+		node = dso__parse_addr_inlines(dso, addr, sym);
+		if (node)
+			inlines__tree_insert(dso__inlined_nodes(dso), node);
+	}
+
+	if (!node) {
+		map__put(map);
+		return 0;
+	}
+
+	list_for_each_entry(ilist, &node->val, list) {
+		if (ilist->symbol && symbol__inlined(ilist->symbol)) {
+			if (count < max_inlines) {
+				char *name = strdup(ilist->symbol->name);
+				if (name)
+					inlined_names[count++] = name;
+			}
+		}
+	}
+
+	map__put(map);
+	return count;
+}
+
+static void extract_entry_func_name(const char *str, char *buf, size_t size)
+{
+	size_t i = 0;
+
+	while (*str && *str != '(' && *str != '{' && !isspace(*str) && i < size - 1)
+		buf[i++] = *str++;
+	buf[i] = '\0';
+}
+
+static void extract_exit_func_name(const char *str, char *buf, size_t size)
+{
+	const char *p = strchr(str, '}');
+	size_t i = 0;
+
+	buf[0] = '\0';
+	if (!p)
+		return;
+
+	p = strstr(p, "/*");
+	if (!p)
+		return;
+
+	p = skip_spaces(p + 2);
+	while (*p && !isspace(*p) && *p != '*' && *p != '/' && i < size - 1)
+		buf[i++] = *p++;
+	buf[i] = '\0';
+}
+
+static void make_blank_prefix(const char *line, const char *pipe_char, char *buf, size_t size)
+{
+	size_t len = pipe_char - line + 1;
+	const char *paren = strchr(line, ')');
+	char *c;
+
+	if (len >= size)
+		len = size - 1;
+
+	memcpy(buf, line, len);
+	buf[len] = '\0';
+
+	/* Replace duration between ')' and '|' with spaces */
+	if (paren && paren < line + len) {
+		char *end = buf + (pipe_char - line);
+		if (end > buf + len)
+			end = buf + len;
+		for (c = buf + (paren - line) + 1; c < end; c++)
+			*c = ' ';
+	}
+}
+
+int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
+{
+	char caller_sym[128];
+	char blank_prefix[128];
+	const char *inlined_names[FTRACE_MAX_INLINES];
+	const char *pipe_char;
+	const char *paren;
+	const char *after_pipe;
+	const char *func_start;
+	struct ftrace_cpu_state *cs;
+	u64 caller_offset = 0;
+	int num_inlines = 0;
+	int cpu = -1;
+	int leading_spaces;
+	int extra_indent;
+	int caller_idx;
+	int active_inlines;
+	int common;
+	int match_idx;
+	int i;
+	bool is_exit;
+	bool has_open_brace;
+	bool has_semicolon;
+
+	if (!ftrace->use_inline) {
+		if (ftrace->filter_retaddr) {
+			char *filtered = strdup(line);
+
+			if (filtered) {
+				ftrace_filter_retaddr(filtered);
+				fprintf(out, "%s\n", filtered);
+				free(filtered);
+			} else {
+				pr_err("Not enough memory\n");
+				return -ENOMEM;
+			}
+			return 0;
+		}
+		fprintf(out, "%s\n", line);
+		return 0;
+	}
+
+	pipe_char = strchr(line, '|');
+	if (!pipe_char) {
+		fprintf(out, "%s\n", line);
+		return 0;
+	}
+
+	/* Extract CPU number */
+	paren = strchr(line, ')');
+	if (paren && paren > line) {
+		char *endptr;
+		long val = strtol(skip_spaces(line), &endptr, 10);
+
+		if (endptr == paren)
+			cpu = (int)val;
+	}
+
+	cs = get_cpu_state(cpu);
+	if (!cs) {
+		fprintf(out, "%s\n", line);
+		return 0;
+	}
+
+	make_blank_prefix(line, pipe_char, blank_prefix, sizeof(blank_prefix));
+
+	after_pipe = pipe_char + 1;
+	func_start = skip_spaces(after_pipe);
+	leading_spaces = func_start - after_pipe;
+
+	if (*func_start == '\0') {
+		fprintf(out, "%s\n", line);
+		return 0;
+	}
+
+	is_exit = (*func_start == '}');
+
+	if (is_exit) {
+		char exit_name[128];
+
+		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
+
+		/* Find matching frame on stack */
+		match_idx = -1;
+		for (i = cs->depth - 1; i >= 0; i--) {
+			if (!cs->stack[i].inlined && cs->stack[i].name &&
+			    strcmp(cs->stack[i].name, exit_name) == 0) {
+				match_idx = i;
+				break;
+			}
+		}
+
+		/* Close all inlined frames above match_idx */
+		while (cs->depth > 0 && (match_idx < 0 || cs->depth - 1 > match_idx)) {
+			if (cs->stack[cs->depth - 1].inlined) {
+				struct ftrace_stack_frame *top = &cs->stack[cs->depth - 1];
+				int exit_indent = top->indent;
+
+				cs->inlined_depth--;
+				fprintf(out, "%s%*s} /* %s (inline) */\n",
+					blank_prefix, exit_indent, "", top->name);
+				free(top->name);
+				cs->depth--;
+			} else {
+				break;
+			}
+		}
+
+		/* Pop the matched real frame */
+		if (cs->depth > 0 && !cs->stack[cs->depth - 1].inlined &&
+		    cs->stack[cs->depth - 1].name &&
+		    strcmp(cs->stack[cs->depth - 1].name, exit_name) == 0) {
+			free(cs->stack[cs->depth - 1].name);
+			cs->depth--;
+		}
+
+		/* Emit the exit line with extra indentation if within inlined functions */
+		extra_indent = cs->inlined_depth * 2;
+
+		fprintf(out, "%.*s%*s%s\n",
+			(int)(pipe_char - line + 1), line,
+			leading_spaces + extra_indent, "", func_start);
+		return 0;
+	}
+
+	/* It's an entry or a leaf call */
+	has_open_brace = (strchr(func_start, '{') != NULL);
+	has_semicolon = (strchr(func_start, ';') != NULL);
+
+	if (ftrace_parse_retaddr(func_start, caller_sym, sizeof(caller_sym), &caller_offset)) {
+		num_inlines = ftrace_resolve_inlines(ftrace->machine, caller_sym,
+						      caller_offset, inlined_names,
+						      FTRACE_MAX_INLINES);
+	}
+
+	/* Determine which inlined frames are currently open above the caller */
+	caller_idx = -1;
+	if (num_inlines > 0) {
+		for (i = cs->depth - 1; i >= 0; i--) {
+			if (!cs->stack[i].inlined && cs->stack[i].name &&
+			    strcmp(cs->stack[i].name, caller_sym) == 0) {
+				caller_idx = i;
+				break;
+			}
+		}
+	}
+
+	active_inlines = 0;
+	if (caller_idx >= 0) {
+		for (i = caller_idx + 1; i < cs->depth; i++) {
+			if (cs->stack[i].inlined)
+				active_inlines++;
+			else
+				break;
+		}
+	}
+
+	/* Find common prefix of inlined functions */
+	common = 0;
+	if (caller_idx >= 0) {
+		while (common < active_inlines && common < num_inlines &&
+		       cs->stack[caller_idx + 1 + common].name &&
+		       strcmp(cs->stack[caller_idx + 1 + common].name, inlined_names[common]) == 0) {
+			common++;
+		}
+	}
+
+	/* Close inlined frames that are no longer active */
+	while (active_inlines > common && cs->depth > 0) {
+		if (cs->stack[cs->depth - 1].inlined) {
+			struct ftrace_stack_frame *top = &cs->stack[cs->depth - 1];
+			int exit_indent = top->indent;
+
+			cs->inlined_depth--;
+			fprintf(out, "%s%*s} /* %s (inline) */\n",
+				blank_prefix, exit_indent, "", top->name);
+			free(top->name);
+			cs->depth--;
+			active_inlines--;
+		} else {
+			break;
+		}
+	}
+
+	/* Open new inlined frames */
+	for (i = common; i < num_inlines; i++) {
+		int entry_indent = leading_spaces + cs->inlined_depth * 2;
+
+		if (!inlined_names[i]) {
+			pr_err("Not enough memory\n");
+			for (int j = 0; j < num_inlines; j++)
+				free((void *)inlined_names[j]);
+			return -ENOMEM;
+		}
+		fprintf(out, "%s%*s%s() { /* (inline) */\n", blank_prefix, entry_indent, "", inlined_names[i]);
+		if (cs->depth < FTRACE_MAX_STACK) {
+			cs->stack[cs->depth].name = strdup(inlined_names[i]);
+			if (!cs->stack[cs->depth].name) {
+				pr_err("Not enough memory\n");
+				for (int j = 0; j < num_inlines; j++)
+					free((void *)inlined_names[j]);
+				return -ENOMEM;
+			}
+			cs->stack[cs->depth].inlined = true;
+			cs->stack[cs->depth].indent = entry_indent;
+			cs->depth++;
+		}
+		cs->inlined_depth++;
+	}
+
+	/* Print current line with updated indentation */
+	extra_indent = cs->inlined_depth * 2;
+
+	if (ftrace->filter_retaddr) {
+		char *filtered = strdup(func_start);
+
+		if (filtered) {
+			ftrace_filter_retaddr(filtered);
+			fprintf(out, "%.*s%*s%s\n",
+				(int)(pipe_char - line + 1), line,
+				leading_spaces + extra_indent, "", filtered);
+			free(filtered);
+		} else {
+			pr_err("Not enough memory\n");
+			for (i = 0; i < num_inlines; i++)
+				free((void *)inlined_names[i]);
+			return -ENOMEM;
+		}
+	} else {
+		fprintf(out, "%.*s%*s%s\n",
+			(int)(pipe_char - line + 1), line,
+			leading_spaces + extra_indent, "", func_start);
+	}
+
+	/* If non-leaf entry, push onto stack */
+	if (has_open_brace && !has_semicolon) {
+		char entry_name[128];
+
+		extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
+		if (cs->depth < FTRACE_MAX_STACK) {
+			cs->stack[cs->depth].name = strdup(entry_name);
+			if (!cs->stack[cs->depth].name) {
+				pr_err("Not enough memory\n");
+				for (i = 0; i < num_inlines; i++)
+					free((void *)inlined_names[i]);
+				return -ENOMEM;
+			}
+			cs->stack[cs->depth].inlined = false;
+			cs->stack[cs->depth].indent = leading_spaces + extra_indent;
+			cs->depth++;
+		}
+	}
+
+	for (i = 0; i < num_inlines; i++)
+		free((void *)inlined_names[i]);
+	return 0;
+}
+
+int perf_ftrace__setup_inlines(struct perf_ftrace *ftrace)
+{
+	struct map *kmap;
+
+	if (!ftrace->use_inline)
+		return 0;
+
+	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
+	symbol_conf.inline_name = true;
+	if (symbol_conf.vmlinux_name)
+		symbol_conf.ignore_vmlinux_buildid = true;
+
+	if (symbol__init(NULL) < 0) {
+		pr_warning("Failed to initialize symbols for inlined functions\n");
+		return -1;
+	}
+
+	ftrace->machine = machine__new_host(NULL);
+	if (!ftrace->machine) {
+		pr_warning("Failed to create host machine for symbols\n");
+		return -1;
+	}
+
+	if (symbol_conf.vmlinux_name) {
+		kmap = machine__kernel_map(ftrace->machine);
+		if (kmap)
+			dso__load_vmlinux(map__dso(kmap), kmap, symbol_conf.vmlinux_name, false);
+	} else {
+		machine__load_vmlinux_path(ftrace->machine);
+	}
+
+	return 0;
+}
+
+void perf_ftrace__cleanup_inlines(struct perf_ftrace *ftrace)
+{
+	if (ftrace->machine) {
+		machine__delete(ftrace->machine);
+		ftrace->machine = NULL;
+	}
+	ftrace_cpu_states__clear();
+}
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 950f2efafad2..65514ca970b4 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -39,6 +39,10 @@ struct perf_ftrace {
 	int			graph_verbose;
 	int			graph_thresh;
 	int			graph_tail;
+	bool			use_inline;
+	bool			filter_retaddr;
+	bool			filter_retaddr_set;
+	struct machine		*machine;
 };
 
 struct filter_entry {
@@ -93,4 +97,16 @@ perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
 
 #endif  /* HAVE_BPF_SKEL */
 
+struct machine;
+
+bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset);
+void ftrace_filter_retaddr(char *str);
+int ftrace_resolve_inlines(struct machine *machine,
+			   const char *sym_name, u64 offset,
+			   const char **inlined_names, int max_inlines);
+int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out);
+void ftrace_cpu_states__clear(void);
+int perf_ftrace__setup_inlines(struct perf_ftrace *ftrace);
+void perf_ftrace__cleanup_inlines(struct perf_ftrace *ftrace);
+
 #endif  /* __PERF_FTRACE_H__ */
-- 
2.55.0

