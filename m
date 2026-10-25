Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.125
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792951899;
	b=xDtrGPC7PLjzz0DF2V5Cfhf/B+neceb1BW+E//r7/lHPbLr+T1hZDBLcKbcik0K1SMFj
	 xlZw88SBR9l2YLCcDPrUEAav0XCMJQgGCmfXcq7BeV3J0ueJHloG7rzwAWplke0oyq4Qn
	 5AlzPkR5TBEYcnKRDWWXFArR9+hT6T6rYM+J093sqwTSRuONLyNj9hxEjj493t5t/FyPF
	 igpia5fxyj3xCGzrsWydpmKiORVTJP4j2I3YQpPTgaQBe6NybKubbBF05SYZZb00RdKRm
	 nkZkRU5Fd5Ra8tYmHFuHXCBdY4lNFRbaAXHIBP2ayHuC4yzOYz3Gyv29aUXJzZPI4iQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951899;
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
	bh=/r3OHPkBXoZzd03Ly8QKaDSufpeoxDklzjbITvX7Mzo=;
	b=yQCayUjqsjHD/BToniWTSh0dMF5Oy8h2mlw5RI8lWGfdU39i3SJpQLt894oBgfp5/ZN2
	 Hvqkq7ptW5CLImIJq63puXnUdzjRQPm49BZVExk51mmsnGr4kMBqwiHF2JbWz3VTTUs7X
	 uW1hCxVxNmYPzZ2h9QG3Pvar950reEWct+32UD7oqjP5+LE2WrDYafAXHG2JZOXRFdMTZ
	 Fy/4QqPjEb/AsykH653xLVVm5nsft2zVtbbtZCVf5R97DPCBQV4k8JQYu1slkErkDPFDQ
	 Fm5qPAjqIe9FyokbfM+HdxYpePDfnJfSnj2c0lW8sxZmviRWSdpxOhAhMmHIiUsnmwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.125
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020125.outbound.protection.outlook.com [52.101.196.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E14E606A31F;
	Sun, 25 Oct 2026 18:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E14E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBtoO5UdXfYI+7J/dxGLSNi2Dh2VGdX/bbxhSizxlBHyAkS6lWoyAQa3U9qg1EMqzp/oG09WVx49pdZA+sC+x4FlNmlF1YWCuCzhd/6ESqc2w2VrYyvkfolsQ4FXS26Qp6e66+XdYySjVi4YEiPMonIeGkrQa2m6WWjnZ+XAwubmcS/mrR/Il49ZxrflUyG3JwPtvCDA9NtWLswokJFjhdDG59WFgomnh6hUStu9qyypixzsI880tAk5vJnrnYMc9QpFOkP5hOAAj6c95YmBoB2TK0OJ9ST/vCXoaTXZ378QEFtslw7WQSs6HZAS/soGwOUTgiWa9PVEuSm1zRmMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=/r3OHPkBXoZzd03Ly8QKaDSufpeoxDklzjbITvX7Mzo=;
 b=rACDWVHu1+wMsDvs1HnnzjRk/hbkTpnN64yGeu6Lik/41TE7p4j4yxXQmTzamCyCE55iFviJ+fwgLTMNLRlY+XO03NtXu+fajsNYATcLmcQ4F+Lno9em5bIeP4GuUHESk04ZZadjVBxHiaF5Iq7tm/vb0q8hOLcdVmvYHNAOtjAwk4Y4yRMwx7f4ZXAcqYErDoGXxLc+M54ANi6GKa2yvv6+RKvR8uEKgDyfP0eSxCq/Sd4xdNB6GjQlTV9LK9rSy2ocis+5WySVad1zZBBsZ8CnGGgcwGrZVMcSW0H80BMHacgLDF2X5j6oku9gz6s9hnrgbZB5FBKaoU1ZBEB0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6815.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:30e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 18:11:37 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 18:11:37 +0000
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
Subject: [PATCH perf-tools-next v11 02/10] perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
Date: Sun, 25 Oct 2026 14:11:17 -0400
Message-ID: <20261025181125.514372-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025181125.514372-1-atomlin@atomlin.com>
References: <20261025181125.514372-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:408:142::18) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 64dc55e9-baf4-4098-b03c-08df32c368d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|5023799004|56012099006|261022105027099003|261022113327099003|261022075727099003|261009223027099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	VM86lI4Vdo+UynVSGhWMJgx8G9nghm9CwxufPgak8dSTFWtlzcI+gjp2riZZxEuF9q//tTcxR+y2ALS2Owp2zGTkHbknf8NgUUgnvoD7urczdYkw6WUkLTRTVDmNwPudBCwFJwWue7hMkHTqzEI2OCz1TRZJD/aLcql0JnLmZ2nOr99DTkJi9JOfoAZc0oVU9QEsvmjn2+7GNy1ZwmYHs1xAOlqsWP44Y6z48jRsuQuGymQa8GNpbTH7lEgSnX1oieHFlg+0ubAbQwaatHOjjdgY4BLQ0g6RBlJzfOGzUcj0qZsXvc0eDPLhvm4HP/rrg+chdkua28ODh+drJhMmEktqgVYIjcGztzp4JFtj41KANKNnl4rlpGI3iUaEg/Sii+qEnmiA3GlvePaxFV9oR8KD+NSGKR89X+CvQJAQ+h0h2yImyMU+Esr/LG32oHc1tffXZiuvmpg+WsCqxmjJAizm4amxHaxmcqYG/LCw5fb5MWSXHCO5sD44JYJA0NTG9r3VTv29xwXY1TTJ1f2U9r1LWIQbMFE8ZVwPaAXC9kRHtCmneMRDuzOZH2k20DPZhpZtUe1uPyxH9hdeFHiuIFSUuVwCPwhGNBw3c8oyLPAJF0fiEOdMvOv5OlC3shcDNhGyAnMtzB6nMKp27+d1VxTPb/xeQI2DWLQqyIpARBc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(5023799004)(56012099006)(261022105027099003)(261022113327099003)(261022075727099003)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uD4aQI4U8usICiJZOFUfa4zOXEHaWOnIdKRAjI7uOblYbPuSTSeTkqp6mrSa?=
 =?us-ascii?Q?UDDOYbZhn8fRmYF9pmOSdijWzDhF3LhHK3CD6F1WSFGgN4vkg3aWd/qO767R?=
 =?us-ascii?Q?xqqYE1llDLQH79MLud6/TlI+p7I543eBq1xXTPIjlt6svJo7nBBYXQyu/l/k?=
 =?us-ascii?Q?rqfML9Eg5PyIXaF2bdJJL5wLCtF6x5IkW33yUxofgsugJLvRi7J6GXUyWTYr?=
 =?us-ascii?Q?5HGeY1ehUyjngq79E3wmLHzDYcdgrIs11vb9Xz6o96gsKZtJ4o6ORmdejBwH?=
 =?us-ascii?Q?NzJgN9wIltlI9xtVshA1hthLN2UTzAo2WY/k082B2gxa5AzXUQZdtM+G4EAN?=
 =?us-ascii?Q?+seFpVvGFex5a0UbzUVV/DLZuCZG0AR+aMflFRRqKRIKAo3VY3owm5yyGGd3?=
 =?us-ascii?Q?c0uaoxa0bIB6trZaObbSoKf1fCA2MRR2x5S7epJFR1plHsv22etR8CU2OXzD?=
 =?us-ascii?Q?h7rGxzFuHU91E6BnmNj+Ntd/SxB2O5wv4xmvtjA6Czv3lqgk8D1jhPliSLQo?=
 =?us-ascii?Q?6V3xcUaLmLZukiDQJ/tAoXvouX59Qn6gD+y2Fp7cDNWowK8muxgImFOqr01O?=
 =?us-ascii?Q?sZzCOCnfeebbs5fzS0ylDiKHQlQhbTOVoK0HDDO/ohGPJDUyNYtxTgFl52N4?=
 =?us-ascii?Q?c5vtoKN7yN4l1bSInd/pfh0T55reGdV0wvdVwzWwHaEZFKbKlyPdX6x2ez2M?=
 =?us-ascii?Q?B6aRCln7dAq1q3mmRF3I++Khuv9Y7t3PjKG4MpMEbNqq4l81POaVeq7Y9IAK?=
 =?us-ascii?Q?pNKpygRS96Lce2M1uh2+W4lCj76vbMRmPADVqiWaAUSwrePHQD7GtAe+azHu?=
 =?us-ascii?Q?Yjjo6RL22/AliWaaPzfKVEFYqGJCb+Dn8XadYyndhn6pGracVIX9VbZu05l6?=
 =?us-ascii?Q?T2veKcRpaAnWh6ZWWnDd17Dne1HzPSAak9TfxzfOc4SxgiXKSLmkcpDcRAV7?=
 =?us-ascii?Q?Ol+cOWopk6RcvMlkSEnt3nQV/9oGDsI1pVokXJWbGVruzfj4uZXkiGgE8Bdp?=
 =?us-ascii?Q?YFiPEED/qfI3yXgKEIuF+1JA0edXbU9lCWf2GHIS673yIWXVyPataEcuCUwl?=
 =?us-ascii?Q?ksQudQ+Ii4GxZJfbl3uamow5XQjIaCA6NExVCGXxKnj38WrZT8QGLqfUoykb?=
 =?us-ascii?Q?xzURvy74WHiioOzBQxJO7bq3qpgBG7f/fgvhnZ/g5TnTo5IgfEus+3p6WI/d?=
 =?us-ascii?Q?2rRdZM4JpVuREKmxX1RRARoV46UdfQ2HOU18tf0JNzgO+cc1fYMBztkdodSo?=
 =?us-ascii?Q?9WHpig6g6Ddr+w6yAUGHeapqQn+BFP8pWuiaqn9tr5XEeckVKYMr6lXsp7lN?=
 =?us-ascii?Q?UIpnralZlb3uJ+BMUG4VeXSAsLgd/TVG99WGj+inA8kfLfgkWezoB8zAYlg8?=
 =?us-ascii?Q?EDI4ItBWIuCK71Pzp43BWjC/tioU+C+G4al0KFHwBHLVE/BX0Q4U9ArtgLXr?=
 =?us-ascii?Q?DKEDtpIDQuK2u4SpXIDUKuTKQhkj4cMJS4MaZInA9NT4ptL2WylOWyf81Bwx?=
 =?us-ascii?Q?iEl+i4Z4Q3wXaOBSEwSsi9YPxYGirGlID2M8XDd5ukGdx6gKcKkyTyH9VuoU?=
 =?us-ascii?Q?y02JlE1Qb8YLV/NsO++sSw4kVVm3CmXz0/mtyekAd6zRZHzoPwhMDjKRAkKH?=
 =?us-ascii?Q?HGHklADBtpmsLNgnrFp1S2cdk1qajh7mK1L/ez9R3Qn9pg0aI7wOXhPoib71?=
 =?us-ascii?Q?oDwP6K6KadVAOb/g+B5k3QiQ1eCyxmIP0IEPzGdPgRUTkjioKvC977ueyEX+?=
 =?us-ascii?Q?TmEbvs3w6Q=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dc55e9-baf4-4098-b03c-08df32c368d0
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 18:11:37.0324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLe1Ft6vksDlLhGepy5YxaWIjJo2Y+R8QZlbNIEzCUZEcMrSC/M2MEscYeIrQ4I5ly5o2iKK8JB70yFVIMsulg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6815

