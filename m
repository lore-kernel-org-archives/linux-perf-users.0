Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022088.outbound.protection.outlook.com [52.101.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8716B3CB55B;
	Sat,  1 Aug 2026 23:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785627619; cv=fail; b=pZIs64iInvaEs1c0v21rJmxHYRQtNq+d+nCacb2CASnQJ45Fyh6mD8iqJ7pPDJ+Hd9WtTCgaAycxmDt62Ft6lyPYvsmqL61GHv06RMXXbT9U8qjLqXLNOE/IckpBOpKZuZ1KEgem5ICm3LazIvu9U4BGyF3JI5FAWb0qZ8IOvvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785627619; c=relaxed/simple;
	bh=jWS1rvOOmED8Kkbh6qPS0gFYwujmZrVL2GTKppTPAx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iRzAODZp3pC0SFX+Sckb3Mbv9YbfPvx0YG2v6JRwHNTShvs9HUJKPMAk98ISwExu+e404FSZyw4fnQexAFkJ5WYmwdJSe+sGbjN6K/osIx7VT4WmfJOzGqwHpfvagNHP9pREw4f+Ib+0sV8HxVKHaSBp5K+4O0uiYmMNceHI1Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoSexX0PwzgPsNRnsqT0pu71ZLstivgx7ptY6AM5SYn7/jSUKUY3dAYMZRrb6/UPGf/dR0fOn/lhjjQ6MmwHqPGy0Uu0ePzWtXvSfddcgwI/2axnp4xO0J6PNGqtuUnYVHVuZ48VzYcRNQurg8GfSsw1vG4DTjIGYy0GTiJWvXGHnPeuMibmpQLm4KyiIM+erEV8ksQ+tPbqexSOGJb9n1UYz4SwagtvKTmX/Ggw6EFggWzVGyDqzNgezQLnPPf+XDEp0Q351bRn9dzkosPjl+oXk2POw9b0jgEUum4KFmh5XJXCoQIZIcYcC9ngLwrN3chs6TuLIMMdvGtSrDhH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=Djxij0QPX/LW/PbeRhCP31Au7MuCtAOAHsIkgDHtErk=;
 b=s1RptnyyuH4DtthWGOZC0wm+4HddcGmeUu72icC4Diqyruivdtl6kZrgsFgusKT59tj5ae/fxXGVpyFZIjV9Xl1qOy+JkbKEWrP8+0hhxpJcoRpf2bdyXsbhuYoCh/k4DDZZUzT1fUdLSXp2y6Nhm3Gp1//gZRtVRu8DWhCWhW0pbjeFEDu8PVHIQJnREAUCQGYz+hRrEG/+ES19qpln4KMcXHCho/3/7+OxWJiQAc8oM2as8HEf/AJ0nFlcbeXDwEsyZ1jKrttZ/HwcHTotZhHHY+Zy4TRPlVDUneqph6pMdEqhw9IbCDXTwW1zWZmwcQOFQsHYo7uOejs1eUyQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOBP123MB8812.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:480::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sat, 1 Aug
 2026 23:40:15 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.016; Sat, 1 Aug 2026
 23:40:15 +0000
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
Subject: [PATCH v6 1/4] perf sched: Suppress latency table output when trace samples are missing
Date: Sat,  1 Aug 2026 19:40:05 -0400
Message-ID: <20260801234008.176724-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801234008.176724-1-atomlin@atomlin.com>
References: <20260801234008.176724-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:408:e4::20) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOBP123MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb4323c-767b-47f2-30b3-08def0263d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|22082099003|3023799007|6133799003|56012099006|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	L24hwZNw5+CWZqd7GiCHoaqXD8PKChs0+Sznau6nJ1+SLBr0PRFg+JxmWmqbBiUSLreNN+ENhHI1+SE6o07VUKB+0clX7LfS8jIP652qdNVFhb7yKs1bNLrMjO93mRwxHrGGxWv7YdWx9UNFJKATYpPqXoPwB46idx7vs9aUp1SuJpEDrwnn22zCltj98NbNuxfOxcDyJtFoJ0M++e2y2rMXOz7PrenZwpIX7YKFcvFNvImsq96tA7uz7wuG7rsaoUyFEpVBqw3riaTwMD7COdcifrasAJDCicehFufRV36c4pOG/X9kG35ouOEpqa/a7pK179+9gRMNhjAbhsj/2hRpXgNaPe6O4AfEr700exRvk+0I9bGuo8tFRHGZR4jDiz9xAI9MUmqubQSlz4iSUS/8Du2jcZ2IUTpLY6ow/6Xp4rrmHmU4ZJOIzHp1UOf9SDipAme5P3JHie/e1xUDZdz6r03L8zFqHxPwaJnRh8On0O5O3cEdBFadN0o3mGAFk2CYl4h0x4NwRjghJ3N2+ijJoUyy2zyqJEhrYQqTfNKrn2+B1/RtV+vcD68NRqqQI/4sL/4xumygEnz2K5rOiBJOQrmkvNrhQvXwEYhO7cWuUiZVoKgpezUeUJKwrXzapbx5xTSD0oiUhMgE4kdC8R596HSySHKcoh6kxuMsJZ4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(3023799007)(6133799003)(56012099006)(10067099003)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bkez/EObsy/1L93OwhU6y4tMfIV8AYFfoYGBT1YFUEldE31POmWrzY4tNOK6?=
 =?us-ascii?Q?bA7Go0RecRUYqoajasKWjQeHpQjQJd1NtcVNVcIuntjNoDVlUw2HJwRUOxMf?=
 =?us-ascii?Q?LffDN+T0z0IG4a6dcAZvq1Q8/fCimHLAZY44mFhN1g74twemLMuO7RlPtVhY?=
 =?us-ascii?Q?LKvx6oEKx/Az+qRc8uN2JtqSSCbzUvf8KTcAL19Qt31Q0JWElCOBZAGS2HYY?=
 =?us-ascii?Q?OEsr3CXd+g6XzVgrKrUzSnAncwmXEfbYNJo1qw1JW5KSw+6YZ1mMiTAb0n7s?=
 =?us-ascii?Q?flvlMcz6VpfZSPvGxCtgJyPIyaDukTZ/JXIECEOqC/0dHgzaL2lCrQL8bU6D?=
 =?us-ascii?Q?C6L1deCmh9q5pvvCGoXDESixtH1LdUaY5j7UJmK9SyOJutLS0ir4tG5GXpEA?=
 =?us-ascii?Q?z14wftMbNDGgAu8pOTb24VsrWs3E1KuIPyhAg9Mst+b8eKfC8W7mUb1mxn+i?=
 =?us-ascii?Q?/Id8oaEbl4NF0L2+QsUZsr3ZAS1ol+yLYQGEXkVSt7CZqn/fQ5mICBLgT41d?=
 =?us-ascii?Q?7KglIhmtikjcEB1J453kD+jZmpra/YaE8nlTz+Ui+jGoYG1voG0xereZlwOT?=
 =?us-ascii?Q?psh5B/Q3WEZE/lYzGxsLv2ItWpZO+2DS+NYaCA9vS9x0/Rho2rEQKs7S3CpQ?=
 =?us-ascii?Q?zR8R3lUuGQnQyKnJHStd22ta07n7ZcIkuPcuiQv4con4UXHWNbnk7orDAf7y?=
 =?us-ascii?Q?xPHPl7Ic6QL/8GYrTXd3F2UWzdd2PaEWQgYLp+4ytKmBemdYLDKvyMn5UOeq?=
 =?us-ascii?Q?crjSQWo0wipXvSmB+3L7BC5/ay1HOLKOFdSQ9wWU9rrl3oQg5vW1xwEHhYIw?=
 =?us-ascii?Q?hygsMbaF+bwqDa6nBWZKu47ThDxrzMXCjpZRMaLFu+CqGHohZUokSvnG92Lr?=
 =?us-ascii?Q?LABRoyQNg+N7UpH+9CA7uqe77rOh/UDl16CsRdedGpWqWaWZVOPUTY55k/Lr?=
 =?us-ascii?Q?qbSQDSudnqZuKErqHhlOb79Wq/ZDveAeU1gtfQfYbvSS7KI3I36YuWoP4Mus?=
 =?us-ascii?Q?xa50ZPEtKENOt7NvBR+VIeexsHEsA1UKz0XVl6ETFWJnaVeCALWBqn7pZ5pb?=
 =?us-ascii?Q?Lg67LCmq/5F+CV72DHoig26LoViZAj0f9m36NE6TWiSpdwKyQRgdF5x48Qo0?=
 =?us-ascii?Q?tTD9u+V6Qvmpbn0Tvgkc7elXH7mGMjyn0loRwbprG/qCntQO5dRScb4JRdRv?=
 =?us-ascii?Q?bucprQ88KwGKg9mnbM9FXDXiL9NYgmKw90k02KuTaoVyXtpA/NIHWFJpVqh5?=
 =?us-ascii?Q?E7m8GVrDtrq80dkpmsLvuDvLG3KKWdD4t0KB+KHpbdG9Fa57rHtRWFBVu4kP?=
 =?us-ascii?Q?W83LD19NW/kQKqoHQCCi1P87plPQbsjS1VfKe/qP0yUCile8Qk4P0bQE60Z6?=
 =?us-ascii?Q?OrEXQeyqdprB4s6N3UtR/bLtdqQ2ngZOlzNdiust+Eyg3Xs6NwCMIvhW4DH8?=
 =?us-ascii?Q?1FrQoh4z1U9tIKg6dd9yRg8RCIK9PM0eWHnHmB2vjH33ZqBbV/4D5IqBv1vB?=
 =?us-ascii?Q?yfgR8Wa5GxKPqWRGn1h5oNXyGtSd312Rj4eNnLHXFhFEnCEO8xfGDlA1+Dzi?=
 =?us-ascii?Q?hobULkrRwCrU/1qKVQ5TJVlu+cWmC0mQylZ8FLj1FUZ5Zlc3iAgl3fKDRL3e?=
 =?us-ascii?Q?yAvkQfWTSN8k/dSkcpNxmjgdgVlWBpdfQP5/F14d85mB+0QvpxYES7IS1JGD?=
 =?us-ascii?Q?gCCT+5Md9X2HP9c1Zi+dmq5ZKF1BJX+nZLHTT5XYABWOuGo8U0S08aPeQCqO?=
 =?us-ascii?Q?xBD7xaP51Q=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb4323c-767b-47f2-30b3-08def0263d04
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 23:40:15.7911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvwfnrWFzJHrcvqgqtArNpnsV9/m9gryi0k0AUKwlUY8S2uaFobyDT4cXGXbtF5FKn6nBCGYu3rbO04nBLmWuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8812

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

