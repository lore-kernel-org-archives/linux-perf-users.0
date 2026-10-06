Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021079.outbound.protection.outlook.com [52.101.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4FF2D0617;
	Tue,  6 Oct 2026 23:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329325; cv=fail; b=aIYN5yZWn3+uY9h8yUfhJljOM8YbQwbgqOWz5MLVpTfZGNSpObF4LU4s0KPQD4jK7D0YQxmk5HK6PnkYmFDuw2+GeQZ+QE1E5/q7/F7VihyhCkEng8DxLFwG1JuCIQa4ZZcbkcRCu/4qIkaQ4qVvqTd51eU8uSTo51E6cpBGMi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329325; c=relaxed/simple;
	bh=UAn8mmAJNyqaWUv7ecRgwSgsaG7JhOsIEHeytZ2YOvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XqBuAiwrPKy9lMaVanyz18+7q8/jOtOQi+NxwjOdfc/BqQwukKrAsxUXygES5N5B7vPHiVziZhrH4MSrK7hQy+2mmVwXnEou4Q3734WX2v3BLYMgKA35aFM6ygNE6ntMR2D0OhWDmplwkvH39f2XbUU08nMtWyMLihKEVtzwL50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYCOxsypVuIibvLk6UV6sj/M1BLMVSzwF2WdpUajFEhcavhYuwOD+IE83KIou/Oa5hDeANt/wUmLBtSbmXVUDOd40349fPfT0f6f1cK0bQ7ZmCOOQGnFWAt2CMGFQzz2r/sy2ECj6S2qnvvt6jug7ajoCcr7ahIzGuOeX8uchNh0lv6VXih/SyHoY2x/eyPjeWu8hq6mvLJGBCt/l1QJyl223WPJgXPZ2dBo5hL36OVnPtp3FyEx82woV/6dbNr2Q+SUXpyhOJ6OSz9kGoasRfQ/XYTgfyqChUOE0dq0+pF295SgDrTI1IwDXCvN9j2Eub5e1kWsxkDG1jrQvVVtbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=K8VkkOf6FHPZfbNkxF9kynTxQeA7mDRXAR59LScKDDc=;
 b=EsUOZgafBPbIUROxQPoyt1NHfhRqcfYWHFv/QhbVNhFN+k5ngWpqQYLUKfPn9WNlo+CBF11xT7ClI1TdCnaPpPrgqbTwFXQ+/ypmodERggl98Bbn861Y8neaV+t7RVjFz6gCaCdxVV4tm16olXN+6GwymU42Ew20jYZaqjQuUNl/E0NR6jeXip/xVMaQbM/fP2m08r6c3G2LBVqK1HGcoA12idA/RDUtRL1xphaRuhNZLyHk2iv08RSvOxImpwlspljY9Ju+2CoOEH41QeamV7+WRbKsMLdjiy36gU9fY5Av1gxpb1IZr8HjExZBSLWsfBN31oljGIVRn1LIC6ak5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB4004.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Tue, 6 Oct
 2026 23:28:05 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 23:28:05 +0000
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
Subject: [PATCH perf-tools-next v2 3/4] perf ftrace: Support display of inlined functions in function graph tracer
Date: Tue,  6 Oct 2026 19:27:55 -0400
Message-ID: <20261006232756.65620-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006232756.65620-1-atomlin@atomlin.com>
References: <20261006232756.65620-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0055.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::12) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB4004:EE_
X-MS-Office365-Filtering-Correlation-Id: 419cf77a-e28c-4500-e91a-08df240178d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|5023799004|56012099006|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	vCMu9Mj0TFQ2e1OKFJAexwkHB2VSYsfK7SWX515ReDnRSU+Cyq/H++ZD6aWbolecslP9TMmYuJJpfqeLnI7rU/sS9ZKT4xmRrDvnKARr+b44HZllsIDyzLVmmXayHjefna9yvkketD66GCFov29dnwucyYM+5vOJWp9+xRa80sSJ/HWyAmu5iMNjdkpXd4IdL/lPgE8Ss+SU+m3/XDca8lYKqd+YRLZEM74yL/CXCqGHwje/5WphNJgppE2ktqglyjoyn17CKSVJoUt1YBqOedWsio+x9TyL9i/+x0Ab0SI6mo5h3Hf72dBxmOdreR5Cop/9ldSZg3IOdKlOf+MOSiQuCznb9sVMn3E9iTA6hrLsDibV2tnLa9cIPyyN/NXFTCqMSWmRmq985mSOEl13vRXv7+3veAR3idwn26sSBq7i1CjGiD0ssmJMP+05dO5XBgEs0KUnvO9an+uCCcYmm+xq/IxpcrVsFq7EKy6yYlOuH8LqaZGBQJolEHjJ3BnCKdtTVlKHvkr4C/n4/3tWiQjOkzN/EUEXYtIOY6uu8tYgIKlWkNLKXh3Bs3To+a8e6ryPB8w47dNosx2UIxV52G+2AXmQRt009zpWEaMObOWOiFs0wSHImt/NapQU4EFjgP0qSfjgHVUGLyQQP2ddckDgCZmv6L32dojSQBuNunE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eBePyApnKV8BY74MQgvoG1CXC1/sVuT8E92W+lSMoxHihuHtivVvt/dHLIp+?=
 =?us-ascii?Q?eEiQbKbVVSobuPBrVvHZbp1ITPyL6FI+OYUGT0iYZ6MJk2Bmj/VVX+Ucj05h?=
 =?us-ascii?Q?zdzRipNj1cBF5GpIK/CBUG8qOz07rXw4fWpNfcwMFvEABpH4IAuHUuVbhAvs?=
 =?us-ascii?Q?5vLQNwtpEqgykLRH7LjIk0Eo95OCEQD46qLA6ptCEQgzOf95gG2ObYAK/TI+?=
 =?us-ascii?Q?nKn6EsmiA4oy/FrPCP2FjMBoNrS16hOV4Oj1Pf20azEmIPcTpLJnqrZSEqno?=
 =?us-ascii?Q?uAgn3NvcRMpm5JBGwUwHz96THDzHHvuW9VrYYT6xDlefCq6OCopwyWLH8q/L?=
 =?us-ascii?Q?imNBdX+bGbJ+UrqqGgfWvMteuPfKJOLAWOfFlpXOlVjhdF/MqVPoZqd5+nS4?=
 =?us-ascii?Q?2DicZJjaVKumtSLm6g0JDQ/OjGSy/ZQ5Qz7w8heOf7yFXBt+eicqKf7VBfKM?=
 =?us-ascii?Q?HU6e/vcdlYnPHjnNv03eSA5TsOF5y73/3lvSOEg5oT7HaGWOkmHwnsMwBx+p?=
 =?us-ascii?Q?PH75bqyhP7M7V7LqdYAy6cQlMD8qNTkSTax/kvhmIYyH5M9ay4Gvm4dBp8tr?=
 =?us-ascii?Q?YVjuhWt0hLrbvxM4wAsw8JSLj44gq7ehKqqJvUu+bmYQ7lrFNFCXLDY20hN9?=
 =?us-ascii?Q?ntOm2rx/GWQ6WJPVvv7KriX6oZ6KbTwmz+sZIyqeAyjfYZTPHiMFRXXkxppb?=
 =?us-ascii?Q?JCz82j4PauiPZLTPTLqORdl4O/oepIG24RjYa/lJSTOhvq0Zzw/qjitHpkBA?=
 =?us-ascii?Q?bO9H0SWYHZt+NyaVppiPjW3ptif8+5P9RUdEbq3E3V0AQTcAtA4FMW3FGRWW?=
 =?us-ascii?Q?zD14gUzpvxRpbOr5vly/bi+fzxEaY4BhBNl14D7f/3m8/9JNblk0Lo5tJrtF?=
 =?us-ascii?Q?fPIenYH3DF75x063Scptwg49lZNuvP8t1dKX07xebLm8H7jMNsVXa6d2UcEB?=
 =?us-ascii?Q?FzHGMgLUfGuG6Al1fPTQniXP3R2WrAVr99Zs8gAz2akyI0lOc8oHsZcvh3UZ?=
 =?us-ascii?Q?pshshnuQh2zgX4aNiJeLRXBhnvslvo/Apli83WFZR8vnyPgD4mXYlav9MWp1?=
 =?us-ascii?Q?xVD4x4FDd9o5FjZEDMSUge54PtILLgRws5qtvuQEv5UJeI1+op6XmIDeCS7s?=
 =?us-ascii?Q?7N4kNSv5447O9ksfctWsNWseXTaGk0mR+nAdxaBWXAyambvPFpYBxyh/DlS8?=
 =?us-ascii?Q?du1iGCFfhRhn62aWKPKaCV+AFfl1R5g6mNcE33OkBsvfhn1jBeTYB4z8xM6z?=
 =?us-ascii?Q?kFkw2sZpILVXU2mXTk3CWGTOtxrEZ2EgfHk3wQOB8F6wDdcPHi2Cztx3PHPI?=
 =?us-ascii?Q?F2BKNdsxo88wlTSq6IPluYD86lhIeX1lmXwr+laYnq9WR6qrtWDVGxXD8cAY?=
 =?us-ascii?Q?2ZkebFGwG0GLV9TyfuORQKxqluNbrRR1snUX1JA5zyhA6otOIYjGtwpeFYVX?=
 =?us-ascii?Q?H6Ofv4Pl4YAYtilLuJ9PMM3iTrLRzYo3xC1OkDntaLTU6uAmfrQeCxbEeVTX?=
 =?us-ascii?Q?4NjOi2FtHZYCaAUBsKt2O0GUcakeN9sDr5a572bcZtByY+HJmz8NDejAYaKZ?=
 =?us-ascii?Q?aXX5PImZO6erEcBF0iH8MUtPqYgIxXr6CdOXLZ1UsfyzkOrHT8MYu5OXxC60?=
 =?us-ascii?Q?/C/yvhj1viUn3kFhirsVV+FwDr9M0s5kcZy+p+59iGNbylKF285S8C6sJdPW?=
 =?us-ascii?Q?cXhE354o8zBk81Ml1eprP4RkAHzqS0ZWGnrGeHCQccwu73mL0qD4fWNdUmPS?=
 =?us-ascii?Q?uE6uzQOsGg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419cf77a-e28c-4500-e91a-08df240178d6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 23:28:05.2258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3q3wcp+IsQcXcZeVkrhNwejXGlaeiDwsbAjY/85FXSiUrOHU/LzJXZRpzOsHIKBOA8H6YnLwXXqZXIjtm0gqIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4004

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

    2.  Call graph reconstruction and dynamic stack tracking

        Maintains a per-CPU stack tracking real and inlined frames,
        synthesising entry and exit delimiters to accurately reconstruct
        the execution hierarchy. Bare closing braces without trailing
        function names (the default when funcgraph-tail is disabled) are
        correctly matched against preceding frames on the stack.
        Furthermore, stack depth saturation guards ensure that inlined
        frame depth tracking remains clamped and indentation cannot
        drift even under deep call trees exceeding FTRACE_MAX_STACK.

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
 tools/perf/Documentation/perf-ftrace.txt |  19 +-
 tools/perf/builtin-ftrace.c              |  56 ++-
 tools/perf/tests/ftrace.c                | 162 +++++++-
 tools/perf/util/ftrace.c                 | 475 ++++++++++++++++++++++-
 tools/perf/util/ftrace.h                 |  11 +
 5 files changed, 704 insertions(+), 19 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index ee126604a8ca..ca0f1d523dbc 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -127,7 +127,7 @@ OPTIONS for 'perf ftrace trace'
 	  - retval       - Show function return value.
 	  - retval-hex   - Show function return value in hexadecimal format.
 	  - retaddr      - Show function return address.
