Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B958BEA;
	Mon, 22 Jul 2024 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721658323; cv=fail; b=A5IskYRnZslEuZKMwVCnthluMMkWktY7ApcgaZZavhhDI+cwDF2S9z9mZ1ikh7YOeu4EVRzCQhirmeDtortBPQeVn/SHhe0hTLCRv+IZgZAKA9keLK0778/k+Lb472zTS88m/FOYfzePFzSrLYyar33I3CHyComyUB+/MCFYdgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721658323; c=relaxed/simple;
	bh=pHX0rZq9ApTWjHgcz0SDMgevbZsy12jH9sOFd5ESq5g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lq9dLC9c0c0DlAwutSXV/+NGKoSdNHWur0Lv66AThpFh9U5oEB6rtQVUlCQFtK3nz//ho+8hfDnLEPwTzJ2hp2DWChCplY982OUWpnRvdCH6+ySx7PEEaUEojO3zlgGtcRRDMJGwJIb1II5KBr6XTbY6zqMWgPUQ22DeBmSm+7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5p78z3rS; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5p78z3rS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCJ6gHNSa3sE5ykyj9rcWUK7k78B2vMJ/LBMMTwFjo1UQZJRQhugT9RifjMx6q1mq/9EgXAm4K/MQ5kcSGmKNAVbq9FOAFXzz2w6iEJmR2qNpSddWHHRevuSsfYJinef7mXdVDBiGSDERh1LPrHl6RYGsD2YvY5SZ8aZfiJS/YU1bfqW+IlE6fpQkd7R7lQnD1Pd+ARJxizDgmiXkzktHx19HvsbiDPcroeNoF/Y5ph00FTOWiV/GuBUxFmroPE9irLomVmgE9Im8xow8b49TEkEwbGR41X/PD7Nh9gps70wxrywdL5gETLzAa3aYOHUVI319nIWhHZ7aRrblDPQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEe6bGANP3qJztHCPyw1YxBk3AMBn4Zim98jGvKWfd8=;
 b=dspfksvkU/SmscJAmx031HkJorcDxTQHtEfZCFjoSBQeMeHJXQVBZ7Cc1lo7Eth10MjEkpyyXifN1/l8ySNG2VoPaUw5W2js2LvHFHIlhq1I8Ch18aorBs2Jf5CjKOEJfGRRecvlcAPq/DxE9BftX219SBYlQZ59lADH/zzgmi6UAVh2+qPw7IEpH8SpnJZNRgZ7VyH1vcbLPPTHxWSQM2m+cOXNNmAGaULdaqfrRvvzp0L6e0Z3VDfUC/lVCIG61y5hWAwte7rhv7hS5DnJDXl1ES4HfJMiMdNP/65oAAgxF3PRfGqZY2wL09N3gHpge7tF4W7gDq9zsPPSyHhI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEe6bGANP3qJztHCPyw1YxBk3AMBn4Zim98jGvKWfd8=;
 b=5p78z3rSnPYNATZ6+8KBO5XkUpyuYyMC9tjbCgJa8JiRqTpf5Y7HRCOFAVs4Tz4MtMcyjfyo+P6lPbDIubcD6cu4Uk+TEU6AFv8/0nghHbQcy/W+bp6zgrcvQFFoHbM2qFTRHoFgly09+xQ97Hrnejb+8GOJOBRYsV23qQhZdc8=
Received: from SJ0PR13CA0109.namprd13.prod.outlook.com (2603:10b6:a03:2c5::24)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Mon, 22 Jul
 2024 14:25:17 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::dd) by SJ0PR13CA0109.outlook.office365.com
 (2603:10b6:a03:2c5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Mon, 22 Jul 2024 14:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 14:25:16 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Jul
 2024 09:25:10 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gleb@redhat.com>, <mizhang@google.com>,
	<ravi.bangoria@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH] perf/x86: Do not set bit width for unavailable counters
