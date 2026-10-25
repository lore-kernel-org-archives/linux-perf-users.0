Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.129
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792951896;
	b=pJ1Qq/2/oHDQRUDgD3yCtXwbCVPNH4XVq64tJuc/LryBwZvE4YFMBIdJePptlIiSaJX5
	 XOWuYfvGGuwOJCrtdZEg64mTG7Ur5JElR5QR1fRJboJfV65rkd6k+91PNwJqOhkruNeab
	 1Kx4jkemO2vzyL06Wz5W9p2PcLqMUAKOwad50hLrIcKgWhqmlCs7vjX+wRsNdKTe7tbN9
	 z3JkV9lRMqbI9xlXG7e51vprvD/9MTQzZtzU4UUoEitP8FRqE+9lp9DqVdMo+D7z84w1c
	 DchzwhkEkJ/LrQz2QZNVZlL24WUgZLf1bVVeCKGNF8N1WVn8UWyL5xHkEFovm9YdYOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792951896;
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
	bh=ZzemNGD1FqHN94h9nGTANHC6KlCsIO+x83kJATeIlCo=;
	b=N43O6FeNLMlT1DQ2DBqOpmaDlwQFT3mfP6tFxDjcOJ/myskNOGMCCWboxkEhYybzLoY7
	 3nCXgy2uQnuH+Wiup+LSAMS+FmwWnghzd3tMZlzDNFZ2Te9DIA2b+ww5M8jCxH/XuLQcA
	 3DVQPuJXjFkXW2dzKf7gaRpEFQas46iQxXlywvsQoiEkC5yWLg+wRQBK9MAQf1f8M9Lpx
	 EBc2923/1r8loU/2J8F9trrInIbrgYgAFyhdP6LDZDYK7tW7b48LCi0ySPYs3z34Mo/UJ
	 9r5IfISRaynYgoI5eEWy+AVxBVw1v3eFxI4kSbgi1PV7FLePgisJpv0p8uXvdUeKQ1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.129
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020129.outbound.protection.outlook.com [52.101.196.129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F0E606A32C;
	Sun, 25 Oct 2026 18:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8F0E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jv/uQlS8AukjN7nR5PG1vVWo+wL4QLJmH1GkMOUxBF05BH9aPcMXiRUSjV6ah6lk+44K33eW/5pgj+arqrzbesMqq9DempawBA9XSZahZ+9ArVcC3kPiLb814nt4Ena3rroSpc4ZkRveclWLVh7soVfcjO23DX7JRL/zeL1KB1m06YSkHmZqVd/ldLZ6QDLgtnA8E5D/Mcx0pmaxnX745EBb9Yc09TP0y7+Kfsqz8gcJkp1nQpTQ/k4gC5SpZRKaFR7NbiG3kIwmTeafUty9Z2IHQSUnOu4rEZ3BOf+EQglFVqU0CpSjd7YGQjUOIoyZscJoeu1gUZUWI4JRGN6V4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ZzemNGD1FqHN94h9nGTANHC6KlCsIO+x83kJATeIlCo=;
 b=H/nkKReo9WNXglikl6+txLMZfoe8jGHo8EAOglnx7wJqn0sxeqDr5X1VNKl1SHa41iZN4sSVUnUxucYSYjxL8ilF3bR98iFeDNe06gxVtfw1QwVD8ZWANiTkcXSLdsOiVLNw9Atp7uy+gkCo9FNfkt5+5jJWsGlegLwFjhX/BizWsMv4PIfhe4D0WYP/2OUW7nmF+RnRHlaitp3j61uNYqjwlnOck4jXw7zXc4+XQ72dPDeX5oOPA+sRu4erDlUYZKTL2ZN8FifDqQ3lso/BjS0xGWYSK25sdAQliPJGpuDLIAOEP+etlShOitV4qOPNAEu/wo13SmSt1CTswRHsmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6815.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:30e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 18:11:33 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 18:11:33 +0000
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
Subject: [PATCH perf-tools-next v11 01/10] perf ftrace: Handle signals, non-blocking reads and pager exits in __cmd_ftrace()
Date: Sun, 25 Oct 2026 14:11:16 -0400
Message-ID: <20261025181125.514372-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025181125.514372-1-atomlin@atomlin.com>
References: <20261025181125.514372-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0311.namprd03.prod.outlook.com
 (2603:10b6:408:112::16) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 114a27e2-7003-44df-68b9-08df32c3669f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|5023799004|56012099006|261022105027099003|261022075727099003|261009223027099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	mGUZsB7d4xzyVuqmZWgFD8kxCcxL2rpt4OHYyW87CchNBM4OJ6synP4YafoFO7ydyB84LCGSLQdOP3qwlT7wMs92mB67NcElJqYTfUjukXpKeuUW1WDu64YDTzeU0J2cdnBzNo8VGWHJnlYKXmIVseQpAcShpvbHWe2JPzLhRc1icPyduPdrC0hGq360FyXAFmU1ln5SjmzcGygnPqpe26dX0SAq0Thd8q+h8k+T/Bdzh9rnaSVUStFELkWL2X4wOkodTHcN83LotxnUG7xLOWjXaZdow4x2noVCUWNmohXLCoNcRpM1+EDpxhkgUVrTvsgIfe/hQjj+AwUHM8w0ORZgiwK3LvnT7Sa5No05xqTSauPmBtyNnjhe4MuDFZc1tqb50MzDG+IzNZCQr/IZwB/B1Lq8C8TO1zccDToT2Ntxx/352kmanOY4IOLwQEPLV6tQPkb6TCIw9mhQMcl/mctNPqhHNuH+Gkbu0KWXPQDOiznjHcawIatyMuM3vxUbNpd8SKI/kLtKAnigkB7s3hCsaxtGwbqDIOenoVq4bJV0z+tQp0Pe+bZDqunDVmu1XDzx8GRBhZK3jHKL2Pz5qctUxvLbhickvDZ2iKWnT9010yLqHj5suRRjjQ5hOJJue1nY+JPNBa6HNuAQYycbdsIfdZ3DyTqod6o/zOI2H/Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(5023799004)(56012099006)(261022105027099003)(261022075727099003)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DGgHi90/+gUJASwJ24AMfRTIU//bA6Tlglsci7/MKzBWz2wKUSyJ7l+DvJyu?=
 =?us-ascii?Q?LP505t8f6jasWghjiFOMRpGf6vhL9j76CUSnueEzKd1Xe/V99V0yjrKbQDLY?=
 =?us-ascii?Q?o1TiRA3FZqm47Sevwg+/4AwaCzsV/Tktyet/0k7MJRSvoba1izGCDI5o44dV?=
 =?us-ascii?Q?lAe6+OHF9xb0tIUnMQ3jC0yAgB5Wx9SV6kRy8MwubDmIwM8uQxC/hwy048/F?=
 =?us-ascii?Q?23DpDnUmvlH/6JuhAf6V4+VENTcoySugRcq2dN+Kzet9O7JEqY59ZI4gwemX?=
 =?us-ascii?Q?zSV7Zl6G0Ef0vG9JWLjy2wNbsqE+ijgNpmS49VqCfuWDk+Z8vcz6BKSH2mWD?=
 =?us-ascii?Q?U56LjQfinftH6O6sQwF7E9aAVinKhXxBVUKSvfzF5XS2MYI+thUH2taJMo6l?=
 =?us-ascii?Q?IV+Gv3BUGzFHjg8GaC+jhzXJOZymCxG9T+nFDD7L91GSieYlJ5S9vZ0JfFg9?=
 =?us-ascii?Q?5pzvW9cRISAToR1dGc8UWa8Hw6nn8UnoYXPbJz71PsDJA3weqQjKLvwfzM9V?=
 =?us-ascii?Q?5OD2KMrQ91//Ls+AxGyjdr4LnKB9mvLdAQletOElC6/laxd9PG/NWu9flEQR?=
 =?us-ascii?Q?0RsO44TnSPeu0lbi11QSd3Q4BPZsku9Yu7SwY/aGDU0lx/RcZa9yef+hiC0M?=
 =?us-ascii?Q?7fxraI7akl1uOBAwI1TxDoaGbtc7fbRpTKLYmINbPpxRb9NrTyWVq5oZ8n5+?=
 =?us-ascii?Q?RUtCFDDjG6Uh9z5DfckAdhb6QRdudnhnKYTK6dZycNLaaON2s4LEmzeQ1KTC?=
 =?us-ascii?Q?scuoJwc5//daxqG9YsMP4hkGBMDpd1Xmf8W6ezQrGkL/adM5mcZcMX4L8jrk?=
 =?us-ascii?Q?fycur6IWNKo3Q7zf39l8ot+kqJFHnj4FUisUTrikqnC/CJwq2boMQ3KlHvG/?=
 =?us-ascii?Q?yqYaUGzYmWLXrq9ADz1YxH3v/3zJziWIlYCWz4bBBANfJPl/AtIB0ho6Co9j?=
 =?us-ascii?Q?O6fdE6+cHGHGrm/7PlfE9oMpMK+3uZ6lEfFGHK4HIeVV9g/G/3mVxSkH/gCW?=
 =?us-ascii?Q?+KmnPD3wkJ3pJ0KCLGeARRGVZYYxJZ+GFOMXGoo7plhR+O1x16SUzUjrfVU1?=
 =?us-ascii?Q?oV+LA2r5F/K/8qe4fnZp6KID77v8CJOBKtFuJIKhu1tVMFVv5uk+XXqVzrCe?=
 =?us-ascii?Q?/a9pHLlaCnb1E8Vz0BvyvHt74WtUsEXh7NVaJN1jQ6adCO4GGVwXrGSkVXuG?=
 =?us-ascii?Q?g36J1W7l0H1PyxAwwuGFY1aVAoq/KTlsZ4Uwz/dxKWS77X2uxlYi0LrFvaVg?=
 =?us-ascii?Q?2sU+iCejly0lYEijXVSYj8p3OFt0RruDvoBiUAgSo4SyLOcpfKWkiyqX1Uw7?=
 =?us-ascii?Q?Fcbi0dj6DTdLxi8FI2QCl/fw/h1rQb9PUlSCZMwWjjuQcVZzG6IvxKJZXpmw?=
 =?us-ascii?Q?H2WddVLuKCBoJS/dB8goj171UFL8HB4ObtOyuW1NWOXA+kevx3QPEGKa/P2g?=
 =?us-ascii?Q?yKXYR/wzUZR0XMKa1TCPwRa9RdS45spRdxmBd4GjEADENQ5PPfayXShR8KnS?=
 =?us-ascii?Q?1TgQxln1yboPDPC+I8HcZtoeICPTJCnCisjPJQOHCUbWeNMYr1AhPsBm11YN?=
 =?us-ascii?Q?6ywe6BvHVBESseaQTSBctEfZUD5evvFd1h5c8+gGxmUdW8yKWA0SkQmwrTYe?=
 =?us-ascii?Q?OHeh32LIJaO71bF/X/TXbr+IoscunsX71VloXskrqTtD6A3s9fhsjWyiUWB2?=
 =?us-ascii?Q?PooezzI/Aq0zafuJmDOsdsKMw5xhAq+Lqd30mwam4KzQmZ2CUEahnUWNyPk7?=
 =?us-ascii?Q?L3p5T0KQxA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 114a27e2-7003-44df-68b9-08df32c3669f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 18:11:33.3109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vI4cmPEgs268U2O18ZVe+7YqSjSLNfusumr3h64jQmRbpnyHZfUV+SA+Qg+ThLC2dMM7yikt5Dhri1ThjcR1XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6815

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
Tested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
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

