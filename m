Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022098.outbound.protection.outlook.com [52.101.96.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5614A1C84D0;
	Mon, 12 Oct 2026 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791765036; cv=fail; b=Umn2vCrqJx0kM6n8PBYKopwyKajJsJlqjxM6iBkr+NEG8K/saVDEmbHe34NkUnUTkpLWdMTQsUUF3gC4SmBNdvxzKy0o0BTfs19YlL7SkppmGnCvQCZV2xoFGVhyYiIoC9giTBbmf7unXcO3Nryd30HG9eRpx6oP0mPLCWbG1W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791765036; c=relaxed/simple;
	bh=4KoAg6+Kf4Xvu6ezFtcITgBrfeDcB6BHLbwGaeKtpEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dE2JY8T+FJerK3oVWDOXr3oxVBrwzE19zk8/j5G9dPUJueU7zVyFWdyJbGjUqjSlBzEi5PbtmYUbzscDwZQxv0GzVXxoEbzizhVSof9XAabUXxjQOX9aFEj9+QUBu9lQZowWs8fn7V2MxAJq2yZTVFFV/YzsNliNUtOl9Wzt1uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUPAzTT/8ebxIzEqw8l/KxIjwzvPiM4UUqgPcXTaX4bLLszY7tuCa1lm7N7J3wcGEMWvMGrvSALBsHDoLSxf12jGMP9ktf+kbk7OS7UlAX0qMdmd7O9bCo7L4Wqj93OiiluHRCNtaZkzvaAhBADfj2y48tNuUajCDX60HdSqcGUQden1OVN4C0kFExXB3LjBa59+rEoygiJ6P6yLEFLT4E8uoookp2QDkFYgAVCQb9WcACYqd23PGYwY850OGg6qXTGEkuG2bI6W9F1tYMuqsA98QAdwyREeGbBcjwtH93ypiYhJ4NYcKn3gv1xCzUASc+gvLU1QSe4j+mjUuY12OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=AyVTXP//ahEjG+PACayYd5h8IjK2GzHvSbC/SpgiZcY=;
 b=QQvnE5lA7zC7EMRVPgkDeqzK2TgApuw+566TEXxVVdqYFQ2FVZaLO2nJfrSgoDJNh0vgKyEky59XOgag0lYbnZ1jGylCJaJ30QhLfvezzIn7l4Y7mpkNBIPRhhY9SGzdY8gK6tczBzU6BxZ7zWaTHjA3QIwGOJ6ylOu0u+GMGxEv88SQrJQs24Yd1EQwnC/SI41cKC9rFd8d1yKFi1q2RKiCYhNpYkhIQW4iA2ZYyz4Ilquh8j7wvj3Z/bKtmoGzA5iya/lFEyC3c7XTXHogThthHSfj/OCJTyzbZLb50PcC3cZLET51tk6VNs7a0TNuIwQi52/hoz0KuOkD0DqnXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOVP123MB8542.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:48a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 00:30:30 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 00:30:30 +0000
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
Subject: [PATCH perf-tools-next v3 3/5] perf ftrace: Support display of inlined functions in function graph tracer
Date: Sun, 11 Oct 2026 20:30:13 -0400
Message-ID: <20261012003016.263063-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012003016.263063-1-atomlin@atomlin.com>
References: <20261012003016.263063-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0912.namprd03.prod.outlook.com
 (2603:10b6:408:107::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOVP123MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: ba16d209-4fd8-46fa-8e1c-08df27f80569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|10067099003|18002099003|22082099003|3023799007|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	7bDQJFrFkfVs+KpAv7tZ/EMrVGLCpw8mwN7AK06WI+/ysmr7HfHZhZzOkVMg9oLaDQ4OPVQ1rLG0BZKr/gs1BtE1zBfTmH1C18u2a7ysBBOJBaRix44SqOa7okUtvR+Lwy9VcsDNY+vxNZx1npK52+8nyIrKlQBUrZAGFmoVO/fgvEBATXi1OKBh1xHKKjWqgAtnIns8D19EtvS7JJV0UCO0msQjETbF1IuW4Y8G9Ha5laJs4TP8D15N8/uL9luQYo9zHUGhoJ3Xwn2Dk1VLRpf/4/LYdpcsojtW2Sfh+4NYzixTh03IBOcUxRtLr4d+KOjpunoWAuCri7L3sRJK6gTJ9rkInGP62M/9pjkezjx9L0dCAKg7EwkBGxn2pgL1wHIAaC076lXX+cTDnH5oDOr0wSUqETtkvUtnxM3Gi7+KxpcgLJEBMrVI76kePB4RB6W8sYloBKHCqySJcMnwnLGUFL+kr6cUCb3P6R3juyxuWT1lh1oc9E5WgH/9Kps+ILEzpY1PRBXgwlnWihBYvEpaMWPlPFO7OGfXi1T9exMBYn2kRlUrxoybjc4FrplU+vh2dZ4RFxVAoVXo89+kzuZ1GOmsBZAiWBvdM8smJfNZxZtxWPpq6ObgnHtNVMes87AoDyADnjClBvozzd+WooHH7lunBg3lf65D6VLm5lk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O33HqlD2OFA/rpTFsr5wzz2AaQ8JsIkU5ifOl/ksmQ7bS/SKiT6kxSeu9At0?=
 =?us-ascii?Q?IbYoGapf6Uwg8E65wedGLo12dk16cOHIozf6IntdGRUcSUQYnQLL7yd/BjZU?=
 =?us-ascii?Q?NU8EiKwHI5nt18RNFWsavG1Vnq4sJQ7JHyRULEmx3pKjcMcsMg0WEJkNI3kw?=
 =?us-ascii?Q?VhprvfaJguQLXgkxdfMQtbYqt9A1Ga6+yunQ2060eSF37hsBXcO6XqkHqEZ6?=
 =?us-ascii?Q?YJNVsL3GTYYcc90/sYobuKmU+N/w7pW2CuLYnfr0/6cp9z9sxa2jTPyqlni4?=
 =?us-ascii?Q?sLKOnu734Fjn7FHuk0OuS/0bJJ1TLVjyMW+mWSBGEwFX/NRieB8AL3yZMICk?=
 =?us-ascii?Q?hfcI5DXLkKj7KidcVVaRSeyJAeh3S6MGpGIz6OZR/J4XwlPsi1bvGAjDS0Zn?=
 =?us-ascii?Q?Ed+V1aA1llmWFPxO3bPFAcsNkylfbP8RCq1ENSwsmkNMUaoQm5AYDgdN/XX9?=
 =?us-ascii?Q?Eflv6RqcND+wi7I29DW28JoolKa4lsUF6F3KjmvLMX3NJVMesnUeUcsBr7GV?=
 =?us-ascii?Q?7FnGOVtRhOxx7Pi6pmlBya5mkTj9onUnOfhUX45yWEJNJRsbhCEKLtaQJCl6?=
 =?us-ascii?Q?P7epb1H5jUlJeBO2WZauxk/4GyP0ljzBfH7uCq4c/WtsdnJTMIHMKPRxdtoo?=
 =?us-ascii?Q?M9cgAAqW2hEOpk332Tbe4i41LSK1G8MLg0nq7jop4tKzt4KKMyN2QRHNak/v?=
 =?us-ascii?Q?8ohkUXjRaktRUNpC2Gr2MtysOrYFh3rW75bI5ydVW/T90I+XuLkD0anIiUwY?=
 =?us-ascii?Q?CHjlergax0JLxEXJCUOz5/uexn/pGILpMVzR189iBjODpDuneVrpiuDqDZqc?=
 =?us-ascii?Q?9z7oGUZ5pIrHpo3grnYSqTveARc0Ih0perwTmbTfGNmd87PACD/oFRS/IiHd?=
 =?us-ascii?Q?KNa1iVjIK9gs4XZWHiEAHwn9uCDsxoiBSxnhXodZZbDCuTVVSqe2whG3ryGP?=
 =?us-ascii?Q?PF9Xxe0ht9AvfjOx64+Ez9O+wp+IXULtHNbyFBFHr0Q3j0ok3qKIboXHsJHC?=
 =?us-ascii?Q?i7kVAFhXLWvcDrKFTvtQZzLsLUYItQw2i+NHr7l8HMG/cOaxFTC155oNiczh?=
 =?us-ascii?Q?TqN5x8qFoUIGEsWfvcA45G1dAWzwGzwR7kfHIYSvSE1KRSWxct9bAvNNXOF9?=
 =?us-ascii?Q?T76Mmu1oZQduNO4QjDuPytiF57zD6U559zPdeZLkxImUuxoHC1tmXXbJiy2i?=
 =?us-ascii?Q?+j4tw/VgY5ZpikBjghfYMzMozEcKS2eCD25IaRMD5iksAVolzoOQ6KMGUl0L?=
 =?us-ascii?Q?PUsWv6eNjj2F0TT/Du7gwApVvIqlN1V+QZWNDBpp4WNS8ge3Rpgou/kD0/Zl?=
 =?us-ascii?Q?EIxznpQPUiu6D9dPJDpgYT3QjLZLE0SlQ+wbYfADtRyCJApJ6nXGd8ZiIQJW?=
 =?us-ascii?Q?It/AUiGmGfLOiNFzYKYDOAFSFlSj8kX3NFZrv5N041BQjHUkJaev1X+J8ceJ?=
 =?us-ascii?Q?0FG1zzJcyDSSZITN07LQxPLv4CBwo/c01me68P87FTv0hUdxhM5h/elD9l/c?=
 =?us-ascii?Q?HM+7vo0jCTgXgAjEQ8WyjIvflRuRBDbfz+ULJQijkXBFyX1lkf9Vs/gF3RM4?=
 =?us-ascii?Q?xRIhKzCZSzRShqJIAPU09ObQmXqUw65Z4L6zII2zCchD1GY3qC6/vtIv1/R1?=
 =?us-ascii?Q?mYWPpmCQ1rZYW0mDsn6QzK8LTAy7JJGGEpM3jmwpsz7vbHx763dOQgvdW1e6?=
 =?us-ascii?Q?bnNNKpiXYnwW1Crmyq6BF5zN/IaDWbwOk4kHRO9SG9mHwD+X6cVb53z7kS1o?=
 =?us-ascii?Q?+hmmlneGAw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba16d209-4fd8-46fa-8e1c-08df27f80569
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 00:30:30.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZk2C1N5dAZNavRC2JpIOpvRFPBHhuYCLf+p9o1sFV1J1K+CljMkcKiyFrqGeiZTxUQvJExRWVkREtWUqgqF4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP123MB8542

The Linux kernel's function graph tracer operates at the machine
instruction level via compiler instrumentation
(-fpatchable-function-entry), recording entry and return events for
physical function calls. Consequently, functions inlined by the compiler
are invisible in the resulting call graph, as no discrete call or return
instructions are emitted for them. While technically expected, this
omission frequently obscures the logical execution flow when analysing
kernel subsystems heavily reliant upon inlining.

Address this by introducing the --inline option to perf ftrace for the
function_graph tracer.

When the kernel is configured with CONFIG_FUNCTION_GRAPH_RETADDR=y, the
funcgraph-retaddr trace option records the caller's return address on
each function entry, manifested in the trace stream as a comment
(e.g. /* <-irq_work_queue_on+0x81/0xa0 */). By interrogating DWARF debug
information from the kernel image (vmlinux) utilising libdw, perf ftrace
resolves this return address to its inlined callchain and synthesises the
intermediate inlined frames directly into the streamed call graph.

Key aspects of this implementation:

    1.  Inlined frame presentation

        Synthesised inlined functions are rendered with an explicit
        /* (inline) */ annotation at both entry and exit:

            # CPU  DURATION                  FUNCTION CALLS
            # |     |   |                     |   |   |   |
             0)               |  wake_up_new_task() {
             0)               |    activate_task() { /* (inline) */
             0)   1.234 us    |      enqueue_task();
             0)               |    } /* activate_task (inline) */
             0)   2.567 us    |  }

        This affords immediate visual clarity to the reader upon
        entering an inlined scope, without necessitating a search for
        the closing delimiter.

    2.  Call graph reconstruction and dynamic stack tracking

        Maintains a per-CPU stack tracking real and inlined frames,
        synthesising entry and exit delimiters to accurately reconstruct
        the execution hierarchy. Inlined frames are structured strictly
        root-to-leaf and validated against the active stack to prevent
        un-traced callers from attaching orphan inlines. Bare closing
        braces without trailing function names (the default when
        funcgraph-tail is disabled) are correctly matched against
        preceding frames on the stack. Furthermore, stack depth
        saturation guards ensure that inlined frame depth tracking
        remains clamped and indentation cannot drift even under deep
        call trees exceeding FTRACE_MAX_STACK.

    3.  Option handling and diagnostics

        Adds -k or --vmlinux to designate an explicit debug image, and
        provides clear diagnostic guidance should --inline be invoked on
        a kernel lacking CONFIG_FUNCTION_GRAPH_RETADDR. Automatically
        enables return address comment filtering unless explicitly
        requested.

    4.  Automated verification

        Expands the unit test suite in tools/perf/tests/ftrace.c to
        validate DWARF inline symbol resolution, comment filtering
        toggles, bare closing braces handling, and stack saturation
        recovery.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  17 +-
 tools/perf/builtin-ftrace.c              |  56 +-
 tools/perf/tests/ftrace.c                | 303 ++++++++++-
 tools/perf/util/ftrace.c                 | 621 ++++++++++++++++++++++-
 tools/perf/util/ftrace.h                 |  11 +
 5 files changed, 990 insertions(+), 18 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 3dbb7e8e783e..86306caf569b 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -133,9 +133,24 @@ OPTIONS for 'perf ftrace trace'
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
 --filter-retaddr::
 	Filter out function return address comments (`/* <-caller+offset */`)
