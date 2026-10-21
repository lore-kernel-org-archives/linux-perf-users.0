Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792550032;
	b=NUEXDqlf+fQgJiJ+i1Cg4mBrKmvBy3qsEwTrvq8JWP8xUzAtgEVRoiuEPRJetc9FOucB
	 vPryAjvg0FJzjVJizsc2LSIPDvxtagfkQWtpGSvjx81C/7rXREhb5zGIa/qrvs1UfLE0y
	 cMfMwdaDWfrAPXH0gCbq0sWyBPsU4rjsWoB9rguVGWVtU+TDo5ziCDCIL3LH8vLOFymlF
	 ViMZwp136A1SZaFFheUTWXDpFoKoTEfnrW7b1bHkxcefUTj6p68/S709Rd6RzR37CY015
	 kb3ulw1l3z9+z9RwTRg5wtcq6cDyRi8SM5XLW6HgA1kwoW26guSSgJTR2Oj++AVx+jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550032;
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
	bh=pvWLobe6hCQqXhuCWpe9GpZZgPA8NVjEpogZ4uSZow4=;
	b=AdpHgaqueV7p41Wzf5iwcr4y57BLQyrlF+QO6KqzK9A5VDUDt9ONtvKRKz4j9Mq5LKEc
	 +M8ubEa41KV9/MjzR/gyMeDP6uge+glUbjMXOkbL2eCIFIsQQ9eVG6a+nPyQe67/USYjX
	 foVME9ssfep9FjxJuM3UbYNgfenY7OmDL/GPN7No8ZOGu4Xm4lX6o2YM7U4D2e6cG504r
	 X5HGoEYesWD5iHzkFxooFZkYIYE6vD1AInnHyXnzhOBWLhK13+iAKHuOoQnwSU0AZNM5m
	 hNi20X7Z8Fcj08Gsz3jsWAc2l/Giln0uip+SVxlt3G+Z3EbTKfDLUmDgwcYW/H+Xp8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.141
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022141.outbound.protection.outlook.com [52.101.96.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19657606A31E;
	Wed, 21 Oct 2026 02:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19657606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daN5rXotyVD4t1uE484Z0ijXQVp7FzNbyd0Rf1HhIBGfkjBXmGk6j5U71xt2Jgwnzw+W+EbWTj7fHylSkiSSM1pXzp+vv89xeYG4AG5F2olPax240cgfQZYLQ3EM3Yr3g562t9nUma9KtCzap+cfeTtbVy0ToyY1dzwG6u6LHz9duI7480lIUogEchu+TRXIo+xoRTVkzX2bv7yn/lLK7d/vsoUL+KxlFvRBIu6cjb201p8cA2nPFDYyjh4VDbNbZLEUIEThWg5XwMiERRYmixqcoHKqBGsJeB9NowqbFrvzM2dUOLYJ6NeeURiaXs/51c4NoE0m8XSSfnDoVCLAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=pvWLobe6hCQqXhuCWpe9GpZZgPA8NVjEpogZ4uSZow4=;
 b=MGUSCb14Tjro+LeHc5wZmuYwpFVvqHeqlxdD1/95KF2d8WBXAyi/vOiqqpj7DxH865Md8/lw+yoFKOTLjWoiGoZjx/gWWCuodYK3Q8pm3aIghFaPmD0jBMDoEABGdcAGEZcIZr8euJtNz9hA9IVe8CyD0F/3ES38YlCrcjEnmvdCYyCKgdWMfqPbg4+ysUje/Y5GA1a/eW7RmwJdiFsay3PLtO42gb6CsYWp0qAL6ZtIBBSnmGtVKVGtKp/+N+Wx+z96ztBApHf1gN1OTh8Z5khx0dW5X0ItTDRR2VTo5aX+e6Fe4e7wsK34xLBtr2tY4CAPzWKoi7W9z9U9Aimnyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB5917.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:287::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:33:49 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:33:49 +0000
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
Subject: [PATCH perf-tools-next v9 2/6] perf ftrace: Support filtering return address comments
Date: Tue, 20 Oct 2026 22:33:33 -0400
Message-ID: <20261021023337.809936-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021023337.809936-1-atomlin@atomlin.com>
References: <20261021023337.809936-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0574.namprd03.prod.outlook.com
 (2603:10b6:408:10d::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e474ee-37a4-45a5-0caa-08df2f1bbd47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	IQE3OnJy9pZy/R/Jonka/GFr27iIj2Qe0Hj4oYHeIx/+TCKmeOJ4VA53RSxbxOPAgYGWdWW3fyaUuQqm3lvqTa9zatHhrpC0jFM0b+6Zbgs1Q4KQrMfIxxDtRvtjcIc5UKMK9ZNUVUsKL4DCzeEuWGVIbn3D8kStVhUcFiX3ugpmnjy9cjjXXqr4yi8TX4JdEUiUOtahbgqToHkOY/8Age5TdTfFoa6Sr3/bfQBDLUvvMzSJUqC/vg2vc5IjsQuxoxDYEsTsrzi0G/snAK8uP3xtgacEfml8GR2A+5EF2n5nFLxFvKArDlLoJClNWDPUv+V6rd9q5j+FqyGsO2qkR5VSevGZaW8QujEKyKRYNYZlPPD6/IK6rD1MDLpD1o5MXaQ+bWU8XqPLCfipR0EyzSAv9YSHcYgJM6CUZJaVz+u4ZBVyro1RT1HYLiIpgJ7J4oy+8ry26tFGxqr2I3bCgZbouBLbM1KHDxccy0iUsqrCN6GVwdLGS+CoR4A7owVBVY8rnipNm7SWj9qBuBdEzGZmbDLoICJcI6RDg4KRjJOu6EbFdutkgsyMcIdQ/Q/J2n4aiL+wfc7ej4mAgy2ioWBPAnlvcqeK2OkdW++H2V2VU5X0SHu6g0dnz1rjhv0lH1bKvOa4HjlOWI4l3OWGJQFs9cOHX4IWTPxEAUFOahw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dn6DJwximJSlb81srZNYFTRA3RL0kS112LCqZ9CJu4/n3K1e/j9OWG5P2Lmz?=
 =?us-ascii?Q?mSknHAeeS5LAMje8ZM/HLZMgKHtDw10VSfa1tOAnHdNRpsqVw+ioAe1xza/g?=
 =?us-ascii?Q?n9g3n3SDRPEwixIv0aGVPRm4/XL5rzr557cr0gpf6HnGsYC8+wCXydJFMyAq?=
 =?us-ascii?Q?rv6dGhAr7ik2hbfyGWNgAqAVC79doGEVr73Y7Yj9UvqtK0RP42pQ5lYV93Ql?=
 =?us-ascii?Q?r8w3QcTXFoy3WfzeCvAL6LRv9u31kdCsIMlXPlBrsEOGfy8q3b2YInjuVdke?=
 =?us-ascii?Q?8/eaUzsPPy9b75DcxBrZhAuUcz+DudzVcH+W2GOK6EgObUQ3GUrHw8FgrDWM?=
 =?us-ascii?Q?yWFpmW4dlhj//5GcCDVHTVtzLjucf/nFxGa1em2tgHm8DBHGqLPIWtmcz+uA?=
 =?us-ascii?Q?jLQEEo8hxuo7iMEN6rWOZVIJZv9F6YeCYo9mBH9B2EhYwujpVb/3GHsFaCo8?=
 =?us-ascii?Q?VJ1OeXjICQXi94sveqcxRFJZlCj/OlmRjp49SBdbdAOhMwoWdP5zsMA+rR+w?=
 =?us-ascii?Q?R+HhlVGsZYuQhrDOgHEnpkYcgCMN/3ym/YbVZ0cSJcZvztTK9q/BKnr+g5bv?=
 =?us-ascii?Q?fY8YC9RX5vI1ytx5ntS8s1tTZV0+7wUmruEzLuMV+LjjUJa+tUMmdcd41HCF?=
 =?us-ascii?Q?sEFLBtboLgzg1gNSBNyIzfdsSPVOu0uo4xdqBH0troKG9rwcqqw5wmHY/1SX?=
 =?us-ascii?Q?J5ZWrel0LotFOBUSlcnrduBHqypjR7tdNFDSbLKk0E0DWykTAUDtkUhFfqov?=
 =?us-ascii?Q?K8QpekI2y20Su5jdLh5Cy6+uPnrOo9GTudMW74iPvGenzXqdbt8r4vUQyGSb?=
 =?us-ascii?Q?K/lUwhfcx2jiaDd3vnt2J+Yx4VWaaJkf09m5ACbJl80UQT6bd0cJH4kwJdpq?=
 =?us-ascii?Q?55VZqk+WMPQPCL46NF2qc2luCoPL/Qh4lQwTTpfa+hPEZsQutmw2gaCaIC5h?=
 =?us-ascii?Q?KXPgWDMZxRxlwnafSLuWJVtQEJuq06bnV9gzufIrjPGedjXHd3Nuj9FiNRb0?=
 =?us-ascii?Q?Sq4xxf8c5UVsCTf4CDl+XxQgSUKbEpo0Y9D4aDBMm/Sl5i29Pfed84j/BCQ9?=
 =?us-ascii?Q?80k0WX2sOgOtA03C63itf8DEUPrxZcCePq1LoEN7nnPCfDLO10MMga2D090K?=
 =?us-ascii?Q?QjBxPB8nd9papvm/Vd5tA5ZMDL7Wp1BaGhoP9X+lqNfU60OqbERClvNQguCI?=
 =?us-ascii?Q?DKPyYdPk/TqoBEvB2s18aPe/Uy6U1eSvvm9OoKQ7xzdjgm0/OrQcGzF5rHDE?=
 =?us-ascii?Q?i3vcNIbkz+etO3v08vUTy8osRFHSctclX3eUjfYJszbhztgI8nobqtUZijpJ?=
 =?us-ascii?Q?Ua7zW6o6WPvWw3g8k4/B3G0bRDJEA6eX1jCL8LyFzSJuEdtsGARCEiFFD0A1?=
 =?us-ascii?Q?G2uWUPOMQm1teLYDZUKcaw/DR603Y3UFuCeKe1A4TSZEJFCPeG28/EBzYRjf?=
 =?us-ascii?Q?ZCQe3I/imLULes6QxC4uCTAZbbDlaz6MZfH3qY7+IvqYwio0YUuM6H28abJY?=
 =?us-ascii?Q?CMLJ/I91c7bJa/2YzGU4hIAdsAwXfmGe26UUC9BYuUeVlXUCQBHr8hJfRBzk?=
 =?us-ascii?Q?EWr4AgxNJX5+xJawPOImmpEm5IomA9DFV5pKW+3mpg46s8QjsMQ4jxPucGlv?=
 =?us-ascii?Q?+tN7b1y7ewcQ9xNmDI/h/gDmeR5swLPssZFq67ahrxD6ElwxoyKnOlScYUWM?=
 =?us-ascii?Q?xZV/My14NAfx0VnTqdFB+DIIhaB0CRhdgRLytgMS0DI7LhW1RfGDG1Y7aVnt?=
 =?us-ascii?Q?ufow1EVDKA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e474ee-37a4-45a5-0caa-08df2f1bbd47
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:33:49.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mipsCtMBcNJw1Tf/UHPiACjYzvuWsnTTK/qeJYFyLmmTi5nvp7SHRAz7tlIIQUM2dHbvrrtS/RzJLTdRfohC7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB5917

When tracing with the Linux kernel's function graph tracer, enabling
funcgraph-retaddr records the return address of each function entry as
a comment in the trace stream (e.g. /* <-load_elf_phdrs+0x6c/0xb0 */).
While valuable for tracing execution origins, these trailing comments
can add considerable visual clutter to the call graph, particularly
when examining deeply nested call trees or when synthesising higher-level
abstractions.

Introduce support for filtering out return address comments from
function graph trace output. Provide a standalone --filter-retaddr
flag.

Key aspects of this implementation:

    1.  Return address parsing and filtering

        Implement ftrace_filter_retaddr() in tools/perf/util/ftrace.c
        to locate return address comments and strip them in-place with
        memmove(3).

        Additionally, introduce ftrace_parse_retaddr() to parse caller
        symbol names and offsets across diverse output styles (standard
        format, return values, and bracketed addresses), establishing
        the parsing foundation for subsequent inlined callchain
        resolution.

    2.  Command-line interface

        Expose --filter-retaddr in tools/perf/builtin-ftrace.c, updating
        the documentation in tools/perf/Documentation/perf-ftrace.txt
        accordingly.

    3.  Automated verification

        Add a dedicated unit test suite ("Ftrace return address
        processing") in tools/perf/tests/ftrace.c to validate comment
        parsing and string filtering across all supported formats.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  4 +
 tools/perf/builtin-ftrace.c              |  8 ++
 tools/perf/tests/Build                   |  1 +
 tools/perf/tests/builtin-test.c          |  1 +
 tools/perf/tests/ftrace.c                | 81 +++++++++++++++++++++
 tools/perf/tests/tests.h                 |  1 +
 tools/perf/util/Build                    |  1 +
 tools/perf/util/ftrace.c                 | 93 ++++++++++++++++++++++++
 tools/perf/util/ftrace.h                 |  5 ++
 9 files changed, 195 insertions(+)
 create mode 100644 tools/perf/tests/ftrace.c
 create mode 100644 tools/perf/util/ftrace.c

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 3f3808e513fe..e8105083e67c 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -134,6 +134,10 @@ OPTIONS for 'perf ftrace trace'
 	  - depth=<n>    - Set max depth for function graph tracer to follow.
 	  - tail         - Print function name at the end.
 
+--filter-retaddr::
+	Filter out function return address comments (`/* <-caller+offset */`)
+	from function_graph output.
+
 
 OPTIONS for 'perf ftrace latency'
 ---------------------------------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 65983259b07e..c715cbebaabe 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -837,6 +837,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 				break;
 			for (int i = 0; i < n; i++) {
 				if (buf[i] == '\n') {
+					if (ftrace->filter_retaddr)
+						ftrace_filter_retaddr(linebuf.buf);
 					if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
 						break;
 					strbuf_setlen(&linebuf, 0);
@@ -874,6 +876,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 			break;
 		for (int i = 0; i < n; i++) {
 			if (buf[i] == '\n') {
+				if (ftrace->filter_retaddr)
+					ftrace_filter_retaddr(linebuf.buf);
 				if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
 					break;
 				strbuf_setlen(&linebuf, 0);
@@ -885,6 +889,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	}
 
 	if (!ferror(stdout) && linebuf.len > 0) {
+		if (ftrace->filter_retaddr)
+			ftrace_filter_retaddr(linebuf.buf);
 		fprintf(stdout, "%s\n", linebuf.buf);
 		strbuf_setlen(&linebuf, 0);
 	}
@@ -1850,6 +1856,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", parse_buffer_size),
 	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
 		    "Trace children processes"),
+	OPT_BOOLEAN_SET(0, "filter-retaddr", &ftrace.filter_retaddr, &ftrace.filter_retaddr_set,
+			"Filter out funcgraph return address comments"),
 	OPT_INTEGER('D', "delay", &ftrace.target.initial_delay,
 		    "Number of milliseconds to wait before starting tracing after program start"),
 	OPT_PARENT(common_options),
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 395f2866094a..136138932fcb 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -72,6 +72,7 @@ perf-test-y += hwmon_pmu.o
 perf-test-y += tool_pmu.o
 perf-test-y += subcmd-help.o
 perf-test-y += kallsyms-split.o
+perf-test-y += ftrace.o
 
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc riscv))
 perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 880eece0bc12..640d6d327215 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -156,6 +156,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__perf_hooks,
 	&suite__unit_number__scnprint,
 	&suite__mem2node,
+	&suite__ftrace,
 	&suite__time_utils,
 	&suite__jit_write_elf,
 	&suite__pfm,
diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
new file mode 100644
index 000000000000..42604811a2fb
--- /dev/null
+++ b/tools/perf/tests/ftrace.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include "tests.h"
+#include "debug.h"
+#include "util/ftrace.h"
+
+static int test_parse_retaddr(void)
+{
+	char sym[128];
+	u64 offset = 0;
+
+	/* Standard format */
+	TEST_ASSERT_VAL("parse standard retaddr",
+			ftrace_parse_retaddr("kernel_read() { /* <-load_elf_phdrs+0x6c/0xb0 */",
+					     sym, sizeof(sym), &offset));
+	TEST_ASSERT_EQUAL("sym name", strcmp(sym, "load_elf_phdrs"), 0);
+	TEST_ASSERT_VAL("offset", offset == 0x6c);
+
+	/* With return value */
+	TEST_ASSERT_VAL("parse retaddr with ret",
+			ftrace_parse_retaddr(
+				"__cond_resched(); /* <-load_elf_phdrs+0x6c/0xb0 ret=0x0 */",
+				sym, sizeof(sym), &offset));
+	TEST_ASSERT_EQUAL("sym name", strcmp(sym, "load_elf_phdrs"), 0);
+	TEST_ASSERT_VAL("offset", offset == 0x6c);
+
+	/* Bracketed address */
+	TEST_ASSERT_VAL("parse bracketed retaddr",
+			ftrace_parse_retaddr("foo() { /* <-[0xffffffff818534c8] bar+0x20/0x40 */",
+					     sym, sizeof(sym), &offset));
+	TEST_ASSERT_EQUAL("sym name", strcmp(sym, "bar"), 0);
+	TEST_ASSERT_VAL("offset", offset == 0x20);
+
+	/* No return address */
+	TEST_ASSERT_VAL("no retaddr",
+			!ftrace_parse_retaddr("do_filp_open();", sym, sizeof(sym), &offset));
+
+	return TEST_OK;
+}
+
+static int test_filter_retaddr(void)
+{
+	char line1[] = "kernel_read() { /* <-load_elf_phdrs+0x6c/0xb0 */";
+	char line2[] = "__cond_resched(); /* <-load_elf_phdrs+0x6c/0xb0 ret=0x0 */";
+	char line3[] = "do_filp_open();";
+
+	ftrace_filter_retaddr(line1);
+	TEST_ASSERT_EQUAL("filter standard retaddr", strcmp(line1, "kernel_read() {"), 0);
+
+	ftrace_filter_retaddr(line2);
+	TEST_ASSERT_EQUAL("filter retaddr with ret",
+			  strcmp(line2, "__cond_resched(); /* ret=0x0 */"), 0);
+
+	ftrace_filter_retaddr(line3);
+	TEST_ASSERT_EQUAL("filter line without retaddr unchanged",
+			  strcmp(line3, "do_filp_open();"), 0);
+
+	return TEST_OK;
+}
+
+static int test__ftrace(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	int ret;
+
+	ret = test_parse_retaddr();
+	if (ret != TEST_OK)
+		return ret;
+
+	ret = test_filter_retaddr();
+	if (ret != TEST_OK)
+		return ret;
+
+	return TEST_OK;
+}
+
+DEFINE_SUITE("Ftrace return address processing", ftrace);
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 5982c4e62cd3..cd12ae85ccfa 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -180,6 +180,7 @@ DECLARE_SUITE(perf_hooks);
 DECLARE_SUITE(unit_number__scnprint);
 DECLARE_SUITE(mem2node);
 DECLARE_SUITE(maps);
+DECLARE_SUITE(ftrace);
 DECLARE_SUITE(time_utils);
 DECLARE_SUITE(jit_write_elf);
 DECLARE_SUITE(api_io);
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2c1f880c4c47..5b082d09006d 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -169,6 +169,7 @@ perf-util-y += list_sort.o
 perf-util-y += mutex.o
 perf-util-y += sharded_mutex.o
 perf-util-y += intel-tpebs.o
+perf-util-y += ftrace.o
 
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_counter.o
 perf-util-$(CONFIG_PERF_BPF_SKEL) += bpf_counter_cgroup.o
diff --git a/tools/perf/util/ftrace.c b/tools/perf/util/ftrace.c
new file mode 100644
index 000000000000..452231c01568
--- /dev/null
+++ b/tools/perf/util/ftrace.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <ctype.h>
+#include "util/ftrace.h"
+
+/**
+ * ftrace_parse_retaddr - Parse return address comment from trace line
+ * @str: The trace line containing the comment
+ * @sym_name: Buffer to store the parsed symbol name
+ * @sym_len: Length of the @sym_name buffer
+ * @offset: Pointer to store the parsed offset
+ *
+ * Extract the function name and offset from a funcgraph-retaddr comment
+ * (e.g. "<-load_elf_phdrs+0x6c/0xb0").
+ *
+ * Return: true if successfully parsed, false otherwise.
+ */
+bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset)
+{
+	const char *p = strstr(str, "<-");
+	const char *plus;
+	const char *bracket;
+	size_t name_len;
+
+	if (!p)
+		return false;
+
+	p += 2;
+	while (*p == ' ')
+		p++;
+
+	if (*p == '[') {
+		bracket = strchr(p, ']');
+		if (bracket)
+			p = bracket + 1;
+		while (*p == ' ')
+			p++;
+	}
+
+	plus = strchr(p, '+');
+	if (!plus)
+		return false;
+
+	name_len = plus - p;
+	if (name_len == 0 || name_len >= sym_len)
+		return false;
+
+	memcpy(sym_name, p, name_len);
+	sym_name[name_len] = '\0';
+
+	*offset = strtoull(plus + 1, NULL, 16);
+	return true;
+}
+
+/**
+ * ftrace_filter_retaddr - Remove return address comment from trace line
+ * @str: The trace line to modify
+ *
+ * Find and strip the funcgraph-retaddr comment from the trace line
+ * in-place, removing trailing spaces where applicable.
+ */
+void ftrace_filter_retaddr(char *str)
+{
+	char *start = strstr(str, "/* <-");
+	char *end;
+	char *ret_ptr;
+
+	if (!start)
+		return;
+
+	end = strstr(start, "*/");
+	if (!end)
+		return;
+
+	ret_ptr = strstr(start, " ret=");
+	if (ret_ptr && ret_ptr < end) {
+		memmove(start + 3, ret_ptr + 1, strlen(ret_ptr + 1) + 1);
+		return;
+	}
+
+	end += 2; /* skip end-of-comment delimiter */
+
+	/* Also backtrack any spaces before comment */
+	while (start > str && *(start - 1) == ' ')
+		start--;
+
+	memmove(start, end, strlen(end) + 1);
+}
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 950f2efafad2..50216d3fef64 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -39,6 +39,8 @@ struct perf_ftrace {
 	int			graph_verbose;
 	int			graph_thresh;
 	int			graph_tail;
+	bool			filter_retaddr;
+	bool			filter_retaddr_set;
 };
 
 struct filter_entry {
@@ -93,4 +95,7 @@ perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
 
 #endif  /* HAVE_BPF_SKEL */
 
+bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset);
+void ftrace_filter_retaddr(char *str);
+
 #endif  /* __PERF_FTRACE_H__ */
-- 
2.55.0

