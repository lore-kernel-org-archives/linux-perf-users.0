Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E0A236453;
	Wed,  1 Apr 2026 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775025707; cv=fail; b=hx2ABN7B/SWJkhZx9vDAQTM4+ph+cjUzlW/Jk17ENU/uJfkHtyUMNvBcvDwYeN9hPauQcPShwfx13LN1+44Z+rt5OTEJrNja+EUTHvk1Wfbh/I7ze7P/NLeMqN3JWMdT+79Ibs3e/nS+rUi03lk2CfIIVnNI+mB4JYP8qTK+qBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775025707; c=relaxed/simple;
	bh=E+GwOTM20OHwqvovgu6wXHOjmZT9fiobJzWgTO5/l3E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DvZS0n7ahitP165ccNRz5k1rvLJ6unZg1by+AHPpEd7ze92TCuL4f6zddP34NwY5gtRqNwLJJaeSaoMzf5B3PsCfVfa7fB+Ddqn02zSSy3IiYg/gFr19gd9Vy5QMIlBWsLVkG7JAuqTkSgt+znG9YmB+ZiqmUYQEVghOggAA39o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tAaBnF5f; arc=fail smtp.client-ip=52.101.48.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tAaBnF5f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GekZXRk/3Ax58hINHRPU14mgsN/AWR8vLW20Ir8PgIgL1VfIwxm+5rutWM8VLUA5Kmda4/lvqAd5ABWR/vE1zyULcDsyAayJKd06BS9EbzKRhuhzK4YemZoWKP/dli/DvCvNdUmSIxKF4ux0GFaj3BTT+hgc00iv3VXePS/3G+dACY4OkWHKz2hVxHHZxdU28RqpFHuiFiHupZ2d4PengozNesRsGxgO4sDhXtv0DDZRaqXt9Fil/B/k0QCJsdd1aMKClxlvV5+rY1k6m7NMH1G/a/tzv9q32/b5Z79dVq2BTdlkFnqTgn7eAxXSiRi5u1i+wYFaAPY92nWlZNBSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsKYTQbgPxh/ic+phKZdwPWKOOMtou8F2HpSV59juKc=;
 b=OOmQ2nxpfHxz+HHXs4b2rBjDrPOoRHFuxCdw5kUi1qlhsjdKKaJdL7SeLivi2RbyMibVd0gaU/OjfBlAsUktGQQh2/EeF/Uuddgt27oq6+XBaz3synIXMYjfCuVgCc7PVDEi4ifM1dsvH5MJiley6egjhelH0E1ZyaTcE9vC43x4fZSTxKIcyIzXw8qdLMFhtDxtqLI6AqOPvGkLw3UI8hejtlZuu4ZFW89a7iMISYwlp2IO6cpDrAgFWahmj0Nv+49AUDH+glhdRy5Wb6A1CPrEKIIY60QNZWILKPUYERCfroyip/MhNjqke/xLxnjLV9O/tRmmfVMhYYfv6rPEBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsKYTQbgPxh/ic+phKZdwPWKOOMtou8F2HpSV59juKc=;
 b=tAaBnF5fQKrMyPHuXHFh2WhUTI2kI42bKEZitnNxxviOTipTGDq9/mILpRu0/rbNuQJsG88yxF0hi0q9gCTKOYqj6gXIyvvmq+G2JXtLvIV9vArEpPuD24audlGmXpMbRrdlSDeemf0AsU1CZRFIfA0q+t1/MDU5qkf0gbK8i2Q=