Date: Mon, 22 Jul 2024 19:55:02 +0530
Message-ID: <20240722142502.224694-1-sandipan.das@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: aee0a6cf-004b-4f93-c4d1-08dcaa5a1bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZWNz/K59V1Bq7yPQare693aJp60xXNUmWll0TWvxgKRfJCXfGXG9KQ2uHP01?=
 =?us-ascii?Q?UWCq2KFv/VDJ522v8loCXCsOCzWB43H2vXp+T5Uz7x3KBoQzke6bwlKfEUx3?=
 =?us-ascii?Q?YHFeUZT+ABwWi/iL5y2xpyVbg1KscVHW6fa1pxWqmFce+OKZo0gvAraaMvyb?=
 =?us-ascii?Q?++5vBBDBZpcPBBp40Fv4vyzpxw/Kg1Wv+CCY1IE35IXNFYeU5AvDLy4Ww9EI?=
 =?us-ascii?Q?3mx5/ogmzYqCXJQsxDXoBzR06KJvWiCHoOhzhClIS+10wisHfJREycF2psYu?=
 =?us-ascii?Q?orLNV6BLa7TBBbyAoJ9RIJ8iuqyeDWyWyEvjEgxisHcrZEWw4pOfeIzWaO55?=
 =?us-ascii?Q?mShMjvzISvEGwma42hu31Xau1N/ZzRXPzFh4mWbqI/WUroswpcCg0ZQVBGS5?=
 =?us-ascii?Q?T7S+gzR+galcxycVSdLGwmPl++MvwhdZCGlGqpZResnqEw3JO+S7ujNspdYp?=
 =?us-ascii?Q?+rxiK3tMrpCjtBPK9R2tiAQfY5PWd4DSFZyXP7o3nsDJEghgf9FVI/tuJyW3?=
 =?us-ascii?Q?Ggd0OuJu0GkeX+mcdTY1u8iwlcgvdq9R/MHouKelacVH9IsG9ub5AHrsFLtH?=
 =?us-ascii?Q?Tnd5ec18Z/Blb1UItiS9ZeU9OxT/YR/dJZZV+unTRmZA8FxkYI+zLznsuPSF?=
 =?us-ascii?Q?lKUN+3fC90jPlGHkrNtFMbFYL/RaDuQG4tNTLS4Jymc6nsR1PDW2EEL8ZFZR?=
 =?us-ascii?Q?/nDlkP1cE/OatXabkTj/Tb0RN1Jl0zRwyUFTJUNDeega6+z4J055EsF+72EV?=
 =?us-ascii?Q?pcPDZXBjJB3pXAUxXqjhPOFzvf49RQOLrEueG/3iBDZcGg3XJaByAKFF1WRH?=
 =?us-ascii?Q?8Lh7gsHq1zUSD65vjvuzDjLroJ3fP/M9eGw2VmIL9gNOHNpqbEpsOAlPEFhQ?=
 =?us-ascii?Q?g3ALdNPFys+JrTGwIeZ4WRfyb2tELkDlhGlqRZWLY/QhaS26mEtAvtg7PusC?=
 =?us-ascii?Q?QZQ90ICEHM2YJnclAvR4kNpn3+5Q9uGq7CcrohqFIBRu7oIMuYQiDiwhKfSN?=
 =?us-ascii?Q?rFCTjnGvdBMjgNd3AoTsJ9sC7/RU2T4xwuR9jDQFeJ2i6Or2NEUf0S1bFIjG?=
 =?us-ascii?Q?QGU5m04GsIqKL0OTUMHb6B7oR/duaRL4w4oiGDSWycLFwqMptjcLW/Ez4tou?=
 =?us-ascii?Q?mNAjn6txzxcX2ieeqn1QQ860MGM1AUfHEWRKe+OXtTTUFV0PcgEeTu2rNnsZ?=
 =?us-ascii?Q?Ptq2KTcQOpPPctjiiUewNdy/eyHLQVAJwIw0IW3G0IqllpOZNlPMAE33KboS?=
 =?us-ascii?Q?eG2t2ZN1kAe2lLaUBSSYD52ocQCBiBEWWDj4qOsbtzgX6Ru056AV4N+b4MPm?=
 =?us-ascii?Q?sIjE1fqkSWe9mOv55vNpNRtbpaZKoRmy+nV7w7QK/2fyF5ejrG76+XBHzYfg?=
 =?us-ascii?Q?2AB+oxuhxznLRRKAznBD3O5zWmM9G6lEPZDLUnfgbLxOn2trumrn+c9aZL8i?=
 =?us-ascii?Q?dQ1I7mRxnl2p8wdxxGPdVrlVQICsq/0O?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 14:25:16.9134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aee0a6cf-004b-4f93-c4d1-08dcaa5a1bd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188

Not all x86 processors have fixed counters. It may also be the case that
a processor has only fixed counters and no general-purpose counters. Set
the bit widths corresponding to each counter type only if such counters
are available.

Fixes: b3d9468a8bd2 ("perf, x86: Expose perf capability to other modules")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 975b0f8a0b00..8405f6859d79 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2983,8 +2983,13 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 	cap->version		= x86_pmu.version;
 	cap->num_counters_gp	= x86_pmu_num_counters(NULL);
 	cap->num_counters_fixed	= x86_pmu_num_counters_fixed(NULL);
-	cap->bit_width_gp	= x86_pmu.cntval_bits;
-	cap->bit_width_fixed	= x86_pmu.cntval_bits;
+
+	if (cap->num_counters_gp)
+		cap->bit_width_gp = x86_pmu.cntval_bits;
+
+	if (cap->num_counters_fixed)
+		cap->bit_width_fixed = x86_pmu.cntval_bits;
+
 	cap->events_mask	= (unsigned int)x86_pmu.events_maskl;
 	cap->events_mask_len	= x86_pmu.events_mask_len;
 	cap->pebs_ept		= x86_pmu.pebs_ept;
-- 
2.43.0

