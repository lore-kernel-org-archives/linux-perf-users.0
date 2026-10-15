Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022118.outbound.protection.outlook.com [52.101.101.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CFC327BF8;
	Thu, 15 Oct 2026 01:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792026738; cv=fail; b=nBJ0bfL4n7wiBKBicFHYWojR/gvISwFGJfKMWSm0G4gt9ZvGftLNRF2BaHjkIVcsdPKWKFtNs75Fth8hkjhsq6e5O7an6Dr6FJxsg/sFa7LFYW1W3q/S/cmXI+c8DuLkKtuYiMS9IFwaHGXfUC7VzHAoTegqFuVpRC64Rop66m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792026738; c=relaxed/simple;
	bh=Wt7iEJRpTmT81qoolYLhOVHmJGnABpTjNsasJfnm8Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WgZcVHKSs1ZbdAZLwCFpcTQikxHsjZmbHG8c2kN66I6dyt7fQas7rL/3bp7Oy0RHphKq6At7ytqQd/Kn1ot0zPp3zK589drB79/nbxxUPz5ZzYURwTbCduu7Rh+0IrYa3a/nqDhP1QzxaQ1TU6OePLHZkVWSJC22ZMipdOc7VaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrp6FuZvUet2hVLsiaA7dM8H1ZClhBTlNHsakV2VAwYyJTz7rAzntOgMWBORbdSWBt3dGvn5KAth3QQ79QRrCIS/956ctg5mRhYpn6twtJFJLmJkpqZDbrcvWw2oHt6v2P/N9cSwb0T+NjRqPiuINJgxmW52yuEtGpIslD9/C5Lxh5aAugX1OcgA+VxEqD4+ZCWx7B84BxkoMAWBN5u9uX6qAbUcbkeCqK8I1Pkcy2GLJI1FVVf8EfBOvicHCksfbKXuS+6DMdgKjBzm7JsQwwX/+/sPOr/u6yWTTnI5AAA3pYGuyYCl4TVVXNeL7b4nUZasnzmM4BL4hxXLXTlzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=M3bvt3vJ+dVB2/OL9QohMa4dbJpoE5xrpBbNBf5jTN0=;
 b=m94KeJiG9FQdKWNom/RDLvtqMj4T2bEKn6DY0W6dO2y13h8xK6Ilfw53qcthWp/rlTc6t7bcIxUN1oqHgYRN86gVFv3epQ8JYsYidZTaxBQi83sSWAORispnBKoIPobBrFcl7HKz/W4gFIsoc49N69n0theK8NUVwEc15jGziyNBdTqR8B+q0Z01/DHBKoP6H6xEF/Nepxqhr39xcFemj+CT8wTjhpniiunGIbuvvj1RosVX4k07Y/k0bkuJzOcMqpcH2x1EQSwnOHCci8Vwe08SLXps+fipeKk4YfVVTp/xyBDCzd23p4xDsyN0XmYX0ArgJJS7RUuoeUIZ90Z9og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB3927.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 01:12:14 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 01:12:14 +0000
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
Subject: [PATCH perf-tools-next v5 4/5] perf ftrace: Support omitting execution duration in function graph tracer
Date: Wed, 14 Oct 2026 21:11:54 -0400
Message-ID: <20261015011155.414667-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015011155.414667-1-atomlin@atomlin.com>
References: <20261015011155.414667-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0499.namprd03.prod.outlook.com
 (2603:10b6:408:130::24) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB3927:EE_
X-MS-Office365-Filtering-Correlation-Id: bd73004b-353d-4e44-76f8-08df2a595926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ZQ8m15qOCe/x9wCUsl3nKqDDJj96QFl0KMjOM/05aR8U5s86yKd5xmPYUU2v4IZgcAoA51yOQJpwWoRdFkh0qWAQ9ofhDOvy10sarQzTmihBYEHcbOdEYwoqp3aEvSkaJ2jiQIIN1/iZEgsP7+I+fiH2aJUsdy2rFA2Ts8j55LNwkW9MQvl+NklgcAKGVN7rJY9JCc3Qre11k1hi+t55lHD1UwoLAD73Yd6BjK4ixoWh9IqjW4wQhCrPpJFfGfRVJzUwJodwCwKMxffVIbWw0zRzaiGTGnDJv1JzR97VYgkwIidG+PjAa3RTX6q6Qy50DGFpgnM0zLxAZhRVFz//f56f98peTiiAK71NNOkhwSeGT/3CZLV/FWQjL9NboeiNj+Hgj2gaVTzF+8veYRQ4RUFhj4EPy4VRG/G/K7nC7sNnkmB80PgA8RzR7Illyz0nu498Hm7VSi3HqTD/jL5whBqYVCNzV74VZPuqxUuHUIxbRBpW21jtCBBW9Zz/qG01lpnEnIb/q1GH9hczW4MRmju+JCueB93L7T+2H/zU0M99EWqdP/Hf78dvJx66Uhqsk+HnL/Ib2wNbIH3hB/ApY9Dukp+Nw1HP45wxN3qmrOQDzpVTpTX3CeXrR0/f1hI1BXUiigzvFGyr0b4War3SmacO5wbbCtZO3XSlRfCBb04=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HLSHmxjJUaPKVERC1JX3lxhMUYbEdZaofLUjMEH/arC12hIhEuHg6w2zSFO3?=
 =?us-ascii?Q?6nAlzOv1xrxGJZN2Y8EElYP+byqybPwYMxZDpxaS9TH6O595CLRKDQisWMM9?=
 =?us-ascii?Q?emF3aZnCQn9X8L9m6FdlE7DZ5lXPz33YOviX/w/7pVhRqTxeeqy0LjZDJXQ3?=
 =?us-ascii?Q?imwdG43cuYjs1fLS4xDbhyKxq7v8s/qLbfuph01wr2cyyWFjEJB6D/5rJz1w?=
 =?us-ascii?Q?yUtvbzT4pnIM55X8qwWtEY/ofTp6hRPokIagn5HrV0pFGmzdOzCqy9od9TI9?=
 =?us-ascii?Q?pNDg8nAE2/1jNji43dC3HSW9SvxuKXIPw/zNiuP0EjxAGFTUnCsrGg6IbZAS?=
 =?us-ascii?Q?5us+syLs2Hrd6QQwovfxhl9gGINqjA3I/SNEfM3Lb9kktW5Mb3Mzif3Bx6q5?=
 =?us-ascii?Q?icTCnjP3Wwr6lftOUrZcj6aGravzYjkEvvT7alzl7/mtc0UwYkyk598jEtb5?=
 =?us-ascii?Q?pBeng3/T2JNpjt8PAJgDkIcMCG4ALTmTFVD1hj8PNAA7U1ZbcI4uKvwMfQUS?=
 =?us-ascii?Q?lQGux1ev146j3Z9QX1X3gJQoUqo2ltMSf556W+zXXvYNjrexTKHoR9PLz+Xj?=
 =?us-ascii?Q?IlhrZ22oY6OLZYA2meEu++33BoqPQQOm2AFC6rpfoz63nTeGnfso1FXjqJs1?=
 =?us-ascii?Q?iVbXKP6QLySlGqw2QhP3YJSb4mksIr4/mhLW3JgCq9W8405eEmzSazRbgb4Y?=
 =?us-ascii?Q?phrAHijuaDRc1l3l+F11nJwutmdHMabwC3fCqajfSwSNZNX+vGqRDRP4kQZW?=
 =?us-ascii?Q?dkTZ8OqyN+qsQjUrhsf80W7yC8XdtxLv2Rbyqrcc3IJ+QZ9z6FULsgH8ENp7?=
 =?us-ascii?Q?H+luRnUQ2i2+nSq5mlSrTLbFbKnlV2tTpoEfmDpMM3p4WvAEjYPY4HlCkVgL?=
 =?us-ascii?Q?PeTx2QVPz6Ab5AUubx7QJfCDAgnw2BhGNdgf9UL+GirHIyVp+EWFQ5QTbA5E?=
 =?us-ascii?Q?TpReB0KvaAQ85gI2NeYxpuTqXwTFjeRpJqek0fhwp6J8DJ+gXkQ+zPbcanyN?=
 =?us-ascii?Q?n0QW4L/wVuPqyundNViHCXsqkPIjeUjoJDCzpEIxSLDPEH2K2NL+5/LkNeiF?=
 =?us-ascii?Q?/viKkv50PsS6bDntrwhW5uj5K/8KtSlkNmIXMO1GcyR/aVIL3qLOLa3DAegd?=
 =?us-ascii?Q?yFzMoIiP+7DpAZh2q1PqFVJv9vGz0ozntrP003ObUAwsYrEnuaftDfXwrbpS?=
 =?us-ascii?Q?he2Il/DlZw50DLQENiO55ggHImbMetfEnk2JRZWDrwmj6VLdz2Gs+OtlQFI5?=
 =?us-ascii?Q?5fSgQ+aEo1yCJbI57cDEEouP1sTVjs3ueVGJQIUPUzookdF8pX+DVFCxxKdm?=
 =?us-ascii?Q?b+SBj8Bk0M+lm0eEhC+nmqOWFrQKawLR+AEvKLtKmkexZ26+VqTAAoUQ1i2R?=
 =?us-ascii?Q?aHvLjiCScTwQqZTeXGnaRDt4EuRfIAHo1IAazgboXZSQC0RRdTb3Gor1RLIs?=
 =?us-ascii?Q?3H4dmMMyQm8eTQCeYAakc67VrapqDMO7jEMmkd36REZ5f96HiQgFqtJY/7Lf?=
 =?us-ascii?Q?jwau+5X3ZHBXTQ6hJFummpYYKdwebkgWvwtkz5rJlWcYA68TfAYkdzuDvgan?=
 =?us-ascii?Q?ynodhN3q/izir/voxIAYEo8Ffd4m3JtTYCfalc5M5tRkgEy43G9RYQNa6krl?=
 =?us-ascii?Q?iPdW/i11u32g4Scndt5Q6/Xovg9QW8eLon/bRbX+L2FWrZm7Vr+m3Ot2OjQ/?=
 =?us-ascii?Q?H7QHdLlYMj7OWBuS+zv3LcZHDLhmqIVwOw/Td0DD4cbxAQIDz+bC86n5v1D0?=
 =?us-ascii?Q?klztFgJ28A=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd73004b-353d-4e44-76f8-08df2a595926
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 01:12:14.7050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVMYXjFqkCeBe5eue4VQXXv92j4HrsXc6YDTDVh4VSfDNadh60vWYDjmik053lsAGshP5LLv4OGsYDL/UUzSLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3927

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
index 018f7e04b739..fb835546e995 100644
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
@@ -1773,6 +1799,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 		{ .name = "retaddr",		.value_ptr = &ftrace->graph_retaddr },
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
+		{ .name = "noduration",		.value_ptr = &ftrace->graph_noduration },
 		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
 		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
 		{ .name = "depth",		.value_ptr = &ftrace->graph_depth },
@@ -1862,7 +1889,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>",
+		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,noduration,verbose,thresh=<n>,depth=<n>,tail",
 		     parse_graph_tracer_opts),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", parse_buffer_size),
@@ -2069,6 +2096,11 @@ int cmd_ftrace(int argc, const char **argv)
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
index 3d0f5748252b..a1262c92ad9f 100644
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
@@ -380,20 +419,36 @@ static int test_column_layouts(void)
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
@@ -405,7 +460,8 @@ static int test_column_layouts(void)
 		memset(&ftrace, 0, sizeof(ftrace));
 		ftrace.use_inline = true;
 		ftrace.filter_retaddr = true;
-				ftrace.graph_verbose = cases[i].verbose;
+		ftrace.graph_noduration = cases[i].noduration;
+		ftrace.graph_verbose = cases[i].verbose;
 
 		out = open_memstream(&out_buf, &out_len);
 		if (!out)
diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
index 09b2fd30a01b..71f00d393349 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -295,6 +295,9 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
 	memcpy(buf, line, len);
 	buf[len] = '\0';
 
+	if (ftrace->graph_noduration)
+		return;
+
 	if (*pipe_char == '|') {
 		if (ftrace->graph_verbose) {
 			/* In verbose mode, duration starts after the comm-pid '|' */
@@ -333,10 +336,12 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
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
@@ -364,9 +369,14 @@ static const char *find_func_column(const struct perf_ftrace *ftrace,
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

