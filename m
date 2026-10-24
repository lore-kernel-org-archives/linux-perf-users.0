Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792877164;
	b=eQGThL2GlULva2p2R9U9HGK4MUViKL2Q5n4vfN+j2XeKPzcVUPal6VcVDWWp44dl3L9i
	 b+BEJ1SDh44DSQOcESD/e9d09S892ZTnXsq64ywV65FpCS2ydUH1Uu7EyXWUjXy2cfrVU
	 OWzXUSji38PYWvqOWWmSkTgr7oUB8dUL7LSirkbrcQZ+VFfdNy3DHdNPKjRqXlWHv1z6O
	 RII+bA/dD87xTzGCsrGcoBN9Lq1RWYylGbmI+gYSu6LfwMTYKOdbboIjPej9HFyvrjdz4
	 9GP8KKaV5AW4HBcwzeI7+zXSSrLljCoemRwdWHjuqlz9X3trUxqVd+f+39WIIQdrSAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877164;
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
	bh=uKHXPAHKpcU/onyV6tHBAgcgCSZXBjjNAQZ+nClFWw0=;
	b=DU1k015jHDsnJ2XIguWHsOCDeER7aybP6qKXAOr4NLSSEPUSKNigVI2jeIGqC5mJpred
	 G86Ei6/b3OIcGkMkoZYp0W9gkiRbe5aoAxVk1I8NoJ2LQZro7picgJTqfXqRluvOFVmi/
	 dF3FkxrNSqv8ugvvkZWOqtEwhX4BMpDl3F3XLXxkj1+zHerYkfsea4dktNMTaids03g/L
	 s7jbg1kOqQ8WKKtOXhk9CnOdtn8PGCp/38Es1jM6tUnj5VhSrmKw65aCtQg1fpNMyTZIN
	 IxPHXsXCD/5J30BZa8WHLjOAfb8jJ6RwvokzwsauMfy1cj+hW6tsieEeJjdP7yfYYgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.108
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020108.outbound.protection.outlook.com [52.101.195.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDE8606A31F;
	Sat, 24 Oct 2026 21:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DDE8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6nlIfgQVF2kj17Cr+rHGGyfd6CWbghCXUNU1RtlQ2yHL7JN5VCBlb7hWv8i0OfFj2AfWiJSx4RFZ2OC2rXiBEHtsoCBSZjiImpICmM5Z8FTleIDC1Qv4Qd3cZ98dhP12v1+sqY5huxZb+c5P0im5Noc1AYf0fM0aoo11PrxrFd3hos+9LtOuFo+d9QMia1qX9wdGHjda/arUKcLfOCeUTXwLN267YWf2NFFGptcCoNDndpNsISe8fMPIOrHYVANad5umB+gc6LtMfQBHpO3HpogaopbgmiNMt7FA8FDHiwm8WIg1TOhO4FQXFP89BDdD9kn4ndehqC4zJHcQQGaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=uKHXPAHKpcU/onyV6tHBAgcgCSZXBjjNAQZ+nClFWw0=;
 b=QnSckgxZ/NiHdsjgZxbgYdDWZ/Yd8LrxZEH9VzoeU4xSrsvP66jEFh0mBhZ+If0UFjxNpEe3SKGdOS4Pg25gLA4zVG0Va8WDRQKSNgbT7eys8rEm0UPj5J6itrvW3EyW7brzyrH9HdYcFML4k3nP0VLpPSsrxzfjfIKKkH12CS53/pa3+8wzcYv9QzhbrWKlntrza7++fF8pogjbOEYm/XxfGFNxp4ftBlnJHPJgvm1hifmPjuRVhT3v/2jXY/jqvzDKQ7C0WBMXZprx1AFZhBlplOytOyNaZJcgGAK7E1efb0xkpx0dEtomA7Ifo1nsj/61VlV5oqQumlXiDfSInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6642.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:273::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Sat, 24 Oct
 2026 21:26:01 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Sat, 24 Oct 2026
 21:26:01 +0000
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
Subject: [PATCH perf-tools-next v10 02/10] perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
Date: Sat, 24 Oct 2026 17:25:41 -0400
Message-ID: <20261024212549.450634-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261024212549.450634-1-atomlin@atomlin.com>
References: <20261024212549.450634-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0910.namprd03.prod.outlook.com
 (2603:10b6:408:107::15) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d84597b-82a8-46f3-1608-08df321566df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|6133799003|3023799007|56012099006|5023799004|10067099003|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261022113327099003;
X-Microsoft-Antispam-Message-Info:
	sXlqCpLY4Zfz+GwEwHPUJNIiocnEaIWWys0inYyfjvYyb7DYYTxzVMnOsJZnEWujzyZyEwjXbmP0oFrmRbgLFZUbrGcbmz/e9dSImlvZmIob8A8Wr2UJ4odp/JughSZ4BsmL2VF+8CnQQsJerDUBVMYJGDb6lkrv7cYhtNfepmexN7u8JcTDRzHehn3pColGTg03crUqaZ+zit5EWSD7Bpcs9r0iiHuDg5Cl0b03g2uQ6+ss7h6LBSBqe1kTQcrsDUAaGdTvR5lvCl7sDUoMimSgD/ho4h4aTVnO8C4WU7gg6U0MJ2IZOMYC0+YVzzIszuNiKpDNBrckO7vFQtw24BJTSyjzMIobs6zzIYCETBqFpioVi95BrCgR+pB5eo5Vw/onWJZ5RHza+dou4WZKUO4ZPbPIMwymRa1JkY0j02DfvZuKLh5PPnLCR7Tu5n3so3R7pIe2u3L4HS312UpFKx0pDBX2CRQ6mU301mZQ3aPR6m5m/KBidNXaAWIR8vEFNAc6lfuo4H+bsVkrQ/7MkltCgGaYOIjct70Eyv1vriVaIECb4uN/sNJ23tX8PShE8kcrb3UZnOmbjhGVesUw47nqqhInmmw8J26Q4EljVDmDtneqDYVG+QMNYb9pWrEpEEor3TAPMFB2nWlcu6QGSB7foOY0h6jdKJjyI65cxTg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(5023799004)(10067099003)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022113327099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cNQzCrdNgy0coWUckFxvpX7FDU4uKQ50jvQyHxvVAQVzVEQwz8nkG3DHmGj9?=
 =?us-ascii?Q?BzVATzVNqG/qvJcVXXlKhB3QKrdu9f4vtsvAzDYFu0kFku2kWOYnZt75uxVf?=
 =?us-ascii?Q?oodBxJZFC/YIghMrofYcnPUkKCoElTtNIvH36A2smqZgC6aGgJiTjAgckx7m?=
 =?us-ascii?Q?ghdFhuQYjvpRhqunr3PY78sBraJvhypAlizRXVHsTjovizzQQC7IvImyIkdt?=
 =?us-ascii?Q?/jKPi0pPABtDJRysXAuqRP980tVMYIrnVYq6lwiwHbzLWcBbZiIumDBOE4fm?=
 =?us-ascii?Q?Wq7vU//l01AdM3fXviCOQEc8Cdh6UBtw9cKOWlX8QxXLe1XwU2OVvn591JG1?=
 =?us-ascii?Q?neiUJ+tGU7d2ATNmY8z7XBTff66Ue67dxl2/4RSmoZ90STuJ07CpARw8RczQ?=
 =?us-ascii?Q?wlWLL+GJar2ASoLhYA5Nqg1uj2PTjU63j1uOzIRXFLiB96kJNXrPle9J6IOt?=
 =?us-ascii?Q?Rcaleaac5b6I2/KI01pB90kkaYBMMGeLAWqKuxSi2thWIsS9L0kqeVayBkFL?=
 =?us-ascii?Q?+zyhTf9BqcNFhrB+xFVajq0W7ANxw57alW2Bj++reOpgFh8ynkFtcYR65FDL?=
 =?us-ascii?Q?1FBGTi4Kjj4l3yblMw/xHe+VGB5x7zMXJSZEWjeljilNiBdl5O0XLmqoyA4b?=
 =?us-ascii?Q?pkZAP5hYg0Db6vHw9JFYTMbPPSzn/qSGY1dUpOjKEx673KzaCMSRw4mwFanh?=
 =?us-ascii?Q?MV1FGEqGWe+EXELrX817vBqljkEN3zof1G/4bGQuZC+sJDTYfZuiLGZaw/TM?=
 =?us-ascii?Q?HyZYt1/YwuaQhO91QYwjx7CCJpeNpkTxJDdAYv+ttXO3mssfCVnb/+/59Vaz?=
 =?us-ascii?Q?EzyOSiq+BFmsnU/W6cXkA6njFfqAgjtAsDB0Upfxeju6q6ApWOpcsLt/PTLL?=
 =?us-ascii?Q?reMxgKb+D7Q7/hXoujjkyKuqCtxsw2XzVEzT28aHpT0Vw0LPyBzUsHO5+Rf2?=
 =?us-ascii?Q?uOVuhbjIliWmKm6sN8AbID9ywpqzV5HeRaEZnugeg4gBHgTwJpTwWunQ7Y0F?=
 =?us-ascii?Q?ALJZlgMTC+HhgD2dsuJCTAc2HVr78HDyYOIKXkEFoMLoNdJDVmz9+4BMQNJx?=
 =?us-ascii?Q?Hpm0R4wuao/Bku/RkVMP3XasZZYhG54n2Lm+ThkWPlkQ8MFLOinuaFvyuXZL?=
 =?us-ascii?Q?c9eHbDAzSJamgtsCRieP/ssz1sp+PeI4sjrYuBpjoEHF9PbadRoIqxB6iKT1?=
 =?us-ascii?Q?xDRQE0Vs5/Gps/oSGQ11M+vUQ6+9nNehb7GZcEztt0GwTk5Pgd9ItVzrglsK?=
 =?us-ascii?Q?vof8EnG/7TefxSYbtLzqd1nQ0msfvQ8x+gBPZWBnYTdHTGugCnrbHpzJeX42?=
 =?us-ascii?Q?VTUeLr0Ql6WMHrGxEhCkN0o6FiJZIeRPWTc/89laehdl8rjbT7jiO3f6Xv+X?=
 =?us-ascii?Q?vzKtF1WpfrBUCkuPYxJckFn1LtSf8Lpy9rj5X2xxUvX52dL7GErQ1QVmVVy3?=
 =?us-ascii?Q?IMog5do9dA5kLjYvlJFaQs9oWCkFx/r224hXRO9kmiHND4liMmiq/Z6lPGrc?=
 =?us-ascii?Q?3UXrcVV66COmkmd9ES0EA1m2Xn3gpAMhppH/wxVSnMFMNWeffXb5ZyfTd2DO?=
 =?us-ascii?Q?z20y9j8CFNhBqh7YutYnVJd8VmJ0EGgu04iOqZaOH0KzfRldfK5oMnIBkpe8?=
 =?us-ascii?Q?1o6HDHJnNvqGm0B2JlQJSaI1tzSQQ7qpOmFaEd3JLR92hHBuBjJjLNIzitob?=
 =?us-ascii?Q?+zdLCds2oS81O5bsIqP32cM7TSpDgbuAnhzg83vJg0i00PVKNmr49wdZfMe5?=
 =?us-ascii?Q?dfGFpUegaQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d84597b-82a8-46f3-1608-08df321566df
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2026 21:26:01.2959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oojggfN814RWmww3xDgwRcJyX+uZhFcuEXO3CLN2VsM5AcsyUJQdP5TxB3mlcxEtmLzfUMnDhg53+RQ5jLP+Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6642

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

