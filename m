Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888E12E7BD3;
	Wed,  1 Apr 2026 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775025724; cv=fail; b=YV9IqWeLGZJwh7cwbb60iPhvRfuOIucM1ac9oMOgnTc5b00+NTgYwveR+48a22HCXfXclLF+MaNUMMImBJ4USrNHElVn7G+KVvQzFsMBRaJrpgDuRvukbSIVtSN3ev8/Qk5XmjqHkhaOG/hU5bq1YUvRcCSh+KrYKypgxXxmYQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775025724; c=relaxed/simple;
	bh=gysk5PzM8xy+Q7jL9jj4JMDWQYDhlGjl5j0n97OEgCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNAwuyesf6W1/MLmod0B7c9Zk/AIKHR26J6kTN0Iv/Q7/hlPopaaECibIvL3dXZLtIz6hLc9ohXrQUZVmqlwwUrwvdZPXrTeEXnajv4rUBiJ/sB8im5ZPfcs05cm3lhukNRVNT/u/4JfWZ3pSdjorSnq7tgQ4uUPOsjh391KNuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eSPrF5Jx; arc=fail smtp.client-ip=52.101.43.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eSPrF5Jx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEAS8tcTixfUgpw5PrApNgD6bGzCs2TjAx2QYJ6XoFCBEjPHCbQr3m2stwCnwWkVQ/LXeHJKh/KzL8yXMwT6maGIq5PE2Z9I2gKMBdYBglcgFKec0Pb6LgG73NjK/B9kQ3AvXhddHHbCm1HrN3LmAfQHTNjFOqXGFYzxTpTnzGIa7pVfyKZ5hqgw6chylhs7BiTLJh+YY87qBwhxXMymanGbRuKnnxV4W+d6X7hOyR50zdb+vIrw9XrAZArR1ORzTmkRJ97Vqq9fCl69cyPRU6a6tTb4h7C1U0+PgbfcXLRM5PcTjvQ7gA77obPOJv0OyjHgnZn6ywtKxZsEKtJhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7r8Ew8WI9jqRiEjJse/Wc/puMIs1UxeBgQJ4bCCvWCY=;
 b=OAqhSwNQrkZLGqlZdCvaNEzFmX5V5o3YzSO5RTGLIMnkIMCe/IBPzxxbeUuRtJnXAvPNo6UaByXOPr10b8udszoZ9NViLGn9AdI50ha/WuKVuT3hc5DlOYcUiR2EyqXpK8m8ZIeN+4VQ2g88hDQicvtB3FIp100w7LXzj945sGhAlAOs1/1xm2NE7PQsdttAaB46Wmmkm2Q32lG3Cj6tlmM+r9kwwokGUtLqwZwFlxGBYt2trzrq/TKxxsZI8OysIFS+bc3ZGB5B28luCOMwfRntrb4FxwwqEJzmp7ctyA49gxV8o6mzxFtwIIAlAfK82nKbw7Bapar5upvvrARmig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7r8Ew8WI9jqRiEjJse/Wc/puMIs1UxeBgQJ4bCCvWCY=;
 b=eSPrF5JxkhAYsURscZZpFnc5eU943NDw3nziI9DU2HctiPMztcaWgtSfKmJhV7M8tMX9iPrPhNnp86P8J7+jXwn9fC6heijyMv8C1cqWFGV3bs0VnVW9MNrPBQc+EHQuAulKs/Ajy/gl/OZ4mWuK7ttqsIX5TF1K7qnfzDHtJIY=
