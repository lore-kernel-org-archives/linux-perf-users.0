Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.138
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793655691;
	b=vW5Mmv4uFc14AbInHMBaqPy2WS8wJvm2dM2Qc9NxkzWiyOWmuKvhAvwZaJqtR6s85B/P
	 sHxvd2n0twtcUgLrGXEAIU1D8XRz4LNrbxU68TbIahNHEm5oxeFYHyqxxlX7VNGWj6IvM
	 4RRvDbGHt11zf/IZcftTM9qBekmjdgAOBtWAJCMb0E9wJQLKZbtPxbh/dZgAiTWO8WLze
	 V0w2wbGu6hj+6mvbT20XDbdlXUFbBa8NufC7TT9Xgirr7IDIJkAnwrJJ61Gr76unDbhdR
	 ipovkh1CjJvakB6Ud1JkGMr3/xlJTDVlo1VMUt2YJHWAfVUe32DS3PYeg5Tw0Cqz/wA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655691;
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
	bh=x/hCB46QQ7tLc2aD4Rqtgt5E7Xg5AiHYe+MkWHN6Ai0=;
	b=VCyXv8/K2WvP3WbM07skdv8ObTLLD+HMP8TALr1Upi9gnfaQqXW6EufepSHilqS6fz2T
	 WPvod7n9yYlpIjjCB35PI0VEp8u5BzP+39QHS1CTai+F6uvZOMik6xM/+mAdMidZG9L6d
	 SwKz6dMQG9BNVqxwBgI0zg5T97POhBYS3Vu+GuQlg7LaNXXeRKW9BlsG3NKrofa55K+Jo
	 UniASu7HsTxP84y1NsizCeJws1DRV5Udihh7OhmonzLO2bF4FU/PO6qX3Re04qbxi8q7c
	 kaJ+9johEadHvRCHa/SybXJ/Ts5JSOUNnFLozu/ojU9OfWZb+AMb4CXWPB+RxhV0KpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.138
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021138.outbound.protection.outlook.com [52.101.95.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8019A606A32D;
	Mon,  2 Nov 2026 21:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8019A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qot+WEoeFiBk7YwsfFFBDlgyqFxyKlinh9qhOCmWdYwrXE3PdoQdDTPfRh++8v3B6vmOZaftlShX3r0QV81zuzatMxHuhUIf6zcDdkJPzHDW12ZmOCL5FybNVUD5LGHSxNUvwptTScOY5+h2cyRWUsjfK872kE6ZJjnPmhd3Xibsfift1h+3T3P83/9NVon0N7y2A3P+1OlSE5ld1VtYBGZkoRtBnPl+xJzu+vBXho5vlziqy8pBFsCIR/KS2ANVyaZHAPqyWtop8/38RyC0OlWuJRRyy/occGnCIKhUJ06B1+wItAP92QZlR9VyOgwpX3j9trQzDTFthrR2OZgXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=x/hCB46QQ7tLc2aD4Rqtgt5E7Xg5AiHYe+MkWHN6Ai0=;
 b=ZPUiNGIGWWtyDgImdrbgP1x7PF6h1XkQm2TEJH9YCchMJVGAFe+MtnF9V82/PKbhy4U73GQSwu+r/5NHXo+otaTW8Ivv98Ku9+Brc68Uomx67rbt3o1aM/bk6ducPOkSHIkUbLU03e9VXxp07tGkKCTQJTgQpwUCppSxG3aCx1Og6SK/nCS1fpP3Roo+afgIFxJYzd7QZm9eY3US2EUoUkRYbpLzbOT+d33Oau+5gOhVMaItEvcFtszzfAJmHRAbz0jR9QeL4mcrhUo+/vDUueYV15fJ55TI8jcN3SxlCQ/FWbIsBzrllSqYvMxSM5Addx3zZHOoTW03s1EFqJmItA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO9P123MB8506.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:41:26 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 21:41:26 +0000
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
Subject: [PATCH perf-tools-next v13 06/10] perf ftrace: Support display of inlined functions in function graph tracer
Date: Mon,  2 Nov 2026 16:40:50 -0500
Message-ID: <20261102214054.911298-7-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102214054.911298-1-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQ1P288CA0020.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::29) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LO9P123MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: eab61784-0acd-4a91-490e-08df392a0bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|261102123227099003|261021133027099003|261021130227099003|261021121427099003|5023799004|56012099006|261021135927099003|261009223027099003|261028144727099003|261026135527099003|261026140227099003|261022115727099003|261021123027099003|261022075727099003|261022105027099003|261026130827099003|261026121527099003|261022113327099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	hc/YGE5wJ/7ZSyVfZNDaOQ/xCYJ/bFLU4DkcBpq4bCs5UJhsA3sf6yTgFOLU7vjqYgyg+aKz/0eQ2qGeL2iBXgNjFdsLA3IOCAxUDp5kY5yA/bstfzWXveWev6MD89dZdn8lVYE9IMN3gUJYfERjY/Mx0/Z9TDrnVnD+aeDZKFiHESUVk1pUBJno2b/ah59/9iqFZhjBV4sLohEsY8kHJLxVl3SWmmCYKcptF81WlNL06b3L5Y2Tmfzxb6XazGq/zMkSWcZxOrwxfZ20JQPHQ8wOJ8Hm//Tt2PdRWmR3uX3btBipJ1aN4W1pR8/J938p2PhnUci3BD8boxieBoOfwKx21tPmxbptjko43PNIQxDEMBqTd0rG2u4TOAv9izKNBC+SDNXhe+8wlXT7DdTMjQ2kQfoHwAKYgeuKeM7AJJKf6i8VeWkZ1/f1fXO9A986srLZkqYZKlirmTydujOl2fdbmOCFSiQHH0m+6/F3KnZ3ql+Sy+SzmAJxeO3h1WTDFxOzUM5Bhw0Vt/7TSODk8R0O1Gk0THUpWUjz2qBNIb0rl3iQc+z+Z1HuFG5f22LL7qhy8L9STCHz3ltKo1Xryg84EQ9RkNg7pvMzfjPWCzl31P/eZaaHES5Fpssue9uBRVDcWQVDTMBfm/xzNYGEzYVb4GYo86Hxt6QymqD4z4w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(261102123227099003)(261021133027099003)(261021130227099003)(261021121427099003)(5023799004)(56012099006)(261021135927099003)(261009223027099003)(261028144727099003)(261026135527099003)(261026140227099003)(261022115727099003)(261021123027099003)(261022075727099003)(261022105027099003)(261026130827099003)(261026121527099003)(261022113327099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6k0+yJwbDJoS02eHt8CKuIM0VTMvKlMFgEcl1MRrk4/c76ssYASdnzdJzDdL?=
 =?us-ascii?Q?uw5bmG80k/uJU6OA0DIlQ96dkaEE2sj8DynDmF139pZDn5865pt0p2Hv7SoF?=
 =?us-ascii?Q?Hqd6PG6npsfCERuZZl3Y6e/Mtw2J228fLvUKFsVoWn3ZF4PLUGvc0tt6IRRU?=
 =?us-ascii?Q?rUqXLk2vqgOHEz+a/XAm4djXIQ9v45Q/Zu3W8to59P3vsFMn97ZmnMZbQHXl?=
 =?us-ascii?Q?0zV3PAPVpBMc+iqu84ZQEH3B9kzkfRr6740Qu8pZ8koqqtjJs/xNPrjOU5Yc?=
 =?us-ascii?Q?NZ6dF5BQSbbI/dkg66SrdAOf8+RlhyLJMZTM3qhRBcvC6Eu2m0RRpUKmq7Tp?=
 =?us-ascii?Q?mojyw1a4HkJHb0aNrOwsIyjWsPTgY3x2S6HQ25mZH5njiuIVLdeO31lSdmOi?=
 =?us-ascii?Q?ccv53G4oXYk5EJeQZlQD7R1PbK3o0ZNlxdRTqc1qxgyk+VAcDSL6uAH+LOQw?=
 =?us-ascii?Q?aMaiejZ2fyGyqtbV/Ao87iryPmaL64F5A5YkxxChhBoWKgaAvOFYn3gjy88u?=
 =?us-ascii?Q?xnCX2DbvfrLurPgLXrCOKPGDle1A2alzuyovq9ZL8o0CeS7hc8xxuZ89dZ82?=
 =?us-ascii?Q?1ol/6ii21xFNaVWLgFH2X2zr//7BuRB/uBL5RpgsHsrq+ezIBY5aKPZnMsMR?=
 =?us-ascii?Q?HEh/apEQeSU0KYvmFWf0e5KYZXcBjSHbbt0VQBWxUYSC7jlBQfjxbwymMa4x?=
 =?us-ascii?Q?WQYDO/VBm0YalsAi2jaoTDvM+pm/VZDmg9K1pX/ZO3fO6hzSJQ21EaRHkpBG?=
 =?us-ascii?Q?FDRfnFpDpW5aI3YXXn2E3RBNzN60cKS1P7ztkf5B/9/Wpya4eCoBARdSK+iL?=
 =?us-ascii?Q?VRh+kMDUbAkeuMWem1Bet0HXReIDRZQc2lJuz16VWyukv5SWyuapqRXCcBrb?=
 =?us-ascii?Q?oulO3Gn7VFgha6B9S2LfdH3O5hBjGw3vffC4FqIwEpzgQ4Y2MvNU48ALIQWB?=
 =?us-ascii?Q?hS7XIpfoFpKnGH2Q2ntkDeUj0I+OqdnjXhYWoPkofHUrmBcOZh9pQmXol65f?=
 =?us-ascii?Q?+xwO03k07/w9uYjmnO5pTGD/b8vLO9jraMk5+CE6jRk1FBy9DLmQnSzttFcb?=
 =?us-ascii?Q?mBHPOWVdF5pBX+GVcrm0vIqLF3F9RHChDyU+Aj5UfFIjDQfzmZHxQ770U8vN?=
 =?us-ascii?Q?0q1ioqrf7LVvzEBiAVtrd1Ku8g/QNJGPu1KQ96uaTxN25RfUSU10+rNbs2G9?=
 =?us-ascii?Q?OysNY+Ep99W6piiJqFz1y3SWxBH2tJ5i8boN6JLe+FiuCd7U5Q/PJyDDtIbF?=
 =?us-ascii?Q?ExirkIuBvAOgDSVBr2RcNNX4t3QVjR5pxSROz/ddLTLwC+yg2G10ahsPhQ9t?=
 =?us-ascii?Q?AosGGbinjwws8iPAwfaw/ARvYOR4SGf7DbJCWG/MgzBLocfA1goHksR7CKEF?=
 =?us-ascii?Q?aMjs/pHe47PE/cwc8YhgK5/eob1OWfbp1pl2OE9fwVgkJXhoS5OcbW38iPdE?=
 =?us-ascii?Q?fbcQV4QFNreuZdITKbS9mu55VWeWI/iUzd8USbalipH1AeRB3OEPLrxqL+gY?=
 =?us-ascii?Q?qhYxg2WY2mmxxx5eO4Adb5XO2Osd3WIsWHM4ByBgPNG0/W7lwzLQtZwuWPZd?=
 =?us-ascii?Q?FY02YH1yImsudtALAD5kY/Wg5X41JfMDB3/IWHjJVRB73zb+zS/SoMrBPScD?=
 =?us-ascii?Q?PIYRM9fR9M0trtqX44lxep28mbWdyRawNtf/hDphGvAx46aTT9eSZ5gdA7e8?=
 =?us-ascii?Q?HLWrDyhp9CLyKNdssBE01E3grvF8K6mFcL0Bz+h6DhA5ftn+qv2DwSU+g3w0?=
 =?us-ascii?Q?pucz/YIVnA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab61784-0acd-4a91-490e-08df392a0bcd
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:41:26.1822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQYAiibZxviHprwJv8aCsvZBug0YUFt+flPg8IOXZMO9N8mF7Z3A+1UomPTlrdvV2q0xEHMGXBRKtLd8QQGQIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P123MB8506

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
              ftrace_task_state__inlined_depth(ts) * 2.

            - On function exit, close matching inlined frames with
              } /* func (inline) */.

    3.  Command-line options and documentation

        Add --inline and -k/--vmlinux options in
        tools/perf/builtin-ftrace.c and document their usage in
        tools/perf/Documentation/perf-ftrace.txt.

