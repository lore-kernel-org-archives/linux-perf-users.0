Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022105.outbound.protection.outlook.com [52.101.96.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF5A400986;
	Wed, 14 Oct 2026 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994510; cv=fail; b=sT7R46x21pHigP6P1TgIkRKDLY2b0CB25FNZ7deMelkQ5BmKjdy2YG/ELwYX7vE48rN88ieS8//2sqZXVeuO3vFfcncF0ZVq7ssfsTJI67aCWZSxCtIPjWPUFHWATzsQVhH4Z83ZSAy5QgbkqgczsQh8VmlwgQkEJRAhhcGXgZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994510; c=relaxed/simple;
	bh=Ga64kZmO+rcvriVrlbBcbtqK1OG8ULZCYuZc3BqmF9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KDdFKpXS8QA6ejNZOrZBz+74aQ+d5zf7hjFzRYfAfR06S/qnEcm/DaEmJ55iSI9c00gYkwB0dfcuG5Ait6yP8eE1D2i20GuJfrFhijfbKP9/Ngl1EJggycYESKopJIeA8KlncI9e+B5fiUke20v9h0u7tx0co5eLKAtvifcw5yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtkBeVjyKU7jEiTJI9GKIhNNEDJZ67yJlGnSC6vRodWwAKUbNGiW8eOJELkDGDgdO8a71gkC73P2DudiiqhZlIZOEllQGXZZZtYjRCebG+7i+FEUr7ohv88xQi1hRtq/FGwhF0sMwSUKO9szJQifCeCgyAv43zSr4Bi9yTgzOJI6FdlnXWmF9f009oj5WokOl/4mXtQo62iAcgn0oymIhYVyBzh9UwAM5rpmBPFSpHy6XFuUsKWoloFqIzHFibbwhGPosBg2uiriitRt3CQLmBAJt0IuBQfowoNNZZ/8gikGPN0FHiXepS6J6z07jn8eZ3XVKA/geNm7kLJjmKa/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=x0ntCmX/JaGcDio5hdKfQn0nz1tSfJNBZeXFvIrLMrI=;
 b=xA3rlc7ttQNFbEFBYiO4pNRw5VDpjzNjwaVZNqPbpNBXicCaDHHA9iK8ITOa9B9V/99vBUzB8xmvjaglo0+1yCSmiLnx9Ua28A8kTvPAztgjwtcoKMLBGvsfcaYG/vq7QJXJ7qEMe3LHs1UiaaCBBw2LvS4LocFLahiSk6bZfsbINenvfOgI4gkROGOsZqRDxviL/8O7Qpa32XOi+jeDrsiHR/uKFsUG98XQyUo93dlAKNO4dbfyzJ59rWsrDslkWG0Jk4mxbNZ9TXSIZoiXHVDiPAmO7bloC/nIrgBry9zkcrGZisa4ApN4cwmFwAQrjfUGR1MVILO4FiiAsgL90g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB3299.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:64::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 16:15:05 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 16:15:05 +0000
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
Subject: [PATCH perf-tools-next v4 1/5] perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
Date: Wed, 14 Oct 2026 12:14:53 -0400
Message-ID: <20261014161457.373253-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014161457.373253-1-atomlin@atomlin.com>
References: <20261014161457.373253-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:32b::20) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB3299:EE_
X-MS-Office365-Filtering-Correlation-Id: c62732d8-d3d7-431b-702c-08df2a0e4ebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|261009223027099003|5023799004|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Q4IrVHslKptZ5eUi/jop1bPfcku8DXga2ehv5VhjkXsS43/tTmUMqI6RSS0EHgRignD7BzplrwSqRj7O5dhnKQ3mE7J8wrAd96FfzyVY9s1IdEw0ycHdULKJKxrgLAYZx0Z5bKFB31Jl6OnIV6DAm37N9UJemrzmj7YD6yKe9907zIJV+o1hyuZ+rqhThtwmq1oD29biMQuIu9medktWIwKnmhjpTbhlEzpfuWq/AFgqWjwLitn7FWZoB0ZqIMi0bMmPTAu57OO8OD1NVPUmG2HRnfu6NXMqY1JYkfJho+/sSKEOUquWZViaFBKSI2xtEnvLmnH4Yr4yFtNdas9T1tdJRVy7ei4gBfxeXA4Z6Q6x3QqOeKqQXEhx5nobsn4NBJbT55Ay5q5C6haFh3i1WkGuyKSQAc7tYmWLSuE6TDlRevrQPMXl/NWoX1JI8tNgFQT2rYQXYxlqdaqjiiYxUjMd3lLkDdrxQ79yuyEU2gQ5cvgLaEL+kkHq59D50JVZ0ZwPHagYwRyCU+GhWuZa/mKgy3eKQQZqdsFqtN0wTwpAGEaezOUUo3Vww4Zg6sMYvlnWZtIKtGZPxoo/H+yjBsz62coEZep6HjReR5Le5iWFRJUosRlVMMgJUIKz5yFjNxReuLUNMbNLzPdbarh+Ix9ObpWxD/BckebYyVCk6Cw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(261009223027099003)(5023799004)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UC+71/b0qnWzeWPHuFbJ9iVR5xvjLVu26enDiEywYI1eaM7KiAdkowPf+cSc?=
 =?us-ascii?Q?uESxG/05D6aiuHRU+2DkuW01nPT9SKRWg9J5NKRxIVLOaA7PMDPK42cA9eKP?=
 =?us-ascii?Q?++kd2PUzC65UMgfQHjJOH0JysnmI46Td0R3NFdgCQk3xUS7CWEQobzm8aRCn?=
 =?us-ascii?Q?MFZ8XJ/z6oRJnPJCg5YCgriEIMaiGxwpzjnSbyoOYsNJdpriL+Lkeg7Z+/1n?=
 =?us-ascii?Q?VUjenKmAK0fhmcEq7odvdgfn9GEqihr8uk+Ftjldof6Sxe/7Un9jdLOZQDsy?=
 =?us-ascii?Q?176OaHL4GgE1vUBO84Y7zIQM3IaNYUq2fpY+qNVTBVl4StP5ecBYfbpRb0PZ?=
 =?us-ascii?Q?s0I1pgSrPb0eXgvoOWmfvCGvNISjzp0UrcKruV6ZhLcWryvQSfxoFwMM34zI?=
 =?us-ascii?Q?zhMAG/1k7+e7wEXzcdM7rKhhZD+pAdVw7NLHu1obwEUCVtfpQJ3MZ5E/NnGh?=
 =?us-ascii?Q?8Sr3VBHVsTYYFmUw+INMgM6A4cBphUM6+E293Nyih8HLXsbZNfXN3axNnY1g?=
 =?us-ascii?Q?Q5ieDC/5Vq/52PNbtW9Qj5AHBqZrzw2/Oen9oITgZiPDyFel8/4OSu1Cc068?=
 =?us-ascii?Q?Di189QwViibbhnoqdTxbu7tywizO4KvrXGsiz3aUs/fg68o3R/m8GqS1jzT7?=
 =?us-ascii?Q?VW+OrNWLVKYJBpD264PM5z/UHPgTM574ZMI3QQy94fyRa6EoYSZY8rX/2p6H?=
 =?us-ascii?Q?CtLcKQtVYdeycJEStsDhzKH4twtfBi33e1L1yHLgrZj0a3pgHmX0H+rF1pPr?=
 =?us-ascii?Q?7/pOJZkLlgfVW+ACHE36biyZMJ1irnyNwKqyK1to4uqpTvy5Q1VDvHzQqAiT?=
 =?us-ascii?Q?wKMnJiUa9Xvc36r3+TK7CYaiRGNvIXPX7hdabtu2s5NvMiEF/fBEL1hVvGM3?=
 =?us-ascii?Q?Ki0HM/tQkGeY/rfEzXX2+2s772Mht/RJiGkt/EEffKQW5QHJT6pcp8Hclfpi?=
 =?us-ascii?Q?2SPDWCspkeQ/QSqLfTCTTP+44Auf8lNqcg39PjIwoQddR0xLfDkpaHIWRUth?=
 =?us-ascii?Q?11hFaWRH86f7kQ2yt9kGufGqD3+Ee91nkpzi+duW6QoVe7VP6MGcknNC30K8?=
 =?us-ascii?Q?lxaye93043Fz+BQVcdZqL2J7Ejqa0nJerMkFwJB+VsIXUoySp+U4GThbBoA+?=
 =?us-ascii?Q?dMS5dQEa8u2f7FVdKjY5q+ZzcoquSB8VAjbF0cQxFRws/nNdzwz+gW0fnTkf?=
 =?us-ascii?Q?uRwGBEoGa+oNpuvyCmjgZSo79eFM4ywmB/eqsaxgKodAIa58Qk1Sm6eEvlFI?=
 =?us-ascii?Q?TUD5Bv6IwDy+79xQErMYjk1Pp3Wij0iAj0WNk7mJz67PaVlFF3HlXUCALymA?=
 =?us-ascii?Q?CR3mcE+vLaj4UnlaPyFM5vTrsBvU40ZRFfQFjnq4KHhfcYyNX0HXK9mDQ//g?=
 =?us-ascii?Q?PrP7rWinQDZHsGnFItcmDvJI3QkJcX7wOQNET2yEBZzKlhRvjqzl3fYT+Qcq?=
 =?us-ascii?Q?9LBnv7PEQo3Z0FW6fMLhQMOkM78HXaY0pTgnPIm8j0EjNJEPm8U8mh4r9k2G?=
 =?us-ascii?Q?hhZza/tbCNuL1zly3eEpnYOyIlGGP666DevTWh9xjXasUAP1nM3qeHIuXFUW?=
 =?us-ascii?Q?24wo7R736xIm62gPPSIZtWemGzHi1ceMseZ9YWo9VYrCzBzCHNU0WjzvHDEw?=
 =?us-ascii?Q?CVFYHkDSwlIrcp5uL2am5WyYoVUqN4H/zXGrc+7wQf+bFmb0Cj7GrJhmP+P5?=
 =?us-ascii?Q?qF/rpqVhJydPBtYOZwAbR71yvvX9+NnoNQzehvqAeF72ws1o9b3f3vA9zfSL?=
 =?us-ascii?Q?Rcmx7LNV/A=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62732d8-d3d7-431b-702c-08df2a0e4ebe
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 16:15:05.0468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aavUrbyrClP0Vx6cl+4hKWVWKhDR33cNDH61apa8ms0t+Kl0JnmuwJz9qAyieGxwaF5Yjfol6iel8wttiX4xgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3299

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
(down to ~160 bytes). Robust error and EOF detection on stdout and the
trace stream ensures polling terminates cleanly upon pipeline or pager
exit.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-ftrace.c | 65 +++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 6017493ff179..efd5343dc9ad 100644
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
@@ -767,10 +771,18 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 
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
@@ -779,7 +791,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 
 	if (trace_fd < 0) {
 		pr_err("failed to open trace_pipe\n");
-		goto out_reset;
+		goto out_free;
 	}
 
 	fcntl(trace_fd, F_SETFL, O_NONBLOCK);
@@ -810,20 +822,30 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
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
+					if (fprintf(stdout, "%s\n", linebuf.buf) < 0)
+						break;
+					strbuf_setlen(&linebuf, 0);
+				} else {
+					if (strbuf_addch(&linebuf, buf[i]) < 0)
+						goto out_close_fd;
+				}
+			}
 			/* flush output since stdout is in full buffering mode due to pager */
-			fflush(stdout);
+			if (fflush(stdout) < 0 || ferror(stdout))
+				break;
 		}
 	}
 
 	write_tracing_file("tracing_on", "0");
 
 	if (workload_exec_errno) {
-		const char *emsg = str_error_r(workload_exec_errno, buf, sizeof(buf));
+		const char *emsg = str_error_r(workload_exec_errno, buf, TRACE_BUF_SIZE);
 		/* flush stdout first so below error msg appears at the end. */
 		fflush(stdout);
 		pr_err("workload failed: %s\n", emsg);
@@ -831,16 +853,33 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	}
 
 	/* read remaining buffer contents */
-	while (true) {
-		int n = read(trace_fd, buf, sizeof(buf));
+	while (!ferror(stdout)) {
+		int n = read(trace_fd, buf, TRACE_BUF_SIZE);
+
 		if (n <= 0)
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

