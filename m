Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.95
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793655697;
	b=NhJ/EBqPhDSoBa8Z60WtCG92SXeeiuwgqwexsysEYpoTr8cirwbkM23xZsBJMS6x98mr
	 zgk4NmU9qln6B32a0myVEWt6Rf3U8zF9vvkBfl1ag/eo6iW9rOuJqEiL7db5HVNUSP0Y4
	 COoCrx8hyjoEmT22Su9Wst5vbfvKYBARdD4oDn4AZeFdFWSE/fyFp4MbwVxbArb4lXVeF
	 1UaTOSZKRnC87XeLSLjn+22/BuAfI1oF462Sen10z3DbvqT21WE6HVPXBDeuZ2KzDqnSt
	 NXl8wTX6iUhQBYOKuHnpClHl9pDyA1JPDijaZdOO865RfTGuIQ+pyYpv0WYR8EbSQ4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655697;
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
	bh=D0xvoO0D4srGBJLXsE53W24DB3arjCjrObpQAoVunjQ=;
	b=LzwEDaMyKO185BA7Md7hHNZ6SDJ08B6UnvgriiUGKvYMn751b5bpJ4sXXjqHvs94Yk8d
	 x3la/jXb7QgRSRCanQwfWfokpbHLYCVIyQpzw9+TRB4YpSIIQI/wI+ysgbsOAoqs4sOiC
	 8Xo13zs5M4fdBH56Obmj8zU2TtqcR/1rqAIHqw+CPDYo+tMwUdCRcd7xB9WX+me81odVz
	 lT92AFP+MyNLwuuiv+Ucg63lrac1dZe5h5wE1vrv6wlc50ovUquARhbQ3vvz/KYNaRZh8
	 /7sMYvMyI0oX0s3KKJV5nZl/hJlF5RiFBm3E+ceURUNTx+UM3KpmEiIDTcfoP6fLRew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.95
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022095.outbound.protection.outlook.com [52.101.101.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73E5606D834;
	Mon,  2 Nov 2026 21:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A73E5606D834
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TO+lNvqhuD8dvRONcOSxi6rA5ItJxk1Fw5CXSCklfEaFj9lV/D6L5B+92sjRDUjIa57PXU8eJbi/JmXN55wMFr05AV8Tnzla3JOFv3XriLLFV7YYdc59yWj5AYKCGt//FIIDCPwGefUxFCxjoYckucZew7htszahGO2zPSeaPeSVRm1S8KtRdTDq7RsMelPIobFNeI7nEyhmOApBLveoCSSQ3qigwZ3P5eikjtB/Q9RlINtagfARw1SQ9r642U60sJ+lABfvD1KfumAcPiWmS12lKsQDDxPJnkhUfKgyQeb6w3NUzhhHxizjhKYa9TGO+VdT+F/9Goq1ptbdQxt7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=D0xvoO0D4srGBJLXsE53W24DB3arjCjrObpQAoVunjQ=;
 b=dS89Co08MQLOEBelKO4aPSeXHSI1VkqolQl0I5E25RrzIJ2MQVPXwgKmA85zeMZLJIkG3VrccEtuVyajLBQ0NaLzTLI591Xtwf5ru2fgimughLgWPiJFCk4nb100xoly6Lzot8PYzhVwPoZfRWFBES4I6zQz1b6KWMMbuecSjBny82nl7BMF2o49oX5EDDzzCcqTOCP229FthOq41wN5LVzDzJeWgImm19ufhsOZiwo1rH6djrzARbsEDZoOGcfK0JNXT3SC8za4tqBmdP/srypkGrF8QOg0K/exVvrHoG+eRyDY/BpOiemmfxyvIbdxPiUHak9uK7Bi2oFDGTgrAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO9P123MB8506.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4b3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:41:33 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 21:41:33 +0000
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
Subject: [PATCH perf-tools-next v13 08/10] perf test: Add test for ftrace inline and task stack tracking
Date: Mon,  2 Nov 2026 16:40:52 -0500
Message-ID: <20261102214054.911298-9-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102214054.911298-1-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::10) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: a2c049f5-a2a0-44f1-b673-08df392a1017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|261102123227099003|261021121427099003|56012099006|261009223027099003|261028144727099003|261026140227099003|261022115727099003|261021123027099003|261022075727099003|261022105027099003|261026121527099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	/8t/NgZrNRwt4rJ0JkAD0Thgge5Q3DA/sB4AUraJdFCTz1dzof+2DqBSY0WN/0Z7qMa6rZOwUrREXGRJTe2w+nOoq7JqwXcF5R+X/uZqOVSCh5UOQgD82YW4qdUGmkIFl8QzwWvAigVysSVG3seE9yajstQ6Np1iNvtbVM4MK3yjm4G3vkf/c+FnIjDamVTuVFbRgBiE+lcYI9Yhe6bXkjnltArun6furtEh1YQ8/mIVBU/YcHjnP+HGN2vuJ2VPEjwvnWcw661zvlm0oo9H2Bn8wh4RW9ae/UGx/G/JC+yG1rDY1aPiyltaDvnuIxxA5DEENYJ4wTeigjZHykJSQSAvaxbckfzDZuTXEal4Inp/4x5j8M476ai9mOgSmdgMw9CCM+MgM4YiilIzlUmubeM7qX9/C14h/7mljtA1SbHf/3hsTyDvyNRBxCEaAPW6Jd9vLmYRgGqFbyQFZ9um5POFlhjee1uXJx3UIrBJn9KdSi16WMQsfsVUX7zToS0aafvvxZYVC2eb8zRLQ/tbHUUxJwvyFPqgmJiK5QSKzNnwfTCZENDNE1D2v3+Kf6kdqbfnSuKgKMIqnRTmVMhD1D6gzWo0TJjBUPs//qK6bVKNfHqmQbn0H3fLgFDIbKkR3KSD6Bdtw9+Lx/UKs8mKvgh/8R8TZs7oDmcgKd4uOUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(261102123227099003)(261021121427099003)(56012099006)(261009223027099003)(261028144727099003)(261026140227099003)(261022115727099003)(261021123027099003)(261022075727099003)(261022105027099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UaB/AmayzEdCQT6awamwSQJIKUm/T0iwYBT05NxElkJJ/+4EKp5lbcHVYU9H?=
 =?us-ascii?Q?QZqGqaDGc8pwc4KBjoHKRdwVcBaZwmSOyeV6dFwURg26cmHYXCIE7JSjpnM+?=
 =?us-ascii?Q?Qq6KXQnIq5Ux02EA4h4ZzJ1I5ZFbcNIkYNMy0s89QSvNdNjD1No12xzfzwLL?=
 =?us-ascii?Q?DSgNSavdZtoVYj9lc7Sj8pL0Kpwtm/1ZtSlSzB8L2NiSdWF/nTAVWxe4PmhF?=
 =?us-ascii?Q?bk4YGQY1owPQy5bQ8lWKDBldgQGjWUdTcWQxoaEG6r0wapxxT7GGid2GBabh?=
 =?us-ascii?Q?DOd+KIq0cxRS5RWkbkF5ticGZu5DVzxGko4tzlDD/iVZz6tEmoDhF/7j0+0o?=
 =?us-ascii?Q?+NKoTIiL4KWJouS0Ezv0g9eJEDju4rmsdE7ayA83cbPjsxydhca+73taB5Mf?=
 =?us-ascii?Q?yAp/bUcH7Es5RjkumsqyIFFlbxEwSGxOUkVTb0ECLF3hBVB5uVd9gfkK2tvN?=
 =?us-ascii?Q?y7FokO42DtHMuinOFNnHGpYiibAsJ8lUwKyRolzSZ4UcFTS7kKdJkE5Fn+FT?=
 =?us-ascii?Q?KpGcdYLxbiOoE5UyKuolPWpPR9rwtEC0ZDohOMDWZJ5m5yrTg2pmFzP/I/1C?=
 =?us-ascii?Q?KMbub4y6qJ46hMIHKiEF2wv9MH/yvBxLWUMlujZFm18FsY2cxmTvj5Ruln0T?=
 =?us-ascii?Q?aXrGrMTNjNUrevG+OiTvU4rZnXAfTprs66Sbp2ZnrobzOaZVAC1g8z1iFk5N?=
 =?us-ascii?Q?Tq25tOQAMOkU0Vy2uiM3aoPj2XlNPljZ7fvJujPepaDVdeIoYcQZ3ThFlQNB?=
 =?us-ascii?Q?Uu7gI/KDUxAVb/lQtFwEgeyVejvxjeZvtwORAOWHizCM7eYXJynycvkgeNNR?=
 =?us-ascii?Q?J9KF45jl7EypP9uEdHSVM9PAWP+5TmCMR8eqWtKU1XSvntFciIYoW0WbddJm?=
 =?us-ascii?Q?YRsNVzKY0VT9ErAqWcgq9KMNlzBEfzEd2S5TviJni2emPt2DEbBx4WIodxhJ?=
 =?us-ascii?Q?fQHaqDG5Kz1vWd0kdR3BAAzT0K6GtNxk9RbKbHRquzAIGezX24Tv07Z9PmHw?=
 =?us-ascii?Q?gXltCF/gQj+VbQynYdyemDEXpEeGh1x9iMUeggvh3FSDMcAfBiSB4QLDXZUX?=
 =?us-ascii?Q?xoKhhkZTu/EypD0gibb2V2zM6aIAr2xwfcFroLPbN1Y0CUV9FeA4ulmojKMU?=
 =?us-ascii?Q?PExf4RGGKRedvCotxCG6wI74YiqL1M6XakBiylp7Su426LzzazUBE9PQZUXP?=
 =?us-ascii?Q?oUphJSZnIm31JE2Sv8nNmuPxMGnb/EwxOQgrWscULUqjpwkNcyNcSYGtxqB3?=
 =?us-ascii?Q?bmHWF60pk3qaR/3EbGjoiWTe3m7W/TJsKnr/HwWQ+CXxrqwk8bPwLDShudHt?=
 =?us-ascii?Q?21YSS0gPMdAhz/ji/48t5DfIeLdUDFmhqVqBbxcUv9acMn7F1tRR2rG3mOLz?=
 =?us-ascii?Q?zRwOhAGEcOJ8O2893DQF+HNOPASqHzanUP/AKag848zjKMzv1v4IGIYt1YUA?=
 =?us-ascii?Q?DqjxSX7jpYMCodJ6Ffj0YGcMEMRvp1S5RisH8OivtgR4pViD4opgqmhQMcuC?=
 =?us-ascii?Q?A/xkJPRlkOlq8S4nkj7vY0ssJkz/JDX5sRXTP8qQAHNCR5HSSa9BwONJuQbH?=
 =?us-ascii?Q?2dIcDEscWXLdlBD7y5f3IpEfkcmXDQPby6uITMc82k2ynks3Bulz29lD32TZ?=
 =?us-ascii?Q?a5jSQinDYVxzJ0NHD2TRAMrySESpE5I9JJGOpBIODkleMVM9OK3Vm27oMZ20?=
 =?us-ascii?Q?siR8m5GiIwI+lTvFbtyWGDwYNN1w1zEBUxgPjNZaHMIncTUywy8cIU261kPw?=
 =?us-ascii?Q?OkUiztJuSA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c049f5-a2a0-44f1-b673-08df392a1017
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:41:33.3506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bTHUltG01Yd73DO8sZd8b40Z3SNmEBMH0+Yi0lpytmWbVF/tN1yImMfpWSGyP5wk8R0T/JxWhOx96a2Dz4Djg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P123MB8506

