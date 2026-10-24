Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.196.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792877188;
	b=ZRWfW9I71nmHBPJyoc+UZxhnBBujnn4OLzXjhNMFvh093PRChY6DZXAB+axodDhbimvF
	 gZr3/2BE0xM/Lh2MZ1e8duE+gdSEru3NeLrPgJ36aJ9K/8N+K2wxHeQDaMjsC6UDumH7a
	 279ETqq0bcXYesFhQncf+n7t4FkzjuFD73evNUU02U+5LuP/onXWu4kVVAUrF7QPn67LF
	 y2Rr/zjrD0xTggpF+1D2Pwsfr0kgvc/dpmtuL/+hLiOp3fBrZ9Bmc5t7b7F27I1J0HP0f
	 ky1ZV3UbCvPuPFREMkzzOf13cICGyAT5rDrCiAUJCmB9LFjY4qZm3Rzv3pNfjxfTr1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877188;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UCrpP7OHrUK4i/u/fkKmedVcN7W1UOSP2hGeaxKE3Js=;
	b=eRhNxWW6vFDR6mTUwbCFZrmMpSBBgpMLdpO0Bi3JJvkQavxj1gmjqtWuNNUt60SXIfAk
	 daaeM2XMV3VDqCMaivtoM+Wk1qaomSYYuMvu4CHSy2VGEOBw7z5YL4XTCFDiIu8Vr8tHC
	 v5+xXFOU0iMI6QWEEsoYi1nIhebIWifHQdRrorCVk/UUSsu3ubQdvpkDuHEkp4XXQYqy+
	 qkzE6F+EJQQR3AsgU5Dvk4+FuZSi5dXrEXSQ8YuLfr8tySG5WSba0RT3gkXE3AsZzlTNJ
	 QlH95utAIn5S6Mjqjjnbcj52MvcGMSEPvoxch7LKycTqqHdYdW9Dhu7PPbFiIwAqwZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=fail smtp.remote-ip=52.101.196.113
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020113.outbound.protection.outlook.com [52.101.196.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC91606A321;
	Sat, 24 Oct 2026 21:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EC91606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWEsYzJiKmPozgrPacHO8Lf5nmjN2vXr8HpStFg1O72iRhG3IUQeC9d4n+7j1PwjxG/y7x1LGgUf9y7zlsF6qP97BY4BuplJnJIuWbXAAWnkzVh72ujEhWtr2HPxIMVciHFjUx94PPPHlAWbkDpgwDhyIu3ZsfaW6qDHOxSkGQmB2wtJsvA2vE4JhTqHFSppCsCTGMTImL9DErbJd+59h9r2TO7lC8HK2nuvAbAYII4wlYFeh6N3LkFvbI6v8Pfrua0wOlm4qSN98cE0L+YoPeMlsQchQY8BzHWBz4Jk4Y48vCZEA6eH+ADxeJ+NNiGZmOuZTVl6Xoa7foVGW/+0Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=UCrpP7OHrUK4i/u/fkKmedVcN7W1UOSP2hGeaxKE3Js=;
 b=e9OP3sJcq+OWZKYndf+WM9Zfoq25HDQl592bliNx+UUcJeQQEl/bpboCaWPI6/K2541Fi3KYG1+lzJ446Qxngb7qmgt0eGvAPJLPz20aqH2oGMPjetHYLVseylTmpbdbXBUElZ17OAaRM63LbUN2H3vwpxEOyAgHRx0diE+6W3QpOeAvQAGMACBTpdp2jn2XPEIHr4JKlprgDUjaD7XbfwdR6vd7+8hiQ6z8VY1i/MzK4J9CDTC7KthuBhnWjW1Ok7CvIbn0wtPMzhbE+pNhfsKgTP239WSr2EWVzIpWFAX/xdFLPwtUJETWPrczoCiBRdqbjZSB7VaRRkCzemqAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6642.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:273::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Sat, 24 Oct
 2026 21:26:27 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Sat, 24 Oct 2026
 21:26:27 +0000
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
	chjohnst@mail.com,
	neelx@suse.com,
	sean@ashe.io,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH perf-tools-next v10 09/10] perf ftrace: Support omitting execution duration in function graph tracer
