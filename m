Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022135.outbound.protection.outlook.com [52.101.96.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616CC36F433;
	Sat, 25 Jul 2026 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785000838; cv=fail; b=LJRTVuHVzxwXGq2+pRXLfMUMRb7+5fLZAj5sWzhfARpQPnOaViQW0SPJE40jiXvP/pUvIAaRUBO0FbGjmf7OxYuoaZXKEeMUqTW8MJ2TCfSxRr0ZV0nORNErkNalQz7s4orNp5Smw2q0BGjhva3SBrzUprtXjDBDCA4rf/UNHO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785000838; c=relaxed/simple;
	bh=Z6iY0cbmOtWKO7yeK9cCcCQFGG2TBU9+6b/1hkfxplU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q7t4EZCFpFwPbhR3q8g+rVCorMrj0sPSRn6G9Za7CWSHqdrfkeUS5iwkfU2y3twNEDKDBYqJhIsQC+bzncu9Voisz7063XyrQ408N856IztYBCbxe6NElJ1rlkynHp5bKNIapreXdSLUN4lQrsqwjqMex/OEi+Vh5+aCIzXgjL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGLoduJeO0ya7LtntMhhLnvHtxWRekIl+62WUxJ6aCEJPkwC2qutFsHhV04qRFe/VEATm3Ef3flMdmPq1xnuKpoQSUYntX8VVxYH4WFVUI/Cu+6ftEzupxAO2hAGnlrpsnVqo4Ch9NPX8zNCcB1fGxhZo9h66Ogya1UePcWLOD7Mcscnuggiu0trd/boh8/5vwKA/VZsRPUNd9hakUAkyLgcdEjyyfbZGulDtuFFVrNSTSf/7wQduT4xIBwMAgb+VKCjLVKfKXjlpDpmSFuDKWfmFcRS7ThHjBXo/j5QozaS2TJhCRXv/fIsmNfdzWpc01ilNOOGJDbRa8vY3LF0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=yST0NRf4PiOy9A35k9w64RlpKfB2QGaoOyCXXPlqHg8=;
 b=V3BlXuSTWo9PH+QBoAzAEZlOiEDu7Ln3WXvVv8NLJBfew9Zg+1gYEA7rA7VU/ZmXkeYHLcw9qzmLloGFR3nOlBIOYstk7+wUnO0pZq/Wqd7dwe3E9NKB1mwLmHa2QqQffxmyOipt/PssLG82ai/CTliW+cOWFZC/Xp70iZd3pZKs6rI+C86pl1bZyDZDPEuUOtfYwydBZDqGybQvmIhpubPB5YNvebuFYazW/Dj+2BBEBkViZQdDLmDfDBoBg4znSQ8eZvMw9zp4JYlms7GZlkEVUOv17f8LZ+MkUcvBUDeVjkjZhIF00Q1F8yJ5HJzueDZJdKnGDDYBB8NFFF82lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6915.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 17:33:53 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 17:33:53 +0000
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
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] perf sched latency: Auto-scale latency and runtime display units
Date: Sat, 25 Jul 2026 13:33:40 -0400
Message-ID: <20260725173341.679782-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260725173341.679782-1-atomlin@atomlin.com>
References: <20260725173341.679782-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0205.namprd04.prod.outlook.com
 (2603:10b6:408:e9::30) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa99b99-c8e2-4865-dc34-08deea72e58e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|6133799003|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	6NR8y0VB6E2CsFa1h1VNnQltrHdWJJvL5BUVWZUPWHfKtSrTvuqiKP58Hx0zg822/inCSgmNq1tkQ3tX44SNzv3dsV0ThdO8q5AQmNV0DN6ZODa16sn/VwYQuPiGDGK9JCJ1hjI99fcVK2dM1mVUcYKicOi9t8TalWpi6rzWc70HjiHAbeVtHt9kZxu9geFP6o5Ag2oUZQ+82purUk0g3hU8K+Bpuo7JI0Hqzxtd6pPk1JNqgDy8mqRB1m/uPnLqAXwNQ/Tj21HwzCIxoysKav7tjvuq6YAmLDdZr2t+A0O10+Y4/xDICo3YyhhZeNkpaIwrJyykrCs1ouiYPBJXK2l6lm9qEmm5zEG19dA7jAgu9KyPgcZQnvUn6xsFX7U0witQ0gGqJH/DpPOcj0KdKmEOGxiN/3k9zssNqJVMUfC/Ftlg89hvreGIFYbodc8RWU2ouCXvWH22L4vZSbKMTY0Vc8pmnRsnUquKPFS+a5tJG9ZZJ29L9oQbkqn0cQCAFTlQMwV4ZSp5N8q3YFhiZLruSrPMdh4YfDCVlkckfovaj+iryErQv1k4nIn4AmlPapnXdt2lOJHU+C03Nx+Xp7AwUZVvK0QWGfeXfIVrphlIav0Wn/KZiluE5Ag1psWePPRwpiB5Pqxsu/9J4dVHUSV6LLBlDeLG1tbjvonpSSs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G3LuKCvNdq9/p9kAGb35hMush9tjwHabMVituWzGbr0BvNrgY8Ti12QuinaH?=
 =?us-ascii?Q?QRtNoKiBZcVT9/3iROLtQVFXCBqOSXgcYkAYC0nC0wkZkcKSxftB31qz0Urt?=
 =?us-ascii?Q?OUewNXEdREOhUAoNl90ZuhIAprIkUGChTkOAm2cB1D9c7BfZq6LFBWk9gq50?=
 =?us-ascii?Q?k9glVI9+N/CSRU+CpYj/qK6cisH7q1dxBX/rD0bOVHHGjRHfEm0da3OsWF17?=
 =?us-ascii?Q?FxGg/GSd+0TtrmBQD/sf+Gjv+RpB8F1DcUNmBDB6PHYJjJLYAWtsgmZDfnHJ?=
 =?us-ascii?Q?Tg+cjWuUZxN8ZLUhd0LNvbKo/G7Y/QeaplCk5S4mFra0WXU+YsFa3+k5meR8?=
 =?us-ascii?Q?8CiZigHlZN6hTooNYW3Iv+J63lZOUqNGfMGFsVQocjvAbW5cIB9v1Rk3T3Eo?=
 =?us-ascii?Q?l6op68ICjgFDbAYht7WGG6T8lrHRxRYD1RycjofW0oc9fpD3pgiqMtvtgF61?=
 =?us-ascii?Q?EvpjDMgcsSFRqavrEsYmomoUvQ0zuLiG/Bf+REa27+55/wk5/nKPzLFQRSSV?=
 =?us-ascii?Q?UxKFrYj7vCKOFZK8SYRi8Ez9/+u+fv4Th7ZBtVMKgZpELUApZ+cSTnE078Fv?=
 =?us-ascii?Q?jMwhMaQWNqlq52deDrIRR2WqclM6yQMwHwXsR+D1cPlXjoZglbnKdPxT2D+g?=
 =?us-ascii?Q?KCvihLWwxEy6xZMQG0fegpykgIvylP22qqUG7PbHftYtX/W1rktvhmSyoMCI?=
 =?us-ascii?Q?uFFItcrYbj0VHhQoC0m/UnuXxFyvLXieTvFrcrASwaxKhQ02l0DNliz+QLxG?=
 =?us-ascii?Q?uRuqwD0k1mZ3XWAlUmhJqYJRXIXXYjo7QtI2l/2aMDRoKrFrX04GGj3clpmK?=
 =?us-ascii?Q?QWiBRK2C4v0HoeL+pyaFJIjcXREA+3QTK8WfEeodcjFjz9E3+KMI1rhsVgeg?=
 =?us-ascii?Q?hrVZONxSNkitkGsiOU2unybFB7gV9O3mJAaHNfh50pY7LP0HYX+hwWjKgcFX?=
 =?us-ascii?Q?gLsDvYPMln3q/YR0gYk9vE/fgIkCzWDWXjeWon9LDlHpjokX9o0JmwTChRIQ?=
 =?us-ascii?Q?5beT07Lbpq1wR1h1caSz8Hvi3m+AOHCMnOMHUUnNEEQDjNVkrmDAMFxynnfs?=
 =?us-ascii?Q?jnXYIiF4v4qCWPAc/Arx9xZIXXGVP3P7yBMl5mq+FICGlSgnZ0s4FmDyVsg1?=
 =?us-ascii?Q?Y4vtY7PFxMBMbUmnUr2iouhywKZOQNEKO1S1AXiV9LZkuxJLtP1zuX9fjN7d?=
 =?us-ascii?Q?Jlop8A/eeigelCai/zsVa2uquhGHb+sqHHkU+VxjgS9r41ywOGqCHbSdJd/x?=
 =?us-ascii?Q?Bw8DORNgaHrPI52mJmzuf+/3j8CAmiG42G/fbUTaVTYA6XQuN0ya1eCnwTs6?=
 =?us-ascii?Q?mquY6UUlq8ftWyz1piU5pu4ijIyaA9xD4O8JIqSVM4PaqDzi+BJnTEYDwAkb?=
 =?us-ascii?Q?Uk4M/6/hXyEzivoZDX5Zk1KptjfDOu3NTwMBh1BaY6gtFdgQXZG8XUjKk6Xy?=
 =?us-ascii?Q?RFJchBidKCs4NARP0RSGduKytyeNODrcpFmv56F8848QxIw0qWcbzPxrND40?=
 =?us-ascii?Q?pMjNGUno3Te1/K56KkHuXC1dTdha44GFPJjuFVSBZWtETO2YJr3dNZnF4Iht?=
 =?us-ascii?Q?V+flsAIcS4t2xjy/JQ+CTwz7/bjo2g8iaJ0XWvKWl121UaWjCcdYzax91Z0H?=
 =?us-ascii?Q?du7adYiBMt2uqz0rX7TyMB8Qyyc9InXNSk+bT/iIUhA5EOCAyQc2TRZxpBwC?=
 =?us-ascii?Q?sy8uljspwGtwG7J/hMBVmvzVKMoczi7GXUNLrioq8nRyMjdUQdSvnMqTWV0q?=
 =?us-ascii?Q?BA2pDDcv5g=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa99b99-c8e2-4865-dc34-08deea72e58e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 17:33:53.2689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +P9xJT2D9KNHnQmshmMlfxyACAru2jGKVaZXOam51z1nQMTIec06v2zeNNE2sE8qrf997Tuw0Sb4dLhtzFZCow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6915

