Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021119.outbound.protection.outlook.com [52.101.100.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30B332917;
	Sun, 18 Oct 2026 02:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289639; cv=fail; b=ogxJZYEU356/briG4/0jlAVuGBNZ7DlWe26lzwiasupoQCzVoWK9GAd9D5QTvZbBncynt3Lvqo8szYwSJSqVd6d52caRa7RCimUvxorHKMrXZZAOpMBRb8P5v0mbt9yMj7A5DU57aHU/No28CccL3kfGxYfVKcXgJrN6EPvWwkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289639; c=relaxed/simple;
	bh=hlVzZ0ZVZfC1EU+4xku/MXRS57WS2IPVIawUD4eFR9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dhT9KDwTc3qNFIW2U9oOgwVhgkqWLC6fTo4tLRQCngAhDhLys3M/3zu26haQk5cncASsuurbCZtqnd2a8FBYJE84B9kfArAFW1BwDA/ASGu4zn4401ONLNUsasotpQR1u0Q7mwfNRCBK4HTYxdPbX51oPsavjx4QPDSCi8Mm6wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCe3dz047LtM5XBJMOoXmSC0SCEch3ExiOAQR20+3rxRMCXJqveFLd3RD9nmo4kHz22mqqDL1LgzIccP8GGONTQn0Ak2CkUDYMn7GI0Pre9AMMMV1YWqJYkxmxSLoQjRMmK6RqRormOk99LZBjGsAy3N2MHRV2XcWF/viljrr6atkDbhZ5yYalxa7KytGTBJPvgE2xXm5f+IgTwf3zGNUbGLNrON2EH+kkhq1YnKO4jNXm4e/IviZQCzYKgu7oloiDa0U+j434yRAH+4/KbtGH9pQxVKq8VJrpkdLo9Q8/EUU+RvMpOHkHCm19OOD8/TYq9JWWTtoMnNHnQDGKMZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ivNWqzelemYPEapGjGZF32IydTHBSNTERYPJOFgp67g=;
 b=tBD2j/okx+U8FNc5cvoIrlBJ9YQ5KEKySnWAljU/8McXTxazi2ijs6eyCF65sfPe+v16AQLPS/mcZIvuigFprvAzE5708SXs1kqHBOrWOd2TXRkfYIOSXAt6M02yjbtCtVpg+M+0DW950FhVuaiXmXgmrxmE25I9zOZZXPJjfBluv7z4JDK+xO4bE59rUyzdCEYR0k7Lt5OpcjCK3JdDNIygzVcFD3Fmwzj5+ruPIBNehGi+PoVEO0Q/R9p4GTPkvy7eyyhfrF4hkl2jSNcTAKxFdEHc1GbBQ8tcG1Uo0QVOrqxYJLKAk3+6t5v/QRmteFnSam9IzQYGmYj/M31eFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO8P123MB986281.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:805::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 02:13:54 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 02:13:54 +0000
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
Subject: [PATCH perf-tools-next v7 1/6] perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
Date: Sat, 17 Oct 2026 22:13:41 -0400
Message-ID: <20261018021346.582845-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018021346.582845-1-atomlin@atomlin.com>
References: <20261018021346.582845-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:408:f5::26) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO8P123MB986281:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aba44b3-694a-4c99-9d01-08df2cbd75d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|6133799003|18002099003|22082099003|10067099003|3023799007|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	M9JYEJlR/WMvyHTINLbgk37aKEDFaJn4Z6slXPJhUZHuBYkhoM9gWLPRLFcgdyqXIMLvVJZUebLmnDe9FnvcOo+cfD0uVXgHWVW3TZUJlBcteCnHhblw3nF0QEZVMQrh3HeK9F7Ju9+5DR6/rbkAiIGfhG0ytfnmwVEkV20jmYmggzyNnUKaNVBxjgoLbwi3VyDEAHt+112CGHZIF0vShu5gmtuDBDIAaxxl0pHAzpn1mWQUL7g4mF8wKDvcqofJ4AXlK7os2OWOpVPmH+EdrrCmWQMFzZNi3kl33CIq9Nuw6gSIqhhtsgdBW72+66QR7lxC2lTOyIGJryCZjzT4UV1boaT2MozU7zVrPL6rxfrCGlkgivcuhCW3g4wrQbMdM7/hOnnbhqMusfjR1v66VizPqQtcc/4/eKS/uMNjXjCgd6JL07VZXtIFSM/9lJB2dXNKu7huqVWNt4nk7BEjP0cHlRsbPpRRUvmyK6muGfWqG82oZJBi437fMmkna9Juul9hdCkS6na9URoqk4OgLzpPDrLaxAMGDfb+IPJRFv7OAdlkar97OaGD4Gt2AAYikVsJ4aqwPOztKH6y4PM2Qo5XLJEJoeqDkZOZoQa5oXyx7ng2nck26/OqcsqVoE6Ia0knXxbRWzDEsyJyuvwqCJ2tene2oDLfzFg0HxfrDr0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(261009223027099003)(5023799004)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K8XecScbCxzRaA6T3gfeRJvzc2G0+iFFRfsF0KPqP9Rj03b+UqpaeSucXtWF?=
 =?us-ascii?Q?PuUurSnSxgbK6aASfkhk/wYLJ0MmGSzj+2mzm2jK5Ea6Rh7ekD+Fe1UqOjzl?=
 =?us-ascii?Q?6NWloMK7rm1ktupKQhaqT4wdacncrg8hsF/FpDdli8IF9AJtoZA49b+O+baI?=
 =?us-ascii?Q?YQuNziDmmNdY0vGvOzfbqhZWIClZki/s+pTQSqF5VHuPcgkS5tAfHDtUKNL6?=
 =?us-ascii?Q?A80UuiW8OEuxw9Ot+kqfOu0NeNSB2WPbRE/iLYVXVffiPIYN7DoaHuGyTsL8?=
 =?us-ascii?Q?hERLGJVQ4A2o1IYeSjuuLP/2VFCifv4KYdDKWAsLlzQtLust6n0RSYl+COER?=
 =?us-ascii?Q?BBfJQY8I5BIGed5yHC94eArRSOstWBvlcQqQx/+ABp6ZmdM/h+IH9zS65ocW?=
 =?us-ascii?Q?qeCbacgQf81GR/noVK6FbztuO4L5mMeFhywteuIAd3Mx3YNblzkCvWK3BCbG?=
 =?us-ascii?Q?cEAhTtm0+GnUSD4S57NhRE6DlXTNANInwFRo48KChQtzrocMy8YW9xbPes3g?=
 =?us-ascii?Q?3pjPR76UGgg3QoVHeBbnpt6l3f3DjAN0h/uTk0iOmh1+cXPlQOuapPxZ0zhB?=
 =?us-ascii?Q?eZ1wU3V/fpVq2gt7XT5hn1WCZ7lHurkWDxuda3Z2AxzCWNPdzxo2GV1j+QYM?=
 =?us-ascii?Q?ZPXY7veJSKAZHDsUgYN73/xz0MbFGjXmeP1f+qpgV+CLywTPscsUlIJ9k0YB?=
 =?us-ascii?Q?i2O5yvWei/cEMao+dinVKFsPo6RVDw0wmOEgVjvqReFnpqJPt6/Kt6ZUx/9W?=
 =?us-ascii?Q?kRq3CNu1HX8Eb1XXwfKHed3q3aCZU311CwJuUvukFiFpSYUokzX7ugsvqoQ1?=
 =?us-ascii?Q?CW6df31FU1R8DKqUTdHwUA8VZkFojgGxAEDAHbpyQgJXg/r2n+weZE4w1cIa?=
 =?us-ascii?Q?9LdGfp4QwlTfxOirdKJBPJWzp6RtuzZHFBjMpHsa5kNBuO1a1EQ4DwKoUyYk?=
 =?us-ascii?Q?/oAKdiaFwkA1DIaNNcVoIjQcDTlx5JksXLucWePTeMF8vmcX43xfVijnCo0O?=
 =?us-ascii?Q?BJB3/YGZu+IRF6jGETWePtWcwxvqnpkdK8IxABwx7MoZnSqAFEFCbjZn8mMl?=
 =?us-ascii?Q?xBsXJ9M3HG8Y6e8g9PF8x/t+gjEkrp4hfjIuJev1fX+Ljp7Ze6sKRFm2mFCs?=
 =?us-ascii?Q?CwP83ZjfIz4Nq0FNZwCK/Qe2zCmkbPZy1kRoSuktGPGRpwk9wJiPacL47/1p?=
 =?us-ascii?Q?dcBfNpgkB9+Nl4XvQKzPWBhN8xqGieYjfSJrjLR2pyNJFlqV5VPadbMvlPX2?=
 =?us-ascii?Q?VOhkT5UlEkxWZlrjKOeHMg7vDpPQITxEs8RACYTgEZWsH43xXOpJcBTpsMtq?=
 =?us-ascii?Q?7FjVvOJCEFZpj5rkr7qDuu57xzHBvjBXb4jcxxcyKHsf+IBKjlzx8Ezp9q6X?=
 =?us-ascii?Q?Kdz4Ne1jsGyz9fI9KuV1Y4ZMGrXpEZ3PDyrMnOvLSLc+FtW/or3Sv58OALs1?=
 =?us-ascii?Q?HhTzNYtLkSI4HiM/6rewQNLPH4/84R/f6cM5LzDiBjSuNz++X1Ch/HmTMD3l?=
 =?us-ascii?Q?nCodRtKmfJP6GjBiVv3KkeT+rP+EAJUujUQWr1zhsaCbN9bQJFAVW8kw2avv?=
 =?us-ascii?Q?t3Des8yD4xKgI+CTz8DqHL/834Gdlv/roxdZSDX917q1tNzEdSy7PRRV21NE?=
 =?us-ascii?Q?wrUjufz9A+iJhKDkJdTfJLCuBu8x53yLBVF6knTrdAAsbBx5O4hpGn2YUOTU?=
 =?us-ascii?Q?w3xVrtocLKHbU1gXD3xwPOE2gputs0vfkmuU3NY27iRKA6PaMyF7mbkj1c+L?=
 =?us-ascii?Q?m83kbikWVA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aba44b3-694a-4c99-9d01-08df2cbd75d6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 02:13:54.8830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bxr344Ct0GMqW8Qkp+L4pxdArEpGuK4qGoVVb8JK3uk8Z4gsMgLIwT5MUa//QZJkaWP/j+vfbSfYk83tyJk1Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB986281

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

