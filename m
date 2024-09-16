Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9416158545;
	Mon, 16 Sep 2024 16:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505389; cv=fail; b=iM76igPZwDGeE3kLPziWHswtweuwtjrPHr9heSvJMlzaw2ZvOfMwqpUVvFK1s42xaHML5MWnHQq20g6tXX+WVK/wXy1GYEz7bHw4/FvBsWn6ixTJqvdaGJSjgZ5a0Fl+fPFNf7LSYbY7EsnJc/xDszC1VUFsOMHJX6hGP9bUJh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505389; c=relaxed/simple;
	bh=lujTFRQjg9R6ZufJYgu4bwbEKRtDCVdPKcYTBVNey9k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVka7N3/UXv0PshykSE0cjCxSGOfG/03roBucI4Ck36Cgn1qg2fXPv+MftyL8hnnFNKJJU6hsSFJAdIRiWq4YWEofuyNa78FTo0X8nTLxHeaXSF1xx7jYllAGE7klq+GMmpyRzATdD52RrsXGeksNWohVfnJ7NbwwobuQM7+Mt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hnBuBvD8; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hnBuBvD8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHchqQ6d8a0KBpXa9QUUd/PLbl/JpvhfvwRe+on0AsBzf5JTWN6zUZ7JnBVWMrLJmsaR4qZAxfZLjAG85I/00wfSQw8ypEATjrBXk5hiqC1eg1GlPcUIUEMIMYyPzpBGKmASF8gTqQ/B7iwfhDxlHZ3eeLhsW4EARsKqTN4EnYcZ/6LUV1iSX4BXbW+RKkuCEnkc/DiLvasi9IiUvyeqOSXBlCwnnn5h11wpSLUTFm2TyQtUusQAePU95MO/1U3AuBygCX/MCTTw+eMvbouAEJ61InZUUslWgL2ziphQLKLlKQOhxjrh1IA4ki1OWHqtOZDb82+taR/OmbcPaBrheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4FuknXIPA/AzQ8XWz8rRWxh7WlgYLMFE13j2az6he8=;
 b=lWj6KhrtPXtVrDTCxBUp8TYfVlw8u82z2f0hmztJeMGw8RMYluHqE66iJ8a326xhHVHazbrHi4k3wJ6ow6ROzcZXVbyTvVeKNlKTa8DsiX3CPoNR7Lgi1ngPXXZ//oJzyheinRGXkhsgpaO0tvJqo4WcAU8QzBfYtrP82nnzM2P3SdLeFBiq6+h5XebTmkYk97HZl2lWzXUANZcYdlMoG8MWZzLwcsqAA5gMdiu/XYzguCuNwDkB95L1mn5bF9nwDBoyUrGEkee6xErb4h0GX39+/rs5rSilfFg+zHj3i1WTMtVt+36UAO1XmYibPfGhP4FotgyAbukONkuiQStfqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4FuknXIPA/AzQ8XWz8rRWxh7WlgYLMFE13j2az6he8=;
 b=hnBuBvD8ntcTzphrIdGv5nTfkeDeP1a2gvZ2YoSiuEGtV3bimHILk2bmh46KxX2TJBMXw4AdjkuN6qsNm047B2VUFo2eA7hOiTQxl5oz4ryLiz8KowHm0DWctErp/8+vcG3NsTTyZV4P7bwlyj1Agyf18BuDeQAuwcx9B4uzZaA=
Received: from SJ0PR13CA0128.namprd13.prod.outlook.com (2603:10b6:a03:2c6::13)
 by IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 16:49:41 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::5a) by SJ0PR13CA0128.outlook.office365.com
 (2603:10b6:a03:2c6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 16 Sep 2024 16:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 16:49:41 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 11:49:33 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>
CC: <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>, <yu.c.chen@intel.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<bristot@redhat.com>, <adrian.hunter@intel.com>, <james.clark@arm.com>,
	<kan.liang@linux.intel.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <juri.lelli@redhat.com>,
	<yangjihong@bytedance.com>, <void@manifault.com>, <tj@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 5/5] perf sched stats: Add support for live mode