Received: from CH2PR18CA0029.namprd18.prod.outlook.com (2603:10b6:610:4f::39)
 by IA4PR12MB9809.namprd12.prod.outlook.com (2603:10b6:208:54f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 06:41:59 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::60) by CH2PR18CA0029.outlook.office365.com
 (2603:10b6:610:4f::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 06:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 06:41:58 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 01:41:53 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <gautham.shenoy@amd.com>,
	<ravi.bangoria@amd.com>, <KPrateek.Nayak@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
Subject: [PATCH 1/3] perf sched stats: Fix SIGCHLD race in schedstat_record()
Date: Wed, 1 Apr 2026 06:41:12 +0000
Message-ID: <20260401064114.141066-2-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401064114.141066-1-swapnil.sapkal@amd.com>
References: <20260401064114.141066-1-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|IA4PR12MB9809:EE_
X-MS-Office365-Filtering-Correlation-Id: cc227432-c873-422a-ddcc-08de8fb9c5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	QJIeaQRX5WilMZ5i35sGGICgi33Vl3+jZJ2ql7P+Qo/tbwUMM9pY71dljwTMnJM9jIV/eJ6BK3RVwcrve8fnnispQFpG1YYTKRab9DeJZge6QJZV2Te2M3Zr+L7n6oaQVZZoxFlTNf1E+s4RJauHoQ5jYHH9GIyLT0mEh29z5BHxJCa27I0fuh0gZUTRAmFfMaQ0J1bkchX5i5GOBfoyiXDo1sJROKOYhiD3xGCDAfmkj3IlEEvAxu2qWmpPoAlesfBFI1b45vyNARXh9IYPUxOyvzpbS2EXGILUNC9/+/t8mMlzDYCpsk13S46tXnzd24rAismHJXVehcMJwmfZuPshAKe/s0NYDtrZE1B1+vIsYi88CEURxNghpOFq0aJIEaNLyORKVfyUD94bp0u5EzSLblODGHA6EBFiuxEIqgfm4/QTo9jsS7GKdFNtb+SZ107Y4o64fqtROnKrGKr0T3+LZjtmGeHABRb9bZ6uACLVzY+x6uFwHooLJq2VwFSKJeXIydqygkbEK5zu3FPvZ3uFScAQVlWVjKnzBok2Tke/J6+pasS6ex3emOfyMVPzzF+Btx8E2dcv1D5mkbsYVjHBDEMVUanMudAbehB9AORXU1RdrGqeXPgW3Gh8aAhjUeYhQ3jsSLVjgdocfs+B5GN7r9cMxtJ+cm0hd2thjoVY9igie37ljMGwYMc8a9Q2YL8anvwStb8dt+4P5evgrV4YXrOkfDDcW2hBMGCtPrm0YhJgg0/8A8YFfwWo1wzx+iMDso4TNT1rmc+PQEsa0g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EGA+SqJo2QQVhn9OuJmR6QgOyaPKdakbHkWt0jPSszEKR7SCBykYQqiGC83dwYKG4PCJ688jHLfuv0kJYj0HR5VbzORyAiNdUxV0aHhcIt5kz90RBal2+8A0PTUrl7y54rpf0cBFHMF0XD/3qzHQJCzjy2nrEFeqZM75Ajs/s+Yk4zDH380ErSI7eRWiLo29HuiE7tLe3GWwFvFOg+TWDwHzoMjWUn1yj9zWV5HUq7IIXpNwI+ynt/sj5dlJisaOvn0+vJSkPz2rIKiqq5pSBFUhgEqKHgTam+wXcD9Zq9AnIjhXAFhzajICrrroz85R9gDNkW0a2WTzaWv0XZvI2hciS+Uto8T2jRc1qtz7r6R1GoU3xupys273yNul+eRD4v+lk9z76Nev2lXuE1JMBmYgLVkp/6vQFcA3B2c9uN7eexNv8ecPrRW6cWnlGrNh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 06:41:58.3155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc227432-c873-422a-ddcc-08de8fb9c5d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9809

When a very short-lived workload is used with 'perf sched stats record',
the child process can exit and deliver SIGCHLD between
evlist__start_workload() and pause(). Since pause() only returns when a
signal is received while suspended, and the SIGCHLD has already been
delivered and handled by then, pause() blocks indefinitely.

Fix this by blocking SIGCHLD before starting the workload and replacing
pause() with sigsuspend(). sigsuspend() atomically unblocks SIGCHLD and
suspends the process, ensuring no signal is lost regardless of how
quickly the child exits.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 3f509cfdd58c..eb3702d98fd1 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3807,6 +3807,7 @@ const char *output_name;
 static int perf_sched__schedstat_record(struct perf_sched *sched,
 					int argc, const char **argv)
 {
+	sigset_t sigchld_mask, oldmask;
 	struct perf_session *session;
 	struct target target = {};
 	struct evlist *evlist;
@@ -3822,6 +3823,15 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
 	signal(SIGCHLD, sighandler);
 	signal(SIGTERM, sighandler);
 
+	/*
+	 * Block SIGCHLD early so that a short-lived workload cannot deliver
+	 * the signal before we are ready to wait for it. sigsuspend() below
+	 * will atomically unblock it.
+	 */
+	sigemptyset(&sigchld_mask);
+	sigaddset(&sigchld_mask, SIGCHLD);
+	sigprocmask(SIG_BLOCK, &sigchld_mask, &oldmask);
+
 	evlist = evlist__new();
 	if (!evlist)
 		return -ENOMEM;
@@ -3902,8 +3912,15 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
 	if (argc)
 		evlist__start_workload(evlist);
 
-	/* wait for signal */
-	pause();
+	/*
+	 * Use sigsuspend() instead of pause() to avoid a race where a
+	 * short-lived workload exits and delivers SIGCHLD before pause()
+	 * is entered, causing it to block indefinitely. sigsuspend()
+	 * atomically unblocks SIGCHLD (blocked above) and suspends,
+	 * ensuring no signal is lost.
+	 */
+	sigsuspend(&oldmask);
+	sigprocmask(SIG_SETMASK, &oldmask, NULL);
 
 	if (reset) {
 		err = disable_sched_schedstat();
-- 
2.43.0

