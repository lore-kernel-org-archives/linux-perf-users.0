Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F52487A5;
	Mon,  7 Oct 2024 03:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728272970; cv=fail; b=I2zJci3xa6t/nPnOJYQDeiRoAScOjG9S2dYXJUjkHPQVPvaMH8+P7V9MeHNf/qZL2J3IUWvaSmCwDW1hIoFq72wI38B94wVv89KQu6itp0KBWyKWcocu5BLR/K5B6pfwQmLhGKio+U2Pejd3DSRFRwr3E+P/Db/ghLXw1df/n0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728272970; c=relaxed/simple;
	bh=I3poo/ebNbr0XkrCVjaxos1JdifkOXUoF90PGhbBbbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lj/OUtYvVIq7tiohEB4kgH0iiaHIR/BgimqlowBjnTPT6SW82Dqm6ug/f654HsGZn0Y+qr6EE5p7UPnpd5geBKuvObEchDBD12+7squkpyO3lMhVsmCMlfZaB2w6Hk+tk8aUgMy8GyP3u/Z6773zJTyG0CgVvRYjdJ3bOMAlbDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GFv6pj44; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GFv6pj44"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fB8CkMp/ZkvgJhtri53X+DXQ32UBGelNd9DL8ok1igtfcoOVU8PDlxnzlgu5fKyXP3+Cdlo6Sdhhtzvji8wK5CXUDd6Hsm0mbTJV3xDDha15Wnp0dMLkSJoKbz/XLo711svdzqvq8OQB+Mlw7InMRL/cCWlFwyf4ssnEzWAI9I6Du0Jw5f9uN6yoJocyvYVwdZ458dqTnM9M0gN8pYSF7RR6OvXstrwoZRQtZ0DhtGZYnB5C5IiMqeR8VrZhzGO+A8IR19hP8gT+I7ZmNK7+4pBIR5RHA1WgA8BGObDUM1VftMMT5b4svdAJPDPSyUch8dElxI0E+OhVbbT4dlA/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYGWAsaQcqa1LUR4Oh+dHTYYTgYXhAiPVs0/pOMv4gQ=;
 b=VVKzIDWWLL4GpAVzSZrh5gQL9sutaqOPoB0ZrLEcatRqhLSOd4sUHoTmXzxYR0dD8n876fw1HKL03PHHEaLjStMd9E2g69//ypwgEZBQsErgx8+S6f2qItkI5nBmY2lyETSOgTZ7DeCdaMMBq7h8JVYcv5A5Vy0u8c3hnhzEWVUWcXatmi3xNRbOZ6s3q28fomNrZvcU4MX2kao1TCDc6ZP1hlMurGhF4paKxl4Lr4GhX7OzkeNbSd4rAOwngkyhm0uTvB/SBe8F0/9NC3erFKzrLRsd9lH5tLZiSPcehrbMLR+YXcIKxlrwgTA2wu6dTlspKLVoPoWM0Dvb48S9/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYGWAsaQcqa1LUR4Oh+dHTYYTgYXhAiPVs0/pOMv4gQ=;
 b=GFv6pj44VGcgEPqdWK4iHNfmyKgxjtbtHVTUGoUwyrPXRSpJvmHRx/eF43sHaFxeNAilGfr8KGGkjxHf8DNbbrDd0jJsM0a+t2/3Fnjn56ZitmD8Gqwp4RUsaeayNeR2NwVKxCMawbI12Z2GW0V1aUvh8QWHQgwJQUua+CR2d7s=
Received: from SA0PR12CA0016.namprd12.prod.outlook.com (2603:10b6:806:6f::21)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Mon, 7 Oct
 2024 03:49:25 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:6f:cafe::8f) by SA0PR12CA0016.outlook.office365.com
 (2603:10b6:806:6f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 03:49:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 03:49:25 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 22:49:19 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 7/8] perf/amd/ibs: Add ->check_period() callback
