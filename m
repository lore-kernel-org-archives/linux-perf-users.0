Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022096.outbound.protection.outlook.com [52.101.101.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9DF480DD3;
	Wed,  5 Aug 2026 21:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964095; cv=fail; b=Cyy1iHTcVOf/g1pRcP2DmR4HtFCfdNibArnyaIIonSsSH3cHc9IzGqj9mhqBUmZ1gBLwNDid4RDhim09eUGROCS0vCLYzqcX94+F6I27RHC4lrS0ddn4CPZ2M80x5fBE+6nY98/0Sq+sU0PcuryhHvkzFvpu52D1CJeOj+uWkQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964095; c=relaxed/simple;
	bh=sgt48lHSmueGH4i7hdyU6py843/XCDUoXd8HA3AZiVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ifD5C6ZQQQmaljd5JWXopv/Q2jGqXvGrQKxndPKfd40YBF6rBZ+G1YDnsEl2KZH4MDEUPIcFaNK9JbCcTqSj4rg4wDxMlb1wlOJ/uPfiwlhw/bcR+XoRSM7PhAtZRFZsF+DLDt6Z1nXhskpTJdbl2WQHmAuP8oI0npnbna3HhI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVYO9uur8p92T86tC5+3U415CGG/E28mvsUWWzzwIU1e9AOEZ3qx7UiDsaZ34vV0jkGj/J4cO4RXR/0aub6g4HJ/W4/q7EsXGLx0GC4HnygmTfehp3pscemEBi66syB0zY4uGFMKmNg7hM7fb2ua8Mlxu5YOnk+5Zx93c02UBwbK37l5r9Gfmux4wtxz1dF8PZgTHn10XrJmwqETR3E2AM/bGS2zQm/Njj/jXWnJBZMZcO+nRXeOt5rGZCR/eqjmBINFBrVkamHGd71c8iUGHDFqKArLcAD/YTn+n8ij8Zfbb0l/RgRnmIDC/8QBgsgLpEpXBNnhP3KYGoEVBywuCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=92oib6K7v5vIyCJpGjg6KslpYIVWXLE2BfamGy27VEA=;
 b=sequpfT82K+TPkNXt8jF+3e43auSd+CSmdnvQj5xu5xV1tOVbrxHvKCpLoMYwDQ2+SpWNPr2sF61jJu30QgaYgEAbH/50t677GX48c4ljiJ1HaqbOM+bDTdc4XMrAkO8OvqQAdfFaYP14gSFnidbdJ1mGkPXz5G+kD6ZfQHD6+mfKmxe2rko0QucPwU+JDcLG+d7EAtUiq+G3MSLB/Fix9k+X++pM6W4ZC788eFjzbyH/BX9QjvCfjoQ38VJfbqun1Zf6DyaamSzrAaMpO790201saK+AUOrdFgnRkOuD4ZSkMXRVu6KN4SWM78e7WCVPUMScdtpQbrAJrXRnC9/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOAP123MB8157.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:437::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 21:08:07 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 21:08:07 +0000
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
	james.clark@linaro.org,
	howardchu95@gmail.com,
	atomlin@atomlin.com,
	neelx@suse.com,
	chjohnst@mail.com,
	sean@ashe.io,
	steve@abita.co,
	rishil1999@outlook.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/4] perf sched latency: Auto-scale latency and runtime display units
