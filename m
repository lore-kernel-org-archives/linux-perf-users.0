Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ACF1D5CE3;
	Fri,  6 Dec 2024 05:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462315; cv=fail; b=aL8njQPz7Gmi3m4esdmzcHADdHBlScjto7rZjGc8x0Ie2Wn4G1VHKAqnO7yxXV6Grun7tQNa+7WIF6Rui6O6Wx2iwv9TEcxWkSJCQOFcVmtYNX7EvvAb1rqgWU4hzs2AmrGTy7s5Dz7Q8O65i5KaXq9KTFh7nNhm8l2y0WakPoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462315; c=relaxed/simple;
	bh=RtSBhlt0jtPkKA4bJHy2BTecnewt9IC2vsVjVmlmnWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZ812m8PKV10/MuMqkLFv8j+AA0UP+BWWdtkVytYLbA++NwITO7aHRdK8k14mho9OoBpue9G7BNbBzBVayJmNW+m8PHIQiD6KI+Vh0qrUKNZRfOjisn8MvVgrT0auS4+MN7V2XEhCkRkPK1rmpelN/r1iR0YG1pMmL+hmgA2MRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a8wol3iG; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a8wol3iG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mg/vw+jpILIA5Ed9upsfKnwI4RJ9i4DuAfVgj/CVqnkso1eDFtsDTM7dxhUiy4r6f38BRVo/PImUs0d+3iAuPScvGUq6mQoY8FquI2AwlDgZwuN/rnk7LLn+RQijVcD8Rt86HI3+PKsP9A/oXSOt1MOU0TUUZMjV8jBZl4PEwyuA2103EljCydgQKWWVGpH1+JBQ5kQ6t8gzMnROluc0R5jb2z8iTbvUuuKbtJnkpYVGZza4U14yve8fgkM9JMtUAHBSmdOT1F+0lEbf625tnj/Nk0LjB5euat9Yxr24f79JrwrBrKQoQT4BD1m3osJ2/+eqeV3eItR8MypqEY0drg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkhWivUUXNwkovBM4cbKaH6BvH49o0UpIn/jn9AvrFI=;
 b=NDATGkLfiTIdFd/vs1Ii5TbclVZycHpvfq6ev9VB4ZtMmt89auFpM9egxK6TLcanRziZ2w9EiWnoBCnyQ8yV781nhO+IJJxFQKsW0yXofsYlFhUW9daac6P0uzf9ZsClUDqLTHmHRHk18XQqtbq+b4+DDAUBAqfBzRStJwS4S62UMfyOcUEcxzXMZNlTolnVq2O+fZZXbKDgiIkkNSTgHyoGZHlxDFrngG6ckmozegKS2BwOXUFFl7Lc9SEtiGOJ+fn7gZWJoY45WUxlnKZk8WtDkGofhMcuHfHZybldZK6qzoqxhmOa+sSJnKrUQJqaDWkxc6Aqv+sUm+pQaXV7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkhWivUUXNwkovBM4cbKaH6BvH49o0UpIn/jn9AvrFI=;
 b=a8wol3iGgVwJzJ+yzcf4FTXviNkCqfPHEdm/9r8DzE1A1LX7SioxlyrsHa/ML6LIIhtHzpQSn3mQKx8VFxwPpT+fB7n3MgEfigcQNMlmnVbDMic3jgiwPsBERmc1x8hQ51pUiSQCQEZs0VCmZ5Vmhp2tM51A/zpyfn0wHboFVuI=
Received: from BYAPR07CA0095.namprd07.prod.outlook.com (2603:10b6:a03:12b::36)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 05:18:29 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::38) by BYAPR07CA0095.outlook.office365.com
 (2603:10b6:a03:12b::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 05:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 05:18:29 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 23:18:23 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 08/10] perf/core: Introduce pmu->adjust_period() callback