-	from function_graph output.
+	from function_graph output. This is enabled by default when `--inline`
+	is used; use `--no-filter-retaddr` to disable it.
+
+-k::
+--vmlinux=::
+	Path to the vmlinux file containing debug symbols for resolving
+	inlined functions.
 
 
 OPTIONS for 'perf ftrace latency'
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index f3221089a479..504007064e24 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -574,9 +574,14 @@ static int set_tracing_funcgraph_retval(struct perf_ftrace *ftrace)
 
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
@@ -769,6 +774,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 		goto out_reset;
 	}
 
+	if (perf_ftrace__setup_inlines(ftrace) < 0)
+		goto out_reset;
+
 	setup_pager();
 
 	buf = malloc(TRACE_BUF_SIZE);
@@ -827,9 +835,10 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 				break;
 			for (int i = 0; i < n; i++) {
 				if (buf[i] == '\n') {
-					if (ftrace->filter_retaddr)
-						ftrace_filter_retaddr(linebuf.buf);
-					fprintf(stdout, "%s\n", linebuf.buf);
+					if (ftrace_process_fgraph_line(ftrace,
+								       linebuf.buf,
+								       stdout) < 0)
+						goto out_close_fd;
 					strbuf_setlen(&linebuf, 0);
 				} else {
 					if (strbuf_addch(&linebuf, buf[i]) < 0)
@@ -859,9 +868,10 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 			break;
 		for (int i = 0; i < n; i++) {
 			if (buf[i] == '\n') {
-				if (ftrace->filter_retaddr)
-					ftrace_filter_retaddr(linebuf.buf);
-				fprintf(stdout, "%s\n", linebuf.buf);
+				if (ftrace_process_fgraph_line(ftrace,
+							       linebuf.buf,
+							       stdout) < 0)
+					goto out_close_fd;
 				strbuf_setlen(&linebuf, 0);
 			} else {
 				if (strbuf_addch(&linebuf, buf[i]) < 0)
@@ -871,9 +881,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	}
 
 	if (linebuf.len > 0) {
-		if (ftrace->filter_retaddr)
-			ftrace_filter_retaddr(linebuf.buf);
-		fprintf(stdout, "%s\n", linebuf.buf);
+		if (ftrace_process_fgraph_line(ftrace, linebuf.buf,
+					       stdout) < 0)
+			goto out_close_fd;
 		strbuf_setlen(&linebuf, 0);
 	}
 
@@ -883,6 +893,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	free(buf);
 	strbuf_release(&linebuf);
 out_reset:
+	perf_ftrace__cleanup_inlines(ftrace);
 	exit_tracing_instance();
 out:
 	return (done && !workload_exec_errno) ? 0 : -1;
@@ -1839,8 +1850,13 @@ int cmd_ftrace(int argc, const char **argv)
 		     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", parse_buffer_size),
 	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
 		    "Trace children processes"),
-	OPT_BOOLEAN_SET(0, "filter-retaddr", &ftrace.filter_retaddr, &ftrace.filter_retaddr_set,
-			"Filter out funcgraph return address comments"),
+	OPT_BOOLEAN(0, "inline", &ftrace.use_inline,
+		    "Show inlined functions in function_graph tracer"),
+	OPT_BOOLEAN_SET(0, "filter-retaddr", &ftrace.filter_retaddr,
+			&ftrace.filter_retaddr_set,
+			"Filter out funcgraph return address comments (default with --inline)"),
+	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name, "file",
+		   "vmlinux pathname"),
 	OPT_INTEGER('D', "delay", &ftrace.target.initial_delay,
 		    "Number of milliseconds to wait before starting tracing after program start"),
 	OPT_PARENT(common_options),
@@ -1956,6 +1972,20 @@ int cmd_ftrace(int argc, const char **argv)
 
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
diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
index 596cecee844e..e856bed00700 100644
--- a/tools/perf/tests/ftrace.c
+++ b/tools/perf/tests/ftrace.c
@@ -7,6 +7,10 @@
 #include <unistd.h>
 #include "tests.h"
 #include "debug.h"
+#include "dso.h"
+#include "machine.h"
+#include "map.h"
+#include "symbol.h"
 #include "util/ftrace.h"
 
 static int test_parse_retaddr(void)
@@ -62,6 +66,291 @@ static int test_filter_retaddr(void)
 	return TEST_OK;
 }
 
