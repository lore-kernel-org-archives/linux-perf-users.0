Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012030.outbound.protection.outlook.com [52.101.43.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A86356A0D;
	Tue, 27 Jan 2026 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539857; cv=fail; b=EvZJ7RqgsR58LsP5aNvbIOpPSs9WnbtFr4mcW2A1p/TxuvgtE1joSuVBxBU2FaNQQ1cUXCH8E3CG1NizuNr65PDT8lP4ywXyKJlQB3tSp1v+jFeodG07Z07GCvI9haVamuK2Hq0p/iog6VBR1n777GWGW9QDKeRl4mNkZ7kfBS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539857; c=relaxed/simple;
	bh=ELT1huwcZlAfBgyzrd+BFnC9OhJvjPFcslK6nlPIRdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhEDZy3zzfx+H+R5toOvZKuNclp8VhqgRTUPdFDXnE9F55ZAiaJY3pBFuhZ4X1Rt7xEN0TW4y+hgcnsSq48qxKv0cJ6W7rruqZjwZnUekC+fXo2wz5JBBGdJLLnBOYpY3NWymUG8/zirNweihd5nEklBY0kEJ2yDiRnKZBzWZBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mbox8pEp; arc=fail smtp.client-ip=52.101.43.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mbox8pEp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaPbIyvGi+qTbBi1ecQn9E8G6RxDf+0WVRHcSBfh0Lkfmb4meOZk9vThXI5CPd3EInPDlqL+kY017UJU2nO/eDW94ZsQdW/1Dar37Y2OeQEwVBYojppodPW6W/tgacvzj8nGjChOsrvsfwxD+exREhBXVsmmapAz691vK7dhHTTygLSpovujIQI/GI4rDr6DzAHqUDIYUOh52YFMBmFhaRuvsXN8H/Nkb+wXO4xVDBvU1pbPhlV9QzAoLOh/0+CsIQ455NPCEXKAAsvCIA5s9uuj84gAizuaOPed4Aaj6XREzXGMt2tUkw7keSRaRSzJDX7z4DaYixoLyCRjOrl/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoSxZkwTwmcSSH28qUTGqJMYOqvH7jxQ/dmrhpta9hM=;
 b=QAUCRTdKDCaVxqMHSIa+v+vr6ZgJrEgrp/oGPK/j6umTPdGASNTXapGqYvfC7Sl4WoIJ4CdM9M7h0Z+Om5mYnL48pB5Jn5h3JJz5aIv2jpANvyY0TqdQq6QXPRxBexX7yzKXJ0FV98BoOiYQEJ2O2TS8lcZbUKw5fZCZvok4aJSlToOhJADTNmRDLL4JMoKFfgTlANCcfnol22rRkbjk8tTGMC0m54sqgIjk2qOEyQGZYbM6JlB7WDqLfecCDn3HLeLbDmf7031ZmpdFXW9IbUhPn3Wt+9u8EfxbXl7nE4m/JcPHilnJ2z1h+yHSMK4GfWfTyXHJGmryv41DyVuWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoSxZkwTwmcSSH28qUTGqJMYOqvH7jxQ/dmrhpta9hM=;
 b=Mbox8pEp4SG76rhJwpXlDvPD3kXUrKReyPLXwEjM5LmeDHit1XmIYQZfNO/SaWXo7BLngURbC7R32HN2Z/Z2oveekCHBlw21On+Xh1mJyxOrb3RcRMCKNkxxL7e2A6TupVZdjZixRVJklI6hn6J6U4vOFvYR/z2K5PjA50vbPq8=
Received: from SJ0PR13CA0208.namprd13.prod.outlook.com (2603:10b6:a03:2c3::33)
 by MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 18:50:51 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::b1) by SJ0PR13CA0208.outlook.office365.com
 (2603:10b6:a03:2c3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 18:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 18:50:51 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 12:50:45 -0600
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@arm.com>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <thomas.falcon@intel.com>,
	<ashelat@redhat.com>, <yu.c.chen@intel.com>, <sshegde@linux.ibm.com>,
	<gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH v1 1/6] perf header: Replace hardcoded max cpus by MAX_NR_CPUS
