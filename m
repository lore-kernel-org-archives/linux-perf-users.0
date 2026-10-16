Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021088.outbound.protection.outlook.com [52.101.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B2136EA8D;
	Fri, 16 Oct 2026 04:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123426; cv=fail; b=eghYiNyAvngt4oCQzcVdZIyxS2AGO3KLkAX3iWAXI3L9Sb0tKRQgtZM0X82NMnVMGdka40VtzlqXtrSuh9In+UalQDzfR4I7/G7aGvSxPB2G1olLtU78uOZ+mrzSEdZK0iIbu3oBdvx0BfOgE3gjX/V72x01uIWyxYWQtnfeyhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123426; c=relaxed/simple;
	bh=RIIHqawolaNGUvszqp7cj3MNR/5T/fumXhW4i+PVsP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XRFtXAeB5rG4Ar/xIL7T7nWNEWhQZY2rvVueSgN46fvY5DW2Vt+eOqaUkdnLnbK7M8+MiapUI6QGyCh8TXHwK5vh2woynyYflNybxHjb9RXk5UoIPNVSeOfsDKGM+X693NGREK7Z2jZzgNhpOjzVztl9UkkPAdGeqGITq1cTJUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJj/oEZHGkADGBz14xF72I7PrrXra961aovQ7AoizDbqnOqh4yGjQsMCBxhktZIi4CV3iU8z1/5OlUsMtyEKiinfrdnSWkcPT10yqjUIsRkflkTBmyPMWYKri9WZbMEW/Ow7H3p62x+Trfmp8JKwY8MVG4+4hvlgKF2viBjiQkVjTtlpcyncjDFNP7liEUfuG+X4LfpgdJRoaC6S8ee/89/O23ziFngRE7or73M6OZCHWRuUsv7yVxaRRXZBEjwjCpVHpPRVdEcSkB5yjAg2K3z/e/X0Gyh4D/aBqKMuW1uJcHEDTP6o1nfbR4xfDRsVjYqM4yjHlCK5UwBBvma/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=gHf97wnQlxIYbL4rG/VL0RbvYYbqi7lWEpp+DEnyX6w=;
 b=vk39fxNTDS3Qx11LZAd9RwiHuMbmMT3pfw5IIU/JM5UMPg3i212RFNyNP5dnb6WA/qyYrrM/iVKTBfR0iTqNtHhicIS+yoFfVxDMKsZHF91cE5qmdPcVWrPT+Ujgtzr0Pppkb/G7/0U4hx6+V2KNpzGrCUoRmhzMQtXHtL+cW5AKJgbRsioO9Prk8kdafl7yup6WpSgTUqiVYvxTBnWANtu5ZSBl3Hvzl6K9LZlXEvaI3O5DReGz0RC/5f2WD3limazMNv8Nt2wjVyoTcB/HBC0F3ZaOGfRieweyN9b9s48nhzBzMHM/dtbLqmklnuAKixIzuJUHaJ2sDWyr+lQoyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOAP123MB8944.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 04:03:39 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 04:03:39 +0000
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
Subject: [PATCH perf-tools-next v6 4/5] perf ftrace: Support omitting execution duration in function graph tracer
Date: Fri, 16 Oct 2026 00:03:09 -0400
Message-ID: <20261016040310.482876-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016040310.482876-1-atomlin@atomlin.com>
References: <20261016040310.482876-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:510:5::31) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOAP123MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f306247-6584-4d39-d1ab-08df2b3a75bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	6gcXbJivNyTR3+eWlvm8y9QVH/ga/fhP9MCBUjN53VFxlqHLfxpTkMqQbDWir6D4IF27lvw4GjKiNJuhosyYwSsp9yGvG0NX9+ZLbblXTxS7N5lCGScjPIGRcCSbI7QNcEzgz1PhMSTw+XjVU+w/LciWysDrkGX5F8K843ntafuephfuh78bU1YOOYsKfJ6DuvznuSodB+QcqkqCm31zaOcAULJ0NBbRYhYppr1KCeSovPF8tquBcunNGWrV6Zno7s0hikHtehYSa3tKyaheo3QPHBVEAUZcZFNJL30pDdQJiQVqyQDcIIwbrU+TlxUXCpTnclM5uPPmQP1YmMTtj12LjTpd+wgW7svO+eq029Ea6AzXw+EvvqcmaJdhBMD151nUTPeFQe4qxix/p2Yknhjts6Qup1ntHlRdggpdJLj85/EcfOugIpGKh8r0wsyZ36UBlymiEiqZo89d+VOu+zq70zBObm5zpsEFie969+JzxusygwPh+tehY5LC4pUt6U+C/Ygu51P4P554PV0crzR6Fn8Eb474QuI2kjIsA/9Zex1spME3VjmdH6VsKghisi7lZDUwSDLvKwUwODVzBabXVq/BcdyPW+gefVC3bAetgGtAdhEqkkTEq0J2ThUBxk/59267OsyPtqvIKFEo/leOBUaf6CnFDKF3lyzCugI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7pXQ5aLqz0L+05+tXioyjrpyrnlh7V8+QZaIcYLGXG0dVapZ/gQRJrQp12dh?=
 =?us-ascii?Q?+oNWJnYWMIMRJCE2m8odpaQCjVbcFUonLXN95CWaXJHfw3vveq+wJuSpVwg7?=
 =?us-ascii?Q?9x9hVBEDk1JSBBIYBbJt3uCWWJOhz4/VyO6GKtD2KQevBeZ+jqPIF8L4u6d1?=
 =?us-ascii?Q?9nBuPLR/VhVpBQIt2GCPNAcXt6Zb925AypH1IC6j3A0QBq77svI6F9m+nfKO?=
 =?us-ascii?Q?mbxD5p7vegh0zA6HaQtfTB0Z1rikVgtaOA6sEJ+2EfF3/eGRmLEBAGm0Guvf?=
 =?us-ascii?Q?Z5Nkrj2nskrVE/l/pybWVJgKR0GaD9+YPh5Ds/krCiXBRwW4boh9HvvZ6Squ?=
 =?us-ascii?Q?qunkuhx1VIbAkSicxF2W7It1PHsP+8YKnPgzWJrefan8axSLQ9AXp2xhUgG5?=
 =?us-ascii?Q?IreCBqX0zTHJ5JQk78djrvROpURU1vWnA1u89PISHwhBC7b07Yn2XteIvrJG?=
 =?us-ascii?Q?P/OlrEAwF+neLpUthRXbkUzEYfK1bDInfe46xOfCctdvevzvSCNgGY+qQsnB?=
 =?us-ascii?Q?YGm34fSEFRQqIJijcuKMvZvBMo/LVsSA7xkPxC7cCoZJZQWr/oPaisYOxVuj?=
 =?us-ascii?Q?LHKHFriGYKuGH3VrXkAk9g3C4wwTCkl6ZlJrme5liMM/kO45lBHxrIrdIOU2?=
 =?us-ascii?Q?2/pD8QNPsRv0HU30hj+yC91LoTukmaz9xFHYIzbl6s2Q5KBAQ0ya41xwplqD?=
 =?us-ascii?Q?h5DH6zzisqkwDURh1lRaVr2MAJjAeO4pNsNjKNKm+8vF+Ca+sAuQd9H2keWb?=
 =?us-ascii?Q?lDwLfn2Q0qcexAkdcwgcmeaWv3DWLvGuwvUKzL/PqLxYLaSXQOWcgZIWjxrj?=
 =?us-ascii?Q?lWwv4Eu/FiP8ASFy4eLCs+nNxnW95nnaO26Ee75Pe8G0q5obyG3z9XMTajTx?=
 =?us-ascii?Q?C3btGFvCjIrbrJ5ZmvbnX9ULK9mNyAubfE5UNHnHQCQrvshFFcR+IncrB4UZ?=
 =?us-ascii?Q?bPpQJ+fuVeu2LlWdzld+bw/sAGcUHY1AKaVXTfJOolzuAnNEyeAiS6J8EvaQ?=
 =?us-ascii?Q?+F9E96Hzyjn2XJbudSnwQ+WZofAlsdvZDqariBvGiy/NMGgij3SnaFhUItZF?=
 =?us-ascii?Q?Nf4Jn1F9en4ifwIXORGUp1HtSQbwJDUC2P4SbL5UEZcE4IP8qLdtsY+Sv7Mg?=
 =?us-ascii?Q?rofuS4gJJuLklXTbKCGjFTkpS/2QXMxrBgNYLhz3Iyp/ePzVez45aJjZlFOW?=
 =?us-ascii?Q?JD1CYfQMwhCRg+ycfUOTdYKmulHfRMymRY1HmoLDc3VVStH/EWjGNqYQ8S76?=
 =?us-ascii?Q?8UisCGQZD/kOluQcSeYsfkeuRjKFWhJwkZVa5nvum/KE8Ja2AvsWDyqPDXx1?=
 =?us-ascii?Q?zPLrezixxn277hLEW6vQm6QjXXI26T36T/SOWm8XPIb2s9SinHmXu9Rs+M3u?=
 =?us-ascii?Q?7CP/nLc57UcHVIQDtHPyADrbXdee96AN/KQNgH/t2fjfkovDSNWi4zq8VLbB?=
 =?us-ascii?Q?GnOkvk8ucboSaFpHGcy7qMbCPa//rdceGoiKIJAfL+HOyJH8D1n3+3+lGmba?=
 =?us-ascii?Q?EYZfcXrNv0VmMqjkxjZFvq0QwLo+Tc8H2cU7neelOAOrtEr+lTHMIp7yI1vG?=
 =?us-ascii?Q?1mhrCVK7VxOuhdhHa7IBzksx+GrDJBOJr3dkVZzGCLxq8RvjwiduudEaOcPu?=
 =?us-ascii?Q?x4L23h5S2HyTD7yPuw8mOkIseMlpAbIuvsM/qiT07Dm3K4ZMqyS1XGXrIXkJ?=
 =?us-ascii?Q?sLp1JKuEpJHNRbQVgqeg3Co6Zi5BQy52PpCXbRLugVfjyJfFYMojmIMM0DRZ?=
 =?us-ascii?Q?cGOnhMtE6Q=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f306247-6584-4d39-d1ab-08df2b3a75bb
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 04:03:39.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PI690tkFLpl34gFwu7Cb9kRZrzX53fEDtEmTp7Oi/daWnCuH6YODIhMcwOgFJu+wgOwjHPOsFjHSfdfA4HQn6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8944

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
index cdacf5af14a6..2309ef88ffdb 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -300,6 +300,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("func_stack_trace", "0");
 	write_tracing_option_file("sleep-time", "1");
 	write_tracing_option_file("funcgraph-irqs", "1");