Tested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  13 +
 tools/perf/builtin-ftrace.c              |  27 +-
 tools/perf/util/ftrace.c                 | 510 +++++++++++++++++++++--
 tools/perf/util/ftrace.h                 |  11 +
 4 files changed, 514 insertions(+), 47 deletions(-)

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
index 5c7d1c71c635..1f31cf31058c 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -1,21 +1,29 @@
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
 
 #define FTRACE_MAX_CPUS 4096
@@ -75,8 +83,9 @@ static u64 ftrace_event_seq;
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
@@ -195,6 +204,24 @@ static void ftrace_task_state__record_indent(struct ftrace_task_state *ts,
 	}
 }
 
+/**
+ * ftrace_task_state__inlined_depth - Count active inlined frames on a task stack
+ * @ts: Task state to inspect
+ *
+ * Return: The number of active synthesised inlined frames on @ts->stack.
+ */
+static int ftrace_task_state__inlined_depth(const struct ftrace_task_state *ts)
+{
+	int i, count = 0;
+
+	for (i = 0; i < ts->depth; i++) {
+		if (ts->stack[i].inlined)
+			count++;
+	}
+
+	return count;
+}
+
 /**
  * ftrace_task_state__prune_stack - Prune frames that exited on another task state
  * @ts: Task state whose call stack should be pruned
@@ -473,7 +500,7 @@ static bool parse_context_switch(const char *line)
 	 * If no context switch was seen previously on this CPU, its initial
 	 * pre-banner trace records were accumulated under an unknown synthetic
 	 * PID. Re-key that state to real_prev so the initial task's stack and
-	 * frames are preserved when it schedules back in.
+	 * inlined frames are preserved when it schedules back in.
 	 */
 	if (ftrace_cpu_tasks[cpu_val] &&
 	    ftrace_cpu_tasks[cpu_val]->pid == FTRACE_UNKNOWN_PID(cpu_val)) {
@@ -569,6 +596,71 @@ void ftrace_filter_retaddr(char *str)
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
+		if (!ilist->symbol || !symbol__inlined(ilist->symbol))
+			continue;
+
+		if (count < max_inlines)
+			inlined_names[count++] = ilist->symbol->name;
+	}
+
+	map__put(map);
+	return count;
+}
+
 /**
  * extract_entry_func_name - Extract the function name from an entry record
  * @str: The trace line's function column string
@@ -615,6 +707,58 @@ static void extract_exit_func_name(const char *str, char *buf, size_t size)
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
@@ -731,25 +875,40 @@ static int print_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
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
 	struct ftrace_task_state *ts;
+	u64 caller_offset = 0;
+	int num_inlines = 0;
 	int cpu = -1;
 	int leading_spaces;
-	int top_indent;
+	int extra_indent;
+	int caller_idx;
+	int active_inlines;
+	int common;
 	int match_idx;
+	int top_indent;
 	int i;
 	bool is_exit;
 	bool has_open_brace;
 	bool has_semicolon;
+	bool has_retaddr = false;
+
+	if (!ftrace->use_inline)
+		return print_line(ftrace, line, out);
 
 	pipe_char = find_func_column(ftrace, line, &cpu);
 	if (!pipe_char) {
@@ -762,6 +921,7 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 		return print_line(ftrace, line, out);
 
 	ts->seq = ++ftrace_event_seq;
+	make_blank_prefix(ftrace, line, pipe_char, blank_prefix, sizeof(blank_prefix));
 
 	after_pipe = pipe_char + 1;
 	func_start = skip_spaces(after_pipe);
@@ -780,19 +940,33 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 		extract_exit_func_name(func_start, exit_name, sizeof(exit_name));
 
 		top_indent = -1;
-		if (ts->depth > 0)
-			top_indent = ts->stack[ts->depth - 1].indent;
+		for (i = ts->depth - 1; i >= 0; i--) {
+			if (!ts->stack[i].inlined) {
+				top_indent = ts->stack[i].indent;
+				break;
+			}
+		}
 
+		/*
+		 * If currently overflowed beyond FTRACE_MAX_STACK, any exit whose
+		 * indentation is deeper than the top tracked frame belongs to the
+		 * overflow region.
+		 */
 		if (ts->overflow_depth > 0 &&
 		    (top_indent < 0 || leading_spaces > top_indent)) {
 			ts->overflow_depth--;
-			return print_line(ftrace, line, out);
+			extra_indent = ftrace_task_state__inlined_depth(ts) * 2;
+			fprintf(out, "%.*s%*s%s\n",
+				(int)(pipe_char - line + 1), line,
+				leading_spaces + extra_indent, "", func_start);
+			return 0;
 		}
 
