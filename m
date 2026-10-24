Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.136
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792877180;
	b=k2bvJkzavmRC7TtjkqpqxSMuP4wTejpoXnDCMnjib6S6i7Ud61Y2gKzXExD/ZxUi/5SR
	 DApA9XcyCszGLcdkl6aWCaiXFTpMOTmHa11G3FYBz+ovDGUwTf9kd9itxvGU8Jm7PyhgT
	 bQJuCtnvkNO/1K+PXOvGDTdJPBGivy3ZJ/svdZuBOD+LTyaHqe0BmZ8qhyfwF/V9u9yjq
	 ddPKzvczT7TCbTolLc3YbLZ/xh3mWaQ/X3GgmVp6EEa4Jg5wQSDWGHpR65qkTZPv24akP
	 cImy4vYJ4jpW2+bkAXUE7z2dU8DFLKafbZoe+ihSaFQ6enQEEzXW/q7yV7/kPfwPY4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877180;
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
	bh=BuvfpvQt4HM4oaEJOlNsX0Ob1XIZDsY9QfHqYnEKp44=;
	b=gKjqEOJUFPRidMNgaOB6LVxlGUAKD+m5jyGSDNSIrb4gvK/VKhuFHeY5hELFFHGsYXQ6
	 etJZ7edEloyL9LHUeesrOIOCIVKqWgl1Nyr0qcrTPDkQFVyhQ+EyuDuMmoVJt7JwYwSRv
	 +K9D6A1L7eTrlDLYGMPhM5Rib2+08i0rm7hmsnDFsX0E/91nu+QgdvHgQsnufXDNLkrNn
	 G1nQYtvhEjBwxiPnvfN7iUs9/3mkwKHekDqwe25q8LF0w/Bh0Otog/AvTpfJ7s+On1K9u
	 FMxQRgE2cXXzCeAcSB/Eqy2n2cnwF6PXUFzrDKodUsKym++2lNtWshAeOWMJByqIFYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.136
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021136.outbound.protection.outlook.com [52.101.95.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1964A606A320;
	Sat, 24 Oct 2026 21:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1964A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Si5G+c62hphU7DbfA/kSeGptTwbKI9NRf3Enbg0SgrZiZr33LONIbr+afN58oO6qweVCNUlz4G7juaToeCHZP+NTdD3LkxXpNduhmYCfsfDRPps9MzVDJWF/WMxNoqO2IuZI6a+e+4zAXvL+zGBtUmtlXSZ6kLnOFq2miuYVLc+dA45EG6JvkYFoap/LP2n5zA+zLCsgklqpvji/AOCDK3wIcS4igFmiXRk2v01eSDmv7y0Gcq7ymU0kFV3E7TrbPiQNr6iyMv2ligQJgZXTs81dHyL1H2e8kFMjHofpPNVyicZauiUL7cJwfNSSzj43Ei/GRRS4+Bn9ic5pn7Ovng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=BuvfpvQt4HM4oaEJOlNsX0Ob1XIZDsY9QfHqYnEKp44=;
 b=dJFmjM9kMQuC9v0h8GKCq9DhoituYNLw7sZFri0PvUFnVMKt6TYN01noEcpMfRfF54VOzaofdrzU/H858zQQaxZst/2yQGDV08Dy2+WY8qKMU2AY6ndC0D8QtZMNlkL7erttI3Pxv0rZTB7XCdxWdB+GaVZONaQw28jRpou6dfYaYinr4yL7lMgQycFLSOq2BsMzhnNbU9ZylCHzTUdJVI5mKVOz+kduuHW45/z5YJG3bVdXGqv9Gp8jYLpjxD4N37yN0rwLCICQqhvmvVJfDRgR7uVYpGcIGiwo9p8FWsfyo36Lni+nNPb+LxgtTb6m+4rLlvdfb6xAgY+8UWb6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6642.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:273::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Sat, 24 Oct
 2026 21:26:16 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Sat, 24 Oct 2026
 21:26:16 +0000
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
Subject: [PATCH perf-tools-next v10 06/10] perf ftrace: Support display of inlined functions in function graph tracer
Date: Sat, 24 Oct 2026 17:25:45 -0400
Message-ID: <20261024212549.450634-7-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261024212549.450634-1-atomlin@atomlin.com>
References: <20261024212549.450634-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0875.namprd03.prod.outlook.com
 (2603:10b6:408:13c::10) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 1aea390b-976f-4e57-338b-08df32156f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|6133799003|3023799007|56012099006|5023799004|261022115727099003|10067099003|261009223027099003|261021130227099003|261022105027099003|261021123027099003|261021121427099003|261021135927099003|261022075727099003|261022113327099003|261021133027099003;
X-Microsoft-Antispam-Message-Info:
	UyW26yhz103zKuBI0Osdu/4w6cV2XEfm0q9Rvv4w6Adz+N+OqalfcKDtT7QYa7mp0iHnRtTlpava6Rha7g8sTW6BwjfsNBAjDgiRROdjNYh0SDfQU5u/GWJTbWlkVCbxNSPRvE9j8M/HVODAx+vsVqkGh8KKq5t8gTSXgGWt5lABiCgRhdjOS2HUaDe1Ajknel6bAQWRPrVRsojl807od5ePAv1sAi4Vt7wxa+N1EVfRMua9XaYG02o13sHFqm7IKH9toLYkCb6AMIEQFSVPTJ8EO0bMV/qgbboUsmIyhnNpsT5jyEjgLW47E6uTp+ZtryCV4M9A//aOXJZKLDrRyXNbz0lFA1FwZI0dZtTUMXQKQLQLel0YqvVbLF0nVUfJuTeaeO15hwB6P0G4373C6tEqI9jVtxdWt2A4ZC6gvBHG5gwVB8QfICZS2bRheeXTlCwDSFZgM6A2xAOo6sAkEjdPzJPgVdLSWu7vpE8IAXzDqI4UcIBSXLoZ5Ct7cjVv7IwAvarRj39ymTtofqMngTIfQQnN5970MdwUvQfgMAzybyJjbyIQJuNuaBfVkKbwPSBCjqfro9J9QqLeuEPFMWSdVcHf0ANQV/FMm5XUYweVRK/QGOIFo4RZC2feEOIX09iUiSceP77/2Zas+Yt32Q1HE3Q2jvYWpyqqr/IO/PQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(5023799004)(261022115727099003)(10067099003)(261009223027099003)(261021130227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261021135927099003)(261022075727099003)(261022113327099003)(261021133027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zIkxK4r/amxvExTUh5+PC96DoPHeX74gUhXj3zZcPi+Lzlwpakl0o9gy8y/G?=
 =?us-ascii?Q?2zIn/JGUGL0qI6i0arXgZIm6beK73RvUf/XdPgs2qpgA8tskrgXyDn14wfUi?=
 =?us-ascii?Q?HUWV8h11ISWcBMOndX/KNs0+pcxNhVF44tq/knDFR0CyoymfQz1EplOgdKuq?=
 =?us-ascii?Q?L4Bzl37qFCExuQN6oMbzOvljbrfac7fkLzHDAPI2RV68fe6jir3uiM5tBKG3?=
 =?us-ascii?Q?ws9v8K0N4XYlAN2isrQNxYNP4vwrKgL6rnq1zuQKY4CyBAc8MLNJaOGty459?=
 =?us-ascii?Q?UFfWLdjniM0Bin/NwDwCWKLmfYxpfb8Ydy6WkHD8xnT+AQSSlQMAFMcUCfZw?=
 =?us-ascii?Q?i02JISgTNKqHoYFJF9JI2Lu2ofFpXhdZOmMWxgFf4SlUoTgAe5JTrg0KuSXJ?=
 =?us-ascii?Q?oFjCSJqJXQD33qurB0JvkFNWldknwjIc1no5/DmuOvckvcUdaERsDOvEbr6j?=
 =?us-ascii?Q?ZcxMckq4pqd0D5kWTO8l3iCnhsAKagTgr7QBt5dEO6DDiQ/WiHIAErJiyNik?=
 =?us-ascii?Q?/RIZy0WmG/4Hu62tYyygkckczRFUoPHyDfeF4GgHbk+Ks1Wfvbzs3XhiqBY2?=
 =?us-ascii?Q?BVZI9m3szRdRubpxVvdbGgbtV8LfG8R290CND2G5wcAHzgIzKKNCfujPYXex?=
 =?us-ascii?Q?zRPxLHG7cxSKzMdoReZZdlqTvGav8xHKjd/3dMOSjtdVQO5mle+c/Nv2I28g?=
 =?us-ascii?Q?QAeHseyc/qEs8JosrynzrRdP7aoTe1Jw9WCacmpiBRmo4fnSAOKVawrhtNWD?=
 =?us-ascii?Q?Dqip0LvVTNcFK3NtgF4+O/9lAEr6PqLKD7k8b5ZVfbGHdVZkkDEnUMmy9uWB?=
 =?us-ascii?Q?r7V7f+HUn34nhKcenY2lDnUJKL4lf60bwxZV+6dR+xf+3PAkwaKzAwV/9lJA?=
 =?us-ascii?Q?+lDm7U19PB5VBiWIDmvdBDmPzx7CYNk9kKqn/H43RWXygUzPlREuLL7EdQvF?=
 =?us-ascii?Q?apgogD+FBqgNcrqdEVnfGzHTl6EG/J+IGPs5rLaR09JXyQptyQxIC4yVry/+?=
 =?us-ascii?Q?priLGnx4jUOR953XVgNQXXpJu/q1zwjJmeNI0KrlLLvrsBjlxRUVmvgFLke1?=
 =?us-ascii?Q?D6elve9iB8qTyt76uUwjthyxJnoERFjsQd4ZXqTeCrsyQb97GKc58TlBRCMD?=
 =?us-ascii?Q?gC+h31pnPcM7fJvG+dorVzUT1idxFrB+z4fw0psjSw+kHYi8Di0W3LTCU/Ss?=
 =?us-ascii?Q?LtEjo7HofxyuuNDxb4pNQzDu9EYo9VI+SVcjSLg5haHyU7SHsssRbzSwjKs6?=
 =?us-ascii?Q?iTkc9ybezLCkB9soXaxy2nAIbGGD4G5qjNCF8MAi+PWZdYgH+QcWe6Q1ws9Y?=
 =?us-ascii?Q?ouiS4INIBVh4rQ6nwgSPPaGdBau8Z7PHY0OZ8uu104ByY4GSd+uodvhfAr67?=
 =?us-ascii?Q?ze2iEwf227ikjyydv/A6WdsM5maSP3ADEOSOoSUSh1SS62zRgUlg6mT8V6eg?=
 =?us-ascii?Q?RH4W5dZvDgbuwd+U4V4A7rfSYVNDAc52XLZbSfKPqA1ZGCp9Sw/u/kgmIcni?=
 =?us-ascii?Q?C4YOMGxvaPMMRFWX0VKDD9kvOj4DOFVGXLSDvQt1uzxLZNHLUoHPnyQd7OrL?=
 =?us-ascii?Q?kha8iUI7crOllAQPhd/NJ7fQBFL8m1k7ErEStgaf+4cQ0GZHfD76Me/9KyYw?=
 =?us-ascii?Q?IbYKGWkCaEj5QP2kTSxYsxUt4+wh0EC0iW1aPnwLmKWOgbZGzAkTVxHUjsOu?=
 =?us-ascii?Q?BCEo6maGxdpnuIsFARIKxLlMAcnlhSi3kF3vZ/wJVJzlhHcSXLzQMDn6h61X?=
 =?us-ascii?Q?1niZfzZzQw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aea390b-976f-4e57-338b-08df32156f92
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2026 21:26:15.9228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sAC6qwWZMIfP0TOFn8RBIG8uFtd8/uyfKMaZ6hZzfN6HJf2BG549zyMhe8mkq/W7JmUBJTyfEuRPmurlqJeGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6642

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

    1.  DWARF inline resolution

        Implement ftrace_resolve_inlines() using libdw to locate inlined
        subroutines at the instruction address corresponding to the
        caller's return address.

        Implement perf_ftrace__setup_inlines() and
        perf_ftrace__cleanup_inlines() to initialise machine symbol
        tracking, load vmlinux symbols, and verify kernel
        CONFIG_FUNCTION_GRAPH_RETADDR support.

    2.  Inline frame synthesis

        In ftrace_process_fgraph_line(), when --inline is active:
            - Interrogate return addresses using ftrace_parse_retaddr()
              and resolve inlines via ftrace_resolve_inlines().

            - Identify common inlined ancestors on the tracked stack and
              unwind inactive frames.

            - Open new inlined frames with /* (inline) */ and indent by
              inlined_depth * 2.

            - On function exit, close matching inlined frames with
              } /* func (inline) */.

    3.  Command-line options and documentation

        Add --inline and -k/--vmlinux options in
        tools/perf/builtin-ftrace.c and document their usage in
        tools/perf/Documentation/perf-ftrace.txt.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  13 +
 tools/perf/builtin-ftrace.c              |  27 +-
 tools/perf/util/ftrace.c                 | 623 ++++++++++++++++++++---
 tools/perf/util/ftrace.h                 |  36 +-
 4 files changed, 597 insertions(+), 102 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 3f3808e513fe..0af6b0c1f134 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -134,6 +134,19 @@ OPTIONS for 'perf ftrace trace'
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
+-k::
+--vmlinux=::
+	Path to the vmlinux file containing debug symbols for resolving
+	inlined functions.
 
 OPTIONS for 'perf ftrace latency'
 ---------------------------------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index e3909cff287b..1f652d1e2754 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -575,9 +575,14 @@ static int set_tracing_funcgraph_retval(struct perf_ftrace *ftrace)
 
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
@@ -771,6 +776,9 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 		goto out_reset;
 	}
 
