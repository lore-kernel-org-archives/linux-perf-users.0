Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022113.outbound.protection.outlook.com [52.101.96.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D3134D397;
	Sun, 18 Oct 2026 02:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792291102; cv=fail; b=C6rbQEu+aKJZBLav9ZuY0GLOo5FJSa0VQ44CU278CLBw7TouxY3vzdKf7CND1qm8GtB6WZ7g3UJT3WqkAKNsSrukYBGYVLcEOLHrn7z2fryQ4Q/dkaRXhMTYYziW/p9NmV4bpzsOOJxn4BJp+ytQ4VfCSvS3il59tKR33Y7yywY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792291102; c=relaxed/simple;
	bh=QKw+GVp0wxfsNy5kv+chT3tWlzehxUZ1g5HGZQHg4pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q7iZLiIgnKtps6VnP/gfD9lZtOrX/ZVoE3S+XMCOSu20O6rqPmMAPuAVP5NchK1iocpZTxIIyEjfKphdMpIcsJgswPxgvKMpX3fJUgYXE3k5/e+Psu7198zExpOYfYhR33bSQNLKkUFZAvUXOK4Wr5CPfNACUQT0SEOvHmU1bQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPaO2C58VZIQiLHVZ81IjTEAnDUU2e7c2zDpZ9MDRidjJJjTF5CnXOfoUyiAIpoGnsgK7IcJqiXDf9ReHnoyiY2ddA0eMB5J5RTUvc6Hs4NjxlgTyfwfQ+uUQ97bNW4MHtK6Rf0f3twC90E+xsYA2g+qvUIPOg2OyF1AsIPWvHdSSiTiVTKW8qSHCqI371UjdP9kwR/PC1hB1EJge03SYQ5GQ3tdrMqT7bEZ/hbhJH+4ZCe+Uf6sU9OC+9VTEKhzu24Zx46N5yhJFMeppWZxT46xMQaRggRHm3u5gyFyYDOOKafvXfB4KI9E9OjsuMmqe6rBPprb0mz2qxY9QeHPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=sKT3VRHBvd3x+7GhRcWgIrKUbDdBNuVvf2sNg3wLHFs=;
 b=YgBxTpccRekgrPYllm6FYi/E3XH2L1wJOTpa0hAIXSfXBUvQL88MxwoU6HR1HPYfJmUdNS0EqaIosTATg8dn6EjVK3K1EVzCGFibCP3IifAKXGK3eTX99tmFScVUAVFBaBx/+r9hKRDTiJ5Qn9cNrpJK9QCYZ85ufoXIZO2ZZ7q7klOcUjK2fNhpIjaxYlmmh7n6ACihyqDRp4hr4TmlyZatcwElux6/UYEF8FHeFLSLSnDXYuhle7MLS8TN4Swq3h8KxPH8Rv3uzD5MjfLgo7mfIsBtcrtKolih79Ks/EJL/ycvl/BfZmUF3k4XDYKl7umsO/b7UbhtJrcid1K0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB4333.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Sun, 18 Oct
 2026 02:38:17 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 02:38:17 +0000
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
Subject: [PATCH perf-tools-next v8 5/6] perf ftrace: Support omitting execution duration in function graph tracer
Date: Sat, 17 Oct 2026 22:37:52 -0400
Message-ID: <20261018023753.584873-6-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018023753.584873-1-atomlin@atomlin.com>
References: <20261018023753.584873-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:408:e5::25) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ce47bc-5865-486a-1e33-08df2cc0dd6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|261009223027099003|22082099003|6133799003|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	Q3bhZQ/STd6ylG+ZhAMUUL+JpK3hzU0rMdlvNyav0PEtnYFlD6aSW5XbobH9zX2bNlDBEaecyotAB5cE0rmQSXbr4ZiXJZZVPJWdKg5LXco40+YqgDUDylwRdhD+PLMnctk4lu9NfdZBYT7CTg0yIvqVVu7D+7HpPqzaELhgzc/yiPoGx7rUfTw8SKorXr1WQFW9mOqXdJApL+Xdi4meN7pLF8QblLszGpZmQqR4NzcQgqzC2QSE3OZFHcqAySz7KO0sf2rpbFRg1QdJ+pIymCI2IxTHHf2NkcaxfcnlEhVvLExMw61z3uNpXJfZp5iqWYHaVdw1T1rJO8zHjiqxRxC2xxGOGzqYFE6v3j3I3GeXF6m8PXCJmEMGsp2TJyvCkcjMFRJxAQwIyUtQJE/ZWNOO2nCeKw0FTUqhfUgdRqTpVv0Tg91SZZUbMGVNIVzVPJ0J24EC21qo+fKFJ+qwBzaRStqZCx8lnC829gpuxaKx0ZtIuMCGnO+pe251ZEdLkMA1EsnElHpTN2Q5ERAK+Z1QhlQTSN+n3KYuZBeU3CqHw7PQuGw+4/JTdxeGf+o9ccTsWwynJKFy+ekFa7HttH+EEc8kbOhdA7QFKYR4gnx0kF3mKGaoFzDXxRC0ZE6radIa6S0cUH8QaBcFywInvNE9hdb9M416z8NB9m+z9uI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(261009223027099003)(22082099003)(6133799003)(10067099003)(3023799007)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fwKMGF/cmlYQ3PO2lJzGvcx3zGpRDrjlyLHTHBdh0GYAknZ5Rf/SYtOU8pOs?=
 =?us-ascii?Q?D099vZK68lR4xwCR22hCjkeYnFzgjgHpm1bXvWG7Kp4RKC1kT0T8L0Mk7Mcg?=
 =?us-ascii?Q?RblnJMniukcD7jR7HUVIAif4iVe+95N+VrpcvXi7Ga5lOrbneVfpvqDarQ0N?=
 =?us-ascii?Q?r+erd/0Ph4457h1BkHoboJbIpKo8Y0puMK8Mw3PXIsTZ6FHkmTouFmcD20xO?=
 =?us-ascii?Q?mv0OJSI/y2uQ6+B79HILPg+sk4aqYo2TTy4dyawsUAhjcYlrL58kGA3s2E42?=
 =?us-ascii?Q?gQB4wGJrCjFPi7l1aag0JSvYCKKx5+dz0k5AXQV91EViIhfs3psSu7Om5OrC?=
 =?us-ascii?Q?7NJR9Hah2IyzdmAU2vl+Vo+Z3HPoFynMrcbp4PUSZUp8yPytxmwxqcGb6/ij?=
 =?us-ascii?Q?0AViMIKSciaY8vN9DFKthm/tZCyWUEXy4onkU8G4Oidp96VpuDde9nuYEbSZ?=
 =?us-ascii?Q?P6g+g2LYjsGmZqGHoTB+3USI2EthC6dzVaaXzJFr14Bh5i6hnBAP9XkNv03z?=
 =?us-ascii?Q?8kmbboBOqbxuvE1YCrLfG6PpOw7yUFS9N5eB3eqI04iVaPz+bse7jg98Vu1p?=
 =?us-ascii?Q?D8tWKyewD6a4CAOwEpzyyN42mLHGuXMyRJwADDXdz4FlQA0C6vn3c+MtNNdU?=
 =?us-ascii?Q?uBzliDC1Jy3JZz0znWFnr4RZN07PmmFvSWe26kpTP1DN0tE1vY72NNhelnY5?=
 =?us-ascii?Q?fIVgaIEDrVtfICbPmWOCqOtqleUB+8qAduAdHLYYhi6HEXEQhO9oxX5VFr2J?=
 =?us-ascii?Q?M7B0l6tEhoF7e23LpU2MJPiScTVvHLdfu/1/VNL0JjqbvIyY/LyPhcQzLmEh?=
 =?us-ascii?Q?op7+igHtf1wwILZrxO+md05RwB6IESs8xKxvseM0xdINSUgkRirmqvkZXWlh?=
 =?us-ascii?Q?pkLDH1kMAiwfikd74pbCa5JdrC9QL5xeKzs4bfqdCwnZDmSaHIwgkCb5kipV?=
 =?us-ascii?Q?lENY1MKTuIVQ9CAeR3UNvNRBgZ9IG6kJ6Nu1Owgq6Z/pglJjV+8UpVZ8RacB?=
 =?us-ascii?Q?NSNokiB5LaZp0MHLvUMUw45JSLaWJzAprlf8IhJyqT1kUW4Fj22oaesT8413?=
 =?us-ascii?Q?lXZWPc1WWK27iaNnrAE5H540YVjVl5N+R9nC4ecA6R2t5ByGfHIpNMZPc/fr?=
 =?us-ascii?Q?6XtRz2zQG66/DNF/Q/tnaAJ+PNKslRw6HMVlCx2ui0nSmnHwsS5YYWLztUbB?=
 =?us-ascii?Q?HPUdpq92UrtRr3I/E4Vo4hwjYf1MslA5cK8Jg5++OzxGh4rH+fxG/PuwdA4J?=
 =?us-ascii?Q?z4c4ZsdjJPu0xlMAgIgK6aPeelEJPel88+MZGNNJUVzMGVcnHVyqWRW4mnb3?=
 =?us-ascii?Q?vcEsjBZM+J0Uv6aA7TvfySkWECp+LygjeyqQ996Ku6fM9Pbg5pSQVJ5DwhMg?=
 =?us-ascii?Q?lLmMgpQ/Hv5NJuEDtVd+nJcyWkWtNTJPUX9c6b3yl+oO3udih4Bk80dABHD4?=
 =?us-ascii?Q?96geNKsB56WoBx/u4DBi6EtBvTmwVW0kt06Rn33gIlpvUm1bRY7TEs9yorSW?=
 =?us-ascii?Q?fTbLEXE9wDU41GDTHDp79Y30y6EvzOZoUVxvEfA3HrtFyGP6Zo08N4wtkcvD?=
 =?us-ascii?Q?0Q4fHVCikNz8xEKqMs6R3qpM8g87GsLBtuLrSmXbpKKnXpS2K8Ji0rzfEkgc?=
 =?us-ascii?Q?uzBlcYJdC1LT/m7y48Gan0iGyC/Yj8w6A9O3wyXyrqUEVpUTULcQhgbIHMrn?=
 =?us-ascii?Q?W4nWG/r9Q7djL9K4fFsvBvKLvXQcdScQqLKsY/1ZTsLCemyChkoZhVfVJUVf?=
 =?us-ascii?Q?v7aYIWgOsg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ce47bc-5865-486a-1e33-08df2cc0dd6d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 02:38:17.1118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5NmIMF4BjhHfrRcuHL3BQhB7ENK7dkwwUcpSom774bI4X2uv2VSNebmoJVmIfpuETotVxT/N3rv22nD6E0n2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB4333

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
index 6e20a61860a9..d83dee5a050d 100644
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
@@ -318,6 +330,33 @@ static int test_inline_processing(void)
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
@@ -422,20 +461,36 @@ static int test_column_layouts(void)
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
@@ -447,7 +502,8 @@ static int test_column_layouts(void)
 		memset(&ftrace, 0, sizeof(ftrace));
 		ftrace.use_inline = true;
 		ftrace.filter_retaddr = true;
-				ftrace.graph_verbose = cases[i].verbose;
+		ftrace.graph_noduration = cases[i].noduration;
+		ftrace.graph_verbose = cases[i].verbose;
 
 		out = open_memstream(&out_buf, &out_len);
 		if (!out)
diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
index 020551a4d7e0..66c19116ee64 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -388,6 +388,9 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
 	memcpy(buf, line, len);
 	buf[len] = '\0';
 
+	if (ftrace->graph_noduration)
+		return;
+
 	if (*pipe_char == '|') {
 		if (ftrace->graph_verbose) {
 			/* In verbose mode, duration starts after the comm-pid '|' */
@@ -426,10 +429,12 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
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
@@ -470,9 +475,14 @@ static const char *find_func_column(const struct perf_ftrace *ftrace,
 		}
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
index 404d596bb60f..9fc4741d007f 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -37,6 +37,7 @@ struct perf_ftrace {
 	int			graph_retaddr;
 	int			graph_nosleep_time;
 	int			graph_noirqs;
+	int			graph_noduration;
 	int			graph_verbose;
 	int			graph_thresh;
 	int			graph_tail;
-- 
2.55.0

