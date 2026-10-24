Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792877167;
	b=wU6ac1OY70LMAkl24XpOWwyRPBb1QYMAHeQu2NhIKRLHGnCyuIXrcFrEXuP+/1EFYJm8
	 oLRG1KVvcK1B6lJ3AuUxYSClzAFwDOWNqM+s1piCqx8cdT07tTCv/Ld3OW3/brZXQMtMM
	 n6aU5Xm8QzgsuYseG1IUOh0LWqxSV7+0HHUEHcBrK0kUfRiwRsiueDvbtGO7FajU0I/BJ
	 bAsnWIDPc6JUg0bE333fQqZLDRqpJr1TOJxvhsPXb0hPRwUKUDgLZEwSujrxJKADdlfwT
	 2jI4clZgrO6PdyL7KR1N7oQW2pIIqfl+u4yt7+ud0aKSYgjIF9oLtvyWtxtN89FzqeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877167;
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
	bh=CGM9NdSO0nLu2zS6XJxcVz2g5F7Q3+ubOHl6eWfyQZk=;
	b=aGpCw86cJKHXHzeDYGMiHhG9+fvqjcMxHglKrbJoj+4uWe0xyaJ/6YPpD0O5myeoBO+1
	 fmMciL62AIck0MERDYS1LANoawVRr2MRPkwJqnMZ/gSadkTGloKcTaIy5fbI+VPyom150
	 zT810iMDva4F92FJXW8IQgj2U7ErPUdyYjfWlShlm6P6SWWiVLMTAjWVdeloNz/1QlOz+
	 FJJwTS9xtfmMk3mK5sU7/4s9c3bniVpTxvTStHrXAAaOaWBpee/dlEVFlsV7idjaiaBFY
	 CK8N+jJmaiN6LIOGJ2KmsJbutBgmwbW6OWsHVPCku90FVJK+SOSzcoYT7jz6A8PJ8KA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.108
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021108.outbound.protection.outlook.com [52.101.100.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB741606A334;
	Sat, 24 Oct 2026 21:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB741606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=io/G8I06rYUdQoBZrsFeEN/AhPL3sZo0qoNd6Igoc9fU2bOpFAWTBvxVkQZ9eGLzim8tplMRze34GguWIRl2wqFXR/GCn3QTOeTKhnvCtIY00nwm9KJHBQ69g9GFlzHhAAfSYF7p4yP70eLkZjPOlT13ZJ8vZ0gyAnuYrqz53+0TjN97qrt7lXHvuQ35pD7Di8K/A0nRHAlo5B6L+DZxMstEe+xUjlR2Q+eEWXNvyZAFlIsbaAZbef/rQKUWmTI68V9sQ4e1ziWIko7+yNx4C5yNSluFrIHqd1qAlgKVRNssnZfhljIbctd6Fi74PnDETgyPsJpxuKGB/Y8k4dwgXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=CGM9NdSO0nLu2zS6XJxcVz2g5F7Q3+ubOHl6eWfyQZk=;
 b=r8eH21y5/mZ/jH5sYEkROy5FntAh8w0BY4Ovu3G2NlW3+0MJfAdDnbAAhdDjGfUf9yZTFXk9HlBGOj428OJaMt0XfT+b5tXP3zuFLQVi+CR3TBw485mjuldLq2i9lQQcryGcZP/2e2SAFGwdTxfI6oUEku4946Ci3jIL2fhX1P88KGGGpLgXLzsNhcSBB2RDifY2k/sdwwtVFWAMkPRGLffq0c9jkqVNPvBL5oviJm434zfbIs13CtTtoOFjSak7mkF2o/W1WYB7pXm8h8iiU4AVKv5yS89cMTO1S+YNJGv4o1/7S46pTWBfOx3cK8ZLMpdHePZ38ui28UuLfu22WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6642.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:273::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Sat, 24 Oct
 2026 21:26:04 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Sat, 24 Oct 2026
 21:26:04 +0000
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
Subject: [PATCH perf-tools-next v10 03/10] perf ftrace: Support filtering return address comments
Date: Sat, 24 Oct 2026 17:25:42 -0400
Message-ID: <20261024212549.450634-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261024212549.450634-1-atomlin@atomlin.com>
References: <20261024212549.450634-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:408:f9::32) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 429a304a-b8ee-4ce6-89c8-08df321568eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|6133799003|3023799007|56012099006|261022115727099003|10067099003|261009223027099003|261021130227099003|261022105027099003|261021123027099003|261021121427099003|261021135927099003|261022075727099003|261022113327099003|261021133027099003;
X-Microsoft-Antispam-Message-Info:
	v8hJQe65a01hVMTOTJuiz+vqymbINIEFrh7XLRE3fXrXlNEK8+XY/QZLR32zhcVAIvSYLVZi4xPrZWWZSX7Eiw0rQ+97p/qX9DQpdRZ2x3cU9tt2Zgn1R6N+83atTcVU4mIau9iU6DjX0vJ6h9rj4I9uNbjMTYiyrGW6/3x9emnHLATMdp1i7GAZMmMFOwBWEOcHxp0c8v/PxuetCp51rhiwrlmuGScwm2k9ugN8PRbNHohBSShL11e33UDFOLMgaWOVWU0OeLzq4wQkg69SpKD30IqowQE4WjHfXF0UsK996uX54baZNRYasPSRzalKUcwDMZn+bW9lk8K/Hb9a/o9iFjdk5/zKU2UiMG2fX1QkdZZv6H2rhljpHCFPtl+qMYDt9GrLXcxb2KXdR8zV4UfsZkB82l3/fKhJTVAr6ZkRRKoMgqHSuQ9qxFO75E3sHRM+/CGUmWWjXqSLiao6kIR/cBdNP4zBEm5jsMM5G/nPH/8WMJ3ZhpDc0l9tAhXCOhnmhQs6HDmgv2UHI+a5o/GhhIslWHuvhcMyWM1hKCWWgWwJD3DF6wvZkS1fdsaLOQsgehAtUzE7MvYpOPNuQWbT3DPKS6DQkAw3dNx8b5LkvWs4Jv5ACWhW/iB2NofOgYIdlKE46fdtjyELHPzA2v1MBGAE5EWpWLCTS6dtIKI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(261022115727099003)(10067099003)(261009223027099003)(261021130227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261021135927099003)(261022075727099003)(261022113327099003)(261021133027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XTKBiEnMO5eUZm5jnTmB5d7+ruQ4VcX31U+XxZ35Vr5zv1ZkYxBEciQ4WZ4T?=
 =?us-ascii?Q?oNh1TLEd5syVWVR16ra573/SizlvK8oFNbMQ5W4d16eKidWm3M4vmy2JGE+o?=
 =?us-ascii?Q?+y9KOVRCa1owCccMhOKw+qlpop9nzgns3vQKcpwngHcVDt/MuI1+mWFU7FuC?=
 =?us-ascii?Q?GRnI3PwXiNOW6l5Mbg0XUulHZrZ5DQX6AeZt1cv5TY9kQuOy4o65Wuns1ocv?=
 =?us-ascii?Q?/LEsydO5u3xrqAyxtDxGpbnr1OSnjCk7JgzgP67sjmBeze4iWQmmhcogSUGC?=
 =?us-ascii?Q?i+bvtj96bORrl3HGafFw7lz/cFK8c4LDHKEPwrOgR09qnFXbihtLJW9kaw+Z?=
 =?us-ascii?Q?03bnRS+RiiH9ZCmJy5K6aWui9wdeZtlkKYdPHBF0s5jMcBnbNedkY/fpWskQ?=
 =?us-ascii?Q?H1LmBxZb77jbilx8JTqWN4WBDsMazoEDYCgXvwLwLFVoRQmvMJ/hHO2Zbq2L?=
 =?us-ascii?Q?WaUcns8Nxz1OoTVZkf6m2Uy7cmjbBPZFrNQcJYjfS/IPZTkY9Sv9Dmye98la?=
 =?us-ascii?Q?x11WOAByRb6GupbSCoK8U/BDWD5tCxPk+u9kIuZZyWh620yY/LG7VvHY10AZ?=
 =?us-ascii?Q?ke38mQ7avmgia0BkU6uE6XELhlh8mVj6kxF9RKQETQTkkhmXjuIHTk4/jb6E?=
 =?us-ascii?Q?yl2bgzQnLLETuOHfHAX8jRksr9E1JfTOlDRtrKDBjvDBYwFWPwnmnE9TA8ik?=
 =?us-ascii?Q?DreNOrPuIo/bVpkeR9xwRDcoXRrY3KrdTOxnvSUwFK3W7qcWI733t4dUkeoF?=
 =?us-ascii?Q?cxE8lfLsPtherHvceAMSNotQuFS3UiwlgNxC31c9WatpQtphP69o+ADyIHti?=
 =?us-ascii?Q?dUJDeOUCPdo3OZ6Y4eM7B1SCLgrRq7iKMCas+TDXFpKIgWpHTaAMHPrfGZBj?=
 =?us-ascii?Q?GqCiR2GCvJs4LVeU+Ose2FQrn9wjxC85fKOcMpLrSq7t+tBG8MvWKU+E4qEj?=
 =?us-ascii?Q?KOy+TxlXHW6bjdLPI6Bhcvxy4yClVF4MDIB0Y+ty+IdCf6U1qkHpZaBCe9Jh?=
 =?us-ascii?Q?89jkI0Ie5HLZiiFDy4FYe2iI7f1GfHRLskl/ReL2jPxIujbPGOoV+Widx2jU?=
 =?us-ascii?Q?RgdVjX5xGHaCRXiQYFA2dblN6mgVCK/6kajJ/OL2PheRl77FKWHYIELHzAgD?=
 =?us-ascii?Q?5CrlaOFcw3ccy2Ppwrx5VY3/KtAKtgenfq914LuzziXBNR5oyzrNlqirn3zE?=
 =?us-ascii?Q?aasfqv3VaWXrbBvPBULaYEHmR1+NGTiGEjqFFs1iyNXpsWksXtoyVIEzE+wL?=
 =?us-ascii?Q?6rPJOMZUrPuvPHYm7MiCatV2XrL7te3+9OShBuFPZcYO8Azkt28prEtDDjRS?=
 =?us-ascii?Q?R1UQm1I2J2Hi1ziiF7HDEDEDLOYKbkMSiunYbVpWbLm0gQgajYMBizNBiu7r?=
 =?us-ascii?Q?axBXjq3JjU77WIIaspVV1sK7J2hoPCiQKt0vaHxM7kwWNkrkusWUX5dKQqaU?=
 =?us-ascii?Q?BtRA0NUnJg+rZ/40XDfaVCGA4keb2DpNo1hyi0tJBuPHSM+fVya3blh4B+hb?=
 =?us-ascii?Q?9Mi2k4DPwIoEN+ropFis7F4DYFtWEppdlvPjmdqECHcpYUpjaHa0m6fg7Gt7?=
 =?us-ascii?Q?iY4sggCjC7R3bR2rxF/9ttpdA5N7w/NaBo+PYH9ik+jcSxlcBXzjojx+tfH4?=
 =?us-ascii?Q?dlpdUun6qnUs1DOQOWoXcN2UVvBya1fjVlgeRqfEoxeTCZvYP6EXkSf3H95X?=
 =?us-ascii?Q?f1BKA/mrhZRbnmGqw3utIgmII5Pye+1Dd+8xNCXkIcugqBigTSDhhmTmHoeo?=
 =?us-ascii?Q?JFocsB/0Cw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 429a304a-b8ee-4ce6-89c8-08df321568eb
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2026 21:26:04.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uB1PZL9ITiioVe7PRZCaASbhA7dfOxw6zophD/vI3RmkhVc3Sjng934mFPszbAF7DNPJdQ6AMnHcqIG1hAHtGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6642

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