Date: Mon, 7 Oct 2024 03:48:09 +0000
Message-ID: <20241007034810.754-8-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007034810.754-1-ravi.bangoria@amd.com>
References: <20241007034810.754-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: d88d0425-f8d3-4fb1-b51a-08dce6830998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4eonQr7lFqGWYzRaMC4Pg0dyROLXVYB8n0dnAEwiWfbuedZ0URpZ0pI2ED+R?=
 =?us-ascii?Q?q9yaOtOBNjAqnDz6boXZg0jnxMFIt//h5uYm2rrScVH8aRlN5A5iVa4V6ly0?=
 =?us-ascii?Q?PUS/5dBhCsm5mu3LY58jMBCtTqx+Dc1Rq1bnfIG41viS2mSXv47lHlKuBk+C?=
 =?us-ascii?Q?v7a+eMh/opaP+v00plyERg1gL0N0e8tOJ0cYdiAiz08My8bXyseMLh426JQh?=
 =?us-ascii?Q?t+3uZ+NKfRhZFLjxoAxRCOuR5Tp/QJmTviC7Ks0oA4HzLt0CiyWx574selwj?=
 =?us-ascii?Q?QtyoN0UaZ0z4Plw4oXAyovt7yaxF2q6NvSt7htU1M2oUpEOa8pCid4M/+1xk?=
 =?us-ascii?Q?uzrrLypaqCjjQBxRQDARfOeDrplYT+FFXR7qkP/OuL+mtvw8t6y6TbD1zqbu?=
 =?us-ascii?Q?N6w/61z+U9mD3JFl5qvef5MZBGqessKpqQ6u+4ylJ1vWNNMqfSpchww0kroJ?=
 =?us-ascii?Q?MMIU7FMwcF0QEZq74TSBUyzDFHtt+sGGPEWBMWCJXm0wrlcK28tQ2msrRtMI?=
 =?us-ascii?Q?MHM9nQpV7S3xJymhDOwBSpAVeaRQf5l4k4g6r2I13Txsvu+SIoPQzO9UpvXQ?=
 =?us-ascii?Q?R/TmsoMh2Doo96S6oqCcc9UliQN7EL9ev2A+KHSCURosgtRcRL6k2UiJrHcj?=
 =?us-ascii?Q?vX0u/dqbUUbfRQEzCwutMeoDh/C1Zjxhc3ZrBtoadktNZ44S8GICdoUPzhJw?=
 =?us-ascii?Q?7lJP0CG0YBXVVduoqQisz4SkfOAfFRXKYnaC5/6BwIymTbmHKTfvTuwNvsOl?=
 =?us-ascii?Q?ZEFIZc3uPcjXTNsX4PDlc+4rNd3AVTIEYo3mUx+8GrYg2WzM58GRif1bGmeC?=
 =?us-ascii?Q?vTdv2jajPkJyQSZpNGDMCQt5gofxKgnmXJck/vACPN0IpGL/4g5AoQ0swJEo?=
 =?us-ascii?Q?SLRvuyXwbiUUOE0QxSItZ5jSWlaSW3xXnymBiVWIzki7x/KXrw8GR7Z9CdlP?=
 =?us-ascii?Q?M7buwyI877tYe5MG1wvSpThSY0uDcwDvwyOtDiVv7O9pzJzWBLPpH58mtB86?=
 =?us-ascii?Q?72G46kZdsBJ8tAkRl6Ba5fMm2C7xPawAVAHjwAtxiL41p0zxjNk1Zd6Wm4+Z?=
 =?us-ascii?Q?+GtkMXWnpt5ChJo0i8db9uh32D3ah7YCFrez/9AKbvfPCQ5Ianut0zz/sCKm?=
 =?us-ascii?Q?XHNbTscLNvWjhVxHn46pYcePJz6iP/QSbXIYodNz/RDPCsU40Ua4YeUIq716?=
 =?us-ascii?Q?UtrgSoW48AGGsJAtaeCvLLw/icONnW5IgYMIqKYpj0ILINv1p8nlTWaR/Stb?=
 =?us-ascii?Q?htInfNKmR3Jlt50VUuThopP7+WoMHTgHlsdwf8chXN+oYxSTKCqBUgmN99gL?=
 =?us-ascii?Q?OpxbdCR+4uduFqF9Wyf2u/gn/rUECRky3mGBLxH9RC+Imsidl8Hk86NHx8l/?=
 =?us-ascii?Q?JQaNCnrPK/y8wEBB1EGVgXmbMOCf?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 03:49:25.5093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d88d0425-f8d3-4fb1-b51a-08dce6830998
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568

IBS Fetch and IBS Op pmus have constraints on sample period. The sample
period is verified at the time of opening an event but not at the ioctl()
interface. Hence, a user can open an event with valid period but change
it later with ioctl(). Add a ->check_period() callback to verify the
period provided at ioctl() is also valid.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e7522ba45a7e..33728ed6d7a6 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -551,6 +551,28 @@ static void perf_ibs_del(struct perf_event *event, int flags)
 
 static void perf_ibs_read(struct perf_event *event) { }
 
+static int perf_ibs_check_period(struct perf_event *event, u64 value)
+{
+	struct perf_ibs *perf_ibs;
+	u64 low_nibble;
+
+	if (event->attr.freq)
+		return 0;
+
+	perf_ibs = container_of(event->pmu, struct perf_ibs, pmu);
+	low_nibble = value & 0xFULL;
+
+	/*
+	 * This contradicts with perf_ibs_init() which allows sample period
+	 * with lower nibble bits set but silently masks them off. Whereas
+	 * this returns error.
+	 */
+	if (low_nibble || value < perf_ibs->min_period)
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * We need to initialize with empty group if all attributes in the
  * group are dynamic.
@@ -676,6 +698,7 @@ static struct perf_ibs perf_ibs_fetch = {
 		.start		= perf_ibs_start,
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
+		.check_period	= perf_ibs_check_period,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
@@ -701,6 +724,7 @@ static struct perf_ibs perf_ibs_op = {
 		.start		= perf_ibs_start,
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
+		.check_period	= perf_ibs_check_period,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
-- 
2.46.2