+	write_tracing_option_file("funcgraph-duration", "1");
 	write_tracing_option_file("funcgraph-proc", "0");
 	write_tracing_option_file("funcgraph-abstime", "0");
 	write_tracing_option_file("funcgraph-tail", "0");
@@ -599,6 +600,26 @@ static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
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
@@ -708,6 +729,11 @@ static int set_tracing_options(struct perf_ftrace *ftrace)
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
@@ -1774,6 +1800,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 		{ .name = "retaddr",		.value_ptr = &ftrace->graph_retaddr },
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
+		{ .name = "noduration",		.value_ptr = &ftrace->graph_noduration },
 		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
 		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
 		{ .name = "depth",		.value_ptr = &ftrace->graph_depth },
@@ -1863,7 +1890,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>",
+		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,noduration,verbose,thresh=<n>,depth=<n>,tail",
 		     parse_graph_tracer_opts),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", parse_buffer_size),
@@ -2070,6 +2097,11 @@ int cmd_ftrace(int argc, const char **argv)
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
index ece7f4b73f44..6a3702e1992a 100644
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
@@ -315,6 +327,33 @@ static int test_inline_processing(void)
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
@@ -384,20 +423,36 @@ static int test_column_layouts(void)
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
@@ -409,7 +464,8 @@ static int test_column_layouts(void)
 		memset(&ftrace, 0, sizeof(ftrace));
 		ftrace.use_inline = true;
 		ftrace.filter_retaddr = true;
-				ftrace.graph_verbose = cases[i].verbose;
+		ftrace.graph_noduration = cases[i].noduration;
+		ftrace.graph_verbose = cases[i].verbose;
 
 		out = open_memstream(&out_buf, &out_len);
 		if (!out)
diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
index 96d612d2f1a1..6cdb87b445ea 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -296,6 +296,9 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
 	memcpy(buf, line, len);
 	buf[len] = '\0';
 
+	if (ftrace->graph_noduration)
+		return;
+
 	if (*pipe_char == '|') {
 		if (ftrace->graph_verbose) {
 			/* In verbose mode, duration starts after the comm-pid '|' */
@@ -334,10 +337,12 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
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
@@ -365,9 +370,14 @@ static const char *find_func_column(const struct perf_ftrace *ftrace,
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

