Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022098.outbound.protection.outlook.com [52.101.96.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581F233D9E;
	Mon, 12 Oct 2026 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791765038; cv=fail; b=eFrzKlm80tjISg/bI4ZDMIMbdD1Z8etHPbeoB+ixC4Pu7ignnoXqshyzPnU+HVuFFX85ODYHyz6hrLHlA16cbqlVFCYLiIop5tuHoyg46H1ebF3Wj2j7griqwFv4bWsj0U3i4DsbzZO7LXud5vyG/4codGP6CIBgj19zy5u8Bk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791765038; c=relaxed/simple;
	bh=lYo0C3il91CmlhdEPqjf/Tha8qr9TKn0pm4h6d8m12s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IUK4Q6sc6JsetHJDSHexcKu/apzMv2LeSGBuUb+q7bgFV8CMy6coPgZxhCyC5UPOUwZ5FWAtjE1BNJ/w/08hpDN6eNYgRHs1j0hBWhZGA5oqnsAAxjt60m7VI34r6ou+7ISORmrZUYK2Wqv6v16BowE7fbx46TqOB02mb4RefLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkNHFBIkulR5MoZh3wZFVhCchU8OZiYGoprxYQTN6SIGXd8h6+1ucY4W3fQspklDXmBCGdpgKGIYwDk0O6xfnCa7AgGpiHg6rnjpK8TaoWJVwrhlXjQFBn73Ysn/Dgmi0Zj8t4bM3CwHdXDaXoFm2UwqMMiinhGAYs43n10EJLDmhv1bJfvD99FdHapaV7R5gv4vHoZTey6dX2w+L5U4rP005LAk3zwBiU74DjKDSjTuoaRN7NDjYlBGQqvT/8pSR+nrt80+UFDAziZ7ClWKZuxJ8P1zi9U/OyjElK0nH1WLtPhhMEHZU8lxThgpI+8JJf2fcVDkfTn4yNYby305cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=8Zf9/1LfhC9x+H8IBwKBbMnvq+TEEr81ieDum9QuPZ8=;
 b=H1HLN8YX4b6+bMEKE15/+zeNpfJUY6j4MjpvW5MOY4wpqD0jbPS4v4hktty51Q/0poXFbA8G1JZ7oJLskJgsq/aNNWpB1JJqg3zjG2crnWwMNrBa5CnyWA8L9FVAsWNYF/joYlr8Xv4vkqJW/2yh2cq45JO0MAeEfrDhTLksEqnvh1cicmR4mVVBdNd8zVrllr6+YxIptXmNGuiy7v1AuT6ydyBC5aFaXqPDvkcGnT9Tn+eZHVYITNr5HVPxPSgNia6CC7IMVWFqg+DIcq/skFz394TWMwcb8hkdhLDH3wM3WlLnStFHgZjKA5Mgewkl3hAyebDLjHva2JFK5aIj1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOVP123MB8542.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:48a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 00:30:34 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 00:30:34 +0000
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
Subject: [PATCH perf-tools-next v3 4/5] perf ftrace: Support omitting execution duration in function graph tracer
Date: Sun, 11 Oct 2026 20:30:14 -0400
Message-ID: <20261012003016.263063-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012003016.263063-1-atomlin@atomlin.com>
References: <20261012003016.263063-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:408:f9::29) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOVP123MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: a54583a1-d8da-4ab4-be83-08df27f80779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|10067099003|18002099003|22082099003|3023799007|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	4Qp25xVp6r3yCGVRxgirvd5h8rjrGzW4H27CMbXq3PlUD2A5i3BbPAqn63ANrWvIyurebcLH3kwf4rxgR9AZ2UNmbGD13K9v+YfANfegEEjVAZAg77gyHUgAkVJpopgOED98ouVe4txjL3FJJjl2fdpqSpf3IVhlnrOyjyvlLKLWB6k9Jl4tTf4IYe86lXNrXlrcxHhuHvTsOL+yXzqCKssiUzwkoOv5Ros0Mpsm8bu5bDyxd0Kinmdo/8xmE+pWzaftjy8jr55W+zPzKZFwu8bCdjvCGbFEvDAusumo+YaJ+wnNMrx+QevzfMM9cyYw+Vpt7qey+MHo8sJUJDKONstWembVlbCIwdxkyyzdYPymwx18tUqTdgTubdAmYsauMxcOkZJQ5lSfxMC/vA64Wf1Zil4QDUAfl0i+lBtaB+kNhwvMs1wGbxc5Hb0SYT1jQBssLrAtbxhTRRvgUe1J68w4qDXjWJPPbM4FWBbgDkQmjf2NK/zYy8zugISeCj2U2XANCKa9QzxhAw2j4tkGD5P7kI2rSMcnQNGVOApgRQNzwC8K1RK5EZCaoWZMz1fvf9q4BX+NqHtBogqoAtVXF1j1BF5jCSZslPdjsS1TJwZ2N+4jqyA2PbltfLbhF5u0mnkqdKymKVWebO81OAi23Nn/0KGV61A72fe8yQ/Q+gE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TGJCynxzwpHNB5LPdHjft7o/CKc1khqIF981kZW8r0GGitPdUHnv8ihjVbvU?=
 =?us-ascii?Q?w9nm47/eptbyKXRGvOddCPlIJUKH3mkBFxR9cByb9Tna6vZ0vU3NBgyVEGJf?=
 =?us-ascii?Q?vjFDHT/DZly6EOWCs5C8xzi667LS2Sd1gPFFTolNTAFUkN2t6Il+1vhHVvbc?=
 =?us-ascii?Q?3cUhHZXjJzj7rlXApqfFc8zcDzwBQ224jwnjIDxkN1R/uHWgvny4dlwr2C3q?=
 =?us-ascii?Q?D7eLXdeEV7hpaa+daHWZjoKUJXUNSPaVI8yYPpc/KX9+ATlkmlH/1AxPi94k?=
 =?us-ascii?Q?bJYSlDmucMc/VpSeF63aWh9AYPZSCrGHlTmDQCW0WsdtzTSEdU4VuXF/UwZp?=
 =?us-ascii?Q?wsCNfazoxqv3gy6Cx4hRUE1XPshhgHBQNPjWpjR6bGyN8d/27YtdhNscEPqQ?=
 =?us-ascii?Q?V4o0INZYvHOsfC/yzuTHZ7UJlElcg8Xu0g1mSwRIsgpsYZbrm89uhXUGz1Wd?=
 =?us-ascii?Q?RJ0to489Mc8hWm2wE9d49JaMuqGl8uQ3R+FDP0SLgsl9/TuHR7Vw/zOpcpb4?=
 =?us-ascii?Q?Y79sOXQI8gT3r83Ocweue14ADV+uB0Ko8xbyjawffvcSjTTWSwV/1HF2wIef?=
 =?us-ascii?Q?Kyf4ejtVWIVr74IVujcibSHK5pvuEmQWwkMjAtMkrnqWwOnY5IuC0tRJPf6S?=
 =?us-ascii?Q?S1Q/JekZhpUaZf5iYifcjfCr+1sW0Nqqs87rJ1FrQWSCWAALvx/ocXpgdLJO?=
 =?us-ascii?Q?PwoLg66hpXWEQt0cvk6YrHknDaxloODhT3VAt2lnMeaXJNQ3kUg7PCtHdjbC?=
 =?us-ascii?Q?eQbD3hwJa/ntpwp5GoHJ0DvuZlYn18muo3bdSV+c45BoYXgxlCywEhDrX6lV?=
 =?us-ascii?Q?BN6PSOLqwdu3bzRnBE/3CCYyXr34qgEYmPIA81I34u2WOdOqgXbHi46uiSVh?=
 =?us-ascii?Q?RZ9t6FeyPoXUcHj5qS5a+RDu+Bod1jNqIfoh0jP9vivG6mH/RUn4iM2OOq41?=
 =?us-ascii?Q?zFO5zuJlALO998C1Wslvd9iphCKWoQ2Xo85J078XM7ejljf7FXKflXkJopcw?=
 =?us-ascii?Q?bIcwTt8ao6Mvgc5Enj8LxGDo3UMv7FEy5bV23o1nssSHxRcc/L0bsVkvbqrW?=
 =?us-ascii?Q?UaTxt2IpuCb9QG6/if4A6BlOLDM1JbxRh136BNLZ3ApmgesOJd0BhM9nS33G?=
 =?us-ascii?Q?dhLV/PxHKL8HqE5Y30vJD8zYpb4pB5BraHK1oWyj5+A8pQa2+jSwZUlANphT?=
 =?us-ascii?Q?z5MDMsR4jDWOPfjSI2PLzpTFP3+VtGUGeko3EuRvDTGvpP3db7f2et5w+A3g?=
 =?us-ascii?Q?hloMvjmm7HH5qg3Cck8pEHgwuKIoNSV6YJCzVtbXbehc1fS7zXIWJX0aXAVq?=
 =?us-ascii?Q?wHVrUkiX6rCraTZ4Xv9stZZN1jIt940UhSmDaxDADac0mBRlmSQSyiDvBOdg?=
 =?us-ascii?Q?/GlBhZmuw6HwAQWg4bHPRWtf4LNXkvIOCbgyRsqlXoanjBmMc1vJP6U5iGWW?=
 =?us-ascii?Q?x12tdT5IKG165U/oRqe2As27iai2XLZxWytuyDC8NhafyFi5ymOevT0DB1f0?=
 =?us-ascii?Q?//N/m98viv4FXXWnP+x5Q2vR7J6+O1ESeAFhkgjQbIHPTE88agqNCzsNvb58?=
 =?us-ascii?Q?Law7k0zof1AgY3yLDg3V9Z7Zk7hBTHqAJvgAaz7JMel5JBhsti90xpSnG/dv?=
 =?us-ascii?Q?mVE4sImwmqch3En4oLzRL4gxqHGlj7/UoXLQVStN4ncRogPGDcDBqZ3L2ofg?=
 =?us-ascii?Q?imY8rdUnC4jmP8n8QhipjPw4aE1H82NM4JrGgBaVKzVG+Sn9RGB1ZNg7K4WK?=
 =?us-ascii?Q?95lIAbmCbg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54583a1-d8da-4ab4-be83-08df27f80779
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 00:30:34.1548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Z4e4b5RM6/lSdDzEA/uF27IdJDmaFJ/E8jpMlICL7+eH1YUDIYX3ZiJxwzAf9zWKjy3RMxcpHTpaBGdk2lxBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP123MB8542

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

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  1 +
 tools/perf/builtin-ftrace.c              | 28 +++++++++++++++++++++++-
 tools/perf/tests/ftrace.c                | 25 +++++++++++++++++----
 tools/perf/util/ftrace.c                 | 15 +++++++++----
 tools/perf/util/ftrace.h                 |  1 +
 5 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 86306caf569b..a584583936bb 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -128,6 +128,7 @@ OPTIONS for 'perf ftrace trace'
 	  - retaddr      - Show function return address.
 	  - nosleep-time - Measure on-CPU time only for function_graph tracer.
 	  - noirqs       - Ignore functions that happen inside interrupt.
