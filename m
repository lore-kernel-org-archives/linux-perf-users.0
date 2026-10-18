Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021143.outbound.protection.outlook.com [52.101.100.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1390F348C6D;
	Sun, 18 Oct 2026 02:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792291084; cv=fail; b=cC4SiIeBnNLX7X86GavJ04CeJPc8dhAuuYM/ET6vhoCiYWZpeoy0uuv7Z3kBkzSKFgrD4eUHL9u7vq6fAEFPfAjGPSCih1+GkLXZaiLPjHKeWgPFy3It/WNcpnJEwWC9PBvo7Jz32j7r+qQ6MpDF1pVPs40Rp05UpzkUBJEhaAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792291084; c=relaxed/simple;
	bh=hlVzZ0ZVZfC1EU+4xku/MXRS57WS2IPVIawUD4eFR9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gH9eAcohN8IOUZUfVD5lknDHwSXOqw75Y/ktS8ygFLEbO5ltx2PEbJzNp01F2ncn7mCxyNSpymZpI1Q9QWNsSVe5z7LC7YGP8IN7H5VDDdD+qkwouJZTspRQNolZumVkXxQqHNvUVdI8oAbYr426j2WOlxlVGeyPfxI3WY941z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebgAoGuXXTjqUEJG5u0s1N4461A5RrLaLtOvnLk//vGe2K0PKEhKBJeizRqj4ie5XZ+cAW4JZdcmpGrN/vX+SyimleMHu9mXIpcfGn+eh9EXOalhfTpuauiDgBjEqJlLSCfpZiU0gNVo/KnrUM00LrmW+HwdyPB66lJz6nM+ZOuzM7USndO0JZEze6M0oniFpCpIPKO8AT3czOrPpvDzij03aMK1tIdhiiQPxK83Rmbcw3Je1usY3Qg5HU9wk//7hAy91yMmN+jMrgGjkmwLup9ZXgFyX8/yDuIJ4GJ8khHlaFHs783Bl+nlFJt0koIDEUOs/aM6gXURtLC3nH998A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ivNWqzelemYPEapGjGZF32IydTHBSNTERYPJOFgp67g=;
 b=wEBw/DQF6vMQ9u11p4/8WLq8lwgUqi/4gGTVIGUeNrNq0KT5ZRv/FvNOLiRYHPQjJKtfMI/qreIGpJ72jpBLbvp5dQim1527H5r495gqQbcTafsyRLKheu57dL/ndju9+nYXHR6pS7+X56Kzr1E0XsrCIRptpk2xMWg5zrJf49pFm0AaXlIyU4TQqVqI9alW4Z65yZP3FINtGvAI/NRUSept8PkTuGVMnTHGFYKwOm+MrCTDtPLaFfNzvDeNoId3YEyEPYAwy2BM3UgTXEq5/ySoql7RBxPI9OBJwUHTOKjji+B5GSMRRVd23GtePD7CE79ex2IFQdBLPP2S1Qwq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB4333.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:19a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Sun, 18 Oct
 2026 02:38:00 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 02:38:00 +0000
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
Subject: [PATCH perf-tools-next v8 1/6] perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
Date: Sat, 17 Oct 2026 22:37:48 -0400
Message-ID: <20261018023753.584873-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018023753.584873-1-atomlin@atomlin.com>
References: <20261018023753.584873-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0459.namprd03.prod.outlook.com
 (2603:10b6:408:139::14) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: d631656a-b038-4dad-d813-08df2cc0d3ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|5023799004|261009223027099003|22082099003|6133799003|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZFUUGbCcDKxc9/F3tiInm2dnB3ODE5S9V+vKWEFWY3JRI72Mdz10En0LIvh7F+4UgVFp8qsuT1d0cpyhSJgzsMrlytHst/wv4f0q3XrSdjPQfAg1nOxbPj2mEZ5QLPMXx+sMpP739zk6o2Zmhvu3f5S8E6km4vnc79i3dibSm2T0PjysJBpyuA+xo8TwJKGNbzxziwP5HnnqMX1FqEIfB6HJnAGe1Z48rzKAJRZV2OyOc6WpkpHeqwAYYwQfpdTuMmebi400zUGipEAbGPqGzDChBhhznxYlaSgCJd3c8Zg4CK355itpyOjgM9QHK2NM7tKXp0TCs2nk1P+sZ03yEqSlNTNoYeTTXI5PHI21YrCMs39dGR0G0bL8uoT0H6oXxj6wN5EY0he2sPMtvFI83+sMS/4eZTJb+FoRcYsPFcyhdcDK9sIhoxyb8h5QEbcajMJas7QiLiAu9Cto94BFtfTYyNlRJx4eQevP9wrKNs/2MfVSoL10v5tqziyRujR9dcuPaNew+hZXh3XiDW3Af4dYXw9fIK+q4mD8GZduIoM6cvVa5KmjdD+gVgX2iiGPMU05Vr8hfFAv6IKYEOixwZYpGqKcy7VmLl/DCFOfu/R2rMRY5E+j4jqDWdgYoAOH0xlmOV/w1Mys/tJ0Xej+7vxS65f1bk3sVVq+4rkZqOM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(5023799004)(261009223027099003)(22082099003)(6133799003)(10067099003)(3023799007)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cKabFcV+QeT8XLJPtk1XZ0I5xKZGy07mO58ZVXUSUjzBXUf6DwuUWXw8Rj0F?=
 =?us-ascii?Q?XVD/MFuEVUk0W0FyY8YnFGf2TlX+YTnWo6KDsVVBqTokosdN3nfcAxNJtKef?=
 =?us-ascii?Q?wplp9nwcA7M7/G7uOmSQsFOSfC45gUrLdHlXNUzNHFG+PscEfAt2XbkCxReM?=
 =?us-ascii?Q?sawpKHn+Xigo92N/BJ47bUrBi+6Cu5DNyPu4sPA5k0kI879uSFkrfIJRxZ2i?=
 =?us-ascii?Q?dJpyo/USd2t3gNQ2ySLxa9CQ1hJmTIVZZFE2mePA5K2eBclAs2EB+OcWKdRC?=
 =?us-ascii?Q?jefle8pB+0oBCmQeHk9e17AnrIshBaR5s8Gl6XLwUrhdTuhESpZtpSwTL1UK?=
 =?us-ascii?Q?aVCIEzOKhYijcjhXyV8yi4234G+lifYYxlR5C1Dz4T5zvEKNOE5owIpA+Fgq?=
 =?us-ascii?Q?Hvlgn3K6B2ImgD2X3qAI1u1rE2VHJXFE5FT0a5GYiTdhR/YYbniamHLpMn9H?=
 =?us-ascii?Q?qlUu/aS8lRLetu1/cWhN2S5QPMjCxWOF71mVWUKlgZPe1KAr+jpJjUHNZM/H?=
 =?us-ascii?Q?Bcpm8d60bcWM1yQZokxiR1GSM1vGhg9PEQCZPOub8KYgm5ZVj3Z5h73yKaXK?=
 =?us-ascii?Q?saCyA7sj7VdUHt61U06p/1PFJZDbGku4ESkbAzO13/c9JJjxho6OOK3dHrTE?=
 =?us-ascii?Q?Bjge6w4kmGVuk0QO9JiE28dUs4UlxqQEA17A28bo7+ElynQGi+9tlsflOZE9?=
 =?us-ascii?Q?ZocpwvPlZmFHZSxzZXnLn2PBjCFX6Xg12gglOz7ziLyoDLW/Gs45wWeW6ve3?=
 =?us-ascii?Q?Ml4c2P4XqZgBZA8l0xav2toorsM4dfP1WiWbHMEn4gFPug8cyBJKQ5mrdPia?=
 =?us-ascii?Q?i9tPZQjSwCdD3LqbUpAGTdUE2sIWlzgJFqNorlvHrkZ2z7AeR2rE1ToP0pak?=
 =?us-ascii?Q?81rX5LBNp+HGMBhzXwNCsJch5VL6svwzMrCMNGQZxsJaHPipBFqUUEGiVdYN?=
 =?us-ascii?Q?8s7Xj+Sk66VWzeOhz8hA3/uvf85tUgf3YH1hNuXodcbFcNuSVKbviwvZwKNt?=
 =?us-ascii?Q?fihNZ9JQNRIsFiCxG9FNOgwbkPhU+sp49YmYy1Bq1MBj0dHrsxW/xkCeHIh0?=
 =?us-ascii?Q?nGvnWLfSCnoyQPYwLNLCvLJiR0AX2h14SEkVeAo01C0zQHIyj/QF7J7lrQhN?=
 =?us-ascii?Q?bV0UcARi8XYg5G/g4J9lHBCszQ+b/7CKOnGQOI/pUnKr+SZX31uW2GAfo7HQ?=
 =?us-ascii?Q?eqEXeZhGMkrWERQUtXcAkyFEfx6WmpCyS0rGw9bdPLUVuGNDobl+9C0ILoH1?=
 =?us-ascii?Q?IfLkIecok17s7pIJdr5wmbzZaG2W1Jts54o4KQMoX46FA7h++oPXgfF8wjsT?=
 =?us-ascii?Q?t81qmXEKSwm5EKLU4t77W92oGrEnkk0ZoY8vb+81OGFRwoTBKa1G68KQXQG0?=
 =?us-ascii?Q?3YaGUdzy0PlRtAf8WrC/fw3Kr6wiS07OfaLyTD2SJlsJN3iDdp2YZMmfpI77?=
 =?us-ascii?Q?1D01/n41DRPzJEPpd45YhH8NwOizGEXswvK04sRhv5WtDXJo2fdgAMFvsJVY?=
 =?us-ascii?Q?elBB5xJ5w7d7tmaIa0soFYyw6iwSKnT4dgLdhxg9K9zEtu4v09I3l84QLJRz?=
 =?us-ascii?Q?m0hJBsnywUDZqANfE3zteZjjdOy6mi8Fssa9MNSyoPSw2Sp0ZzyWuZPTKHeg?=
 =?us-ascii?Q?n0hMuq9/n5fpn8oqlseFXzkjGFMhlh+O1xJz2+r7jxtRGetXMu4vg/BwOnDX?=
 =?us-ascii?Q?LK+4srBKp6h6qwFSphezZdkqhXFO1SkYnKf6DH3ZeR7S1EZ6n+a/0YmFQ5vK?=
 =?us-ascii?Q?C4QFHhmggg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d631656a-b038-4dad-d813-08df2cc0d3ba
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 02:38:00.8216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdNpsO+Wat9Z9buaJF5JlaViiVbvSjfvIWGwVPi65EK42pEL2ST8aDwV8LFk3d0Xb8b94SZo2Sl5tf8ULyKZnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB4333

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

