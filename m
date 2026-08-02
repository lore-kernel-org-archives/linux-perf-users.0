Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022106.outbound.protection.outlook.com [52.101.96.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34483438B5;
	Sun,  2 Aug 2026 21:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785704973; cv=fail; b=UDZb9F8IX1hyIHyDzJf3JyRQL+gUEnNDpTZ10tF0ZbOb6bBaTgiw1l2rCqDPRlVTf+ZLlPuaOEXiAcB53MVPnPOQwTJmYG8vzTy8h3C+M3fm6yHfjoubx2wocqBAosMHxuf+sSm3TieejphPBn54tVdfmhP4ncaxRTymGe5/Is4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785704973; c=relaxed/simple;
	bh=P1QlmiejhuK08ASztNokSVjEXfrFSg5XEdwhWc8vU5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hCjgOxKaX8QNw3tBLIC8h7Y79bh8wxUBYvz4TGgYI8Qtu4K0X5NPPCieeKvtxnSyZC5bHuBFJSFazSDJi/amUVVW8t9TmRlCQbdYcXE6u2qnsgrm1SMaa+zLblEgwwh2iuA6vCsdT99EYz2eoutULReG5syroOVo7BjAzRjHHRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bg55DhcYdSUYacx+cAl6ylScaHopwD2I61ImYj7CIMbeEG8QXd+CTuQorbJfJfKVEbad1gU1yy+vnLerCnV+5pG1opv95SybHEmo/HYF7bgqaX0VmQHdh2opM6xbA1/Jz+0JaHQ0lT0aAJWC7TXa/R7DHizR8HX7BMIqiMqdxT4iRvQ3F1jcW5zYc31NFOVlQh+6dCVoHGNu4r0nmEnOQGOP0BBOITFdiQfOvVjwPpB096yi3kgZElh3l39ntz97bKadPqcnHdeX7M939j6EQ0rRxF+ylMdRHm0jNY4w9kWIXM3oTgCxoVnBCnBefOuI/tsQZbKKF7aINeaID3ZNjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=1ob8LvZWNT21P9OG3jG1BRiXV+z+8qGdjMtSwYSUXgg=;
 b=cf23r3DMce2K62DiFMTfVn37kBsk0SQQ4r/gI5eV5gL905glnI4AClM9CtWnFN4IW0DW7G3GTsFviUngQ0uKEapf5Iwv9/cOBkOO42hfmjzAq7iDyMHamhkidDmHMLbGrJ3bDeXf92Q2WT8/maiuJd6KLwygPLrZ0z9+bSsUZtSuDa088wdBeeY0K8wUXde0j7+1DYb9CC+RaoxbxEr+oahyuAYP14O01JvGassWfIfaF0KHodvK/+qOND0Zxt78FvqQ3DBtMs2hz1WjrZJiGOZiKN6UJrpfLlxMxyEoUxmHcrJW58z7RcaQuSlHwIe6o6s9oBk8uRvQvPAGK6ug4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB5940.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 21:09:28 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.016; Sun, 2 Aug 2026
 21:09:28 +0000
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
Subject: [PATCH v7 3/4] perf sched latency: Auto-scale latency and runtime display units
Date: Sun,  2 Aug 2026 17:09:13 -0400
Message-ID: <20260802210914.199941-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802210914.199941-1-atomlin@atomlin.com>
References: <20260802210914.199941-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0377.namprd03.prod.outlook.com
 (2603:10b6:408:f7::22) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 363de8a7-452b-44da-b1fa-08def0da56fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|56012099006|10067099003|6133799003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	I8hTR1Ss3CtUq+dl2c8ZMlHNS+HLIh/a5Fz1F3l+LNvriLzKJ1Gd2jLXtI4xqapHisWBKmJLk332tm+v7ZIcDuugbaAILYdWojs3vLsylx9+MNx9/lLoKReLP+1e82ChfWROc1gk5x+WUMbZHT4hf+k/PMlMxmZYvJ17ktJGVGI/HKJ4WIt3xdrrnIVSCBtp0Ul4H+WucfZrtjgUkA7mYMpFktxLhc0qbZ15LRZsrnChF5+J7nUBiyeHzehKb/h788t8IQHzw0f7YY6lBPb1bKEDcgbzBc4bZt1hKCb7tIyy3ZXggza8x+3+TAn8tvFMuJmRpIevxrotmHR7GhCqHjhqnPMaSlFXSRne/zdI554x63O4pACFd7JPZ/OvE2HQJ0pnX7gWccuHIVNmFXeksnHicfKMi2kqBv87moNmTWFFC99Y8FqIlfHsnAHtzvldCP4Irv3S7RKpiIR83b5h3Rfe+1g5ramySLT8QuuNJQNDVGR1jJpIItItcD7EC095HOmYYus2OQu8X78V/cTNDrot6a6XHrzafHz3NX6D/Zm5PSP4zHjwaqaltr0gv+10TS+2OEs1g/ORYGPobSHBX6+n8Uz5Yp+n8Pch1XneDZKg6aeVn21umCBfaII1lObpep7Ze4XgA56jJ7HDURyYJf5Z2eqx72usAc1lKqjXCi4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(56012099006)(10067099003)(6133799003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oNOGJZyfhCuosOmZJZv1H6K5S+4g3Lqny1IlErwV6iHaG8j5+wWvqhpQvCsw?=
 =?us-ascii?Q?pgExRGGg7NKpMseyjmAhsPpOwfr5Szc1uOJJj5xuZr5qooQulo5b1Qy4aE2H?=
 =?us-ascii?Q?QVNoBAGYvUF7FoTf8quWNvhFwPxi2R6J0flTGbmOVzpBGyWC+JjDqKmncStx?=
 =?us-ascii?Q?Q2JB7cqBThLRLnu6EGr+MXwm7nCqxJMVPuSNe3DIIoPNOjK1yYscU6qp0AZZ?=
 =?us-ascii?Q?NJ5gN2E2vuEq6pEsUwp/f/ao61qTBXW8bEIuTvp0rzuOJJ0mUHjRkSkEohUF?=
 =?us-ascii?Q?IrvEygRlKniuwdcminkU+3KV9lq20v9E+bVSBp+ELIdxVHRW1s3OcitbTthg?=
 =?us-ascii?Q?jtz/CGhbB9WmK3tIZsBdhbiCzweFwdX0Y7VBRC4A09LKvanhjPwvhCsM1Jci?=
 =?us-ascii?Q?UstoTK4RcS0JUdOaagV7uH5rNyWPyZenWYBpePkrK7WmK7BuSOICFCD90jyj?=
 =?us-ascii?Q?aOg9K+Xb/BbDgVGB9BdC08neFZ0by9v/wY32wWhmQFNY7uzO89u6x0cXkip4?=
 =?us-ascii?Q?Il8Z/xcBesYyktzEPCagT/okVYHCvjh/QpCe0X63Q1Qyr8A7HoqRt64urEEp?=
 =?us-ascii?Q?Qxo4NVy9t1pRS8ElqRQYa8luWz6mSyY+b0n4b/QDoJCHSImmtQrn3vNSUnD+?=
 =?us-ascii?Q?BY4hVoQ0VSsKIPpwOkMbNFlS2tQE5AsQA5pdty5Meu3ffS6JAjvt83ZIeGA0?=
 =?us-ascii?Q?d5cX6MmNttlLPeboBzXOIWzO6iL8zArkKnp4YIPNUcXG3leFmsHs8tcUjxIF?=
 =?us-ascii?Q?onglu7V7+fqpgUPghEVIz3qiyh7emQ9VEjJn+vvw99XrlDbGp1p9Lo7Pwoyj?=
 =?us-ascii?Q?HK5/olOYTw0s3TtMI2Vcu00LbyrSXMkfcWJsyfI1nV5gYwjtgqxcypPwpwhK?=
 =?us-ascii?Q?rhby1Ml5zagorHcZ6rIMLxGuq2TeemxIqMHEfvTEBSkKPnCakHQCpIVbLZ5z?=
 =?us-ascii?Q?w7SBz8nYjtJG114Gf3BXE+VdLZjnMtAM/CkwCNKcTqRy3nSFfHoLX0DA4OXd?=
 =?us-ascii?Q?oDXqB4r9JJgcrNnlxh1xf/fh+lDIEzqt10HQrSIb6Udl66mhVew48AEO7VVC?=
 =?us-ascii?Q?ZIi2KWJwu3EtMGj2xVG4OXjEdCi8e2pCctSG94owNyzg9fNt7tVaQkjy3uYt?=
 =?us-ascii?Q?mqVtfc4PmzLPHcK155JVctmCjQ4Utz5vnPIfUNtARlnIZYg7LWC1fPj9mzdc?=
 =?us-ascii?Q?/hY2DXYTvzJeL2tdGbKB5d20kwUvWTotKToVeAWqpWjt3OZdo+b300AC5tuB?=
 =?us-ascii?Q?/KmAYaxILzsc6mEFnD4wm+tJQaPCxJWesRuiz68sUwuWwBKtZ8Crtpyz88/s?=
 =?us-ascii?Q?ZAVb9DXBei0JvLR7DdbDT6Ikc9nZ1YvxlaParZWmYNeoNMgBYSk1cJuqPBvf?=
 =?us-ascii?Q?d7Azfaf60CiSooIj0ncmoAy9FPLBIFe3kfWQTv/XQPQfHoWK6a/Db72sgATw?=
 =?us-ascii?Q?ya7TmPDqAzGo9j0ehjQ/sYuWcXaU+xpW8gYkCIXjIRvgc+zVYxoUrXKVWzsL?=
 =?us-ascii?Q?+jg9eBegXbwmhxmOgBzCjmOBbe63TR6kxueibpCg4aN+NYldpbGVduPVfdBQ?=
 =?us-ascii?Q?TDuS+hYD7p14+rZXKwatKkjmtsI3XuAq3Nq86SSTXrm1kfORfMsNasJn73f2?=
 =?us-ascii?Q?TERESUtzHa3CoUzaDXGhNT+ty5olsQL1YuA1VONBmHdKlEy9sEPsWp/2XzAb?=
 =?us-ascii?Q?tr7eXmGhjtyTwIP8h+7eh1JGbz6CNz410pQasQYcWcULnmBzW/sJIVtZ+/bM?=
 =?us-ascii?Q?Y93FmlCjKg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363de8a7-452b-44da-b1fa-08def0da56fd
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 21:09:28.8024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqwxYLqYh/jtTffAGkOkGUofq3apmkvYk+gXmi7iQVqFokudNGI/wFeUUXD0cud9nYZteHDkNmx0mLyUzT611Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB5940

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
index 232e72537df3..f86255ff107b 100644
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
@@ -3630,6 +3646,7 @@ static int perf_sched__lat(struct perf_sched *sched)
 {
 	int rc = -1;
 	struct rb_node *next;
+	char total_runtime_str[32];
 
 	setup_pager();
 
@@ -3642,9 +3659,9 @@ static int perf_sched__lat(struct perf_sched *sched)
 	perf_sched__merge_lat(sched);
 	perf_sched__sort_lat(sched);
 
-	printf("\n -------------------------------------------------------------------------------------------------------------------------------------------\n");
-	printf("  Task                  |   Runtime ms  |  Count   | Avg delay ms    | Max delay ms    | Max delay start           | Max delay end          |\n");
-	printf(" -------------------------------------------------------------------------------------------------------------------------------------------\n");
+	printf("\n ------------------------------------------------------------------------------------------------------------------------------------------\n");
+	printf("  Task                    |    Runtime     |  Count   |    Avg delay    |    Max delay    |      Max delay start  |     Max delay end     |\n");
+	printf(" ------------------------------------------------------------------------------------------------------------------------------------------\n");
 
 	next = rb_first_cached(&sched->sorted_atom_root);
 
@@ -3656,11 +3673,12 @@ static int perf_sched__lat(struct perf_sched *sched)
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

