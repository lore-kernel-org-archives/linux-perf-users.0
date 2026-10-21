Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.110
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792550027;
	b=rLLE6e8w58opv1AGbHUzojsZf7NBBEV5onfzEdbiOq3T60YJVv2hdm4wRDFWDtSPb4Vl
	 N6066W1e5XyjnWjkLH9iwcXEEnIIIN/0XG2UrQYz0OypPyut+pBIqQo1CR+/ITnjnj9+Z
	 IA+VBvQFFB4dprnPPg8jreJD+uE2pl/l5zAH4t5Ha5LI9LM4GUNQzCLgoUuXmIZMviGUh
	 1EREhhLpQb/qWisV3yoEFvRp4znBZjB3AcbaoO6xLWTIOo8VDu0AZqpSVYz7XU2aI13Cf
	 WF6OMoxJ9jC9CV3mRj6vavp4P1Y+UlBTQnTSgnk5AU9mQuP3cfYq1VnLMzQlexYgTKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550027;
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
	bh=ivNWqzelemYPEapGjGZF32IydTHBSNTERYPJOFgp67g=;
	b=CdABCpAxaY4RavT8wUyYL9IlXpkab+MDrbkZDeKGnnmgA4BEAB1V3QNYuZoY3ChS5+fd
	 /m2njq2SVznxxvgpS9e0aZgnN6V0Yr3DAlQkYCszcYrcxwmVSz59GN46dGMiFp2dTqWKF
	 CgZmW+Iyu9V/SrnT2ZPyB85mO2J1896bg+xeLvALI3BsWhHWl6xXICrKxlWNW9kti/p/1
	 7MUdKWUOdNvv7uDfLIV557M++XWc2tukAoLu32+uqbEjgGNRlxzm9hT+1LYkZIjkkXOS8
	 4BkE6WcVUKyn1bNZv5rJSf2d1000MsLQ3eC6tyWsNCScXCYDWWrl7PmRBneUt4R0aFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.110
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020110.outbound.protection.outlook.com [52.101.196.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE85606A31D;
	Wed, 21 Oct 2026 02:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BE85606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4yeU8E0PvsiW+lfxU1o0Z6rOvC50YoujcXKk9NLuPLtpaJpJWG+5IDlCQkhLNata81Tr36I3iSykdOD1XQe8TJBA0FtnJbt75u/t69fm/u4Q9btGRPb0Vbk0yulK0mo7I806whU5ImKB+gD0PlOSlhw9P3rflz8AVhcNputv1BrhZb3c3/xrpOgcWp23Y9FjLX/NOcQ/mU55goEh8NweECQTybv86qZUhozkj6dHGS8DvMwQ8WbhvOalcjfpvUhGud2Krz6fVr5lNesmVUtP8m/s8ZDjcGOlTaymxf/eMMLidrNOHsNUnCUJTT29AqH+AxkoS7apx7AwqsWsWuV/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ivNWqzelemYPEapGjGZF32IydTHBSNTERYPJOFgp67g=;
 b=rY6CCkuflZb3lNcZWnRiBh10oVfP4A/K9SriV04ncVaNDQMdXU8nY3YOqxEPwhDv2EYJWXh8AgbPVduXJi940lXY7XYeVEqnUcsF1V5HFOU3yeCGZqoK4MSqqi/jtqV0HfB8sjk1d8SlEL8i4+Ak4znOsuYror51uO6rG5wft9oW4boC6PDoF3ioMnIptWYL/87TH49MKLSneJ6L5htD91c4a1Gy+vDawJ017Pe49DgZr2Vi6UJs4Z7cT2STUCDaMM9p0p8snvPvi4DOIrGNNbRZNMwTCJqHn6TZ9vP4eaU2VkI6mCdqokX6GFCV4bGvpHHTL7NXQCQRiNrwxZZ41w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB5917.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:287::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 02:33:45 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 02:33:45 +0000
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
Subject: [PATCH perf-tools-next v9 1/6] perf ftrace: Optimise __cmd_ftrace() stack frame with strbuf streaming
Date: Tue, 20 Oct 2026 22:33:32 -0400
Message-ID: <20261021023337.809936-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021023337.809936-1-atomlin@atomlin.com>
References: <20261021023337.809936-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0850.namprd03.prod.outlook.com
 (2603:10b6:408:13d::15) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 9634d243-79da-4afd-848a-08df2f1bbaf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|5023799004|56012099006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	qdZ/1hsGZrqGsMlOgZD6dMgPFeW8mQgx+QhuW7hMYPhSEU+BtG38gn3KY1NaCU3j+94T2T8CrYbk6tLBboC7b0jc9thNmDHNV00nUXNKnGahcLujpqjM4eC50S7ouIypaxD7oPS7pH97RkraF6Yda/i6IUhkCbjMTArvDCrPaEFX3DGGqwyfhv/9n8swKAp/aM4lG1yGS/DqIuaI9xnIBB7qxfpySXSJSdLhisNXYED0Tscq1lSW7UAzQk6W4aeHN1UuVt5b1CunGfp7DcMDOaOo/xH21wHDoqpUSq6iK54jWhKGT+SOqCCRhMNji1yuSSVMZk85+ndL/ZGdt5Z+yuQQ9I+lXP9Irx2zhbt4AkPGj4ynWIIhZfnlKdmCHhLTX0D3nFtKbb6NgcUoLWMNWlvumlgrKFfyXT2cOb3NXheOwjhVIT84lJQ5/Isbw/hMR3KEN9vFjbV4wuGhKkUjP3agqr8CuIcd0WtmsK/1oTDHw7/+/LnaZ+61Ywt5V5bAvbYcyhQ5doITUJog9IUc+5C0uj+0bvqtcu5EPbjVQEXleCmabMxXmboyKpV2rkZKUKYZlYD1fTn9+/SJ/S8JHEoIacxwmVGU1n/TND2jvMnk2IgXa3BmpWxkmMg422AZZruPBTWDas6mVg7IahkSn2ED7kB1nK60g7Xu7TNUJtU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(5023799004)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BB7Aa1IqIrNa8kIpxorOkMKCJoRRnUueM247mAnSTT6VO1khATPiZwd/aJDV?=
 =?us-ascii?Q?vR2Y8fRcPK5ZGm/F7bhekidxLhKrvi3lBfhVbBA/7zQCJElkWv+NZfeGANVI?=
 =?us-ascii?Q?8FkT318BxdasGpy8E8l2/7fWo/OqwsDAfdQDj9wf9ODx2urYHgH62RiO7eG/?=
 =?us-ascii?Q?vhwaygvtZm8KqjdCgIPyRFGYDZ9kuXPaxQlenxnFJd9dgfm1DIXaYxuSbXxc?=
 =?us-ascii?Q?3QezpzCUpYRZ5MtktpgGvb4Yj3tYrJG7Cg0bSC/jqewhHe8uiBS79IrfNXhL?=
 =?us-ascii?Q?76qhRdMRUxYKpUAfCvVwyRNjph0786wUUzSNrigEQG8QJ6xEaFz1SPdVXHZq?=
 =?us-ascii?Q?I20ilXy8LAchlXkL9paFVBskIGtevAi3idbaNA+i0KPTPFVOLPei39HrcyZc?=
 =?us-ascii?Q?HQ5cdFw1CVJ+yyAyLiJAiyuA19oTtOO+9v/bXGfHfFXYGF3rRkATMjVyOYhf?=
 =?us-ascii?Q?sKKxatIaKEp9Si3ZnNOvVC3jTCFRh9/ddLs4nFoMgq4xW0iiaLw6Zyp7hG5D?=
 =?us-ascii?Q?fkk8qoYErzS2C5WjvopXKGD+UiWo8gkULj0216JBXZUj194c4HRGApMyovuc?=
 =?us-ascii?Q?8AePjhgoqnQNgqyLBkCN52d67Qwf3zS2RUUtle49zAAa6M4UAYPn8MGTdpXQ?=
 =?us-ascii?Q?UPryD/2chgKH+hDZg+jLuNLrkWM84hmIFtXNLAtrBuqdNMTrfrkjdnulMgRv?=
 =?us-ascii?Q?ZvZ5sqjnGfdpc2edN6ITeS8Z3fOYWpvjph+5bnHiFkfaI1STlmjWYcaGBwQr?=
 =?us-ascii?Q?3BJQe5zqynd23X+aXAyp9ZhqKKq5Z5uJ2vKtoqvKoEcmGmnJjbI4PvK8iBZF?=
 =?us-ascii?Q?O1LF5HfPBFuKftKuEGtFrLAeobU3EOmC1eF43BNoWmUjW7+c2DDjXQ8i8fS1?=
 =?us-ascii?Q?inwcbNnY055tgTaEQSy2WKQLSexPmh5C2y8oZWiZ2xwD3keIQKRcg4BSvHB9?=
 =?us-ascii?Q?Q4g96Vu4sXa3Wjx2fjeQ5N+ZzA7HA117/OxggokpuLrnJB0qDY8lhqgosSaz?=
 =?us-ascii?Q?yni7mtB46BJ/vziMvKqN7ase77meCFR/uwHnVVemfiO9ULkysvdMZnQQFFj3?=
 =?us-ascii?Q?aJO6wG/8JaE2hyAZu6hbBLv2FF1sP8CVQn6rpFvQ8bpcUVhZNSNQgtJvSCUK?=
 =?us-ascii?Q?++ICeJw+9+n8wCYxMv+KJGj1uc/SUi2KrCYO5VXEcc+K8OQIDt4q7TvIVcux?=
 =?us-ascii?Q?bqFmU/IiYjEbpKPaICCN2hoem461hfmd2qs8GKb6UDbYj0CMctIEn4fDpvA/?=
 =?us-ascii?Q?zjkweHc6H+1RiLzIvm7/3Tr9YLnshDYNEXnrd1EfN0wJLCmeJ9xhBXySyhYH?=
 =?us-ascii?Q?dy6++7mSEKbczZQpgEZT9dfx9XZ/vWulkNCSDRPfNq5udKYXCSaKbUCYa0J7?=
 =?us-ascii?Q?kSwz5jh+im1rsVMZevjkCXcpqWH3EvsJbJO4yKjxTvuObZr+lRVlFmhdk55h?=
 =?us-ascii?Q?DmZsunCzbpwksUV4gI/nOU5jeECb5+ymnSYCLuau3b9WHRl0ICBZOcuQIYMR?=
 =?us-ascii?Q?REe19SMAHXjtrx7Q95RwVilee3HaAv94aXzrykTiMnM27SvMIN0MqVUxk3ug?=
 =?us-ascii?Q?bzZWOz4w2ONuEPMQzdiXXCSrJSD3ssF6QVexS7A6ydv+dmiyg/ELK19Kzd+H?=
 =?us-ascii?Q?nXa6EX01S8YLE02KGi5wOd4jZ1u0T63mAjQYoBC8VVjpt2g3HXEmfx+h8T1W?=
 =?us-ascii?Q?EWhnVkIFD7ZG23aJHWEPtIh4/QMU+GQ6efulujG1L4sfKhp5emEw6ZwHiWdb?=
 =?us-ascii?Q?rPDlR1FP1w=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9634d243-79da-4afd-848a-08df2f1bbaf2
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 02:33:45.8118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GC9E5wY9irTFWnOQJi0fgAstJl4jl+82Wv1lUY1mTWSvlqdd4pSRMHHKwikr2WBoxTcioMgGWRxIm4NH28kvKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB5917

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