+	if (perf_ftrace__setup_inlines(ftrace) < 0)
+		goto out_reset;
+
 	setup_pager();
 
 	buf = malloc(TRACE_BUF_SIZE);
@@ -916,7 +924,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	free(buf);
 	strbuf_release(&linebuf);
 out_reset:
-	ftrace_cpu_states__clear();
+	perf_ftrace__cleanup_inlines(ftrace);
 	exit_tracing_instance();
 out:
 	return (ret == 0 && done && !workload_exec_errno) ? 0 : -1;
@@ -1872,6 +1880,10 @@ int cmd_ftrace(int argc, const char **argv)
 		     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", parse_buffer_size),
 	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
 		    "Trace children processes"),
+	OPT_BOOLEAN(0, "inline", &ftrace.use_inline,
+		    "Show inlined functions in function_graph tracer"),
+	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name, "file",
+		   "vmlinux pathname"),
 	OPT_INTEGER('D', "delay", &ftrace.target.initial_delay,
 		    "Number of milliseconds to wait before starting tracing after program start"),
 	OPT_PARENT(common_options),
@@ -1987,6 +1999,15 @@ int cmd_ftrace(int argc, const char **argv)
 
 	switch (subcmd) {
 	case PERF_FTRACE_TRACE:
+		select_tracer(&ftrace);
+
+		if (ftrace.use_inline) {
+			if (strcmp(ftrace.tracer, "function_graph") != 0) {
+				pr_err("Error: --inline option is only supported with function_graph tracer\n");
+				ret = -EINVAL;
+				goto out_delete_filters;
+			}
+		}
 		cmd_func = __cmd_ftrace;
 		break;
 	case PERF_FTRACE_LATENCY:
diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
index fea61a9e17b1..746e966b4049 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -1,23 +1,60 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/compiler.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/zalloc.h>
-#include <linux/hash.h>
-#include <linux/list.h>
-#include <stdbool.h>
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
-#include <errno.h>
+#include <stdbool.h>
 #include <sys/types.h>
+#include <linux/kernel.h>
+#include <linux/zalloc.h>
+#include <linux/hash.h>
+#include <linux/list.h>
+#include <linux/string.h>
 #include "debug.h"
+#include "dso.h"
 #include "evlist.h"
+#include "machine.h"
+#include "map.h"
+#include "srcline.h"
+#include "symbol.h"
 #include "util/ftrace.h"
-#include "util/string2.h"
 #include <perf/threadmap.h>
 
+#define FTRACE_MAX_CPUS 4096
+#define FTRACE_MAX_STACK 256
+#define FTRACE_PID_HASH_BITS 10
+#define FTRACE_PID_HASH_SIZE (1 << FTRACE_PID_HASH_BITS)
+
+#define FTRACE_IDLE_PID(cpu)       ((pid_t)(-1 - (cpu)))
+#define FTRACE_UNKNOWN_PID(cpu)    ((pid_t)(-1 - FTRACE_MAX_CPUS - (cpu)))
+
+struct ftrace_stack_frame {
+	char *name;
+	bool inlined;
+	int indent;
+	int raw_indent;
+};
+
+struct ftrace_task_state {
+	struct hlist_node node;
+	pid_t pid;
+	struct ftrace_stack_frame *stack;
+	int max_stack;
+	int depth;
+	int inlined_depth;
+	int overflow_depth;
+	u64 seq;
+	int min_raw_indent;
+};
+
+#define ftrace_cpu_state ftrace_task_state
+
 static struct hlist_head ftrace_task_hash[FTRACE_PID_HASH_SIZE];
 static struct ftrace_task_state *ftrace_cpu_tasks[FTRACE_MAX_CPUS];
 static u64 ftrace_event_seq;
@@ -25,8 +62,9 @@ static u64 ftrace_event_seq;
 /**
  * ftrace_cpu_states__clear - Free allocated CPU and task stack states
  *
- * Free all memory associated with the per-task stack tracking states,
- * including the strings allocated for stack frames.
+ * Free all memory associated with the per-task stack tracking states
+ * used for inlined function resolution, including the strings
+ * allocated for stack frames.
  */
 void ftrace_cpu_states__clear(void)
 {
@@ -69,6 +107,32 @@ static struct ftrace_task_state *find_task_state(pid_t pid)
 	return NULL;
 }
 
+/**
+ * ftrace_task_state__grow_stack - Double the capacity of a task's call stack
+ * @cs: Task state whose stack should be resized
+ *
+ * Reallocate @cs->stack with twice the current capacity, zero-initialising
+ * the newly allocated frames.
+ *
+ * Return: 0 on success, or -ENOMEM if memory allocation fails.
+ */
+static int ftrace_task_state__grow_stack(struct ftrace_task_state *cs)
+{
+	int new_max = cs->max_stack ? cs->max_stack * 2 : FTRACE_MAX_STACK;
+	struct ftrace_stack_frame *new_stack;
+
+	new_stack = realloc(cs->stack, new_max * sizeof(*new_stack));
+	if (!new_stack) {
+		pr_err("Not enough memory to resize ftrace stack\n");
+		return -ENOMEM;
+	}
+
+	memset(new_stack + cs->max_stack, 0, (new_max - cs->max_stack) * sizeof(*new_stack));
+	cs->stack = new_stack;
+	cs->max_stack = new_max;
+	return 0;
+}
+
 /**
  * get_task_state - Get or allocate stack state for a given task PID
  * @pid: Process ID of the task
@@ -88,12 +152,10 @@ static struct ftrace_task_state *get_task_state(pid_t pid)
 	if (!ts)
 		return NULL;
 
-	ts->stack = calloc(FTRACE_MAX_STACK, sizeof(*ts->stack));
-	if (!ts->stack) {
+	if (ftrace_task_state__grow_stack(ts) < 0) {
 		free(ts);
 		return NULL;
 	}
-	ts->max_stack = FTRACE_MAX_STACK;
 
 	ts->pid = pid;
 	ts->min_raw_indent = -1;
@@ -103,32 +165,6 @@ static struct ftrace_task_state *get_task_state(pid_t pid)
 	return ts;
 }
 
-/**
- * ftrace_task_state__grow_stack - Double the capacity of a task's call stack
- * @cs: Task state whose stack should be resized
- *
- * Reallocate @cs->stack with twice the current capacity, zero-initialising
- * the newly allocated frames.
- *
- * Return: 0 on success, or -ENOMEM if memory allocation fails.
- */
-static int ftrace_task_state__grow_stack(struct ftrace_task_state *cs)
-{
-	int new_max = cs->max_stack ? cs->max_stack * 2 : FTRACE_MAX_STACK;
-	struct ftrace_stack_frame *new_stack;
-
-	new_stack = realloc(cs->stack, new_max * sizeof(*new_stack));
-	if (!new_stack) {
-		pr_err("Not enough memory to resize ftrace stack\n");
-		return -ENOMEM;
-	}
-
-	memset(new_stack + cs->max_stack, 0, (new_max - cs->max_stack) * sizeof(*new_stack));
-	cs->stack = new_stack;
-	cs->max_stack = new_max;
-	return 0;
-}
-
 /**
  * ftrace_task_state__rekey - Reassign a task state to a new PID
  * @ts: The task state to re-key
@@ -377,7 +413,7 @@ static bool parse_context_switch(const char *line)
 	 * If no context switch was seen previously on this CPU, its initial
 	 * pre-banner trace records were accumulated under an unknown synthetic
 	 * PID. Re-key that state to real_prev so the initial task's stack and
-	 * frames are preserved when it schedules back in.
+	 * inlined frames are preserved when it schedules back in.
 	 */
 	if (ftrace_cpu_tasks[cpu_val] &&
 	    ftrace_cpu_tasks[cpu_val]->pid == FTRACE_UNKNOWN_PID(cpu_val)) {
@@ -473,6 +509,80 @@ void ftrace_filter_retaddr(char *str)
 	memmove(start, end, strlen(end) + 1);
 }
 
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
+	int j;
+
+	if (!machine || !offset)
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
+	ip = sym->start + offset - 1;
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
+				if (!name) {
+					for (j = 0; j < count; j++)
+						free((void *)inlined_names[j]);
+					map__put(map);
+					return -ENOMEM;
+				}
+				inlined_names[count++] = name;
+			}
+		}
+	}
+
+	map__put(map);
+	return count;
+}
+
 /**
  * extract_entry_func_name - Extract the function name from an entry record
  * @str: The trace line's function column string
@@ -519,6 +629,58 @@ static void extract_exit_func_name(const char *str, char *buf, size_t size)
 	buf[i] = '\0';
 }
 
+/**
+ * make_blank_prefix - Create a blank prefix mirroring a trace record's context
+ * @ftrace: Perf ftrace context
+ * @line: The original trace record
+ * @pipe_char: Pointer to the final delimiter character of the context columns
+ * @buf: Buffer to store the blank prefix
+ * @size: Size of the @buf
+ *
+ * Generate a prefix matching the context columns of @line (e.g. CPU, duration)
+ * but with the duration field replaced by spaces.
+ */
+static void make_blank_prefix(const struct perf_ftrace *ftrace, const char *line,
+			      const char *pipe_char, char *buf, size_t size)
+{
+	size_t len = pipe_char - line + 1;
+	const char *start_delim = NULL;
+	char *c;
+
+	if (!size)
+		return;
+
+	if (len >= size)
+		len = size - 1;
+
+	memcpy(buf, line, len);
+	buf[len] = '\0';
+
+	if (*pipe_char == '|') {
+		if (ftrace->graph_verbose) {
+			/* In verbose mode, duration starts after the comm-pid '|' */
+			for (const char *p = pipe_char - 1; p >= line; p--) {
+				if (*p == '|') {
+					start_delim = p;
+					break;
+				}
+			}
+		} else {
+			/* In default mode, duration starts after CPU ')' */
+			start_delim = strchr(line, ')');
+		}
+
+		if (start_delim && start_delim < pipe_char && start_delim < line + len) {
+			char *end = buf + (pipe_char - line);
+
+			if (end > buf + len)
+				end = buf + len;
+			for (c = buf + (start_delim - line) + 1; c < end; c++)
+				*c = ' ';
+		}
+	}
+}
+
 /**
  * find_func_column - Locate the function call column in a trace record
  * @ftrace: Perf ftrace context
@@ -526,11 +688,16 @@ static void extract_exit_func_name(const char *str, char *buf, size_t size)
  * @cpu: Pointer to store the CPU number
  *
  * Locate the context columns that precede the function call column of a
- * function_graph trace record.
+ * function_graph trace record. Depending on the funcgraph-* options set
+ * up by perf, a record looks like:
+ *
+ *   [ abstime |]  CPU)  [ comm-pid |]  [ duration |]  func
+ *
+ * The abstime and comm-pid columns are only present with --graph-opts
+ * verbose.
  *
  * Return: A pointer to the last character of the context columns (the final
- * '|' delimiter, or the CPU ')' when no delimiter follows it). Returns NULL
- * if @line is not a trace record.
+ * '|' delimiter). Returns NULL if @line is not a trace record.
  */
 static const char *find_func_column(const struct perf_ftrace *ftrace,
 				    const char *line, int *cpu)