Date: Fri, 6 Dec 2024 05:17:11 +0000
Message-ID: <20241206051713.991-9-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206051713.991-1-ravi.bangoria@amd.com>
References: <20241206051713.991-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|SJ2PR12MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b74c856-5d06-49bd-f87b-08dd15b56bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fo+M8MNK1edrsktMYxuykXL3ox1U0xM1rodiP+2GKSx9YEEoEpU2+x9hgqry?=
 =?us-ascii?Q?hoa5aKTysBeKvMbKWiBfJALz6oVn1xSVN4pkir3a0YFv7L5eEQSHshR2d5Aw?=
 =?us-ascii?Q?B4wBQ1VGr09jJUzWhQ/TiblF1lv8iQSGIemG6tJg6wxgkoTV/cL0HndDcHFA?=
 =?us-ascii?Q?GxKVmhXqeAAWJ1mTSBzv3pZ93PfSGPK2nnH9lu5FTutGs7E9ovQpqxvyuKFQ?=
 =?us-ascii?Q?D8wNXVvnFaTqmDLcOam5rxG/cJxla0uF+4qH/EhYyV1+0snKz7XsjLfR//51?=
 =?us-ascii?Q?Re72Zqf4lf+lS40GPu89qc1S4jEBqZJxLDPNUh6ubOc1xhLx3daWga5u1IwS?=
 =?us-ascii?Q?AsDWPV4x0PYo1SDCMtYHetKGocE6wG9NIqzJdlVxamD4B94Upb8LfjvNo51z?=
 =?us-ascii?Q?/X5xev6//7d9AewRigdSezSHzGr4xk7E9BJYszYKWQm9tQXbIVCVpGS59gdq?=
 =?us-ascii?Q?lAOGkf4oKwkdPU3zdiAp2tjQztHIqhOR/gWOyH/nZdEYT+4Um+7egs26EleG?=
 =?us-ascii?Q?VKkOr800amdIMDTP9imK5tUNth5OeBDKZh3svk7l1+yX1p3w504RfqZfnX6Z?=
 =?us-ascii?Q?HXsnO2XgA6f0EwvQ83DrK3lBF5aGpHNVZVNT8Vg4eFXvQqY6l99bvzcmuOP4?=
 =?us-ascii?Q?3fo6bWekAZKimrkqcwdau75SF7HjUQBeuh9TjbFXNPZplDbIdwZxe6+0ET8L?=
 =?us-ascii?Q?BOqgOaQujRfGH8CiHtMYWeRHKN4W4s4KXW0RrIxjPxFeF0BlTSfN4t/dSdX9?=
 =?us-ascii?Q?oXeLaqFGsdGPyUfuU70FKIKYa29YxeFOmH6c4XCMCrp2DMw5V0rstsKY3U95?=
 =?us-ascii?Q?P0NqZX2eC3/nBacP1SI5JUOVw7IpUw+S/dJKm8Zn2TxzDG+W6AQVNlL6k1+b?=
 =?us-ascii?Q?6L6Kx2FHeKKwSkDC6y5iyoKtDEtcJgvsGo9EnHgQ5iUG2UDTEZii+6EiZ4dq?=
 =?us-ascii?Q?U+6HozdeVJrDGCw7+UejauK7LBZpSkr8B7Oak3HIpTj0yJXHFR7pEI6Qv2m8?=
 =?us-ascii?Q?Go8aSSsciRJYsh4t3WDYtlKjI4ZPc7MoENYw/rviIM7PexLW2xleedIVgWj3?=
 =?us-ascii?Q?b8/YXFPnRGaNOuG1L9tKVMNbbPmoy0dOUA3g5nRRxNi+1lV1U5W0HOBcTqe9?=
 =?us-ascii?Q?88ijGLJQID05zT8gsVIq+UOctZM5AIPX+G54EFSeAjdBOQg498TGvoMD8sTY?=
 =?us-ascii?Q?Ws/Rld9y9r+9gedgWaPNh6T0QjXdUpFAMZt9hu36pDmQPS/MdIecs1Bf1h6n?=
 =?us-ascii?Q?hT812YLSjFIVYAT5IImBhzv0bRXs0FdJIGggLpvG1o0wsyXVp2jQsWqvdCBw?=
 =?us-ascii?Q?vZ9WVM20FArUlcB+y+bkLb+cOiP1dmQd5ILIsi3VQMdcokj6mvNOHKXJWmQ3?=
 =?us-ascii?Q?vwNhFASK6QT48cWQ/ULAxOdPQFOpfrEs5KRyIh7HyvmFNUz+vd3A8zaqktGJ?=
 =?us-ascii?Q?S/u/efqM4EChwnRugYTf4j1Bye6Ollli?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 05:18:29.5070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b74c856-5d06-49bd-f87b-08dd15b56bb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115