Date: Wed,  5 Aug 2026 17:07:50 -0400
Message-ID: <20260805210751.287746-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805210751.287746-1-atomlin@atomlin.com>
References: <20260805210751.287746-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:208:23d::34) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOAP123MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: 097d1f3c-67e4-494c-f193-08def335a5b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|56012099006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	md01eYUCPeoX5jTJe4eGLO1jn4dSA6TaVlMLBgKCIAGAQnCElIfvLI/7RviM/UOQKihuL3LAi0c119JGps7I3qYWk8iS/hzXWui6Q3UWN7LqTu8UZ6gB7slcdPMz1Gst2Ejpg9us5qyjqON8jIUI9uI61E5SATDV6/nUwcAyD/Q8iqrXqEhAw8AF04R4lRQhoxwYq1pu4WtVAaijRLaRXiRtCgg5wAEr3sbXVxas63/OKgCYldlM5Ap758gZPSRLGB80E7/tKgFLv9opqz5Bjq7U2bZaz/3xzgb6fWh8mVfA36HVYX/edqEQY9cy0QPLXn2ztUWAQwabB6weieOf6QMptfvHBqAYaveC5UPddJjhwsOYOPkq9ez6/fPSRNXUXVyWuud+vu/pl26Gsmg8fIpcnpeRP5OdUOCTt67PoHQn1VgxH7t+j5ISfaNFdO8pSGdEuLutVhrTBWqrJf4kCktjkdqepJMcATxSr2dwdS4is9U6X1BTMDCLFYPmcPpaNRqedZRJzNLv4UJJs2XR3J4iQEwG+z+g3KC6ldNLgo8LaqC2BfC5xz3o+jSDorqWoNPfetGa1Dsgq+UtP5UHaZiR/8jYvK9MFs93o2jrkrbxKPhi/VZojSOmZFfbeK7VY7HZlulxSkF8Uv/P9kzOawR8TkH2hYA4T9hqScK2ZYk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?smi45NDIZFy/pY6lw/FDb8Hd8Ry7MM/Kcy6n0MtMnScxyr14n6TZNVlbBPwk?=
 =?us-ascii?Q?s1tk6H6BPfgvj/Jq+36JNA0ZNh1PpqgHkSO7Q5leX8obP0fyWAaUe+FM5KQ9?=
 =?us-ascii?Q?A/eZurdvHYuXaD8cjcK7GA5HXFMi1lt2FAB3Rm/VNvkHB/luXJle7N4bA785?=
 =?us-ascii?Q?wwjDkc4+8XXHcX2xsCjiRpcfQAaITCEHWKhcCqhsclrR1iHhtTRHa/kPzmEE?=
 =?us-ascii?Q?TT2sHKqmjk2w5LTCh5829q1aI71+YTxrL54s33M/ukuIT+oMYWfkN4u/0wkq?=
 =?us-ascii?Q?wfJRyMQzqSsqKKkxmZTeGwmSSAhw5GOGrZn+5wOAP1Aks1SoaNfCLOe1yHxc?=
 =?us-ascii?Q?kLkNGdZ9NH8sfssJNxUlU5JBUGBzMoExVkVgPIxQmGjEWt931XjBWf/2nrqq?=
 =?us-ascii?Q?0KZPU+jTrvlnnXKvmuofymVKrIFyfqLFF1VMGzANGOFU+8ki3j3+N+/+7dQ2?=
 =?us-ascii?Q?1FaQd0yvpRSQXY9SKi2dWLVi+wLxEbTm2kNFAkCuYrOFQ1D98oA6ejEYTn5B?=
 =?us-ascii?Q?oD+WPtZDJvXe2berwUt/geU4hpmP5AvHrBpmfrG6UlPmA+x8rjkZUR5ms2tR?=
 =?us-ascii?Q?xmRubjYabhjpL6h3DUXQVNGAalVrhL5Su4hhxUrHcbbizpl9fA6H38ZJf6nf?=
 =?us-ascii?Q?fxC9OgeKibKhLxfcnUuML6US1loRhNFVjp6dO8Fgenya1OA/XCloi7shMJzK?=
 =?us-ascii?Q?I6C9thaw1IJa7OMFvlp248E4E5VQlDqJsz4/qR+uLMbgOHMsuN3RX+CAWaOs?=
 =?us-ascii?Q?55Gl+GMNzCqBUtXNjmcob7R/P0ZHtwCQ+XRO/LOlcSunmVPVjEbkOBmDljNw?=
 =?us-ascii?Q?lzr+/fwUXJun+Xjj5mAvfv+9NiztMmdjmNfMoOC72oR6O5Rg/r3RNLb1z6S0?=
 =?us-ascii?Q?mYWyDdZZTUNDoMvPdjNsNJidG9trWDWNkQ9t1cNolH0HzD95j2/usxhVZsGl?=
 =?us-ascii?Q?g5n8AaNY4RBhkaW+p5qaggCGpXeFgbYtXgt2vPQKbymtB2uT88K9o7Q9Jcd6?=
 =?us-ascii?Q?Cd7/5kE6hxiRk6S/VAVM96dRgLole8PT79FEIVqClWpfZutyC6oc9Blgb9cP?=
 =?us-ascii?Q?Q2+bFTprt/RKZ4u1VTOFnJRefSsi8CED1LNH8S8g/FFctJoqV1fZIXLfiOiw?=
 =?us-ascii?Q?FMHCiItOAwG+DZd3tPfaVAvN3ixjsf4Ll4c0IAxX9hOslsuuLKaPSH860vpd?=
 =?us-ascii?Q?X0NH8WT2BTPe+GNAT+yspIUMQw5TtSRK2bySTAax1NPpFt8yw5NK3cx95V6L?=
 =?us-ascii?Q?R6O5cbB3UC3nyfvkx4cTaQhZrAv7GXSAAzEIgG67l9UXfuMoJc0PswX6krVe?=
 =?us-ascii?Q?3jnlj8fcJsct8p3WXZpSXDw+sK8dIq6vMUU2DzuPrZDNeOed4P/NpptZhan9?=
 =?us-ascii?Q?0sDFh7Lfok1GMZWB78lHg018rCigkXo83llJPPspZQooamNmnKRuC/bLzO5E?=
 =?us-ascii?Q?USfBD3TLYpj5AswIyBo0WbQO7hHLKWNLyu0DIojVbTaR1mrVKXw/3lxsRC/D?=
 =?us-ascii?Q?fvdwwU5pUkWSzNxamD4H/fO9Z6IeXnj+ElXeqQqVwcsS5mV4dQgXFA8EJwQd?=
 =?us-ascii?Q?x5lcPLuWipUq9q9XxTjf1nI2Sj/rmhFtiUtblUzn7WR4ySBUXBmtwGvH894l?=
 =?us-ascii?Q?4L4y+P/46gGCuDAt5m0PPLXCwXuWhKPN2EPg+lbI/HbZ0i0ovHysyWfTCdMk?=
 =?us-ascii?Q?6/GmXGK01FAzBWau0wRA8477gIz3Sg9RQ8/skTysaz4Hdl6iHNGlQVC1rniX?=
 =?us-ascii?Q?4ZfzK6KbXQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097d1f3c-67e4-494c-f193-08def335a5b5
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 21:08:07.3642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoaRYtXhk18NGufRJf6sqPZ1kjQndwcB+Blx8CcMIQ4pjNvM8e3cW55jEctvqEAa3Bbv6mA7TgN9222SruLryQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8157