Currently, 'perf sched latency' displays task runtime and delay values
exclusively in milliseconds (ms). This can be hard to read when
latencies are very small (in the microsecond or nanosecond range) or
unusually large (seconds).

Introduce auto-scaling for latency and runtime display columns. Values
are dynamically scaled and output with the most appropriate unit:
nanoseconds (ns), microseconds (us), milliseconds (ms), or seconds (s).

Additionally, rename column headers from "Runtime ms", "Avg delay ms",
and "Max delay ms" to "Runtime", "Avg delay", and "Max delay"
respectively, and adjust spacing to maintain column alignment.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-sched.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index b3cf678573e0..00ff5abb08b5 100644
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
+	printf("|%13s |%9" PRIu64 " | avg:%10s | max:%10s | max start: %12s s | max end: %12s s\n",
+	       runtime_lat,
+	       work_list->nb_atoms, avg_lat, max_lat,
+	       max_lat_start, max_lat_end);
+
 }
 
 static int pid_cmp(struct work_atoms *l, struct work_atoms *r)
@@ -3599,6 +3615,7 @@ static int perf_sched__lat(struct perf_sched *sched)
 {
 	int rc = -1;
 	struct rb_node *next;
+	char total_runtime_str[32];
 
 	setup_pager();
 
@@ -3612,7 +3629,7 @@ static int perf_sched__lat(struct perf_sched *sched)
 	perf_sched__sort_lat(sched);
 
 	printf("\n -------------------------------------------------------------------------------------------------------------------------------------------\n");
-	printf("  Task                  |   Runtime ms  |  Count   | Avg delay ms    | Max delay ms    | Max delay start           | Max delay end          |\n");
+	printf("  Task                  |   Runtime     |  Count   | Avg delay       | Max delay       | Max delay start           | Max delay end          |\n");
 	printf(" -------------------------------------------------------------------------------------------------------------------------------------------\n");
 
 	next = rb_first_cached(&sched->sorted_atom_root);
@@ -3626,8 +3643,9 @@ static int perf_sched__lat(struct perf_sched *sched)
 	}
 
 	printf(" -----------------------------------------------------------------------------------------------------------------\n");
-	printf("  TOTAL:                |%11.3f ms |%9" PRIu64 " |\n",
-		(double)sched->all_runtime / NSEC_PER_MSEC, sched->all_count);
+	scnprintf_latency_unit(total_runtime_str, sizeof(total_runtime_str), sched->all_runtime);
+	printf("  TOTAL:                |%13s |%9" PRIu64 " |\n",
+	       total_runtime_str, sched->all_count);
 
 	printf(" ---------------------------------------------------\n");
 
-- 
2.54.0

