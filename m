Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.93
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792983473;
	b=DONDYImFRmZtSY3ZMm9IG6zUfx8ew82AteZXx6d8t12Zvgzbxc3k4qx4SwwE26cn5c0R
	 qgY+HbyiB7Tnr09WY0sz3WzsCR6lzG9B38py+w0V6v+XNLofLTGViU5t3F51DVnHXoz9l
	 KKVN/LIyWD+AheZRzLpEQdSR5OuoY7gJzuTkNPr9OH/KN2bc4qM3zoAgFp3OoAA9fG6ST
	 WkkQJC2CPJLZA10vzMEiUuaNJwHnyNlz85r1TIiybF7J8HJlhOzZziqt/MQbT7e+d4toD
	 OYPSg96ujFRvjdHP6TW1m3/UFbs5DbrDVCuxqxu3hdsnzZW+4Ls83CMDMq4BEe+3U8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983473;
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
	b=T+iMXpJnknsJT0oiqYCplYtnzYoqBOSScU5lfPXCHh/zjPJNRwClx47GVBs+DIwvk+aC
	 Ox97DSVrxXg3KrdUtpLyfZRz85rqECHRCH4xI86+YIYv4f8U2vXb08AQx4cGJr5cIqmy8
	 awA4OXtlT0Ke5B64NdRjzHce7fFt94kLzW3ORBfLk4RsFO51NphaDKgati+MbPEZN/uh5
	 N2Z4S0pivbn+ikJxqIgkWMDT2RPClc+RsnleiB+KkmQreSBwynSPwatVdZoJpuWoMpABr
	 hFAePxKrObJXLa1Xy3wd5F3TgDoumvp05UhTcDGwGHUU5MHN+JFw54W6JTffPvmBwfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.93
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021093.outbound.protection.outlook.com [52.101.100.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E741606A322;
	Mon, 26 Oct 2026 02:57:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E741606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h26iy48U4+9eOaOrZxGPqBebE6BIMJKyiS1dA7IKyI4l/egac644lH/SEMTwOMWbciFBXi1jub0Mv8mCBrw/saBqpEO8oC72jqmgkULyLX1myiLrET0XmC1fA74hY3SzAEoNvQ+9Iw9JjEOKBweWzhN9MkEYcg2EKfAVeDRbbhpw6bvjHMYGN/4pwx88xvsPNTw72pJ0aZMmfLPPSyLFVOTsnl4+vrN8sAtIWx/E2ktLX3k/SbJ7QC+XijBSRJnnVQBrjsR0u+rwpn1RIgPmewUK98aasws9tNFaBioA/SQDSBShViY7z3R4/E0Lb/MmNeIawWHHsciDzO3h1tO6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=/r3OHPkBXoZzd03Ly8QKaDSufpeoxDklzjbITvX7Mzo=;
 b=w6GE+VVtrre3pEi/nYgE7iBSycCnqgD9h+FpRFedjcN5500PbKBxZsNDAQd35cGtBW3B6vh0HaT4deLNQr4omrxw2YyMUKMFp4v+WQq61O5C54lDqlLU4y5yMAZRaUxyg5tTT9R3FzNpJNH7D0FqBhIvty6FFusI5lwvQ89wMnn+Q5zyrlsoWv34WFmMCPzymfMerZc3OkXNNBzMKQU7ecKsg7WnCm+H/iVCUbKWkMvv/mu78uBqLH/PHuvGL6lMuAwICfLkwcvfCAvi1paFi2vbGSw82qMWft8x4bZCq5ntlBRdkbJBltaRHOQc+eyZs56tU3bHv6N/310HlNdRaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB9009.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:285::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 02:57:50 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 02:57:50 +0000
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
Subject: [PATCH perf-tools-next v12 02/10] perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
Date: Sun, 25 Oct 2026 22:57:27 -0400
Message-ID: <20261026025735.546101-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025735.546101-1-atomlin@atomlin.com>
References: <20261026025735.546101-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:510:23d::6) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 66c86e4f-71f1-4b22-9b14-08df330cebc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|5023799004|56012099006|261009223027099003|261022105027099003|261022113327099003|261022075727099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	zwHj5Y9+1oQxvTptICspFES+HRGk6rfeSVaWrmcCpZeLrU/gXVQhuDOUgOWia4nEwzKN13ZXUUYkZRxe1giKsDUbaG3oBfpAxjzxWRrvP0JBsone4luB8dctAIv86haT4abxHHn2Z5UXin+MuOqr9UhuAJhVpn/Yk5oMKcif+8/Jes5pM0Vv/nsXlPQmCTiUklBbQofbweEbfSxdnATEQnkXA1iiikTzkRNqJ94RNtbQMJF63CqWh6whLa/KSYqxaqbE1A+8zz+R+TbfLUn6pwhIe+MudSeMLWLDpf1PtcAhd3J1OI+O51jVi0ujNJVLg4SxeHuvcUV8g68TdMCU3UIHcrstXmSv78EqDnSFtDZ6YeO4waN2IBAirCW5+b06DvxuE5r9p08CmiF//WPRW3jwPuGxg/+AEELzEycrNPDE++E/zUSWqG4joDkIEMl6Kn2M3V8IKnhunpy4RlbjN3KLwHRr4M/ubtxAzwz1VdTKflA9HnrrrHouCfRvx+QSu+8T5SbLoXwOorRFwvhOARpuqy8YxcPpaoessmctj+ayzDsApEoVmnJu8IgwWTk6trw12gZ7A2IGvIralBQLRgpoCOEnM3uZPOAq9atlYU6xrCsA9vCbfk5z9IqR8kZgDz69N8HMNF8h5uVEjV6H9EXVAkXr6bakOrx8aVOkK6w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(5023799004)(56012099006)(261009223027099003)(261022105027099003)(261022113327099003)(261022075727099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?unAO9felHKvWwnqAuv0vBF0kjj9Wbhu6WGQRsolNzPxHz9fXDHcV7Jn6qOvb?=
 =?us-ascii?Q?MCRP8ZcRh9UeQKgn0DEv6gjt20C7CinJuC+zwTW5itCLeKagZsp/01k0D62w?=
 =?us-ascii?Q?ErDPdxEEF/y8lt6+IZs80o2+7eRCboz6Nff8iLwrPV9Vl9nqBtR/1BQeQlzS?=
 =?us-ascii?Q?1+aPWxb6OtR5V6ow0ks85s9eVYAHwCYc6UTFes6X2HQY+WXKbcCiOJB3PbaM?=
 =?us-ascii?Q?PC/x+4pNVeVcu43e9/77RJSAump4wmnQY2YANpVKNd9ESyOyQhWIfnKqrRI1?=
 =?us-ascii?Q?pszQ97wZGvW2F+Jvl4UmeR9WwGAcjqUpAaGAYVp/jvFa/mYllBixUeeb94JI?=
 =?us-ascii?Q?NPY5PyDu85ENcys9aJWlMr/eAX9xuPARvaHzL1mYcgCVht+4cGwKD7argPni?=
 =?us-ascii?Q?NRJbMA7rBoQQ9x4TBj6hJzFYKe7vNhZ5QUsG+ix3XluouIWSgxM8DkvZqLPr?=
 =?us-ascii?Q?IYm1Ai4zocmtxbjfyu228sNsuVjNeNYckftmTcfNJgw9c9wKJjmjFUzvU5ka?=
 =?us-ascii?Q?LY2X6ZGJI7HoPnyq4NH5MlaJJQRTk3yS93Y8LWnM4HA3jRjMmvSwu4puu0KM?=
 =?us-ascii?Q?1XhAI3YTQ+KuYLiXCils8DMQz5M49BZrVqVvjDF6GPu6QylKKojZluaqyb/m?=
 =?us-ascii?Q?oul63aGiZPOTFXMzfK4ll/BIRCOs2N6zBXhWpWwUkMYUogqfAAaGvQfcfx3Z?=
 =?us-ascii?Q?/MhuI7b5n0StteN6mY3A3Qb5g2DZDu7d2/5nk/e0hvwKOn0AEs3aA9wZ+3iq?=
 =?us-ascii?Q?pfKgmRsEbdKep+P/mpGbPc4q+fFS2/ivwDUVXrEQTu6yp+u+Txzcv43/PYak?=
 =?us-ascii?Q?Dt0+K78afboNmeRiEjmT22PR26HYKhizHvh6sTTHBea+sC7Oiyjz+/um7D95?=
 =?us-ascii?Q?gHkUzCmiZjwkfXTcb9kqfPA7DYVpWkN1+F+itPLvpgWaazXc+30I4b3QKHhu?=
 =?us-ascii?Q?DGjSFV3t4NMAzaz7ZfpJiElQcbjxErrfKJj+aw8qO0gKVz7wIvg50DwcxbGe?=
 =?us-ascii?Q?aChF5KVye9COzXnEk3WQP8SfEtmNCpCGDc0Ce6A+uW1fKhiHhyvO0DcVg34v?=
 =?us-ascii?Q?fgYN77PBh0kSxN40MbRsDDm53RVQPePsu4HuAmZcBpAWrxhqpib1jdG64ySw?=
 =?us-ascii?Q?r1m5315EKTaAWBLhdBoCcDep281oEi2r9l0JhIhyxt0mq1hEGRinbgxELA+6?=
 =?us-ascii?Q?mtvK+ETEcEnPT+9qoUwij6zLQL2XmSApgjQHfkbSyjzN+wiY1gyhaTwlptHL?=
 =?us-ascii?Q?4FkKfdBmsIn5XfgOtwZYEnL0S8h6puWyWid9b9foGqbl5GoQ0mAKuENW9nEP?=
 =?us-ascii?Q?QIjD0+Tpa6sOUN0v/96Y6MX7ytyuHpkO22UlcpG/IPYXxqas8rpVlXGT+3pP?=
 =?us-ascii?Q?hoDpSTmUXB6AJX/LDyfSXZ5i59cM9zwnGQt8ykymGihNpZMqgyLiAgvqZh2r?=
 =?us-ascii?Q?X3E9b0vVyh5agBjf1BGtI0tr7anYPcTBRmlGmdF9PrMy98SVjRZpN9IKQBKt?=
 =?us-ascii?Q?bPj/C1+nO0o285vFNeTsMLH0xgorEnbyF3ncMJMfVzDxWvx2SP44sI74xw6C?=
 =?us-ascii?Q?9Vuec70Y7W5GNhLHhKb6dlwmVvvGkqsI//4t1+VSjlq1e6MpOB5LYlaIMATT?=
 =?us-ascii?Q?MTAB5nzVm1jW16eYRBXL9WhQQpnUQG2utW0VsmAaTG/WyPBpinBPng1xpg4U?=
 =?us-ascii?Q?AFBjNSaTQWB3ZExvU1FFokRlzb3fHKrVmAghcY67+pq4gmx+FGYSxDeJcIaZ?=
 =?us-ascii?Q?upUpN8wq6g=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c86e4f-71f1-4b22-9b14-08df330cebc2
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 02:57:49.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJ8smS87RbUIChG6OUJpVBGcwDYsAke0cyhbcCqTaTqo+F1iEDOPe+UTwokp7eSAiMOwtKcE9iuMXDpTKXJN2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB9009

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

