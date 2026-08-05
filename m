Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022096.outbound.protection.outlook.com [52.101.101.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B847DF9A;
	Wed,  5 Aug 2026 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964085; cv=fail; b=ZWuiVwUUM8wkboqvj1oulA+v9zsskeHlUH0T5Ma7v5NbI/BbTBmcTzUCOPCkNA6YZqZCbiL+hCn4V8WOfwMU4ZyRDihq4jAFhUU6b6rSOS+3l3wU2kCsBoEuNZBs67lXRAVMbZEgrbaLg3OlO1fBFZrQ3N7mcbBDplnkf05diow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964085; c=relaxed/simple;
	bh=jWS1rvOOmED8Kkbh6qPS0gFYwujmZrVL2GTKppTPAx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HpcmEDDWbFYEeMOB86to9AipQ7w+g779yLNeIauuGKaO/b1Qz0AOGqYXYnoKUN6RIcxJZECsdO0Ln+dnMsHsAT/ofjSWpKcZaUYp+NfhFBdwiCPeBq3WBoQ4YiKxb/7Je2MaZVqNAri94dR844pusYfpIt/rKW0PG9OOZHoAciI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWYRyJs6BVrJkikrOdjbKzeuDEd+NYs6EAYWoMwV7FvMCfUgJowN+K728HTcNnJyPp/tD/XT9Zc4jcYOqwcBOX0xrnf+1kF2be8xQWGwYubUySFk774XmW+YLyd83vPmZFjs+p5vp/i4Mn6820BK9fOaE4WSHRUtWm+ENnigFfSGPpCE54g7wysP49nTbICo5ij/9nsiEyw1K2VWtdIVGeHk105CQDHNA/xSQV2R+lyBuzJmBf4exyB6iYuSrmJibya9BhQ5+Z0NYv/f8wZeGX+5pdWUSXsq++ekh/sepZzU7NG0+P5t6b+VYI7ycmxN4REbm5WZUeJQh6YMhjfZ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Djxij0QPX/LW/PbeRhCP31Au7MuCtAOAHsIkgDHtErk=;
 b=mmttuxUFQ/jCf2kZnQkC5ePQxNlJUWBViVA5QBqSFXmEULqmtYGxjSYTLONOeZqHMOuxmn/hUedoD7fXxdXxSla4HdZNGHqSlX2qiVbHREwFxzq6YonziEAwEGEWByhmsVFDZK7vYMUNZ7xT9dCB0FXC7kNhZjwjGaIcKh+1GeZAWa78o2PWnQThStZYzHVsfqD/xbY09wWEEBWgtuXFfskHdI3VDbZUuAJlJI5dEUQajjV/ejPh1dCVexvRltSEcCCvR98Nh2tNYvw6G6xcPF6cuF9m70mnVBEen/fJt5t16RlPxOfwz7egGO2jFxX71yTBQsHjK9yepGpW8vwOMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOAP123MB8157.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:437::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 21:07:59 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 21:07:59 +0000
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
Subject: [PATCH v8 1/4] perf sched: Suppress latency table output when trace samples are missing
Date: Wed,  5 Aug 2026 17:07:48 -0400
Message-ID: <20260805210751.287746-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805210751.287746-1-atomlin@atomlin.com>
References: <20260805210751.287746-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0570.namprd03.prod.outlook.com
 (2603:10b6:408:138::35) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOAP123MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a34ac0d-c357-4aa5-78d4-08def335a124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|56012099006|5023799004|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	40OMpXW71S3VCasD6EpLhXUxKu3xDRnBKRseTKElrwss/+DEfi1E42pOdRJ3Y/x+L0GgEVZT0AvWqqn983C3l5Yca1MNXWwvbDlrETXzAz2zeyA621cGs/KFNl1LJkcCT4P1SRacswhmjYsFCHPKwIOJa+9983Wf5T6j68I84N3LpHrp64PXeEC87GclNTYhUTouLYGD5Pa+VOpI9q7+EEpaps44mu2bOoAIXhpdnYx76jvp4cWx2HtxO32xN0+9nLvbfV9l9wK4d+lCXXIqCGQHwbX+Orh7D7FbjzayxQxIOZ1IoqoYLfl0u1nKs3VBUcxA5uJawwuhtWqIi/M3tsdxWJNSsqNXz/64OynL1r5a7tVKgmS+KLmzbZ6ok7JpjQ3XbC78oWo2X204Dws6tzyehdgFMTS+nlTgS35E8csS/GcG/UbCWcpCbHBjylsSp07QXyUmU7zr2+SsKPi/vVfk2NA6g9lkIXbWTiInA58RqqfyArOjGEhgrbD2GxTFmlhRY2h2LqJkyKwnNwbmrIf2M++S5q78Y1Zec/gC0ea1gq/UbYDd63qH7FIpOf/81SAAEGQ9X9jaG75vIsv6GMkMilRSBJ6zL2NzxYmZpvmjIrX13aJGSP/mKwF17uje6JWDe2cAXovf5NBYVnN3OAo1lRo03Z6Ie+n3FTOC2Hc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(56012099006)(5023799004)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wV92+Z5beJKcJwfZXHzXUE2svbOxWxX9kQthgvhZy7roIYGKvhleKN9Q2JRf?=
 =?us-ascii?Q?1DunA/yKZ3OiUMyNmwMjxvaiNLZfZkJVC1gQbrGDn+F9hp382wfbt4i4EA9b?=
 =?us-ascii?Q?KvPnVQhIa+9GICFE9unRBfwaHAGqQJfj2NL7JadUzkwyEfi+RLP5685XXuTm?=
 =?us-ascii?Q?O6XU4a9N2P1lMbS45b4aPgU3FxX3n2y4VK3scv+w/YoPHr7Qe8cC4REfHRLt?=
 =?us-ascii?Q?VRJyUO2hcH7/6cOS6isTdQAi9f450wS+MKkzIkBxKHXI9a1AmSF1yBrAFgYx?=
 =?us-ascii?Q?mKWdTwb2cEjsdAOoaDuVSdrfTWEXPOlb8uhl7S/SF8QCbvJ1TgieDakFG4/6?=
 =?us-ascii?Q?cZqR/bJaDMa/OeC1zbyruDReR3UzkVdz2taXRPhVPCUXC94dwzec2N1EdXME?=
 =?us-ascii?Q?2xXVN9+/BJeu8dXOK9T5Wsg4WloOYi3I6W1bvYenzXn7UncvO28xmcK0o5rv?=
 =?us-ascii?Q?w7OVpojb1zDZw67ywx7fErDZACuphcf9TP7+va1HrF4NP5m6r3x8BdLPPlkC?=
 =?us-ascii?Q?dF7g85BUPbDMxALyqJByfquDEUadzKgobkk+GWWC1onPApTa4CP+xQoHs9Bb?=
 =?us-ascii?Q?Na6PO5IgVGo/xxvub98YkAuwlseLaEvjNfi4bHA+KHOXh0GnfE/hHZdMm+tS?=
 =?us-ascii?Q?usn/Hm64vs4xfmSGwL//Ne85SI3FRy2MK5pw3Kln7vtFquTd4ScJAPjMmR8+?=
 =?us-ascii?Q?hHZzn8/Ftzyv1FKeJ7hlQEay0jzpNJ7mqNaueNP3uB/OJTZ2ms0M/ojFaupU?=
 =?us-ascii?Q?+lK6Gflogv5AlyS8hiT/Go0c5de4/V9vd7ooaG6VPg+/cXY551MYQrUgO6gF?=
 =?us-ascii?Q?ou7OherjAb8tPgG1lFzcDJzxlKx1ggwAm9iEsof60haiAP8wdAxGMOwr1mBs?=
 =?us-ascii?Q?GX2cKXTObtHxIWi0GI2zfYUZ6XWR5eNMztlQHlR74rr5YkqhTUr69wtDDLEK?=
 =?us-ascii?Q?4K1o+MT3oiI7zaBLiz5OnnIi0hbTn5lZCcnVqZGMP/BpSVtdDDqBIUT3wu5H?=
 =?us-ascii?Q?dGYTkfSz/vmOtXsWf2VW/tnC2liorzOdREIEoCZlgHe28jMy0Ag6joqNOEST?=
 =?us-ascii?Q?yEPQFdUsxzOLld0FJEAxpZeNBW7zF3L6pqjI1kyGBsyJIk1H7Uuo5xc+eRcx?=
 =?us-ascii?Q?Qv/G22qDwTYZxq1x4t/A6Gevn401gCWgLIi9iZAuMnsmREZySDRB2aghW9rS?=
 =?us-ascii?Q?mf3eah9odjP7O/8L3BU57xsQOZAtUDnoQlM8aMjVWcj0ROgmrxUytKv3Thar?=
 =?us-ascii?Q?JDqUCop9rCwwRd079q/XRwJJJN1stutflv3uBlBvwxbvOse+KmKOEFJwbrny?=
 =?us-ascii?Q?Jk3wVMYAZpSmS4CLvrjg3YbJcrtwsTAjybD7xeM3S78em/rj9RhQEUdY4asK?=
 =?us-ascii?Q?9fCD206EdUY+NPHMgnc7FtV93CnMa4+veMRrUYXEDLn+R9xNmZrGHTvfgRHc?=
 =?us-ascii?Q?y3z/hPlqN5PSOqRmOchA0FnJnBvBU0Ab2AZcNDRttSPBLPPjlGKscxPmSoHH?=
 =?us-ascii?Q?YA1xKMd39dhrS53PfngxqJR/oQnI5oF+m1aniXg4ZT9tKqCTG6mZaBpDI7H5?=
 =?us-ascii?Q?w/09a9CgEzaVcrrEWTz7vpyroW5ZZeHAr8YgPxmq3qUHIa3/jDc7GdsESsop?=
 =?us-ascii?Q?7SpEQ5PZK4INrYKWDVg5AF56+Tz1hs6w+Z+ag0w12o/ytitSlNnG80EGtkEJ?=
 =?us-ascii?Q?k934NcIkMWIZuEZfzwKZGzxe603ghpvtJNPYRYmlfUbd/yXrM5NZQpklamz+?=
 =?us-ascii?Q?0FmAaGe6qQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a34ac0d-c357-4aa5-78d4-08def335a124
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 21:07:59.7327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSLTDjlBTheYI5rSmGo3g4hx6cLGw6FczGxghB/JHNHIwLqscFb7SdpmwbwfabpSU/Fh+JPVyTa3P5Jf9tfDLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8157

When 'perf sched latency' is executed on a perf.data file that lacks
tracepoint samples (i.e., a file recorded without the -R flag or
containing only non-tracepoint events), perf_session__has_traces()
correctly outputs an error message. However, perf_sched__read_events()
subsequently falls through and returns 0 (success).

Consequently, caller functions such as perf_sched__lat() assume event
processing succeeded and proceed to render empty latency header tables
and total summary statistics.

Fix this behaviour by ensuring perf_sched__read_events() aborts early and
returns a suitable error code when perf_session__has_traces() evaluates
to false.

Additionally, validate thread__get_runtime() against NULL in
map_switch_event() to prevent potential null-pointer dereferences.

Fixes: 27295592c22e ("perf session: Share the common trace sample_check routine as perf_session__has_traces")
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-sched.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 7fd63a9db457..94a323da0799 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1833,7 +1833,7 @@ static int map_switch_event(struct perf_sched *sched,  struct perf_sample *sampl
 sched_out:
 	if (sched->map.task_name) {
 		tr = thread__get_runtime(sched->curr_out_thread[this_cpu.cpu]);
-		if (strcmp(tr->shortname, "") == 0)
+		if (tr == NULL || strcmp(tr->shortname, "") == 0)
 			goto out;
 
 		if (proceed == 1)
@@ -2001,7 +2001,7 @@ static int perf_sched__read_events(struct perf_sched *sched)
 		.mode  = PERF_DATA_MODE_READ,
 		.force = sched->force,
 	};
-	int rc = -1;
+	int rc = -1, err;
 
 	session = perf_session__new(&data, &sched->tool);
 	if (IS_ERR(session)) {
@@ -2018,18 +2018,19 @@ static int perf_sched__read_events(struct perf_sched *sched)
 	if (perf_session__set_tracepoints_handlers(session, handlers))
 		goto out_delete;
 
-	if (perf_session__has_traces(session, "record -R")) {
-		int err = perf_session__process_events(session);
-		if (err) {
-			pr_err("Failed to process events, error %d", err);
-			goto out_delete;
-		}
+	if (!perf_session__has_traces(session, "record -R"))
+		goto out_delete;
 
-		sched->nr_events      = session->evlist->stats.nr_events[0];
-		sched->nr_lost_events = session->evlist->stats.total_lost;
-		sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
+	err = perf_session__process_events(session);
+	if (err) {
+		pr_err("Failed to process events, error %d", err);
+		goto out_delete;
 	}
 
+	sched->nr_events      = session->evlist->stats.nr_events[0];
+	sched->nr_lost_events = session->evlist->stats.total_lost;
+	sched->nr_lost_chunks = session->evlist->stats.nr_events[PERF_RECORD_LOST];
+
 	rc = 0;
 out_delete:
 	perf_session__delete(session);
-- 
2.55.0