Received: from CH2PR17CA0012.namprd17.prod.outlook.com (2603:10b6:610:53::22)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 06:41:42 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::8d) by CH2PR17CA0012.outlook.office365.com
 (2603:10b6:610:53::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 06:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 06:41:41 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 01:41:36 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@linaro.org>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <gautham.shenoy@amd.com>,
	<ravi.bangoria@amd.com>, <KPrateek.Nayak@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Swapnil
 Sapkal" <swapnil.sapkal@amd.com>
Subject: [PATCH 0/3] perf: Fix SIGCHLD vs pause() race with short-lived workloads
Date: Wed, 1 Apr 2026 06:41:11 +0000
Message-ID: <20260401064114.141066-1-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c101ba9-a42f-4b6f-6c74-08de8fb9bb85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	vH+JUQO5yHrdNhma0W2F7iBKSr8D5hm2IUUuOt3wmrmgus5ZoJOBxhkT5IUinsvLFUW+ykwY55jbzRY7Lri7EJ6jy2+e/rs+tFl9Td1rmz6a3zfem3gfwOAqcUYAPcP14zurOkH1GFuVhNa5pFXckAmsv+c/XUeZneKPQ/NO5jzL+PWkXf8JVasVNOuwxuK8VmNQaAXbG8ZOJ7mMWyph4Zs1D3z0wUy6H1BKNTOYhWzVZ9Dzquhv+W6Cl5wss1/bhospSjOfenwykbATavagv9/IQW6LZW5aZEekb3YZRapSLpinTiL60vxY+9ELHYX2LgByCfigdsjJsGK1ykaQYIb/GNcoN8YltGtIE0AXT3MPFx09lS35b9ZvsQCl1PgFK7v5ewmhtmqV1rtyaKhJfT3oDilMnhK5OSplGZ3s0QbPj2Q7IWNFDRVKyehAw2DuyDExS+IAUgyaYKBcDveXjx5h0LV9MoYCQ28tD24rhIA1Q4Y+MDAYes8SyNMIFJYlzSbej27zah82TvmgLZ2q5pw7H/LZbGRcLpieG0M7R/dVdLHgXXTGTF/reMYYR8BU1hXZ3ilbxTTBH7HDoMAlXUP64f9u76AlXZkTmxiD2b1THJsMzlgWffr55GmJtqMTmD9LH9k+QJSNMl3D72f4pOlgpI2ivj33jAsij+jPfg7LPHI8A2u2+m0I0i9v9O89HjlKoGcpbU4EZt1IXxynHgqTKtmAUgLRVYL1O5vk3xMokNabeRxafMXMl/nwJqWpWTTlNsq5EjoJ1/9UfWGg4g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sPAqY/ZZoJ9UhBcWviRu7Dn+EBprmX5YRDs4YiYhgGHOzbgw6g7+CmnRB9q4wFkfG7nzuX6fdPXC+0Avalt6U0OVdha8I+jYv0i/FnDRqLd/pVyYBeIwM9STxuLJRk2t/PHC0e5k5KUXUa8DXVasAZXuNGJKZMCgpUKRIdN5tUcvk8J7YnEL9tNpQVPfME1vZvOEhW4lTybAtnjndYPso7gFNDacrLh+WCN6F0F465ICZfwCRugmNVgDYYiV5GVTpJ5YkElZ/xeuXdVHah7JZ250oq80ZAeWdZoVN/3x0zwk25Ka9ZnTuH+2eTToq8zNokzYmAw5qZieWQ2GETC3+eKtLVkKrLz5+GJp9QlzCSQMs3aSvW6tUo1O0tauQ0Cjc+dlMw+1UzXkb1g6yClmMHcj60dtI2lP4+WWNs4HwTxQBVU0cm5svRlJrxUHXp2x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 06:41:41.0449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c101ba9-a42f-4b6f-6c74-08de8fb9bb85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120

Some perf subcommands (sched stats, lock contention) use the pattern
of forking a workload child, calling evlist__start_workload() to uncork
it, and then calling pause() to wait for a signal (typically SIGCHLD
when the child exits, or SIGINT/SIGTERM from the user).

This pattern has a race condition: if the workload is very short-lived,
the child can exit and deliver SIGCHLD in the window between
evlist__start_workload() and pause(). Since pause() only returns when a
signal is received *while the process is suspended*, and SIGCHLD has
already been delivered and handled by the empty sighandler(), pause()
blocks indefinitely.

The fix uses the standard POSIX pattern for this class of bug:

1. Block SIGCHLD (via sigprocmask) before starting the workload.
   If the child exits, the signal remains pending rather than being
   delivered and lost.

2. Replace pause() with sigsuspend(&oldmask), which atomically
   unblocks SIGCHLD and suspends the process. There is no window
   where the signal can slip through unnoticed.

3. Restore the original signal mask after sigsuspend() returns.

SIGINT and SIGTERM are not blocked at any point, so Ctrl+C and
graceful termination continue to work exactly as before.

Three call sites are affected across two files:
  - perf_sched__schedstat_record() in builtin-sched.c
  - perf_sched__schedstat_live()   in builtin-sched.c
  - __cmd_contention()             in builtin-lock.c

The two pause() sites in builtin-kwork.c are NOT affected because they
do not register SIGCHLD or fork workload children; they only wait for
user-initiated SIGINT/SIGTERM.

Swapnil Sapkal (3):
  perf sched stats: Fix SIGCHLD race in schedstat_record()
  perf sched stats: Fix SIGCHLD race in schedstat_live()
  perf lock contention: Fix SIGCHLD race in __cmd_contention()

 tools/perf/builtin-lock.c  | 20 ++++++++++++++++++--
 tools/perf/builtin-sched.c | 30 ++++++++++++++++++++++++++----
 2 files changed, 44 insertions(+), 6 deletions(-)

-- 
2.43.0

