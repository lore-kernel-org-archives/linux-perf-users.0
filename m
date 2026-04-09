Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E4F3B7741;
	Thu,  9 Apr 2026 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751868; cv=fail; b=PkUyhWThiCrVBxlZ8Y9QNQqlpfsUjP84yUzlTJNUIzMUq8nOKmLlGC2cuYyKKSzvL7UmWBLEc1GRlsR+XWh/6es3XW/dFisjPgs7PQxZNivbb+gQKApIFxVc20NaHpvJg7OzbOXktdC6KXUsW3Gx7853fuc1T870cXZPmbiolcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751868; c=relaxed/simple;
	bh=pnMpT4EPrQH4EJCrLQFruax2rX5spUH8T0dOROqNHWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfwQzAu5G0OrvjEpiOcU5o6T3/A2fE+88lZU2PqjONyOPEoNUPrBzoSPGKRGdWyIgYs6eaFk/8gObE2VGWQ6jSX4kBErhrCXhnoFGHTAUNHWY2HuKYjqeuuis9IuBXHbUShm7SzW6xHpXZhRhasqLY/gJsw9GNB2XpLHjSrs0fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IU6OX5D3; arc=fail smtp.client-ip=40.107.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IU6OX5D3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pst8FMKi33mDuPk9TlfmuqUxj7d3ShqB3w8X+Inf8UT4KPasjRCEfiCPEo0Xj9uASIlE5dymPvZ20+81/lS0MY8th+lrlFx44IBZNYAO1ZxZT7Uyf2+Q7S6XzjON+UffveBF9CKRF/2hoYv/0jGn5FwfiP/Rgj3QrbmVc48GgUPBVe8YQHEXMj4tUMmGr+IAWAk1SGVxQKTtmrd6xeTM0xizPnGcrHywIfMpkmRLoP22CjoFgxZEsomHLUOQgv7Xe0195ogVGiKG57B3QI9EscjWVdiNFGflKICkx34YvOl6ZKJW10Zg27birPe+bJqO5h6tRiGwpZGgjmEcCHJjag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOPQVgEX3IAUTL1lk+lhzKwBcc4pVmZ3u2jjMypyq7Q=;
 b=UOplxYj5hxTE1OLUbT4YfzaiTWYKCUiLbXqvxw/5vdLj3Ma3WYM6vYTQLqFb9dYBRar8D5rWJhWDE3TDQrCSUTTW0+nVGzLw4luSdMFxdlONnRpsZA0FkaQwRr78NMylF4OIWZWQntyUFnqDcsmziYJrmFzD35N13NM1jIYv1GVJ7Z8+AIun5c+c/qbh0tQAg6Kfc/oNmOIQrHRvc/BD7WahinsVOmb10q1b9TM1yRHjzW5l9xmhldfDZZzHhzZLf6NE+MaVraBMwqe4i5mUISrwXMGlndezVOB3BCSwOASx2xk1ws6NZVmSRtb24NfUpjd2MEI5TAAjwjzzdCTelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOPQVgEX3IAUTL1lk+lhzKwBcc4pVmZ3u2jjMypyq7Q=;
 b=IU6OX5D3/CGhc/sckBYPVgrjtwVgnkvM16pquikO1CF6TPo+scYgm3buojEN31vYxEgK6WzDw6Zrrm/dN7mkl+ZDhmukOn6R7aVbLXyPrMUdcjaENAlghEXFo+ny1EhEp1pxDUT2Gbxdx/Oxv5JMncisBibq973Uji8RT0pye0I=
Received: from PH2PEPF0000385D.namprd17.prod.outlook.com (2603:10b6:518:1::6b)
 by BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 9 Apr
 2026 16:24:24 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2a01:111:f403:f912::4) by PH2PEPF0000385D.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.35 via Frontend Transport; Thu,
 9 Apr 2026 16:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 16:24:24 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Apr
 2026 11:24:19 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
