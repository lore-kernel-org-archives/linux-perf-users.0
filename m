Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022088.outbound.protection.outlook.com [52.101.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FCF3033FD;
	Thu, 15 Oct 2026 01:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792026728; cv=fail; b=n6rFPlqcQM7x5LAgpCfghgmTdtKhGbwdkK2Eu/lBJot86IJGTC+AGfjEN+Xrz3fi+Qrb23c64AM1tP1CYJXxd/mHbd0fGwTFFpKagale24wNIrqOA4SjUgdpFnPjc3/vfyr5ji4MFpLhDTtVZ7IizJ54m9OyCgioCOsUhp/sJMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792026728; c=relaxed/simple;
	bh=0UxpdlD/QbcVGiWcy0mfIhsf+sFy6m+2f8eAmNG9BHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cYZij0H+UyBAkhgZkT1Od55wpkOo7Mbh4dhY4vLOaZ3ewHSDwvtXOAoQoi0ERAjb9gH2/x4dB2i7OmfRshe7i/9k2Y+LN1TGZH1E+RAwVIVkkZyjIwHW7Ak1GRLur51ZSv4k2xRfgLsfcXqlO7dUj6JvNdKrpuBIY/s83BjAWiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7xT0Urc9hQ+abcn6ruhUq9VbktZa54ac6ryvTbRI4s5xG23aTUh5oFnvAKMvBWY4m/Ym4ZEnUkl7P5/S+n9PqtTF0wgu5WhZscgUA+B0oU5vMBMU+/rxpfjvP4rT7/RF8Di2xzxW6kPJpEA4rREVEceDCKpu6RubJVWzGLmt9X97XWiozaOiIYwcQ3S+bT/Atg4EpReoGqJT756Okp/gv9ALT2Ec4g0B7L1gAq3BbAYLfQMCrXKxhLs0II63Q2oEJUlZ4hyrX+dlv4QRipi9QD+AWiKRSHnlwA8PnZ4VFK30ZxLuG+lOevBp2G4jJow88RebxgP4msOVIBCCj9ppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=J69AJuAvbPgBwSnPOduOaLDvtwROrmMNYx4Go53BrA0=;
 b=n3I5GYhGZjzd5L3dJTjTk7fT1XeEQZ7jPVh6RExJkDOJJyxI9C2ZHffHs32ZMPc4L3XfZzDSw9Ae68wi1Xs3taKyUFeTNXcgWrU2r5wylSkcEFHFVtcuz3aeh3aAxcLS1QZT8pdPCG3x++kfO6sRgTh3CUTO4r4SrU5pK+N/3mNeNGx/Q7k6RVzC3UI5+DO8J4F6ZcNdZmb4XNNf9uw5DC17dj+q9660hMRDKrlGNIhxt81mEvGdpvIFySjv8KsQGGfJCGKibkhZ361gJIXOejEcxtqBJytCpFQzQaD7j6ky1JNqLQN4qejy8lG2c//gX5rOPtphU4JTHP15VOoYQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB3927.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 01:12:03 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 01:12:03 +0000
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
Subject: [PATCH perf-tools-next v5 1/5] perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
Date: Wed, 14 Oct 2026 21:11:51 -0400
Message-ID: <20261015011155.414667-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015011155.414667-1-atomlin@atomlin.com>
References: <20261015011155.414667-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::29) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB3927:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5a1504-091d-49e4-31be-08df2a595229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|261009223027099003|5023799004|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	cymNuuqavFWqDUuE/UIibUQNK0b6rAMK3yaYM0wiqaxnxGVznzRQg8lz8ZEHfEODhN+lXOp+WhjiVeCtkfMMYtzGLss4A1E2ZmG6/STf+85erWI8jA1eSLFOqUdUUG6NZZ8I8BjmkclXiFsT3Me5x/8F1PjJFLVlbepvXjxfIDepI+QPFP/dsQvMzxOffNyWGTRGegcxutQ1KQuw/4dq05xngdnhv6oIJLBIu2s8K2hh+sebWneexILaXHVI6AzffEkQfF43BEHmNiUraXEgimjky4COFfUqnzr1GzdIufr6fhzXUAZCcfrH2KBZheMRM/KlG5tXOpcI/2YJrhSJ5RJctVeZCtM/s04XZnH+0qYQvdwXajt6zifnoFDQMiR+uCqz5fnUFD5lRKCSukp5iI8CBudv+3j2H1cUBCUHw+Qn9ug+FlHIwQve2MWbDd5JDlTmr51Qyol3B7RdiwrhpAIMp4W847q7XyrMO8cir1gV7KeFbm9yDcJP164bQ0OIgSksF2+ZHQoLZGeL2RtvFvT58pKEBzcDXt9eNACVPb5oCBg1wHE6tolipb6vBH6ZO53yH/EyxjrZkBF7GiH9y84trMVsB0AWISI+k4LoqwaaBgphg3SYYZMGd2POAySBWnEmCNeSmW09Zm1m6nGjqgxWLOlPmrvi0cWIbx2Dtz8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(261009223027099003)(5023799004)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bjrPs8hGDwccTsAS3AFYTY36kkynuY2NKhNXHXIAmseZr45wh+7WChmxN9qy?=
 =?us-ascii?Q?/ZPsJhYXN8kHunc0+IASr9TqSg1qTdPIhVnJlMIzzi4xFJBs5wGkntL4Rj21?=
 =?us-ascii?Q?20OTFgQd7YRtM3vy/Yhb3xXZ1eivZZfqzR3xvekAnkF+yrlzcrxyI8W5Brrx?=
 =?us-ascii?Q?6lG7jTLAeROJ6FpCrqHbiEn8FaCJTOH50j+Ef81pcJ5p+6CAQ9WHBoDiDdlm?=
 =?us-ascii?Q?zO7tqQXRnAw6Q9WUBbvgd6y0BvzPWuB5Q8ZmO17doHqfSfHj5+bAheTUBIkN?=
 =?us-ascii?Q?1Ed+xf21lBzsbqxBoQFv4Q6NLYQn5u6eo9/m5BcHUD2vtscK4y950SNGj8yy?=
 =?us-ascii?Q?0pXiFB8TKLMXrv7+lQLf7BkIOU8sNIDLsfiHx3s/A2ms0w48niJqsjRtieR0?=
 =?us-ascii?Q?vsLLPJVRVHKk8QkiTfcUGKXA3mdnF51mxVrTElXRgsvGRr9d2m07bX55MD9L?=
 =?us-ascii?Q?r3xwYYXfCrMqUKQs1ah+YbmiK/yww7T3ozKlOtzLFQU+YFcrQiqyyuPzZrpk?=
 =?us-ascii?Q?n2uZ/2EQ6UV8X7UnyHXoDVhLiGvW7WlULlLidM/rEvBINN5e1cCDroXsnBno?=
 =?us-ascii?Q?532b2RwUuTEc61h7XvFp+iXUUNMkoxEtJIrWTPAU3BUXqlIjt+Mzmf6eM2EI?=
 =?us-ascii?Q?SY+dQ6WRY8lWa1H9j+nZKcDWhUR+mWquY2ZoybT7xpIN8gn0D3Yj0uaXkdC9?=
 =?us-ascii?Q?XvOQ14DN3cJnrotSy7Ow1RDtZKWw8X3NPImy5hSYUTj1opwyrDQPb1D+gfk3?=
 =?us-ascii?Q?/3IvjikmJNtjqwmYBr4VyfTiAqRC1VqBa2ngBHhsimZjXyezCjYDgmQuHp+P?=
 =?us-ascii?Q?b4NdxL6Pw4zFi2UURCBAsnWcL2mwm9zRW5y+ukfvbI74teAg1IirLpX6ThyL?=
 =?us-ascii?Q?DPhkwEH7HAYg4JOhMgJIjcd/nNXzHC0CdDZ4dRRgZ9GowFI8Cr3R1rfZdP/g?=
 =?us-ascii?Q?BEdD+vYV94R+u6uONEx5eHW7a9Hic7+ft4tYLBbyYpVsnpsupTjgdkDBocud?=
 =?us-ascii?Q?6FXZbjGGpFUn/85P4Xmualg+2DrQ8HmgFL2YdR13LNTHF3dylIWw9HwkI/wm?=
 =?us-ascii?Q?LWgRZMmA2qT5hjebXwyLsrAaF99n+gY77rPBu65Bg43MVAPnquQiFoV8KEkY?=
 =?us-ascii?Q?88IadMqKnpSeC0kuLORUOVxrNWYhwnbFKKMoizVQEmzq9ZvGzn/JCUEoXTcf?=
 =?us-ascii?Q?ImF4LdvdiCpu/qZNoQnAZIViT1kOO2cw92iGvWJXBe+IKL9TO7IDj46LiGhp?=
 =?us-ascii?Q?52ywmMHJUQHXrKlghjAb+qu1cQfBjdn9AmiEqT96iR04nEvgPkGs5ffh4ayd?=
 =?us-ascii?Q?Lb+A4hL/gkbxNjnu1+Ef50WwywFT6f5DqsZ+lA5aiWbzmfLtfSkl/nfZxdzo?=
 =?us-ascii?Q?GnA6/9b6a8HVRii2aUBxWfI/04U6+Vx6Vzpv+h9Km8zKbKpMQFAbrabpZ2HN?=
 =?us-ascii?Q?u6Q9PpI1Fu1Ygo206xowKis68A+UJUczBaQW57NcacEHiH/VT2JloU5b/Egs?=
 =?us-ascii?Q?fLWBR4ijDUSCd/fkmUa9l/ZtOUEQKagqGAE0Li/YF579h//qouieD5ex0qUj?=
 =?us-ascii?Q?mPn1xjJ4GtMtFXHUXw4qft9GGZ8vt/2oJpRbf+Pe2L5QUsJbZG0DAltkwGhj?=
 =?us-ascii?Q?DmPEF4TuDB9+B6xe8Tang9M4qsthpkEFewmq37Hyn5e9YEc4Utbui/wuMK+y?=
 =?us-ascii?Q?yF2c1SrouI/RHnoKPvUu3atpNJooIHsuLxfX6O09PFbv3HKzWSeyyis+jl6d?=
 =?us-ascii?Q?uQr5/bOMBg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5a1504-091d-49e4-31be-08df2a595229
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 01:12:02.9787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +j1qcZ6ZCyU58206psOcX32ex+CNGeVanIHTj4phPVTi0CgbWyE9OAjcgmnanxGRlnJf5rgSnIyqdDy+txBPhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3927

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
 tools/perf/builtin-ftrace.c | 78 ++++++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 6017493ff179..6ee72ae90f67 100644
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
@@ -806,24 +818,42 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
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
@@ -831,16 +861,38 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
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