Date: Sat, 24 Oct 2026 17:25:48 -0400
Message-ID: <20261024212549.450634-10-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261024212549.450634-1-atomlin@atomlin.com>
References: <20261024212549.450634-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:408:fb::11) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a432e42-691c-4c8e-e876-08df32157665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|6133799003|3023799007|56012099006|261022115727099003|10067099003|261009223027099003|261021130227099003|261022105027099003|261021123027099003|261021121427099003|261021135927099003|261022075727099003|261022113327099003|261021133027099003;
X-Microsoft-Antispam-Message-Info:
	2LY+PpjfOoUlKpnYHl14gYTfrcp9T9Hp+Jbu0zByD2yq3+QgJKhj2ly/CZbSwKNwmsYhNErqKpkeLgvg63OQ4zAA8SVpMI+odi94/xrtMUsJy2v2KER/yeZU9f76OmlCTLD+0XVSTct5mqNXuj7m3KaMsK1lYfnzQ1DgrmgSPSf3+z/9tBJIvWEv/R2Pqyp7XtbKJldoGL/SNdX/ISbxAuJ44T7EFKCGDTBddEVsN1L3028djF4efTimA2IVh6Zgtcz+4tvwImINx5+t/wUs2mwYxhEBJDazGPPXIjhHUQI/9rl9l7Fn5TrdRcuVQwq5Fu0fLlHtUEHvT9AhbdPQCsD+Wm+lAFVmuhGTxEiungzJI1+a1LnbvY2HqVV0+Gnpmts5cT6Rsiy/FT+BT8thXza0DjzThlnwj+w//ztwQO4K4ItuQWG+LZwwTU4TB2jPj50xZrYjGwCvO8UlHaHF9lP33PuWMg3TwyDPxaOuK/qR+ShtzNbQjuY8GMCUTyHMfCMeYKJ+6Efsb++H/3M2S2c58b+TN/FHBXBthjJVKQ0lOCDqbHDLJnnuoPiaIIxY9jzCGrFr3u2aAtL2JRDhn8ymXbd5RXzcu8ddLzp99apPqMxjjHSt18pVFQbdAn/MdulyhIAGgGC7DMA4iG/Xpw4e9qPouUmJolF36JVNONY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(261022115727099003)(10067099003)(261009223027099003)(261021130227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261021135927099003)(261022075727099003)(261022113327099003)(261021133027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wNxkJAdXBDb+XJAdmn1KIw5PQE/h84ZxcKRT1+Uq7xU6zUqOGMwxj0ko4fSC?=
 =?us-ascii?Q?e7AukbywD2sEnHpGAIca+3vtcfFagyy438q98xIdSSE/p1N3bxylpY2FZWqN?=
 =?us-ascii?Q?NLvbUOLVclbfgClqi4NTJq8Cn+oAKf9flnUHRIiLpDF2vi+V4QFMLfhClvjV?=
 =?us-ascii?Q?g+RU5DGKsRZsSP02VKUnhDtUWzlALlPqQpAV6EWpyGaKvvjPxepgz3uxGqkL?=
 =?us-ascii?Q?DY4eovO3rOtkXCinW0sLraWsgqM5uFQIKsxj82oNHy/ikwaHx+3i14OwYaWL?=
 =?us-ascii?Q?eX1SE3RT2UXsMQOj3iM76IHSRR6EVtxAAuAc9t1EE9h1f1UEBkxLXDuJwFmJ?=
 =?us-ascii?Q?7iVTPWgtt3bfHT9lQTY4O7fDqVQwFiF86uk//NXFZN05lYFRm9jA14zFfw9j?=
 =?us-ascii?Q?Ej712xiLmaY9zMD8IfVBJTVVVDETernzLsUNoULEXWsWvBhzaxG+ETsi+KLq?=
 =?us-ascii?Q?vfluSGDWb/o2W2eub5Y/+c9QKWe2a2AZfyja1xzg//+HpW2QBK6vkVjTKQNb?=
 =?us-ascii?Q?3kYu7b7Lp5rPtWsYb4NA7/ruXRzbhKUoG3vhaiePhuVjiPvbe/XdIF2UEtRE?=
 =?us-ascii?Q?HtIqkOeKAv/beoQUHkEz14m1cCnC+aLW7xurTrTWlDZgVCx+F4f7WcjgTFF1?=
 =?us-ascii?Q?Bcvl6Y/Xqd/i5Cx6WdHoJqZnaLwHmELYLo3LTj/kvw04RWI4iRtOFOrjFYDL?=
 =?us-ascii?Q?wqQHO+UfdTzskeVUQO15WMlWPDneotsxrpkBYrkzsluYFCleRzNcPHz/LzYu?=
 =?us-ascii?Q?6hFs4+X8MsvKM+9efCLdyaWJPL74KROLNav2QZOmWakA0DnsVitwDj9/ytTA?=
 =?us-ascii?Q?8OISOBGX33Y87Fgg5jYH78ekPFsNydl2hljUI8HCExIVv/wPIWJlDJHM4cKe?=
 =?us-ascii?Q?rdE83MPfdjkFCLnFxRBS00qkfhAwqtr4qU4FwY/eZuVzzrENreaUlBiyMOMA?=
 =?us-ascii?Q?HE83qd67v3Hi2WfZawqBOb1Y9A66k/7Fk7QJhmvD71UBph3EblQdRp2aoVQ/?=
 =?us-ascii?Q?IrBD9MpHhOvVzu4/MvbgxbNEQcE23y9V2OyK1BCfcmMlrknxlONbXMzz1b9/?=
 =?us-ascii?Q?Sjk4IBLerZJ3ZK2LwUXt6CAYYgSI3/fl4O2TzOTc3b5AW3O822MspWuUEk5+?=
 =?us-ascii?Q?3rbZVTyj43PvQwqKnfmjD5Dh7UpLc6I1O6YJqjdStVcByBnnCE7ErkzlyVdD?=
 =?us-ascii?Q?4hS/B/ag4FpaxPhaFjPOmI9Tyu/LaKvwvtf1Ut9conXoCRHVrcDA/vtngFoL?=
 =?us-ascii?Q?fSqLwnWzTA6fYdPefZrBEbFlcGoRM//aqBrU4eUhObKROIZr7D3AiZduzwof?=
 =?us-ascii?Q?asGg8T4Cwu2QLbw5ZHnFvMHEmKoLYc0yCkheSXCIjqu6iGtjo5wgeeZ5bRjK?=
 =?us-ascii?Q?r1UMyPkLZmBpFT7BpaTa7fUGOYUT4whObxk1jbM5ne7FdbV8LIGExHNmVaSi?=
 =?us-ascii?Q?e40b0ETe6LMjjxZmMaWsLlUm4c89havwJQRmrFp0dzjYn6Bx0warAsA5eU6o?=
 =?us-ascii?Q?87TXVURfEZwLCJ+tdqYbPgl5Laeud+gIa8oxt2uxGpxFBKgYqa09y6aiqUBV?=
 =?us-ascii?Q?kTFMV7iOnG1JGMRH87Rr91ix8zeMHx8Po7h5Ua5KZvappyqiPrVMBzN/XcRg?=
 =?us-ascii?Q?z4aUB0QJm9oFet7UIXbPHYyozg0LnxWaG6+5RJKbwsWujvgatY/Hyr4IOLCy?=
 =?us-ascii?Q?g2+mwj5Z9EB9/taf0XZEC35tIIr0PXuZi6RVbqo6saj2DjsaO3wmlEx0vYBS?=
 =?us-ascii?Q?UFoYMY8pCw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a432e42-691c-4c8e-e876-08df32157665
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2026 21:26:27.3032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsJ1XTjRthFmttTGDy5u6iePBvsyEZyoLn1hb65n0HEb/6ISWtZj+H4PGD5M/pRcHokmy/z02pfNOmgGo71oYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6642

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
 tools/perf/Documentation/perf-ftrace.txt |   1 +
 tools/perf/builtin-ftrace.c              |  34 +++++++-
 tools/perf/tests/ftrace.c                | 104 ++++++++++++++++++++++-
 tools/perf/util/ftrace.c                 |  25 ++++--
 tools/perf/util/ftrace.h                 |   1 +
 5 files changed, 154 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 0af6b0c1f134..ed2e45b8507f 100644
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
index 1f652d1e2754..db9616ad68af 100644
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
@@ -1785,6 +1811,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 		{ .name = "retaddr",		.value_ptr = &ftrace->graph_retaddr },
 		{ .name = "nosleep-time",	.value_ptr = &ftrace->graph_nosleep_time },
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
+		{ .name = "noduration",		.value_ptr = &ftrace->graph_noduration },
 		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
 		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
 		{ .name = "depth",		.value_ptr = &ftrace->graph_depth },
