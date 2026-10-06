Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021079.outbound.protection.outlook.com [52.101.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E14AD7F4;
	Tue,  6 Oct 2026 23:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329313; cv=fail; b=QuMPIvguTALRA/jbkofQHpK9rvgwhk58LEAazwrKZLPY1niaoF5MZ+TzNKcx896ehcBakCp1W3QYNA07R6wDK3RmbK2qXdC6O772EnDoDj5DQcARNJRwa/3Z0JboCfWcpz9FBqyC5MoF9mDiO8z8tBc0g22ZhaWXjJAJ6PScOR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329313; c=relaxed/simple;
	bh=nFGDiVpJco1EwoHKOizC0/QO0dS6c34d1cNGFhy+EiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TON1rQJjxre3EybrkQW098G4+OixcaytcgZB71qcryb+VOJk0nkWB5cxpVO6cXHXDaRrNLQ4/9Z88eU4wMSH1VoHlXllwbdu5GWGbyLpw0Z3736cpBh+m2+BGOpsZG5jAewwRfyJCWmZhuwQ5BgFHyXCOV1T6/bl6ApHHXljUZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnJ/UmL1fqxomsQ+8C0/6yJD3KZWl5f23EXrJkTVSEfuXETmJ9MTU7bAsWqBj70ljuDZRqwOXDv8e1+eml5xseioOmGzGs354+Q7bNhG3UzYdkrLarBEjxdnMspVwJCBmfAUlXnzLb6czaksqk+wuxu5zr6s7fBODyXEx2hVM92prVWtQtp2eDlnhHX6lGUcKClFzWkq8mb5J8LE2fENuzCmvov8s2/pBmQyr7djFtzUnoZ1vtdkzPwqVMSB2GRiCjVgSCkWwRlpDBeIuAuKYn55Fm56MxCJiCVaOQCNF/SWVKI/1CVrWvQbaAMPZldBYcVo+f4orsYd8lgVTM7/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=1hekU8W/NBDwMM/ly75JO+B9cJxIOy8xInDG9kYYFlE=;
 b=X5GT0fBwTWkWLip2i9dNNUX79rB8Nj3bS2MyX1MLYgnX+GeYr1cx0ZyHd2VJrfcgu0CYGnDRq9TITz8gZpO79BwW0i6Hc2trMpytkD5FvwciIIeSTly57UGAbSXQlqT4STH+jH9RRmKYeylh9fL/t96YfvOHbqRyTmm+fAlEEXHtXjDocvruQ8usCgWtqGKhFisHPCmiUNgQcqAdM6qP5TvJhEekwgvJLA1L3UnB95+yR6fA4zWMP5jv7/dxdgi/ffkDjKz9S1D0TGep9d5rTiYVGkbBNEthINknS+5B1349i65thnawh3C6yMCUl1sH3Y7CJgWb37/JUEsqYCkLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB4004.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Tue, 6 Oct
 2026 23:28:03 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 23:28:03 +0000
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
Subject: [PATCH perf-tools-next v2 2/4] perf ftrace: Support filtering return address comments
Date: Tue,  6 Oct 2026 19:27:54 -0400
Message-ID: <20261006232756.65620-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006232756.65620-1-atomlin@atomlin.com>
References: <20261006232756.65620-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0101.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:351::15) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB4004:EE_
X-MS-Office365-Filtering-Correlation-Id: a1c9ad37-30a8-4218-e7eb-08df240177b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|56012099006|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	1pO43Cx+92oeuD6+bT/v80JsZcrSBFvWLROtK8GVPXbkCV1vS6FEy7pTcrJfb/y1rljkHZNRmYHtSJLT1yVBRNiraWJCRLmUBpCz70OWtTBPQSJxVlERI+Mg+vG8QZIY8UW7feP/ULLeE8acf2efUJ3E2Cf+H2NoALjhviHgdZVKjT7KcfIeIxmCxg47Xn/vJksLORDdhhmVuPRxpFjLmkWzvI8IgaI3oxwS6q4SmvCWhOY64i9A2kHPaQJKTbKyNP21sWRHCsz5Y1S05QUpX0ggy2AmQkn6yXNFDL+7dO2QJXIT4TubHvbwG14k4m3cv7KLdnJ+iWuieKdmEWixBPu2c1Uhgc+prSvARl+0nhNvG1SxlZgOlQ11Gex2diZrIGobryB6K8YedD52wsnWgSkfBVEfThvvLaZ3p+dbo4cahNcY/kf2V6Jq/DU4Km7+VA0mLiH76DDp3sy4J1YXHqGOFz5hh5oVnprLdSRScsGeXDYYdpE/12KXTJUwSps91h9IoB3zfdhyYrLRC5AGyzGVuanajLEve16NbVu8ZKtMK/AulxcyFVZSyyt1vapK1vroClEVwbS/s1mPHrgaPXA0zX6mzIY065XEWWQjC0J8IJvQPGRA0MnEUw9DIXNS8u6NO8slEaKt3Dsfyn6LgAyfWCMw8upC8mcsicLIYhw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Prh8fqdJ6w3PMio1incdbhWDb8p3cacf0hWFatpP8BDhZDGWe3rJij9LeogH?=
 =?us-ascii?Q?mF2I+jRqBJn9EPZaLi98dYajfp5izqgUt2nT3/wrt2sTKB5odxTNG6VJYvFK?=
 =?us-ascii?Q?U/XbFZK8UBemqaRtn2Vd8ObBc7LGTFgMcyfvS/yS8Vk5R+nzfZeokHyLmg60?=
 =?us-ascii?Q?6mTPbGJJL/ex8ia/V/tUrpjMjnMysoHbDw8lZTnAhrYh6Ma7cSiu7xlub2Ph?=
 =?us-ascii?Q?kVyhun2e4YFeCPrgyjMu6lcKYDrwxdqmcViGObhzERaxAjrdy9YanHtl4qtQ?=
 =?us-ascii?Q?3aPPBslNSMXPgLdSqQ6BvxBqcRUEOAPFzFM558LNdFAsuyVoD715tc/FUOB0?=
 =?us-ascii?Q?MgAO71Er/dkkxivuejYb4bHQFQRPKfD/XeWpM6I+tMO8GcttCwi+ZgOaFKiG?=
 =?us-ascii?Q?T9UtxVGcl8/UCjgXDKIe+ysoPNOmd19YRxKKRdWbzeej1dWjXSf/BQ8PUSYx?=
 =?us-ascii?Q?CrHds9xAbjOTmSk4jpVvHROkXN3ymx9Wa4nNE7IB8C6VTpobdB+Y8Ce3wgy/?=
 =?us-ascii?Q?tU/zShHlJLvHTkkGCAsPTkyOg9gzs/CnN7g6ViOJaVK+iiBmi2n/7/LMe01+?=
 =?us-ascii?Q?Fauo9vNAd57J1yfbR+yq2jSo8nGtFa6OqoFYN4fcX6AqYYiPzC9LuQd6ehmk?=
 =?us-ascii?Q?uhyRBE3UnsMJNb6rpcEuDqUHzOMT7cfMW0qApvcxPpb2B6sDELz3fLGMbXWA?=
 =?us-ascii?Q?xUzi9nWA2RdcKxIgRuInvt0OeVi95Q4kWia40O7lRkdYBzE/HeNEe2/wEANy?=
 =?us-ascii?Q?NfenGbLxjx6nZUSFj0F3bmu31UTXcwvdBXlgJzgHabe+dEv9xGPGxJhgWcST?=
 =?us-ascii?Q?hucYhzO1lMO4t5RCTkvbhUmaqjqbwZM/pWRledmNVHqpgRcj9BMdxNbRd2pd?=
 =?us-ascii?Q?rEqaI1VfO1eUCadGChdC4fL6AadRZ4mFRRG5u8TKsINXkZPPnx6yReIk+iLv?=
 =?us-ascii?Q?8nBz2I6tzndFgbncyuVJdfeMSwgA+MYJtPHpL56l45w72czk1+y0N1PvbwVS?=
 =?us-ascii?Q?9Lv5kTagMm6OjLTI/ypZLVWFKwNAS5HTdAWPRAng3ZpROF210PHFa9wdTe+E?=
 =?us-ascii?Q?cDULSJ6J6FThcyOSTA99QKF2o3Gd1+1vktWJqXvTEmmuZtnkGvQpiNskneD1?=
 =?us-ascii?Q?CvWnKYZ68xZyeE426bvZWe/vslYrx4rpsF3qc4v1DzPxE4Lqcg+39S5H8siw?=
 =?us-ascii?Q?0BMe7MRtqEbxHADYBXe4AqnOFg1xE47O7Mh0Jjyy8zswFKEtxy1t/Ib7i0s9?=
 =?us-ascii?Q?TwXba0fv2U/RZkSM9OhaA0FqswAdNQs6IknfnVgIZII6CBHP7zlu8IDi9Drb?=
 =?us-ascii?Q?hv9LSVDVYOJ0kyt47bcpUQtsYJCPMgcjI5j5tLUOqPbbF1iDlvoFZarGgkUX?=
 =?us-ascii?Q?QLv+zkr5TVi+G3heZ+eTcvkXQvprzKz2j4W6hWbvsD+oGcrpXrxTrhdh9OCi?=
 =?us-ascii?Q?vc0pGonamjvH94TKvNhmBdQDYvtTBPycSt2EoSm9Z5ickzGc1K0667glb0Ah?=
 =?us-ascii?Q?8IfZTYZZJJAOkvsrw72cK8vFJs+vns/s5+Fe7AKGVdWXERNuv3amq+R8ctKR?=
 =?us-ascii?Q?aSBkmy+FdAH3CJUPJ7zdbI3ORthBD0sy50KnhR/qK8s0Wn1iMKP1g2lqmuJA?=
 =?us-ascii?Q?GAJS2uyRxFrbAYwo9Cb/mhSwH/SPaGF8n8QiYfENqgIej5vPU8aef/SOdeCL?=
 =?us-ascii?Q?1k9SSzhLE5mOYD7t6I69gse+H6oToYksh0mPAhpdzKYKwElLWwSz9HvOndmI?=
 =?us-ascii?Q?zYqGfs+K6w=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c9ad37-30a8-4218-e7eb-08df240177b8
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 23:28:03.3168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1fEFIVxEopWIoVzeRg7PrxZ2nHY/rr+XsV/5fG0kXwcPMwuQ2xAfRogFMT29fPq8nl7B4idnvQQmBeSPkPvkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4004