In __cmd_ftrace(), incoming trace data from trace_pipe was historically
buffered in a fixed 4096-byte array allocated directly on the stack
frame. Furthermore, reads were written directly to stdout via fwrite()
in arbitrary chunk sizes, rather than as discrete, well-delimited
trace lines.

Refactor __cmd_ftrace() to employ dynamic heap allocation for the read
buffer alongside a dynamic struct strbuf to accumulate streamed
characters into whole lines. Pre-allocating the strbuf ensures that
line processing incurs zero heap reallocations during steady-state
polling, whilst the stack frame of __cmd_ftrace() is reduced by over 96%
(down to ~160 bytes). Emitting complete lines provides discrete records
necessary for subsequent call graph parsing and inlined function
reconstruction.

Tested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-ftrace.c | 56 ++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 7cdc9ae2fbbb..65983259b07e 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -42,7 +42,10 @@
 #include "util/units.h"
 #include "util/parse-sublevel-options.h"
 
+#include "util/strbuf.h"
+
 #define DEFAULT_TRACER  "function_graph"
+#define TRACE_BUF_SIZE  4096
 
 static volatile sig_atomic_t workload_exec_errno;
 static volatile sig_atomic_t done;
@@ -739,7 +742,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 {
 	char *trace_file;
 	int trace_fd;
-	char buf[4096];
+	char *buf = NULL;
+	struct strbuf linebuf = STRBUF_INIT;
 	struct pollfd pollfd = {
 		.events = POLLIN,
 	};
@@ -768,10 +772,18 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 
 	setup_pager();
 
+	buf = malloc(TRACE_BUF_SIZE);
+	if (!buf) {
+		pr_err("failed to allocate trace buffer\n");
+		goto out_reset;
+	}
+	strbuf_init(&linebuf, 512);
+	strbuf_setlen(&linebuf, 0);
+
 	trace_file = get_tracing_instance_file("trace_pipe");
 	if (!trace_file) {
 		pr_err("failed to open trace_pipe\n");
-		goto out_reset;
+		goto out_free;
 	}
 
 	trace_fd = open(trace_file, O_RDONLY);
@@ -780,7 +792,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 
 	if (trace_fd < 0) {
 		pr_err("failed to open trace_pipe\n");
-		goto out_reset;
+		goto out_free;
 	}
 
 	fcntl(trace_fd, F_SETFL, O_NONBLOCK);
@@ -814,7 +826,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 		}
 
 		if (pollfd.revents & POLLIN) {
-			int n = read(trace_fd, buf, sizeof(buf));
+			int n = read(trace_fd, buf, TRACE_BUF_SIZE);
 
 			if (n < 0) {
 				if (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR)
@@ -823,8 +835,16 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 			}
 			if (n == 0)
 				break;
-			if (fwrite(buf, n, 1, stdout) != 1)
-				break;
+			for (int i = 0; i < n; i++) {
+				if (buf[i] == '\n') {
+					if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
+						break;
+					strbuf_setlen(&linebuf, 0);
+				} else {
+					if (strbuf_addch(&linebuf, buf[i]) < 0)
+						goto out_close_fd;
+				}
+			}
 			/* flush output since stdout is in full buffering mode due to pager */
 			if (fflush(stdout) < 0 || ferror(stdout))
 				break;
@@ -834,7 +854,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	write_tracing_file("tracing_on", "0");
 
 	if (workload_exec_errno) {
-		const char *emsg = str_error_r(workload_exec_errno, buf, sizeof(buf));
+		const char *emsg = str_error_r(workload_exec_errno, buf, TRACE_BUF_SIZE);
 		/* flush stdout first so below error msg appears at the end. */
 		fflush(stdout);
 		pr_err("workload failed: %s\n", emsg);
@@ -843,7 +863,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 
 	/* read remaining buffer contents */
 	while (!ferror(stdout)) {
-		int n = read(trace_fd, buf, sizeof(buf));
+		int n = read(trace_fd, buf, TRACE_BUF_SIZE);
 
 		if (n < 0) {
 			if (errno == EINTR)
@@ -852,12 +872,28 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 		}
 		if (n == 0)
 			break;
-		if (fwrite(buf, n, 1, stdout) != 1)
-			break;
+		for (int i = 0; i < n; i++) {
+			if (buf[i] == '\n') {
+				if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
+					break;
+				strbuf_setlen(&linebuf, 0);
+			} else {
+				if (strbuf_addch(&linebuf, buf[i]) < 0)
+					goto out_close_fd;
+			}
+		}
+	}
+
+	if (!ferror(stdout) && linebuf.len > 0) {
+		fprintf(stdout, "%s\n", linebuf.buf);
+		strbuf_setlen(&linebuf, 0);
 	}
 
 out_close_fd:
 	close(trace_fd);
+out_free:
+	free(buf);
+	strbuf_release(&linebuf);
 out_reset:
 	exit_tracing_instance();
 out:
-- 
2.55.0

