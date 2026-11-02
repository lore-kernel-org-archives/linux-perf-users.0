Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793655670;
	b=gshBJ5GuoWCUYVWdvNCLWewegNDOrl+3BLulwVB8JVxMWBFY5AJLCXvEzjxIS2D8aMsL
	 7gaVjpdpM31Uz3rOo5C18ogFwG0nS71QccviCWVqUVbUy2VUcgdnfnUvZady4rNlsEakc
	 PQGQh1Asn0orJaJgVI0J9v/0Ct1HvKMvFKDVfBXi4uYF5KoOu3XL/0X8ihnJa9xUd6ycn
	 Aq8/8A9+mlovcT0+TxABcT+zwxVJy/iseLfEUcezFXTpUrUAv0PAok87w+ahV/tcZ1Gg4
	 OXaCyZz8ioGVgcvvqAtOfEdFpyzwMTuxkQjPSH4AZ25SnZOowOQPYZRkHvWzYtL9aig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655670;
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
	b=3mwRxzFe/Sodf4WhlAqYd2CCRPYDv8+GQbCgrfJxlsmurgdaiCs6zk2W6FOli8nKzTB4
	 kEzsFRQx7kUFPu0ck0YnBMWE9r/+l8hEc7ef4uGqv3vWMMT2ChsnP6hJ7Hcc0uzElPXHD
	 wxgidNQqTawKu732bO9Le10wmZWPf6/+13bdrXheJf8q3N8Tah6mNwR84D2P91hW+rb8q
	 3y8SinTTY4as9kCMzbo3D2pV1uAuM1Mv4II6+PqSyaBatYnlwUkU6qbgBbCW9r75u7gOn
	 VMNvGKESjWmSnx71HHmrJW4ofbv9ovyXcOgA3P5SHUoutrB5JLKwTkCcIx7BjlZp3WQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.75
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021075.outbound.protection.outlook.com [52.101.95.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1C8606A338;
	Mon,  2 Nov 2026 21:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D1C8606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tujOb6dV3smqqS3sJqHMAEGoqidH4BTLaw8geSb8kPx/UimWiRaHj21WqI2HsAPiccILVRnDKumSVxgoW0YknXLtUCJVMw1ApCLaLL2PckAlRGEStXAMGaoiO1u0wOlXyprfOaVc+RJ5OGCP7vDyStBZBGcBjaXPTd+J0rTmoz2u5hZBMVDOWFRo1RmLRCRQoBTPZ+dGvSqatVGikh4mJSg4E43tYRp9XOYxrxlLimxjXs46x52ifNlqeeX30ZHJOCu+mu7jr/lRFST3a53AiKg2U/Z0frOuXpSgruRh3y5BQAphc8Cy7z79anC8anF+GyBUnPIPyq348kDqDJRyGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=/r3OHPkBXoZzd03Ly8QKaDSufpeoxDklzjbITvX7Mzo=;
 b=UvA/eoRFhGl/gYk203MWpVczWqdvH1sY4pXxpe0SgdQKPYsX8nRI4SRIkMXZmJadE4f3/PrUhfc3aOpJntgR5Xt8QkDH7bXRG7w9gMpJ4zzRl4xMw1LxZ7rYqnWgxyQwnBs3PD1GHC5/PHJMIX+GZUhHIPrVUU3WwEcmQSa2aupJfWTO7QnzkeCa+0RcKV/2k6uDdz9m3A/oFfa8BkMRv2uRI+Y7eYqrWYNWd3EygA1Pf5bph44ozjm8eJOIylkD2Dh4kyDVrxp6XtMEs1zcvlXSSFy5Nltci9xWymCZQNibr5LZ4vN6qRfsHaScUkhHwNbyzIbql7L8yqwn3j+b3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by CWXP123MB3814.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:4c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:41:06 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 21:41:06 +0000
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
Subject: [PATCH perf-tools-next v13 02/10] perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
Date: Mon,  2 Nov 2026 16:40:46 -0500
Message-ID: <20261102214054.911298-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102214054.911298-1-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0680.namprd03.prod.outlook.com
 (2603:10b6:408:10e::25) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: f985932e-16b3-4dc3-304d-08df3929ffbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|3023799007|6133799003|10067099003|18002099003|22082099003|261102123227099003|56012099006|5023799004|261022113327099003|261026121527099003|261022105027099003|261026140227099003|261022075727099003|261009223027099003|261028144727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	VRklkavOqlEn45+H92c5TwYTUKhzBzDvAzicafL/0dk1UDoRnSQesc9HS1Hfe+v/eNmqBf394CzB2zL65NnqDypvanfoKQeqMzPhdzynjGQNPj0xneRKF8jKAph3CodOPP0Ugo1yf9al3OWwrhruk0O1nmAfq8G6M/SQhU7lk6FnsS3BNHfcKLoDHSUA/XAHNXa8wlfyzDLfZv0TFgigykLU5n2bw9su9KbazVGa0ylY3lg7M2sIhbUkGQAeGmO5rlZDJN2SF2zOFL5NXDnlbOsE/XmZ6X1EQqaw+RQiZPvzMoFwkgixAoiG8LKxHZNVIaYMgy3IBteuS91E4rVY0KiLKph5pNmydxn5g+YkPfmyRbLv7ybuxMhIGRUMYt4tOFYfowPGPP0Wlr/z9eLThLdrVTc+e5+kpThLxDczlLtaCZF93HRmP083dXxpn+EG9NI8vKzuMJ84sPoRupQhOnj1jci39b5lqkxj2ZawvD7hfTswFrpOZi2V7FrdHbB4fXSxhLmBNmRC3j/wZnJjeJkUVt7s+FZk5ig6qQ9j+h8LbsEyIa32oLvA0yJ2P0K5AKlJoHiyZFeWPQQDc2Cr3bG7N8nhlXWjyzEdACC3C4lmAK4JGUk56K1nXgJFcKfyeUDTbdUBVwq24wyDrXLlvoyzXOlyLedmc30hK7CV4Q8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(3023799007)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(5023799004)(261022113327099003)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G5zFMI92M8iKGx0U0WVRC2Rs50neZbi+3NDcHdTwsDyoatjTXX1repzdGclu?=
 =?us-ascii?Q?Tbcon1XnlfLddcxAjaGdhKlOAuk1zIO29gFO50ELq5GR9JkVaRnvxCSapLd2?=
 =?us-ascii?Q?fNuPakCUd+Gr7BFT3js2jHEBYleaQLgQYj2JWq1/Hd36VTidbskK/DEFGHXP?=
 =?us-ascii?Q?fIUdeISaYURJXnlYKykRizL61he2GuUstuXEZVROcpgpCP6TqPfJKXrDTxZN?=
 =?us-ascii?Q?bocjplSsi83Tr95RLFe8Pxt2WJH/NqafTmKJInfNzZyiz+4uXWFLon6M+N72?=
 =?us-ascii?Q?odbSFNejsjFJsiqpWLoyNyitUOPjy3QLoz1Hwd3Lv8ArJXKogmx5No90kTxl?=
 =?us-ascii?Q?C5ifHLvZlaLtc2iR+coqD1nCJJq+7hZY3kzXy/OUvA6hCPAcx2Rx09681VKb?=
 =?us-ascii?Q?5odMHzP/TPyPGphsz6gEl2Ca5Fn/TsvM2FMNgKYT8y2ARqvPvjX377VjRel9?=
 =?us-ascii?Q?pdWzxrsjvIQs5qNl5pCYzD0ll+kPPrQkMZpVipIEzfhDNqGjVDwPM2dc2pHH?=
 =?us-ascii?Q?eU0UPoFIx7gos1xf8OWH2e5r/VPNKOMi/Hg+pLEMmCca3rdNZmSn3e5+gGyc?=
 =?us-ascii?Q?eL/fPwYu7JUAJ7GSJVJh8fnxELyrJl4f28mIUdGj2i5CazLkZP1rjovTRopi?=
 =?us-ascii?Q?el6IQgc3SUYm+AOzJj7ugUdFmllOdSnqAlcOra0mP7aiWQXdkTC3UfX2PY+1?=
 =?us-ascii?Q?Dzwg+HSeqvZIXbN6gv9JXMgrJZ5duZm60++GVU52WCtm02X2nqhSOXfz2XKh?=
 =?us-ascii?Q?+lfh7bdZIgvM+XAvXgQICKO4eG38Bgn/lgtEpdndCnXtVfrDbpGZuBJy+Rj1?=
 =?us-ascii?Q?Btnky9XZYEVPBY7ogREo1dDm0k7Xi/OJUHrNdKurzJkSYZtAQp2qd/tAdG23?=
 =?us-ascii?Q?1o+kRHQDaH/jlY/rwCC1aVyDccwiQ/viRNG80Mqz9qQdwRyyQHcJolKrMkYo?=
 =?us-ascii?Q?dngIgpTbcO3S03yqnMUN4bcYz3VJ98F57fWIUXjioDOLsLoku8zFTFzUl0B6?=
 =?us-ascii?Q?8XtSg5c9waCi6mcn8g/0bFeHq1bwPPIid1tMB6UdCA4VJKrdlBBTRuRv3JG6?=
 =?us-ascii?Q?S73Ow2ZnlvE4SK7DihF+L6+rOLS/BlB7jHP8O8BpJbJ5w0NSDeaxTnL79zD+?=
 =?us-ascii?Q?s5IY2Vn4FFbnVxDbnEOh3eNZifq03a8HEySArF5TTrnJiI5HhWHVWVWjdRSl?=
 =?us-ascii?Q?uloYsrvX1iIaZEZIliJuRFRPgkSa6xb+Mjm1erH0GgDZ5SIoSt3O/+rIPwDL?=
 =?us-ascii?Q?JiY25yJIwDG8DuFA7hbjmgHy1b5hRRvjDOgjznNxa3QgKu5BFhUd24PaVbfM?=
 =?us-ascii?Q?279pnkWQU6rD5RaIEFB7NP7tniVMPCH/hDmpFY9FSjzptGoVpMPtdOfljwYo?=
 =?us-ascii?Q?RHtksLD1SUPI/lwBkNb6vkOlATeVULPmHV2RfZ4L1XPG5FH/xs3ymq47plQo?=
 =?us-ascii?Q?mjjJDp04A9W/ch0ODx7Jb9okDku8/Xxcky/o5hEMyEmB/AtFMd6eAqz96d6j?=
 =?us-ascii?Q?lDsaa5HURlLSoSQAUrovSYhPW7xyFDvRH6+1aU2n1wbyfwRq7QCvIHQWSFgL?=
 =?us-ascii?Q?QTReiPFa2LInPP3SMwWhroF7x6Hn324VV/ov0IHsHzk2k9uLG76om47K13a6?=
 =?us-ascii?Q?EDBghBi0bcMK6HhsSs4M2z6zGOjxmkVR9Pnrm5AKMHzmpRaEhpG8rZwQADYG?=
 =?us-ascii?Q?/M2Y0pclePlh3Ey2Js5jmEEZcGkywvXZ/Gol7vYXCmxWBQKcHc354rFArXmb?=
 =?us-ascii?Q?Uxw1hcHUVg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f985932e-16b3-4dc3-304d-08df3929ffbe
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:41:06.0407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRJPqHWNv3B3Ip9gjIjzN6PNeFUpWsjn8YSJSNb9c5JgdTsbKtT25IaaTJrEROvymv1KL2KwZIupD6PifDDytg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3814

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

