Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.102
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792951925;
	b=KvTZusIUdKCL7myRuK0fnVXPx7jABqhOSoSsDYTL9PM0uRhzfsMPZrli3RWwvj9iw1+f
	 vXi9d1NuKyTK3Mynxs4Wy6vlHfMZEoZkuGK8l86pkTLVPC+hSg9WrWys6fWJLPtSo5pMz
	 BWBnbZg3Tbru8kYG0T9OTKDn0pTaEvLJdFOlYvxOiV2LsD2dYWs/SHAXEzHp3kEiFIYZK
	 MMnTV6rSwSUmvvEQoGUJpZAtMvOzyFSViyaG5/v8QIlIp5e+9kYj6VgmmF8UoPqGDF3kM
	 EfoP8hWu7UawLsbZi3zlpMta3+k6fBpBSUCY9pkhnrda1kHOroDxSAGJ0eBTVRKvP5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951925;
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
	bh=2Cx0Jiii2QUpC01GZdRv7sc7C40YwtkLq4s8ADlB7GE=;
	b=oDqsHvpoTY5D4u/j/7W1Au0EEnVH50TXSowtRupqHEZjpypI/XN5ygcGfmEAcIZ4ERkA
	 GUHS7yiLbAe0F7L7h+nXMA09RHhM7p4FBtkyCxlpB/Q45sX06LTURXruIvqz+ziKgM43I
	 XOEjLoFzk1nPRSf4R51JdXoJmc+HKkVppx4B4/hvWKL4duCadk5x3+0mSpkRIMxGYtyoZ
	 TBz8u4BN5FpCp8ZOKTuOr/YDSHRG3Uwu1kBA44Ta9UoD6D+NxHR4VCfJcZ/txdoTKMxel
	 IcJmRBrNEpAQ7zCP5lWjEGynd0eS6RSLATz015BLIGTlp40mNFKapLPwhK+PMPSWFJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.102
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020102.outbound.protection.outlook.com [52.101.196.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30433606A31A;
	Sun, 25 Oct 2026 18:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30433606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLmnzUX6W+wtKYqDJNPORKz6prspsW72wDoE8CRu8iojzg3vDfy+3WMkPRshPN189kXjpuJbkmlfXh4TPkwRXIozZnlSkXtNeE5ljh2F8tAVIigtprEf5o6V0LYirokzf1e8RF/eh0rgG+QEaW3C6ZI3qoMtxcihBKYgb9S3rVNvwkJ5lOuhoSADXr6/ta0hhCX87iLmBpz8wtCkM84YT0T45jR4Z8UoTrCc9N+12tSuIXa0VL3N4dQlrL4oVL5GpSKeg1tOva0FZDz582l5K4A7hr8n8CjIoaNGCU783qJatBGNBGyWSiaH6iVRLwB9blXXmC04FUSXURL5Il3Nuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=2Cx0Jiii2QUpC01GZdRv7sc7C40YwtkLq4s8ADlB7GE=;
 b=ORr50lJVhI5DCViK1XffcBBBul8N29lBO3val1wCU2lvll40vLA6Krax9pT3rAwvRnB7NkaEe56MJvdcTVunkKzd1brRdzaR5OxoG4jvkleUo5OQmtue1YhI1U5gDA8Lrck0W5i2WrRK1NwqWKyUOBcU8MpQBc3JWUCa5CIeyNsBcPl3DY5vdZ+mahOERPydg2Z1zIP0d681sgT0RtPyuLFJTa5GjeKpLs2M/THBiUj9WoO/3gqHuT0PH8QD8vy3Sp2fHQgw9IPx+74G1K1Wju4Dky6Uxhack88V+Xk08hSheFhCSi1xRK+LNeeFm9d8sMp5eTBl28uFgf/ux0jzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6815.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:30e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 18:12:02 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 18:12:02 +0000
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
Subject: [PATCH perf-tools-next v11 06/10] perf ftrace: Support display of inlined functions in function graph tracer
Date: Sun, 25 Oct 2026 14:11:21 -0400
Message-ID: <20261025181125.514372-7-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025181125.514372-1-atomlin@atomlin.com>
References: <20261025181125.514372-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: QR0P297CA0007.MEXP297.PROD.OUTLOOK.COM
 (2603:10b6:3d0:17::7) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb1f0b9-a262-4b2c-507f-08df32c377a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|5023799004|56012099006|261022105027099003|261021135927099003|261021133027099003|261022115727099003|261022113327099003|261022075727099003|261009223027099003|261021130227099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	VVmMdZJDS9YTZfOW5q4jTlPcVsqt3buUpFe0sM0R90sIvBAU/86Y2uA0RwonZigEr+8DGEOkMQYKkQYgl9kLMuQOOSZNz1WFpJ0BvL4lqokB/I51hfhy5DhmEA1P4IBehBnXDm65L94wXDm70O04cqQFbGE6zE9h/nf6KOm+KIwfdW99leGNMBbnIET6qLZwwZVLgJGjpT35E+6E+BldhqoAIsjEhpoFXCdHCpW4iRkzoW+VD26VcczCLuJ6qqY4P2PV0CjDHgH4K7pkOLkgYQhp3gRI7KXY2gz8VXGS6zD4ZfDN+b0PK0VhmOmTuH6xI2dRDhKmXCiBDTyijJ8VtYYKDQcidqEuFT8UWlLavdElzd/VfENT//fpHnMinuzS/4TP5xkpbYScb12Mt9+Sn5p8l6JV+ulL2ByYJwYuLX+qJeLpd1ioeJmiYyEqoyPEdpm3EadYVQyeKECgh08ZzwfXLm3c69avaeyQTY26nH5h+2VJIS7XlEv9bs2YtGzD9iLRUMH7WK4y1VzC1ImobUYaeOrBDpiHZSGHWHCmat77fVtZjXP5S93oEQEhKSyOE49TR4Qy5U0R3Y5H+1k8JXIMqVkTJbGUPfwb5la4lqKlDIMBEbvChTV/l1+SOQCStc1HmYao1DJ85jst7v1Mu19QmWc7IjeaX7pj9MAf2Eg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(5023799004)(56012099006)(261022105027099003)(261021135927099003)(261021133027099003)(261022115727099003)(261022113327099003)(261022075727099003)(261009223027099003)(261021130227099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yf21fUXXYDYPG/waHNJUyPkU8hO42pCBiI7yf7ytTjU7vTEEtDyv+979g1mS?=
 =?us-ascii?Q?OwHQVpdgk3fYCYyZHtffyZ8GZp1Mmi4ri+nTmvwNwCTnauhAUZFAYDstxwsI?=
 =?us-ascii?Q?TohTvYkYWp+vvpGwHu3neckQo90i+xraYlR8H+IwpGWbjVlekae6imCBH9VX?=
 =?us-ascii?Q?/tJgpVr4S3OJzU2Pa9nkt5KWCnbqnwUf246F22aO3SMzG0Aujp5o1LBLZmBf?=
 =?us-ascii?Q?1LSj6j4yoZgmhJP78ieihTEFJPg5rwGQKFCHVGfZxWdEi+wJ4siw4QwBSa9R?=
 =?us-ascii?Q?ZjWlPd7iGh3QK74EMLKMRlBfqJ0QNun2MB6GKf3CVh9hRII+MPznl8m2b/ZI?=
 =?us-ascii?Q?pLWfseRmshC8W3igcmOE3c59pvS1iLxpnkY+WZT5uF6SThzT1rGyJtyK9Vq2?=
 =?us-ascii?Q?efarhvprDFV+G85TaPrKngmWKaMARiTZaqRYLoXWkqMmx32PBw1GdyvcOxQn?=
 =?us-ascii?Q?LwFbJiSRrfiwaFcGNMVLgmcb2rBZSWoSqVpASJlk3sJtV23y/5jp6H9Gs3mP?=
 =?us-ascii?Q?hG189P5SIYYF1hsuEa+bGedhL4FRKnSbeCoxATobIBVd30rgIfIS0m/+czJN?=
 =?us-ascii?Q?mdCR2p9ByO0l71E3SkUq459xShzF9szEDcZ76CzfugZ09IHewyX9LNwvPCK9?=
 =?us-ascii?Q?M0uv2k8hpw7u9x6qnvCihTtTbYWTzdOGrtl/Lv8M/Gf0H6tQ6rBQUGXZiiHl?=
 =?us-ascii?Q?BEftvFyOyWAhrqGqsz72uq4Eekzk1/RoTZ9l5ZdH6FSNxegGRxpLRZUBljl5?=
 =?us-ascii?Q?49piLg97SSDcuYDHCDP5cr4hwWvY20kaqNNSeX9PdrhViTBjy2mfU14RzZ+z?=
 =?us-ascii?Q?yAotPV7bvNJZzzpRXTtIxOV0Dj3zFWG7VGSjbfxprbM6pd4bpW0wWLQ6JM5W?=
 =?us-ascii?Q?4Y9XUPUy5rdk7Ov0NcAOARCL0l70zWmZVAA38Wxrmyk/gpsGCPHnOx/Bmv0q?=
 =?us-ascii?Q?HKuOA2q4aou81RTMJIikAbm4Lx3pkeV8+13gWT53Rias533133GQsL61aO/B?=
 =?us-ascii?Q?8gtnl8s9DCz/nPXpBf4ZJvjk556cKATAOsO7HTuUXltgntvjNP0OFzCOqRTU?=
 =?us-ascii?Q?EKTNvTZH8juneRn8pm9IZEpqRLqb/nIPs6XjzPF5qPm6amyvWK/ABzb2qn+q?=
 =?us-ascii?Q?KnrsY8ssxrz19vmIo0NAvBmkjZRZDuQfjKobRb0+D8pKeL64QGDRFc9R96nC?=
 =?us-ascii?Q?BukXEzFo0eM6njS1trEqyIcCTbXZVJztMSt0ED0UD8O1/ocTFnY7Ia2eFv4z?=
 =?us-ascii?Q?t/ThGM23aboMb8Ff0vWOEMOJS9lc8meatBi+itI7TEnktRKMKrMu8Mm1ENws?=
 =?us-ascii?Q?FGaIJ5GsFGMzb1e+Oc3hwPeH5AsCCy9eWAFR+7Bf75mvaclNcZau6y5iPiSQ?=
 =?us-ascii?Q?TAqoRXE+UNXFjNru2fkLi+Kqn8jf23HACB7pZU4LBaXi9xYBtuFIaqNKk6Ib?=
 =?us-ascii?Q?/KkS2Stse7viSbvQTDXGW83GqeVG2K/FN1cmpR8oSyrMrVKL7dBr7D4c2w0a?=
 =?us-ascii?Q?LyF3DNE8gzCc3UQSq/HVQ7jgzpDjB3Bu6uYujgcUV6atDVTUuDC4KxIFpwAe?=
 =?us-ascii?Q?1rWIegtENbaNdPMVTlGL8T+JUrzr25i/yzqge3mDHK1AAyriPtaQxSZ5CtO6?=
 =?us-ascii?Q?xaJZR5va8NmHUQQGn+P+yZpc35IrUOkXERAM27Pj8nD7cSOYY3TmNDC+LkXn?=
 =?us-ascii?Q?UWvmyWpioGL/Vdw/pX2h4IoXRCR9j2IyQZBeXF3xkOxURD4JGEgXbYKn8zEB?=
 =?us-ascii?Q?tw5VVOJSMA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb1f0b9-a262-4b2c-507f-08df32c377a8
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 18:12:01.9704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ieg5wru/0fKwal6sqGV6s9V/yUBTZJauj3XTLd2PHMtEnCt8a1v6UPx4RvEWDsKvNGh0OMcHT8QvhIY9m0KnFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6815

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

Tested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  13 +
 tools/perf/builtin-ftrace.c              |  27 +-
 tools/perf/util/ftrace.c                 | 627 ++++++++++++++++++++---
 tools/perf/util/ftrace.h                 |  37 +-
 4 files changed, 600 insertions(+), 104 deletions(-)

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
index 055b5eb6b832..85ff1ede5454 100644
--- a/tools/perf/util/ftrace.c
+++ b/tools/perf/util/ftrace.c
@@ -1,23 +1,61 @@
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
+	u64 seq;
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
@@ -25,8 +63,9 @@ static u64 ftrace_event_seq;
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
@@ -69,6 +108,32 @@ static struct ftrace_task_state *find_task_state(pid_t pid)
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
@@ -88,12 +153,10 @@ static struct ftrace_task_state *get_task_state(pid_t pid)
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
@@ -103,32 +166,6 @@ static struct ftrace_task_state *get_task_state(pid_t pid)
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
@@ -428,7 +465,7 @@ static bool parse_context_switch(const char *line)
 	 * If no context switch was seen previously on this CPU, its initial
 	 * pre-banner trace records were accumulated under an unknown synthetic
 	 * PID. Re-key that state to real_prev so the initial task's stack and
-	 * frames are preserved when it schedules back in.
+	 * inlined frames are preserved when it schedules back in.
 	 */
 	if (ftrace_cpu_tasks[cpu_val] &&
 	    ftrace_cpu_tasks[cpu_val]->pid == FTRACE_UNKNOWN_PID(cpu_val)) {
@@ -524,6 +561,80 @@ void ftrace_filter_retaddr(char *str)
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
@@ -570,6 +681,58 @@ static void extract_exit_func_name(const char *str, char *buf, size_t size)
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
@@ -577,11 +740,16 @@ static void extract_exit_func_name(const char *str, char *buf, size_t size)
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
@@ -681,25 +849,40 @@ static int print_line(struct perf_ftrace *ftrace, const char *line, FILE *out)
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
@@ -712,6 +895,7 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 		return print_line(ftrace, line, out);
 
 	cs->seq = ++ftrace_event_seq;
+	make_blank_prefix(ftrace, line, pipe_char, blank_prefix, sizeof(blank_prefix));
 
 	after_pipe = pipe_char + 1;
 	func_start = skip_spaces(after_pipe);
@@ -732,20 +916,32 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
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
@@ -754,9 +950,14 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
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
@@ -765,51 +966,329 @@ int ftrace_process_fgraph_line(struct perf_ftrace *ftrace, const char *line, FIL
 
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
+		cs->stack[cs->depth].seq = cs->seq;
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
-			cs->stack[cs->depth].seq = cs->seq;
-			cs->depth++;
-			cs->min_raw_indent = -1;
+			for (i = 0; i < num_inlines; i++)
+				free((void *)inlined_names[i]);
+			return -ENOMEM;
+		}
+
+		cs->stack[cs->depth].name = strdup(entry_name);
+		if (!cs->stack[cs->depth].name) {
+			pr_err("Not enough memory\n");
+			for (i = 0; i < num_inlines; i++)
+				free((void *)inlined_names[i]);
+			return -ENOMEM;
 		}
+		cs->stack[cs->depth].inlined = false;
+		cs->stack[cs->depth].indent = leading_spaces + extra_indent;
+		cs->stack[cs->depth].raw_indent = leading_spaces;
+		cs->stack[cs->depth].seq = cs->seq;
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
index 95c1b880e836..7b9e0919ae8d 100644
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
@@ -96,37 +98,18 @@ perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
 
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
-	u64 seq;
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

