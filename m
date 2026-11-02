Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.102
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793655678;
	b=ckcwOjQ+LYb9xaB/+vY97G523OtJC2Q78PL/iKSN4XEAUpujcVctXDdkssj+W4heRiTs
	 08Bn74BE38akE2nq8qy+tVDfCKxTQIM7v890YrZTIZqeR55puXQJPEZQVVmtdGJ7JrYMq
	 56B/kRsXnTxd3Bh6NQRLezONy3lwc+sdodZDCxOuZpej9E7h/s2vS/olo2olvhSWx9jCA
	 WPwL36t8L2G7jOUtGxqJsI1fnjCF7zJhsPqAEDaqTCpfOBS+oLtd2XGZ2QLs8UXvtkvIb
	 wRhQxTfA6h9SRSzbmdug4IwD6MRRn1BmMi1PwfkPVVXMyzUtVgDbG4AGvVOROpMJ3Dg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655678;
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
	bh=rD0yRWY14jT4oE4urHl/JA6WolPLJ3OZyjGTE/vk26Q=;
	b=kouSt0DEGQuXGF3VdZUYDjUtMbG8hvMN+6Xlqym2j5HZhijuetD5Hk9GVNmTsszC3hsN
	 FFT30EsmxEWMEyF5hoT7jglII6lAiy20Ss0zC9tQmwMdKDBStQDz7YySn5/iOmsUhwrkR
	 mb0XexxZ6e//Zrajd4Fqau2VbG7DI6Yseq53aIBSk6zYC6LHth7D63Ea36KQK2ItSF64q
	 69/E1CpzIcKZAtO98iy51HneehsEghL/wz4qEY+C9B5LJ/qM4yyMCedI30ozwLtf+5zkw
	 BeAyNDThX1OjPgd9EKZsQ3Nq82SfGdIXF8NT1xqMWZpyoJxojaCTp/rQTFt3yCExXSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.102
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020102.outbound.protection.outlook.com [52.101.195.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F515606D80F;
	Mon,  2 Nov 2026 21:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F515606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAfDEPYy7A7cRytsIb65UZoAFCMTk79sqPojWq78EpXOMAxAmYev0VuD3PSqyK+VrHN4o6ATH9fgZfXsYcFDWGG8xNciP5e8VYOvqW/jZiYwcwosPuUp7bQEy/4QQT/KJ7a84BMjGqxbT6OsIvidR+7oyZLpoOZcFtcAzOlQQKSjkvANtoqii7w5TUN9IhiH49tSz3mhQ6TiiEr9HVOLGQkq7cPl/c5PiFzyW6cjsbDpyQTQKvpOg1xLC0QbZbDnv0v58q5LKUbQ1z1ChRFu6gaxfhBzXwR3mpQChnEYno1BHF3b7vxP+vTq+00ZPNzGV5WX8YsasPGFoIBw4NEIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=rD0yRWY14jT4oE4urHl/JA6WolPLJ3OZyjGTE/vk26Q=;
 b=bnBYqiVvdowvIzjfH9A+RLzCvr/4nnvBP7mCyr19BVUGce5GLkJ+V38jrv+sorA2noEfBbetOLFchim6f4a7RwdFkxGPyOwgM78eApj4tWLuTokEQ209KsDdP5SGBoVR3RXNmiI2+MaJ4ngSh5YLIlVqZGAhHa9cCwRpteIfEb6FytaA0ybrpJ3oXWj8dQu1jgbvRlIEGEjPSLbkXTRac3vX5Wtk4yqG3PdDG6OUnOUKsl97tszNJ88cd+DeWtKmOmqC6lN3M+ln98y34kRsDRrvNVhTxazg7EuTDKX99A1PssH58FRAsx2mxagKnjizlSuqzyaSGMNS0Y7uIHl+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by CWXP123MB3814.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:4c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:41:14 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 21:41:14 +0000
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
Subject: [PATCH perf-tools-next v13 03/10] perf ftrace: Support filtering return address comments
Date: Mon,  2 Nov 2026 16:40:47 -0500
Message-ID: <20261102214054.911298-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102214054.911298-1-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SCYPR80CA0001.lamprd80.prod.outlook.com
 (2603:10d6:300:30::12) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|CWXP123MB3814:EE_
X-MS-Office365-Filtering-Correlation-Id: 5acc28d0-05b9-4a0a-9479-08df392a04be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|3023799007|6133799003|10067099003|18002099003|22082099003|261102123227099003|56012099006|261021135927099003|261022115727099003|261022113327099003|261026121527099003|261022105027099003|261026135527099003|261026140227099003|261022075727099003|261026130827099003|261009223027099003|261021133027099003|261028144727099003|261021130227099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	detOvzbETMM3Y8bDj+lVyr09B891E7+rSKOT+RI1Vy78b7iF/Pp0/P+fMfuf84mDBf3ZSNW/ClltNpT7U/mKzj+eAg92IM3axyemieXlvsNKYorlgKSkq5rLe9vz95DiMYSE5fzzM38vLTKyrYi4c8UL2s5jetrrio0574z9eBfPLyR9GT1wjBOgnUoZGfUotTBTk8G8EQkWBfMpzBWPJnWljEsYtFBSMLPMfqCcQgAhSouZkIhPQq2U875JjnTxW+dn/VQtuiW4HQeu3pxg6nXnwY6+zDBmu1Ltt60tPYwfK63Yz926/OSfA8YqhhxHFi9Xaf2iUZHpk0yezRSv9zGTPAKHRB7D5odcqGhAk/B2AVctXZZaiRlgFFWDzcJDYW6bGXguEQBWFjeS8WaJl+Jvathvf/jS+Nq0kq/mi1LkLOiFxrkeMLmnnjoA+NQ5+GmyyNVqrw+kN/ZDv5en9AfBfooURvorlrRdUQHkc6F+VvggORfRKDGeQWv730MBNbNDu1fsj+pJl/q1Sw1XsbfqHCYQnR1jX3oYaQP5VgWSN2xntJQHiil50BEgBh2aqBmogsg2MGAL+3VFsgpLtsokNY/OzCKptHVXhFPrRkimuJTDqsglBbz+sXdU+k1W5WPiLE5VwL0OPavNr9NOdgGUoL9mQ5gveqZBGiEWBvM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(3023799007)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(261021135927099003)(261022115727099003)(261022113327099003)(261026121527099003)(261022105027099003)(261026135527099003)(261026140227099003)(261022075727099003)(261026130827099003)(261009223027099003)(261021133027099003)(261028144727099003)(261021130227099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dgFD0dVVcdqsSbSQ1ENoFm/h6UZNsEQi92dOPsMBpERHEgFHQKoLf4Ne6xAV?=
 =?us-ascii?Q?O/UmqbctlsjsxWYKvpL0OgZM/PK6K2E4dTcUcqegYxMdnpbpuwFDwxIgckZI?=
 =?us-ascii?Q?mnprcj/E9wclpH8NIFRidv9YurR6wU0xhCicn/qEvZ4eX2BsEDGj4tbkFW83?=
 =?us-ascii?Q?7JxnF8iy2dEjeHB8LNTBGBJJgq61zyBZyvuBkX0C3/DG8Bjbx4DeJNBB2UVy?=
 =?us-ascii?Q?g6w6QTfN/hB/O55vmFApAVVqIWOH0Pc4SpdRTcxSvbS3Nu5q8dIv3f+gdrMr?=
 =?us-ascii?Q?rIJD0DSdUsb4R1YHUlFnU9I8nWCCXkEu/0iA3AUrXkpWQc19DEStbE9C0Dr4?=
 =?us-ascii?Q?w8jaKQO3SOijTEkL0CB5BzB/7xxr8IGZYFTWT0/Q270dJ5kY4OUi7HS9N4js?=
 =?us-ascii?Q?hXZB6wG9eF2Q7ANjqZ9iqsQokiSExsKIbSGNFtZrZ3w1hKzw6OTFDz6Lcvbt?=
 =?us-ascii?Q?MiMd5jsmcHhbOjOaVlGxE0t8bxXUq0LHv3mpcUy0BO5q1A18GUxd9nrYoya9?=
 =?us-ascii?Q?M6i9UUr97S6bWLg0eZKoB7/z3hhjt5zeJnCLl570jPNVEwkXazMMFi8e4RaD?=
 =?us-ascii?Q?xS2nv/aYmfBL7k3Bxo78zatMR3CVp5q8z83y2c2pxg+CkpRDbNo8M70IRdO2?=
 =?us-ascii?Q?Qz7PraS7rtJQ2Z99gVGPzbEEKpMeKDq5bR5coMyMv8htuF6IwLd2s5bO8sg4?=
 =?us-ascii?Q?U8Vm3g8LJAzbNAzsHnLFa66Yog40Q8T8FysFinB64v51aNLSj3d69fxlUmdp?=
 =?us-ascii?Q?WxKLzTZ9wn1A79lW9r/k5EnIMoIpb1WxKUzWYMTAddbD8jjG5qolBrCMlDC1?=
 =?us-ascii?Q?cwlSfhK0cj4FU/CeZ0s8J+eBayZGF7EGLxH3s1ibC9lk5vfSqNNFi7ja52Xa?=
 =?us-ascii?Q?KyRV0f8Cmjh0MNgM04TFnsbbr/D8Mh+pIE/HpKemmFan9zY/N6hpWpa40l4P?=
 =?us-ascii?Q?SmelpZYFCv7hvYRUiHw/3yqAJRk+ecKvBoy7jPkR9hZ3nsPkjt1xZJhCnnm+?=
 =?us-ascii?Q?qcMaKNdbaDZDa9faUs9tUv2AbUnxu0M4v4Zefugl4JG613g5LS7RR5aE5n35?=
 =?us-ascii?Q?xjBPtLI0H7+jgePBKHdqizRX3PGuCnXUphqnF+DTQ6QdFwqDaNFl52ce0Tma?=
 =?us-ascii?Q?H4tw08Kze2n/LWmiEdiVR1p9VChm8HfTpIrob3ezU9FJeLuvNjliuyOW59TH?=
 =?us-ascii?Q?qFkgmum+B8/EfXgs2KKP+PgTxNdT6yya1xDpzQoxO1z/TyGP76019+0yAiC4?=
 =?us-ascii?Q?suCVpIFXGp5iymJ4ZYlp+7QDO7ytir4CdbCtxGsq22FQkVGmuqgRrAMma9iK?=
 =?us-ascii?Q?8PbSwlndEWPOKzlB0Rte+yV/urlDYJbjLT1Zb8OvdUYlX0JAUDmhQKlUvZQY?=
 =?us-ascii?Q?eYLSj+b4LUnhUI9Er4V6ST7cFKV8L3MWHEzTAVt3O7e5bOo+/ZLNqVQ8sWCP?=
 =?us-ascii?Q?4jDgACmJ/pRxep+tqnQX13toIYdBOOXFN6pjJes4x3Ki4F5Z0QzWki/OyCBf?=
 =?us-ascii?Q?VN0ueH2J9IrHyFO+vwaGM0qfZyga+qLsxcyn9lr3QRQ+0Vbjpe0wjHFO05tP?=
 =?us-ascii?Q?5IvOyG6R01AlRk+i4/yH2Sj7E/+u/BOS4vbnADGdIJGDpOUJIqAPLK2wkaK+?=
 =?us-ascii?Q?Pa+nLgqf5fQyEy/A5p9bUQtSWKDyNKlgijvGt5haeQbVv3SsXDNvoRzUalty?=
 =?us-ascii?Q?Fgcr6BH36C8Fx64ntxKZVOa+tXqSbxN1xtfENV4Sy1XBJVXNNBjtJ147xaxv?=
 =?us-ascii?Q?rNxi/mCGwA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acc28d0-05b9-4a0a-9479-08df392a04be
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:41:14.5936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBAFSgMAUSU5OKK9JW1qmTc76o2tjG1aXNhD8HDpDRolmHr47t1/BTFN2aY3AWP4ZB4nKr59ixMMu4n0SHIKFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3814

When tracing with the Linux kernel's function graph tracer, enabling
funcgraph-retaddr records the return address of each function entry as
a comment in the trace stream (e.g. /* <-load_elf_phdrs+0x6c/0xb0 */).
Whilst valuable for tracing execution origins, these trailing comments
can add considerable visual clutter to the call graph, particularly
when examining deeply nested call trees or when synthesising higher-level
abstractions.

Introduce support for filtering out return address comments from
function graph trace output whenever return address display is not
explicitly requested via --graph-opts retaddr.

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

    2.  Automatic comment filtering

        In __cmd_ftrace(), filter return address comments from whole
        trace lines whenever !ftrace->graph_retaddr, ensuring clean
        output unless the user explicitly requests return address
        comments via --graph-opts retaddr.

    3.  Automated verification

        Add a dedicated unit test suite ("Ftrace return address
        processing") in tools/perf/tests/ftrace.c to validate comment
        parsing and string filtering across all supported formats.

Tested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-ftrace.c     |  6 +++
 tools/perf/tests/Build          |  1 +
 tools/perf/tests/builtin-test.c |  1 +
 tools/perf/tests/ftrace.c       | 81 ++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |  1 +
 tools/perf/util/Build           |  1 +
 tools/perf/util/ftrace.c        | 93 +++++++++++++++++++++++++++++++++
 tools/perf/util/ftrace.h        |  3 ++
 8 files changed, 187 insertions(+)
 create mode 100644 tools/perf/tests/ftrace.c
 create mode 100644 tools/perf/util/ftrace.c

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 65983259b07e..e00621703dd7 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -837,6 +837,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 				break;
 			for (int i = 0; i < n; i++) {
 				if (buf[i] == '\n') {
+					if (!ftrace->graph_retaddr)
+						ftrace_filter_retaddr(linebuf.buf);
 					if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
 						break;
 					strbuf_setlen(&linebuf, 0);
@@ -874,6 +876,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 			break;
 		for (int i = 0; i < n; i++) {
 			if (buf[i] == '\n') {
+				if (!ftrace->graph_retaddr)
+					ftrace_filter_retaddr(linebuf.buf);
 				if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
 					break;
 				strbuf_setlen(&linebuf, 0);
@@ -885,6 +889,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	}
 
 	if (!ferror(stdout) && linebuf.len > 0) {
+		if (!ftrace->graph_retaddr)
+			ftrace_filter_retaddr(linebuf.buf);
 		fprintf(stdout, "%s\n", linebuf.buf);
 		strbuf_setlen(&linebuf, 0);
 	}
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 58858f3d2bf9..54923c162f2f 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -73,6 +73,7 @@ perf-test-y += hwmon_pmu.o
 perf-test-y += tool_pmu.o
 perf-test-y += subcmd-help.o
 perf-test-y += kallsyms-split.o
+perf-test-y += ftrace.o
 
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc riscv))
 perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 0b8897fd42ca..5f16cf5770a1 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -157,6 +157,7 @@ static struct test_suite *generic_tests[] = {
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
index 20ae3609892b..384599ca18e6 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -181,6 +181,7 @@ DECLARE_SUITE(perf_hooks);
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
index 950f2efafad2..a3a679f74e9d 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -93,4 +93,7 @@ perf_ftrace__latency_cleanup_bpf(struct perf_ftrace *ftrace __maybe_unused)
 
 #endif  /* HAVE_BPF_SKEL */
 
+bool ftrace_parse_retaddr(const char *str, char *sym_name, size_t sym_len, u64 *offset);
+void ftrace_filter_retaddr(char *str);
+
 #endif  /* __PERF_FTRACE_H__ */
-- 
2.55.0