Add an automated unit test suite ("Ftrace inline processing") in
tools/perf/tests/ftrace.c to validate the function graph call stack
tracking and inlined function reconstruction implementation.

The test suite verifies:

    1.  DWARF inline symbol resolution

        Uses vmlinux_path__find() to locate the kernel image, setting up
        symbol resolution and validating activate_task inlining within
        wake_up_new_task at offset 0x1d1.

    2.  Inline presentation and return address filtering

        Verifies that synthesised inlined entries and exits are
        correctly annotated with /* (inline) */, that return address
        comments are filtered out by default, and that comments are
        preserved when graph_retaddr is requested.

    3.  Bare closing brace matching

        Verifies that bare closing braces without trailing function
        names (the default when funcgraph-tail is disabled) correctly
        pop and match their corresponding LIFO stack frames.

    4.  Task context-switch tracking and CPU migration

        Verifies call stack isolation across context switch banners and
        task migration across different CPUs.

    5.  Deep stack growth and recovery

        Verifies that dynamic call stack growth and depth recovery
        operate cleanly under deep call stacks exceeding the initial
        FTRACE_MAX_STACK capacity.

Tested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/tests/ftrace.c | 1363 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 1354 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/ftrace.c b/tools/perf/tests/ftrace.c
index 42604811a2fb..900f5390141f 100644
--- a/tools/perf/tests/ftrace.c
+++ b/tools/perf/tests/ftrace.c
@@ -7,7 +7,14 @@
 #include <unistd.h>
 #include "tests.h"
 #include "debug.h"
+#include "dso.h"
+#include "machine.h"
+#include "map.h"
+#include "symbol.h"
+#include "srcline.h"
 #include "util/ftrace.h"
+#include "evlist.h"
+#include "thread_map.h"
 
 static int test_parse_retaddr(void)
 {
@@ -63,19 +70,1357 @@ static int test_filter_retaddr(void)
 	return TEST_OK;
 }
 
