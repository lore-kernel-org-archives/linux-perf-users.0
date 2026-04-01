Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E856236453;
	Wed,  1 Apr 2026 06:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775025768; cv=fail; b=qZXVyQzXLdtOMPApeKN41o31MA47izCMFfMI7qq+O9OpSibwhx63S9vduB9rhVmD8Uc/TMuuuHrk3c1t/GjziOmHj4aCE33Brz6j58oz9waSWQXQHcXKXRZcK6lFqp6NiRGcus8CZ0YnuCx+H1Dz4FqTDP0YaPEeKXYIoOWijqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775025768; c=relaxed/simple;
	bh=dN1EA5QRqfV9BFMXTpdFYlMia/qKoLp9Eh7WKjB5q/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpZVTAJ21dtGlnTPIs61/A6gkCXmcimREuRApXZPzCwnNaTpyFvLJolKr7cbBEpE5bS45GkrFPwnDfz5JKt9HMMPuAnFPVKtSEQLgIfuFK6B1+csUG/lIqAHVWyM/CCBElSBxXMKpkSPSEzGXwOdeoo2FolGc0cF53oLD5bVPVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XljyU8+M; arc=fail smtp.client-ip=40.107.208.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XljyU8+M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9Zt2dGZC+LU5ahRQW+YfJfv/vSt5fg1cBevJj2JEr4VP+ZxFFjH58Cbl3NQyq8+kivA9nCWl5cqQuuVi81k+pyySRijGXIOW5qNxjMkDXz2DypdWEdDkEu7Gx2cZHeqyj9N9s4F7kvjhhrnrtItz/TjJ33HqZfIKq3iIwHZuTCFUZLgiqLlvA2MWBcB0NBdPDIpqnVz+whn+kS/YwPaDM+RLqYpXC0SCOotvkVNnhFf8i4saKfltbmLZ/AEcnrWiHl6qCDYISTh3fsCyJhhc13la64EDzvMoE2cHl+RmCakMH1gU0eeXU1xaDh7MofXBn6Flfc1x1rYWCEBHaEAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnrRHe83yZfbDDdlgIEsby/7yU1++1HtyUa6z8KxTok=;
 b=HyohhELhU7ZohLUOfpOgm8alyjAobC2lgHKfGpaKcY7dp0VtuGwUoNNNYRiOwfw6HRRkzPlEHwr3iSwpN6s7N1XCXagPVwJxhm5b8gD/CGYWQoT/40PCV5Qrz3i2+CjtaZeVtDI3sHFHPvLSA2IbTGIGHmWWFCZmBBkeTW0KZj3UotM1NrWsGZ6UGNGSAt2uXGTuFzc5j2CzCQSGkxd5d2PNN4ZmGIbLBKJ4/IM+qPKaM+GN2Pap5l8N1GWoVCrViUF20bO7yJUzqbg0mCnnhvYh1X1y1N7Ss8Bziv2Ltbithx4uChfwqCmyCuupZdaZr0XUu/JfCOWuc6J9qmsXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnrRHe83yZfbDDdlgIEsby/7yU1++1HtyUa6z8KxTok=;
 b=XljyU8+M9mLs/JAF8kSMklL4REh4TcmlgohwAa4P5SOehKlM1SWUD8J8TfarO9HPn9CxXgnPZxs5jYBekKauJsEKtoKT/w2hiMFOU/mrysitr8AaE5Qb4JiT1cqcaaSKdTnDMIN9FNEo+YU1VUxNBebz91ndkvSIgWFwOrUHm0g=