@@ -630,25 +797,40 @@ static int print_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
  * @line: The trace line to process
  * @out: File stream to output to
  *
- * Parse function entries and exits, maintain the task's call stack, and
- * output the trace line.
+ * Process a trace line from the function_graph tracer. If --inline is set,
+ * this function parses the return address comment, resolves it to its
+ * inlined callchain, and synthesises intermediate frames into the streamed
+ * call graph.
  *
  * Return: 0 on success, or a negative error code on failure.
  */
 int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
 {
+	char caller_sym[128];
+	char blank_prefix[128];
+	const char *inlined_names[FTRACE_MAX_INLINES];
 	const char *pipe_char;
 	const char *after_pipe;
 	const char *func_start;
-	struct ftrace_task_state *cs;
+	struct ftrace_cpu_state *cs;
+	u64 caller_offset = 0;
+	int num_inlines = 0;
 	int cpu = -1;
 	int leading_spaces;
-	int top_raw_indent;
+	int extra_indent;
+	int caller_idx;
+	int active_inlines;
+	int common;
 	int match_idx;
-	int i;
+	int top_raw_indent;
+	int i, j;
 	bool is_exit;
 	bool has_open_brace;
 	bool has_semicolon;
+	bool has_retaddr = false;
+
+	if (!ftrace->use_inline)
+		return print_line(ftrace, line, out);
 
 	pipe_char = find_func_column(ftrace, line, &cpu);
 	if (!pipe_char) {
@@ -661,6 +843,7 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 		return print_line(ftrace, line, out);
 
 	cs->seq = ++ftrace_event_seq;
+	make_blank_prefix(ftrace, line, pipe_char, blank_prefix, sizeof(blank_prefix));
 
 	after_pipe = pipe_char + 1;
 	func_start = skip_spaces(after_pipe);
@@ -681,20 +864,32 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
 		top_raw_indent = -1;
 		for (i = cs->depth - 1; i >= 0; i--) {
-			top_raw_indent = cs->stack[i].raw_indent;
-			break;
+			if (!cs->stack[i].inlined) {
+				top_raw_indent = cs->stack[i].raw_indent;
+				break;
+			}
 		}
 
+		/*
+		 * If currently overflowed beyond FTRACE_MAX_STACK, any exit whose
+		 * indentation is deeper than the top tracked frame belongs to the
+		 * overflow region.
+		 */
 		if (cs->overflow_depth > 0 &&
 		    (top_raw_indent < 0 || leading_spaces > top_raw_indent)) {
 			cs->overflow_depth--;
-			return print_line(ftrace, line, out);
+			extra_indent = cs->inlined_depth * 2;
+			fprintf(out, "%.*s%*s%s\n",
+				(int)(pipe_char - line + 1), line,
+				leading_spaces + extra_indent, "", func_start);
+			return 0;
 		}
 
+		/* Find matching frame on stack */
 		match_idx = -1;
 		if (exit_name[0] != '\0') {
 			for (i = cs->depth - 1; i >= 0; i--) {
-				if (cs->stack[i].name &&
+				if (!cs->stack[i].inlined && cs->stack[i].name &&
 				    cs->stack[i].raw_indent == leading_spaces &&
 				    strcmp(cs->stack[i].name, exit_name) == 0) {
 					match_idx = i;
@@ -703,9 +898,14 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 			}
 		}
 
+		/*
+		 * If bare brace ('}'), match the topmost non-inlined frame
+		 * with matching indentation.
+		 */
 		if (match_idx < 0 && exit_name[0] == '\0') {
 			for (i = cs->depth - 1; i >= 0; i--) {
-				if (cs->stack[i].raw_indent == leading_spaces) {
+				if (!cs->stack[i].inlined &&
+				    cs->stack[i].raw_indent == leading_spaces) {
 					match_idx = i;
 					break;
 				}
@@ -714,50 +914,327 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
 		if (match_idx >= 0) {
 			cs->overflow_depth = 0;
-			while (cs->depth > match_idx) {
+		} else if (cs->overflow_depth > 0) {
+			cs->overflow_depth--;
+			extra_indent = cs->inlined_depth * 2;
+			fprintf(out, "%.*s%*s%s\n",
+				(int)(pipe_char - line + 1), line,
+				leading_spaces + extra_indent, "", func_start);
+			return 0;
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
 				free(cs->stack[cs->depth - 1].name);
 				cs->depth--;
 			}
-		} else if (cs->overflow_depth > 0) {
-			cs->overflow_depth--;
+
+			extra_indent = cs->inlined_depth * 2;
+		} else {
+			extra_indent = 0;
 		}
 
-		return print_line(ftrace, line, out);
+		fprintf(out, "%.*s%*s%s\n",
+			(int)(pipe_char - line + 1), line,
+			leading_spaces + extra_indent, "", func_start);
+		return 0;
 	}
 
+	/* It's an entry or a leaf call */
 	has_open_brace = (strchr(func_start, '{') != NULL);
 	has_semicolon = (strchr(func_start, ';') != NULL);
 
 	top_raw_indent = -1;
 	for (i = cs->depth - 1; i >= 0; i--) {
-		top_raw_indent = cs->stack[i].raw_indent;
-		break;
+		if (!cs->stack[i].inlined) {
+			top_raw_indent = cs->stack[i].raw_indent;
+			break;
+		}
 	}
 
 	if (cs->overflow_depth > 0 && top_raw_indent >= 0 &&
 	    leading_spaces <= top_raw_indent)
 		cs->overflow_depth = 0;
 
+	if (ftrace_parse_retaddr(func_start, caller_sym, sizeof(caller_sym), &caller_offset)) {
+		has_retaddr = true;
+		num_inlines = ftrace_resolve_inlines(ftrace->machine, caller_sym,
+						      caller_offset, inlined_names,
+						      FTRACE_MAX_INLINES);
+		if (num_inlines < 0)
+			return num_inlines;
+	}
+
+	/* Determine which inlined frames are currently open above the caller */
+	caller_idx = -1;
+	if (has_retaddr && cs->overflow_depth == 0) {
+		for (i = cs->depth - 1; i >= 0; i--) {
+			if (!cs->stack[i].inlined && cs->stack[i].name &&
+			    cs->stack[i].raw_indent < leading_spaces &&
+			    strcmp(cs->stack[i].name, caller_sym) == 0) {
+				caller_idx = i;
+				break;
+			}
+		}
+	}
+
+	/* If caller is not on the tracked stack, do not synthesise inlines */
+	if (has_retaddr && caller_idx < 0) {
+		for (i = 0; i < num_inlines; i++)
+			free((void *)inlined_names[i]);
+		num_inlines = 0;
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
+	/* Close stale callee frames and inactive inlined frames above caller */
+	if (caller_idx >= 0)
+		cs->overflow_depth = 0;
+
+	while (caller_idx >= 0 && cs->depth > caller_idx + 1 + common) {
+		struct ftrace_stack_frame *top = &cs->stack[cs->depth - 1];
+
+		if (top->inlined) {
+			int exit_indent = top->indent;
+
+			if (cs->inlined_depth > 0)
+				cs->inlined_depth--;
+			fprintf(out, "%s%*s} /* %s (inline) */\n",
+				blank_prefix, exit_indent, "", top->name);
+		}
+		free(top->name);
+		cs->depth--;
+	}
+
+	if (caller_idx < 0 && cs->overflow_depth == 0) {
+		/*
+		 * If caller is not on the tracked stack, unwind any frames whose
+		 * raw indentation is greater than or equal to the new entry's
+		 * indentation (their exit events were dropped), and close any
+		 * trailing inlined frames that were left open from prior calls.
+		 */
+		while (cs->depth > 0) {
+			struct ftrace_stack_frame *top = &cs->stack[cs->depth - 1];
+
+			if (top->inlined) {
+				int exit_indent = top->indent;
+
+				if (cs->inlined_depth > 0)
+					cs->inlined_depth--;
+				fprintf(out, "%s%*s} /* %s (inline) */\n",
+					blank_prefix, exit_indent, "", top->name);
+				free(top->name);
+				cs->depth--;
+			} else if (top->raw_indent >= leading_spaces) {
+				free(top->name);
+				cs->depth--;
+			} else {
+				break;
+			}
+		}
+	}
+
+	/* Open new inlined frames */
+	for (i = common; i < num_inlines; i++) {
+		int entry_indent = leading_spaces + cs->inlined_depth * 2;
+
+		if (!inlined_names[i]) {
+			pr_err("Not enough memory\n");
+			for (j = 0; j < num_inlines; j++)
+				free((void *)inlined_names[j]);
+			return -ENOMEM;
+		}
+		if (cs->depth >= cs->max_stack &&
+		    ftrace_task_state__grow_stack(cs) < 0)
+			break;
+
+		fprintf(out, "%s%*s%s() { /* (inline) */\n",
+			blank_prefix, entry_indent, "", inlined_names[i]);
+		cs->stack[cs->depth].name = strdup(inlined_names[i]);
+		if (!cs->stack[cs->depth].name) {
+			pr_err("Not enough memory\n");
+			for (j = 0; j < num_inlines; j++)
+				free((void *)inlined_names[j]);
+			return -ENOMEM;
+		}
+		cs->stack[cs->depth].inlined = true;
+		cs->stack[cs->depth].indent = entry_indent;
+		cs->stack[cs->depth].raw_indent = -1;
+		cs->depth++;
+		cs->inlined_depth++;
+		cs->min_raw_indent = -1;
+	}
+
+	/* Print current line with updated indentation */
+	extra_indent = cs->inlined_depth * 2;
+
+	if (!ftrace->graph_retaddr) {
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
 	if (has_open_brace && !has_semicolon) {
 		char entry_name[128];
 
 		extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
 		if (cs->depth >= cs->max_stack &&
 		    ftrace_task_state__grow_stack(cs) < 0) {
-			cs->overflow_depth++;
-		} else {
-			cs->stack[cs->depth].name = strdup(entry_name);
-			if (!cs->stack[cs->depth].name) {
-				pr_err("Not enough memory\n");
-				return -ENOMEM;
-			}
-			cs->stack[cs->depth].inlined = false;
-			cs->stack[cs->depth].indent = leading_spaces;
-			cs->stack[cs->depth].raw_indent = leading_spaces;
-			cs->depth++;
-			cs->min_raw_indent = -1;
+			for (i = 0; i < num_inlines; i++)
+				free((void *)inlined_names[i]);
+			return -ENOMEM;
 		}
+
+		cs->stack[cs->depth].name = strdup(entry_name);
+		if (!cs->stack[cs->depth].name) {
+			pr_err("Not enough memory\n");
+			for (i = 0; i < num_inlines; i++)
+				free((void *)inlined_names[i]);
+			return -ENOMEM;
+		}
+		cs->stack[cs->depth].inlined = false;
+		cs->stack[cs->depth].indent = leading_spaces + extra_indent;
+		cs->stack[cs->depth].raw_indent = leading_spaces;
+		cs->depth++;
+		cs->min_raw_indent = -1;
 	}
 
-	return print_line(ftrace, line, out);
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
+	struct ftrace_task_state *ts;
+	pid_t single_pid;
+	int c;
+
+	if (!ftrace->use_inline)
+		return 0;
+
+	single_pid = ftrace__get_single_pid(ftrace);
+	if (single_pid > 0) {
+		ts = get_task_state(single_pid);
+		if (ts) {
+			for (c = 0; c < FTRACE_MAX_CPUS; c++)
+				ftrace_cpu_tasks[c] = ts;
+		}
+	}
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
+		if (!kmap ||
+		    dso__load_vmlinux(map__dso(kmap), kmap,
+				      symbol_conf.vmlinux_name, false) <= 0) {
+			pr_warning("Failed to load kernel image '%s'\n", symbol_conf.vmlinux_name);
+			goto out_delete_machine;
+		}
+	} else {
+		if (machine__load_vmlinux_path(ftrace->machine) <= 0) {
+			pr_warning("Failed to load vmlinux from search path\n");
+			goto out_delete_machine;
+		}
+	}
+
+	return 0;
+
+out_delete_machine:
+	machine__delete(ftrace->machine);
+	ftrace->machine = NULL;
+	return -1;
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
 }
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 00e7eb636083..7b9e0919ae8d 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -42,6 +42,8 @@ struct perf_ftrace {
 	int			graph_verbose;
 	int			graph_thresh;
 	int			graph_tail;
+	bool			use_inline;
+	struct machine		*machine;
 };
 
 struct filter_entry {
@@ -96,36 +98,18 @@ perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
 
 #endif  /* HAVE_BPF_SKEL */
 
-#define FTRACE_MAX_CPUS 4096
-#define FTRACE_MAX_STACK 256
-#define FTRACE_PID_HASH_BITS 10
-#define FTRACE_PID_HASH_SIZE (1 << FTRACE_PID_HASH_BITS)
+struct machine;
 
-#define FTRACE_IDLE_PID(cpu)       ((pid_t)(-1 - (cpu)))
-#define FTRACE_UNKNOWN_PID(cpu)    ((pid_t)(-1 - FTRACE_MAX_CPUS - (cpu)))
-
-struct ftrace_stack_frame {
-	char *name;
-	bool inlined;
-	int indent;
-	int raw_indent;
-};
-
-struct ftrace_task_state {
-	struct hlist_node	node;
-	pid_t			pid;
-	struct ftrace_stack_frame *stack;
-	int			max_stack;
-	int			depth;
-	int			inlined_depth;
-	int			overflow_depth;
-	u64			seq;
-	int			min_raw_indent;
-};
+#define FTRACE_MAX_INLINES 32
 
 bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset);
 void ftrace_filter_retaddr(char *str);
-void ftrace_cpu_states__clear(void);
+int ftrace_resolve_inlines(struct machine *machine,
+			   const char *sym_name, u64 offset,
+			   const char **inlined_names, int max_inlines);
 int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out);
+void ftrace_cpu_states__clear(void);
+int perf_ftrace__setup_inlines(struct perf_ftrace *ftrace);
+void perf_ftrace__cleanup_inlines(struct perf_ftrace *ftrace);
 
 #endif  /* __PERF_FTRACE_H__ */
-- 
2.55.0