+		/* Find matching frame on stack */
 		match_idx = -1;
 		if (exit_name[0] != '\0') {
 			for (i = ts->depth - 1; i >= 0; i--) {
-				if (ts->stack[i].name &&
+				if (!ts->stack[i].inlined && ts->stack[i].name &&
 				    ts->stack[i].indent == leading_spaces &&
 				    strcmp(ts->stack[i].name, exit_name) == 0) {
 					match_idx = i;
@@ -801,9 +975,14 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 			}
 		}
 
+		/*
+		 * If bare brace ('}'), match the topmost non-inlined frame
+		 * with matching indentation.
+		 */
 		if (match_idx < 0 && exit_name[0] == '\0') {
 			for (i = ts->depth - 1; i >= 0; i--) {
-				if (ts->stack[i].indent == leading_spaces) {
+				if (!ts->stack[i].inlined &&
+				    ts->stack[i].indent == leading_spaces) {
 					match_idx = i;
 					break;
 				}
@@ -812,17 +991,47 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
 		if (match_idx >= 0) {
 			ts->overflow_depth = 0;
-			while (ts->depth > match_idx) {
+		} else if (ts->overflow_depth > 0) {
+			ts->overflow_depth--;
+			extra_indent = ftrace_task_state__inlined_depth(ts) * 2;
+			fprintf(out, "%.*s%*s%s\n",
+				(int)(pipe_char - line + 1), line,
+				leading_spaces + extra_indent, "", func_start);
+			return 0;
+		}
+
+		if (match_idx >= 0) {
+			/* Close all inlined and orphaned frames above match_idx */
+			while (ts->depth > 0 && ts->depth - 1 > match_idx) {
+				struct ftrace_stack_frame *top = &ts->stack[ts->depth - 1];
+
+				if (top->inlined) {
+					fprintf(out, "%s%*s} /* %s (inline) */\n",
+						blank_prefix, top->indent, "", top->name);
+				}
+				free(top->name);
+				ts->depth--;
+			}
+
+			/* Pop the matched real frame */
+			if (ts->depth > 0 && match_idx == ts->depth - 1 &&
+			    !ts->stack[ts->depth - 1].inlined) {
 				free(ts->stack[ts->depth - 1].name);
 				ts->depth--;
 			}
-		} else if (ts->overflow_depth > 0) {
-			ts->overflow_depth--;
+
+			extra_indent = ftrace_task_state__inlined_depth(ts) * 2;
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
 
@@ -830,38 +1039,251 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 		ftrace_task_state__record_indent(ts, leading_spaces);
 
 	top_indent = -1;
-	if (ts->depth > 0)
-		top_indent = ts->stack[ts->depth - 1].indent;
+	for (i = ts->depth - 1; i >= 0; i--) {
+		if (!ts->stack[i].inlined) {
+			top_indent = ts->stack[i].indent;
+			break;
+		}
+	}
 
 	if (ts->overflow_depth > 0 && top_indent >= 0 &&
 	    leading_spaces <= top_indent)
 		ts->overflow_depth = 0;
 
-	if (has_open_brace && !has_semicolon) {
-		char entry_name[128];
+	if (ftrace_parse_retaddr(func_start, caller_sym, sizeof(caller_sym), &caller_offset)) {
+		has_retaddr = true;
+		num_inlines = ftrace_resolve_inlines(ftrace->machine, caller_sym,
+						     caller_offset, inlined_names,
+						     FTRACE_MAX_INLINES);
+		if (num_inlines < 0)
+			return num_inlines;
+	}
+
+	/* Determine which inlined frames are currently open above the caller */
+	caller_idx = -1;
+	if (has_retaddr && ts->overflow_depth == 0) {
+		for (i = ts->depth - 1; i >= 0; i--) {
+			if (!ts->stack[i].inlined && ts->stack[i].name &&
+			    ts->stack[i].indent < leading_spaces &&
+			    strcmp(ts->stack[i].name, caller_sym) == 0) {
+				caller_idx = i;
+				break;
+			}
+		}
+	}
+
+	/* If caller is not on the tracked stack, do not synthesise inlines */
+	if (has_retaddr && caller_idx < 0)
+		num_inlines = 0;
+
+	active_inlines = 0;
+	if (caller_idx >= 0) {
+		for (i = caller_idx + 1; i < ts->depth; i++) {
+			if (ts->stack[i].inlined)
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
+		       ts->stack[caller_idx + 1 + common].name &&
+		       !strcmp(ts->stack[caller_idx + 1 + common].name,
+			       inlined_names[common])) {
+			common++;
+		}
+	}
+
+	/* Close stale callee frames and inactive inlined frames above caller */
+	if (caller_idx >= 0)
+		ts->overflow_depth = 0;
+
+	while (caller_idx >= 0 && ts->depth > caller_idx + 1 + common) {
+		struct ftrace_stack_frame *top = &ts->stack[ts->depth - 1];
 
-		while (ts->depth > 0 &&
-		       ts->stack[ts->depth - 1].indent >= leading_spaces) {
-			free(ts->stack[ts->depth - 1].name);
-			ts->depth--;
+		if (top->inlined) {
+			fprintf(out, "%s%*s} /* %s (inline) */\n",
+				blank_prefix, top->indent, "", top->name);
 		}
+		free(top->name);
+		ts->depth--;
+	}
+
+	if (caller_idx < 0 && ts->overflow_depth == 0) {
+		/*
+		 * If caller is not on the tracked stack, unwind any frames whose
+		 * indentation is greater than or equal to the new entry's
+		 * indentation (their exit events were dropped), and close any
+		 * trailing inlined frames that were left open from prior calls.
+		 */
+		while (ts->depth > 0) {
+			struct ftrace_stack_frame *top = &ts->stack[ts->depth - 1];
+
+			if (top->inlined) {
+				fprintf(out, "%s%*s} /* %s (inline) */\n",
+					blank_prefix, top->indent, "", top->name);
+				free(top->name);
+				ts->depth--;
+			} else if (top->indent >= leading_spaces) {
+				free(top->name);
+				ts->depth--;
+			} else {
+				break;
+			}
+		}
+	}
+
+	/* Open new inlined frames */
+	for (i = common; i < num_inlines; i++) {
+		int entry_indent = leading_spaces + ftrace_task_state__inlined_depth(ts) * 2;
+
+		if (!inlined_names[i])
+			return -ENOMEM;
+
+		if (ts->depth >= ts->max_stack &&
+		    ftrace_task_state__grow_stack(ts) < 0)
+			break;
+
+		fprintf(out, "%s%*s%s() { /* (inline) */\n",
+			blank_prefix, entry_indent, "", inlined_names[i]);
+		ts->stack[ts->depth].name = strdup(inlined_names[i]);
+		if (!ts->stack[ts->depth].name) {
+			pr_err("Not enough memory\n");
+			return -ENOMEM;
+		}
+		ts->stack[ts->depth].inlined = true;
+		ts->stack[ts->depth].indent = entry_indent;
+		ts->stack[ts->depth].seq = ts->seq;
+		ts->depth++;
+	}
+
+	/* Print current line with updated indentation */
+	extra_indent = ftrace_task_state__inlined_depth(ts) * 2;
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
 
 		extract_entry_func_name(func_start, entry_name, sizeof(entry_name));
 		if (ts->depth >= ts->max_stack &&
 		    ftrace_task_state__grow_stack(ts) < 0) {
-			ts->overflow_depth++;
-		} else {
-			ts->stack[ts->depth].name = strdup(entry_name);
-			if (!ts->stack[ts->depth].name) {
-				pr_err("Not enough memory\n");
-				return -ENOMEM;
-			}
-			ts->stack[ts->depth].inlined = false;
-			ts->stack[ts->depth].indent = leading_spaces;
-			ts->stack[ts->depth].seq = ts->seq;
-			ts->depth++;
+			return -ENOMEM;
 		}
+
+		ts->stack[ts->depth].name = strdup(entry_name);
+		if (!ts->stack[ts->depth].name) {
+			pr_err("Not enough memory\n");
+			return -ENOMEM;
+		}
+		ts->stack[ts->depth].inlined = false;
+		ts->stack[ts->depth].indent = leading_spaces;
+		ts->stack[ts->depth].seq = ts->seq;
+		ts->depth++;
 	}
 
-	return print_line(ftrace, line, out);
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
index a65ae369e9fb..7b9e0919ae8d 100644
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
@@ -96,9 +98,18 @@ perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
 
 #endif  /* HAVE_BPF_SKEL */
 
+struct machine;
+
+#define FTRACE_MAX_INLINES 32
+
 bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset);
 void ftrace_filter_retaddr(char *str);
+int ftrace_resolve_inlines(struct machine *machine,
+			   const char *sym_name, u64 offset,
+			   const char **inlined_names, int max_inlines);
 int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FILE *out);
 void ftrace_cpu_states__clear(void);
+int perf_ftrace__setup_inlines(struct perf_ftrace *ftrace);
+void perf_ftrace__cleanup_inlines(struct perf_ftrace *ftrace);
 
 #endif  /* __PERF_FTRACE_H__ */
-- 
2.55.0