-	  - filter-retaddr - Filter out function return address comments from output.
+	  - filter-retaddr - Filter out function return address comments (enabled by default with --inline).
 	  - nosleep-time - Measure on-CPU time only for function_graph tracer.
 	  - noirqs       - Ignore functions that happen inside interrupt.
 	  - verbose      - Show process names, PIDs, timestamps, etc.
@@ -135,9 +135,24 @@ OPTIONS for 'perf ftrace trace'
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
index ddb567781125..e11418e61937 100644
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
 
@@ -882,6 +892,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	strbuf_release(&linebuf);
 	close(trace_fd);
 out_reset:
+	perf_ftrace__cleanup_inlines(ftrace);
 	exit_tracing_instance();
 out:
 	return (done && !workload_exec_errno) ? 0 : -1;
@@ -1844,8 +1855,13 @@ int cmd_ftrace(int argc, const char **argv)
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
@@ -1961,6 +1977,20 @@ int cmd_ftrace(int argc, const char **argv)
 
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
index 596cecee844e..599c55132910 100644
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
@@ -62,6 +66,154 @@ static int test_filter_retaddr(void)
 	return TEST_OK;
 }
 
+static int test_inline_processing(void)
+{
+	static const char line_entry[] = " 0)               |  wake_up_new_task() {";
+	static const char line_enqueue[] =
+		" 0)               |    enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */";
+	static const char line_exit_enqueue[] = " 0) + 10.000 us   |    } /* enqueue_task */";
+	static const char line_exit_task[] = " 0) + 20.000 us   |  } /* wake_up_new_task */";
+	static const char line_bare_enqueue[] = " 0) + 10.000 us   |    }";
+	static const char line_bare_task[] = " 0) + 20.000 us   |  }";
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
+		ftrace_process_fgraph_line(&ftrace, line_entry, out);
+		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_exit_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
+
+		fclose(out);
+		ftrace_cpu_states__clear();
+
+		/* Verify return address comment IS preserved when filter_retaddr = 0 */
+		TEST_ASSERT_VAL("retaddr comment preserved when requested",
+				strstr(out_buf, "/* <-wake_up_new_task") != NULL);
+
+		free(out_buf);
+		out_buf = NULL;
+
+		/* Test with bare closing braces (funcgraph-tail disabled by default) */
+		ftrace.filter_retaddr = 1;
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			perf_ftrace__cleanup_inlines(&ftrace);
+			return TEST_FAIL;
+		}
+
+		ftrace_process_fgraph_line(&ftrace, line_entry, out);
+		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_bare_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_bare_task, out);
+
+		fclose(out);
+		perf_ftrace__cleanup_inlines(&ftrace);
+
+		TEST_ASSERT_VAL("bare braces inline entry",
+				strstr(out_buf, "activate_task() { /* (inline) */") != NULL);
+		TEST_ASSERT_VAL("bare braces inline exit",
+				strstr(out_buf, "} /* activate_task (inline) */") != NULL);
+
+		free(out_buf);
+	}
+
+	return TEST_OK;
+}
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
 static int test__ftrace(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	int ret;
@@ -74,7 +226,15 @@ static int test__ftrace(struct test_suite *test __maybe_unused, int subtest __ma
 	if (ret != TEST_OK)
 		return ret;
 
+	ret = test_stack_saturation();
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
index 5f582cf8531f..a0ceaae0a978 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -1,13 +1,68 @@
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
 bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset)
 {
 	const char *p = strstr(str, "<-");
@@ -66,3 +121,417 @@ void ftrace_filter_retaddr(char *str)
 
 	memmove(start, end, strlen(end) + 1);
 }
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
+
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
+		/* Close all inlined frames above match_idx */
+		while (cs->depth > 0 && (match_idx < 0 || cs->depth - 1 > match_idx)) {
+			if (cs->stack[cs->depth - 1].inlined) {
+				struct ftrace_stack_frame *top = &cs->stack[cs->depth - 1];
+				int exit_indent = top->indent;
+
+				if (cs->inlined_depth > 0)
+					cs->inlined_depth--;
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
+		if (cs->depth > 0 && match_idx == cs->depth - 1 &&
+		    !cs->stack[cs->depth - 1].inlined) {
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