+	  - noduration   - Do not print function duration.
 	  - verbose      - Show process names, PIDs, timestamps, etc.
 	  - thresh=<n>   - Setup trace duration threshold in microseconds.
 	  - depth=<n>    - Set max depth for function graph tracer to follow.
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 504007064e24..926726c5d9a8 100644
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
@@ -1754,6 +1780,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 		{ .name = "retaddr",		.value_ptr = &ftrace->graph_retaddr },
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
+		{ .name = "noduration",		.value_ptr = &ftrace->graph_noduration },
 		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
 		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
 		{ .name = "depth",		.value_ptr = &ftrace->graph_depth },
@@ -1843,7 +1870,6 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>",
 		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,noduration,verbose,thresh=<n>,depth=<n>,tail",
 		     parse_graph_tracer_opts),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
index e856bed00700..cb212339e666 100644
--- a/tools/perf/tests/ftrace.c
+++ b/tools/perf/tests/ftrace.c
@@ -303,20 +303,36 @@ static int test_column_layouts(void)
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
@@ -328,7 +344,8 @@ static int test_column_layouts(void)
 		memset(&ftrace, 0, sizeof(ftrace));
 		ftrace.use_inline = true;
 		ftrace.filter_retaddr = true;
-				ftrace.graph_verbose = cases[i].verbose;
+		ftrace.graph_noduration = cases[i].noduration;
+		ftrace.graph_verbose = cases[i].verbose;
 
 		out = open_memstream(&out_buf, &out_len);
 		if (!out)
diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
index 8737bb52921e..5cae01a28529 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -315,10 +315,12 @@ static void make_blank_prefix(const char *line, const char *pipe_char, char *buf
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
@@ -346,9 +348,14 @@ static const char *find_func_column(const struct perf_ftrace *ftrace,
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