@@ -1874,7 +1901,7 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>",
+		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,noduration,verbose,thresh=<n>,depth=<n>,tail",
 		     parse_graph_tracer_opts),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", parse_buffer_size),
@@ -2073,6 +2100,11 @@ int cmd_ftrace(int argc, const char **argv)
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
index 457ab6eebbb2..b738f04da13c 100644
--- a/tools/perf/tests/ftrace.c
+++ b/tools/perf/tests/ftrace.c
@@ -160,6 +160,18 @@ static int test_inline_processing(void)
 		" 1234.567890 |   0)   bash-1234    |  ....   |               |    activate_task() { /* (inline) */";
 	static const char line_verbose_inline_exit[] =
 		" 1234.567890 |   0)   bash-1234    |  ....   |               |    } /* activate_task (inline) */";
+	static const char line_verbose_nodur_entry[] =
+		" 1234.567890 |   0)   bash-1234    |  ....   |  wake_up_new_task() {";
+	static const char line_verbose_nodur_enqueue[] =
+		" 1234.567890 |   0)   bash-1234    |  ....   |    enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */";
+	static const char line_verbose_nodur_exit_enqueue[] =
+		" 1234.567890 |   0)   bash-1234    |  ....   |    } /* enqueue_task */";
+	static const char line_verbose_nodur_exit_task[] =
+		" 1234.567890 |   0)   bash-1234    |  ....   |  } /* wake_up_new_task */";
+	static const char line_verbose_nodur_inline_entry[] =
+		" 1234.567890 |   0)   bash-1234    |  ....   |    activate_task() { /* (inline) */";
+	static const char line_verbose_nodur_inline_exit[] =
+		" 1234.567890 |   0)   bash-1234    |  ....   |    } /* activate_task (inline) */";
 	struct perf_ftrace ftrace;
 	char *out_buf = NULL;
 	size_t out_len = 0;
