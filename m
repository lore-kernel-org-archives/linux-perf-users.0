Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.140
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792877159;
	b=djlopYD9TCYEBCqgh2LYzKoHPbWq/z5lm3emHvR3YXD0MgxCoLmzgYO34aeKRRbB/iCL
	 6EOsIHHkWInz8GYL/A01iIJjg+EugtRHoTH3MskAIn4744AeDeYim/4cCPUEBRDT1tZYI
	 0TJDQ4i47aJEd/tRp06WIP+DXhd1XVdutrjbX9IspBwmZDDJxCXUZTJHo3k9nfXLeyzok
	 aoEJC4nl0tHU5+zaVd8A7xMkEJF5Io42qYI9Iw3N3zFYXcXwQQiXM7jrCi2mRxvQnqfbo
	 r5ymgYtnpnLo2SeJu4Sig3+65MhfkbZFoYJ8VQfilvclQ5Yb9VTlFWbgtt03g82M0HQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877159;
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
	bh=3KZPPXDZB/EY+SvPa+01ScRRcT0DlFLSP6N5S9qMwJg=;
	b=GxthFrBzkR3q14RpH/9wVYcLLfJeG9Z8ccBSnaQwTI1jpPpuEsShS3qbrQStbnRmXJbg
	 Jl+oGhHVE06QTj/WdTZLyJv4vBDg1UxsCuvpqwo1HDhQRe1p5z8wSRfC3iZ4TsKmWhT6E
	 CUM89eHEqTzRIXplJbhBz8Jar0+JlNhLIMryS7O73uOMd6ybZNYFoLuWHNmX112UJBhmF
	 MQVRonH608bqMd0MpXzZxXXa7TTTR/io0OYbYkCCdvoY0Qtzqh5FWA2FiQACRRc1DIh3u
	 0oOXJlCelZ7yOnCa55E47Dwk/FRwhRfIELWQ4UXvSvoVLdbxkCvI3xuRb7ZjVgmcDUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.140
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022140.outbound.protection.outlook.com [52.101.101.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF5606A320;
	Sat, 24 Oct 2026 21:25:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FEF5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=al0usLo4z7LAntaWe8iJb2dLh0DIma5Ck8IF5Ihrb40PR/LeSC1ubVcphJKLUxTCCQPBbS9KvJOc5qK/VXfEaD8KBJkkF2F/RHkR8QhZ8c5Pl7YlnJ/FWx8sLTgfcJQG7I4g2q+/PMG99U2PmyMue7alIybn1illEN6IEWS2noVh2+7+ESopXGjQMPGpdx6yEZy1mplHT/jJgm0yhfaHqnwg9+ZxFAIUZuEc9PJ1FcQImkGr73E9V6QWOeNB7K/yYwBRDiV7TOqtzG0mKTV7pv1hLwVUpNxTuy8Mk7/ccTSYK4vq1JxozzQ24K8GeAffFTWWrlbIzGdRfrFEIiJ3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=3KZPPXDZB/EY+SvPa+01ScRRcT0DlFLSP6N5S9qMwJg=;
 b=UoNtbqSs2XLJwud8hFkBtly6qHUXIVUb0yn2hNu2S7Lorr96/YhJsXN/3CmnHnlthvCdo5pL0a5/JZ4XMJrVclVcigcOIvAxxFCeUbVOzqL3ATVX8kYzmgqqKO/V9d8UNz6xfVLU/nYTj4tW4N/+d5X8u8i9t2lU7jczRVR/wuYx8W8v36gDZ7/fQjxUL1hs/PuCv8drg2iXc4OAN/qxI28TzXzcnKTCwZfLdPPrEK/t1cNq0zYjCfjG227TEIgLLJVYU9ReuDpxsq+tul/UDV7iq6y8ivetrX4VWL2xNR3+vrBTHPiE0ISVoSYwL8pxFgAtH1s4v+xXL0UZLP8Jew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6642.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:273::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Sat, 24 Oct
 2026 21:25:57 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Sat, 24 Oct 2026
 21:25:57 +0000
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
Subject: [PATCH perf-tools-next v10 01/10] perf ftrace: Handle signals, non-blocking reads and pager exits in __cmd_ftrace()
Date: Sat, 24 Oct 2026 17:25:40 -0400
Message-ID: <20261024212549.450634-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261024212549.450634-1-atomlin@atomlin.com>
References: <20261024212549.450634-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0386.namprd03.prod.outlook.com
 (2603:10b6:408:f7::31) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 1d68eac2-dbc5-4dbb-c0a9-08df321564a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|6133799003|3023799007|56012099006|5023799004|10067099003|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	g5fU6yMC+CIywY17zNKn+PxI3AFZxZohScT6BW/47G8DH8bZQsaoj3qTZTdXMVV9e2YBUFXh22RD/020deCtKNlmP9YuOEe+5HL/NRZrPFSQI4Eviaa5P4w+1SDji/cxZUlEkEZUvMJrVIPoQaQlckP9jLGRV7Go/q9SwSMImosL6P/DcPTWFut4AHdUGbsvxzJOvaTrqgkXlGNyZ/TPilfMqfVt+MCV6EIQsDF9wdniJFgM5Rz5gePYQ706S5fyDAw8jzPGY55RJj8jybFHFk+FnUre9jYu4aFPqgmjknwMn2rQSWknSYuRAGOcivu9vPeahHKLwVvjORo1CCH3rcTQgL4XzA64oe+6p2HJ57pEq03HJLJ3b2v+LT6IB5chKm8nN6BQj9cEau8giGdfYtC6y7g1HFOAgzoklNWrZNEh19XKcRJlfV44ygJdEtElvxJOWPxR3e+a0RSDfvzAclkICngdZoLLm3MO+7c54DkNB+r497rAVwtBs1v8jncep1YE5K9MuUVOxSMvsn/FuEaTROIsl7kUs+xBh0b4UBj+B+QHi4D3L/FPwQPq3Nuf4IsnJwKCZsMf/l49sPAokvyMh1OkrQG59t7SaERt+f4BOIlc+4L+XFavSud5PvuLJY7o6rub3y62cSCm8UKwCqa8IOmjtEcy8/tkAm2SJoQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(5023799004)(10067099003)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iYMY6atNm3iF+O7k4VOa/CItefeBeXYCGkR0m32P2Z7fuQ3XX3fftNhE0Jqr?=
 =?us-ascii?Q?emoi0SCFiSJyML7NDOakDk+KZ1LLp7zQzYT/np+8nKxrbb+36ekq71GlW5Be?=
 =?us-ascii?Q?qaPcQZ43zAORcl7Icl/muHDaBg5BiUP8nPNIlBUiIzoWL+zKRVwhhghg8qfe?=
 =?us-ascii?Q?psA7Hk1sSsOVPY4d9dLhRCA2iMRhlaNdACJO+7kqBH68aJ51I4Z24b5LHZZ9?=
 =?us-ascii?Q?p5SelbOHxenDpyhxFTlzzBike/7FbIIdnlnQXE3oG+dlPfWG2bWi/sT6qhej?=
 =?us-ascii?Q?v0m8NxO/E0OCi3J0E9PtpGCXOC2Wjr2p2Z6IBmR6A+GtpXqXjXYbstRydIm5?=
 =?us-ascii?Q?XP/12psoj+FZpe1MlV3Eov5vAwIr3lEW6HzJhETu2AdsZoIdBaxcl67zwOBG?=
 =?us-ascii?Q?Uwwgg5O9Vi70iJy0VIn0nboKI3qbGvXRGlvMMEVq+lbo01sUukpRsufLnhmP?=
 =?us-ascii?Q?59G+01V4XxF9BATxjGWP1woa9WYvwfCsdhUdm19Nd7KziFzJAqernes0Q0dg?=
 =?us-ascii?Q?lkARIN2VHNLBI3u7ThsP4eYHoYfpbDs/p3Izt0z42n6VBf2q06jBr9mWmehv?=
 =?us-ascii?Q?jQ5iHAziGRw0agBYqTckT+gawnx7oBakn6Y8H+iduPdeD0PkEaQVzHdjkQcw?=
 =?us-ascii?Q?rAPzugZ+mGltTFjHVjRrMugl+gMnXXRAJGZuNTkCESN14JyD5uGXFuz6HZDl?=
 =?us-ascii?Q?4Ry42+XpQJevLb6clIZZvzWU4fmUiQwONzNHw3g+2U/664CknQFtGWSkAU4v?=
 =?us-ascii?Q?kx8tfmKqlmMBzTKKJN9sF5xR/w5tMdvtHul5sXlMTYlDVlZt8W8+hYF9G+kb?=
 =?us-ascii?Q?lPp0u0Kncbl3Z3OT6sLKl5g1oIdHkEyf+Gl+J869g4yS3bVA1/uZfj5EtAvJ?=
 =?us-ascii?Q?AkVSVetlM4pU/d1y6aTqivKWy0AzNJKxzmm7fXMLdmIsaqrqBiGC2JJ0gWYJ?=
 =?us-ascii?Q?X1UZM36Una3iThrCerHniQp/OZmZvDKjiRJMK+Cpd/FmVbnTN32ZrRP5P0dU?=
 =?us-ascii?Q?NUJFVHySIAywM8to2x3mkMg1Oj+Hh6H8eNLdlCgai7Q6YGThAH1SYAo50+Ug?=
 =?us-ascii?Q?dp4eZFz/6GlBAYG7ao9lXQQw20vzBoxNcqMhJpxbkAHWqmNP5/URrDok9GCn?=
 =?us-ascii?Q?GzIqDsrhdLqFXo4lFj951bHCLIP6d5K57dGyUE7JHeqA0CUCs6xaKHqOM16G?=
 =?us-ascii?Q?JfKBCfvI6i4/7nMybEc1t1djsX84xNkEwy39S2NACUEljvqMrJJm0Ithh3Pu?=
 =?us-ascii?Q?pCG9tAr/1OGK+e7mJ3a14GnkVjeZs9Qt0XDr5OUi94nEXGqSAv4uRhQkRKlq?=
 =?us-ascii?Q?tCYLCjV40jD1DoyI0nTuaimBUULKJqnMDmzFPYeM/19Mi8pJcSMq6MZ2z4s3?=
 =?us-ascii?Q?JheiwpHgTbPwdPpls3uaQuQ97Li+2t2JamqkyNlv/zOKHhf0mHKpx3PeiSfj?=
 =?us-ascii?Q?DAY6nBpJOtAVGLDfrEs+4OV71NSc7utMYOkjHR3elhkwy9NN6wPAMpRQJNKL?=
 =?us-ascii?Q?V8LUXoQZDwXYImtbY/djatYeUZiS5qThvjouB3XbolV2WpfxqgF1uEBMQxkZ?=
 =?us-ascii?Q?rwA3ev8cQ1vkk8c5yTc/NzZCKhxhd3qciUvzsUycGFv58PeTshFSGgFitstE?=
 =?us-ascii?Q?h09thKFTWxFeZRYvzv+EaJOn08a+7NmGJzOC+9svI8oOMotrIh3Im6aBiy0t?=
 =?us-ascii?Q?W7ScBaizPudT4wg+h4+wTaMT/TdfOxSBj4NonqzksOxOR+h/xV6uoEKf7Gwn?=
 =?us-ascii?Q?mP65x8nw5g=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d68eac2-dbc5-4dbb-c0a9-08df321564a4
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2026 21:25:57.5589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olb2tl9Gp6Ttb6Xgjob0gDAFVfeUFV4W7ib9vYSm5Tvg+znQBlSxe3XVSFFbP0s09eDacirQrkJD7u7Ojsntlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6642

In __cmd_ftrace(), trace_fd is configured for non-blocking I/O via
fcntl(trace_fd, F_SETFL, O_NONBLOCK) and polled using poll(). However,
the polling loop previously treated any negative return code from poll()
or read() as an unrecoverable failure.

If poll() or read() is interrupted by a non-fatal signal (i.e. SIGWINCH
upon terminal resizing), errno is set to EINTR. Furthermore, read() on
trace_pipe can return EAGAIN/EWOULDBLOCK even after poll() indicates
POLLIN (for instance, under concurrent readers, spurious wakeups, or
block-mode trace iterator options). In all such cases, breaking from the
loop causes perf ftrace to terminate tracing prematurely.

Additionally, output errors on stdout (i.e. when a pager or consumer
process exits, closing the downstream pipe) were ignored by fflush(),
leaving __cmd_ftrace() polling indefinitely until the workload
completes.

Resolve these concerns by retrying poll() upon receiving EINTR, retrying
read() on EAGAIN, EWOULDBLOCK, and EINTR, and breaking on EOF (n == 0).
Furthermore, detect stdout errors and broken pipes via fflush() and
ferror() to exit immediately when the downstream output sink closes, and
handle EINTR and ferror(stdout) cleanly in the subsequent buffer
draining loop.

Fixes: d01f4e8db22c ("perf ftrace: Introduce new 'ftrace' tool")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-ftrace.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 6017493ff179..7cdc9ae2fbbb 100644
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
@@ -806,17 +807,27 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	}
 
 	while (!done) {
-		if (poll(&pollfd, 1, -1) < 0)
+		if (poll(&pollfd, 1, -1) < 0) {
+			if (errno == EINTR)
+				continue;
 			break;
+		}
 
 		if (pollfd.revents & POLLIN) {
 			int n = read(trace_fd, buf, sizeof(buf));
-			if (n < 0)
+
+			if (n < 0) {
+				if (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR)
+					continue;
+				break;
+			}
+			if (n == 0)
 				break;
 			if (fwrite(buf, n, 1, stdout) != 1)
 				break;
 			/* flush output since stdout is in full buffering mode due to pager */
-			fflush(stdout);
+			if (fflush(stdout) < 0 || ferror(stdout))
+				break;
 		}
 	}
 
@@ -831,9 +842,15 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	}
 
 	/* read remaining buffer contents */
-	while (true) {
+	while (!ferror(stdout)) {
 		int n = read(trace_fd, buf, sizeof(buf));
-		if (n <= 0)
+
+		if (n < 0) {
+			if (errno == EINTR)
+				continue;
+			break;
+		}
+		if (n == 0)
 			break;
 		if (fwrite(buf, n, 1, stdout) != 1)
 			break;
-- 
2.55.0