Many hardware pmus have constraints about sample period. For ex, minimum
supported sample period for IBS Op pmu is 0x90, the sample period must
be multiple of 0x10 for IBS Fetch and IBS Op.

Add an optional callback adjust_period() to struct pmu to allow pmu
specific drivers to adjust sample period calculated by generic code.
This will ensure the sample_period value will always be valid and no
additional code is required in PMU specific drivers to re-adjust the
period.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c  | 11 +++++++++++
 include/linux/perf_event.h |  5 +++++
 kernel/events/core.c       | 12 ++++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 54a434722c79..e41f83989b4e 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -573,6 +573,15 @@ static int perf_ibs_check_period(struct perf_event *event, u64 value)
 	return 0;
 }
 
+static u64 perf_ibs_adjust_period(struct perf_event *event, u64 period)
+{
+	struct perf_ibs *perf_ibs = container_of(event->pmu, struct perf_ibs, pmu);
+
+	period &= ~0xFULL;
+
+	return period < perf_ibs->min_period ? perf_ibs->min_period : period;
+}
+
 /*
  * We need to initialize with empty group if all attributes in the
  * group are dynamic.
@@ -699,6 +708,7 @@ static struct perf_ibs perf_ibs_fetch = {
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
 		.check_period	= perf_ibs_check_period,
+		.adjust_period	= perf_ibs_adjust_period,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
@@ -725,6 +735,7 @@ static struct perf_ibs perf_ibs_op = {
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
 		.check_period	= perf_ibs_check_period,
+		.adjust_period	= perf_ibs_adjust_period,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index bf831b1485ff..d588d3dda492 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -582,6 +582,11 @@ struct pmu {
 	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
 	 */
 	int (*check_period)		(struct perf_event *event, u64 value); /* optional */
+
+	/*
+	 * Adjust period value according to pmu constraints.
+	 */
+	u64 (*adjust_period)		(struct perf_event *event, u64 period); /* optional */
 };
 
 enum perf_addr_filter_action_t {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4c6f6c286b2d..6858f8d9b16c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4192,9 +4192,9 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
 	if (!sample_period)
 		sample_period = 1;
 
-	hwc->sample_period = sample_period;
+	hwc->sample_period = event->pmu->adjust_period(event, sample_period);
 
-	if (local64_read(&hwc->period_left) > 8*sample_period) {
+	if (local64_read(&hwc->period_left) > 8*hwc->sample_period) {
 		if (disable)
 			event->pmu->stop(event, PERF_EF_UPDATE);
 
@@ -11562,6 +11562,11 @@ static int perf_event_nop_int(struct perf_event *event, u64 value)
 	return 0;
 }
 
+static u64 perf_pmu_nop_adjust_period(struct perf_event *event, u64 period)
+{
+	return period;
+}
+
 static DEFINE_PER_CPU(unsigned int, nop_txn_flags);
 
 static void perf_pmu_start_txn(struct pmu *pmu, unsigned int flags)
@@ -11899,6 +11904,9 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 	if (!pmu->check_period)
 		pmu->check_period = perf_event_nop_int;
 
+	if (!pmu->adjust_period)
+		pmu->adjust_period = perf_pmu_nop_adjust_period;
+
 	if (!pmu->event_idx)
 		pmu->event_idx = perf_event_idx_default;
 
-- 
2.47.0