@@ -497,6 +509,33 @@ static int test_inline_processing(void)
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
@@ -845,20 +884,56 @@ static int test_column_layouts(void)
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
 			" 1234.567890 |   7)   bash-1234    |  ....   |               |  wake_up_new_task() { /* <-kernel_clone+0x160/0x510 */",
 			" 1234.567890 |   7)   bash-1234    |  ....   |               |  wake_up_new_task() {\n",
 		},
+		{
+			"verbose noduration layout", true, true,
+			" 1234.567890 |   7)   bash-1234    |  ....   |  wake_up_new_task() { /* <-kernel_clone+0x160/0x510 */",
+			" 1234.567890 |   7)   bash-1234    |  ....   |  wake_up_new_task() {\n",
+		},
+		{
+			"noduration context switch marker", true, false,
+			"   7)  bash-1234    =>  sh-5678",
+			"   7)  bash-1234    =>  sh-5678\n",
+		},
+		{
+			"noduration irq entry marker", true, false,
+			" 7) ==========>",
+			" 7) ==========>\n",
+		},
+		{
+			"noduration irq exit marker", true, false,
+			" 7) <==========",
+			" 7) <==========\n",
+		},
+		{
+			"verbose noduration irq entry marker", true, true,
+			" 1234.567890 |   7)   bash-1234    |  ....   | ==========>",
+			" 1234.567890 |   7)   bash-1234    |  ....   | ==========>\n",
+		},
+		{
+			"verbose noduration irq exit marker", true, true,
+			" 1234.567890 |   7)   bash-1234    |  ....   | <==========",
+			" 1234.567890 |   7)   bash-1234    |  ....   | <==========\n",
+		},
 	};
 	struct perf_ftrace ftrace;
 	char *out_buf = NULL;
