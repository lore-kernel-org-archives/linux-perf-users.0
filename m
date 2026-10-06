Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021079.outbound.protection.outlook.com [52.101.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4774B8262;
	Tue,  6 Oct 2026 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329334; cv=fail; b=kzKvJ4LRo8fkVBgsCQjKwm6I0Z3uR64vfxmPs4SePAGQU4gdhKRixtk4moI9jixxAWYn0U1zdlDkrY3Olr5KzwfClgzvPADhUsgROtRdN5s1aPnFWOVI96BcWA7XwIkRQW3fI0QJdEwIKdd2Md5Ubv18t2Gx4mjO1qphNY0Jteg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329334; c=relaxed/simple;
	bh=FoQXH3JKIGuDSo3JKgtpDJlTGzCgR3WrWl7qC/gN/3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mD9X3FRRTK0w4GLX9uPD1QtE1fHa4war0sgxpriA13yYebhsEMkJ76h36JhOzvgUw/My/Rc/qhHgz/sb78gsVrDrIN7LCYIvxUyiQZ+/p3e27DTbbNBaRi+o0hQqi2xkNaBYbqZErpUg6KrMDowQUDrfiFGDf/Rr2WjFkGkXry4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvdEkAcvT/IGo4wq0X+p/g00rIzXo/g/1jUANCtq9i86VPAbelsVNNsdmtfDzmsIDoZrL14/jPX9XJmUt5CpyrRA0UX4RdB8U1A/sWU2+HbJKMDe7DIfUcEuM1TH+QbsWHNUuxaixaYwRgfYdji/0QBGmVD3kM1yWrgp1MGJFC40ANvScwy0MtW8dmUyJzcJNTQp3UQrbuf0Qon/f7laT3AoZI65cf2LJ6OkKvVV+LvJ6KynrqQ+HHlB62gBPkD2o2irz+XJhjNBKDGnWH5J09AfzoA+8eqZu0WjpsL+mluIlqGWNbSB2XCKmABASDfniKQG+WuJIR/t3WVwagqL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=6t0KgnVzyzek4FkT1pGdHwpZ23p5POx3tOCftjtVvxU=;
 b=mnHSfEOYb5sVHn4SXlFAer4serc7zeD9vTkWP2LOepTf1LYVTJr21tEIQkuMUW/Sf/kZyUIBaXnKTMloFH4ih7xhaesiBl6z7UsxJCieLuwVrFq5b8DBEjbCgRxGZfsKtAKdV/U0FQfWWwEDcqennjIXquzc2/5GSb4Hw8dBhudxmbdzUGcGMmt6jyXTJU7vbAjuokToP1YXIOkSKmkydBoJ+hHh1mHuGe1BoQJzOOCj8trJbjlFBwHdwxxT6Sh/WwejtF4uePlnTBJ7zUGePT+g+LT6bPo0j/2V3C0aBAWD+SKlCdzAIRmP7VwfQgeNxwYKyRhJirAq5wB8mRrCKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB4004.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Tue, 6 Oct
 2026 23:28:07 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 23:28:07 +0000
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
Subject: [PATCH perf-tools-next v2 4/4] perf ftrace: Support omitting execution duration in function graph tracer
Date: Tue,  6 Oct 2026 19:27:56 -0400
Message-ID: <20261006232756.65620-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006232756.65620-1-atomlin@atomlin.com>
References: <20261006232756.65620-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0045.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB4004:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d8a77c-ff40-4423-d094-08df24017a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZXrUwTcWSG3ikgAxSrQDofniog4m7BrznOLNwbodfrWu0svHmEcK7L/5158zNFy3WjMb6OQ/PxWiX5YR/HXHxPq/qAHBrSXIllQ1Jg+xRqpCb027IGq9dIwxtqL+cTHsEaUcL7eaGj9l9/SSqNX5nXF0LXoUNeWdta3aPCOAM26ISXR0bC6eBsQwHI7l3eI2e+QJ3zXaB/aRchR1lT0CBgCLnraj4VCufL8u0wLqCRVEpv6rbfWfkw+cpHfPW9PLqUY9YYPcL7ZZ+blcPpyRFac1/zJvgVvPcGIkpsLumj8nIsCR4uaUwUmoijA+r64lC2UgPvm95T+orJz8zjfovuxf2d0oCX4jwcqDekUk97IJFYck1eZJDNZLltr2zwChiMNKkSKY9dmHfQSRy3L2v9MTLFmwFLfj1vwdj7wj2dAYQ6yIY992YkdAkejzOkz/NF87jXhKwJm6VxFiNoorAxsJMoNWncXb8Uuc7xR2tOwC6Lk7k6LNs5055Zo+4LLr3P9jF5uvABEe+RXzrR+1P+O7Vd/vuDARwnghHnQ912K7MWGxB+UXdoOZKnaTTYDO6C2VKratoDJ6m/+NhQVDqJ1uCzANnhIX52Nui6r6WPawdjrlJVcbgNnyurgW31e/ierTRihM9MXSU/hHZikdmAnm6wkvJEDq+gIfj20r9tg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GO6/shlItCvKNxZGZiDp/CG9ooU4vMVjcb3g1bZsYjaehOkBkgu9/Qu4xayx?=
 =?us-ascii?Q?h6kuA48JHG/zYFC8OM/4+9P9i8uv7XvZ1avS3qjdBe+ho22Kzv1m5ShbrQYK?=
 =?us-ascii?Q?AbQmBHvSo8/KTS2ISbEs6hojAhECDAIxKucdlTv5rCzkQT1B5iYVdRaTKFFj?=
 =?us-ascii?Q?1L1g66k//XrbFBiuopCk4bjhQS1CI8Uxv4Ykca7p0S+Mu0mDbk35VO4ShDgU?=
 =?us-ascii?Q?UhSeu3QNJWb2Fso0bo6Os2+73H6foVbvL4LC4z+LJb45YzT9s8QNKm5VxRHg?=
 =?us-ascii?Q?/IkxmmeqqCydQc2fukZPymqSc0GrnDLwUcQf1T3DE3EOq5tFwmZMIASdhpUZ?=
 =?us-ascii?Q?w0X/DDCHs7XufOp8V/vIsSVxaXw8GKe789cslcYqdFEQpAroE2/W1CFRf3Dn?=
 =?us-ascii?Q?Gw9Eq0Cbi3fg90N7aBpYGG3sgTDsH55wR2wiBJL01jUcEhCRrlM/agzWkdRt?=
 =?us-ascii?Q?/7U7DpjYyQGuEiIVumNCY+Gbt85QDnYIX6F/uPJFifP2ck+SB3+Teum3IAj5?=
 =?us-ascii?Q?y5UBEAKbMt2WXwO9IFKDy/uUBR/uRcpHXIfMA1q8y1WW9Ff8Zk09eLK44CFA?=
 =?us-ascii?Q?zZ4pb4sfzLXpXT9bQk5F0A3y0TSbzqy26LQRo+BU33/6mX5u+zwM70WrDsTN?=
 =?us-ascii?Q?ee/Tn+QwfmcWsPEHjFDOYcePS4s6URICS2e01u+5Xti4LFM9IXcjdL+RWi3s?=
 =?us-ascii?Q?i0/CaU3sf5YEDa7VPkNcIMyVGbDS4/GPCawe4VGPOpJkcDrUr5hOKH2nifpb?=
 =?us-ascii?Q?mqy0xs4neGJ8sAyYkkBBjp9drazfjHWBGyvDK3u9ltR6303dQvhK62yp6k6j?=
 =?us-ascii?Q?RaKs8YjWKPHKTWgVNSjBpSelOq4mMg6GUC3SDMxKtsZ2AIWsv/40VR1s4/G6?=
 =?us-ascii?Q?I2ynfX3bYqXTvl2O+Rs9xRTU73wOJjQ/kfQwu2evTr18QZjS4YQpityQH8Ae?=
 =?us-ascii?Q?AvHse3aOHyQrPlZDh/o+OmeTZ2zJjE/Sn1eRhIQhkyAOr1A9XKun0OLaQNVx?=
 =?us-ascii?Q?cnSZ3pyuAyFTDMViubFjE2b7FaRh9VrSxODr7m9dOU+IXHTHvncGsHt09EUs?=
 =?us-ascii?Q?4gJmRmRBgTsQFNKcslDeSbc6aUXjhgu6EyRHFsRTdlpWAau2rxZD41UrLghn?=
 =?us-ascii?Q?ZvKR03GEysQgbfRoGKqMUy6VAMiaurqgtcLxVbPxEmynt+t7i5CB5r98Y+cA?=
 =?us-ascii?Q?eNS4fB6hsC/Gi+J0K5K8nr7JY4rISD5ohA2Bw8opyI3TiglHHB6gmzvtHYc4?=
 =?us-ascii?Q?jYxpQ6t4OOnjBu+YK/0YwoE03qNAxSYRAIlvGexHkc/neOUaLgKD4mo6vz0l?=
 =?us-ascii?Q?fQ5Tmhh25UUEKo3f5WKhlL4JyXJzt1CMgY30cFUKhf3wbiv+9tW/lXbzin+P?=
 =?us-ascii?Q?aMkLGFCSQgZ5aPha3kXU8Nsk3ePIYqEqanN2rMVTu28BvhSC3JPflM+62Lqd?=
 =?us-ascii?Q?wk+scMpNks+O8UPx8tAVQNua8W8iHaPJ9CYzO03OicuVa9N82ktdnBw7p9dv?=
 =?us-ascii?Q?CgC4/2KbodgEPAYfdxP5eKt+VsnfXNnbP8KjtZiBLRBOpV+30YDafprcnrIh?=
 =?us-ascii?Q?5E1I6S9foLR2mdQBpSnXJOsdRL17Lu0pNv8kIDDHMiLJFwCWKXYM9CKKOYV1?=
 =?us-ascii?Q?N61bntU733nZqFT2E9Yn+7gyQ5tBd3d2aVIslt7FqWEMQmKVkvEj8Bwi7yww?=
 =?us-ascii?Q?DkPaWJGETKI7hylVmnYKwm6tSEkZ/WMcmFAq4cyjvyfPjBCRD0wXFB5bgZlL?=
 =?us-ascii?Q?EiVbA5wzLQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d8a77c-ff40-4423-d094-08df24017a08
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 23:28:07.1785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSgmRy1EZqWRQi9PP63Bqzwnebu0lBnPyBmy0PgCawQfxu0AEW31fLR4vN3NvEZL0LeamM44ZVqpY06aElIpXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4004

The Linux kernel's function graph tracer displays the execution duration
of completed functions by default via the funcgraph-duration trace
option. Whilst informative, in scenarios where the user is solely
interested in the call graph topology, call flow sequence, or inlined
hierarchy, the duration column can add visual clutter and widen each
trace line.

Introduce support for omitting function duration by exposing the
noduration sub-option under --graph-opts (and conversely
duration=[0|1]). When specified, perf ftrace configures the kernel's
tracing instance option funcgraph-duration to 0, and restores it to 1
upon resetting tracing options.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  1 +
 tools/perf/builtin-ftrace.c              | 25 +++++++++++++++++++++++-
 tools/perf/util/ftrace.h                 |  1 +
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index ca0f1d523dbc..2e0b69a6e5ed 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -130,6 +130,7 @@ OPTIONS for 'perf ftrace trace'
 	  - filter-retaddr - Filter out function return address comments (enabled by default with --inline).
 	  - nosleep-time - Measure on-CPU time only for function_graph tracer.
 	  - noirqs       - Ignore functions that happen inside interrupt.
+	  - noduration   - Do not print function duration.
 	  - verbose      - Show process names, PIDs, timestamps, etc.
 	  - thresh=<n>   - Setup trace duration threshold in microseconds.
 	  - depth=<n>    - Set max depth for function graph tracer to follow.
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index e11418e61937..88df6b09d9b0 100644
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
@@ -598,6 +599,17 @@ static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
 	return 0;
 }
 
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
@@ -707,6 +719,11 @@ static int set_tracing_options(struct perf_ftrace *ftrace)
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
@@ -1747,6 +1764,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 	int ret;
 	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
 	int filter_retaddr = -1;