Subject: [PATCH v2 3/3] perf lock contention: Fix SIGCHLD race in __cmd_contention()
Date: Thu, 9 Apr 2026 16:22:49 +0000
Message-ID: <20260409162249.25581-4-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409162249.25581-1-swapnil.sapkal@amd.com>
References: <20260409162249.25581-1-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: b50dfc76-28d2-4a3d-7cf8-08de96547668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	oujGb06ePkU1TqBidBB/K+8yty+Xev7rSpu9BwbyFq4LFyDG/+5weLBbfzUsPwJtyETbXXcNmo+J3dawHQxbQ9FgtNN4jDM8tixtjTTM61VgW6QGK43MpbAxgS6ScRiC8SzYTAlvkAvlmm5lINcILekT6qhX6w8WQ239uYCPXUWaaoLhhKberWxJbXLX9zhmvrHUkHQi3NlsuErmOtWsxPcgl+y+rrOgfM+6HxrZrrMUFhuFGGuuhpG8Yxm48769j+VMRGsSYe5ioMU3Jx4leQq+4CtENuMxbJlj2YY7g8S31QA0psb+wb1jG+itrAYSPK0TtbEbaGyMfqGNYVg5UcWAGGGdyjGc8PRMr6zeBf65KO2wHgobAWwFDgYGoBtH+5MSm8ZzWOsCqgfUdChPfp7U8VgTJNYXE+e7/OA4xrLRUCzMpmvRpj56dFuUwypEGCCqaUoiKPSnwufip73H8CUOyZvn4WqpYJl6T6/k/QmP2n4VAEti4g0EavVwXoTWJiGhrwmTvqyVPBEtSOSgtHWsH7HdAtIrJ/ELzXpuSxs2CA/t4e2jk6FCVWUDDm3JBB3i02HEKtCGLioNOcTSqy1NBPjGmj03o91bbPwjw8HbjrwrUs4sr5TERK3xXBpilGGfl0oJTy1OARtBOINsKh+2x6iEdMe1j7OnARdBcZdiV6FXbf3nQY9tATMn0fXy9wABKOSifuQtpuJ78ve0rm2e4QtCgssIdwoyfnrpsoirbtXgll/5FHbHCxrT0npbtnVMJJoaNIM4/TV361q4AQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cjQVKalLrILW8uC3q2ga4zyGHccvKJP/snaRAYoyTNVSaWE3SYLfptqhM6/ouV114yvM7DedkqA0SUo4yqlpcDes6CyA9uWCAfy6u0Uzqmlg3T6T7zLp0eNRqMTJDOiPwnhN9bpHwSFZzN9UVNEV8Mc6Cxt1PAxdH4ddgK7KFFj9k70WU0KlHmOwq5TxuP/nTgOhVLTBxhO0Lp3cc3IhE5TymnZ4amWzolpJFzIRRDHtduPxN6/hv/gtSPk2+18LOnP3HV2MFWVrRTg8rtfYuI4MDN4s14WAruvxrbjPrlLDDAa7QmvRgMgd7gVMrClkUNMOWHg34R3Aea27E6BLJ9Qz/Rl+gn/bjNXue13IQ31PcK1aQad0pZWWDJV+l730Yu+qjjpOY2fRRuzwDDPkZM1HGC8NHA+c+nEZrCvBvQp8YskjdqnTb0kYFQhg1X9P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 16:24:24.0293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b50dfc76-28d2-4a3d-7cf8-08de96547668
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226

__cmd_contention() in builtin-lock.c has the same signal race condition
as the perf sched stats code paths. When running with a short-lived
workload via 'perf lock contention -- <cmd>', the child can exit and
deliver SIGCHLD before pause() is entered, causing an indefinite hang.

Fix this by blocking SIGCHLD, SIGINT and SIGTERM after the workload is
forked but before it is started, then replacing pause() with
sigsuspend() to atomically unblock and wait. Blocking is done after
evlist__prepare_workload() so the child does not inherit a modified
signal mask that could break workloads relying on SIGCHLD delivery.

Reviewed-by: James Clark <james.clark@linaro.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-lock.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index e8962c985d34..2da689de134a 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1991,6 +1991,7 @@ static int check_lock_contention_options(const struct option *options,
 
 static int __cmd_contention(int argc, const char **argv)
 {
+	sigset_t sig_mask, oldmask;
 	int err = -EINVAL;
 	struct perf_tool eops;
 	struct perf_data data = {
@@ -2123,12 +2124,25 @@ static int __cmd_contention(int argc, const char **argv)
 	}
 
 	if (use_bpf) {
+		/*
+		 * Block all handled signals after evlist__prepare_workload()
+		 * so the forked child does not inherit a modified signal
+		 * mask, then use sigsuspend() to atomically unblock and
+		 * wait. This prevents a race where a short-lived workload
+		 * exits and delivers SIGCHLD before we are ready to wait.
+		 */
+		sigemptyset(&sig_mask);
+		sigaddset(&sig_mask, SIGCHLD);
+		sigaddset(&sig_mask, SIGINT);
+		sigaddset(&sig_mask, SIGTERM);
+		sigprocmask(SIG_BLOCK, &sig_mask, &oldmask);
+
 		lock_contention_start();
 		if (argc)
 			evlist__start_workload(con.evlist);
 
-		/* wait for signal */
-		pause();
+		sigsuspend(&oldmask);
+		sigprocmask(SIG_SETMASK, &oldmask, NULL);
 
 		lock_contention_stop();
 		lock_contention_read(&con);
-- 
2.43.0