Date: Mon, 16 Sep 2024 16:47:22 +0000
Message-ID: <20240916164722.1838-6-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240916164722.1838-1-ravi.bangoria@amd.com>
References: <20240916164722.1838-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|IA0PR12MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: fce5aa9f-7e51-4d13-b1c2-08dcd66f8f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3vvvSzl0J7Ciw6KHq4rucPB8jGfpAMio+/xCU3T90vB6XlmFQrBr2ySLhdur?=
 =?us-ascii?Q?Hyd/9RIS0ajxQiay3nAJDp6l2z2Uesy5536tas9vTOl3dgESPhyHSCFzIIGU?=
 =?us-ascii?Q?lnXCY7URJwEmDD8oaYmRTBtBg0LKOQOyN1koFc84anQxlIlj7UbmXaNj3qbZ?=
 =?us-ascii?Q?xZ0qbCeG59s2LkX5Sz5vq1X4KWkQ6Qn9NEElQo6Vyy9XcQ45s179kFb57tz4?=
 =?us-ascii?Q?liDtB7Q0mLj86bga89e7e6SkumPAKxLieZshGte2jzgXavEHvloWj5rWClcG?=
 =?us-ascii?Q?QQBgaVSc40N6IsF1ehbXAeEzp/U3MM6XhJgxvBdxZiRdo26RnrxeXgyXPzNn?=
 =?us-ascii?Q?hU9mkPPg1o8Ee4ssXNp/X2A7YJs9KfCLwjV3WU1+cpmIJq6F/XB243LBEloQ?=
 =?us-ascii?Q?ce/pS6kenziGWJN6OLRyCJGE80rbZDLqUdrGN5zWFEqW2EXN9Oej9PIVgFZD?=
 =?us-ascii?Q?5HhtCLw1yfmg4iQpcA+kGizjSp/H7yy0SMw/FX56wNk6pjJsDwGWilaJXn3+?=
 =?us-ascii?Q?LSFw7e21YkiMbz3XQDA43y9txrjDHkxSWo39kbcyBK59NNCXJ9Yc7zQ21hfT?=
 =?us-ascii?Q?zU1eGWj7BCKw0uJjpNw5JDMgNN2Li3K1oqgkYkB7710EUtTh9+h7KUWpbATr?=
 =?us-ascii?Q?7hwSzRZzAj0S5HiDykfUDyTVBEpRqJ+IjMp+czcONxj53B2R5Ek5vqHJTuIE?=
 =?us-ascii?Q?jIyZLH7HzKWJcdzAgPiVyltabvBk16DL+PAByg2cVP3uPWWyH8lgVZzQtDKQ?=
 =?us-ascii?Q?vOrn6YVaRNTOPaS6bVQPnQc8zm69/lHh6H4gllDGADeSTmpsq4EMnZvTyedw?=
 =?us-ascii?Q?wfYHkZSgzFGuhmliCewcz3iAKt9UHWocyLWPzocrSiqzH/nxxMdBUYE00LKm?=
 =?us-ascii?Q?mOS8lSHaevdRzH7xPbB/eaUwI0sZCIf3Kb8N3Icqzb6ZY8BhR9HonFXjqQEm?=
 =?us-ascii?Q?c4OcK6ZHVroYajPluaJOIdOlqyKsfOnDPR3T7fawd/6Ar6Eh2bzVlDEGT7Ig?=
 =?us-ascii?Q?HXunjgI6Kj0xfyS/u7sGJ6lKwHFBdBRb0jGwXLQ61iPGQ5RfFNvs6gsup6QI?=
 =?us-ascii?Q?8BjBU2g0ucy35bah7xSMimTWjt0gv++IcX+M85ohTtTmqdyGp6QsWBas/o/f?=
 =?us-ascii?Q?yVeAOP4iaJuUIT9v0OFVot8gN4wEkAkZ5jqk0+xL4nt0h2TO+P/7yPgQ1ydN?=
 =?us-ascii?Q?puXYAIrZ8FLCiuo9ED58MKAxqv/NpUj5h0U8tQWSothiAVgfV8tobdXO6h5g?=
 =?us-ascii?Q?v3ECivLuX7BHwRZQJStL4OXoCQ+PCLTEYfFfWo/Pa1mimA7h+papk1SL3G3x?=
 =?us-ascii?Q?WyEuH49lAlopidaG/NuqE5BNrTzzZ6h3FvNslMz6iE/xWi9ooeLH7rh0sI0E?=
 =?us-ascii?Q?AdPdq6jhQnImI2zHkG9FlYEHrDkoaJ/2S9jMr4Ewp5copkc8QYkNpI7RMjI6?=
 =?us-ascii?Q?giZHzapVz0zD6sM81hAI7G0RS9EZc08x?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 16:49:41.0736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce5aa9f-7e51-4d13-b1c2-08dcd66f8f35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8424

