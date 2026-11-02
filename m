Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793655664;
	b=xYWw5mtqtvMMKfgpx78ciGP8Wjs4bIkmVz6yPhFbl09sWRylzJl6NhY5I+rnhoaBVaBG
	 l8XUuSDRMyCNV0dOgKhHI6Q4vBEz9c7bEWAWmhlLc9Y1nmsyBtrKmXGvBafCYNIJAoI2k
	 idrQlaDORctEUcR9Bkw8KQG6WbI7u2aEcXs+AvtshvCDYdJHi9+HbkRhnS1/xnaUIMLO/
	 dzpCmWq8sYjqWjk6v0V1zFc82Jq/fZ6oUTO8wdOplT8c6coF6yAVONrdosnShJqTbNQ8t
	 1GNIOZALBmxMS0tvYKFk//zPwEYeGlKirfm3IU7vLUCrucJGalxncM6HZoNPPe5SkUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655664;
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
	bh=2TDdyfi6VH8fbjP7+w7BLQ4KilM562SM5uE9GwjsaO8=;
	b=pjEkWAZb4aH08J9LZg8GbS3ytWybv51WPMxEdHorBZ33++hUiqOxN/ELTCHZ8MO267Ft
	 tIOyeRovKH3ARxYaaIXekQQOJIY1FGJMDTp8IG0c7Po4VuYhYKhHdblgzVaIvlwccOtFc
	 YAxpgMjs4za9M0sZn/Tct2jRhuxtG6SlCVtuxGHYJytNapKeLyAbIEGuWNsVDXwf1DZE+
	 Ecnk7LaUu2ujE226zEygV6QjFHn8cfqaTnsS1wfGV/IDrpki4g5vu4onM9KQAr3/3sUuG
	 u0llDP7sA2AtnyVRJB2yFNKLH2ZBMV0hOZf+Bvt6NISX7FLea/vqzytGqrsSmG8eSlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.75
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021075.outbound.protection.outlook.com [52.101.95.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB31606A329;
	Mon,  2 Nov 2026 21:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CB31606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtfZ7k4MLVZsTL/71jzO7a7SK8fN0bToY9nQ1Zc4iwLhL7s5gyjV6RuR8CDCFdNXGF1iHjNuXYlukkXvbxzK+k1kK3BlokFRp+k8aARO+67o5wS2evqUQuoiqRFnpc9RnaJW3dCqQhz8pqh3E/e+0iKzXKKBPxH8p4JGeakgvpUo04n564PcbreGudG0O307+C2eglbdJB7uyxxEn4FW50/AcPliCa/jOAXkBjQcUgDgzQ1kWXzL47fqJg5bkHH4ih3NUzf4g2pGjtO8o8hVx8twqJroh6B/3a9JO593oij0/e2H55R8TKCw7GyO6Uga39igwEby8orP6sgwPFyNVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=2TDdyfi6VH8fbjP7+w7BLQ4KilM562SM5uE9GwjsaO8=;
 b=iKS4gWUlcC7NObfGQpTpss0YiACOXiGkHLN5lGP7LQyZkn3slm6o1iPt5KHtASKN80A9wZoc3kKOvxqfR9/BF/YosnXlE+zhnGvDZE4p89YuSID0z1VGzRkAidx3lJIHx/mXtsiBY8wiFhvdeSXaQbBmIiw2hAfYMPMiyKDnPE0fytfSBrEhzp+A84h36n8Y44+JhaP1RzpiycaAcXcEEDqZ4V2YZokBRHGf8s4XwNeODRyZe6I2QQzRmwVUVZersGygO8t51qQMrXX2SW9rWE+cB77STXA8waSdnysmBjVK5PLdetS1GYrDFwkEooJVUWvfyN7mWglxqmjkpQztKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by CWXP123MB3814.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:4c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:41:02 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 21:41:02 +0000
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
Subject: [PATCH perf-tools-next v13 01/10] perf ftrace: Handle signals, non-blocking reads and pager exits in __cmd_ftrace()
Date: Mon,  2 Nov 2026 16:40:45 -0500
Message-ID: <20261102214054.911298-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102214054.911298-1-atomlin@atomlin.com>
References: <20261102214054.911298-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0513.namprd03.prod.outlook.com
 (2603:10b6:408:131::8) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|CWXP123MB3814:EE_
X-MS-Office365-Filtering-Correlation-Id: b9832fb1-3272-436d-1044-08df3929fd9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|3023799007|6133799003|10067099003|18002099003|22082099003|261102123227099003|56012099006|5023799004|261026121527099003|261022105027099003|261026140227099003|261022075727099003|261009223027099003|261028144727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	lb37KTGMc4gKYaFgMSSNlcp1+QXQpMUJbcSklI90Lrr1K7H5TcbKeIk30vh7PuC6TIDHG/blcO1hLFN9hKjQ9OAU5RbCRKdXXMBN2rUE0B3m2zKVjNPN3sLUENfKi61xYE+NXOD96o4g3kovlcPmSAH4CcrO2l67vGfOyhTJ1GlUHnbzLc0MLUa3LMo+FUVhXmOOrZpUAvLlAlYbspml3FfFvH4QJQlfGvZkjSad7/5inC00MYQK6jAh8shWmKQAiDSfbv5H8idnP0dPiqcX8fdltofHEu2v1CHX7/JVhyRvTJOK17W95XCeHKNY68qwSYR8Ccz0hLgLtrTzV98MaWDsxVAqRfcP+GWdsTHulzR5OAEC7vOvqrgKrczKGx/0f7b3TUtJhsj6UDFNKL5V/Pq9ukNsMZnJJ8TuLthIoPR8qqhM6XmVrcicTHrOulB/HcwWEm7qjs4uxL4Zh2Q2D4a37PirP7j+SMEK+66HZxr0i73oeKUR3pIdWZthMqEwqrfDywjnuNbNcuaqK+1KoVy8mnGQ9hMsdyDKUW8sPgvDom2k7vDy5cB4fqRJ9RisrIP4B72SuKZVMkjiUtO/HIws5BMsSpnj+/HlrZcV8++jgwgMKPe5YsSazSdgU1UFZ7vf7jHjnTCir7LCsh1mJ2ywFqE9UA6Iia/WKYJ2MGA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(3023799007)(6133799003)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(5023799004)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NaoZfK/rhax/D0h2s2SyuEAIz1V3HR4Muuw1dKlrrj/OI4oaTGtiCw8G3tSK?=
 =?us-ascii?Q?EruXiw5xC7dSY3vtX1+DvP4CnC8cQ78Os2F3fPwbUpNLsa6CFbU40hguSLFd?=
 =?us-ascii?Q?XI0YdpJSMHHsUJwPuZbg/rAgL9gYJZi5rPUYYt8Rup+zC3XXrT/4FP98LEWH?=
 =?us-ascii?Q?6z+IhpkS5llwi/SYEvbiCXFrUujthkCS1FNqizAeNwACXbpZIdA8c+XvlH6m?=
 =?us-ascii?Q?9syjFQv6A++TUMRjuRUVeL7BmPUmRHHKSEtE2op7kPF8gnBFwRp0heNIXdko?=
 =?us-ascii?Q?yTaLmQiR/zqYz47n7pCHhjV9k7Z+gV3cKAW7LXoceeNp9QpnAq13RL1H4u1g?=
 =?us-ascii?Q?eni8RQj/KH2btzS+/uP+SL074w0V4ZEf/Vu1+bimtnvh4tGliyOPGaZyfgi5?=
 =?us-ascii?Q?785YIF2plOq5aTKNYTrxXUMSp1qsr6sqfY2SPQJDylQ+BP1KW211iIqOC5jC?=
 =?us-ascii?Q?S2T+OD8fD1422IBVt6hruqt/0pKRzeRjIYh9oc1i4mBLegj7uE6YzZoCgPfn?=
 =?us-ascii?Q?dW3HI31FkQcCkl74SZKWP8kPVJO51VFk8NBT/IudrFsZr2+bSAe7lJxyCZBb?=
 =?us-ascii?Q?SwU/lzdNpY2nWiA8HOamXilArr9JaMP7y4I4F0K76usUcz4HbX2e5ohFY+FM?=
 =?us-ascii?Q?VxmDtJBKfB/EikxwDrk+BdwiUtSth+wVJhINMMpVswg9rVgl/HAdKHiivPsc?=
 =?us-ascii?Q?JIWdqyyz5MDgtz+o6kYOb6dFADU4FfdPKAG/JhX0Ma0m2bNpwR9dC3o9yTiW?=
 =?us-ascii?Q?eDbSYDKxi04e15A4mdZQEFKliY4KfvHEBNOD0cPhhWjscxcRenwMjmv24Vmj?=
 =?us-ascii?Q?cTecFg3Vd0cXo3edqT0AIv4yccRWs8Zcdm9TCkIrqT8c4cAVQxtvJDVtekno?=
 =?us-ascii?Q?M9kv8Bu/QHZIoOpfkUw9+t1Q5590TFTAdSKiVajnwsrgVLrg4PhKWspqSHZq?=
 =?us-ascii?Q?zBEbAM9zS3nCUdS3778EJHNwWuA8nhYxFJBCXGYwoFJwb3HWyjLH1mgqSE3m?=
 =?us-ascii?Q?MieftDMKOSeYKjkUYt+OEWG5beGJaSRau547yCImsc+4TXiv79869Ny5cJWy?=
 =?us-ascii?Q?Gfq7g9+rtByptSEmXNOQO/YwNXLxWbKf9z1PfHmYy3WFuNfbbA1uyRWlBP6q?=
 =?us-ascii?Q?mLrAXJZSUtupKY47qWNqHn05HaaYm64UaYpcMoXQ2uymWGB40pFhmp9N3lQn?=
 =?us-ascii?Q?zphDkyzxUQAXv2nn2lFmsa2NNpDiQzsU/6smgnHJvzb+B0rbkMrNCN5t+6VX?=
 =?us-ascii?Q?Nr0frcoaVH6SMWEl6yMGoLMVWdJfRqFqO40LZ194kMvLz1b/sZkwZloogqB5?=
 =?us-ascii?Q?gH1UfpK4ij80u49LavS5ANY0TVZ7jiha48Fg/An4SGmF8L+mQ92KMFif62kB?=
 =?us-ascii?Q?07myAqJZPhB6yLaj2wk/2w5mBpyVPPCCViHG50Qg/dy+EFyIXosC4DcFuGA5?=
 =?us-ascii?Q?+ssYL395fLi9K4mvoBry5HU+pz4+dbnQQZbQorWzKhlsZvxGxdgsPKBsz+wg?=
 =?us-ascii?Q?M8+MAFGLSkoThZQMvOODqXVus9PLCIiNZmwZrklSs99RhJ+Ufe7LLSyPJm6x?=
 =?us-ascii?Q?LUSgRebznKsAZJguea306cVsbxfnxgXFCeR3Pj2BHWYkGDy4vsuEjRB4pB3t?=
 =?us-ascii?Q?rTl05Ilfz6uUZ725buGEp8FG0Bc6TgysVy4/j0/xRLcc4gx7o9cfufPKMZ8N?=
 =?us-ascii?Q?cMzWSTI17K1FTcEAZ+J4UBk9muMlWTwCa7WV9J4Dtvldg8nYRkVWuvzPDIWi?=
 =?us-ascii?Q?XvC/JdkckQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9832fb1-3272-436d-1044-08df3929fd9f
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:41:02.2973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkhDy28NUfmpOVtLhJr/JQ+Dmz8MVk5JJSiYP+uX076uwI2E5THnLatT/YVZ5qsQbr4lmDQLC60nN3A2DYTyxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3814

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
Acked-by: Namhyung Kim <namhyung@kernel.org>
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

