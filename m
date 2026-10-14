Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021122.outbound.protection.outlook.com [52.101.100.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CF752FE39;
	Wed, 14 Oct 2026 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994532; cv=fail; b=mW9JT5xeErGyfWzHnAsb9hIS9WorYv0D4Lm6d5g4RXv+YP8lULtxCjjuEDgzoB6R+Lbs9uF+IAV7diIk94ehjw5fvyrU1fF32oeMPzTDjupucYY1cy1b2M2F1xmsiHfTAY1D9qlcoYUcTszqQ3mHGk6Us37kKtjeZltFxt9q094=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994532; c=relaxed/simple;
	bh=HlpDbubJgQTwKE2CaalWg0XffplKYkuJysRg5KWj7gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I+bSvL7N6mbAPYcdh3t69RS6BkuM43v8qrw/FIzrE3DwM7UaA6B6DCQqCKi2vefIACDET50cch4cwyKKhkvAJUWTHOxL35QCooYvTPSI/8xG3C+VQM8dn/tflzlvC+PWpaeFKahetjA9LJnaXUhPEFBy0MuOZ6qm1sD7EqJHnSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KF4qC/bh2CXOUKM5jMUFkwcylnfObBHCacXm9Ikd1c7Q/tXdrF79XoHBkjRwixgVFWyNUWkJ1FR8F23CIFKhkKgVSBXlf8S3GYZtlKwz1onPUl8lCUo9qieCl7sTidSV9jfBdBiLunRNF66KMr+zh1qTgqqHaiQaFJiUqsDy8/AI31ITgIx0mT4nv36m+k84d1fw3yIkr0tB+G4vZ6iPycmauKMwtiUGCE1KnzQ9DM59QpjCHNvgZg+rAz8ICUQMH+t+CNdi2M6C9aV/N4v2i8UU/uf0QZi6yfTZvg3v4JW6B9eI5d87BYoEzeIJEUr/GiJ87MfIMb4qN6yLTR3kzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=UVAjOwPmTY3zkaxM6kzX26Jcx3BKKUSpg9dQe1RVXSM=;
 b=vxgC7W2jMyoh9e+kqBY0smAboHE+1gMjfdAWDI0AneVbtPKMFPuVaapFNiytY6rerBtidK6LcNySJg4nrraG1+G0mjBbql5Qfso7Iejp1LoZ9ZdyELrqtOH/D5dYdXud2h2RRGpEwpHf96uKK9Cuii+Nd+OzwXU4rAUaPlL1gyWYqfDEg+GufkU9TJXUx6ezvJ7uAR4WSccREdOPOvsUL5d1TgAaNKopo4DuXkoTULpnLntEH4eC6Tme/F8yNHd+8JVkObE5WKyDcZdKYoMPgLLl5TqkSne83VCDn9Wd+JiRG6cQLJ8o4CsRMxEJyM/Xh5Oi/ltX0k06/f2qUfeN4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB3299.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:64::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 16:15:16 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 16:15:16 +0000
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
Subject: [PATCH perf-tools-next v4 4/5] perf ftrace: Support omitting execution duration in function graph tracer
Date: Wed, 14 Oct 2026 12:14:56 -0400
Message-ID: <20261014161457.373253-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014161457.373253-1-atomlin@atomlin.com>
References: <20261014161457.373253-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0048.namprd16.prod.outlook.com
 (2603:10b6:208:234::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB3299:EE_
X-MS-Office365-Filtering-Correlation-Id: 0283a572-f845-4a36-7a84-08df2a0e55ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	O2kiT+8R+VA2aAqrrY3tZNfsuV/U01zLt2Jg/iExmgm3nrHQRTySUaQ3jxgZCLlG2RL0jhGngKqyez5saSkkKXLWljz3cZZeJH518fWj8mJYuml3lM00NNMYA/ezJd3qASajbisurmq9k7z0XxAK32T8QM0uI1+q6LaCaQ5oCXJty/d+iz1WKFhDChmkfc60kw8Bf0Ffeukq5TOW2wpoCN28/x3KoXi1R2vbRv+6SYaUcK8cmqBZdOhVy5/HNyl7FlRzT98B+BpjaRAe2ZKWqyLzA48ijv2lcJOJqvZrNYa8LtulVSgVWKf2t5CudH2WWPsXS2O6my8RqKfFB65H+izk+Zj6x08X9g1HWTfNxOg/+XH5FUWjIOiud5KdKvP2/c43WOYweHQPgLprc6KflSdf6hiHBBCnwSi6p9ufkYABrYz1udb+H7BmbBK47DGN7BLe+Or99fDYcB1fXhACN6eZ2kd/S1keBQZTRZqaVZx7fjK9flgkT7ZXvfJzNim59eOdo+Ij/nf70Wg/KSQcdd7mp2fo32JE4X/Uqf/oGIcvComsHeFMwa84dKM7+GmD8LGDABuq988nvTEtQFRgL09bhaF6meepaMus2Xr7MFG6ndwZhd0NLWhuQMTeSn4HDynWJ/hw0v4WEnjVRK2HV1lsT+460l71PbfEPxoo2+s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0X+yplGm01zIU9MGaOXasOBmBMGTZ7rdNGtpwtTV/TWfmh3dApvRw4Mgyt2f?=
 =?us-ascii?Q?GqL8As/Ft82cHIriNH92qOoINM7wm6k/J/JDqDpb1qWkHpeF1a8HUhofNK0c?=
 =?us-ascii?Q?tLm44icRgrjMD7T06of6Ar/GyBxWjtkMnOyNEQgadjkiRczZ70CRqK5vengM?=
 =?us-ascii?Q?CCxYf2q/Z1U2OTb05It3xZwGVTNqSDbZmi8Wr/p4ZniNdKATjtcdEK8hQOqP?=
 =?us-ascii?Q?WHbGlQg7yqf07gHNKBJeZsjCfPa/e9XMvRhej+5Gr1iSc0pj4W91dPNBPtcj?=
 =?us-ascii?Q?kXe6t7xIJ/zyUN6Jhjlx9nd057Jnx9k6iLyhpj4sa8rDycJizOQcvmyA2fC6?=
 =?us-ascii?Q?qPZntlEk6xhTR+0i6p5IYIltlzc2Vml8xqSYaJS7vSFDWjfXPF9jpar2kUKU?=
 =?us-ascii?Q?euEf3kfEhQU7vIP07TYpZxfo2pEF0igxefCfriT0pfTe2HY/7VOorU7SAQiC?=
 =?us-ascii?Q?NZYusbICel5UEyT+P8fvweicOfuopgDg5uJcE58GF5Luou+D8oAX3oYuxX13?=
 =?us-ascii?Q?AgEErRxSB3C5O/wYA4gY9Z1JEhdHszWHsAFWwd+4+Spmk3OiqCnnvFfWb2pF?=
 =?us-ascii?Q?vTQ2Powf9ZIHqHmFT0vIafj04GKhF29Ey3Q9IaCWcXxe+L19pvjYinwDbTQS?=
 =?us-ascii?Q?A5bKx/DgSDJAjqxZ6Z9UlJ1OAn1NQ/CyqbMhecU4LFkf/r+y5878rFl2DL8X?=
 =?us-ascii?Q?Fxo/SW3ZWhqwGLdM9yjx5DkesdvrQCNJ08oPrjXcHiQb4kO4l98bjoYvj+Pw?=
 =?us-ascii?Q?JCz8NFbrwiLQjNbgxchHD/j3tueFmNl9xz9YgqnYQDrmSvyqiQ5XoWaJy4HS?=
 =?us-ascii?Q?FJnSiSL1RSFGrMw/Qnd3mm408beclObLs5xUfCbydnLXe+pbtZ+wyNKt5z/v?=
 =?us-ascii?Q?WFzdBhrhUGw+JULVEPzHh9dW6fe+V4pxWi8srJAy4OyUC4mrknlnsRoeLyN1?=
 =?us-ascii?Q?km6TlIn9FcRhWKUutycu/ALCEs3OiWSizL6jU8cZDJSqqP4gD/UqFaPebM9F?=
 =?us-ascii?Q?pxjsyLI7LfBXGlzCUoCtUcklUI4whtEzg8mG6wFzFSBT01GGvyPzT+cZ8qXC?=
 =?us-ascii?Q?EQZbAw8MMmoSpWFg1aDdg6gy4P0VwyhIZEN13uhSVsDu1Sg6wH/3T+eJ/agT?=
 =?us-ascii?Q?0vHyaSWeojocWdNIW0hJ6CUDZYOYWeJ0vklgv0MB2oKrrLn4vqNnOIUkeY8w?=
 =?us-ascii?Q?uk+dM5B/VvzJ0P6uHdtC5VqFksK+cTQriYpjZoIKJLQqgqb27n/cp4X30RS9?=
 =?us-ascii?Q?0oIzwvNk/GMAQ73iEEb/ylOq5IUlydMPdPK9TrfEF3OgyUiwjjTopIvTtbIo?=
 =?us-ascii?Q?xqjTgH8l7XqMamA6l0D7kMuRIM5aZ0/X57hVEZx6XANsy8neJqMM8eXCX3S/?=
 =?us-ascii?Q?3/k/e8yb/tqBMkUEckw8G1fdO1GguSFKggMEig+onOvB2I22uYbWLmIyJseI?=
 =?us-ascii?Q?kEOz3fcWLZ6j5wqH8Njn5EAA+BPmDPGMEZKUhVey9EKQRMiivmoj+g2nenoi?=
 =?us-ascii?Q?5nBy4pEeOymZCpyZSAtjF3ud1M4ucmEpSVTM89SpLc4dt2GMEUnuKXU72su9?=
 =?us-ascii?Q?lj6V3uPOTIovjyIFiLjW3zxjbsn/TRooklkQ3Kl0/EAG0jXgxv6QqfqqaRVA?=
 =?us-ascii?Q?iP84QV3MVjZpL6SZ4oLcpdt2gOthoSuzzUUZMztJE8mPlRH6bXpAhhgw6Zwu?=
 =?us-ascii?Q?jYF5UtxQH2bYozpGgqv/x8odrhNE+ocQVT/i1QIQA87iIMvYEwjhCRsARSuv?=
 =?us-ascii?Q?Jg+T8nFMFw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0283a572-f845-4a36-7a84-08df2a0e55ad
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:15:16.6913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7iVQrQgNESwp8m//No+BpJZiD82sKpGatB8Ijc7Huy2EoY/HxZzVUNLqN49Yvw0DasHe2mRBfbiVae1nCGJEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3299

The Linux kernel's function graph tracer displays the execution duration
of completed functions by default via the funcgraph-duration trace
option. Whilst informative, in scenarios where the user is solely
interested in the call graph topology, call flow sequence, or inlined
hierarchy, the duration column can add visual clutter and widen each
trace line.

Introduce support for omitting function duration by exposing the
noduration sub-option under --graph-opts. Consistent with the existing
nosleep-time and noirqs sub-options, it accepts an optional value, so
noduration=0 explicitly retains the duration column; when specified
more than once, the last occurrence takes effect. When enabled, perf
ftrace configures the kernel's tracing instance option
funcgraph-duration to 0, and restores it to 1 upon resetting tracing
options.

Because the profile subcommand fundamentally requires function execution
duration to compute timing statistics and call counts, combining
noduration with perf ftrace profile is rejected with an explicit error.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  1 +
 tools/perf/builtin-ftrace.c              | 34 ++++++++++++-
 tools/perf/tests/ftrace.c                | 64 ++++++++++++++++++++++--
 tools/perf/util/ftrace.c                 | 18 +++++--
 tools/perf/util/ftrace.h                 |  1 +
 5 files changed, 109 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 445c8ccc22d2..a50f3bae86b2 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -129,6 +129,7 @@ OPTIONS for 'perf ftrace trace'
 	  - retaddr      - Show function return address.
 	  - nosleep-time - Measure on-CPU time only for function_graph tracer.
 	  - noirqs       - Ignore functions that happen inside interrupt.
+	  - noduration   - Do not print function duration.
 	  - verbose      - Show process names, PIDs, timestamps, etc.
 	  - thresh=<n>   - Setup trace duration threshold in microseconds.
 	  - depth=<n>    - Set max depth for function graph tracer to follow.
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 2707d3d62bca..1c86e0a711bd 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -299,6 +299,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("func_stack_trace", "0");
 	write_tracing_option_file("sleep-time", "1");
 	write_tracing_option_file("funcgraph-irqs", "1");
+	write_tracing_option_file("funcgraph-duration", "1");
 	write_tracing_option_file("funcgraph-proc", "0");
 	write_tracing_option_file("funcgraph-abstime", "0");
 	write_tracing_option_file("funcgraph-tail", "0");
@@ -598,6 +599,26 @@ static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+/**
+ * set_tracing_funcgraph_duration - Set funcgraph-duration tracing option
+ * @ftrace: Perf ftrace context
+ *
+ * Configure the kernel's funcgraph-duration tracing option based on the
+ * ftrace->graph_noduration flag.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int set_tracing_funcgraph_duration(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->graph_noduration)
+		return 0;
+
+	if (write_tracing_option_file("funcgraph-duration", "0") < 0)
+		return -1;
+
+	return 0;
+}
+
 static int set_tracing_funcgraph_verbose(struct perf_ftrace *ftrace)
 {
 	if (!ftrace->graph_verbose)
@@ -707,6 +728,11 @@ static int set_tracing_options(struct perf_ftrace *ftrace)
 		return -1;
 	}
 
+	if (set_tracing_funcgraph_duration(ftrace) < 0) {
+		pr_err("failed to set tracing option funcgraph-duration\n");
+		return -1;
+	}
+
 	if (set_tracing_funcgraph_verbose(ftrace) < 0) {
 		pr_err("failed to set tracing option funcgraph-proc/funcgraph-abstime\n");
 		return -1;
@@ -1760,6 +1786,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 		{ .name = "retaddr",		.value_ptr = &ftrace->graph_retaddr },
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
+		{ .name = "noduration",		.value_ptr = &ftrace->graph_noduration },
 		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
 		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
 		{ .name = "depth",		.value_ptr = &ftrace->graph_depth },
@@ -1849,7 +1876,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>",
+		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,noduration,verbose,thresh=<n>,depth=<n>,tail",
 		     parse_graph_tracer_opts),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", parse_buffer_size),
@@ -2056,6 +2083,11 @@ int cmd_ftrace(int argc, const char **argv)
 		cmd_func = __cmd_latency;
 		break;
 	case PERF_FTRACE_PROFILE:
+		if (ftrace.graph_noduration) {
+			pr_err("Error: 'noduration' option cannot be used with profile\n");
+			ret = -EINVAL;
+			goto out_delete_filters;
+		}
 		cmd_func = __cmd_profile;
 		break;
 	case PERF_FTRACE_NONE:
diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
index eacdee1dde86..24b5bd4a1e03 100644
--- a/tools/perf/tests/ftrace.c
+++ b/tools/perf/tests/ftrace.c
@@ -97,6 +97,18 @@ static int test_inline_processing(void)
 		" 1234.567890 |   0)   bash-1234    |               |    activate_task() { /* (inline) */";
 	static const char line_verbose_inline_exit[] =
 		" 1234.567890 |   0)   bash-1234    |               |    } /* activate_task (inline) */";
+	static const char line_verbose_nodur_entry[] =
+		" 1234.567890 |   0)   bash-1234    |  wake_up_new_task() {";
+	static const char line_verbose_nodur_enqueue[] =
+		" 1234.567890 |   0)   bash-1234    |    enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */";
+	static const char line_verbose_nodur_exit_enqueue[] =
+		" 1234.567890 |   0)   bash-1234    |    } /* enqueue_task */";
+	static const char line_verbose_nodur_exit_task[] =
+		" 1234.567890 |   0)   bash-1234    |  } /* wake_up_new_task */";
+	static const char line_verbose_nodur_inline_entry[] =
+		" 1234.567890 |   0)   bash-1234    |    activate_task() { /* (inline) */";
+	static const char line_verbose_nodur_inline_exit[] =
+		" 1234.567890 |   0)   bash-1234    |    } /* activate_task (inline) */";
 	struct perf_ftrace ftrace;
 	char *out_buf = NULL;
 	size_t out_len = 0;
@@ -292,6 +304,33 @@ static int test_inline_processing(void)
 		free(out_buf);
 		out_buf = NULL;
 		ftrace.graph_verbose = false;
+
+		/* Test verbose noduration prefix formatting for synthesised inlines */
+		ftrace.graph_verbose = true;
+		ftrace.graph_noduration = true;
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		ftrace_process_fgraph_line(&ftrace, line_verbose_nodur_entry, out);
+		ftrace_process_fgraph_line(&ftrace, line_verbose_nodur_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_verbose_nodur_exit_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_verbose_nodur_exit_task, out);
+
+		fclose(out);
+		ftrace_cpu_states__clear();
+
+		TEST_CHECK("verbose noduration inline entry preserves comm-pid",
+			   strstr(out_buf, line_verbose_nodur_inline_entry) != NULL);
+		TEST_CHECK("verbose noduration inline exit preserves comm-pid",
+			   strstr(out_buf, line_verbose_nodur_inline_exit) != NULL);
+
+		free(out_buf);
+		out_buf = NULL;
+		ftrace.graph_verbose = false;
+		ftrace.graph_noduration = false;
 	}
 
 out_cleanup:
@@ -343,20 +382,36 @@ static int test_column_layouts(void)
 {
 	static const struct {
 		const char *desc;
-				bool verbose;
+		bool noduration;
+		bool verbose;
 		const char *in;
 		const char *expected;
 	} cases[] = {
 		{
-			"default layout", false,
+			"default layout", false, false,
 			" 7)               |  wake_up_new_task() { /* <-kernel_clone+0x160/0x510 */",
 			" 7)               |  wake_up_new_task() {\n",
 		},
 		{
-			"verbose layout", true,
+			"noduration layout", true, false,
+			" 7)   housekeeping_any_cpu(); /* <-ring_buffer_unlock_commit+0x1a0/0x1f0 */",
+			" 7)   housekeeping_any_cpu();\n",
+		},
+		{
+			"verbose layout", false, true,
 			" 1234.567890 |   7)   bash-1234    |               |  wake_up_new_task() { /* <-kernel_clone+0x160/0x510 */",
 			" 1234.567890 |   7)   bash-1234    |               |  wake_up_new_task() {\n",
 		},
+		{
+			"verbose noduration layout", true, true,
+			" 1234.567890 |   7)   bash-1234    |  wake_up_new_task() { /* <-kernel_clone+0x160/0x510 */",
+			" 1234.567890 |   7)   bash-1234    |  wake_up_new_task() {\n",
+		},
+		{
+			"noduration context switch marker", true, false,
+			"   7)  bash-1234    =>  sh-5678",
+			"   7)  bash-1234    =>  sh-5678\n",
+		},
 	};
 	struct perf_ftrace ftrace;
 	char *out_buf = NULL;
@@ -368,7 +423,8 @@ static int test_column_layouts(void)
 		memset(&ftrace, 0, sizeof(ftrace));
 		ftrace.use_inline = true;
 		ftrace.filter_retaddr = true;
-				ftrace.graph_verbose = cases[i].verbose;
+		ftrace.graph_noduration = cases[i].noduration;
+		ftrace.graph_verbose = cases[i].verbose;
 
 		out = open_memstream(&out_buf, &out_len);
 		if (!out)
diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
index 8a7f8f6eead1..0602e2cc1793 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -292,6 +292,9 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
 	memcpy(buf, line, len);
 	buf[len] = '\0';
 
+	if (ftrace->graph_noduration)
+		return;
+
 	if (*pipe_char == '|') {
 		if (ftrace->graph_verbose) {
 			/* In verbose mode, duration starts after the comm-pid '|' */
@@ -326,10 +329,12 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
  *   [ abstime |]  CPU)  [ comm-pid |]  [ duration |]  func
  *
  * The abstime and comm-pid columns are only present with --graph-opts
- * verbose.
+ * verbose, whereas the duration column, and thus its '|' delimiter, is
+ * omitted with --graph-opts noduration.
  *
  * Return: A pointer to the last character of the context columns (the final
- * '|' delimiter). Returns NULL if @line is not a trace record.
+ * '|' delimiter, or the CPU ')' when no delimiter follows it). Returns NULL
+ * if @line is not a trace record (e.g. a header or a context switch marker).
  */
 static const char *find_func_column(const struct perf_ftrace *ftrace,
 				    const char *line, int *cpu)
@@ -357,9 +362,14 @@ static const char *find_func_column(const struct perf_ftrace *ftrace,
 			return NULL;
 	}
 
-	p = strchr(p + 1, '|');
-	if (!p)
+	if (!ftrace->graph_noduration) {
+		p = strchr(p + 1, '|');
+		if (!p)
+			return NULL;
+	} else if (strstr(p, " => ")) {
+		/* Context switch marker: " CPU) comm-pid => comm-pid" */
 		return NULL;
+	}
 
 	*cpu = (int)val;
 	return p;
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 4140902d9de6..d202a09d112f 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -36,6 +36,7 @@ struct perf_ftrace {
 	int			graph_retaddr;
 	int			graph_nosleep_time;
 	int			graph_noirqs;
+	int			graph_noduration;
 	int			graph_verbose;
 	int			graph_thresh;
 	int			graph_tail;
-- 
2.55.0