Date: Tue, 27 Jan 2026 18:49:55 +0000
Message-ID: <20260127185000.431884-2-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127185000.431884-1-swapnil.sapkal@amd.com>
References: <20260127185000.431884-1-swapnil.sapkal@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b4ccf9-f763-46cf-08fb-08de5dd4fe4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SUiMYa7CYUiMB4SQ7nNkWQ4x4haCaYK3DkzyN7xfv46I3BcaCk5D1+3Fsim5?=
 =?us-ascii?Q?8UhrB+Pf5FVyKBCb7wg5NVdG9PcDCydr+kzh+W6tDsPKS43WCopkfNjGPKwF?=
 =?us-ascii?Q?wWEyfljB1XtSm8rHdzxQVeHSKTdAtFwMKY9jswIs3Ycx8n7uQ7TmEIdqWKJK?=
 =?us-ascii?Q?ScGfVKpY4ED3nXww4hdcQWNW8Ultk+8w6zCA0eMfJdSdrbHE+HpOw/0ExeUY?=
 =?us-ascii?Q?EAeKne1USoghcZdbIF0Zv9EMhE0Dt0dajjQ5rRdW9GZsKs5Yl5IwMYPDcTuY?=
 =?us-ascii?Q?osGjz/LnIDdQ2YjZaOnY5xlSyM+V42cV5yGG3qrAMI3jCo63ihxKDMqrj8Wu?=
 =?us-ascii?Q?8NajHDIjtT6bCjeONhI66AC3aRPGW2y3VuxO0SZ4AlDrgrOTQ1KtDrf7pS1h?=
 =?us-ascii?Q?S9gV7UU97H9oRz+SxmW7+CSDBJ0/mWFk4c/OPxx5GMCQtf/C9QE/1DxMI5QM?=
 =?us-ascii?Q?x+GIKh37LOs7+o2wyiVu0FgK7qCAZb8EZmeODNX0VnmT+sHMUWM3vcr8MNNX?=
 =?us-ascii?Q?N3X5Huv9qA4RdhEYbCOJaF5xAYo6YEkM+jysmg4hVtPnbVNOiFFcGzmcQR6M?=
 =?us-ascii?Q?TmFPemtakuUKdxAiyFLnYmtf568nUI94nwo9XDoP+ibugdg2EcJFm/p0TATo?=
 =?us-ascii?Q?kaOh6cFiPOxwtyJdQktKGuq0ORIPIfItvVayxRkfBGz6jzzeLcd2eZHULhNi?=
 =?us-ascii?Q?cYgOGhOkPGwRpBtEKQdP0/utXShmn/oCgmJNInFdhZ39s/OXYakOceq00VrV?=
 =?us-ascii?Q?QHxZ3DJ/+0kFEfIMtVUlOg1xbFr+oMBxPrFnIsKPv3Zc1ndALPw4s+GJFsmp?=
 =?us-ascii?Q?wcq0kUFGzHLXVr32OJZT+ErjlUAP6AgS9KbDMKpIAK0ALbKVbQsKwJqdNtDP?=
 =?us-ascii?Q?YWrxyIwNcH5gm/k4EkMr4yBCe26IJETy3jcp/FKJ5KIfO6lwHQSHW1V4WYM5?=
 =?us-ascii?Q?5eE5Nx5fhy+4uenRGodENIwf3hA3RvpPXFeNKfxcP2umbiaHfhV2t2yX0Mnt?=
 =?us-ascii?Q?xcLPwfIqmld21vahJAGg+xxMXI4kxjbptsty7O0AJd6zgSL6CuyvL0g5Dkvj?=
 =?us-ascii?Q?Wbfb9Vna1vg/rbuCG8IBJ2x6RYFdgyyXqgYiHfP8LjLFLlF39HxqxrBqBHBf?=
 =?us-ascii?Q?bJ+gYTNKv7RqinRvwL+EX+PwUbvBotHFsrpD/4xhRslbQz3w/HYLKRa9nqzx?=
 =?us-ascii?Q?dOypdbq/q7iH4ysqH4Gzx0PTXPBBPg65DCanHvdU9U4j/4i1CbevYirP4S//?=
 =?us-ascii?Q?t4Z51zNqBF616QHUMDKZKsNf6URRnbCvVybCb7M4zNiiI5pZ77FkZjHJjCN7?=
 =?us-ascii?Q?cZT8mlqNuJFMembXfjJaKv3EGTcleEP7uZ0lX77LL8ZKn7OByuTpUbVfqLx5?=
 =?us-ascii?Q?V04nVF5UHI7pJlCdSAh9P3fwNeJdhqxLzUtT0Us7BXm7hgB/0nYlhHVWcRKz?=
 =?us-ascii?Q?AXjJ/dFD6Osj/xxPE9YMLrxKYhPSiaJnyQYJmF06RhmijwChLUkd2MmE/h0p?=
 =?us-ascii?Q?+72pXpq+SfNqxTd0RD5Hgh6KYWF+2vpu4vQ4esZqSz3h64HNARso35C4TXpp?=
 =?us-ascii?Q?hSqYfqscGMs+zcFVNHen6ucdwqzPQdKrTsJa4AIPqTN4pKQElF1ORNgnwAhO?=
 =?us-ascii?Q?MDwoUypMPv4YM/dg0I0Mbpq74UWhpLcvUqP5T0LlurOlXSDaPX4Fnve/pjpl?=
 =?us-ascii?Q?FOqgNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:50:51.2672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b4ccf9-f763-46cf-08fb-08de5dd4fe4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238

cpumask and cpulist from cpu-domain header have hardcoded max_cpus value
of 1024. Current systems have more cpus than this value. Replace it with
MAX_NR_CPUS. Also define a macro to represent domain name length.

Fixes: d40c68a49f69 ("perf header: Support CPU DOMAIN relation info")
Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/util/header.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index eefd1cd73b6a..31c3bab1b10a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -76,6 +76,7 @@ static const u64 __perf_magic2    = 0x32454c4946524550ULL;
 static const u64 __perf_magic2_sw = 0x50455246494c4532ULL;
 
 #define PERF_MAGIC	__perf_magic2
+#define DNAME_LEN	16
 
 const char perf_version_string[] = PERF_VERSION;
 
@@ -1616,10 +1617,10 @@ static int write_pmu_caps(struct feat_fd *ff,
 
 struct cpu_domain_map **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains, u32 nr)
 {
+	char dname[DNAME_LEN], cpumask[MAX_NR_CPUS];
 	struct domain_info *domain_info;
 	struct cpu_domain_map **cd_map;
-	char dname[16], cpumask[256];
-	char cpulist[1024];
+	char cpulist[MAX_NR_CPUS];
 	char *line = NULL;
 	u32 cpu, domain;
 	u32 dcount = 0;
-- 
2.43.0

