Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792983477;
	b=ZlyH1fCKhkQFwaClBfp7U6L77slPwXnaDHXMotFZhxL8nkLLzlPPIl5W8wGe+2E9QeSh
	 i0KXKbxVv/dUxgtVwcdcwHpqZHn7VqvtRe7h4clzxgQkQaU6mloxuYJziQrQxoIquOCoE
	 IL7Px9SiZL0gWEYFlHSgvuMaGZY6NmTGrmsI30DsD9WKQIHyKx09V23alpJ7hMGudEW7/
	 lP9j0aujFZmGiGA/E3Yq+9rEkl7GZF0FLDJR+Az8vAA3xxe//EAu50TR3BGCWNTAEy7v+
	 xJkMJms6hgJ57orGisXRgrI8oY23x2L5siae7Fh1DZ3GjVlI4ILU0HVyKBDX0gGKjGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983477;
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
	bh=eZp4rrmdY0s4A8o1LRNbbqn1bJ5GrqK6NKfXRyZbmu4=;
	b=0hP4rhpN3o4iqMTcr3C2UpLAc3b/4sKqoEYOGniNGPf7wq3LbU8cgKa4oj/r52B0Bdya
	 NB7Tn39pGlVtyYxmT8udlKlhNUvge45t5SWGPdqu3QMdMdehYhUubGEJOxH3aqcWduIvL
	 6qnrBa2rrsfqx+tjmi6bH1pNSIklYLL/AzPR9Zn8pnNt5RMlUnURCvmkB8TCsDw8VTy7N
	 yqP+EsF+cgwNVm5MXYy3hQqKNCOCrKXRilsgtWEnjvVB9N+T/ZZba3WE43BQnhL01bqWX
	 qj6p81/MaXbUjOQ8eEUTG0UMzzXiOJEIPKRsUrfh0+cP2Joh5y2xvCU5ht7jch6YnzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.83
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021083.outbound.protection.outlook.com [52.101.100.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD83606A31D;
	Mon, 26 Oct 2026 02:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DD83606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+9ZSdJegzyEb6yBDd9L2zeSDFwb5WHlDgkKZPUrn+wWfRdlq2Drw5OYTsDirn5F2oQ4FEKOtzLAgbJe4XYgdlr3HL9aOhNkzeffCuhpB99LmHDpmCkTUhDAJBU8DaobhzSWKguIr5CCJ7lB/ImNGi2q8tb3oYjP15IDJxFeOijNjM0XoWXkBxJvDlyCRwbWgar5r7b61UZxeO8NUt4Z7Jndwce8eJ9pk72SFL8FJcvoP5B56ayPNAMBQJkx34AWXEGDNvxfKrYqKW166vBeegUq5FQ1Ql2JmE3RsXWXziq5RFmIQSeXaHTmrZbki2+ZyWOq9nMC7K8sdFbmYzo+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=eZp4rrmdY0s4A8o1LRNbbqn1bJ5GrqK6NKfXRyZbmu4=;
 b=jKjScsqctxoGUxkfYjQnVm1UfgFAjGZZXPJg1xOjXj0VwVPDBxg9TJ2xmgzE3HXYFmrwiUnsgVMLvcWlJhSrxwqGjxLhWk25Q5IBtSxMwpfhP1DfKRCsnXpMY3YHy91k/m2+g4P4OuTwvVjcag98xEufKy5zzvfIZpomJa2nmTR0s6ddhhQh2SuKwILk/jXgfgBY/33rsGKP7/E7VqkSzsBjLOz4j6ixUGOeBmmQZdRUb6rsiEu6r9w0G9pAg0+nfz6o/SP2q+rXWg7hSd7vZOconjba+0mu6ZrTw4a0AXEGY1M7d7fOW9fvpOQ8HN1iovXfgzrDkRsqr21kI7xPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB9009.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:285::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 02:57:54 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 02:57:54 +0000
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
Subject: [PATCH perf-tools-next v12 03/10] perf ftrace: Support filtering return address comments
Date: Sun, 25 Oct 2026 22:57:28 -0400
Message-ID: <20261026025735.546101-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025735.546101-1-atomlin@atomlin.com>
References: <20261026025735.546101-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0184.namprd04.prod.outlook.com
 (2603:10b6:408:e9::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0db75a-0a8d-4b6f-5391-08df330cee36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|56012099006|261009223027099003|261021133027099003|261022105027099003|261022115727099003|261022113327099003|261022075727099003|261021130227099003|261021135927099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	wxop4gHAUXRz5k0HTSCP4j8cgzFAm5IZSqnjsF6IS9IEL2cF4d+H1Ua0MliVd3oEbcLjrfCyiGIFBZcu/io0wdWKZwKGvifbAvEB0B3kBonkCLPm3Y8yD1MgVNK/X6nBhD3t9gvXAzVJCDhjDq9xj86plTvEJTfYWGUWhnYan+S+mquxhRXoL432B0fbZcDYZ4n7Yw2CeT2dXgR9npuPB2f/caSzqYfrvbmi46TpNVH1bMB5vjVS3KgV2vDOiuQL5T13ijXHDme5b/WwYKXk1J5YmNZJ1Dg7llmwmiiPAxCfrg29HezOLz/F8ganPd/8qfTpOZ9bfXf5Vh+UaByuz4++QEMaxgCUwAgNS/rLqlNEj8ln/vPFpwcFjwPyO+M9/bBDaMNSyICJmh0AGSh9Wp7KDs8+0fkRzgu8vv4SBQixS2EgS0O02H31YIdDRXlmscw5NmvFazsAgo7eQA+NRa9XyWKrGFE24CjJQuDAL8+JxPcbRcHsfqox/8HlyXWabEZOVTXMcGGlTov/E4FzHPiz/IzZWkGUvjd0jzF4qBQ9MuAQ6vYKR9Oz2BNwiWx8NGe1F9QEDhb6XECkpiqTXryexsWm+F9S1/63kSKJ/BuJMj0kIe31rKPdxAzqYX3kedybp9mLd32QRfdjN2dwEFZ2RBFSCGtd3cAqhhhl8+o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(56012099006)(261009223027099003)(261021133027099003)(261022105027099003)(261022115727099003)(261022113327099003)(261022075727099003)(261021130227099003)(261021135927099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Xj3Q2/5Y2EwPaC0bytR8wBWIIwdH07eQwoAuIZOWDWwq3c5Gd48/mXX8P0g?=
 =?us-ascii?Q?QMwKj1/iWDuDwZpqgzhefCXZKqRgU1XPe5xmc7chCd+rM+DFtTAbcFqeO2fZ?=
 =?us-ascii?Q?HCb6LhsfD0Ko2DTr/SwRHrUqa3Fppb1NoAGwy26nrABtDWEvhq6egAxuK+J3?=
 =?us-ascii?Q?mK10tTQDW1s9WMDj7mA9uhXZVNa1eiU9Z7DEBTaKmyxXGfz2ZblemL8I3Fo5?=
 =?us-ascii?Q?I27hEhQprBsgQIGJC3spn3o5hbKwMko7iz5z6aZzcZekEtkUvCflwgaSXIYI?=
 =?us-ascii?Q?DGJEtYIwhCmGLBpxk1uO1EdfPhYsYjC+N9IrTnpoF+lTIdecn1i7gcctBPFT?=
 =?us-ascii?Q?k5eQ0f358dCp6KnqLuA9lU55CpuubuIAZTVHNHP3U9l+Hca1Q61eCthQHL2Q?=
 =?us-ascii?Q?K/7XRLtYmmXCZ/VvseHB5CgdELKji4PwwBMfeA894c+XsWS/vtISlDbjGH3D?=
 =?us-ascii?Q?F0u5fBxl2W8yl23myOoyEvzjHXuu/e1M5EC3NfHLfPfgbDeIBHKknHZvdxEH?=
 =?us-ascii?Q?unJlixJe8E5AnSLs2XQCO+DZF4XxCip+SYoSDH9P7tCH5pCt7rzhZ9rqy6vZ?=
 =?us-ascii?Q?vZaoAZ/0bI0ZExKHk6DND4h43mAfZGRj55ISgKRxjp3TCB2q0b4ow5yn6XkI?=
 =?us-ascii?Q?lq1qmNEyUpEr7NoOZ+genceDSIjcvLqjYxviffopkMzPtdaVt+VSQM8m4XNu?=
 =?us-ascii?Q?N1tDzo77JFBLYgSUSL+EhpkYBGANK9ViiSBnPmcA8MyjRZfZzyND+jD2/rQs?=
 =?us-ascii?Q?E3JTWS7pBFB1XmiRnCT7AgSz6l2YrJF++cKsXQAXRD8INVGZ4LG1iArXeH2X?=
 =?us-ascii?Q?1KbQj3IDCRLn4e/TSdYaZmUHHhBcIcE0HnKxodF/hlQXHEV5cK3S1SApkuz/?=
 =?us-ascii?Q?YTGH/+4X911pg78zBxNwhk4nwmw/ToeVRSBPOF1QhgztCVQm6Gg8UskFvndc?=
 =?us-ascii?Q?OkfJrXtfTDgPniu/zw/bfwELeikwjJmXkGwtvTT7O3KIJfsJjoQexODWmNXG?=
 =?us-ascii?Q?dZjDQVTkK5kbl7QSmiBOg143tFiaJrA9ApETv7/LKg7lDNaxJw7NgNNx+8Fz?=
 =?us-ascii?Q?ly/HQ60/2NFWOaznof1vKvy3FpaEybdyz9kla2zVi8INl5rF6Vhn0vjGKFUM?=
 =?us-ascii?Q?0MK7o3XXXNRvZf98K3GZ0K95DxGZWnsnuoKAfloZnFr2YJobuj9KZyP+luwU?=
 =?us-ascii?Q?PQBO16c5wxz7cU5TMMBB+g/olX1/lrl//pfti+hgQ4AUQiYfsGOpdw6SkPGL?=
 =?us-ascii?Q?nVBps8B/R8BUC30Euuc8Byzp9o4nemPwfJreWtNteYQl8VxUjoIH+EYpw19C?=
 =?us-ascii?Q?D9niHBwSLqS8SJdcqTouRdfywUdMSv+cn6af6gLk4cVv9/2Tezav9LSAvMQr?=
 =?us-ascii?Q?x1lEPPXKTHoHhKhZXOuj7XaFhSvxL6+ufNJvzjfvnmFAmhCzX/18ANpnkb/c?=
 =?us-ascii?Q?uWfAfRkC3SXsbqiz5UckXlzI5gk9mp8I7rD3fhLpCuonp/Cw5cWJzNis59sC?=
 =?us-ascii?Q?66iXuMxVxc9e8uQzIajRX/CGq8gqxz0AnQCIUlZ3Qp3oKgYzQw6o7th2cYsI?=
 =?us-ascii?Q?l3VHdJABm8La9E7GjUmThX1cToKcv974/nJsyvsR/L8Xqzu+U2ux1r5JIV33?=
 =?us-ascii?Q?rBcMs+OxP8zKPweZFQNfO0HccbDkP6qp2Xo2W3lR3mylci5siUbmz/qXL02S?=
 =?us-ascii?Q?7HEeK17QVC99Ds0BAvGSNiwCL048HyYu5FCEWCb0Su3fSnxGkmUhr22nA8u+?=
 =?us-ascii?Q?YEjxJU1Lkg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0db75a-0a8d-4b6f-5391-08df330cee36
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 02:57:54.0553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uKDDGlDv5M7BDrJqPUIBueIMPoZPEY+ddJGia0puBlF66bIc3lngVvNTQnEjQTXYCrMhhO18HFnc1ExP3TMBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB9009

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

