Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.79
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792983467;
	b=MoH4QBBwDIG3kBdTs0VgzrclWEnm9LUARPIhZ1BXQRM0ZN8Jretpm4unTIln1neGpTVi
	 +pEmBra6WeCHPiSHbvLKWgomaMxQjHp14y3E0F5k+/8Im5ndrD3viqty378DGdNMUx3FT
	 R4JFfY2cb42qQBM/22ndqubMReju6UtvJJDtVv3VwxL12ZGiqsnuSj+yxm3pxPMxc4J08
	 xGbnN6X6YcO1YNxbW5CIPBKRGXj1Twq7u37kJwx4/zEE7WARIYj5F3hS4QupJJr4TvccY
	 I4ub7FUFb42QDWPUhs0NPrPkXGPI7dNYO7Bve/eYThhQ31wHJC5W/e+1utvNP3Izvng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983467;
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
	b=TlZBIqFCHbaEhfteZRshy+qywAVAvRIwHQ9+KYIs9yTijZhhDUK70/bYjrEcfnhBbKoj
	 gFqFBMAZVbmGII08GwGcc1DzmZJgpX8augKioVXPS/HMW1lyabNV/IbUW7QklZr2t90Gh
	 nHj1n9XI6RLzsDt9fjLUSNtwZcqF/ZvflCqcYvVmi5FJminUqmbi27W8nZltGqBzA+2GQ
	 V+s7lo+9rldku9V0LLV914HNXKlMTD8C5L+1t7K4fwdfJCnH/3GEpQ8Z8DRY/apT+R3ix
	 ylqbPruhshNYo2DwE1TEnBrzBdQIx1/qDDemx0oXwS1/iOmIqcIUnTVRqy0efBJAGLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.79
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021079.outbound.protection.outlook.com [52.101.100.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F9B606A31B;
	Mon, 26 Oct 2026 02:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4F9B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNKlE9tN3JUibshSacz4OEfyW3c21F1adYldTgJWlrIconWQaVG1KYZftsAf1rt5koKWEDYR9PSALgEsgbyJeztrQ+zV5Y9BKdPW2If9dBW3yfmwU+BUyi7x7TI+nxd2IiVQ9oiY8aaonVoaf+V3k4j/b8qcJ2OXRDb2eqnrt9Pzs1GgAhQv1FkyviSl0LGqwI5T24UzK3Vnc7O6PparMP6qCTyAzwt5ERlQwHDHr8baQesCv5A+o8T2WNyEPPk/n5u9YNdps79RJBRDB9Hgp1K7fTlLSyZh/E7Hg/njsACMXgTO81Gy0kJ+eoUNZvZLuDMz9NL+v7l62vA/KVwXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ZzemNGD1FqHN94h9nGTANHC6KlCsIO+x83kJATeIlCo=;
 b=lMJW78pSDAC1Dsy+wPoeMko3VrXqKnAU+vVf5hiD8+P+UkhQaKmpURH1h8BonWPN5lBZDGY51hoE/MZArAywCsFE3pTqxmVSBhq6SicsSJNjv1YzLNrEO3RnfHfs0Py2Lc0a+5v4qwLmcr92a1mqZktYAn8DScjLCq8uQBomqdWT2ZGC472IapfsZJigKYc6/wkEXDBE2o39BIPt2fASmUeOzmFLSj0gTN+9HJBwy/b7wz1Ny4dLEzDUaf7rbMpuUzaWh4ruXjPDcERDfNx1km7DYjv1imxBw87KhLxqLiqd14sBTSZJMAQVHFXrRGPI56VhenHeqE+H05pTdLKLFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB9009.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:285::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 02:57:44 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%5]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 02:57:44 +0000
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
Subject: [PATCH perf-tools-next v12 01/10] perf ftrace: Handle signals, non-blocking reads and pager exits in __cmd_ftrace()
Date: Sun, 25 Oct 2026 22:57:26 -0400
Message-ID: <20261026025735.546101-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025735.546101-1-atomlin@atomlin.com>
References: <20261026025735.546101-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:510:23d::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 117392a6-15a0-4d0c-1eb5-08df330ce878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|5023799004|56012099006|261009223027099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	WoFdwbrOdKgq303fnSsRXbgCDIqpVnufRdRYQfB/tjXASKQG0brX60UZPEsqzm7ztc7PIdZXmSEn5xgsMNb3kvJtx7eoGZdNGrJWpXx/IgiCKr9X5wEYmEb18NgawELj9bTcBkTSckhVhWfdzxeocNBQVKxeKQrCHfi2/kIo6Wet6BNqtrpUBoLbqnN0YJSQqO32BamUa7TJKjZ/vgXNe1fGgRVii6fxgmGiMDmv2fDgGTWBTMHA5PSEHhEyUejhS0s1p9i97WLk5dNYCXx7orSJ9njyREGM37KRNNVAXaUOJbiqXunHjBDjLgZl44N6IRuvUOLWfB8FHTJXC4QV7yOaFLDQo1KHCc/XVXwr0Oi3UYofjqQ31XRdR2og1cs9qR8zUolPOADfbmnyLQRMdZt0SlUPtmbdFQpCjeXZ4Lo3nVX22W10rnhbTNL2P5b6TpRWQ2yKLDJ15taMl4WZRDhpgUuxLdl2t9bQVfR68t/cJP5cLvN18rQOlP27v3vx3zp/kyiplD7l4EEl3Ujw6eX/6IyBmX8GOP7cUNZfl9gPpT1C2j5MWIi+Wsn2UbNU9H9wMus6WvOVWwGTziPCIQ6A+27nMEBFDYO03M4Khci7z2/alkKXRjya3CAFvev01imKy7NwZV7OZg0D6LX1bSs8cBlOJqep7C3Y296WxyM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(5023799004)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1CK224vZF7vCQTJPs9G6hzoIGSit5bo84WZii9YbvB7y8SZ8RUYagzrPzDpy?=
 =?us-ascii?Q?cw3d391S+TWJCALvQgDNV84WK+h6bGDYuJ7AYQPelWRYjBBFaJycLHv642D+?=
 =?us-ascii?Q?JJxFn+3v5X14HXKgtzxcH30UdU0bfyvxAVXvc4EalcGVi+7BoR5/2HlMlGJp?=
 =?us-ascii?Q?SDqLKC0HzdtUyKss2y1Gfex9GPoAp/+PIkayJemnwLz/QavC1fkoQ3+j2Tdn?=
 =?us-ascii?Q?1roVOYX6eT+cxFsFxgTOMG0BT9OVhU50n8eWtBRofEeZPsNDFN87rxwWGM4Y?=
 =?us-ascii?Q?pM/W/F16PLDK44CwJxyVeYIxZsSzOGEsXKCbydXphCoj0Sa27xwCiq0DR9zn?=
 =?us-ascii?Q?zMHIMrNOAItxzDGQur2JxuNYL8oI2oxoLtHDLlAgQECCo6l0baQOIhLakBov?=
 =?us-ascii?Q?iaxlXLC6k70cgZqY/dMBV8Rr78RLr+GLQpDexUdcxNzd2HX5F9sCFKrwxcLA?=
 =?us-ascii?Q?fjZm6B4x8OfpLT1XrUBfnVKa1KbpX5gqBUfSJaFHk05br19/D1LwEuIpa4Q5?=
 =?us-ascii?Q?ZbCkyGgaqcfPMbsR54jjNcgXbMyAtCl9ulxxwkksUbCtgvON7li7tOSe4Td0?=
 =?us-ascii?Q?WSKLOOP6KElkcK2XdJaOiltBuF9dY1OFGwiIhahofA1Rg4HF3BgoWxtvzoxV?=
 =?us-ascii?Q?fZe8CyQUwh4hQsX+hDjhVXZAY9xggQBUaI7L+DW/M5n+HhEQDeiPkdQB9HUb?=
 =?us-ascii?Q?/M/UEzqUpu4ReCclG+q7Wq4nsOmlWQZY6xNhuKIPQmy5+oFHBSAkGSEKALcH?=
 =?us-ascii?Q?kbVrCM0EUPLjte7Qz2COlk5fvkf9c+3A64docdmIyTmH48NQc8nKKlDRFb9i?=
 =?us-ascii?Q?bS2MsrL7N+2ZseMRch1KsPs/6omyoxoPMfudDjEJihlDPoQulxGWsZR9q7ur?=
 =?us-ascii?Q?WCwZQKF93AbICsLQjFfzE4kWNp5H4pfYH82sXHETasI6qggtJpSsvMOFRorj?=
 =?us-ascii?Q?Y2CCWTQkDICcODdTm945YKEv/6KTF21p9VvT4i2mo+jrPfF1lTAK1LNUaXn/?=
 =?us-ascii?Q?GkZ4oq9M6mqrWgro7u6o7ktYEdWlsSvY8LIDA7IWz6BfVVbt8+1QbDiwRre7?=
 =?us-ascii?Q?ZRRd+VPmxahbV1aA9WyX5jCGiVGxeqKqp+d4Ks8IfK+g9nHhaf/01DDCDoIB?=
 =?us-ascii?Q?PkbX6tcPhXkFMi1U4cHLf5JexVxZP+A8Tttf44WNfJMmqnIqX5IR3fzmKqIn?=
 =?us-ascii?Q?VM7RNTF1FVssPB31QDtTcpazZO1tAqDVXO1WTwXpchuYjUB4y1WG23+pySZd?=
 =?us-ascii?Q?wikN0lqFO0wH2oialbXVS7PlzZGrS88Y3ZaYZf29e7FT7DrD7s1iS1nLqX2f?=
 =?us-ascii?Q?wbLX9Ek8uDR7SlqrNRjq29PXAFkCZTxF7mfjlK8qTLkSVwe6cwG0tLqm2bR9?=
 =?us-ascii?Q?nR/GR3g6K+tBmA7ZXgNIYHxkshYG4b8M3nQiuhuDmduTVo2cEOq8i8PxqNng?=
 =?us-ascii?Q?CZXmqyrd1SKYRDXHbgPBDHh5qHnscz8zhaAsrZ17+kTTswlj2hcHIl4qdpJ8?=
 =?us-ascii?Q?Gq9Bmy7IhN8BV3oiQugx7dhuaj1QTRYzLpCfQFdgQhpvU0mLvp0tCKVH2rw/?=
 =?us-ascii?Q?JLYwlbKgoELLTCk0x0knEQZa6iVFfmzaCIgNbdZDdIFPrIlp3B4INBa8ecHb?=
 =?us-ascii?Q?gABpoCuEUdWnm9slKmjdFiK2vyJJ4muXmrrxdL39G78Mn5irGN2bHEkM+UoE?=
 =?us-ascii?Q?XJDdQAtNgJGl92T5fEea+QRMAfneq7HaVxkQrfZMSEbXzaxb//opekBBvfS8?=
 =?us-ascii?Q?qEUjWj+fRA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 117392a6-15a0-4d0c-1eb5-08df330ce878
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 02:57:44.4706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65Thq9BiNaliKFhbuI+wVyYjgc5CQD+PI4J2BOLGlOXKtHQgtvyz8C+dlV8w9YXPiJdXnW1UbexGjA9iALgORw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB9009

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

