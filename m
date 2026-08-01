Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022107.outbound.protection.outlook.com [52.101.101.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26E23CC9EA;
	Sat,  1 Aug 2026 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785627625; cv=fail; b=QavSHjPDlcLDnRSvoc4dxzWmL2YPbJJjTq8kdWMTB6LeDKYLXLX8QvByDq2oXcgPBCQ735jK4m6efwCuvmz19ng9KOsNiEeWx570SN/Hnw4I16w5QOwHnsy1cWUOosiM/afK5R7+vEsXyxxcoshr7+zBUz9wm1HeCxAOXLUAuHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785627625; c=relaxed/simple;
	bh=YztxJYvHtbHQDFmcE9BrtyZjbGsQPvvbUOz16STi8jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cq6i8kkA+DC6JJAJ2a6ImkDACrt6qKULGZAIG/fvPDJPoYHykbnOb5yBL/jfwraJmyFOKVNTi+jjdTE7sAAazXeIfmMfD2+6z/jYWoBRtGpMAOnkXP16Ul4Hb1WHxQq5sL12tR12RHKlpg0kg4M8rl74x3Rl8X6mf3sXS74I96Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSoe1sbVb+tA10BHw5vwsf8LnquY8MGGjpoCntCq5jajvZxoNah4onwBluqlu55RJxBUUCDoaWofJvIk6g8s/QLuDZxLI32P/zvYGtIcGMT3xfGIQO0u9Ol4jJVV6UST/hENH+GuAHX21QTvW58oGq0A7cU9XwZFOayn+2C2hGl/ldlSwMUkkqCqfeCBNg3OSB9LZgtcJPlfr3V7m0qiVxZmBilfqzgq5pImxAo/Bhy3oehkSmgN5eZ/7DpJz5L9cbraRftSZH88sfZyqta1vgR30P//UoyB9+JSzBLBjh1+7QkR1hSa1RC+Ig0ifKIoBbhR5XAdYv0lHLleWCErEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=+eI2q0UxGTRJoavhB/NzOjj7233ymFUnEgXl/S3qPVU=;
 b=nm6DFLaBRJy/1rP0ulC4XpMWsKmQ9U0LJ/NilFKTzGX7zXvLIdEadkHtNHc9kak4J/aToIo2KvLar2jWOXb0fvLL16LVn3OdC/0H/JX6707QPt9lSx2Hch9/ZWsUFuI3FnbFnkLp4y17jvv1HehNe7yQh5Aa5dVOvl2AcKiV1Ibm6ihikuZTvaEky2R/4y922SsX31FbmM86ef+K93jo0YH0tTqamzDZxhD5uNG4uzoKOnn6w1xELUnq/3A5rwiV/G6VRXRiUR2lP2qcnSQoEeG7xC/WGl2fNqgghTBSFSs8ShR3FLJ5kkByNBupldfStyrPnphtPPzLm1NS8zQBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOBP123MB8812.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:480::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sat, 1 Aug
 2026 23:40:22 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.016; Sat, 1 Aug 2026
 23:40:22 +0000
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
Subject: [PATCH v6 3/4] perf sched latency: Auto-scale latency and runtime display units
Date: Sat,  1 Aug 2026 19:40:07 -0400
Message-ID: <20260801234008.176724-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801234008.176724-1-atomlin@atomlin.com>
References: <20260801234008.176724-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0414.namprd03.prod.outlook.com
 (2603:10b6:408:111::29) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOBP123MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: ba9d4e9a-2a48-4aec-aa7e-08def0264146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|22082099003|3023799007|6133799003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	cnR6ZqnGS+seROXidnYYeg9MMaE/2/MZJ+23tlqhTpGgZDsBADYVhaGOZ6PSj3TyxmONxLGVH9piMCnwQ2Eie/qdogqvAEPNNCgSw3nlOKpAncQe9IOLwHtSI+lxrWFFrMrOBVR2OUDtpTYNAMXy57P7xcjbSlWe6fpW3S/uUhf7/D1rJySwlBx55KOH5supoj8YUD4NJd2NeA2+hzGPJenan9BvBdVVRY/dK9sUVWbyYolf5gqDAZN2bgQ0scaEK4+1G9KOVoL2vveGnnad94JsphKnC9rHUe4gYsfltwJ/c+evUzwN8p9DhTtV4TDqhI2tK343vglbI1fsXCsp6SpXXgPFxFg/6vsonKB1+DG6OZxdr8HGsmrhIHJd5FiU0tW3iuPIRRxlPfgfIRRy4dgcd6keV7jdfqUocFDof+n/wVhdcjl3Ap9w+/Dw+/7Y/dHJy+1x4eQ6Wqr//bsMtl288b7ELJOT/UWSmKstp7JR0QG/0IgyZQbwWe0KsjjBRmJi66UyaTdOKbtE3qwKo7MBkii6zmyhV5XzbbulHu8phN6k368A14hyZcp8NRXVy1BBs0fJuuoC7RG0hEw0//Y1sWT9lDEmhA8LPrE2jx4ePbn/nvnJ93Bu9SI5lPRbKE7ayEVoMEM9KjMsvgWpf1/XDOVkgxf9/uWug9qTp7w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(3023799007)(6133799003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nGJ+KITR4gZqbFp5fnT0uan1GzTRwo+AdVDMHgss4NKhgi+Xtr5jETykemV3?=
 =?us-ascii?Q?ysIvbzjwMzqZJ2eGORV1+nbd/kX5BWK58KwYuaN132AdsBTL/uLrLcPHcGbM?=
 =?us-ascii?Q?lR8TP2IGRNx3YNmUfKVGXqxEFxuPih0dUl8I7SO0F1mISKpnArWqstJCuDmW?=
 =?us-ascii?Q?VBagk2KIVh8VEW6CtdC1qgdG8yM9joi5g6wC9d1C9sS++fCBRLhNITjFSNQW?=
 =?us-ascii?Q?0OgD8yJvaqu+Y303CJ/igz6RJmjUiR1K+mKeh0qcewCqT9VhaOJjh4lRP7uc?=
 =?us-ascii?Q?yAkHnjpxtrKoipggeLum4Y3NtUcYRT/u6SUb+QpWu9DwY+PIaW7bd21js602?=
 =?us-ascii?Q?fMpx6lGXyESUAA+/vYImmxs9EGC2N8i+HSAAC7D4Fw0SWlKHG6xSjWT7KvZK?=
 =?us-ascii?Q?kd9VPDgf5IXeKTEw2Q4Skty1K9QihMHIwYW5igAZasUL6HZEmvhjsVxJwHp6?=
 =?us-ascii?Q?dJPaSY3gyJa0mXlz5tncychYXxetoFPtlBahe4co9ORSTKVmNK0DoKI2ZWb/?=
 =?us-ascii?Q?tHum2P7/YLLG8Iir8iBhkUm9yOHoGvfy/ATd9qZT24q5KYzGosbPVGFdNj8n?=
 =?us-ascii?Q?4kcW4m6oy7Kk5tpr9eWmJz6A9rKGAQkxKlOl8e3wR0VzZW5+YfYeyPoHSGFo?=
 =?us-ascii?Q?9Ch/8AJtczwGYN/AXbrI3Euul/4mof+0hkYBUTGbCTmxS0u11HJsc23sEJPL?=
 =?us-ascii?Q?tDAgaiS9RyrNmm5h+C5Ub2lNtIP7xoB4rGMa84b9qR0axSmrl0TezkVpIcuJ?=
 =?us-ascii?Q?LOzOmHAB8G5wltAWM+sMoCyNYb+XEXadjcIEisv93lEU1YPl/HSuFs4vLk9K?=
 =?us-ascii?Q?jLJdnxmy3qsUb70nBi+uN+VM32D0zFH7LJjBdBdy/QqpC5a67e16UwwOkr4g?=
 =?us-ascii?Q?+kMeVvZukwwEkLq5sOamP8Ury5nGTU0tfPEO78VRnl/Zv0IzQ872v67mU83X?=
 =?us-ascii?Q?mqOwX6+tPn5FOOHWIkQB1u4fcxWvQds7DvxArc3v5EfbS8AzPbrV3Ma5PGzd?=
 =?us-ascii?Q?m4ci5pWjhil2+uEI28ZatPOs/2fwuKnsZZh57LKc+xdmv/DOOgFZxjTPDZlh?=
 =?us-ascii?Q?s/igTirk3LSpBeTLPXm4GKRP6NxXZhujHzkSsg8ggzYnhmxIjeHpuuxg3LPF?=
 =?us-ascii?Q?G974aF9nJZFiLIxveej/q1QdekPw4pwiZOdGRlJ2owuk/ztNvtw/rRHUxt0l?=
 =?us-ascii?Q?fkL6X9Y6nf6ECk2s5Mr+RtaBrQCv0BOrIu0u2q2NhnTmidChZB+qjsePLTg4?=
 =?us-ascii?Q?6JkhBsqbOpag+/UqsTweziEGWZt2pjb9dd5FBn+i1IyISLCCsEhNlV2z051O?=
 =?us-ascii?Q?hubENl3uvqcyUq0HZHXiDdxBbGK2zX+F17mPbehkyecf2DgcoyDNIwSLajwp?=
 =?us-ascii?Q?Tlqf/CTF/iksRckH0Uet4TCjfe0DADaAWNTcMKUCwWcIGM9crrEJ3w0jj/4z?=
 =?us-ascii?Q?db+J1bbG0EGWoUxJOeLaUWpg9ogpjYNS5Yiwm9YeUesbAh1a6s87ENXgsFDZ?=
 =?us-ascii?Q?Dxx5/suGSQWFHYVROh5Rlasocau4EK+hrpYmWSbsWj5o6dcxgN1F81J0/CFz?=
 =?us-ascii?Q?wYnYrr2/S3eZlaOV1kyWZdD7Ra8bj0Iq72djzEo5j1WWSHj9xDbWrZUP3qTc?=
 =?us-ascii?Q?40bkR4U0PFpNWKVC3Qa3nv+DIns+cYrma6oJYlpnRPl8Ey6sfh43iulGfSru?=
 =?us-ascii?Q?VUcCFHMslgu3SFuYwpR/JLfi6k6cGk5jy/NyNfPth8rHlwmcAh5j5S4SPOWZ?=
 =?us-ascii?Q?K3xtJ/8Szw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9d4e9a-2a48-4aec-aa7e-08def0264146
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 23:40:22.8538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g12zJjMhPiI/+q0QonkZNhKv4rAkjaYuQXGZCoGbiT6nzVYW6HmDugTYn14hFwS/IjDcvSDIlPhGshyZ6ko7Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8812

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
index 0abf9f1f3c2e..38f701b65110 100644
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
@@ -3616,6 +3632,7 @@ static int perf_sched__lat(struct perf_sched *sched)
 {
 	int rc = -1;
 	struct rb_node *next;
+	char total_runtime_str[32];
 
 	setup_pager();
 
@@ -3628,9 +3645,9 @@ static int perf_sched__lat(struct perf_sched *sched)
 	perf_sched__merge_lat(sched);
 	perf_sched__sort_lat(sched);
 
-	printf("\n -------------------------------------------------------------------------------------------------------------------------------------------\n");
-	printf("  Task                  |   Runtime ms  |  Count   | Avg delay ms    | Max delay ms    | Max delay start           | Max delay end          |\n");
-	printf(" -------------------------------------------------------------------------------------------------------------------------------------------\n");
+	printf("\n ------------------------------------------------------------------------------------------------------------------------------------------\n");
+	printf("  Task                    |    Runtime     |  Count   |    Avg delay    |    Max delay    |      Max delay start  |     Max delay end     |\n");
+	printf(" ------------------------------------------------------------------------------------------------------------------------------------------\n");
 
 	next = rb_first_cached(&sched->sorted_atom_root);
 
@@ -3642,11 +3659,12 @@ static int perf_sched__lat(struct perf_sched *sched)
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

