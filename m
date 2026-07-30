Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020107.outbound.protection.outlook.com [52.101.196.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E7C45FFD4;
	Thu, 30 Jul 2026 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437671; cv=fail; b=B1Gh9KPzyyxidsff3IOGvgANtr7LlbvLXht/7zzprW/013U+7W64b+EQNNeCGEXKHdCaMMCZ8DoF99XcJanc/tZ/QETWvRDDLz29vX1tilSzGBSDLegS85z7dUU5KowUEGr9QXscubLE2L2oUQmVk1HDLSyWgvxKCefLR1Fn/rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437671; c=relaxed/simple;
	bh=MxUrUiYuwC+yYIGKlx3tJPR4IWrA4anWX8s4eK8scik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZCp+AnyYMhaAqickXTW2aPQ6Jth9Sd7JRlsxjmlao1nPxTASuqT1+JPJo4fiMUe6TItDpjULlvJ7KM/+eAktwp9Su6eQjTaTgry/aBfqA/YoYs6PgEpX1/0W6L3UwRA+S9sAnWYqLaTKu/AO8+nfU5Do2h7y12ta/4yhweQf4ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPh34IVFuOh7OfF+7yg+mcEoKN5qRBY2xHszMrqbZhDFQoodF6F5FnBwc6AUUVMMqful3YBZRe6+PeaTZLQ0YDrS1kshxiNv+Ec4lK9BZ0TH8PKbBrNUxGXH/ycCxwFeuK+lJxp+56+3Y9qhNPdTw1zduoiR9gJwT/TZ8D7ZCOCN2Dji72F2mStign9N97Mwp9xGb0tIzsBcauFP+mD9ir+eSJgd9Ymz4sjb97wHxVXrqMU9pgmDhj7rThfkhHrdI+8fOTjTREIxwm5VQkpqA9VsiL1rKrg0bzCyT8dV5G7GOY1VHTCJzyaQCkdAaRnsHu8YWe88d4ocRRfX4Y01Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=17VUbLXesrCEmDkjsfRP7qB0/ZHrCp1udZf86iSB+iQ=;
 b=fYoq2IGKMyVu7GYacwjZOWRHoylvONSBzsUVb5LqwLUverACqYOuCMHrGV3UiTsO6PJff3nI+z+DZzk5/xkXL1VJJoyHm5auqJTFiEnGef0chHlU80XE5GLpdsrxqa3ojKng2loTdRSG0dRPYIqcUzjMlLM8Hh/xIkqpT52ROT/rkEcyV1e6YBCtFPtxc4V/7ogGFV9T8VV4HCCNH+YNDIuBj/W/yB1ji1Z4iw4D9YsEVcwJSx/E9uCpeFZnQ7C6aR3QZIKlKsEW8tudsVtKZeJhWFZHg4pGepxaKNF5QIAjQJLHCwjiEwBi7SIUg5BEZPg9jCxaMbhEBO/EXhQ2Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB3654.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 18:54:27 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 18:54:27 +0000
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
Subject: [PATCH v5 2/3] perf sched latency: Auto-scale latency and runtime display units
Date: Thu, 30 Jul 2026 14:54:15 -0400
Message-ID: <20260730185416.97166-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730185416.97166-1-atomlin@atomlin.com>
References: <20260730185416.97166-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:208:52d::26) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB3654:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e37ee6-a21e-495b-eb62-08deee6bfb46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|3023799007|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Yjl3aeQYSEV4m40jJzty+xVvqR5qbug0QymYnXBFjnNi+WZqshQJtG3IbReQMgtl59WVBOKMnu89p0wco6SZOq4zp35RGwyN8u1CPLBd34R+7NcU82eBBc+YzTiM1M95e2j39KP2XssjfKWqpAHO1QikTSBGjloab1jK7Bg1YoSr8NibJRKNk2mQ6p04ln1md0WTNuBeI3Jb8nH92AiH0hiJ/NcTEcjihiym1EiDAco/fjhl4R8ll+X2i5ROe6qCtsFYBLcJyneug0QxsRti4hqSrRChyOrBLr/b5I0UE1MFm5QBoWbB7uU3zxdigeNorKGlbfyQqh2VDZVdYzQAoKNDD2RXu4aGpPer6uPjLSc35ofKSb/GC+0hU+yvs9TiUsS0gFyRPAPhqDeFFW9xUIA5PmbZzEqDbVZOyMKmZdLtRe5QROzVKEtJa7NnAjdF13I7Gg1TOfXvUbUNj0ncUNYoAKanYmh0YY2o3zCHSsypEhRCnJho7e2w/IdwyCGvlHWZFKUCvXcpFGs0GeZTa0HG66SN9jf/aORI22aZA6tLdZlzSR95f3Hc4dWDiAV8b704EXHbLq1jg1DwzonV3MJ/JxwYlF2GvWK+24zNqe1nM6dPaHH4E5o0dDn9oRarFikVOcpcCy6D2+3SUP6iC/+/sXZb8dzDonXy3SzvSSk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(3023799007)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xd2r8WjUfdBYhMlKsBLwpuB88GCZgT4SFKFr12x1S/OtmxxJ+qmN3PNSEH3T?=
 =?us-ascii?Q?fWzis3ZXQkjgqOVbRuNYrRQnY5pkd+XvwrsrqW2Tsowu8W4JCCWjI+v9np2l?=
 =?us-ascii?Q?VKskOjlSo6ETfbhRmF8xP68XfcjtDx1DpjKyosAMS3t55NGPaI4NrnteKylF?=
 =?us-ascii?Q?MPwucxNPkyb6CyoYm7hYQ+FaUqjQbLiK20uJ4znvbeMvetEll25BpVZqdtf/?=
 =?us-ascii?Q?oKe3lKOgar6xeFwXzmrMeQHtKtBr2xwvQPXwhrwwc/4cL8dlGRmWe73+GLBr?=
 =?us-ascii?Q?2ReGl/umSe7jFFSj8bbqtSTSET/hfAelQPF8q0IQyyWehBIbrkaZt65L4f1s?=
 =?us-ascii?Q?jPWRYeirOH6V154YX0UFXTQu257Nt1ISw9gDn8zadHU6WLnzCKWKmV3E27l4?=
 =?us-ascii?Q?oJpnQNoC7es/pMTziaCB9AcJtCFiXpJgmDaJrMXH6xheccB5/Y6/RyJJPby+?=
 =?us-ascii?Q?Ka0gmvVf7HG/61XUSPmrQvuEzToEkYj9xU8NjpqsTnTP1EltPZc4GGU0Co7l?=
 =?us-ascii?Q?BecqIOT1/OdPc0CcTIdwd29MugitM9/33px8LOsYGHMBx885CsLSCU5SJn7S?=
 =?us-ascii?Q?JfCOmDEZDhwhieN1eTu0ikEXUB5FPoIeHc3FsMmqQF8MmvgOQK1OQDB1U0NX?=
 =?us-ascii?Q?mx6/qCq4c+aSsvEA69itC9VMl6J0iTmkNyTo2g3IKNcwZFWFDZwyrZDirYPC?=
 =?us-ascii?Q?ZhEJuAHCbz5rhih4T6EwmeSOvZ3WjjC7Df05nEBgsGhUxgM9wcRyOlmYpXcF?=
 =?us-ascii?Q?nz4RUxF9TwtlEPu+Zs7Mz7aPCpj3YzyhQDoTQODmPRnnS8MVd5rik8YthUCN?=
 =?us-ascii?Q?RyDOrdbaXIyJgVV0JDaNMBFRcLLGqff6QS05LdVjesofbqchRcCBQMkfxQkE?=
 =?us-ascii?Q?p/oU1quIKbVhaNSxFnTmVmV3oepxB8Q3E+9pYn8hfjNkAViIzrCALHUq+ciB?=
 =?us-ascii?Q?d4vza7UY1RP5MZ/qMcQI3/kdP7ANUKPo5R4CISwlQh30xsQyybGRdd+xRr8V?=
 =?us-ascii?Q?1+aUtMUZdw0dnU7csfJsuFRGcV2h3kyFfB7FK6EZ3o+j1Cwc/B/PGbryBxyP?=
 =?us-ascii?Q?5UW/HckvwijPmznvfNI0k1acBsC4ddH5ZxX57kXbpaCKqigMmN58DxJmClzl?=
 =?us-ascii?Q?wi/InROFya4aep3Sr146CqkgkhWDkqTThLAOFr2BO0EDJcpLLiz4N74RWTl0?=
 =?us-ascii?Q?ozpPQmimtSWcdixXLTR9xE1/RHCLoIXtPfrlFSuVHctii+dr5wFcuq6XVQxT?=
 =?us-ascii?Q?XHGTbv5DlTw8Np8flC/HYARJNpPdNicWIiT3S37mM41CVuUesAdzAM+gDGOK?=
 =?us-ascii?Q?1zlCKu5g9UGSRVroxdZoTl6awRwssmtZXlETExFSdBRZUoS+g1FyO2ZDkakP?=
 =?us-ascii?Q?ziQhaTHwo80L/Vtiexx442VJ6029ZLCYV/KynqvF4La5Z0anUdKEoqbsi4p0?=
 =?us-ascii?Q?UBqtE53TgGwVOpeMJjSHCEMeedDA1/tmA47Im3om7I6A2Nw755G9eu0yZgog?=
 =?us-ascii?Q?VatgQB1WIFf7xW08dUsFbc/SrySGjgdDbEwpQLbyNG3JkMPFxMZoHBOOQxF3?=
 =?us-ascii?Q?g1zrm7B7AFC/oSweWD2IrS8pycwwCc1gr9mx6M5YkpWiBItEuXgVx0ZRXLDA?=
 =?us-ascii?Q?X8vbk3KNpS/eQTckzs2c7yZ0/2tLNv3kNCGu3ydo9JjBI9tpyHn5pSmtgHXo?=
 =?us-ascii?Q?sJVat5w1lql7HqNkS5g2p2de1ng7dAJuYYHKUFqwzxvuze8ne1JeYdT1RUQv?=
 =?us-ascii?Q?bTDwMP6A1g=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e37ee6-a21e-495b-eb62-08deee6bfb46
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 18:54:27.9014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpVZONWcWUsaXG4Y0ef39RQpgZZw3A3e0IpU+klZHrMj1d45/umHgW/pDg7xb475A0695I4QrgyGyPzM6CKZrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3654

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

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-sched.c | 42 +++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 0abf9f1f3c2e..bfbedd12b346 100644
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
+	printf(" |%15s |%9" PRIu64 " |%16s |%16s |%20s s |%20s s |\n",
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
+	printf("\n -----------------------------------------------------------------------------------------------------------------------------------------\n");
+	printf("  Task                   |    Runtime     |  Count   |    Avg delay    |    Max delay    |      Max delay start  |     Max delay end     |\n");
+	printf(" -----------------------------------------------------------------------------------------------------------------------------------------\n");
 
 	next = rb_first_cached(&sched->sorted_atom_root);
 
@@ -3642,11 +3659,12 @@ static int perf_sched__lat(struct perf_sched *sched)
 		next = rb_next(next);
 	}
 
-	printf(" -----------------------------------------------------------------------------------------------------------------\n");
-	printf("  TOTAL:                |%11.3f ms |%9" PRIu64 " |\n",
-		(double)sched->all_runtime / NSEC_PER_MSEC, sched->all_count);
+	printf(" -----------------------------------------------------------------------------------------------------------------------------------------\n");
+	scnprintf_latency_unit(total_runtime_str, sizeof(total_runtime_str), sched->all_runtime);
+	printf("  TOTAL:                 |%15s |%9" PRIu64 " |\n",
+	       total_runtime_str, sched->all_count);
 
-	printf(" ---------------------------------------------------\n");
+	printf(" -----------------------------------------------------\n");
 
 	print_bad_events(sched);
 	printf("\n");
-- 
2.55.0