-static int test__ftrace(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+static void ensure_synthetic_inline(struct machine *machine,
+				    const char *caller, u64 offset,
+				    const char *inline_name)
 {
-	int ret;
+	struct map *kmap = NULL;
+	struct symbol *sym;
 
-	ret = test_parse_retaddr();
-	if (ret != TEST_OK)
-		return ret;
+	if (!machine || !offset)
+		return;
 
-	ret = test_filter_retaddr();
-	if (ret != TEST_OK)
-		return ret;
+	sym = machine__find_kernel_symbol_by_name(machine, caller, &kmap);
+	if (sym && kmap) {
+		struct dso *dso = map__dso(kmap);
+		u64 ip = sym->start + offset - 1;
+		u64 addr = map__rip_2objdump(kmap, ip);
+		struct inline_node *node;
 
+		node = inlines__tree_find(dso__inlined_nodes(dso), addr);
+		if (!node) {
+			struct symbol *isym = new_inline_sym(dso, sym, inline_name);
+
+			node = zalloc(sizeof(*node));
+			if (node && isym) {
+				INIT_LIST_HEAD(&node->val);
+				node->addr = addr;
+				if (inline_list__append(isym, NULL, node) != 0) {
+					symbol__delete(isym);
+					free(node);
+				} else {
+					inlines__tree_insert(dso__inlined_nodes(dso), node);
+				}
+			} else {
+				if (isym)
+					symbol__delete(isym);
+				free(node);
+			}
+		} else {
+			struct inline_list *pos, *outer = NULL;
+
+			list_for_each_entry_reverse(pos, &node->val, list) {
+				if (pos->symbol && symbol__inlined(pos->symbol)) {
+					outer = pos;
+					break;
+				}
+			}
+			if (!outer || strcmp(outer->symbol->name, inline_name)) {
+				struct symbol *isym = new_inline_sym(dso, sym, inline_name);
+
+				if (isym) {
+					inline_node__clear_frames(node);
+					if (inline_list__append(isym, NULL, node) != 0)
+						symbol__delete(isym);
+				}
+			}
+		}
+		map__put(kmap);
+	}
+}
+
+#define TEST_CHECK(text, cond)					\
+do {								\
+	if (!(cond)) {						\
+		pr_debug("FAILED %s:%d %s\n", __FILE__, __LINE__, text); \
+		ret = TEST_FAIL;				\
+		goto out_cleanup;				\
+	}							\
+} while (0)
+
+static int test_inline_processing(void)
+{
+	static const char line_entry[] = " 0)               |  wake_up_new_task() {";
+	static const char line_enqueue[] =
+		" 0)               |    enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */";
+	static const char line_exit_enqueue[] = " 0) + 10.000 us   |    } /* enqueue_task */";
+	static const char line_exit_task[] = " 0) + 20.000 us   |  } /* wake_up_new_task */";
+	static const char line_bare_enqueue[] = " 0) + 10.000 us   |    }";
+	static const char line_bare_task[] = " 0) + 20.000 us   |  }";
+	static const char line_unmatched[] = " 0) +  5.000 us   |    } /* unrelated_func */";
+	static const char line_verbose_entry[] =
+		" 1234.567890 |   0)   bash-1234    |  ....   |               |  wake_up_new_task() {";
+	static const char line_verbose_enqueue[] =
+		" 1234.567890 |   0)   bash-1234    |  ....   |               |    enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */";
+	static const char line_verbose_exit_enqueue[] =
+		" 1234.567890 |   0)   bash-1234    |  ....   |   1.234 us    |    } /* enqueue_task */";
+	static const char line_verbose_exit_task[] =
+		" 1234.567890 |   0)   bash-1234    |  ....   |   2.567 us    |  } /* wake_up_new_task */";
+	static const char line_verbose_inline_entry[] =
+		" 1234.567890 |   0)   bash-1234    |  ....   |               |    activate_task() { /* (inline) */";
+	static const char line_verbose_inline_exit[] =
+		" 1234.567890 |   0)   bash-1234    |  ....   |               |    } /* activate_task (inline) */";
+	struct perf_ftrace ftrace;
+	char *out_buf = NULL;
+	size_t out_len = 0;
+	FILE *out;
+	const char *unmatched_pos;
+	const char *inline_exit_pos;
+	const char *vmlinux;
+	const char *saved_vmlinux = symbol_conf.vmlinux_name;
+	bool saved_ignore_buildid = symbol_conf.ignore_vmlinux_buildid;
+	int ret = TEST_OK;
+
+	memset(&ftrace, 0, sizeof(ftrace));
+	ftrace.use_inline = true;
+	/* By default, graph_retaddr is 0 (return address comments are filtered) */
+	ftrace.tracer = "function_graph";
+
+	vmlinux = vmlinux_path__find();
+	if (!vmlinux)
+		return TEST_SKIP;
+
+	/* If vmlinux is present, test resolving symbols */
+	{
+		const char *inlined_names[FTRACE_MAX_INLINES];
+		int num_inlines;
+
+		symbol_conf.vmlinux_name = vmlinux;
+		symbol_conf.ignore_vmlinux_buildid = true;
+		ret = perf_ftrace__setup_inlines(&ftrace);
+		if (ret < 0 || !ftrace.machine) {
+			ret = TEST_SKIP;
+			goto out_cleanup;
+		}
+
+		num_inlines = ftrace_resolve_inlines(ftrace.machine,
+						     "wake_up_new_task", 0x1d1,
+						     inlined_names,
+						     FTRACE_MAX_INLINES);
+		if (num_inlines <= 0 || strcmp(inlined_names[0], "activate_task") != 0) {
+			pr_debug("vmlinux does not inline activate_task at wake_up_new_task+0x1d1; falling back to synthetic inline\n");
+			ensure_synthetic_inline(ftrace.machine, "wake_up_new_task", 0x1d1,
+						"activate_task");
+			num_inlines = ftrace_resolve_inlines(ftrace.machine,
+							     "wake_up_new_task", 0x1d1,
+							     inlined_names,
+							     FTRACE_MAX_INLINES);
+			if (num_inlines <= 0 || strcmp(inlined_names[0], "activate_task") != 0) {
+				ret = TEST_SKIP;
+				goto out_cleanup;
+			}
+		}
+
+		if (ftrace_resolve_inlines(ftrace.machine, "wake_up_new_task", 0,
+					   inlined_names, FTRACE_MAX_INLINES) != 0) {
+			pr_debug("ftrace_resolve_inlines with offset 0 should return 0\n");
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		/* Feed simulated function graph trace lines */
+		ftrace_process_fgraph_line(&ftrace, line_entry, out);
+		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_exit_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
+
+		fclose(out);
+		ftrace_cpu_states__clear();
+
+		pr_debug("Processed output:\n%s\n", out_buf);
+
+		/* Verify activate_task entry with inline hint */
+		TEST_CHECK("contains activate_task entry with inline hint",
+			   strstr(out_buf, "activate_task() { /* (inline) */") != NULL);
+
+		/* Verify activate_task exit with inline hint */
+		TEST_CHECK("contains activate_task exit with inline hint",
+			   strstr(out_buf, "} /* activate_task (inline) */") != NULL);
+
+		/* Verify return address comment was filtered out by default */
+		TEST_CHECK("retaddr comment filtered out",
+			   strstr(out_buf, "/* <-wake_up_new_task") == NULL);
+
+		free(out_buf);
+		out_buf = NULL;
+
+		/* Now test with graph_retaddr = 1 (user specified --graph-opts retaddr) */
+		ftrace.graph_retaddr = 1;
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		ftrace_process_fgraph_line(&ftrace, line_entry, out);
+		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_exit_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
+
+		fclose(out);
+		ftrace_cpu_states__clear();
+
+		/* Verify return address comment IS preserved when graph_retaddr = 1 */
+		TEST_CHECK("retaddr comment preserved when requested",
+			   strstr(out_buf, "/* <-wake_up_new_task") != NULL);
+
+		free(out_buf);
+		out_buf = NULL;
+
+		/* Test with bare closing braces (funcgraph-tail disabled by default) */
+		ftrace.graph_retaddr = 0;
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		ftrace_process_fgraph_line(&ftrace, line_entry, out);
+		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_bare_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_bare_task, out);
+
+		fclose(out);
+
+		TEST_CHECK("bare braces inline entry",
+			   strstr(out_buf, "activate_task() { /* (inline) */") != NULL);
+		TEST_CHECK("bare braces inline exit",
+			   strstr(out_buf, "} /* activate_task (inline) */") != NULL);
+
+		free(out_buf);
+		out_buf = NULL;
+
+		/* Test bare closing brace matches outer frame when inner callee exit was dropped */
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		ftrace_process_fgraph_line(&ftrace, line_entry, out);
+		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
+		/* line_bare_enqueue is dropped! */
+		ftrace_process_fgraph_line(&ftrace, line_bare_task, out);
+
+		fclose(out);
+
+		TEST_CHECK("dropped callee exit: inlined frame closed",
+			   strstr(out_buf, "} /* activate_task (inline) */") != NULL);
+		TEST_CHECK("dropped callee exit: outer bare brace emitted",
+			   strstr(out_buf, "|  }\n") != NULL);
+
+		free(out_buf);
+		out_buf = NULL;
+
+		/* Test that unmatched exit events do not pop active inlined frames */
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		ftrace_process_fgraph_line(&ftrace, line_entry, out);
+		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_exit_enqueue, out);
+		/* Unmatched exit event while activate_task is still active */
+		ftrace_process_fgraph_line(&ftrace, line_unmatched, out);
+		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
+
+		fclose(out);
+
+		unmatched_pos = strstr(out_buf, "} /* unrelated_func */");
+		inline_exit_pos = strstr(out_buf, "} /* activate_task (inline) */");
+
+		TEST_CHECK("unmatched exit present", unmatched_pos != NULL);
+		TEST_CHECK("inline exit present", inline_exit_pos != NULL);
+		TEST_CHECK("inline exit not prematurely popped before unmatched exit",
+			   inline_exit_pos > unmatched_pos);
+
+		free(out_buf);
+		out_buf = NULL;
+
+		/* Test recovery when an intermediate real function exit event is dropped */
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		ftrace_process_fgraph_line(&ftrace, line_entry, out);
+		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
+		/* line_exit_enqueue is dropped; outer wake_up_new_task exits directly */
+		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
+
+		fclose(out);
+
+		TEST_CHECK("inline exit synthesized despite dropped callee exit",
+			   strstr(out_buf, "} /* activate_task (inline) */") != NULL);
+
+		free(out_buf);
+		out_buf = NULL;
+
+		/* Test recovery when intermediate callee exit is dropped before sibling call */
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		ftrace_process_fgraph_line(&ftrace, line_entry, out);
+		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
+		/* line_exit_enqueue dropped; caller makes sibling call without inlines */
+		ftrace_process_fgraph_line(&ftrace,
+			" 0)               |    check_preempt_curr(); /* <-wake_up_new_task+0x0/0x3e0 */",
+			out);
+		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
+
+		fclose(out);
+
+		TEST_CHECK("inline exit synthesized when callee exit dropped before sibling call",
+			   strstr(out_buf, "} /* activate_task (inline) */") != NULL);
+
+		free(out_buf);
+		out_buf = NULL;
+
+		/* Test that callers not on active stack do not synthesise inlines */
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		ftrace_process_fgraph_line(&ftrace, line_entry, out);
+		/* housekeeping_any_cpu called by untraced ring_buffer_unlock_commit */
+		ftrace_process_fgraph_line(&ftrace,
+			" 0)               |    housekeeping_any_cpu(); /* <-ring_buffer_unlock_commit+0x1a0/0x1f0 */",
+			out);
+		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
+
+		fclose(out);
+
+		TEST_CHECK("untraced caller inlines not synthesised",
+			   strstr(out_buf, "rb_wakeups") == NULL &&
+			   strstr(out_buf, "rb_irq_work_queue") == NULL);
+
+		free(out_buf);
+		out_buf = NULL;
+
+		/* Test trailing inlined frame closed on untraced entry (caller_idx < 0) */
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		ftrace_process_fgraph_line(&ftrace, line_entry, out);
+		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
+		/* line_enqueue has inlined activate_task() open; next entry has caller_idx < 0 */
+		ftrace_process_fgraph_line(&ftrace,
+					   " 0)               |    irq_handler() {",
+					   out);
+		ftrace_process_fgraph_line(&ftrace,
+					   " 0)               |    } /* irq_handler */",
+					   out);
+		ftrace_process_fgraph_line(&ftrace, line_exit_task, out);
+
+		fclose(out);
+
+		TEST_CHECK("trailing inline frame closed before untraced call",
+			   strstr(out_buf, "} /* activate_task (inline) */") != NULL);
+		TEST_CHECK("untraced call not indented inside trailing inline frame",
+			   strstr(out_buf, "|    irq_handler() {") != NULL);
+
+		free(out_buf);
+		out_buf = NULL;
+
+		/* Test dropped exits unwound when new function starts at shallower indent */
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		ftrace_process_fgraph_line(&ftrace, line_entry, out);
+		ftrace_process_fgraph_line(&ftrace, line_enqueue, out);
+		/* Exits dropped! New root entry arrives at indent 2 */
+		ftrace_process_fgraph_line(&ftrace,
+					   " 0)               |  schedule() {",
+					   out);
+		ftrace_process_fgraph_line(&ftrace,
+					   " 0)               |  } /* schedule */",
+					   out);
+
+		fclose(out);
+
+		TEST_CHECK("stale inlines closed when new root arrives",
+			   strstr(out_buf, "} /* activate_task (inline) */") != NULL);
+		TEST_CHECK("new root entry printed without stale indentation",
+			   strstr(out_buf, "|  schedule() {") != NULL);
+
+		free(out_buf);
+		out_buf = NULL;
+
+		/* Test verbose mode prefix formatting for synthesised inlines */
+		ftrace.graph_verbose = true;
+		out = open_memstream(&out_buf, &out_len);
+		if (!out) {
+			ret = TEST_FAIL;
+			goto out_cleanup;
+		}
+
+		ftrace_process_fgraph_line(&ftrace, line_verbose_entry, out);
+		ftrace_process_fgraph_line(&ftrace, line_verbose_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_verbose_exit_enqueue, out);
+		ftrace_process_fgraph_line(&ftrace, line_verbose_exit_task, out);
+
+		fclose(out);
+		ftrace_cpu_states__clear();
+
+		TEST_CHECK("verbose inline entry preserves comm-pid",
+			   strstr(out_buf, line_verbose_inline_entry) != NULL);
+		TEST_CHECK("verbose inline exit preserves comm-pid",
+			   strstr(out_buf, line_verbose_inline_exit) != NULL);
+
+		free(out_buf);
+		out_buf = NULL;
+		ftrace.graph_verbose = false;
+	}
+
+out_cleanup:
+	free(out_buf);
+	perf_ftrace__cleanup_inlines(&ftrace);
+	symbol_conf.vmlinux_name = saved_vmlinux;
+	symbol_conf.ignore_vmlinux_buildid = saved_ignore_buildid;
+	return ret;
+}
+#undef TEST_CHECK
+
+static void feed_fgraph_entry(struct perf_ftrace *ftrace, int cpu, int depth,
+			      const char *name, const char *retaddr, FILE *out)
+{
+	char line[1024];
+	int indent = 2 + 2 * depth;
+
+	if (retaddr) {
+		snprintf(line, sizeof(line), " %d)               |%*s%s() { /* <-%s */",
+			 cpu, indent, "", name, retaddr);
+	} else {
+		snprintf(line, sizeof(line), " %d)               |%*s%s() {",
+			 cpu, indent, "", name);
+	}
+	ftrace_process_fgraph_line(ftrace, line, out);
+}
+
+static void feed_fgraph_exit(struct perf_ftrace *ftrace, int cpu, int depth,
+			     const char *name, FILE *out)
+{
+	char line[1024];
+	int indent = 2 + 2 * depth;
+
+	if (name) {
+		snprintf(line, sizeof(line), " %d)   1.000 us    |%*s} /* %s */",
+			 cpu, indent, "", name);
+	} else {
+		snprintf(line, sizeof(line), " %d)   1.000 us    |%*s}",
+			 cpu, indent, "");
+	}
+	ftrace_process_fgraph_line(ftrace, line, out);
+}
+
+static int test_stack_saturation(void)
+{
+	struct perf_ftrace ftrace;
+	char *out_buf = NULL;
+	size_t out_len = 0;
+	FILE *out;
+	const char *vmlinux;
+	int i;
+
+	memset(&ftrace, 0, sizeof(ftrace));
+	ftrace.use_inline = true;
+	ftrace_cpu_states__clear();
+
+	out = open_memstream(&out_buf, &out_len);
+	if (!out)
+		return TEST_FAIL;
+
+	/* Push root frame at depth 0 */
+	feed_fgraph_entry(&ftrace, 0, 0, "root_func", NULL, out);
+
+	/* Push 255 more frames to fill initial FTRACE_MAX_STACK (256) */
+	for (i = 1; i < 256; i++)
+		feed_fgraph_entry(&ftrace, 0, i, "sub_func", NULL, out);
+
+	/* Push 44 additional frames triggering dynamic stack expansion beyond 256 */
+	for (i = 0; i < 44; i++)
+		feed_fgraph_entry(&ftrace, 0, 256 + i, "overflow_func", NULL, out);
+
+	/* Pop the 44 expanded frames with bare closing braces */
+	for (i = 43; i >= 0; i--)
+		feed_fgraph_exit(&ftrace, 0, 256 + i, NULL, out);
+
+	/* Pop 255 tracked sub_func frames */
+	for (i = 255; i >= 1; i--)
+		feed_fgraph_exit(&ftrace, 0, i, NULL, out);
+
+	/* Pop root frame - must cleanly match root_func on stack, not popped prematurely */
+	feed_fgraph_exit(&ftrace, 0, 0, "root_func", out);
+
+	/* Feed one more function entry - it must have base indentation (no indentation drift) */
+	feed_fgraph_entry(&ftrace, 0, 0, "base_func", NULL, out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	/* Verify base_func starts at standard 2 spaces indentation without drift */
+	if (!strstr(out_buf, "|  base_func() {")) {
+		pr_debug("FAILED %s:%d no indentation drift after stack saturation\n",
+			 __FILE__, __LINE__);
+		free(out_buf);
+		return TEST_FAIL;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* Test call depth recovery when events are dropped on deep stack */
+	out = open_memstream(&out_buf, &out_len);
+	if (!out)
+		return TEST_FAIL;
+
+	feed_fgraph_entry(&ftrace, 0, 0, "root_func", NULL, out);
+	for (i = 1; i < 256; i++)
+		feed_fgraph_entry(&ftrace, 0, i, "sub_func", NULL, out);
+	for (i = 0; i < 44; i++)
+		feed_fgraph_entry(&ftrace, 0, 256 + i, "overflow_func", NULL, out);
+
+	/* Dropped events: root_func directly calls recovery_func */
+	feed_fgraph_entry(&ftrace, 0, 1, "recovery_func", "root_func+0x20", out);
+	feed_fgraph_exit(&ftrace, 0, 1, NULL, out);
+	feed_fgraph_exit(&ftrace, 0, 0, "root_func", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (!strstr(out_buf, "recovery_func() {")) {
+		pr_debug("FAILED %s:%d recovery_func missing after overflow recovery\n",
+			 __FILE__, __LINE__);
+		free(out_buf);
+		return TEST_FAIL;
+	}
+	if (!strstr(out_buf, "} /* root_func */")) {
+		pr_debug("FAILED %s:%d root_func exit missing after overflow recovery\n",
+			 __FILE__, __LINE__);
+		free(out_buf);
+		return TEST_FAIL;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* Test that bare braces on deep stack do not prematurely pop tracked frames */
+	out = open_memstream(&out_buf, &out_len);
+	if (!out)
+		return TEST_FAIL;
+
+	feed_fgraph_entry(&ftrace, 0, 0, "root_func", NULL, out);
+	for (i = 1; i < 256; i++)
+		feed_fgraph_entry(&ftrace, 0, i, "sub_func", NULL, out);
+	for (i = 0; i < 10; i++)
+		feed_fgraph_entry(&ftrace, 0, 256 + i, "overflow_func", NULL, out);
+
+	/* Pop 10 overflow frames with bare braces */
+	for (i = 9; i >= 0; i--)
+		feed_fgraph_exit(&ftrace, 0, 256 + i, NULL, out);
+
+	/* Pop 255 sub_func frames with bare braces */
+	for (i = 255; i >= 1; i--)
+		feed_fgraph_exit(&ftrace, 0, i, NULL, out);
+
+	/* Root frame must still be on the stack to match caller */
+	feed_fgraph_entry(&ftrace, 0, 1, "child_func", "root_func+0x10", out);
+	feed_fgraph_exit(&ftrace, 0, 1, NULL, out);
+	feed_fgraph_exit(&ftrace, 0, 0, "root_func", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (!strstr(out_buf, "child_func() {")) {
+		pr_debug("FAILED %s:%d child_func missing after bare braces in overflow\n",
+			 __FILE__, __LINE__);
+		free(out_buf);
+		return TEST_FAIL;
+	}
+	if (!strstr(out_buf, "} /* root_func */")) {
+		pr_debug("FAILED %s:%d root_func exit missing after bare braces in overflow\n",
+			 __FILE__, __LINE__);
+		free(out_buf);
+		return TEST_FAIL;
+	}
+
+	free(out_buf);
+	out_buf = NULL;
+
+	/* Test recursive caller lookup skips stale inner invocation */
+	out = open_memstream(&out_buf, &out_len);
+	if (!out)
+		return TEST_FAIL;
+
+	/* Outer recursive invocation at indent 2 */
+	ftrace_process_fgraph_line(&ftrace, " 0)               |  rec_func() {", out);
+	/* Inner recursive invocation at indent 4 */
+	ftrace_process_fgraph_line(&ftrace,
+				   " 0)               |    rec_func() { /* <-rec_func+0x10 */",
+				   out);
+	/* Inner invocation exit is dropped by ring buffer */
+	/* Outer invocation calls sibling_func at indent 4 */
+	ftrace_process_fgraph_line(&ftrace,
+				   " 0)   1.000 us    |    sibling_func(); /* <-rec_func+0x20 */",
+				   out);
+	ftrace_process_fgraph_line(&ftrace, " 0)   2.000 us    |  } /* rec_func */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (!strstr(out_buf, "sibling_func();")) {
+		pr_debug("FAILED %s:%d sibling_func missing under recursive caller\n",
+			 __FILE__, __LINE__);
+		free(out_buf);
+		return TEST_FAIL;
+	}
+	if (!strstr(out_buf, "} /* rec_func */")) {
+		pr_debug("FAILED %s:%d rec_func exit missing after dropped inner exit\n",
+			 __FILE__, __LINE__);
+		free(out_buf);
+		return TEST_FAIL;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/* Test dropped inner recursive entry does not prematurely unwind outer caller */
+	out = open_memstream(&out_buf, &out_len);
+	if (!out)
+		return TEST_FAIL;
+
+	/* Outer recursive invocation at indent 2 */
+	ftrace_process_fgraph_line(&ftrace, " 0)               |  rec_func() {", out);
+	/* Inner recursive entry at indent 4 is DROPPED by ring buffer */
+	/* Inner recursive invocation exits at indent 4 */
+	ftrace_process_fgraph_line(&ftrace, " 0)   1.000 us    |    } /* rec_func */", out);
+	/* Outer invocation is still active; calls child_func at indent 4 */
+	ftrace_process_fgraph_line(&ftrace,
+				   " 0)   1.000 us    |    child_func(); /* <-rec_func+0x20 */",
+				   out);
+	/* Outer invocation exits at indent 2 */
+	ftrace_process_fgraph_line(&ftrace, " 0)   2.000 us    |  } /* rec_func */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	if (!strstr(out_buf, "child_func();")) {
+		pr_debug("FAILED %s:%d child_func missing after dropped inner recursive entry\n",
+			 __FILE__, __LINE__);
+		free(out_buf);
+		return TEST_FAIL;
+	}
+	free(out_buf);
+	out_buf = NULL;
+
+	/* Test top inlined frame when cs->overflow_depth > 0 does not misclassify exit */
+	vmlinux = vmlinux_path__find();
+	if (vmlinux) {
+		const char *saved_vmlinux = symbol_conf.vmlinux_name;
+		bool saved_ignore_buildid = symbol_conf.ignore_vmlinux_buildid;
+		const char *inlined_names[FTRACE_MAX_INLINES];
+		int num_inlines;
+
+		symbol_conf.vmlinux_name = vmlinux;
+		symbol_conf.ignore_vmlinux_buildid = true;
+		if (perf_ftrace__setup_inlines(&ftrace) == 0 && ftrace.machine) {
+			ensure_synthetic_inline(ftrace.machine, "wake_up_new_task", 0x1d1,
+						"activate_task");
+			num_inlines = ftrace_resolve_inlines(ftrace.machine,
+							     "wake_up_new_task", 0x1d1,
+							     inlined_names,
+							     FTRACE_MAX_INLINES);
+			if (num_inlines > 0 && !strcmp(inlined_names[0], "activate_task")) {
+				out = open_memstream(&out_buf, &out_len);
+				if (!out) {
+					perf_ftrace__cleanup_inlines(&ftrace);
+					symbol_conf.vmlinux_name = saved_vmlinux;
+					symbol_conf.ignore_vmlinux_buildid = saved_ignore_buildid;
+					return TEST_FAIL;
+				}
+
+				/* Fill stack up to 254 with tracked frames */
+				feed_fgraph_entry(&ftrace, 0, 0, "root_func", NULL, out);
+				for (i = 1; i < 254; i++)
+					feed_fgraph_entry(&ftrace, 0, i, "sub_func", NULL, out);
+
+				/* Frame 254 is wake_up_new_task */
+				feed_fgraph_entry(&ftrace, 0, 254, "wake_up_new_task", NULL, out);
+
+				/*
+				 * Frame 255: enqueue_task resolves inline activate_task.
+				 * Inlined frame activate_task is pushed at stack[255]
+				 * (cs->depth = 256), and real frame enqueue_task dynamically
+				 * grows the stack capacity beyond 256.
+				 */
+				feed_fgraph_entry(&ftrace, 0, 255, "enqueue_task",
+						  "wake_up_new_task+0x1d1/0x3e0", out);
+
+				/*
+				 * Nested child call on deep stack: does NOT pop the
+				 * inlined frame!
+				 */
+				feed_fgraph_entry(&ftrace, 0, 256, "child_overflow",
+						  "enqueue_task+0x10", out);
+
+				/* Exit child_overflow */
+				feed_fgraph_exit(&ftrace, 0, 256, NULL, out);
+
+				/* Exit enqueue_task */
+				feed_fgraph_exit(&ftrace, 0, 255, NULL, out);
+
+				/* Exit wake_up_new_task: synthesises inline exit */
+				feed_fgraph_exit(&ftrace, 0, 254, NULL, out);
+
+				/* Pop remaining sub_func frames and root_func */
+				for (i = 253; i >= 1; i--)
+					feed_fgraph_exit(&ftrace, 0, i, NULL, out);
+				feed_fgraph_exit(&ftrace, 0, 0, "root_func", out);
+
+				/* Feed base frame to check for indentation drift */
+				feed_fgraph_entry(&ftrace, 0, 0, "drift_check", NULL, out);
+
+				fclose(out);
+				ftrace_cpu_states__clear();
+
+				if (!strstr(out_buf, "activate_task() { /* (inline) */") ||
+				    !strstr(out_buf, "} /* activate_task (inline) */") ||
+				    !strstr(out_buf, "|  drift_check() {")) {
+					pr_debug("FAILED %s:%d top inlined frame saturation failed\n",
+						 __FILE__, __LINE__);
+					free(out_buf);
+					perf_ftrace__cleanup_inlines(&ftrace);
+					symbol_conf.vmlinux_name = saved_vmlinux;
+					symbol_conf.ignore_vmlinux_buildid = saved_ignore_buildid;
+					return TEST_FAIL;
+				}
+
+				free(out_buf);
+				out_buf = NULL;
+			}
+			perf_ftrace__cleanup_inlines(&ftrace);
+		}
+		symbol_conf.vmlinux_name = saved_vmlinux;
+		symbol_conf.ignore_vmlinux_buildid = saved_ignore_buildid;
+	}
+
+	free(out_buf);
 	return TEST_OK;
 }
 
-DEFINE_SUITE("Ftrace return address processing", ftrace);
+static int test_column_layouts(void)
+{
+	static const struct {
+		const char *desc;
+				bool verbose;
+		const char *in;
+		const char *expected;
+	} cases[] = {
+		{
+			"default layout", false,
+			" 7)               |  wake_up_new_task() { /* <-kernel_clone+0x160/0x510 */",
+			" 7)               |  wake_up_new_task() {\n",
+		},
+		{
+			"verbose layout", true,
+			" 1234.567890 |   7)   bash-1234    |  ....   |               |  wake_up_new_task() { /* <-kernel_clone+0x160/0x510 */",
+			" 1234.567890 |   7)   bash-1234    |  ....   |               |  wake_up_new_task() {\n",
+		},
+	};
+	struct perf_ftrace ftrace;
+	char *out_buf = NULL;
+	size_t out_len = 0;
+	FILE *out;
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		memset(&ftrace, 0, sizeof(ftrace));
+		ftrace.use_inline = true;
+		ftrace.graph_verbose = cases[i].verbose;
+
+		out = open_memstream(&out_buf, &out_len);
+		if (!out)
+			return TEST_FAIL;
+
+		ftrace_process_fgraph_line(&ftrace, cases[i].in, out);
+		fclose(out);
+		ftrace_cpu_states__clear();
+
+		if (strcmp(out_buf, cases[i].expected)) {
+			pr_debug("%s: expected '%s', got '%s'\n",
+				 cases[i].desc, cases[i].expected, out_buf);
+			free(out_buf);
+			return TEST_FAIL;
+		}
+		free(out_buf);
+		out_buf = NULL;
+	}
+
+	return TEST_OK;
+}
+
+#define TEST_CS_ASSERT(text, cond)					\
+do {									\
+	if (!(cond)) {							\
+		pr_debug("FAILED %s:%d %s\n", __FILE__, __LINE__, text); \
+		ret = TEST_FAIL;					\
+		goto out_cleanup;					\
+	}								\
+} while (0)
+
+static int test_context_switch_handling(void)
+{
+	struct perf_ftrace ftrace;
+	struct perf_thread_map *threads;
+	const char *saved_vmlinux = symbol_conf.vmlinux_name;
+	bool saved_ignore_buildid = symbol_conf.ignore_vmlinux_buildid;
+	char *out_buf = NULL;
+	size_t out_len = 0;
+	const char *vmlinux;
+	struct map *kmap = NULL;
+	struct symbol *sym;
+	FILE *out;
+	int i;
+	int ret = TEST_OK;
+
+	vmlinux = vmlinux_path__find();
+	if (!vmlinux)
+		return TEST_SKIP;
+
+	memset(&ftrace, 0, sizeof(ftrace));
+	ftrace.use_inline = true;
+	symbol_conf.vmlinux_name = vmlinux;
+	symbol_conf.ignore_vmlinux_buildid = true;
+	if (perf_ftrace__setup_inlines(&ftrace) < 0 || !ftrace.machine) {
+		ret = TEST_SKIP;
+		goto out_cleanup_conf;
+	}
+
+	sym = machine__find_kernel_symbol_by_name(ftrace.machine, "wake_up_new_task", &kmap);
+	if (!sym || !kmap) {
+		ret = TEST_SKIP;
+		goto out_cleanup;
+	}
+	map__put(kmap);
+
+	ensure_synthetic_inline(ftrace.machine, "wake_up_new_task", 0x1d1,
+				"activate_task");
+
+	ftrace_cpu_states__clear();
+
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_cleanup;
+	}
+
+	/*
+	 * Initial Task 1 (PID 100) starts running on CPU 0 before any banner
+	 * has been emitted on that CPU (default kernel ftrace behaviour).
+	 * Frame wake_up_new_task at offset 0x1d1 resolves inline activate_task.
+	 */
+	ftrace_process_fgraph_line(&ftrace, " 0)               |  wake_up_new_task() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+				   " 0)               |    enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */",
+				   out);
+
+	/* First context switch on CPU 0: Task 1 switches to <idle>-0 */
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)    task1-100   =>    <idle>-0 ", out);
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+
+	/* Idle task executes on CPU 0 - must NOT inherit Task 1's inlined call stack */
+	ftrace_process_fgraph_line(&ftrace, " 0)               |  default_idle() {", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)               |  } /* default_idle */", out);
+
+	/* Context switch to Task 2 (PID 200) on CPU 0 */
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)    <idle>-0    =>    task2-200 ", out);
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+
+	/* Task 2 executes func2 - must NOT inherit Task 1's inlined call stack */
+	ftrace_process_fgraph_line(&ftrace, " 0)               |  func2() {", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)               |  } /* func2 */", out);
+
+	/* Task 1 migrates and resumes on CPU 1 */
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)    <idle>-0    =>    task1-100 ", out);
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+
+	/* Task 1 exits enqueue_task, then wake_up_new_task on CPU 1 */
+	ftrace_process_fgraph_line(&ftrace, " 1)   1.000 us    |    } /* enqueue_task */", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)   2.000 us    |  } /* wake_up_new_task */", out);
+
+	/*
+	 * Test delayed context switch banner migration where a task state
+	 * with an inlined frame on CPU 2 is rekeyed from CPU 2 to CPU 3.
+	 */
+	ftrace_process_fgraph_line(&ftrace, " 2)               |  wake_up_new_task() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+				   " 2)               |    enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */",
+				   out);
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 3)    <idle>-0    =>    task3-300 ", out);
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 2)    task3-300   =>    <idle>-0 ", out);
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 3)               |      func4() {", out);
+	ftrace_process_fgraph_line(&ftrace, " 3)               |      } /* func4 */", out);
+	ftrace_process_fgraph_line(&ftrace, " 3)               |    } /* enqueue_task */", out);
+	ftrace_process_fgraph_line(&ftrace, " 3)               |  } /* wake_up_new_task */", out);
+
+	/*
+	 * Test delayed context switch banner migration where CPU 3 enters func6()
+	 * BEFORE CPU 2 emits its delayed context switch banner. ts from CPU 2
+	 * must be merged underneath existing on CPU 3.
+	 */
+	ftrace_process_fgraph_line(&ftrace, " 2)               |  func5() {", out);
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 3)    <idle>-0    =>    task4-400 ", out);
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 3)               |    func6() {", out);
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 2)    task4-400   =>    <idle>-0 ", out);
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 3)               |    } /* func6 */", out);
+	ftrace_process_fgraph_line(&ftrace, " 3)               |  } /* func5 */", out);
+
+	/*
+	 * Test single-task profiling across CPU migration where context switch
+	 * banners are suppressed by the kernel (verif_pid prev_pid == -1).
+	 */
+	ftrace.evlist = evlist__new();
+	if (ftrace.evlist) {
+		threads = thread_map__new_by_tid(500);
+		perf_evlist__set_maps(evlist__core(ftrace.evlist), NULL, threads);
+		perf_thread_map__put(threads);
+	}
+
+	ftrace_cpu_states__clear();
+	ftrace_process_fgraph_line(&ftrace, " 0)               |  func_a() {", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)               |    func_b() {", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)               |    } /* func_b */", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)               |  } /* func_a */", out);
+
+	evlist__put(ftrace.evlist);
+	ftrace.evlist = NULL;
+
+	/*
+	 * Test migration where task with active outer frame on CPU 0 migrates
+	 * to CPU 1 without an initial context switch banner, accumulating inner
+	 * frames in ts under FTRACE_UNKNOWN_PID(1). Rekeying must append inner
+	 * frames to existing stack rather than inverting the stack.
+	 */
+	ftrace_cpu_states__clear();
+	ftrace_process_fgraph_line(&ftrace, " 0)               |  caller_outer() {", out);
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)    task7-700   =>    <idle>-0 ", out);
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	/* Migrates to CPU 1 without banner; inner frame called */
+	ftrace_process_fgraph_line(&ftrace, " 1)               |    callee_inner() {", out);
+	/* Banner on CPU 1 rekeys CPU 1 to task7 */
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)    task7-700   =>    <idle>-0 ", out);
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	/* Resumes on CPU 0: callee_inner exits, followed by caller_outer */
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)    <idle>-0    =>    task7-700 ", out);
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)               |    } /* callee_inner */", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)               |  } /* caller_outer */", out);
+
+	/*
+	 * Test task migration where older stack has scheduler frames that already
+	 * exited before the task entered a callee on the new CPU.
+	 * CPU 0 has caller_outer (indent 2) -> schedule (indent 4) -> __schedule (indent 6).
+	 * Resumes on CPU 1 where schedule frames returned and callee_worker (indent 4) runs.
+	 * Rekeying must prune schedule and __schedule from older stack rather than
+	 * leaving stranded frames between caller_outer and callee_worker.
+	 */
+	ftrace_cpu_states__clear();
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)    <idle>-0    =>    task8-800 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)               |  caller_outer() {", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)               |    schedule() {", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)               |      __schedule() {", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)               |    callee_worker() {", out);
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)    task8-800   =>    <idle>-0 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 1) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)    task8-800   =>    <idle>-0 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 1) ------------------------------------------", out);
+	/* Resumes on CPU 0: bare braces pop callee_worker then caller_outer */
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)    <idle>-0    =>    task8-800 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)   1.000 us    |    }", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)   2.000 us    |  }", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)               |  base_verify() {", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)   1.000 us    |  }", out);
+
+	/*
+	 * Test migration where task unwinds to depth 0 on CPU 1 before CPU 0
+	 * emits its delayed context switch banner. Rekeying must prune the
+	 * already-exited frames from the older stack rather than restoring them.
+	 */
+	ftrace_cpu_states__clear();
+	ftrace_process_fgraph_line(&ftrace, " 0)               |  caller_deep() {", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)               |    callee_deep() {", out);
+	ftrace_process_fgraph_line(&ftrace, " 1) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)    <idle>-0    =>    task9-900 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 1) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)   1.000 us    |    } /* callee_deep */", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)   2.000 us    |  } /* caller_deep */", out);
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)    task9-900   =>    <idle>-0 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)               |  fresh_root() {", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)   1.000 us    |  } /* fresh_root */", out);
+
+	/*
+	 * Test migration where older stack has an inlined frame at the top
+	 * when rekeying. Pruning must not stall on raw_indent == -1.
+	 */
+	ftrace_cpu_states__clear();
+	ftrace_process_fgraph_line(&ftrace, " 2)               |  wake_up_new_task() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+				   " 2)               |    enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */",
+				   out);
+	ftrace_process_fgraph_line(&ftrace, " 3) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 3)    <idle>-0    =>    task10-1000 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 3) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 3)   1.000 us    |    } /* enqueue_task */", out);
+	ftrace_process_fgraph_line(&ftrace, " 3)               |    other_work() {", out);
+	ftrace_process_fgraph_line(&ftrace, " 2) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 2)    task10-1000 =>    <idle>-0 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 2) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 3)   1.000 us    |    } /* other_work */", out);
+	ftrace_process_fgraph_line(&ftrace, " 3)   2.000 us    |  } /* wake_up_new_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	/* Verify synthetic inlined entry was emitted for Task 1 */
+	TEST_CS_ASSERT("task1 emitted inlined activate_task entry",
+			strstr(out_buf, "activate_task() { /* (inline) */") != NULL);
+
+	/* Verify default_idle in Idle task started at base indentation without extra indent */
+	TEST_CS_ASSERT("idle task starts at base indentation",
+			strstr(out_buf, "|  default_idle() {") != NULL);
+	TEST_CS_ASSERT("idle task does not inherit extra inlined indent",
+			strstr(out_buf, "|    default_idle() {") == NULL);
+
+	/* Verify func2 in Task 2 started at base indentation "|  func2() {" without extra indent */
+	TEST_CS_ASSERT("task2 starts at base indentation",
+			strstr(out_buf, "|  func2() {") != NULL);
+	TEST_CS_ASSERT("task2 does not inherit extra inlined indent",
+			strstr(out_buf, "|    func2() {") == NULL);
+
+	/* Verify task1 synthesized inlined exit on CPU 1 */
+	TEST_CS_ASSERT("task1 emitted synthesized inlined exit on CPU 1",
+			strstr(out_buf,
+			       "1)               |    } /* activate_task (inline) */") != NULL);
+
+	/* Verify task3 preserved inlined stack across delayed context switch banner */
+	TEST_CS_ASSERT("task3 preserved inlined frame across delayed banner",
+			strstr(out_buf,
+			       "3)               |    } /* activate_task (inline) */") != NULL);
+
+	/* Verify task4 merged outer stack when entered before delayed banner */
+	TEST_CS_ASSERT("task4 merged outer stack when entered before delayed banner",
+			strstr(out_buf, "3)               |  } /* func5 */") != NULL);
+
+	/* Verify single-task stack tracked across CPUs without banners */
+	TEST_CS_ASSERT("single-task stack tracked across CPUs without banners",
+			strstr(out_buf, "0)               |  } /* func_a */") != NULL);
+
+	/* Verify migrated task with unbannered entry appended rather than inverted stack */
+	TEST_CS_ASSERT("migrated task unwound inner callee cleanly",
+			strstr(out_buf, "0)               |    } /* callee_inner */") != NULL);
+	TEST_CS_ASSERT("migrated task unwound outer caller cleanly",
+			strstr(out_buf, "0)               |  } /* caller_outer */") != NULL);
+
+	/* Verify pruned scheduler frames allowed clean bare brace unwinding */
+	TEST_CS_ASSERT("pruned scheduler frames allowed clean bare brace unwinding",
+			strstr(out_buf, "|  base_verify() {") != NULL);
+
+	/* Verify unwound migrated task starts at base indent */
+	TEST_CS_ASSERT("unwound migrated task starts at base indent",
+		       strstr(out_buf, " 1)               |  fresh_root() {") != NULL);
+
+	/* Verify inlined frame pruned without stalling on migration */
+	TEST_CS_ASSERT("inlined frame pruned without stalling on migration",
+		       strstr(out_buf, " 3)   1.000 us    |    } /* other_work */") != NULL &&
+		       strstr(out_buf, " 3)   2.000 us    |  } /* wake_up_new_task */") != NULL);
+
+	/*
+	 * Test migration where merged stack depth exceeds initial FTRACE_MAX_STACK (256)
+	 * triggers dynamic stack growth and unwinds without indentation drift or corruption.
+	 * CPU 2 starts without a context switch banner, accumulating under
+	 * FTRACE_UNKNOWN_PID(2).
+	 */
+	free(out_buf);
+	out_buf = NULL;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_cleanup;
+	}
+
+	for (i = 0; i < 200; i++)
+		feed_fgraph_entry(&ftrace, 2, i, "deep_func", NULL, out);
+
+	/* Migrate to CPU 3, enter more frames */
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 3)    <idle>-0    =>    task5-500 ", out);
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	for (i = 0; i < 100; i++)
+		feed_fgraph_entry(&ftrace, 3, 200 + i, "more_func", NULL, out);
+
+	/* Delayed context switch banner from CPU 2 rekeys and merges stacks (> 256) */
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 2)    task5-500   =>    <idle>-0 ", out);
+	ftrace_process_fgraph_line(&ftrace, " ------------------------------------------", out);
+
+	/* Unwind all 300 frames on CPU 3 on dynamically resized stack */
+	for (i = 299; i >= 0; i--)
+		feed_fgraph_exit(&ftrace, 3, i, NULL, out);
+	feed_fgraph_entry(&ftrace, 3, 0, "after_merge", NULL, out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	TEST_CS_ASSERT("no indentation drift after saturated stack rekey",
+			strstr(out_buf, "|  after_merge() {") != NULL);
+
+	/*
+	 * Test migration where task exits to depth 0 on CPU 1 (setting min_raw_indent = 2),
+	 * migrates to CPU 0 entering outer frames wake_up_new_task (indent 2) -> enqueue_task (indent 4)
+	 * with activate_task inlined, migrates back to CPU 1 entering inner callee_c (indent 6).
+	 * Delayed rekeying of CPU 0 must not over-prune caller frames using
+	 * CPU 1's previous min_raw_indent.
+	 */
+	free(out_buf);
+	out_buf = NULL;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_cleanup;
+	}
+
+	ftrace_cpu_states__clear();
+	ftrace_process_fgraph_line(&ftrace, " 1) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)    <idle>-0    =>    task11-1100 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 1) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)               |  root_prior() {", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)   1.000 us    |  } /* root_prior */", out);
+	/* Task 11 migrates to CPU 0 without banner, entering active caller frames with inline */
+	ftrace_process_fgraph_line(&ftrace, " 0)               |  wake_up_new_task() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+				   " 0)               |    enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */",
+				   out);
+	/* Task 11 migrates back to CPU 1 and enters inner frame */
+	ftrace_process_fgraph_line(&ftrace, " 1) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)    <idle>-0    =>    task11-1100 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 1) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)               |      callee_c() {", out);
+	/* Delayed banner on CPU 0 triggers rekey */
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)    task11-1100 =>    <idle>-0 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	/* Resumes on CPU 1: callee_c, enqueue_task (synthesizing activate_task exit), wake_up_new_task */
+	ftrace_process_fgraph_line(&ftrace, " 1)   1.000 us    |      } /* callee_c */", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)   2.000 us    |    } /* enqueue_task */", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)   3.000 us    |  } /* wake_up_new_task */", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	/* Verify active caller frames preserved despite prior exit min_raw_indent */
+	TEST_CS_ASSERT("task11 emitted synthesized inlined exit on CPU 1",
+		       strstr(out_buf,
+			      " 1)               |    } /* activate_task (inline) */") != NULL);
+
+	/*
+	 * Test multi-stage rekeying where CPU 1 unwinds frames to depth 0 first
+	 * (recording min_raw_indent = 2) and merges into an existing state,
+	 * followed by CPU 0 rekeying its older UNKNOWN_PID state.
+	 * The merge into existing must preserve min_raw_indent so CPU 0's older
+	 * exited frames are properly pruned rather than resurrected.
+	 */
+	free(out_buf);
+	out_buf = NULL;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_cleanup;
+	}
+
+	ftrace_cpu_states__clear();
+	/* CPU 0: Task 12 enters frames under UNKNOWN_PID(0) with inline */
+	ftrace_process_fgraph_line(&ftrace, " 0)               |  wake_up_new_task() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+				   " 0)               |    enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */",
+				   out);
+	/* CPU 1: Task 12 unwinds both frames to depth 0 under UNKNOWN_PID(1) */
+	ftrace_process_fgraph_line(&ftrace, " 1)   1.000 us    |    } /* enqueue_task */", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)   2.000 us    |  } /* wake_up_new_task */", out);
+	/* CPU 2: pre-bind an empty state for task 12 */
+	ftrace_process_fgraph_line(&ftrace, " 2) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 2)    <idle>-0    =>    task12-1200 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 2)    task12-1200 =>    <idle>-0 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 2) ------------------------------------------", out);
+	/* CPU 1 emits banner first: merges ts1 (depth 0, min_raw_indent 2) into existing */
+	ftrace_process_fgraph_line(&ftrace, " 1) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)    task12-1200 =>    <idle>-0 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 1) ------------------------------------------", out);
+	/* CPU 0 emits banner second: merges ts0 into existing, must prune exited frames */
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)    task12-1200 =>    <idle>-0 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	/* Task 12 resumes on CPU 1 and runs fresh function: bare braces must not pop stale frames */
+	ftrace_process_fgraph_line(&ftrace, " 1) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)    <idle>-0    =>    task12-1200 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 1) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)               |  fresh_task12() {", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)   1.000 us    |  }", out);
+
+	fclose(out);
+	ftrace_cpu_states__clear();
+
+	/* Verify multi-stage rekey preserved min_raw_indent to prune stale exited frames */
+	TEST_CS_ASSERT("fresh_task12 starts at base indent without resurrected frames",
+		       strstr(out_buf, " 1)               |  fresh_task12() {") != NULL);
+	TEST_CS_ASSERT("stale inlined frame not resurrected before fresh_task12",
+		       strstr(out_buf, "} /* activate_task (inline) */\n 1)               |  fresh_task12() {") == NULL);
+
+	/*
+	 * Test migration where task exits bar() (indent 4) and enters qux() (indent 4)
+	 * on unbannered CPU 1, then migrates back to CPU 0 entering child baz() (indent 6)
+	 * before CPU 1 emits its context switch banner.
+	 * Rekeying of CPU 1 must prune exited bar(), insert qux() between foo()
+	 * and baz(), and cleanly unwind baz, qux, and foo on CPU 0.
+	 */
+	free(out_buf);
+	out_buf = NULL;
+	out = open_memstream(&out_buf, &out_len);
+	if (!out) {
+		ret = TEST_FAIL;
+		goto out_cleanup;
+	}
+
+	ftrace_cpu_states__clear();
+	/* CPU 0: Task 13 enters root (indent 2) -> foo (indent 4) */
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)    <idle>-0    =>    task13-1300 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 0) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)               |  root() {", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)               |    foo() {", out);
+	/*
+	 * Task 13 migrates to CPU 1 without banner: exits foo,
+	 * enters wake_up_new_task -> enqueue_task.
+	 */
+	ftrace_process_fgraph_line(&ftrace, " 1)   1.000 us    |    } /* foo */", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)               |    wake_up_new_task() {", out);
+	ftrace_process_fgraph_line(&ftrace,
+				   " 1)               |      enqueue_task() { /* <-wake_up_new_task+0x1d1/0x3e0 */",
+				   out);
+	/* Task 13 migrates back to CPU 0 and enters child baz */
+	ftrace_process_fgraph_line(&ftrace, " 0)               |        baz() {", out);
+	/* Delayed banner on CPU 1 triggers rekey */
+	ftrace_process_fgraph_line(&ftrace, " 1) ------------------------------------------", out);
+	ftrace_process_fgraph_line(&ftrace, " 1)    task13-1300 =>    <idle>-0 ", out);
+	ftrace_process_fgraph_line(&ftrace, " 1) ------------------------------------------", out);
+	/*
+	 * Task 13 unwinds baz, enqueue_task (synthesizing activate_task),
+	 * wake_up_new_task, root on CPU 0.
+	 */
+	ftrace_process_fgraph_line(&ftrace, " 0)   1.000 us    |        } /* baz */", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)   2.000 us    |      } /* enqueue_task */", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)   3.000 us    |    } /* wake_up_new_task */", out);
+	ftrace_process_fgraph_line(&ftrace, " 0)   4.000 us    |  } /* root */", out);
+
+	fclose(out);
+	pr_debug("OUT_BUF:\n%s\n", out_buf);
+	ftrace_cpu_states__clear();
+
+	TEST_CS_ASSERT("task13 synthesized inlined exit for enqueue_task",
+		       strstr(out_buf, "} /* activate_task (inline) */") != NULL);
+
+out_cleanup:
+	if (out_buf)
+		free(out_buf);
+	perf_ftrace__cleanup_inlines(&ftrace);
+out_cleanup_conf:
+	symbol_conf.vmlinux_name = saved_vmlinux;
+	symbol_conf.ignore_vmlinux_buildid = saved_ignore_buildid;
+	return ret;
+}
+#undef TEST_CS_ASSERT
+
+static int test__parse_retaddr(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	return test_parse_retaddr();
+}
+
+static int test__filter_retaddr(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	return test_filter_retaddr();
+}
+
+static int test__column_layouts(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	return test_column_layouts();
+}
+
+static int test__stack_saturation(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	return test_stack_saturation();
+}
+
+static int test__context_switch_handling(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	return test_context_switch_handling();
+}
+
+static int test__inline_processing(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	return test_inline_processing();
+}
+
+static struct test_case ftrace_test_cases[] = {
+	TEST_CASE("Parse return address comments", parse_retaddr),
+	TEST_CASE("Filter return address comments", filter_retaddr),
+	TEST_CASE("Function graph column layouts", column_layouts),
+	TEST_CASE("Stack saturation and expansion", stack_saturation),
+	TEST_CASE("Context switch handling", context_switch_handling),
+	TEST_CASE("Inline symbol and trace processing", inline_processing),
+	{ .name = NULL, }
+};
+
+struct test_suite suite__ftrace = {
+	.desc = "Ftrace inline processing",
+	.test_cases = ftrace_test_cases,
+};
-- 
2.55.0