When tracing with the Linux kernel's function graph tracer, enabling
funcgraph-retaddr records the return address of each function entry as
a comment in the trace stream (e.g. /* <-load_elf_phdrs+0x6c/0xb0 */).
While valuable for tracing execution origins, these trailing comments
can add considerable visual clutter to the call graph, particularly
when examining deeply nested call trees or when synthesising higher-level
abstractions.

Introduce support for filtering out return address comments from
function graph trace output. Provide both a standalone --filter-retaddr
flag and a --graph-opts filter-retaddr sub-option.

Key aspects of this implementation:

    1.  Return address parsing and filtering

        Implement ftrace_parse_retaddr() and ftrace_filter_retaddr() in
        tools/perf/util/ftrace.c to robustly match return address
        comments across diverse output styles (standard format, return
        values, and bracketed addresses) and strip them in-place with
        memmove(3).

    2.  Command-line interface

        Expose --filter-retaddr and --graph-opts filter-retaddr in
        tools/perf/builtin-ftrace.c, updating the documentation in
        tools/perf/Documentation/perf-ftrace.txt accordingly.

    3.  Automated verification

        Add a dedicated unit test suite ("Ftrace return address
        processing") in tools/perf/tests/ftrace.c to validate comment
        parsing and string filtering across all supported formats.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  5 ++
 tools/perf/builtin-ftrace.c              | 17 ++++-
 tools/perf/tests/Build                   |  1 +
 tools/perf/tests/builtin-test.c          |  1 +
 tools/perf/tests/ftrace.c                | 80 ++++++++++++++++++++++++
 tools/perf/tests/tests.h                 |  1 +
 tools/perf/util/Build                    |  1 +
 tools/perf/util/ftrace.c                 | 68 ++++++++++++++++++++
 tools/perf/util/ftrace.h                 |  5 ++
 9 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/ftrace.c
 create mode 100644 tools/perf/util/ftrace.c

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 3f3808e513fe..ee126604a8ca 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -127,6 +127,7 @@ OPTIONS for 'perf ftrace trace'
 	  - retval       - Show function return value.
 	  - retval-hex   - Show function return value in hexadecimal format.
 	  - retaddr      - Show function return address.
+	  - filter-retaddr - Filter out function return address comments from output.
 	  - nosleep-time - Measure on-CPU time only for function_graph tracer.
 	  - noirqs       - Ignore functions that happen inside interrupt.
 	  - verbose      - Show process names, PIDs, timestamps, etc.
@@ -134,6 +135,10 @@ OPTIONS for 'perf ftrace trace'
 	  - depth=<n>    - Set max depth for function graph tracer to follow.
 	  - tail         - Print function name at the end.
 
+--filter-retaddr::
+	Filter out function return address comments (`/* <-caller+offset */`)
+	from function_graph output.
+
 
 OPTIONS for 'perf ftrace latency'
 ---------------------------------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 4e77a0b2513f..ddb567781125 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -827,6 +827,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 				break;
 			for (int i = 0; i < n; i++) {
 				if (buf[i] == '\n') {
+					if (ftrace->filter_retaddr)
+						ftrace_filter_retaddr(linebuf.buf);
 					fprintf(stdout, "%s\n", linebuf.buf);
 					strbuf_setlen(&linebuf, 0);
 				} else {
@@ -857,6 +859,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 			break;
 		for (int i = 0; i < n; i++) {
 			if (buf[i] == '\n') {
+				if (ftrace->filter_retaddr)
+					ftrace_filter_retaddr(linebuf.buf);
 				fprintf(stdout, "%s\n", linebuf.buf);
 				strbuf_setlen(&linebuf, 0);
 			} else {
@@ -867,6 +871,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	}
 
 	if (linebuf.len > 0) {
+		if (ftrace->filter_retaddr)
+			ftrace_filter_retaddr(linebuf.buf);
 		fprintf(stdout, "%s\n", linebuf.buf);
 		strbuf_setlen(&linebuf, 0);
 	}
@@ -1729,6 +1735,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 {
 	int ret;
 	struct perf_ftrace *ftrace = (struct perf_ftrace *) opt->value;
+	int filter_retaddr = -1;
 	struct sublevel_option graph_tracer_opts[] = {
 		{ .name = "args",		.value_ptr = &ftrace->graph_args },
 		{ .name = "retval",		.value_ptr = &ftrace->graph_retval },
@@ -1740,6 +1747,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
 		{ .name = "depth",		.value_ptr = &ftrace->graph_depth },
 		{ .name = "tail",		.value_ptr = &ftrace->graph_tail },
+		{ .name = "filter-retaddr",	.value_ptr = &filter_retaddr },
 		{ .name = NULL, }
 	};
 
@@ -1750,6 +1758,11 @@ static int parse_graph_tracer_opts(const struct option *opt,
 	if (ret)
 		return ret;
 
+	if (filter_retaddr != -1) {
+		ftrace->filter_retaddr = (filter_retaddr != 0);
+		ftrace->filter_retaddr_set = true;
+	}
+
 	return 0;
 }
 
@@ -1825,12 +1838,14 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>",
+		     "Graph tracer options, available options: args,retval,retval-hex,retaddr,filter-retaddr,nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>",
 		     parse_graph_tracer_opts),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
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
index d2f594921e25..9663f48afb92 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -137,6 +137,7 @@ static struct test_suite *generic_tests[] = {
 	&suite__perf_hooks,
 	&suite__unit_number__scnprint,
 	&suite__mem2node,
+	&suite__ftrace,
 	&suite__time_utils,
 	&suite__jit_write_elf,
 	&suite__pfm,
diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
new file mode 100644
index 000000000000..596cecee844e
--- /dev/null
+++ b/tools/perf/tests/ftrace.c
@@ -0,0 +1,80 @@
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
+	TEST_ASSERT_EQUAL("filter retaddr with ret", strcmp(line2, "__cond_resched();"), 0);
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
index 9c96f33483d1..1aec32e094c8 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -163,6 +163,7 @@ DECLARE_SUITE(perf_hooks);
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
index 000000000000..5f582cf8531f
--- /dev/null
+++ b/tools/perf/util/ftrace.c
@@ -0,0 +1,68 @@
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
+bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset)
+{
+	const char *p = strstr(str, "<-");
+	const char *plus;
+	const char *bracket;
+	char *endptr;
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
+	*offset = strtoull(plus + 1, &endptr, 16);
+	return true;
+}
+
+void ftrace_filter_retaddr(char *str)
+{
+	char *start = strstr(str, "/* <-");
+	char *end;
+
+	if (!start)
+		return;
+
+	end = strstr(start, "*/");
+	if (!end)
+		return;
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