From: Swapnil Sapkal <swapnil.sapkal@amd.com>

The live mode works similar to simple `perf stat` command, by profiling
the target and printing results on the terminal as soon as the target
finishes.

Example usage:

  # perf sched stats -- sleep 10

Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/builtin-sched.c | 87 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index cd465644fce5..e888ae763eac 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4319,6 +4319,91 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
 	return err;
 }
 
+static int process_synthesized_event_live(const struct perf_tool *tool __maybe_unused,
+					  union perf_event *event,
+					  struct perf_sample *sample __maybe_unused,
+					  struct machine *machine __maybe_unused)
+{
+	return perf_sched__process_schedstat(NULL, event);
+}
+
+static int perf_sched__schedstat_live(struct perf_sched *sched,
+				      int argc, const char **argv)
+{
+	struct evlist *evlist;
+	struct target *target;
+	int reset = 0;
+	int err = 0;
+
+	signal(SIGINT, sighandler);
+	signal(SIGCHLD, sighandler);
+	signal(SIGTERM, sighandler);
+
+	evlist = evlist__new();
+	if (!evlist)
+		return -ENOMEM;
+
+	/*
+	 * `perf sched schedstat` does not support workload profiling (-p pid)
+	 * since /proc/schedstat file contains cpu specific data only. Hence, a
+	 * profile target is either set of cpus or systemwide, never a process.
+	 * Note that, although `-- <workload>` is supported, profile data are
+	 * still cpu/systemwide.
+	 */
+	target = zalloc(sizeof(struct target));
+	if (cpu_list)
+		target->cpu_list = cpu_list;
+	else
+		target->system_wide = true;
+
+	if (argc) {
+		err = evlist__prepare_workload(evlist, target, argv, false, NULL);
+		if (err)
+			goto out_target;
+	}
+
+	if (cpu_list) {
+		user_requested_cpus = perf_cpu_map__new(cpu_list);
+		if (!user_requested_cpus)
+			goto out_target;
+	}
+
+	err = perf_event__synthesize_schedstat(&(sched->tool),
+					       process_synthesized_event_live,
+					       user_requested_cpus);
+	if (err < 0)
+		goto out_target;
+
+	err = enable_sched_schedstats(&reset);
+	if (err < 0)
+		goto out_target;
+
+	if (argc)
+		evlist__start_workload(evlist);
+
+	/* wait for signal */
+	pause();
+
+	if (reset) {
+		err = disable_sched_schedstat();
+		if (err < 0)
+			goto out_target;
+	}
+
+	err = perf_event__synthesize_schedstat(&(sched->tool),
+					       process_synthesized_event_live,
+					       user_requested_cpus);
+	if (err)
+		goto out_target;
+
+	setup_pager();
+	show_schedstat_data();
+	free_schedstat();
+out_target:
+	free(target);
+	return err;
+}
+
 static bool schedstat_events_exposed(void)
 {
 	/*
@@ -4640,7 +4725,7 @@ int cmd_sched(int argc, const char **argv)
 						     stats_usage, 0);
 			return perf_sched__schedstat_report(&sched);
 		}
-		usage_with_options(stats_usage, stats_options);
+		return perf_sched__schedstat_live(&sched, argc, argv);
 	} else {
 		usage_with_options(sched_usage, sched_options);
 	}
-- 
2.46.0

