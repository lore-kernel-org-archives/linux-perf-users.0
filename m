Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022139.outbound.protection.outlook.com [52.101.101.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9B47DF8D;
	Thu,  6 Aug 2026 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030785; cv=fail; b=BTTMmDuiyBfGnlmg0qixYCwRqC+IK4Ka0EmMftsy0YO+a8U11l8Uqly9cgop49OrnU+mykPdugoeSTpMbKRx5rXwvq8FVT7JVSo9t8wgjUOG9GTembhQJKVoZLzeFI2KvYXIE3SlUdSg0DG58c56RhEGHn0RIJa8ghF0/wsbdT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030785; c=relaxed/simple;
	bh=N+twuu3xDD/YrN7MW3UcVC64Vsdg81jVN02HYOTclu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lfdpNVOtexuwEM2MdIc6eUkv1o2oD8Y2hpahjgE8vJVkZZczdbOGF+kuTROiVbbeuA3wc9V9tn1Z5h6yi7gy9yc3LYg4k3X594+0r3bPNV69PJgEe9sP3POaEULfyWL2YITVpsXleb2BJV35EvcbCXKxLUPqjT/M4DKNSVPysD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBTp+RqSiu/KqI9WdERZiDa5MmieYhu/SnIKMfXyRaowDM/iF1WrntVtwOMq896+6LNz+xcmZfwwjAGEocU3IDodxZFAJGyykzs3NZYkDTpI0M0HpehRF0oSOu4/hU9ztSmunLC0m4Nv2bSBFWjZpILZu7PdY3KRfkdOg90VpGPDrlGS99Km+MuUWTm9ezDYWewgzWSxBpvdnv97xjPkkEycHQHkxmYceL9GAT7i3CTSPp+8xMCU9r1TwHS61o/y99up6HG7ADwfMnwu0MJNImkJP7DIOzAQVkkTdI+Pt7iC1QQPkaE0FViaidsAAB7fvD6/eYBO2DljNgLSXGAZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=/OEM5N0I435A2xRJGnheXK+ygYgVwZzT0DCQebeAqwk=;
 b=fP/uBrQc8EXa2ocKDN5lD+vAYbnH2ugIjD8H/R5Nr0X7X2LdzUlVzkhyc8Ik4pMYuVEzt6gBy870E/loyht2LYSk5TJuvU5HIuBJIchsyvcyPsnv2hevsZvk1oi6kLx1usdMz6kheyhjlIniohcIqUESndAZhxtPLmgkoJofpHadvgQaoSyweYdLFhhhyUmsMEBTawUeOIo1gwRVjcgIFyhsyXO8aalNUvPx3VVVQcEmh0Fq8DPZLKH2dlIlRISNv+1ZVfuH8M7D4UjQd8bSVYj/4m1n3jUVL1XToSPZxSyWEl24RdsbhPUjxc0u28M4wpKzmPMyLVBMX5bZGG0Inw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6694.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 15:39:40 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 15:39:40 +0000
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
Subject: [PATCH v9 3/4] perf sched latency: Auto-scale latency and runtime display units
Date: Thu,  6 Aug 2026 11:39:25 -0400
Message-ID: <20260806153926.300499-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806153926.300499-1-atomlin@atomlin.com>
References: <20260806153926.300499-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR02CA0009.namprd02.prod.outlook.com
 (2603:10b6:208:530::12) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7da1ff-558e-4819-f890-08def3d0edb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|56012099006|10067099003|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	o7574xacVCAYGrQeP16z+w/Xt1oxA4Xxr6Ry0pSRIpyqZnd3CJVp31Ue/hsX9bcPm/Y/Pgx9Pu0oLvTWqMyCLkhz7Us0P4zAarDm6F8s+ZJusiKjMtSy1JiZ3WEzlrfEyQHMfqxgkrhoANKwjunhydLLRMnnnX1zNtl1vwZSxUjDFiFsCzqD2WmXmQ++U8VUn9mM1AglmO9iGK5R+plwscBZRJJuH8wiDXt47Qkh7TDkHZpk2eMFwWna6qDwOMd7ONgUlAd3xc6SvUGr3rFKvtrD17lQsM5AbdbbCiMA3pp4jt4m4oG8A9TvIFyHR8AZVogWvA61z3dxQPzIss5CijrbpShgoaZOrTX3WuqtnpZmUSkrrMQNE8n7X5Rucmd8WpVgWUNjL8v2nKN+vRRSuUbd8nB6/4cdI3QkbZQW2HYWMbXmPwc7lU7+FnFY0oUCX6CFv3ym1c57iqKaHNPX3hPLeU5OewbNpVHkP9IV3Ufd1H7BtUtpIsQ0YkMprl4YeN/F70bToDafGv2Apxe6NLucKh45TN6SekzpXKQ6Q/0nZDzyjT2X5JrDrA2uUf8BNwINwv0LJSm5QHcfGF2lH9WoGE98CGU0/6mG33veQGcOgsWyatLjVW66F69r17xmwSjRAdYKhWA/k8vesnj3co7na2fkQ8vuHmRBEtyeba8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7J+xJAmwkM1K4yMlaBgjWZkVlxAQ9ykbNs6R5ORwLv0RadkLxUGzkm4zGAn7?=
 =?us-ascii?Q?EErChgIWnBdXnBevjAyQIWwF67PCVQ/3KvNVZB2WAUWlo53KPQAA4A8Wdrcv?=
 =?us-ascii?Q?zIZY7zqgtHnEkI/1QpmY2NGLrOdBszxpX17TkrHuRaaThXpOe0Jm8zhQuBQx?=
 =?us-ascii?Q?v4or7gIVOEjt9tbKZ7uKC9DW4yAfWFO5P0tlrMAQjUwAZihFofAuBbu0Emc7?=
 =?us-ascii?Q?U87SuVF5Tgmda5Gw55p9pz4+cLdHOoXxFJ3wKeM7vAA3vZgXai4VFh07d4xV?=
 =?us-ascii?Q?MYdCRlMOaUcNEGeqIH6dP7WmP0S5rsCc3M5d4fJErRmyss8nfZTX7nKWz4su?=
 =?us-ascii?Q?sLq2oUzo4a4AVEoYmU36u8IjonsK1ze0MhbPalXHwkDFPHm6QWe4iaYhmDXm?=
 =?us-ascii?Q?OX9Z2/xeSiXsT7l4DmPhARKJNEeh4ed6GXApzcPARX8M2hwk/XEpNNAv/JPj?=
 =?us-ascii?Q?wY33dodZwfUvtl01BN3ogUiF46PC+aOYfvTOla0gqq15XWqqh6e6yzGmtoKM?=
 =?us-ascii?Q?erLznzWM6FVDLf5oZJppdfWALGzqSD2cRKgiaB4XYtTxAGXX56/VVBflfYBE?=
 =?us-ascii?Q?E4uW5kMTHJTqPtr2Afo9crXux6qjTVRe2k18akHJjXjoLzg9q1j9AGtX3lXP?=
 =?us-ascii?Q?QaFChAqE2nrLY2z+Rh6t5M2Xan0xIgGzNYSV16Avy90KnO8pcqVLzHRIR/Nt?=
 =?us-ascii?Q?Af96lLgqaqtbRLVMPNmU4/4qr879MphqB7MfDow5GN+1m2mrL3e2aZOYj+3K?=
 =?us-ascii?Q?L6AFcyRB1NQjpXCxGR4D3AtXVobbHLduv/CMAf8rQAnR15oFZraZutycO5Lo?=
 =?us-ascii?Q?VyJP/oK/idPq5XewB85ho9ZarFnjFngS7GzlOr1XJqwAoY86t6fgqsUN9Diq?=
 =?us-ascii?Q?BcBHC2rpgaVHWyVvCjGxPpJ/lIB5wNm3xh8g6C+Bli/ih3ETIRzq8Y2PBAJc?=
 =?us-ascii?Q?kkEcAZSduU4DYLdrxrpntfpTzcGMrPtOo/e+58hwicjDibkoQha7ne4c569h?=
 =?us-ascii?Q?/cBSwxGnWI3CDHHTD0ZjDPOmWOJ94xH2NEK9pfpdjpA6rhFk27MC3Vmglgdm?=
 =?us-ascii?Q?QGIeO3cBmZ/q14AD8LDgGS6ChCs4i/bRkaAVdjkfCkmvgSaUQugmNK/SsDLN?=
 =?us-ascii?Q?a+ZGu7t4fECkdCdDSDmY7ztcZgiUd4xrM62sBKPhzMcZnHoAFInubro1RW1s?=
 =?us-ascii?Q?p9vtY4j91ILkTgo9nxZ8dGgwcT6hHzt9CMXnl6px2IJwHWD/SkEec4N9wVPT?=
 =?us-ascii?Q?RyqrQvb2um86/6WGMZwJCpSS1HzhR38vvJf+vi3fTeHORGXNC/RVH/SNGf91?=
 =?us-ascii?Q?FKP1tQSdX/JFHC9WudPxenDrzG7QQDdegSo/AWRECAjYf87Dz7umhYhREGZb?=
 =?us-ascii?Q?WLtHfI/ohk7WuIJT5e4PfofDWVs5vBGNYqsbX+VIMKv04Hn8493jYxHmrUOC?=
 =?us-ascii?Q?sjMtlnD3MTwn6qq5l+6FTbY8KcZJsAcC0FORHJ2WUvo9ZPvfI3LPU/DbSZ0o?=
 =?us-ascii?Q?apctnkn0xa7pxNnmaF4nPynRZK5UXcoIkPCWZL43H0ZMUEn/wb0JNq1ZLMD0?=
 =?us-ascii?Q?Qn+gdDmC20STtreejAHVarwgTLLC9QiVEzQBIAWd2CSZ4sc4ibaoH6zcA9V/?=
 =?us-ascii?Q?nw2jxtnuCvtgF5TEB+N4E7+8tfhXUA4+HFpMzGoR3JQk3uKAic3qQe6/m+uf?=
 =?us-ascii?Q?60etrtc9UIDbR7J4KWOnIM3YOFcAMh8fwS2vjqaY2yYhgLqWFUKw3ZJ7ys1I?=
 =?us-ascii?Q?cQcM98PiZQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7da1ff-558e-4819-f890-08def3d0edb6
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 15:39:40.1666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKVJ4b5m0WOtq5oA+CtM/AsU1loGKCt2BFdw2o81CQO2RmTsNp+Ku9ZhtRAG4qV+QZIUblAx8SBjbPccbIrK+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6694

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

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-sched.c | 46 ++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 7d4c6d6f308e..80022f869cce 100644
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
@@ -3629,6 +3645,7 @@ static int perf_sched__lat(struct perf_sched *sched)
 {
 	int rc = -1;
 	struct rb_node *next;
+	char total_runtime_str[32];
 
 	setup_pager();
 
@@ -3641,9 +3658,9 @@ static int perf_sched__lat(struct perf_sched *sched)
 	perf_sched__merge_lat(sched);
 	perf_sched__sort_lat(sched);
 
-	printf("\n -------------------------------------------------------------------------------------------------------------------------------------------\n");
-	printf("  Task                  |   Runtime ms  |  Count   | Avg delay ms    | Max delay ms    | Max delay start           | Max delay end          |\n");
-	printf(" -------------------------------------------------------------------------------------------------------------------------------------------\n");
+	printf("\n ------------------------------------------------------------------------------------------------------------------------------------------\n");
+	printf("  Task                    |    Runtime     |  Count   |    Avg delay    |    Max delay    |      Max delay start  |     Max delay end     |\n");
+	printf(" ------------------------------------------------------------------------------------------------------------------------------------------\n");
 
 	next = rb_first_cached(&sched->sorted_atom_root);
 
@@ -3655,11 +3672,12 @@ static int perf_sched__lat(struct perf_sched *sched)
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