+#define TEST_CHECK(text, cond)					\
+do {								\
+	if (!(cond)) {						\
+		pr_debug("FAILED %s:%d %s\n", __FILE__, __LINE__, text); \
+		ret = TEST_FAIL;				\
+		goto out_cleanup;				\
+	}							\
+} while (0)
+
+static int test_inline_processing(void)
+{
+	static const char line_entry[] = " 0)               |  wake_up_new_task() {";
+	static const char line_enqueue[] =
+		" 0)               |    enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */";
+	static const char line_exit_enqueue[] = " 0) + 10.000 us   |    } /* enqueue_task */";
+	static const char line_exit_task[] = " 0) + 20.000 us   |  } /* wake_up_new_task */";
+	static const char line_bare_enqueue[] = " 0) + 10.000 us   |    }";
+	static const char line_bare_task[] = " 0) + 20.000 us   |  }";
+	static const char line_unmatched[] = " 0) +  5.000 us   |    } /* unrelated_func */";
+	struct perf_ftrace ftrace;
+	char *out_buf = NULL;
+	size_t out_len = 0;
+	FILE *out;
+	const char *unmatched_pos;
+	const char *inline_exit_pos;
+	int ret = TEST_OK;
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
+		if (ret < 0 || !ftrace.machine) {
+			ret = TEST_SKIP;
+			goto out_cleanup;
+		}
+
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		/* Feed simulated function graph trace lines */
+		ftrace_process_fgraph_line(&ftrace, line_entry, out);
+		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_exit_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
+
+		fclose(out);
+		ftrace_cpu_states__clear();
+
+		pr_debug("Processed output:\n%s\n", out_buf);
+
+		/* Verify activate_task entry with inline hint */
+		TEST_CHECK("contains activate_task entry with inline hint",
+			   strstr(out_buf, "activate_task() { /* (inline) */") != NULL);
+
+		/* Verify activate_task exit with inline hint */
+		TEST_CHECK("contains activate_task exit with inline hint",
+			   strstr(out_buf, "} /* activate_task (inline) */") != NULL);
+
+		/* Verify return address comment was filtered out by default */
+		TEST_CHECK("retaddr comment filtered out",
+			   strstr(out_buf, "/* <-wake_up_new_task") == NULL);
+
+		free(out_buf);
+		out_buf = NULL;
+
+		/* Now test with filter_retaddr = 0 (user specified --graph-opts retaddr) */
+		ftrace.filter_retaddr = 0;
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		ftrace_process_fgraph_line(&ftrace, line_entry, out);
+		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_exit_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
+
+		fclose(out);
+		ftrace_cpu_states__clear();
+
+		/* Verify return address comment IS preserved when filter_retaddr = 0 */
+		TEST_CHECK("retaddr comment preserved when requested",
+			   strstr(out_buf, "/* <-wake_up_new_task") != NULL);
+
+		free(out_buf);
+		out_buf = NULL;
+
+		/* Test with bare closing braces (funcgraph-tail disabled by default) */
+		ftrace.filter_retaddr = 1;
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		ftrace_process_fgraph_line(&ftrace, line_entry, out);
+		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_bare_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_bare_task, out);
+
+		fclose(out);
+
+		TEST_CHECK("bare braces inline entry",
+			   strstr(out_buf, "activate_task() { /* (inline) */") != NULL);
+		TEST_CHECK("bare braces inline exit",
+			   strstr(out_buf, "} /* activate_task (inline) */") != NULL);
+
+		free(out_buf);
+		out_buf = NULL;
+
+		/* Test that unmatched exit events do not pop active inlined frames */
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		ftrace_process_fgraph_line(&ftrace, line_entry, out);
+		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_exit_enqueue, out);
+		/* Unmatched exit event while activate_task is still active */
+		ftrace_process_fgraph_line(&ftrace, line_unmatched, out);
+		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
+
+		fclose(out);
+
+		unmatched_pos = strstr(out_buf, "} /* unrelated_func */");
+		inline_exit_pos = strstr(out_buf, "} /* activate_task (inline) */");
+
+		TEST_CHECK("unmatched exit present", unmatched_pos != NULL);
+		TEST_CHECK("inline exit present", inline_exit_pos != NULL);
+		TEST_CHECK("inline exit not prematurely popped before unmatched exit",
+			   inline_exit_pos > unmatched_pos);
+
+		free(out_buf);
+		out_buf = NULL;
+
+		/* Test recovery when an intermediate real function exit event is dropped */
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		ftrace_process_fgraph_line(&ftrace, line_entry, out);
+		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
+		/* line_exit_enqueue is dropped; outer wake_up_new_task exits directly */
+		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
+
+		fclose(out);
+
+		TEST_CHECK("inline exit synthesized despite dropped callee exit",
+			   strstr(out_buf, "} /* activate_task (inline) */") != NULL);
+
+		free(out_buf);
+		out_buf = NULL;
+
+		/* Test that callers not on active stack do not synthesise inlines */
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		ftrace_process_fgraph_line(&ftrace, line_entry, out);
+		/* housekeeping_any_cpu called by untraced ring_buffer_unlock_commit */
+		ftrace_process_fgraph_line(&ftrace,
+			" 0)               |    housekeeping_any_cpu(); /* <-ring_buffer_unlock_commit+0x1a0/0x1f0 */",
+			out);
+		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
+
+		fclose(out);
+
+		TEST_CHECK("untraced caller inlines not synthesised",
+			   strstr(out_buf, "rb_wakeups") == NULL &&
+			   strstr(out_buf, "rb_irq_work_queue") == NULL);
+	}
+
+out_cleanup:
+	free(out_buf);
+	perf_ftrace__cleanup_inlines(&ftrace);
+	return ret;
+}
+#undef TEST_CHECK
+
+static int test_stack_saturation(void)
+{
+	struct perf_ftrace ftrace;
+	char *out_buf = NULL;
+	size_t out_len = 0;
+	FILE *out;
+	int i;
+
+	memset(&ftrace, 0, sizeof(ftrace));
+	ftrace.use_inline = true;
+	ftrace_cpu_states__clear();
+
+	out = open_memstream(&out_buf, &out_len);
+	if (!out)
+		return TEST_FAIL;
+
+	/* Push more than FTRACE_MAX_STACK (256) frames */
+	for (i = 0; i < 300; i++)
+		ftrace_process_fgraph_line(&ftrace, " 0)               |  sub_func() {", out);
+
+	/* Pop all 300 frames */
+	for (i = 0; i < 300; i++)
+		ftrace_process_fgraph_line(&ftrace, " 0)               |  }", out);
+
+	/* Feed one more function entry - it must have base indentation (no indentation drift) */
+	ftrace_process_fgraph_line(&ftrace, " 0)               |  base_func() {", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	/* Verify base_func starts at standard 2 spaces indentation without drift */
+	TEST_ASSERT_VAL("no indentation drift after stack saturation",
+			strstr(out_buf, "|  base_func() {") != NULL);
+
+	free(out_buf);
+	return TEST_OK;
+}
+
+static int test_column_layouts(void)
+{
+	static const struct {
+		const char *desc;
+				bool verbose;
+		const char *in;
+		const char *expected;
+	} cases[] = {
+		{
+			"default layout", false,
+			" 7)               |  wake_up_new_task() { /* <-kernel_clone+0x160/0x510 */",
+			" 7)               |  wake_up_new_task() {\n",
+		},
+		{
+			"verbose layout", true,
+			" 1234.567890 |   7)   bash-1234    |               |  wake_up_new_task() { /* <-kernel_clone+0x160/0x510 */",
+			" 1234.567890 |   7)   bash-1234    |               |  wake_up_new_task() {\n",
+		},
+	};
+	struct perf_ftrace ftrace;
+	char *out_buf = NULL;
+	size_t out_len = 0;
+	FILE *out;
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		memset(&ftrace, 0, sizeof(ftrace));
+		ftrace.use_inline = true;
+		ftrace.filter_retaddr = true;
+				ftrace.graph_verbose = cases[i].verbose;
+
+		out = open_memstream(&out_buf, &out_len);
+		if (!out)
+			return TEST_FAIL;
+
+		ftrace_process_fgraph_line(&ftrace, cases[i].in, out);
+		fclose(out);
+		ftrace_cpu_states__clear();
+
+		if (strcmp(out_buf, cases[i].expected)) {
+			pr_debug("%s: expected '%s', got '%s'\n",
+				 cases[i].desc, cases[i].expected, out_buf);
+			free(out_buf);
+			return TEST_FAIL;
+		}
+		free(out_buf);
+		out_buf = NULL;
+	}
+
+	return TEST_OK;
+}
+
 static int test__ftrace(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int ret;
@@ -74,7 +363,19 @@ static int test__ftrace(struct test_suite *test __maybe_unused, int subtest __ma
 	if (ret != TEST_OK)
 		return ret;
 
+	ret = test_stack_saturation();
+	if (ret != TEST_OK)
+		return ret;
+
+	ret = test_column_layouts();
+	if (ret != TEST_OK)
+		return ret;
+
+	ret = test_inline_processing();
+	if (ret != TEST_OK)
+		return ret;
+
 	return TEST_OK;
 }
 
-DEFINE_SUITE("Ftrace return address processing", ftrace);
+DEFINE_SUITE("Ftrace inline processing", ftrace);
diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
index 344d36293f5c..8737bb52921e 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -1,13 +1,82 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/compiler.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
+/*
+ * ftrace.c - Ftrace utilities and inlined function processing
+ *
+ * Copyright (C) 2026 Aaron Tomlin <atomlin@atomlin.com>
+ */
 #include <stdio.h>
 #include <stdlib.h>
+#include <errno.h>
 #include <string.h>
 #include <ctype.h>
+#include <stdbool.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include "debug.h"
+#include "dso.h"
+#include "machine.h"
+#include "map.h"
+#include "srcline.h"
+#include "symbol.h"
 #include "util/ftrace.h"
 
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
+/**
+ * ftrace_cpu_states__clear - Free allocated CPU stack states
+ *
+ * Free all memory associated with the per-CPU stack tracking states
+ * used for inlined function resolution, including the strings
+ * allocated for stack frames.
+ */
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
+/**
+ * get_cpu_state - Get or allocate stack state for a given CPU
+ * @cpu: The CPU number
+ *
+ * Return: A pointer to the CPU's stack state, or NULL on error or
+ * out-of-bounds CPU index.
+ */
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
 /**
  * ftrace_parse_retaddr - Parse return address comment from trace line
  * @str: The trace line containing the comment
@@ -85,3 +154,549 @@ void ftrace_filter_retaddr(char *str)
 
 	memmove(start, end, strlen(end) + 1);
 }
+
+/**
+ * ftrace_resolve_inlines - Resolve inlined functions for a return address
+ * @machine: Perf machine context
+ * @sym_name: Name of the caller function
+ * @offset: Instruction offset within the caller function
+ * @inlined_names: Array to store the resolved inline function names
+ * @max_inlines: Maximum number of inline frames to resolve
+ *
+ * Use DWARF debug information from the kernel image to resolve a caller's
+ * return address to its inlined callchain.
+ *
+ * Return: The number of inline functions successfully resolved.
+ */
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
+	list_for_each_entry_reverse(ilist, &node->val, list) {
+		if (ilist->symbol && symbol__inlined(ilist->symbol)) {
+			if (count < max_inlines) {
+				char *name = strdup(ilist->symbol->name);
+
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
+/**
+ * extract_entry_func_name - Extract the function name from an entry record
+ * @str: The trace line's function column string
+ * @buf: Buffer to store the extracted name
+ * @size: Size of the @buf
+ *
+ * Parse the function name out of an entry trace record by stripping away
+ * parentheses or braces.
+ */
+static void extract_entry_func_name(const char *str, char *buf, size_t size)
+{
+	size_t i = 0;
+
+	while (*str && *str != '(' && *str != '{' && !isspace(*str) && i < size - 1)
+		buf[i++] = *str++;
+	buf[i] = '\0';
+}
+
+/**
+ * extract_exit_func_name - Extract the function name from an exit record
+ * @str: The trace line's function column string
+ * @buf: Buffer to store the extracted name
+ * @size: Size of the @buf
+ *
+ * Parse the original function name out of the trailing comment in an
+ * exit trace record.
+ */
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
+/**
+ * make_blank_prefix - Create a blank prefix mirroring a trace record's context
+ * @line: The original trace record
+ * @pipe_char: Pointer to the final delimiter character of the context columns
+ * @buf: Buffer to store the blank prefix
+ * @size: Size of the @buf
+ *
+ * Generate a prefix matching the context columns of @line (e.g. CPU, duration)
+ * but with the duration field replaced by spaces.
+ */
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
+
+		if (end > buf + len)
+			end = buf + len;
+		for (c = buf + (paren - line) + 1; c < end; c++)
+			*c = ' ';
+	}
+}
+
+/**
+ * find_func_column - Locate the function call column in a trace record
+ * @ftrace: Perf ftrace context
+ * @line: The trace record to parse
+ * @cpu: Pointer to store the CPU number
+ *
+ * Locate the context columns that precede the function call column of a
+ * function_graph trace record. Depending on the funcgraph-* options set
+ * up by perf, a record looks like:
+ *
+ *   [ abstime |]  CPU)  [ comm-pid |]  [ duration |]  func
+ *
+ * The abstime and comm-pid columns are only present with --graph-opts
+ * verbose.
+ *
+ * Return: A pointer to the last character of the context columns (the final
+ * '|' delimiter). Returns NULL if @line is not a trace record.
+ */
+static const char *find_func_column(const struct perf_ftrace *ftrace,
+				    const char *line, int *cpu)
+{
+	const char *p = line;
+	char *endptr;
+	long val;
+
+	if (ftrace->graph_verbose) {
+		p = strchr(p, '|');
+		if (!p)
+			return NULL;
+		p++;
+	}
+
+	p = skip_spaces(p);
+	val = strtol(p, &endptr, 10);
+	if (endptr == p || *endptr != ')')
+		return NULL;
+	p = endptr;
+
+	if (ftrace->graph_verbose) {
+		p = strchr(p, '|');
+		if (!p)
+			return NULL;
+	}
+
+	p = strchr(p + 1, '|');
+	if (!p)
+		return NULL;
+
+	*cpu = (int)val;
+	return p;
+}
+
+/**
+ * print_line - Output a trace line verbatim, filtering return addresses if needed
+ * @ftrace: Perf ftrace context
+ * @line: The trace line to output
+ * @out: File stream to output to
+ *
+ * Output @line to @out. If ftrace->filter_retaddr is set, return address
+ * comments are filtered out first.
+ *
+ * Return: 0 on success, or a negative error code (e.g. -ENOMEM) on failure.
+ */
+static int print_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
+{
+	char *filtered;
+
+	if (!ftrace->filter_retaddr) {
+		fprintf(out, "%s\n", line);
+		return 0;
+	}
+
+	filtered = strdup(line);
+	if (!filtered) {
+		pr_err("Not enough memory\n");
+		return -ENOMEM;
+	}
+
+	ftrace_filter_retaddr(filtered);
+	fprintf(out, "%s\n", filtered);
+	free(filtered);
+	return 0;
+}
+
+/**
+ * ftrace_process_fgraph_line - Process and output a function graph trace line
+ * @ftrace: Perf ftrace context
+ * @line: The trace line to process
+ * @out: File stream to output to
+ *
+ * Process a trace line from the function_graph tracer. If --inline is set,
+ * this function parses the return address comment, resolves it to its
+ * inlined callchain, and synthesises intermediate frames into the streamed
+ * call graph.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
+{
+	char caller_sym[128];
+	char blank_prefix[128];
+	const char *inlined_names[FTRACE_MAX_INLINES];
+	const char *pipe_char;
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
+	bool has_retaddr = false;
+
+	if (!ftrace->use_inline)
+		return print_line(ftrace, line, out);
+
+	pipe_char = find_func_column(ftrace, line, &cpu);
+	if (!pipe_char)
+		return print_line(ftrace, line, out);
+
+	cs = get_cpu_state(cpu);
+	if (!cs)
+		return print_line(ftrace, line, out);
+
+	make_blank_prefix(line, pipe_char, blank_prefix, sizeof(blank_prefix));
+
+	after_pipe = pipe_char + 1;
+	func_start = skip_spaces(after_pipe);
+	leading_spaces = func_start - after_pipe;
+
+	if (*func_start == '\0')
+		return print_line(ftrace, line, out);
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
+			if (!cs->stack[i].inlined) {
+				if (exit_name[0] == '\0' ||
+				    (cs->stack[i].name &&
+				     strcmp(cs->stack[i].name, exit_name) == 0)) {
+					match_idx = i;
+					break;
+				}
+			}
+		}
+
+		if (match_idx >= 0) {
+			/* Close all inlined and orphaned frames above match_idx */
+			while (cs->depth > 0 && cs->depth - 1 > match_idx) {
+				struct ftrace_stack_frame *top = &cs->stack[cs->depth - 1];
+
+				if (top->inlined) {
+					int exit_indent = top->indent;
+
+					if (cs->inlined_depth > 0)
+						cs->inlined_depth--;
+					fprintf(out, "%s%*s} /* %s (inline) */\n",
+						blank_prefix, exit_indent, "", top->name);
+				}
+				free(top->name);
+				cs->depth--;
+			}
+
+			/* Pop the matched real frame */
+			if (cs->depth > 0 && match_idx == cs->depth - 1 &&
+			    !cs->stack[cs->depth - 1].inlined) {
+				free(cs->stack[cs->depth - 1].name);
+				cs->depth--;
+			}
+
+			extra_indent = cs->inlined_depth * 2;
+		} else {
+			extra_indent = 0;
+		}
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
+		has_retaddr = true;
+		num_inlines = ftrace_resolve_inlines(ftrace->machine, caller_sym,
+						      caller_offset, inlined_names,
+						      FTRACE_MAX_INLINES);
+	}
+
+	/* Determine which inlined frames are currently open above the caller */
+	caller_idx = -1;
+	if (has_retaddr) {
+		for (i = cs->depth - 1; i >= 0; i--) {
+			if (!cs->stack[i].inlined && cs->stack[i].name &&
+			    strcmp(cs->stack[i].name, caller_sym) == 0) {
+				caller_idx = i;
+				break;
+			}
+		}
+
+		/* If caller is not on the tracked stack, do not synthesise inlines */
+		if (caller_idx < 0) {
+			for (i = 0; i < num_inlines; i++)
+				free((void *)inlined_names[i]);
+			num_inlines = 0;
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
+		       !strcmp(cs->stack[caller_idx + 1 + common].name,
+			       inlined_names[common])) {
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
+			if (cs->inlined_depth > 0)
+				cs->inlined_depth--;
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
+		if (cs->depth >= FTRACE_MAX_STACK)
+			break;
+
+		fprintf(out, "%s%*s%s() { /* (inline) */\n",
+			blank_prefix, entry_indent, "", inlined_names[i]);
+		cs->stack[cs->depth].name = strdup(inlined_names[i]);
+		if (!cs->stack[cs->depth].name) {
+			pr_err("Not enough memory\n");
+			for (int j = 0; j < num_inlines; j++)
+				free((void *)inlined_names[j]);
+			return -ENOMEM;
+		}
+		cs->stack[cs->depth].inlined = true;
+		cs->stack[cs->depth].indent = entry_indent;
+		cs->depth++;
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
+/**
+ * perf_ftrace__setup_inlines - Initialise symbol resolution for inlines
+ * @ftrace: Perf ftrace context
+ *
+ * Initialise symbol tracking and load the kernel image (vmlinux) for
+ * DWARF debug information parsing.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
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
+/**
+ * perf_ftrace__cleanup_inlines - Clean up resources used for inline resolution
+ * @ftrace: Perf ftrace context
+ *
+ * Free the machine context and the CPU stack tracking states.
+ */
+void perf_ftrace__cleanup_inlines(struct perf_ftrace *ftrace)
+{
+	if (ftrace->machine) {
+		machine__delete(ftrace->machine);
+		ftrace->machine = NULL;
+	}
+	ftrace_cpu_states__clear();
+}
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 50216d3fef64..4140902d9de6 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -41,6 +41,8 @@ struct perf_ftrace {
 	int			graph_tail;
 	bool			filter_retaddr;
 	bool			filter_retaddr_set;
+	bool			use_inline;
+	struct machine		*machine;
 };
 
 struct filter_entry {
@@ -95,7 +97,16 @@ perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
 
 #endif  /* HAVE_BPF_SKEL */
 
+struct machine;
+
 bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset);
 void ftrace_filter_retaddr(char *str);
+int ftrace_resolve_inlines(struct machine *machine,
+			   const char *sym_name, u64 offset,
+			   const char **inlined_names, int max_inlines);
+int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out);
+void ftrace_cpu_states__clear(void);
+int perf_ftrace__setup_inlines(struct perf_ftrace *ftrace);
+void perf_ftrace__cleanup_inlines(struct perf_ftrace *ftrace);
 
 #endif  /* __PERF_FTRACE_H__ */
-- 
2.55.0

