Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020142.outbound.protection.outlook.com [52.101.196.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC7521CA02;
	Mon, 12 Oct 2026 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791765028; cv=fail; b=R79xF202Vpe0KZ+sf9b5cvpsB7T7kLt6FoinV2yxaWhyN+kyoGkUO2Dc/lxs6Of4r9wNua3GcRvvzdKUI00C1wm+Ba2JqD2ETZ0gZMCIwwTDRb6QJ2T4QkPhZKJJmZN6/xEl9Um88+eGUeMo5+H7B9BEvvNK2b/H+OMjob+Asx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791765028; c=relaxed/simple;
	bh=5yWPm4Ic70iE86VQisjU68VH8erGhju6X5+62xexD7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RwJo9wQblpmxd9HfY23lOJP3BU5hRlPahhoeiiin+YNQtkb4ePocSuINq/wUafFI1+DJ+7rIq2vYs/CL3RJqcEG+Sjh3ocg+Mqz3UUj+9VYju8DMaeRUepvcia44ioke/v6NHruPQIEcrZ8k4ZIt1FkkQ8xheKN0o2/FMueuVrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/Lfwq7aiYE91fMjRMYoBlOpSFzThCVmVVlaN6XRPFjyimsY+DXVaW4/Kxsb0YA23QtN/N4sj5yLocE1h7xkoMfJyXn9Ukipn1TnSBvIpZSGiotvz9UqtuP9/d0A/aZVtj50E3F58eXbJC1UIx7jmA6e8JyemZtSL6fdE3LLGRd4mNzOXIGYdHmE8v9Du36LHL/cxvotTsc6axmjkaE3ZE81jXwFVFf2A52nAg/EYiohL7tdMmNl+LzwVYHlgerV6r7voQURH+SODnsllBCKwxnCaRkKkIqqLHgTjE5OYrRtB1XjWb3eN6PgVVfcinKDhmuK3YNt3hc6FI1tnEJSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=GiaPBL1owF7pdU6dmwo/1TInltLcpACRAKkSx9IF1uU=;
 b=lpEpwPWNOzuSNVgwdk/yuRUzSRyW4T5XRUYoBb9BL0H6B9V9VgQVWohLBD04zbDKORxMVA2gddI7stIo1VdcahUlFIPdB02cWqddyLPES/ipb4P85GClBk49SZZTR23Ie1AKE/hApNcuDAQAh3HaF3BMQKKM/YVdd7Z67nlvj9ZIbcRpfDJ/YWtJAZFbW/VALMiSBy0Q7mppdWxLjDt9tFuc6FelYUEEJp6mjxVdxAgECAu5XgpwxMtUuxQ3Dhmt4Sl7z27jU65b3AfIVM3cvz8CSWFai8CTuFEnJUPyYzj9SZ13lax444wJW0Ol+/S1IPY0BZL/l7qAj6rfboMhcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOVP123MB8542.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:48a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 00:30:23 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 00:30:23 +0000
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
Subject: [PATCH perf-tools-next v3 1/5] perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
Date: Sun, 11 Oct 2026 20:30:11 -0400
Message-ID: <20261012003016.263063-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012003016.263063-1-atomlin@atomlin.com>
References: <20261012003016.263063-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:408:f6::27) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOVP123MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: 968262b6-9c09-41b2-4e91-08df27f8011d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|6133799003|10067099003|18002099003|22082099003|3023799007|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	cXE3HgcA/J7mfD3Ycnk8pbTbadmxVXgDts1wwAIX90b/rVjhBjT2i1do2gCntykQGwt4SPS517ZA+WM2M4olQ+TgWl7qo9ZSUoY9ZvMaeoMBEUJsWs3e9tctuHgiESckV4J4tci7vERBeYHQBMN3WtU06n5VQ2czn12D9jYr6kD88kaT5RFBaHAEs0BE1XQuAb46K9TWMru5M1Nv+XsAm3/BTfejorhymvkxb7+nO+y1kHpXpkw4cW5QSYavR/UE5eMK0lad4/lWvVxcyxbegl0ZmFsvsd0nnzFyGV/ip0XFkrXZn8BU1k0F1qiKYf3RCBzWsh+eALuIOl1+vlPZ/H9swNQP7DMhUfkQMb08UNllB79pcjlOuSIC3xz/CBiTbVmUkssf/Nq+J2S8asQYNnk7Mo/q7ZNowaFZnthUtBE8WXuzf3mckns4A7fRPTyvgi79jReOIwm2R0ZvVz7YBYfA5NpEA4JndcyOk0JZPjO82RIzkFhIrE6LRW+ZWcRCLL2c76SWsBhOxkaK4K1Mw50gPsWoNPRxRTQQpcYETokDZOo1a8vAvZmrECotySzbOb6sq1f09Ycq9UfcfKDBFOKcHCWO1rJZdgiZ/aKR/7BfrZ6g5ID2pJMACWVLwEGUhdZiG+YHrj6R9ZAQol9PZrM3fEqzzoR7rr27wF/1uQY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0KHdGBX7Ntzkfn22ilQG+SWmIQLGMNfVPauWXA4GG9GRQbJ2d0L2BM6YqybE?=
 =?us-ascii?Q?HX8RUzCGs59UHfS4WI9Rl3CVMyo20Thm3kLTJoxU/o00E7RXYVkVCnebP/V1?=
 =?us-ascii?Q?PTrsLN9bBapjrujxx2tKRSaj0U8vBWPunvYyJ1xlcX8RzQMFXchPtvyorDbv?=
 =?us-ascii?Q?NjLA+nfqp7CtZ0WLVVxX4Akzif0hP1zWmV2beZwTI1Y9j+gb7IeybsbmVNNK?=
 =?us-ascii?Q?WfIwneolBUrASg63G9zktXkeCfYaLuzt+6yxqJvmET8lZLFGemNyGOkHlb6q?=
 =?us-ascii?Q?hw5XLtpKiGw9IIQQKtod3M9d/nUOh1TtS0ckVEwUQAiML+It1eqken+yziGQ?=
 =?us-ascii?Q?NQ7LcT3K3Pl1fESFu2zivA14/HfGzGC5Txb1mJYeqWVpPF1wea00CLbTJmhd?=
 =?us-ascii?Q?A4H7gFWHgrGo6MYX1kWTwa7PI1AcE14GtvQmGFynP02YNNXvB0B621FGP6bb?=
 =?us-ascii?Q?/rFnkHI0FG703VF0oRxkTkKtl5wTiD/JyETwp8PUirhjbySHaTdKYVsnYTJa?=
 =?us-ascii?Q?m3m2JFN6GInf/dD3gh79iUyN2fjo6lETeV+oWSngE9yjp9H6H3taNhogEvLw?=
 =?us-ascii?Q?fAT1cG+k1JODA24OHBmI6OBAPCfdBaS8J7yDRWNn/AoR/Q/EXIHwm13rS2oY?=
 =?us-ascii?Q?TDoF6yoCfguy5pczVZc0aby/tzEga5ePJJDGr0buudC2XIEQQZdbHnzY15nv?=
 =?us-ascii?Q?cTGPaos5mGV8lFGtRz6DGZAbKcTneyYqw+BSsUaB1zhqkxfS/vMiWqrbObuy?=
 =?us-ascii?Q?WtkgznSdLBRJw7L4L0P5AKMZqkHMoZ+wK12lo0i1yZCEFsxUegL9XNQa/1+a?=
 =?us-ascii?Q?SUWNIQF+r9F2uSMcu7xNePmW8UqzkRxrD83z1+rwRMPyKWHPAadva6hfb7Ob?=
 =?us-ascii?Q?CvXC702EUKnJyWOpc/ENQX5pjJ2YwsF4P9vNomtZNI2RMcQ0DWteB7h3by0/?=
 =?us-ascii?Q?ljymldV8CMcb5rOOMUJQsMecS13mvNai0B4q+8jDAuQBDajXt4RoTPFasq8G?=
 =?us-ascii?Q?dlHoNVeNiEfnNEHps7FTk9AUe2mkA8WBu9XPpkWVVhrHzU8WlRTwRFJxNO/k?=
 =?us-ascii?Q?qL4bvUcF6gktqnlHcuvbcaYqp5fYVAexkScMkWv03+T2Hxu4FTDIymAHVmeA?=
 =?us-ascii?Q?O0myYn/YyisoUEx4zvq6wxtFGbnrLIedr4NWAmRNsYnvmWLKY+a9JGpjp0OV?=
 =?us-ascii?Q?mWRgKB5hNYr1Rg5X8NzNM3eu6iAIn7nqHUpzBLh0jut3kz5lKduU1j6nk8Jg?=
 =?us-ascii?Q?5/iAuOCdyVkrtwyCi82TH0gCSfK9pWr/pBfqtp+WtYjItr4r0KAWxJBoZb3m?=
 =?us-ascii?Q?5+KCdlyuqnGOnszlJy7rL2YJbATuSY3qJAVfrwYB0FTUGu61vPMJ7xLNz2Zo?=
 =?us-ascii?Q?dDY/fpiuhHQlQKgAX3RBTnO6ZmGxBuFBbvm7AGXl4H/icnRwrqYMiYGNVD03?=
 =?us-ascii?Q?1qxzkHzQbVRQqBfjmNwiL+7/kHcCC9O/HEDvBR9a98QQv6GJLZzKFnbWhnXp?=
 =?us-ascii?Q?5vMPjqW+Oj+BiLqClBucviCqp6kQAwh7n2p67Lsg7v6D4Z63TiRnVdYIJXUQ?=
 =?us-ascii?Q?iRZxVzBcUzIofYUoG5MZDQDUreMBWXS77fwqQdYhzmugnRWCQ4CePsnpFaCK?=
 =?us-ascii?Q?jjpGTYqWbQvhrzwhZto+vXsMMDwf1Kh3fnmLvaT+nKnn9qnTOh/p/ilcSmm3?=
 =?us-ascii?Q?CMm8rD3IFoghrYligEvMMcBypWjcuw38GnP0IxHN+earq5tzUWtB6mLQTuYB?=
 =?us-ascii?Q?7SB+X+UBEA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968262b6-9c09-41b2-4e91-08df27f8011d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 00:30:23.5618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ES0wAOUx2cdbULW24MFrlBT82h4x/bGHwdmduQyN/hYVf0ALTZ2elkzbGmvdaN5NmtaG1fMUAw61WzGyg7dSEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP123MB8542

