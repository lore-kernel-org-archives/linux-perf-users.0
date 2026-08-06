Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022139.outbound.protection.outlook.com [52.101.101.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0E747D448;
	Thu,  6 Aug 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030779; cv=fail; b=qq0Eoc7N4Xb1WNUyrwQTE6MWTdkEVmdMcCQgnt7D18H+Jp1BQzFOhFCmeVklMKIIynN0lNa2FTbivHzmP0P6QJnF45UNoEpJqMuiu0KjUOTPCHOh8rkD93BLfid+tP8N9KUKnstjwBcH6Y9y6xFGV7Xi9iijFGpa3mg6WRjhmkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030779; c=relaxed/simple;
	bh=xWF1LP2ROpew8LwQwGdc3E2JGECMcOZqUFmO0oqmVYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DsnvTle6tGtN9lXHWmPLhysqBI9/YZdeMpBIMMmO5Xy4+WxQqDhsMsLrpHe/KopHaWyZLcrqBEy8Rwdifv/JxbcIx/wwkbGWKyymxOhlbcwRSGavowEBGNFQuS4kuTDGD7NpczGNj1NI5ZC6qRQjwQLkiqys+F26EKbRNuMYS6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=magpWVUbmmXiecbAwuQQ8k/nmqzmHnBpEy6J16L4O9sJVnI7HBJ1QMsljmTbNU4Pdfwf0DdnCo7ZcuDq05b0m16gvWb67fW0UuJSemEzGCYDURqdXT6b1WiZ9pAZcPWTGPhMzeEjyzEMs1lvOde3uf+Ta7nS0iRLTCTITyHCM0ttjcQH4hAAso2sX5F5x753IHR7d9eDA6BssUQfTdfF+FJLn0QCiZ8p60ZYUC8y20CPNBhsc9lF89dpY8ogxGlZI0PiNdP/5l0TbU20+BYfit6UOP/FD0SgnW00JDd7W3IRl7Ps9LWIIcsukGUJ2ItMd6Gvscp6Z/ZXxUqIEMxC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=h+POsusymliilSiEeAO118y/sq/tX0jGzeJYVwLiJY4=;
 b=ZswziyN+26eAfovd3IvpSnjIvlaP6mqK/HZdHQ7XMcX31fTbScOe01RyR3mo4SqZ+MYbTbnvHMcDWz/vikr0t4gvi9bs2FgNsYBNuQA/fK3bFt9sr/x8RkdURcW3GNVPtAvOIOJrs5QLoOCR0sbY+dggT1Rymr/K8ZRuYigFH5lQaGWP2mzeosoEdeL/sXqdanl54sDiZl9D/107uCy/bgHdhSrngcPxLdzwi0ftELvRuw8pK/HN7JKf7VB3GjdIy4AgdLNJFtyg+jrnN3KY5kyn6gY+ZFqJVasZrgQZJyEL+qLwcsAuhC9jwANq/YbDmfj6LX9dG5P7meM96UOtNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO4P123MB6694.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 15:39:33 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 15:39:33 +0000
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
Subject: [PATCH v9 1/4] perf sched: Suppress latency table output when trace samples are missing
Date: Thu,  6 Aug 2026 11:39:23 -0400
Message-ID: <20260806153926.300499-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806153926.300499-1-atomlin@atomlin.com>
References: <20260806153926.300499-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA4P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::6) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO4P123MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: d438d7de-9e18-4247-dae4-08def3d0e999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|56012099006|5023799004|10067099003|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	tG5HI6qoDB9rpTqxvbqzIaqLnqVgF0bZSLU4/CSKurv9TJEVyEilBDlcG44CzqZXF+bYSI+lUp4LpwAqd6Kzlk8YjeAh7EonUH0DB5GO/WnIo3qxJbXN8Il/nnz/hDB6XAPvc++4E3iKOq9bn1cThm+K9HMxgUlpynxdNzgJAKVxYKuDAK2ugGMKZv/TRtfCaxHiASvaX2iguxDjfVhGUoux+3zChUA1jmejDO/A5YIYSpwUxNg2WszY9NbiK7EPMyD/Yo/iBvOHJg6vZQzhSchvGnXyTbQR7jt2xP5AaYcHOh17yMqEaIbLPV+8vu1VCzEo8zh6VMR+Ki7vhPXeKMjjDCZvioYOjGYvE3J3+ckdJjulbAM2HX3r2etAbYkZ9+qBvgmCGM2wWAoK5AWd4SSHhmJd/F7KhCM7QwzbL+CVPQcBoZjVDIPGs6gNuj5fS52GljAlJOgp3nrFwILn26CKpr1izkxnytuDHZxkc26K+IuVX7XefuyPo84n7oUhL8xyKMYqL5Gh746K5U0HfmNLLSF9deVRdhn1bTZa3V7HKjyM5bZH8kqqxuiErfOr0T8hpRMH1rouGmjUzFRveCQ5rgNW4+2hu/TPkTmMBG1mvZW4wqZ26hdWXic7Ez71b84Cy6qxgIMD3BA4mEiJP+al7+7N4XiGjCHc1pFo1jU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(56012099006)(5023799004)(10067099003)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i9pZH5fEwnK1FDmybK7Cyc7OUZZXsTBolfwsu3LuJKsBJJerBHhZWAKFRZAc?=
 =?us-ascii?Q?eWbmiQVaEZXwD90HxExooJ5DtFfbCHf0ZBWogPd6fJcMe5AERE3QFzFjLYa7?=
 =?us-ascii?Q?uKeF3EnouqeZp8dDK+2wEuH2MeZqady/Gw/Rh6hBGOcHaZpHjBBFKcGcLb7n?=
 =?us-ascii?Q?ibVydNUfpd7CuyvDO/70uASJ4XosoyZ74o5lwywI/Pp9YB5U6hnBZVL4fNID?=
 =?us-ascii?Q?AloXE9CCQ0coSphb1Z7hJqGclKqBiwZsnrX8CK70wD4bjs17keKBWnQK9IbR?=
 =?us-ascii?Q?sEE5fKFdo2JZDKJUod1Relp+Hv7oFb0/CURXYTq7BhuHEVdW/r/DJDRDpj2c?=
 =?us-ascii?Q?pBaXCjhcwu+bR165IEquxXMVguX0jJJC3BKG9weW4tXgmZIemcdiGmGEJfLX?=
 =?us-ascii?Q?Oi9fnfrjmGOEjs7Z5MbRbzQ3iZAzJLxc2OUultF5mtmj2OzUlQyUpyrXi7XD?=
 =?us-ascii?Q?Una8sHUr8nzFtVjqpCDOz/o2NuzJOiw9ar2PDiBtQ212/as4oOLyFThKBVtf?=
 =?us-ascii?Q?huLyZnZQbEc1YdnI6Tjs2Z9/KPbRjmBdMArjpmVj0374NVWBAdFOz519nh/D?=
 =?us-ascii?Q?qBXtbsj1tXRpft7h/l0S1bGqAveQPb0ZyVhm0FmmHoTUxsUofmVGNLN3DdbS?=
 =?us-ascii?Q?3+th6/+j3/z5A7/Kv2wWyfOhv/UvBvV7mlZ/UcbwRz7ItoHJRfNYfp2IkTYP?=
 =?us-ascii?Q?K3mHCvcIjSauj4pMV4/gNAAUX12BqN3JmlY9Gj4V7mKTuJ4gFIjsrEJcWkRt?=
 =?us-ascii?Q?FrLxgz+kOkoyLzS/7UXCS8kyDEoWdf8mh2H+J9LXQxvXbVfY5dQyKC3T2Spt?=
 =?us-ascii?Q?n4nuAkObV2Ma77pg++LmuBDe+X9lcPNm6z09CUO2wZIUI6wtAbG226nLYXUc?=
 =?us-ascii?Q?lBofqf/QSIL+vvGcmITTZa28wOyR4cFs0P4HCOet1h5Ye5Wg5LoXaKafn1d9?=
 =?us-ascii?Q?v6n/33Vwi45xUzKLOl1Yum87MOJ+M9Y4RoxjXf6EHZWwrYiipQeoJNW8z1Jr?=
 =?us-ascii?Q?o9KVpMfrHRooX3GYXF+6kNCzpaVXCZQtd7wI0ahf4nunN3WVwOnt9/mTgR9+?=
 =?us-ascii?Q?PPMQUqgIx7NRwBiLWZc1++L/fL9tL6idhE0AVu/3zHhfP5A2AsC6z8F/8BxV?=
 =?us-ascii?Q?sZ4HvawgTtJFH6R18Uk9yGhkpG4WM2JmUDf28KeiCOpxAiwKnBVfHZJHPHNp?=
 =?us-ascii?Q?Id/zCOXmmSd1utctNEGCkT8+DlBjcvjDiYzUXrO+fFc+I+daaWTOXaY18GAa?=
 =?us-ascii?Q?Fa7ILbfiRboNhcHFGth7EXbtY5QqNuuWaq+1C2J/lP8VnV9bs6fky2x7rIxu?=
 =?us-ascii?Q?CUdYqYOTgPtBk2J/+vV+Oxb3N8W/WQS8IOq74/4xJEREn2KX4/JNq1NLnJE9?=
 =?us-ascii?Q?o89gpqQQOl9L3wD7XHzUsRsoFnG9Gd9t6+w8Ox1kCjcE62y2K/Y5wxpKQ83U?=
 =?us-ascii?Q?snr6khG6pzq83gxJAMut8TqqVxssNDEIHViHYwvhQVlQzBwqXY7fMM5y6v/A?=
 =?us-ascii?Q?Oc4kqZPujhv+2pzcEV3NeMTrdmQz+23H80Ih1eTyYM4QdHF7xHqlerPCh20n?=
 =?us-ascii?Q?pW0oNy6baS834GKLSRGZGNg2fK8bshlwGxCCIUy2FJE8ulQXZeuwwactSCI/?=
 =?us-ascii?Q?14tUlfWMFupZhD0K9rSGKetDNWeRB5R6MdCFssMFKSzHEU33uURsl26vCxfV?=
 =?us-ascii?Q?3rMkXpxi316sQKWWOrdMdow50YyO8pEXu9+KhnFC+ynkNbzELvZHHkfI7UMb?=
 =?us-ascii?Q?xI/94ufwkg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d438d7de-9e18-4247-dae4-08def3d0e999
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 15:39:33.2673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbcqv/UhcTZzp7lpwSZPG2auFcWqFJHyjI9pAMId/pifHienv5j79OoZ9QA1yTrH9gR4MMvsQGOtX006x4XmpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6694

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
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-sched.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index acc8d81a20d3..39a375ef209a 100644
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
 
-		sched->nr_events      = evlist__stats(session->evlist)->nr_events[0];
-		sched->nr_lost_events = evlist__stats(session->evlist)->total_lost;
-		sched->nr_lost_chunks = evlist__stats(session->evlist)->nr_events[PERF_RECORD_LOST];
+	err = perf_session__process_events(session);
+	if (err) {
+		pr_err("Failed to process events, error %d", err);
+		goto out_delete;
 	}
 
+	sched->nr_events      = evlist__stats(session->evlist)->nr_events[0];
+	sched->nr_lost_events = evlist__stats(session->evlist)->total_lost;
+	sched->nr_lost_chunks = evlist__stats(session->evlist)->nr_events[PERF_RECORD_LOST];
+
 	rc = 0;
 out_delete:
 	perf_session__delete(session);
-- 
2.55.0

