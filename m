Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021095.outbound.protection.outlook.com [52.101.100.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C333B6F1;
	Sun, 18 Oct 2026 02:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289654; cv=fail; b=ix/Mp2Wxb3VdQVhuWi06F9HXkim4pkDHOblc+X879wjTnKursHWbVOgeNZIwvT/NPTOy307LPG0isQWz2sAQlmmAutR3+U3DVyolgwldP+M8OnSC94JKMojFoqOKr1KH9AOv9vKDO1mGYZTDfsOITM4z4aA9X43BewRNqy2g0ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289654; c=relaxed/simple;
	bh=QKw+GVp0wxfsNy5kv+chT3tWlzehxUZ1g5HGZQHg4pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qdOGDyInq8VFcHp/90D32nwJY2mbZYm7thT7liRpzcDM3Mt8Y6F1vp+ahNvQE27GzEAy1CuE775dKrK3VlEQQWqCCJg+0fHeHYnAYM9ZbH1aYGPMXSRXltHWQjRN+v84S80kbETjind5trVqQszGznOrxooanPmhU/nTtNlKwn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5nx88Q0T8n+j7mnRYDpsfJqt5HLburM855Xh6E5qPojUdOCDH3nuNgFKdvmK6pcliZ54ZEP6p07DJ6FaCk+U2UOes0v2XGaba+uzzzrRFUDzagKPcvYh7l5oAdwmiRygpVF8ACrPMgjD+ESV079x6ZbCljkaG82EcgoJsmzWLgOMmJ5Q/opezVb3BzAbNuaf19vWXT9GpmJUuxDdxhaK+l5wRpxWJkqn0zR2SMEctDbHVkWDQnx4xSAz/2lRhX/ccElALuCh6lK+SkNbB7p65qfm2mFPhCwkA2F9NPnZqQQZ4O/V4GIocDzwnknzSVeAP9mcolgU5AHdp3soFiVFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=sKT3VRHBvd3x+7GhRcWgIrKUbDdBNuVvf2sNg3wLHFs=;
 b=DRUJYvzPTkeVgQpk/PxWXcdqkSXKIxNMZWs8GDTfb0uP5360rtOG4LJUmZDdgCcqdWAz5vcqHZ+O9Wkv3Z3F87Vyht+73PNROpyZXZA26PsVlavNpUd1SWkKoheBoWVmvcT/cNVTQSXY3cLEKopqVwO5bWvc8X8dcxIwp9DAitLv0g3l3p1hCqUp4LjqpP1525zHABvwHeZY0n7/2kETxu+IGAEn99ulxs8grCkIgJGBRJvXarjxjWxJ1KuBo5lU/xIJEtrlRdwhnrBI+TggHutXCvi8NgVuPGkuCNMVPzNuEuWSyYt4H52p+iPHiv8EZOw3tQS1yt983Tg17KnQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO8P123MB986281.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:805::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 02:14:11 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 02:14:11 +0000
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
Subject: [PATCH perf-tools-next v7 5/6] perf ftrace: Support omitting execution duration in function graph tracer
Date: Sat, 17 Oct 2026 22:13:45 -0400
Message-ID: <20261018021346.582845-6-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018021346.582845-1-atomlin@atomlin.com>
References: <20261018021346.582845-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0848.namprd03.prod.outlook.com
 (2603:10b6:408:13d::13) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO8P123MB986281:EE_
X-MS-Office365-Filtering-Correlation-Id: 41880a6e-d409-4347-89bb-08df2cbd7f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|6133799003|18002099003|22082099003|10067099003|3023799007|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	BojA9cp/BXHKEncztCwmtP+VBM9n4eaOjkqqJahWnUFLhhM6Hr/Yrl8qEcZDaMu3hIeGUqxbz7guAd5YCu2iNK5YNazfZBW0XbKetGy1bO7kthF3B0jdzYyEHC+++4yoRtZzPB7wNBib6OyqT70111UBQ1AQ3EiBv+ShknynjGQsVxCkQQ5cuZj3zUPSn5CSqn6CXUFxiFJTZv1thL9P/iSAELtPH455/go4vzbeh84KXo8SAsHaQG9x88GVNIOkiDIQM8rndah0ABj5U86sRtrri/wYFA/UjYgiccSiwKgGFSPlXGwOvw72doruwe5q44AuSqmRphpWYL951DtIK+vV0qExvGLZtpRvpJ+VEgR3udCyEScY8088llG7m9khiCeC7Ixql/ZuDjqX1Nq7R5Wf34RubjZmxQPhk1/hO9BXsvSVpXPL7v6N21YVG3AjdSR4P146j9e4PTKuwIcITHubmeF6PAhk4M/aeRMWLUMH09JsKpEKB8YXS3kImsfOn4c3OEko5saBu7V7804LFAWvGI678voBPE3OH+qsuI+h8BP0leVf3hvRNWa2R/MSnTNPtowHw2Zrk8YfJV3SEiyKE2AbmoUw2DDdYZqAIZKucUbysDV9tTp8HLjWBfHNKFKF2anqo/u9dDCHav27qJr87L0mXdgVcSpK9AUzVVo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kvq6KlCCVB42JOUHpCC+1ae5lkz20HsZCuNeNKWFcl4MRPs1YMmRNpGJUvVm?=
 =?us-ascii?Q?AuOlIyG67+72nJ5rJo30Ju/Yiqtr7VnCPJRT/ojnf1zksH55vz312cHC5PpY?=
 =?us-ascii?Q?O+IAHKazw2t6HCVU8TuSfHXgnEAiERej6hd8a475JDKXZGVKsfKGagn6wlsI?=
 =?us-ascii?Q?RKGFoFmSN9sfgN2clwzcx9dogbLMwwezwbaGi8I66kMouHIisVeQ3Na1HvHV?=
 =?us-ascii?Q?6tEbk+hO7Pti6fgeAMHCJlDPvWSfJLqWVCZL4cLFpqVEr3MBhP2sMbGWbRyA?=
 =?us-ascii?Q?qrjfDZsrU0xMgLL8wE3Rqlq+HqLZJfzMpCOuscFg41LUtSjYfuiW6zqzj8dj?=
 =?us-ascii?Q?OLrtgWqgU7yimPQNze68+7sFh7bs0we+/NbE8Vo6/gBmSyvQwQQwgb7o57Vv?=
 =?us-ascii?Q?sQkgm8iIU9+0H9ygMNVvpjDVTwRToyW3MVLtZ34bjbpi1n4aVpCsTIjOu1+B?=
 =?us-ascii?Q?L5AHoEdwFVt198WSCZPOsEHbFNLNztm2tJVN3/v5RW2fKGcHIp7Iwib5K9EO?=
 =?us-ascii?Q?hugX4k+JYFGcEGGUf8mhNjaODF3EmUL+rOTnEpIin6qRJ1ePdHCGY8U7padG?=
 =?us-ascii?Q?cfqB7Jrr1N41sQtjMU5m7/xrbfFIqBNP04sACP51gV0312eHBEF48Z7hO1VZ?=
 =?us-ascii?Q?+epaMm/WwAHl99enpQvfX7oeQWihu9Rcp4N0ANBe8xrmQSh3gmm2/t44BmIr?=
 =?us-ascii?Q?L7AKjEiRlbPMLiEhFIZPNkuNpy/TQBIh55z5BuXx2PiX9XaM/nFrqHlG9O3N?=
 =?us-ascii?Q?cF/7qbka4l7OAwosF7ZzzO2BeAJXAr7pCZyUht9rancaL7hxG2v9mmXbB2Ml?=
 =?us-ascii?Q?01QotyB0P6Dh2Gvvn1o+tdi/LgTBuQfQHHmm4/2xA1WbBVLqUsdcMD3ULCIN?=
 =?us-ascii?Q?T3d7LW+D2Iz966BpgtHLYTiRssJ1eVxEFtCepbvgu+6To/jeSvYDX+oae1zA?=
 =?us-ascii?Q?W3FobN8+tCtoB9SOxGzxvNIhJoQRd8VIjv7jqSXn1VT29FpiwD3MXyeoQe75?=
 =?us-ascii?Q?h5xFMCxmjehPtPbWqwckQfJFjJcqFxHmO8KxUwLKw/u00BGBkAK7RemG8GAN?=
 =?us-ascii?Q?xtnYjim3WafX7oL2O6giQYmrx4mSTpwKa28qxGI36Om47qoE3I6uL7lWY9Vb?=
 =?us-ascii?Q?sD+iS8He7CmtVLkoeYg7cSXEujn6jnK7tVk4wWyVXUPuX1mRVXBMXuveTMq7?=
 =?us-ascii?Q?ikq5mHoKIVWB/y8NHAz3Hyzu+IFqNZMCSJ+wGenpIcnqoMzz/ps+39x33tvu?=
 =?us-ascii?Q?aWPU6YX6GhWCJB5ruG986NCWCVURwTP27FSb0Y+fBtzwD+k4ljkSu2ii8ABM?=
 =?us-ascii?Q?8rQgvwa8IKZlNCrytgIBuIGfLa/4XyB8lg5WOHYi10Km9+TicLynTYByhsXv?=
 =?us-ascii?Q?+5hgYnQGewWY/olIJWBJnzj77euOH9uRYhC4d/7qLf7pa2a5UY/I2Pae0pfx?=
 =?us-ascii?Q?68Ktkcp+ig2gs6FLAcZd0krnnv2P89hPSL4pPNjQiXzVsIn1mopNgUcjuT70?=
 =?us-ascii?Q?CgvhQBTLAzCH6jpDZniuzZxRDaJTaYU1Jzj+oy5fQZVd+mowruVxNrkFrdJ3?=
 =?us-ascii?Q?bAvY1mtsLviTUVOxoJ0WkfP4OgP01lth2z3nzRu2cJYEch0Skl0F0T8E7ueX?=
 =?us-ascii?Q?DSCKoPxF3NZiLCUPk5yUfiEH7XVZ9r+QykQF7o81YGfBkiFkZE2fxFYX/B/p?=
 =?us-ascii?Q?/OhdkFpu7gyQWjptinD7lg/RNqkQ4ERoj20QpeMzDJPJpp2WZBcS/nDTImRT?=
 =?us-ascii?Q?GZprGqbeAg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41880a6e-d409-4347-89bb-08df2cbd7f8b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 02:14:11.1270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uo08yPSjqDs4JpAcLGRjbXTQypVLyYDTjtVuo2vSqaJ96HusXkTac0VgcSIGzFb9sRD1DnXBIu0rkEN5NztzlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB986281

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