Currently, 'perf sched latency' displays task runtime and delay values
exclusively in milliseconds (ms). This can be hard to read when
latencies are very small (in the microsecond or nanosecond range) or
unusually large (seconds).

Introduce auto-scaling for latency and runtime display columns. Values
are dynamically scaled and output with the most appropriate unit:
nanoseconds (ns), microseconds (us), milliseconds (ms), or seconds (s).

Additionally, rename column headers from "Runtime ms", "Avg delay ms",
and "Max delay ms" to "Runtime", "Avg delay", and "Max delay"
respectively, adjust spacing to maintain column alignment and stripe
redundant prefix strings from each row's format string to produce a
clean, tabular output.

For illustrative purposes, a comparison of the latency table header
before and after this change is shown below:

Before:
 -------------------------------------------------------------------------------------------------------------------------------------------
  Task                  |   Runtime ms  |  Count   | Avg delay ms    | Max delay ms    | Max delay start           | Max delay end          |
 -------------------------------------------------------------------------------------------------------------------------------------------
  kworker/2:2-mm_:154757 |      0.033 ms |        1 | avg:   0.829 ms | max:   0.829 ms | max start: 169486.543205 s | max end: 169486.544034 s

After:
 ------------------------------------------------------------------------------------------------------------------------------------------
  Task                    |    Runtime     |  Count   |    Avg delay    |    Max delay    |      Max delay start  |     Max delay end     |
 ------------------------------------------------------------------------------------------------------------------------------------------
  kworker/2:2-mm_:154757  |      32.873 us |        1 |      829.347 us |      829.347 us |       169486.543205 s |       169486.544034 s |

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-sched.c | 46 ++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index d6b4412045e2..18282ab669e3 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -246,6 +246,17 @@ struct perf_sched {
 	struct perf_data *data;
 };
 