@@ -869,6 +944,7 @@ static int test_column_layouts(void)
 	for (i = 0; i < ARRAY_SIZE(cases); i++) {
 		memset(&ftrace, 0, sizeof(ftrace));
 		ftrace.use_inline = true;
+		ftrace.graph_noduration = cases[i].noduration;
 		ftrace.graph_verbose = cases[i].verbose;
 
 		out = open_memstream(&out_buf, &out_len);
@@ -889,6 +965,28 @@ static int test_column_layouts(void)
 		out_buf = NULL;
 	}
 
+	/* Test noduration IRQ markers do not pop active frames from tracked stack */
+	memset(&ftrace, 0, sizeof(ftrace));
+	ftrace.use_inline = true;
+	ftrace.graph_noduration = true;
+	ftrace_cpu_states__clear();
+
+	out = open_memstream(&out_buf, &out_len);
+	if (!out)
+		return TEST_FAIL;
+
+	ftrace_process_fgraph_line(&ftrace, " 0)  root_func() {", out);
+	ftrace_process_fgraph_line(&ftrace, " 0) ==========>", out);
+	ftrace_process_fgraph_line(&ftrace, " 0) <==========", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)  } /* root_func */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	TEST_ASSERT_VAL("noduration irq markers preserved stack",
+			strstr(out_buf, " 0)  } /* root_func */\n") != NULL);
+	free(out_buf);
+
 	return TEST_OK;
 }
 
diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
index 746e966b4049..72c3fddd93bc 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -656,6 +656,9 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
 	memcpy(buf, line, len);
 	buf[len] = '\0';
 
+	if (ftrace->graph_noduration)
+		return;
+
 	if (*pipe_char == '|') {
 		if (ftrace->graph_verbose) {
 			/* In verbose mode, duration starts after the comm-pid '|' */
@@ -694,10 +697,12 @@ static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line
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
@@ -751,9 +756,14 @@ static const char *find_func_column(const struct perf_ftrace *ftrace,
 			return NULL;
 	}
 
-	p = strchr(p + 1, '|');
-	if (!p)
+	if (!ftrace->graph_noduration) {
+		p = strchr(p + 1, '|');
+		if (!p)
+			return NULL;
+	} else if (strstr(p, " => ") || strstr(p, "=====>") || strstr(p, "<=====")) {
+		/* Context switch or interrupt marker */
 		return NULL;
+	}
 
 	*cpu = (int)val;
 	return p;
@@ -849,11 +859,12 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 	func_start = skip_spaces(after_pipe);
 	leading_spaces = func_start - after_pipe;
 
-	if (*func_start == '\0')
-		return print_line(ftrace, line, out);
-
 	is_exit = (*func_start == '}');
 
+	if (*func_start == '\0' ||
+	    (!isalpha(*func_start) && *func_start != '_' && !is_exit))
+		return print_line(ftrace, line, out);
+
 	if (is_exit) {
 		char exit_name[128];
 
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 7b9e0919ae8d..0afaa9695691 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -39,6 +39,7 @@ struct perf_ftrace {
 	int			graph_retaddr;
 	int			graph_nosleep_time;
 	int			graph_noirqs;
+	int			graph_noduration;
 	int			graph_verbose;
 	int			graph_thresh;
 	int			graph_tail;
-- 
2.55.0

