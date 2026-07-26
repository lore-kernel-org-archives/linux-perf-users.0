Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021084.outbound.protection.outlook.com [52.101.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC07318E02A;
	Sun, 26 Jul 2026 03:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785036349; cv=fail; b=AtF4+GedrNCdPMdGrwc+wV3QQoHYZeKkR0qw/YYLGsnu6G+y2Pniab7Gp4uAHjOFbMPTJ48fbeRrJpLbFIDe4sBO1RDvOMBIm1n6OlYb+ui09yG0Q7OLoLYm9t/U0KLReHmgssagEuKOiaP6u8954mLqg3VNwR/upuqVVZuc6Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785036349; c=relaxed/simple;
	bh=grpfVVjVqBQXlpx1Ndx1acIWr176x+4ngiyUKCDX/MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gN2T2yBzvex0QbSj2jpqjCwH+LRIdw/VrouohSi3Tt/OPDK7eqaaIV4JuAaCefqA2EP4I2Aad6anLrAaFDZU0vsOn7IwD/RbijxV9hMtWjbLgRzx1Lo0lkXKhd9xuGZAergzdlGMH+TuvHtHch8ZyLflNN3Rd/jMFSjLCMyBO5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fw9ySiBYhorRKoLBFy8g9H0RtxcGS7mr0PzkSjxrZM47afABU8b3q/Z3qKs4tpFUFtrn8E1Fzh1R7WY3FnvXGvzWHTXG9nSad3Zx6kSqJ2432H3oiv2mYwSn+ItToI7jYoyr0bB/MiFgyw9T5h3VZw8Zwz78TF76Nk5QBRAULi/kDty9pHYNgNmavS6+dwhsY5u0MecWgfJxZtE5OZBMuj6tAjB4jcsYPKvTBboAL1R5lMyqOIKCNLzPtmUmEEMiJXsOwW7KbO1rozWvGH4OBkhhkgN+a3lcDJLyhgB5mrgGmG6csznvVBkxr+7TtJsEoZB2rWs0CFqnITCAMTWSyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=1HNOw6WcfX5s1gYgMn3hlPRux7mIViF6cqMIntvYHRY=;
 b=mxTXKWYRaU25DKfi2d/8epsSPEWCCYYPUUmhbfy1Z0OUKsWQzhmSJdc6mo8r6ApMzIxWd2SS6OInSrlkD4s8mH3EmebGdLyWwu8aJAJ3eoFQM4X4DC7BB+D8ccyveOpPh+4b3GFSK8C+yNkTzy+6AwDUOxA8FrPVyVvFCtP0thMqc/QPcvMpaKsPBKwNgegzKRJKZYlon8EIXGvRIPcigunUzWwrMT73uc3+0M9KI2TMBfiRZ2aFU5DG4dN3AhO1+gELS6YOkNYb5lTLtQJGGEk6ejQzMl+67XF1Yu8ixS10tjud35BsbHSwD5mTCl9KApnL2/AORS7/Jv8iZgs1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB7849.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:244::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sun, 26 Jul
 2026 03:25:45 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 03:25:45 +0000
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
Subject: [PATCH v3 2/3] perf sched latency: Auto-scale latency and runtime display units
Date: Sat, 25 Jul 2026 23:25:32 -0400
Message-ID: <20260726032533.712462-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260726032533.712462-1-atomlin@atomlin.com>
References: <20260726032533.712462-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:408:143::7) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 243b7b23-d649-44cd-4d24-08deeac5946e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|56012099006|10067099003|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	f/1nmA91xMULxyTx7+ly0AZcbql7jF4Hcy6lKc9XtSgzuyhzwmKCOSDUKgsQLE1p7DWNGdqoPKL3Un33yOtXwxxIDkSFr7VAn9gWiuQpOyrEQnlNO4VYmKcsjUJ6qBs8G9p1ZVB4hDxBfj3vhYPZWMZDfVH/0BX0a7X84+V1XPHe/JlJSdUyrs8m0EweJUbriXILTXj07qaZUTGO2Wij++JQdm9CeSxRN7POfOcBERm6TDo6VSqMt1DhN/+eU9cNKlN2oN16ZEQEcLtLHX0XC9zKRcM0nyeKa0908awVeOegUto2sRBV5cq/1axlQmTjKZLIo0h3dJ4ZGZB3V4wsBxlXHz5cpPgOqHT2X21xcjk/XcOWseAc13pe1msyRxjijV7mHIlmdHSlqBTPnPOV00jUBvrz1cD3mm+mAnLJJRMbTjchh3R4Fx4MnGehwX77r5d34W8MCjXSBWF1TjEOQVcB0X37B1RbNJE8Ngq5udaobTe3Lf+qCBXzAThpM/UxBDFkMoxrf9AlbKIqX7hQrIdRhIDSU217hQu0QlYKkG0CQ1FsLg4axVZ7F3lH7KwdJ3eLsP/Wo8DNErqKtbExVR3j78qPDPRVW9TlI3IfNVVdhhisan/pz65XrAldn8xZa7XVsWxxkYqexRzjehXUMsIHt0wruFJAzQNCsH/biIY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BmaisoAy8ovyMXn9X3hwkSDjdKPucBEnV42qggjfcEsS2zui3GZbb+glT4+2?=
 =?us-ascii?Q?XI/VD/v6eXLz2iLGU0AykoIIom12UJcC7z+iN8LYToTZW91fArIpfsrOVqF9?=
 =?us-ascii?Q?wWekCPL3wSPWORYed8xY+mtni0ZT8yHTTDGtmjaIWEBAr73GWvlq286dFRHE?=
 =?us-ascii?Q?ExzBBUV7P0wsSMOOxNEEf/hUuT14xECDpDiY+VP7iYUeAObquwSTUkMqZIe/?=
 =?us-ascii?Q?SnWlZE6zMg73Lc0uEF9xbBgGts2kSbiSmYsTp/p4ze0SdgP/eKkuZrhzPv4B?=
 =?us-ascii?Q?E+Ga+UrSHGMaEZo80nXuCvbs2pggU23GZbaQrUhGCJ+q2LCkaeqS5vL9PbNd?=
 =?us-ascii?Q?qxCLgUUmvX1VI56+McwF4w2OnY8Uf/bbB7I1fXGVJ51Cje4wsNqIJkELWGIs?=
 =?us-ascii?Q?EgvvNRBEc5yDjrLPn8LQqsx2iS0M3L3cDDvSSG+Gw00sPOJVBRPNXeY/mGIL?=
 =?us-ascii?Q?o90oF1vMdX6hE+8Cy2JhLktIXmyel4CzFGfO3Sg9OnX9Z5XTYto1W2IKOJkt?=
 =?us-ascii?Q?ybeRuXSj54H8zQC/N7ZjbYK61KFRNIy5vbr3h6uevcjA74aQeU+94EMxKE3H?=
 =?us-ascii?Q?px7nSHyFT0fyq5L5nn02r565Zmofv2ja1enmpAIr3+9u3ymC8AqgsoAQQfja?=
 =?us-ascii?Q?FxxzALnds1rxuFYbUqn1RI7ZDl2Nb7Euukt7Ma8ZQQm/+l0EGrAhUQAtOW4/?=
 =?us-ascii?Q?4YQDFwZNAMgRkCY118aayuJ0zeEaEgDZEmFRR47KuBKuHKj2DYzaDji/lq4Z?=
 =?us-ascii?Q?mRjkLvn50b2CG9enss7vTjR56FZaqFd9hu1JwnQmg6Q/ViDW+4A8B1EXZ5Y5?=
 =?us-ascii?Q?2TPtPEJWP4QPK8zQeci61qVn1hYE72c8/V+2Fm6VeqRLSr6laHJgWWJnjQEO?=
 =?us-ascii?Q?RAVcN1YzwrsVr1jUH+Xw1QQ98RNxw5BfLCqRt3j6GGSoS56/QXx5FFHjAihK?=
 =?us-ascii?Q?pLvqCuLuSnMPtBPnGj18urFp+3EmNm9pMxfEA3DRmQHYA35DGemIM4PMa1AM?=
 =?us-ascii?Q?PMrnV02DpL0DzCu7RUjWRAWSbpaJKLL7E7Fl2gWnx4vnzBWChx7G69W+NOxu?=
 =?us-ascii?Q?d+5PA+Kx/y2u6gtMaNl4C5bvMg0qNNBBHvSo7iVdoLW2sfuaIe7jjn6U0fkh?=
 =?us-ascii?Q?BlE4G6Mnc7LZ0a1T6ftcy2N0hq3s9hPwCXIiYeSslZ8pKJhs17/OMrqrsFAN?=
 =?us-ascii?Q?5GOIwCgIKTWbv3hiF51yFYbKpfdjpkPG8MTW70rXcUPXyZTEAxyvfL9zaRPB?=
 =?us-ascii?Q?pu/C9jXT9gre2G28YJNb2H006XpMWCJgRcAsIU3c2QMGilDge0FuJRhf0XbG?=
 =?us-ascii?Q?qSMEGPUILOwtawy3ALBY/vdlJurBdY0eS3c+L3ihTtqGf48B4G33dXwgjY8+?=
 =?us-ascii?Q?FRQjNX/+8hz4Tot8oNZuZfUFDEdl4wZicgWaAf+0TKlnZKgKKky5zDeUN912?=
 =?us-ascii?Q?68FuCdvXgebZMaReyWOnqldtXyLgPsd27E5wEq9KM58UrwatoVH2HtRLI2pG?=
 =?us-ascii?Q?Gen6qpX+75iMg1bthwxutCKux2Cpc3EOMS5wB2o+rZymS9WmVfwEsI1/gjET?=
 =?us-ascii?Q?I2nIBsp09erUkkY5EwZHeWUEqZM1vc410Q6OtK0wfHltez9ywSjS+iFr3bZV?=
 =?us-ascii?Q?wXsfJxn8ZrNvgFw/U5d3p2g3TJoB7c4y6x19x/nbC9fnfeNMtBQDq6CeMD1i?=
 =?us-ascii?Q?+WaHVuXILahYFnx7ZD8S4rVkVWOlSzCf68x7uYTcpAL5KfOVmBv2Xfy5/ql9?=
 =?us-ascii?Q?7xEcKK3Z7A=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243b7b23-d649-44cd-4d24-08deeac5946e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 03:25:45.4135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAMWy5ofmJonHk7qZxxPFn9OvjBcTQ3jdiZuHUyPOmBTs0LCCs1Lx4yUP09JCu5IMQjpBNDNU2+WWgdg1bYjag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB7849

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
index b3cf678573e0..8c83dc423b57 100644
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
+	printf("|%14s |%9" PRIu64 " | avg:%11s | max:%11s | max start: %12s s | max end: %12s s\n",
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
+	printf("  TOTAL:                |%14s |%9" PRIu64 " |\n",
+	       total_runtime_str, sched->all_count);
 
 	printf(" ---------------------------------------------------\n");
 
-- 
2.54.0

