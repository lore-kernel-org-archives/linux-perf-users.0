Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021133.outbound.protection.outlook.com [52.101.100.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423F0370D4F;
	Fri, 16 Oct 2026 04:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123406; cv=fail; b=sVLUgIsXMZWCIWLxLhu1XP2iRdQ5kgZjqf1Q33FuT3hN/Cj3iUEZQDRWTbeXMtPJxtPKJJ5oYq1USYCp5PlUp4IJvCNQYPIVn/QctU25t27+L+Z3aVM+89d3tfnIKek+XJNkqyCAYzyYF7hIxNgYfVOmIj0UHVBBWLLaWQf5rUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123406; c=relaxed/simple;
	bh=hlVzZ0ZVZfC1EU+4xku/MXRS57WS2IPVIawUD4eFR9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SlKd5epZpB0CsvILwL/KKIeFZ9lK6ZlcC2vMxKr4srnNZ+eOcgR/IX5z9dQp2nNn59nQxkx4lR9RxhpdDE2k2Gpqlo4JOCu9iIQEytW479VIh1qrKQKIWqIl67H4vu+6NPQPBE8YjLbVtwsGg2c/hrNAGK6Lb6I+w1Ow1ALx9Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qn/3Oi//GfrCwgQZMWs7LAkIphEBX3gJ0+yWDbNKZqpxzv4J8iMvOZw69PreXeWy4tW1+Jx1ONyVht4V3s9/Wy2JIfDCY7mau2g4pmmRW/Yom1E+0dfAeJlMU17zXDBCznRLixImuLhv2zHYbmxZKu5sT+66kBCALmCBP1jz3Rp4lufwiZc4Ryz07eBu2CGbR/J7b3WGkOF+imXk8/RLACjjFAhu+mGmsvuLm5wUUgDkTORL/sHAEaPwZsn0Br90+tdKgYw6hAeOd/TZd1JJ9O889oAOhT2wcO4p4nlKE0k7FhYX5nxaLuU3k5yB22Oyi6zD5HwOwL13BKpeaSiB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ivNWqzelemYPEapGjGZF32IydTHBSNTERYPJOFgp67g=;
 b=gYNF22aOix1kKX885LFnk0psLglAWS5FC6wB/FXyTRfDqvpVpkkvgaBVDhHk5rarCZJ0g5O6dMBPNUWZIFOBe2H72lHU85rQvPWEO6PncvJgJwYS99kLq0MPXJ0pidP+V8N+0o/d2MR2AO71X+J/7KUcyhnAfqJUHgQCbYh2Fyrudf4Ag/nRarVJS7r/917qLbLG4AVw98IezZebjnPA7/JPzgbslW50eD44YO3kv+xl4zlinbyCOoN35VRqDYC6YJvA0NUWh2Xz3WvOEU6dxsgS9Y1WLlbDZGSh3IUuVlNJojHQmpXLPD13ZtIBmHVXR0iJpt5dLrjlg1ZjyXAfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOAP123MB8944.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 04:03:21 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 04:03:21 +0000
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
Subject: [PATCH perf-tools-next v6 1/5] perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
Date: Fri, 16 Oct 2026 00:03:06 -0400
Message-ID: <20261016040310.482876-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016040310.482876-1-atomlin@atomlin.com>
References: <20261016040310.482876-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::20) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOAP123MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a08ea58-b899-431d-e86c-08df2b3a6b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|56012099006|5023799004|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	LBtAIyzOgsz7WjCop9KR0pevKusKhB1ZI2TDPnCvXVsJdWFTLpeuj3kkBYagDU2R+m+zIyKW4JJAwtR+/mk6Ppu1JiPDQa+h8pVw1htHmFHbbgrWO3npsczS+iMbKrgnFRzck5UejsmJ9G1eAz2a15mMcU8B30o7HHkIzP4qMZL4tdfeF7i9XtYV/gX7uchayPqIyhHE/z+gbETdeNYuh14FdenGUT51oZx1nqBwTD+jbdC6VFhgEFSSUBPiQSkIOhOJQsi8wihWRyfvg/iyY6FDUu2gPwxJDM6A8y0vKsGyXcfP5YBi3IzQslYbIu8jUfp78ZlfM1u/tuf/sk0MwPl3ENPkig/Slm/lc7lXEcFq83nJ/rE3YKdkhzjFEpf4lAFL7/wqP5gwJjfgWmrrfnUtnmLahYmjgC/+B+nuN632Pxdq7lcBauWmLSCkBsOXvmMk7iHlSsPUEs7cRZygsDnmhNtmeNlTSFrAZGNO9I2K5hz9ox7BVniK+eABah+4nnKzSgkkH9ZxQc5UKP3S2LBn5iWxGoSwHsq6sRsrqfxTAfMBp09sXnJyE65E/Vqz2VjHEt5A4eRTg9kQ4Yn/95q4ytXk9ALdmkW2nUb7QDiK7oMpjElbOxqMtYv+fTkDFjfJ95BN3ZbC/1Fykz0INtJsrzmVdp5aSPAGix1DG9Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(56012099006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SsEec5NZBdTZCSXj0LRMqWpcoHKPTvV1ASIIdJUiq0n4F+yD2u3rM0MupuOF?=
 =?us-ascii?Q?kSm4TFHJmXcp3mQRxGIwcRtYbVAueyjVwRRboGbeqZDU1wOEsLGCu51TWijG?=
 =?us-ascii?Q?v/WBqk+H89iRNQH3yM2IAC+yCHOfi1GhcywIz0aPBNw9cHQQw4MSWBMZLKoa?=
 =?us-ascii?Q?LcBsbWru7UBpBvdii6sKDVfssdt6F4JlhTbojn9c6+WaGvbhVH4aDFIp9bkg?=
 =?us-ascii?Q?j6+n5L7wdw3cYV8GIcuqA5ZaADLj3fmjLfTffBDlwSd2OzY1b7PJTimcz/HD?=
 =?us-ascii?Q?X+0E30OI60BtOEFj1KHmR/IItjWg3Sa001j7RB3GZ01F2c4hp+YloFiiVk3a?=
 =?us-ascii?Q?6Lw7KVByF/6EXKbU7/cIP1ayO7KSLed4QqG1bRiqZkUo+AK9NWhO+JGwJdhj?=
 =?us-ascii?Q?+21ebiFdEPiVnOPWjGYyvdZlNUQg0ud9TD9zNKv1XWIPHn1Wof7R06jlh6sC?=
 =?us-ascii?Q?fgreSjBFKQFaRtyw7uMVFMSD2MifdJVNGcm/1JwwTW4xHnDk258OUovdWDt4?=
 =?us-ascii?Q?Gfjlr2d/2Y+ekXCBAekr3khbblnMnZJKRtl8nuLgc9+5rxR5gbZ1LbLpPJ81?=
 =?us-ascii?Q?AvGo0WhFFKRl8mHdEcjWSpGWUHB+uEq3mHJPPRgrdrHuGBz8r9WLhxDHeJEV?=
 =?us-ascii?Q?TXBGBTO54Y5nZrQemsHjoWpRXOBDcQ4GKCoFzd/6qFo4OZqovo6oO9SIJ7Qc?=
 =?us-ascii?Q?ja9tgeutaRUTjL4lpxnmNZtbsrLFxbUkOkl4cRXhuNdGhhHaT1WQR4smx1oT?=
 =?us-ascii?Q?DgFBfgJxe4DKV+jAOnuqQLG+i8VNux44z1f0JPjllagbBg1eSliYAQvg/EOW?=
 =?us-ascii?Q?mjYFFF4aojwESurdxbsFPPTdsBabiLaUAIi+iaxd8/hcgvLZZ6tHIGzxNqYI?=
 =?us-ascii?Q?n+MmkpjIGMWDXsICDPfLpyKXqpCCqSpVYtLJBju6wl4HvuvxnPYzZJwkEKvF?=
 =?us-ascii?Q?2vttG0SxJESSmZ7ASxTFbr6kYbmBJDYoqoRfhKgrUhRXTU7PmRvKHOXsH2Zl?=
 =?us-ascii?Q?YwqzKGzSfhxC33v3l7YvX+j/E8IOmO9cLlIJIRp4R3Iep8cqkNh0O5+eLDL1?=
 =?us-ascii?Q?q01YjKwNL7ZR5bFldJuKI+4uTe39yxsG0HwVB+muxwNiyjHZGAbteRs3gbgz?=
 =?us-ascii?Q?AzWtFP1XOfehTd+HozCvGINMflyTPbdz3+AvNJOCapQp/49cx4TnKtnEvDU6?=
 =?us-ascii?Q?TZ1BaPG9Xxb/Ql1ot+i516ncCgAtc+cDxzSlI++al3TXicYTo00n6N3PYiAI?=
 =?us-ascii?Q?Ipe24TsyeBgjfbOSGlhoWNwOzdDkYMwGV9gZ8CgF6ENWB10dMhoMaKcHY2/n?=
 =?us-ascii?Q?XTgBihfgXeA5TZKP9v6H8sNz0kKfhy9Cnxfv+0OUbuGxUt+c4LanuanDi/Ak?=
 =?us-ascii?Q?kCXPmZL8LAk6vLAyJKWbRamkR0KHcacFj/JclAr2ky1thYnJ86xorg5dHEr8?=
 =?us-ascii?Q?U4JjhdOyxx2mGmkRRF/0u4wl6+gnQ6JzMYXVquzKHAqcgnX914lwQJT2h6EM?=
 =?us-ascii?Q?8q7hGwmGYtXq9GZPP/eAirXieTXtj4z8ITHCVvJqjCmj9sLLAC+CmT41SquL?=
 =?us-ascii?Q?gJ3ZRDO/GzSCa5Mxq9WpsIv+fVqM9raP0ManSiKAnHjcb/M6jA5u6Bh0Y26b?=
 =?us-ascii?Q?PihZK5MdbNCq/VfI7yjNCElj6vT3SJrrKuuIZIeSZNtweoaFjmsNST80lv6W?=
 =?us-ascii?Q?Lctq3Kp0qWBRPrjSCXfE6anb01HYWHYIBTrKbR37vmtZznSno68kGT5ec0sc?=
 =?us-ascii?Q?Rq7rihtbkg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a08ea58-b899-431d-e86c-08df2b3a6b24
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 04:03:21.7088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsvVL4LI0+4MjQGePZB0izl8ov1/6DpZTLlOsCgJgrpspSEvA52ArAu3PsUCLu+G3QCDGJv2QcUJFQAqMc5xrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8944

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
exit, while retrying on non-fatal EAGAIN and EINTR conditions prevents
premature termination on non-blocking reads or signal interruptions.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-ftrace.c | 79 +++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 6017493ff179..65983259b07e 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -14,6 +14,7 @@
 #include <poll.h>
 #include <semaphore.h>
 #include <signal.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <linux/capability.h>
@@ -41,7 +42,10 @@
 #include "util/units.h"
 #include "util/parse-sublevel-options.h"
 
+#include "util/strbuf.h"
+
 #define DEFAULT_TRACER  "function_graph"
+#define TRACE_BUF_SIZE  4096
 
 static volatile sig_atomic_t workload_exec_errno;
 static volatile sig_atomic_t done;
@@ -738,7 +742,8 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 {
 	char *trace_file;
 	int trace_fd;
-	char buf[4096];
+	char *buf = NULL;
+	struct strbuf linebuf = STRBUF_INIT;
 	struct pollfd pollfd = {
 		.events = POLLIN,
 	};
@@ -767,10 +772,18 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 
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
@@ -779,7 +792,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 
 	if (trace_fd < 0) {
 		pr_err("failed to open trace_pipe\n");
-		goto out_reset;
+		goto out_free;
 	}
 
 	fcntl(trace_fd, F_SETFL, O_NONBLOCK);
@@ -806,24 +819,42 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	}
 
 	while (!done) {
-		if (poll(&pollfd, 1, -1) < 0)
+		if (poll(&pollfd, 1, -1) < 0) {
+			if (errno == EINTR)
+				continue;
 			break;
+		}
 
 		if (pollfd.revents & POLLIN) {
-			int n = read(trace_fd, buf, sizeof(buf));
-			if (n < 0)
+			int n = read(trace_fd, buf, TRACE_BUF_SIZE);
+
+			if (n < 0) {
+				if (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR)
+					continue;
 				break;
-			if (fwrite(buf, n, 1, stdout) != 1)
+			}
+			if (n == 0)
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
@@ -831,16 +862,38 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	}
 
 	/* read remaining buffer contents */
-	while (true) {
-		int n = read(trace_fd, buf, sizeof(buf));
-		if (n <= 0)
+	while (!ferror(stdout)) {
+		int n = read(trace_fd, buf, TRACE_BUF_SIZE);
+
+		if (n < 0) {
+			if (errno == EINTR)
+				continue;
 			break;
-		if (fwrite(buf, n, 1, stdout) != 1)
+		}
+		if (n == 0)
 			break;
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