Received: from CH2PR11CA0028.namprd11.prod.outlook.com (2603:10b6:610:54::38)
 by CY8PR12MB7660.namprd12.prod.outlook.com (2603:10b6:930:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 06:42:44 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::c2) by CH2PR11CA0028.outlook.office365.com
 (2603:10b6:610:54::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Wed,
 1 Apr 2026 06:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 06:42:42 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 01:42:38 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <gautham.shenoy@amd.com>,
	<ravi.bangoria@amd.com>, <KPrateek.Nayak@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
Subject: [PATCH 3/3] perf lock contention: Fix SIGCHLD race in __cmd_contention()
Date: Wed, 1 Apr 2026 06:41:14 +0000
Message-ID: <20260401064114.141066-4-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|CY8PR12MB7660:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e856b32-58e6-4c31-3750-08de8fb9e057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JzrqcqGqStlCqM7a+NVa7/hoYeje5KsGu3rTdBE2Mp6tjVdURiQP8X5Xj/Uc+WES31PakIa4F3hu/kXCSPPLl7pwqiRi8+luADoWBphd2dsDKl4ghnhBfYmcXspxOlvnv4zriiOlsilZL7pSv+Qb+OOHgqtjFEjiDwYozy/zJiul8Fx9tK0SV9cfKe5bNAoRWuq01mx7ZzTi9Zj2cPQYk1LfOg7+qaGcus6MSw01nMlpGCxMLCZ3eX9FwWubUYcndYX8nBqmLd+TfMB6sIOitOJS/gUVnD1uaURHj/a84amCl7uVxAHSSvhEWm/3c9BI4F6QF1EyaRucoyN7lo1HyzA/uuH7E7ajzBIwN7kHmB8BCRwSlaZLf/40JTM10GK8Db3KHIjKkdFYLu6lKcrYQR7KXmWGT83ZzxcoNhVK7QmjGvlpyFdzZ8RQUQ8c5ZLJVYMUiRV22j5GRv2Ev63xy/IMBG2BAmnQTcSwrd6iFMivJ7wQGaTAvXwm8SBKm5yZsyfWA1NUdJFGTQEdpEczx4Nld0Gw3U5/dgb6YaMuTIRjXapMJzGXpBkSdzWkZRoFkBKceUJPdArxLHJ3sDkBYrQ6vKpcz+x+jzbf1rLuh4GWfiYRpULx0TC66k+i3KzBwzBRMKk3PTtqGfFuWsmp8bZK8qqf2utMzXsd/FnVT6wR+V45efX9N1LVVf73Ijb93QaUkhaKyohramzFNcgykTwx1/9BYfENWAgjbZmV3sjuoaRjJixLl64mXC4bM7bK7+8FKdzhXdie0I9DM5qElg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S1hFxT60yJJ4qjLNSdchzo5xeADxCpnx3OOqMoW6UhI0M1OYe0vbi7me34w8UsiGHF/qg2+SCVLrvTCQEcleC9rM/CozqVqAE0QlXOKQ3NnyG9niiKZfUwlDFvFWeH1XviGwuJ3hEmhtXcWBU664ARnNqFeb7PQf82NCKY20nQaDwePE9Hyx8bzeDlexIAGvCS1j2/vM3fy600MxX2Cs4LtSr+3JxlajkxPgo2K4SSozPHVW4KXjOcgaJXLnVZGDkQe5YUll95S4iGCj6X01km9vHqTEvnjeXeK0YXsqB4PVM9O/EiP4Q++Vpt8JR8Ng6qGhwxJck8ahH0ugtiu5hj238wMw9WB2LuUhU9g6AlXbdgeuTF64UzGEBkrItpsjxtpXmcuY5guOn1Nc/azdM66fkTF71c+S9DyzrlZ0v/tX78T560zDPGXk4qkKxQhv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 06:42:42.8184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e856b32-58e6-4c31-3750-08de8fb9e057
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7660

__cmd_contention() in builtin-lock.c has the same signal race condition
as the perf sched stats code paths. When running with a short-lived
workload via 'perf lock contention -- <cmd>', the child can exit and
deliver SIGCHLD before pause() is entered, causing an indefinite hang.

Fix this by blocking SIGCHLD before starting the workload and replacing
pause() with sigsuspend() to atomically unblock and wait.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-lock.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index e8962c985d34..1bada9833c93 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1991,6 +1991,7 @@ static int check_lock_contention_options(const struct option *options,
 
 static int __cmd_contention(int argc, const char **argv)
 {
+	sigset_t sigchld_mask, oldmask;
 	int err = -EINVAL;
 	struct perf_tool eops;
 	struct perf_data data = {
@@ -2064,6 +2065,15 @@ static int __cmd_contention(int argc, const char **argv)
 		signal(SIGCHLD, sighandler);
 		signal(SIGTERM, sighandler);
 
+		/*
+		 * Block SIGCHLD early so that a short-lived workload
+		 * cannot deliver the signal before sigsuspend() is
+		 * entered below.
+		 */
+		sigemptyset(&sigchld_mask);
+		sigaddset(&sigchld_mask, SIGCHLD);
+		sigprocmask(SIG_BLOCK, &sigchld_mask, &oldmask);
+
 		con.evlist = evlist__new();
 		if (con.evlist == NULL) {
 			err = -ENOMEM;
@@ -2127,8 +2137,14 @@ static int __cmd_contention(int argc, const char **argv)
 		if (argc)
 			evlist__start_workload(con.evlist);
 
-		/* wait for signal */
-		pause();
+		/*
+		 * Use sigsuspend() instead of pause() to avoid a race
+		 * where a short-lived workload exits and delivers SIGCHLD
+		 * before pause() is entered. sigsuspend() atomically
+		 * unblocks SIGCHLD (blocked above) and suspends.
+		 */
+		sigsuspend(&oldmask);
+		sigprocmask(SIG_SETMASK, &oldmask, NULL);
 
 		lock_contention_stop();
 		lock_contention_read(&con);
-- 
2.43.0