In __cmd_ftrace(), incoming trace data from trace_pipe was historically
buffered in a fixed 4096-byte array allocated directly on the stack
frame. Furthermore, reads were written directly to stdout via fwrite()
in arbitrary chunk sizes, rather than as discrete, well-delimited
trace lines.

Refactor __cmd_ftrace() to employ dynamic heap allocation for the read
buffer alongside a dynamic struct strbuf to accumulate streamed
characters into whole lines. Pre-allocating the strbuf ensures that
line processing incurs zero heap reallocations during steady-state
polling, while the stack frame of __cmd_ftrace() is reduced by over 96%
(down to ~160 bytes).

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-ftrace.c | 57 ++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 6017493ff179..d6604be593a3 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -41,7 +41,10 @@
 #include "util/units.h"
 #include "util/parse-sublevel-options.h"
 
+#include "util/strbuf.h"
+
 #define DEFAULT_TRACER  "function_graph"
+#define TRACE_BUF_SIZE  4096
 
 static volatile sig_atomic_t workload_exec_errno;
 static volatile sig_atomic_t done;
@@ -738,7 +741,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 {
 	char *trace_file;
 	int trace_fd;
-	char buf[4096];
+	char *buf = NULL;
+	struct strbuf linebuf = STRBUF_INIT;
 	struct pollfd pollfd = {
 		.events = POLLIN,
 	};
@@ -767,10 +771,17 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 
 	setup_pager();
 
+	buf = malloc(TRACE_BUF_SIZE);
+	if (!buf) {
+		pr_err("failed to allocate trace buffer\n");
+		goto out_reset;
+	}
+	strbuf_init(&linebuf, 512);
+
 	trace_file = get_tracing_instance_file("trace_pipe");
 	if (!trace_file) {
 		pr_err("failed to open trace_pipe\n");
-		goto out_reset;
+		goto out_free;
 	}
 
 	trace_fd = open(trace_file, O_RDONLY);
@@ -779,7 +790,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 
 	if (trace_fd < 0) {
 		pr_err("failed to open trace_pipe\n");
-		goto out_reset;
+		goto out_free;
 	}
 
 	fcntl(trace_fd, F_SETFL, O_NONBLOCK);
@@ -810,11 +821,19 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 			break;
 
 		if (pollfd.revents & POLLIN) {
-			int n = read(trace_fd, buf, sizeof(buf));
-			if (n < 0)
-				break;
-			if (fwrite(buf, n, 1, stdout) != 1)
+			int n = read(trace_fd, buf, TRACE_BUF_SIZE);
+
+			if (n <= 0)
 				break;
+			for (int i = 0; i < n; i++) {
+				if (buf[i] == '\n') {
+					fprintf(stdout, "%s\n", linebuf.buf);
+					strbuf_setlen(&linebuf, 0);
+				} else {
+					if (strbuf_addch(&linebuf, buf[i]) < 0)
+						goto out_close_fd;
+				}
+			}
 			/* flush output since stdout is in full buffering mode due to pager */
 			fflush(stdout);
 		}
@@ -823,7 +842,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	write_tracing_file("tracing_on", "0");
 
 	if (workload_exec_errno) {
-		const char *emsg = str_error_r(workload_exec_errno, buf, sizeof(buf));
+		const char *emsg = str_error_r(workload_exec_errno, buf, TRACE_BUF_SIZE);
 		/* flush stdout first so below error msg appears at the end. */
 		fflush(stdout);
 		pr_err("workload failed: %s\n", emsg);
@@ -832,15 +851,31 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 
 	/* read remaining buffer contents */
 	while (true) {
-		int n = read(trace_fd, buf, sizeof(buf));
+		int n = read(trace_fd, buf, TRACE_BUF_SIZE);
+
 		if (n <= 0)
 			break;
-		if (fwrite(buf, n, 1, stdout) != 1)
-			break;
+		for (int i = 0; i < n; i++) {
+			if (buf[i] == '\n') {
+				fprintf(stdout, "%s\n", linebuf.buf);
+				strbuf_setlen(&linebuf, 0);
+			} else {
+				if (strbuf_addch(&linebuf, buf[i]) < 0)
+					goto out_close_fd;
+			}
+		}
+	}
+
+	if (linebuf.len > 0) {
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