+	int duration = -1;
 	struct sublevel_option graph_tracer_opts[] = {
 		{ .name = "args",		.value_ptr = &ftrace->graph_args },
 		{ .name = "retval",		.value_ptr = &ftrace->graph_retval },
@@ -1754,6 +1772,8 @@ static int parse_graph_tracer_opts(const struct option *opt,
 		{ .name = "retaddr",		.value_ptr = &ftrace->graph_retaddr },
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
+		{ .name = "noduration",		.value_ptr = &ftrace->graph_noduration },
+		{ .name = "duration",		.value_ptr = &duration },
 		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
 		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
 		{ .name = "depth",		.value_ptr = &ftrace->graph_depth },
@@ -1769,6 +1789,9 @@ static int parse_graph_tracer_opts(const struct option *opt,
 	if (ret)
 		return ret;
 
+	if (duration != -1)
+		ftrace->graph_noduration = !duration;
+
 	if (filter_retaddr != -1) {
 		ftrace->filter_retaddr = (filter_retaddr != 0);
 		ftrace->filter_retaddr_set = true;
@@ -1849,7 +1872,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,filter-retaddr,nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>",
+		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,filter-retaddr,nosleep-time,noirqs,noduration,verbose,thresh=<n>,depth=<n>,tail",
 		     parse_graph_tracer_opts),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", parse_buffer_size),
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

