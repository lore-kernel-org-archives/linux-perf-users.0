Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021079.outbound.protection.outlook.com [52.101.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81203D5259;
	Tue,  6 Oct 2026 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329302; cv=fail; b=DFzMM0cOuBlzvIc6t25tBe0bsecg5+kcSvGrZv9oIVE7KwHZgP5aSom0zVvUsNDznIKA/KuPYq+jtcT5eXkgB2BcncSq8DvuNU2PPEV0JR6xgZhgTGbiOISEdkXu9Q/msMxANtqB5iefnUnQkFgdwqGINCCX+ASWFUelDJz+/5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329302; c=relaxed/simple;
	bh=T+heYctYx9Ork5tXbB6HHMIs46/Y4uHWqfGs8Dz9IUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E8XgfMCPvkcG15YS4nM/GFYK6DnQS7kvUWoh61rxA/ikqG8nBpKO8WTtJY5A8UCN/zDEuVLBVVb6ADxwmHUgJ6olTEW2b8hOLKJZI+iYCLu4X/LqkNMHnM++J9hLdqxEn8cicrh+YU5ATLf50hcDlZmt32g28VuNrU70vabaiEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5253Hghbb6zJOyO5bnwvSzXSARprSKAhezr+6Ku31N8C5glwD1ic/0LboJpRiNYe8I/qemkzGFmEzy846A+aInrbCP6zb2sSu3WQpmYRtTkUbYmJ0YMiNOCBo6xfMgT3y3p3Rh1YseQDNi2qmpbeW8+mSyOg9rdK6wBbyl+cdJTHWMfu5HcaZriBBL0TVxxeeQDtpgXTxjOvjNMeGdj1oNzEpxbwM2zj74RokI8KFAJQ1kqi8d4nFZUEFrp8olTHinQ46VIIAKIthTB0ObY5jaCVham/EV4fzrPcOUpHeurT1n1vFN5F2uV6S01hViv4oCyK/rf8mgK44Jwoit7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=gnNoB5Ev981yasWbUCLIgJUO+FTgQSD4ro2KmCYeaUw=;
 b=WbUKkS7EHQgoxzHmGpyFsjERDaWXVy3aOeIXJQ58hxWw6gsP4A+GgnfOIiEuZDEdlOfYss4Xn+3LqRUtLgkUlz84yxwI6IJt3uZG5qiqrc1HtabrbLaneKMu8xx1bGbXL6R2DdaGpmt/PUWWWwCnr9ggWUT/20cmfgdzdnVdNOUz/IgwYs1CE55mbhFCyZ6rXVugMy0E0LWEN+pa7+a2eNI6uhDVD2SpqjizvPHFb8I2a94ONtO6tGYe0IXXeiqtiz+vTXgZanf6RvgnodgDXqnev4m1EiA7bcEN55lQeuOw1HpkKLnWOTFUJ6vdG5DELZUILjamnDDxgYL17uF0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB4004.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Tue, 6 Oct
 2026 23:28:01 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 23:28:01 +0000
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
Subject: [PATCH perf-tools-next v2 1/4] perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
Date: Tue,  6 Oct 2026 19:27:53 -0400
Message-ID: <20261006232756.65620-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006232756.65620-1-atomlin@atomlin.com>
References: <20261006232756.65620-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0052.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::10) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB4004:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ed4307-dc48-47bb-1866-08df24017650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|10067099003|3023799007|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	vNrt7ZyllioLFH5vxKRKhWu7W/Duyd2KMzFR5o3Y20qzEZ20ntOkWSxUgnTKANw0p+yKgj00LMxEB33lnJZsQnDqd2W/pwNMwB5vJ8sLtYv0qSpuZm+dN7k/pZLaP9neARzOx4caO4c612jO3Ezi2Be5307Ne4mS/QzRqqWIB52NJE79ardt/LVG5nH/a1ar9jWBBxW5S5b5kvy36JkDUKsruB607csTfyOL+Jmfxnr0vuTYr0OnH7C03LeXBN3kw7CPtSE8ElDGkDbEp8oAWJYd2vifs5dsFqCP6b4wie8ACMtpLECOKBTz1+v5oZTAYnL/CAQyvb5y5sllrAkdAGpAc8xgIrSSo+JEUK4IYQKFuUhFshRQ4YLZZwG5M9gXlDXNwOG6bAA/qEgLe24Mmf0nfWjT1JqZqW/swsTk2XlEC751vLlXgrTgdsc9gyEKI8gG1ok8+O8a/5K6vUAWAyscntgZnRONz8kfmETKwpTnCx5coVUrfFszxemdOzuRyo5EbEpbfeeOi6vUZum2esmzy/XEvZPxrRMqIlzS57arwDjaPdNIBy7g5RTYxXPkAt5QmEx0vR0NYOs26Tiy7OLhaeyVm+bF5edBEOPsLPzj8bmJ32fwh+kcqRcBTEHjS5OrFD3o6jeyucQHTCgT+0MJ3R89jsBXupV++5htXco=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d9I15Bha4Gmpdh5DlQQSk/6smS/13ZyR0RFPxp3buMhWYEGGJFSZNWzU9Q7H?=
 =?us-ascii?Q?8yJA6bjTkZI5h/Sbcdi6DZ8TTYsKUGbF2eXbIeszcJeJVtq97XhEM/b2bqqL?=
 =?us-ascii?Q?8d0eIg+MIBdAWInT3TftH9SIk2EHSVGOmLzHwb8nxidzmxwyGft29XpFhl76?=
 =?us-ascii?Q?zbBG0Pq0nwZbGzASRxp3A2x5LjEoMxxR21w47I1HXismt0XK4ukiyjngEMgr?=
 =?us-ascii?Q?cVN1ZQuIZwft03kOfJDlpE7EUFyd8HfoGiB6KAzawezMYAXLuOgpB8R9JOHD?=
 =?us-ascii?Q?D5QdU8rHuvJ2232gi/4X1+ZqKHzOi70CAd+p8UXbE20M1pMqlEJB2Th62t4P?=
 =?us-ascii?Q?u+YLmvxVK5ti3I2NL9FszJBgW9kFOP2Y02s3qJqnCHRw8ncXh9gLP6L2bZbw?=
 =?us-ascii?Q?6VAQP9P7suZf8Z7dF4WjxA65tB2ujT4zm8Be/d6VNMVSl/IrACFtAnSAw2Xp?=
 =?us-ascii?Q?vQXaJxE5mb5AOwPu01946DNuify7IdZszno0HIAQGRkO5Wi7y4ib0QzzFZL8?=
 =?us-ascii?Q?VawL8MzN7murW9CuP5PA/FdrCSZnrhZ2M4qaYPdb+FNlbjfOWbq6ofBHBUfq?=
 =?us-ascii?Q?rDUtdR+TCVvDOzORWDzpevBDW8v0U8eDsdz0NdHYj1i6btUxHVQp/rFC+8uT?=
 =?us-ascii?Q?htcsvpwSNgxG2lVMYGxKPt53O0ouDEASsSik5QSbS7LP9XhKAClS8M/Ic9Bb?=
 =?us-ascii?Q?KV2cY5JfDD/V2yyZhVs1arhXM1sNHEsXx8e2g+QZlRiaT6ZfDtP/a/Pf2C7z?=
 =?us-ascii?Q?nvpI+937nvcjERAHzOfyNFOTo9zT1MZcJyvXeOrWYqrUYuV+Np0d8r2954+V?=
 =?us-ascii?Q?zFTofpaspvxhO8a/IhA94cXCSRrPgcLIpBgrmftQ4RXaK6vD0lWj/37PjoKU?=
 =?us-ascii?Q?y4xE33uK3hIDBHr5R0QKESDktNtDvqqkbi2EV2PUsCecu/dayhv+SLCH6mBs?=
 =?us-ascii?Q?yyvOK/TKbLeJdEJNBREwOrh8cMB9TG6YvK2xwml8mqLhVn39u9x4R9jLH0bu?=
 =?us-ascii?Q?yTGnu+kQ4hmz/zHwn/OFRVqfHx+P+Fdlphoppbu629fqUiwgMWPXyUrsEWLh?=
 =?us-ascii?Q?9mMtyykJNVzu8SG3JlKMI2egmxHe8MLecUTARdaAhk1qsRRNKVNy9fuZHZjm?=
 =?us-ascii?Q?6PU3OrEjzgMTv8cPEEA5WgcQELZAxEZpWL1hqJa9Bx8vPLJMWplzaiLcifnM?=
 =?us-ascii?Q?WqOPxPlYeuz2LQ+TvRC5yxsm+V1Y7ZHHes7me2vopPKKEdb+T5bma0R7hynb?=
 =?us-ascii?Q?sbUWlJ7Tglz15pbjGoK3dI0UN2njZuz87IoZPLPdgTkJdzUXhGjJK6bLnffj?=
 =?us-ascii?Q?qLnYpT0TQWxWbPfPpI5VixqUug2mtYE+ZpucyH+0jk9gtBfcSVSnoN05Zjui?=
 =?us-ascii?Q?vo/+vrYmAPlFP7qB92Ggt/vfeskp8F/V81XTm9EMvNbg+fE4P5ObqQrRjX47?=
 =?us-ascii?Q?Nika9Tj2A/zLVZmRfaagMAjR0nG7M9QXS+9u1CvQNM3QwTqVnt9UyAwN2kIt?=
 =?us-ascii?Q?HjpNMcqT2oe45ztZgUZcNp/gFze1sY+rGsagLzHXPGnO6CPki30ybM4Poq2v?=
 =?us-ascii?Q?kALzIV6oEPdmL0qLElEKg66ioDLXTVPghE+nE4/FLi6vTEasVxcJTqU/pOl7?=
 =?us-ascii?Q?Z7gHEYhjgej4LsQaiPQNLz1veSDWViB3qtqpcnIBfoOZSXybdy4OE24ecHv3?=
 =?us-ascii?Q?j/BM3I5SWdmd3rQxqge/bVnapBJ9x+C5NIfG7Pv/b/FPFZeC3xjPY8kC+fJL?=
 =?us-ascii?Q?5kJOmdYRBQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ed4307-dc48-47bb-1866-08df24017650
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 23:28:00.9714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfKz36eHpW+qBTjlmwjLnmTD7AWdIGfeiJ6D5Wb+WEtW2kp6wE8Rs9t2zSnH63+oXvFlhiAvFS6p7eB9uF2ikg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4004

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
 tools/perf/builtin-ftrace.c | 52 ++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 6017493ff179..4e77a0b2513f 100644
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
@@ -767,6 +771,13 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 
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
@@ -832,14 +851,29 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 
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
+	free(buf);
+	strbuf_release(&linebuf);
 	close(trace_fd);
 out_reset:
 	exit_tracing_instance();
-- 
2.55.0

