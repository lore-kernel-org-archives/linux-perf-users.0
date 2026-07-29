Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020077.outbound.protection.outlook.com [52.101.195.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780694C6EE0;
	Wed, 29 Jul 2026 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336311; cv=fail; b=cWxgasHyDT84Akz2SSXK00jDnUUpB4is+j9pJQxLiVSzI92K/zuLS8AxOIM+F8kvmjrxHzEgW7Itcpb7JNVu14yoBl+5ToN3KbI9mFG9Ytyq5dAa18reSSOgSqa3gVk5J8Q/QRUPrIvY6ufCfmKrnHU7P34j+UdTtpBOqS3pTjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336311; c=relaxed/simple;
	bh=b/M3jP0gnjhyyzBPFYMFEPt4rdxCe6oj7TYLejJe/Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GT0Y9EmktmkyUBkeCz3+/eDBClDQvzaVKyTOijVYhzw/ZKvWd8CRbf86u1/lo8SnsIiwRvzOaCf0lovPMDgX5XO+u5aBAl/ZsmQhrXzpfd7Y/hUHbBHcCrbJXs+4Z/cTq5SgMaTuY8CMhtitF99kEqx4vcPuku/lFKLG6ypiS0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tk+b1vs8O2ldhDIx9svHLnjKy+VZ7E8NN5V0zu+BX3/qQmfFpkpHcMSn5TId0ZhAzWhHNovamE4I3DGQor6MDmEJMjResAsPqp1FJmT85Cd6jgeWU1XLuPA4S8+sn0fCQ1D62OQ97P+tNvbbsBjaUwEQ2KBXcQmRIaHiWBkeI6YyRQeaQHn9vmu+VAY+nx7dRiK+GtsawB6lTzgCEPxUSeNkueB/7cYNoaa7Ycs8EdpqjLwgKP0XVa+CfcoV9tM0fvEtPfq8w/0yl0IrgMrq61KIj8cySrcome4VkVgaD7fklYLD3oFmpYiiURP4Qu1wp1hKBjb/NX0cmz/iYH6SGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=9SvhooG2mqehHizPQxzcCTw7XrdzAlNrxer572AzGXc=;
 b=AONRIlQesPSXYryh516PH/JbB1vB4C/RSFVx1CLyIsQe7P1ArTV2EEPtpmYnInV+Etpnqh2LPXF5V36cDgBHuF/5mWuU9ryGCsoYF/1REpMXGgBg+9XS76jQNFeg/R4XsRGvFZ+AM0sZTM0R5h4M4EWBB2WBAQLaQ3XZiYsyCsmE6brpzZjo2177Dojo4NRHqKE1WsSJqjyYVRymarCnHa6q/Pm/eIJL2v0CZdkqPjlUPcBM/yGiYliNeGFiBHhG+cAGoMiR3/KfztuybypHrzou+YqAGv+rlyFZbSuayNDgsg0/unnvvyRdoz3mMk4mSooPCKJOu/5fYOHv9bIG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOVP123MB8527.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:487::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 14:45:02 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 14:45:02 +0000
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
Subject: [PATCH v4 2/3] perf sched latency: Auto-scale latency and runtime display units
Date: Wed, 29 Jul 2026 10:44:50 -0400
Message-ID: <20260729144451.38286-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729144451.38286-1-atomlin@atomlin.com>
References: <20260729144451.38286-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:208:52d::35) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOVP123MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 3990cfda-275c-4ab0-c9c5-08deed7ff8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	PzbWroZNoB2Asqa2l5BPW+3GB7i/ULo+rkKyosVfHAGxUORUNI4xXfoyJqPZQsxIl40NiQMvixlfh0CoulEQHDxF58yzVQtKRi1bGVfUvBme+cqlacXdr0PLKfNvYjorYt0DakBSGCxcYSsOf+r8ubqy5qNHN7doNJ/EJzeS56v3u8ChFQlYxPC1gRhYsHAiDtuYZHIRo30qKfHiznJzpp3RkW1yZ0P3mmsr6KKN1iztM3GLLAOMIGElQlE5r4MrFDUtHeuNc3a0mJhR76HShUEpXww0NpdxqEU91WGwN/bmujQ111oghBVG//ZEgDW0VQQ29VPjH8CA5+zu4N4+MByRStuzrF0l/skLCvkNCpKQsq1uC60dJP/SrEsA9gCw5uTr84EhVB+KXyryH5PtFgliIhpFrywabfo6ZDiK+bQyQF6G6nliboW9Uw75K5juWK1iHjmNvjr7ic19eALoknub/wZVTATe4fn3/5pQoFOLIOHZo78NNbqrkY3ThoBQ8XWeFbHosPUeBw41+QL9WbuP6d4zvp7PsmPChG525wfy/cGPOkd0klgk5MGiHnxEMC0QCg3hSq/b/V63X7N2NGnDIZ9QGUcZ8CrhD7mZk9WgYiptHFrg93+Bvgs01u0NE6u86zDMrtu+bkzsknbjW8OrXli07+oeCGs9V0oWtDg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XIaNLj9NG0TVIH/uUSS2VJaILuuOF1+EhbBbBYcDzuX2ffqje2iVfQQ+tsoL?=
 =?us-ascii?Q?65VKYsbnsXE6aIaoQcHebgFqOgG7pPqgAlDgJuWTKmPs+T7TQiLdeYZ9+6wB?=
 =?us-ascii?Q?Wl1p1dvB7e60F2++bF4j2rq4d27u5i6CSDmqow+McRTLF0eJArdnYok9laiw?=
 =?us-ascii?Q?aKtkDE0Zxxb8Z8aleHCSP65vjCoz0cERZu2omnotIc86F3FU7REjMUUE0BsG?=
 =?us-ascii?Q?lYNHpNlGpajdcUQwP4N2mm2TPd8afnC5VldztmjAhMKClWw1/YMDHKDVD7RT?=
 =?us-ascii?Q?K5x0YWfWU+WXW3S/vIy2UwlThAvKjI+FI6Y296lIvN/hV8C7baByRhB9PplO?=
 =?us-ascii?Q?rXa/gplyRPClL9NsmkOrAVXPOzZ+3E98LshS7F8tYkFh7EOYUdXdv1HYMhSJ?=
 =?us-ascii?Q?gvTZH5dzWPWx95nS6OfsYDokdzNW4oRzS1gYhyQTaQsSQYkJOC5r9NfLJOg/?=
 =?us-ascii?Q?rFl9kpclLqfelZ0bfu50njAMRfmxa7S7Svm8vP95gbqELj4o4oRdhShok1RI?=
 =?us-ascii?Q?nowUVYConoqupbQTw1XV843kiFDP6P66hvLW2lNuMFmN22zffB7FWevHV4/C?=
 =?us-ascii?Q?MQlsC1SL22NbaXjTAQFfqrdyzfobI8M6jAqDkV5015CbQUfQ0x0ijBKCzQ4R?=
 =?us-ascii?Q?WH4ZjnH46f22Emgr6Xsoy21cpYWTSa+m1H6VKKHiGdnBScdYZXkR/qmtjgj3?=
 =?us-ascii?Q?1/UUdOfRMs0PjLzNdRujUbBIWyg147H7N65vQ6Fnd5zzsb1O6dK92Knib5kI?=
 =?us-ascii?Q?sgo3GK0EGGJWLEXCh0DJfX/9jiNWOJ0aJzhxbGfluswFkQo8iFgfIMd2xxKX?=
 =?us-ascii?Q?X+W2L1CN501tl9Tsk3M8c5iIAlYU1h4jmFzdALqtDtehV+ori4oMMnRRdWMO?=
 =?us-ascii?Q?18JOtLCy8ARwdXZVylFOqgEbgmdJqZieOLZi+LtDKbDE4F/io1FgehW+XoX4?=
 =?us-ascii?Q?f8A7Mig0BKAddzphJB25ZrZ07OlknNFGtWz2woCPj/CS+zDqZfw62k2Av52d?=
 =?us-ascii?Q?jbRgJw+Ekxg15nxFKlbYV9HUshbqr8/5upOeJ4HCNmYNZWIiTxYvl/h63OzC?=
 =?us-ascii?Q?3hJqR6+wo1mwLCqtx6ZTqTvLYnBehdt9Jqhylp9hDi8Qq6RXkqKGHIAI19fx?=
 =?us-ascii?Q?8qkU9nCZbY2inOFtrMiddSfzLB6IY5h2xwBKR2OiQQ6SWb/UHo0wWzdLZNQz?=
 =?us-ascii?Q?cfRRgBPw+vFGGeU9/UibZQlyDdlSxhMsd5KfSaJMc8f7UJoJ9/7t7NBJAUIu?=
 =?us-ascii?Q?9+Az7PQayzaJU4y6MGRUow4QbwViGr4/NLxb+6mSFWOQ3QGyTq9uka/HMXKN?=
 =?us-ascii?Q?5Jdc9wSpgcbkwfaVhGj20RTrEyJaO6e5Y5yEVmnZllv/KIEbz5HA1xtinlY9?=
 =?us-ascii?Q?2aH5Y81i2q3i7U+QbFD0X6sMXkVg/i++5v7YnMft5Y5bxT5r5/Y8GUY1sElO?=
 =?us-ascii?Q?vWqTjvZgdaiGH5MLVz51e0F200cegAyjxnaPYRlOr5T3+CR+brCo7Xs/0zge?=
 =?us-ascii?Q?Q5DMqgkkGB8rT8BirRm6ddvFYxy+wJ8y4xA2xN9pUPr7GewCPwi3i3Z28WSZ?=
 =?us-ascii?Q?t+l9YfKVc5/P8sXGkJdW2O9J14DXIaKDP8BpIX1k7n/ve5gR7ib/EzUToHcb?=
 =?us-ascii?Q?fp9C6TqeSRsGxlApCKWbIT83CjCmsXCreS7a83X6GLEVvyfsqr2GLvb43tmP?=
 =?us-ascii?Q?BSaAZUJTgNIbn9vXoqy5TWoh21B9YqxofxF4Y+BpweJy2m9Kz7ZdtuFbx4ue?=
 =?us-ascii?Q?IoF6lJD/yA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3990cfda-275c-4ab0-c9c5-08deed7ff8df
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 14:45:02.7568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfWHD0Sw6y7IV4lI+2Qh4gZLnPmA/tDnZE9uFlWKS6b2mZCSJ22/wvALB8qOQIfQN0l7DRAKFymWSlD8WN5CiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP123MB8527

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
 tools/perf/builtin-sched.c | 40 +++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index fabd99a18aad..c34726b87eaa 100644
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
@@ -3605,6 +3621,7 @@ static int perf_sched__lat(struct perf_sched *sched)
 {
 	int rc = -1;
 	struct rb_node *next;
+	char total_runtime_str[32];
 
 	setup_pager();
 
@@ -3617,9 +3634,9 @@ static int perf_sched__lat(struct perf_sched *sched)
 	perf_sched__merge_lat(sched);
 	perf_sched__sort_lat(sched);
 
-	printf("\n -------------------------------------------------------------------------------------------------------------------------------------------\n");
-	printf("  Task                  |   Runtime ms  |  Count   | Avg delay ms    | Max delay ms    | Max delay start           | Max delay end          |\n");
-	printf(" -------------------------------------------------------------------------------------------------------------------------------------------\n");
+	printf("\n ------------------------------------------------------------------------------------------------------------------------------------------------\n");
+	printf("  Task                  |    Runtime     |  Count   |    Avg delay    |    Max delay    |      Max delay start      |     Max delay end     |\n");
+	printf(" ------------------------------------------------------------------------------------------------------------------------------------------------\n");
 
 	next = rb_first_cached(&sched->sorted_atom_root);
 
@@ -3631,9 +3648,10 @@ static int perf_sched__lat(struct perf_sched *sched)
 		next = rb_next(next);
 	}
 
-	printf(" -----------------------------------------------------------------------------------------------------------------\n");
-	printf("  TOTAL:                |%11.3f ms |%9" PRIu64 " |\n",
-		(double)sched->all_runtime / NSEC_PER_MSEC, sched->all_count);
+	printf(" ------------------------------------------------------------------------------------------------------------------------------------------------\n");
+	scnprintf_latency_unit(total_runtime_str, sizeof(total_runtime_str), sched->all_runtime);
+	printf("  TOTAL:                |%14s |%9" PRIu64 " |\n",
+	       total_runtime_str, sched->all_count);
 
 	printf(" ---------------------------------------------------\n");
 
-- 
2.55.0