+static int scnprintf_latency_unit(char *buf, size_t size, u64 nsecs)
+{
+	if (nsecs < 1000)
+		return scnprintf(buf, size, "%6" PRIu64 " ns", nsecs);
+	if (nsecs < NSEC_PER_MSEC)
+		return scnprintf(buf, size, "%6.3f us", (double)nsecs / NSEC_PER_USEC);
+	if (nsecs < NSEC_PER_SEC)
+		return scnprintf(buf, size, "%6.3f ms", (double)nsecs / NSEC_PER_MSEC);
+	return scnprintf(buf, size, "%6.3f s ", (double)nsecs / NSEC_PER_SEC);
+}
+
 /* per thread run time data */
 struct thread_runtime {
 	u64 last_time;      /* time of previous sched in/out event */
@@ -1405,6 +1416,8 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
 	int i;
 	int ret;
 	u64 avg;
+	char runtime_lat[32];
+	char avg_lat[32], max_lat[32];
 	char max_lat_start[32], max_lat_end[32];
 
 	if (!work_list->nb_atoms)
@@ -1419,10 +1432,10 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
 	sched->all_count   += work_list->nb_atoms;
 
 	if (work_list->num_merged > 1) {
-		ret = printf("  %s:(%d) ", thread__comm_str(work_list->thread),
+		ret = printf("  %s:(%d)", thread__comm_str(work_list->thread),
 			     work_list->num_merged);
 	} else {
-		ret = printf("  %s:%d ", thread__comm_str(work_list->thread),
+		ret = printf("  %s:%d", thread__comm_str(work_list->thread),
 			     thread__tid(work_list->thread));
 	}
 
@@ -1430,14 +1443,17 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
 		printf(" ");
 
 	avg = work_list->total_lat / work_list->nb_atoms;
+	scnprintf_latency_unit(runtime_lat, sizeof(runtime_lat), work_list->total_runtime);
+	scnprintf_latency_unit(avg_lat, sizeof(avg_lat), avg);
+	scnprintf_latency_unit(max_lat, sizeof(max_lat), work_list->max_lat);
 	timestamp__scnprintf_usec(work_list->max_lat_start, max_lat_start, sizeof(max_lat_start));
 	timestamp__scnprintf_usec(work_list->max_lat_end, max_lat_end, sizeof(max_lat_end));
 
-	printf("|%11.3f ms |%9" PRIu64 " | avg:%8.3f ms | max:%8.3f ms | max start: %12s s | max end: %12s s\n",
-	      (double)work_list->total_runtime / NSEC_PER_MSEC,
-		 work_list->nb_atoms, (double)avg / NSEC_PER_MSEC,
-		 (double)work_list->max_lat / NSEC_PER_MSEC,
-		 max_lat_start, max_lat_end);
+	printf("  |%15s |%9" PRIu64 " |%16s |%16s |%20s s |%20s s |\n",
+	       runtime_lat,
+	       work_list->nb_atoms, avg_lat, max_lat,
+	       max_lat_start, max_lat_end);
+
 }
 
 static int pid_cmp(struct work_atoms *l, struct work_atoms *r)
@@ -3625,6 +3641,7 @@ static int perf_sched__lat(struct perf_sched *sched)
 {
 	int rc = -1;
 	struct rb_node *next;
+	char total_runtime_str[32];
 
 	setup_pager();
 
@@ -3637,9 +3654,9 @@ static int perf_sched__lat(struct perf_sched *sched)
 	perf_sched__merge_lat(sched);
 	perf_sched__sort_lat(sched);
 
-	printf("\n -------------------------------------------------------------------------------------------------------------------------------------------\n");
-	printf("  Task                  |   Runtime ms  |  Count   | Avg delay ms    | Max delay ms    | Max delay start           | Max delay end          |\n");
-	printf(" -------------------------------------------------------------------------------------------------------------------------------------------\n");
+	printf("\n ------------------------------------------------------------------------------------------------------------------------------------------\n");
+	printf("  Task                    |    Runtime     |  Count   |    Avg delay    |    Max delay    |      Max delay start  |     Max delay end     |\n");
+	printf(" ------------------------------------------------------------------------------------------------------------------------------------------\n");
 
 	next = rb_first_cached(&sched->sorted_atom_root);
 
@@ -3651,11 +3668,12 @@ static int perf_sched__lat(struct perf_sched *sched)
 		next = rb_next(next);
 	}
 
-	printf(" -----------------------------------------------------------------------------------------------------------------\n");
-	printf("  TOTAL:                |%11.3f ms |%9" PRIu64 " |\n",
-		(double)sched->all_runtime / NSEC_PER_MSEC, sched->all_count);
+	printf(" ------------------------------------------------------------------------------------------------------------------------------------------\n");
+	scnprintf_latency_unit(total_runtime_str, sizeof(total_runtime_str), sched->all_runtime);
+	printf("  TOTAL:                  |%15s |%9" PRIu64 " |\n",
+	       total_runtime_str, sched->all_count);
 
-	printf(" ---------------------------------------------------\n");
+	printf(" ------------------------------------------------------\n");
 
 	print_bad_events(sched);
 	printf("\n");
-- 
2.55.0

