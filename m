Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021118.outbound.protection.outlook.com [52.101.95.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F2236B920;
	Sun, 26 Jul 2026 03:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785036345; cv=fail; b=EhIli93mlsa9oSHb0IDNB8heqhJYK7sdMkq0KWwz1JZB0NGo8qCXRE60apnWc/W5tRvTzi0XwPs4dJO3HBeIftes7ieGA5yMT9ixwKlrWY5XF6g1SZvcQWLRovZjEJYcMSonqrKvIGW/51NJnYjPBTWt7E9jROCVoBuDcsrUo5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785036345; c=relaxed/simple;
	bh=AzVE2MAho7EV9YVirdBmkAbeLSab3RHkh5abS+u/n20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Geyct+pMLS7+TG76s+7bUJyyoQ1Fd37NwdYNGEOtawgbiTpQjU2znOA/s21VB3edP7nJKzY40ILSw6ulI9rEDmP0X9GID8IupHpXi0yvXCyxcJHSwqH3b5YAvIpClp+qlXldrA6lddvt20Ij7tzuZawbX6NHyggNC0gikBPpsy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLXgw3OqeWGc/rt7HcaOqlFmi0T5RZlj94HlgHZLb/kX12YFApWlkvvtJXt9qWjk3JA6+jwnHSkLVCLZruj5GBE89Cpuzrjwm3YPkvgXKVdiXmlkjxiwAazb3dYSRLE+EfK4TU86oxMGKVFAf49P/oVJQk3ekpU/tptqz/3OmCoYNTgccqkrsTQ83RIA6OCKPhBsV2FoY7UUW6+OCNmcYjDGj1yJOUEh4Imsa9II24KirPQWDDxHXhZxAAjpmDUErvOqPOsd0xCd0PzFt5+Bv5HnQP42qhNcqxznnb2zDgoDy/dbVQo9+5pWGBn8kW2i1NTQfV0d2ITh3my/Id6LWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=5CsDdTm9aotaWc3LfQHuysx/jE6ZIKMr8aQuIY87R7U=;
 b=iJ4+WyzY5bKNaRb5rzPXMc5JR6qE5zukrPkupYXyaDgKeuHw7QChm/4vQNrYXlxe8uP6k1DeoWKZgfaWVDNhsr16N3hDMcIKu7Eddtxt+NFwn0dkp6PJhz+fevt/Xb+BigDALbmySxAtgQWwf249Amb8Zn5utLVDTygzUtP0k/YgGw1WYUPPWQ3TNtL3YzeZhD0M2WHO3ddvxjdHl7N3FrD3fBNkJ+aCCkTXu7KP3o2KjxHCNTwM5MXmaVnrliQ2W5jlQy0nVetfVIO4R/UkgKOKvlzNb/PGpJ5neF76DtyOvVtc3jUszzzpC2sO9XmvibF3+hFqp3YRWmlCszAxwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB7849.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:244::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sun, 26 Jul
 2026 03:25:42 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 03:25:41 +0000
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
Subject: [PATCH v3 1/3] perf sched: Suppress latency table output when trace samples are missing
Date: Sat, 25 Jul 2026 23:25:31 -0400
Message-ID: <20260726032533.712462-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260726032533.712462-1-atomlin@atomlin.com>
References: <20260726032533.712462-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:408:142::12) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6af33a-4da2-437f-fd3d-08deeac5923f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|56012099006|5023799004|10067099003|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	dif8HXxhPkUMG3pHcwwx5CgYWxXryVLhJTptgwgPXiojGYpSbvvEddbAjC4sKhaNaEwqT7X8U7bO73hwdgyWgbQOku+SAMi7uI9dlM2cFnWwtQExi1OIFY4mAQYmNAdfz5fFGw6dj3ZzBiUlC/n5p7daPitnNwDzDoXKRz0hjaculPmZMDYWWJUpN/kzlXPP1Yr9wP1obxMmcQzsbrqbNDGLVUviCgYYoxUEjvhP9CDmbiVmlTxii5zN2iZGzU53N/bTZ1LE8goBHFI7QWIu3YHENdNH20rUQqCYJV0bv2RKI6uqtzWO6vBJjLHpNT3Z3rCk7Eq5wFbLF5NReS2oa+zskQZe5SNahONd9avYIudI2nARU7kGfCsEGZmPQO5tYSqRXNfG+6qk2o5jckZLq/UfcwYlVI3OoqXw328IAGKquV7Zu2c0dhHyQeUP+JpQ0uX42NkshsGGhVLTZDUSepvr3pNjRbSKPdJo8L/eJopE0eBOW90KTWexlMhZFKy6OnunVPdvGupLM4Xgk4K6QRZq3jKJqi8f8Y4w/6FWsWeBOE8QxY+X8WTVGzBJIdVHUBbIV33IFLv4jFJ23gQpb7yGbvLMOYw5AiGonfLTGbdCmNo2WgQ1awNmnO5JXJdUvBcFcFxUN8PpwjkWbzpqX/T1D+Bawzl7Zo595xlhFEs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(56012099006)(5023799004)(10067099003)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rpBh7ogZRqR6mxbNzOGUmVWWKb7ruI21H/2Qv+/0ewW3VwrpGEKHfqpT2jH/?=
 =?us-ascii?Q?/19BuV5YM7QgsaUt9eoZPoGtYjMgc1h+8DdLNIDIFb3dW05kOM4uH0yBwWZV?=
 =?us-ascii?Q?Kv39sRH4ChgyHiZ5Mf0LWgqQBRAfi68lJJ2jSVNIQYycSBv29VD3Uq+buR1C?=
 =?us-ascii?Q?QHbHW+BGySQx/xurrBe5fOcCwBYxZT0SfIPv+62ctAIQWdDgwS8HcHuo/SRY?=
 =?us-ascii?Q?lr8Vg4GeKNmIQC0CwcHA0NstPBG0mOrg5wBqYZltKSPoXu3UdvCgwPHAQCM6?=
 =?us-ascii?Q?SZ076wQRYC0W6zY/Cxha0oA/WivFmrpssZHyc5UkAUfmwZu3xKFuceP84h6O?=
 =?us-ascii?Q?Qk+c/d8c0ilrRk2Mikh6nfQDgHl5iQko3iXW62wQI1UsKcKxbXv2i9Dw/Kd9?=
 =?us-ascii?Q?KYMmO11nwNwyWzq4KMynp45F0FRmKrp6Ye9MKVT2rAblNssmREaGdd9xI0RF?=
 =?us-ascii?Q?LRD02hf1zxjDJ0hGT87bLmplQlzxzJvlI1BEAfoUHjQIZHDH9h5BIaX13aXT?=
 =?us-ascii?Q?dMw0aPThUZ6UJoGLZaCgdh+B23w5J1FwE9Czx2NBGJfeR8xe+K+/TeHXy+Bx?=
 =?us-ascii?Q?/RrfhmCTbaO5PVMJf05OWeVZlbXDTkGT4QKiAWSUCm9k6l1HN0wIV39FxjNC?=
 =?us-ascii?Q?1jzoq2+mzTdt0fgzhlW0h0Isgf7J+sVcypSDK/m8G5w1ahqk7hxTaSsXG8VZ?=
 =?us-ascii?Q?2IcZLNz/PTXhCwKwLrPBB3DXlWjMCLdilw2zjMzNRhPbn9xCNhbnmdZJyRgY?=
 =?us-ascii?Q?1vzph9tVCe6Pub9+9Gx9t2Jphr+3ApJmx1bOMp983O17Mv+deHMKP6NnHQ5s?=
 =?us-ascii?Q?bvBxtYLsR3q4bpI1WTnBYaQT/77s07q4eXdNPsQPUVBd21vryT/2rpVJhrye?=
 =?us-ascii?Q?F0uq8pRJ3rqOyIj8S0WV55UqHX98BFULg/38ni2lbeLLzRg6kONUiBiS2GBx?=
 =?us-ascii?Q?NUjVoWbd9vdqoPfljxbmAB0MXBiM00R6AdSsMHdQnWE5FySHBM4rGbDL0+tx?=
 =?us-ascii?Q?7rXL2iat2YNQG2pmC+2vGy6Nvhw50V/jV67ZFeav5DHtNgQGouxvCa4pyUUE?=
 =?us-ascii?Q?5FpL0xu04QTCYpEiHlXKddYw4bFrmIT1b40WbbJBYLmWQo0q8gFncY8vzFqb?=
 =?us-ascii?Q?SVdHPJASc0Qj6xEqVcRgU+s1gpRdJGogaAFgWRI14tUGV50qtu2s46sCezJ+?=
 =?us-ascii?Q?CcXSyAcx4PCQ6tEKC9lFI0v0bR4KrQl0uGQd36OvAQrL+CG+i7exCtCCHxnV?=
 =?us-ascii?Q?YS20oKgNKoZoIZm3bOWKQyPL8xO8/63MoC6Ou0/GPIHIWqeoS4bdxAdQ56R3?=
 =?us-ascii?Q?68hpfzXpaMDt07srdN6VDIolF9qOy3MNWq22Yb9LcJeDMyzM/Zbgu+IcDvNh?=
 =?us-ascii?Q?VljEbaLlA48NbjKOVhCL8VDIZ/AcUGO2R4y37ZJOorHqDsDh8FNx/N0AZxvz?=
 =?us-ascii?Q?g8HDzXJ8WB28TKAL7VAli9s4lxw017YelbZksK8oIhPGcFUarX4UEVlUCGRu?=
 =?us-ascii?Q?ljB0yR23dhwrTfWO4lSk53Kzs9oShPZ4gPVF09cRQp+a4AfSstitX8H1pdOo?=
 =?us-ascii?Q?GVkIa389i03frvcPV74FPyLUIOcLckRUJZ3R1eOwMolDOStJSFCTUpdIkNfo?=
 =?us-ascii?Q?y3uWQkdl3uVrsWrqsP2vz7iNEUk/Ypa4U7Z4iY5Jm+xhrCJAw6obA+U6DbXJ?=
 =?us-ascii?Q?9UQuIV5i4BrrofPYAGFpU5fV/xxtVRISKxr8jUEDc8Ttsa/It+IXctYknGdB?=
 =?us-ascii?Q?9NBV9S43mA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6af33a-4da2-437f-fd3d-08deeac5923f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 03:25:41.7605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHCiIsNN743dK0uyAN4+l4xWXIvT0GofpM+fE6CgQvuGuWgfHkpdhWe54VtPxu4LjBKPaIIQmhPwALLlNYfgJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB7849

When 'perf sched latency' is executed on a perf.data file that lacks
tracepoint samples (i.e., a file recorded without the -R flag or
containing only non-tracepoint events), perf_session__has_traces()
correctly outputs an error message. However, perf_sched__read_events()
subsequently falls through and returns 0 (success).

Consequently, caller functions such as perf_sched__lat() assume event
processing succeeded and proceed to render empty latency header tables
and total summary statistics.

Fix this behaviour by ensuring perf_sched__read_events() aborts early
and returns a suitable error code when perf_session__has_traces()
evaluates to false. This prevents superfluous table output from being
generated when no trace data is available.

Fixes: 27295592c22e ("perf session: Share the common trace sample_check routine as perf_session__has_traces")
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-sched.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 7fd63a9db457..b3cf678573e0 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
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
2.54.0

