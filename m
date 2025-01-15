Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DDA22F831;
	Wed, 15 Jan 2025 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920020; cv=fail; b=nRsBxhv/ZNh4Pn13YJnaSX6DxtDY5oESkwn3cZzYezr+7evkq3wOqA+5G3IYbejLD50DAn/WRAdFnpTBUyCnd28tMD93iBTFxcQx4SpGYX+vn2P6hgFpFye4cphVXT0UhzAMm1c7SlBaVYqBGx2FciCHhvn/VQ/acudCjvoSD1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920020; c=relaxed/simple;
	bh=oXwMspnklaEKw+3Dnwk+UzHBujLoVmxzLBT/pyUJqcU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXwdSH05unbylSxYv8iojYlHOLK2h216FTBTF2XPjvLsBEuUsS/p23nayt7uTaVbi6Bty5MCTQV0e5JMrLNqjvebftm1gUrNe9i77itPubVxNrY1bTfYqei1sPmANPAsaUAUBfYZV94bcd+o7iIGcaXG5DlcV9XylSl4ZwKn6kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zf494J6k; arc=fail smtp.client-ip=40.107.96.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zf494J6k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLPBg/bwGZSEmyCSDRM4jOrv5ooATDg0A4zNxKXaPQVZyiO/G8UWoikJOWMDTtnYj2qk9iXeSsMSihFNvSNbTl50Jgc7On4trFNdeL7T9wMXhQtc4QyEDAHA3/zA/F1fUA5HhK5lojRPJPLysgnFG3CzKWGH6r/uCB19Ij0hOZHRdv+FGfkT2S8R2TgJj+GYB38OoOfZjqXwC0jzHjZq04bgsrhb7xo9YO9aUsY9LDTZImfRnkWa3pEAhM6yA2D9OC4/vUDiRHsD6BexslpWgZHqnLCCU+Nt8Wp8+D5i205XP38flMq/Js4rt2evfgjMPWJcqUN1lBuHo0dXJXQnxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwDzLvP8sO/hht95liQJ+am7mc0dDiplwj1UV7IIzG0=;
 b=RqD3qWp2g0SrFOmsK3v60E/+dsClzmkrOm3C7ynxdKHaCtTWTcLsahwr0KC5lJVUGUmK1TXF9jlH8NK04YboPoIGJMsFQYaZTEU9j8Mzurm8AXzz4WCUljzpFeOdPJ7CcyZh0iwQFlMuPFigANiFOTKID2cmCCd7OSQQMEJ9Eo46LMoerfH5aacRDr4ZVQ6JkDsu5Sbs1s6oE9qSOT+QkBM4yXk0SwuIdSiwexW5T+QbID6mtjxT2LSPUa1Pc2C7W3TvELyXnq7CvvNL6XfOa+c1WOWOEtn58WJRrxZvLcPyBMoUqXd4lgK2eN7kYZ+SgMTZT6vvpoSIl6YrxEiJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwDzLvP8sO/hht95liQJ+am7mc0dDiplwj1UV7IIzG0=;
 b=zf494J6kh7bDuLjJdrVRNNC3e1xRqDEQKOwYSXtqAsMwECzpb/t/qKLtlxHD8jLadYFyTza2Am6kxkf4be5QBPHVnMTxR69YDAr/AAZoeI/DCoS/VTDgpDLg41pTKDRy90l88Czj9scoYKEtl6wIXFuxQBc5i+1HI227cY/ws3A=
Received: from BY5PR13CA0036.namprd13.prod.outlook.com (2603:10b6:a03:180::49)
 by MW6PR12MB8899.namprd12.prod.outlook.com (2603:10b6:303:248::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 05:46:56 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::a1) by BY5PR13CA0036.outlook.office365.com
 (2603:10b6:a03:180::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.9 via Frontend Transport; Wed,
 15 Jan 2025 05:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 05:46:56 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 23:46:51 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v4 5/9] perf/amd/ibs: Don't allow freq mode event creation through ->config interface
Date: Wed, 15 Jan 2025 05:44:34 +0000
Message-ID: <20250115054438.1021-6-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250115054438.1021-1-ravi.bangoria@amd.com>
References: <20250115054438.1021-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|MW6PR12MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: 21621eae-3e86-482d-09e2-08dd35280562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aFZJPeJ3ZSvts0kz5OmuvxxLcjsVqKfoK5YaGvE9EQfH00v5Yeoyyy2p2h+3?=
 =?us-ascii?Q?OJqfLb1mbr9hPPvsN0L5yUwMDonoLsYukh3PSrC1T8UlzxuDKpHp8KBF4ZI0?=
 =?us-ascii?Q?+Kso2aWk9bHkgfPO4uDHktxvSgo0J2/9r7FVrROyIPGY2J4J3ucV/63MJ3En?=
 =?us-ascii?Q?7T2iTjGsWbTxRJulxS5zpaScVT0Lu6RRh/0pIHQUNG21o+6jtP1vZQ3Nc4p9?=
 =?us-ascii?Q?REj5Ts/pu44CwROnRc27hlo7ihkrzyrcb2BZgbzxffQ6n17w7S2dQUAxDjem?=
 =?us-ascii?Q?uVv867EJrKMhtliD7bnjxDSuJBI1S9XvVcXZefYLNYhBJw2dhxn1JZdpfBKW?=
 =?us-ascii?Q?DXhWRivraukNcDV0UGCqQu5sT2L2f5ashjDLDT4uWe9ruFVazxVYJC3vnkOZ?=
 =?us-ascii?Q?g8C58QSIewbqa2RvzzPWY238B8M9TGS16EV4ODATJ9IOt2WM2z6P9BwDxBLq?=
 =?us-ascii?Q?tqkHMNxcsIWVooHLSjfVLt1hiODxtQVZmd/D/uaazNjaUCYNXival2Htx+xX?=
 =?us-ascii?Q?GoiZkhK9lQsuo1eBkyF90Ot/f4+9wFExTI+vDqoOMG64QyKund2TtN7Tb7Oh?=
 =?us-ascii?Q?kfQGP5G5wGy21kHdiBlHzbYwAAbg0e7V/RRYyakKT1cYbq27tnM28w86x1ft?=
 =?us-ascii?Q?H+QWixEKCxjydTalfHNkknkLPiX/cyJ5/DUrDvVpsXvPxWlAAayG8rL85Utl?=
 =?us-ascii?Q?f5DkCrRkHy1wJZfIcPzLGDQbX2utIclB1huDz+6dJ2sWbTRLhmzmnesAt24K?=
 =?us-ascii?Q?Qr5+3U/Shy6xj2rpLb0fr1eRssoLWUWm5rK91wh3CXZUJl52rAhahF5BLfjS?=
 =?us-ascii?Q?CHjtojYB9bDfw3W4pxADieFVvv0zd/atlLrEXUm/uhVzO9EX/Z7jX+kaZx30?=
 =?us-ascii?Q?wIcHc92qqIaH8wbNxMUAbK4scJ/vc0EzJMu36FUSwV/8kvELiESiz+YbGP8v?=
 =?us-ascii?Q?ou+k3CoHvpSvk8HOdij+3xMlDJ2x3mx/TU0UR/10y2odQaPIeZEDQIkYT7jG?=
 =?us-ascii?Q?eSqfgdZKCQHBAIbhh+Zt3HcG0V4hgP8Czi8VY7FSVVnPibXcKwEsJwdAS3x8?=
 =?us-ascii?Q?n1e0cnFwQ8YtuNAoVlq76IUOfi5CKReIkA2daOqG5bPwibCrNUsc0ePTL8mi?=
 =?us-ascii?Q?gJ/2ChaP8ysQ7NJQKJKeKf0UxD45jT2KzbktH/KHW2Cia3VLttynA47VZ59X?=
 =?us-ascii?Q?jHdUQYiGm0I4oTv8ut7yNTMDqhNA6dCs/fVN1Sf3cA4K/lKzfAQSpKrisIqW?=
 =?us-ascii?Q?cEVGs0xK+SSEexWRdNgJHT00sozDFMzwhOJUgOfQDXHUkL6PY0OLNfH9886G?=
 =?us-ascii?Q?3g3JshAq83Hkj9sZiPUBhc1GMWOUl9UXsPU2ygdWadSv2w5Z4Q8CH7WJ62y7?=
 =?us-ascii?Q?9K/ajkM0Jl5cFGy1y/tR0KYxc0C9U4CrBbafugtDa08mobITaCyN9Hg9vp/s?=
 =?us-ascii?Q?LguYjTw1tA0eiW0cHH52irJjQ39FGXoakraGLLSAnQ15h4WVXZjhJiQtU2nL?=
 =?us-ascii?Q?x/m0BPUq6MKwVkU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 05:46:56.0191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21621eae-3e86-482d-09e2-08dd35280562
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8899

Most perf_event_attr->config bits directly maps to IBS_{FETCH|OP}_CTL
MSR. Since the sample period is programmed in these control registers,
IBS PMU driver allows opening an IBS event by setting sample period
value directly in perf_event_attr->config instead of using explicit
perf_event_attr->sample_period interface.

However, this logic is not applicable for freq mode events since the
semantics of control register fields are applicable only to fixed
sample period whereas the freq mode event adjusts sample period after
each and every sample. Currently, IBS driver (unintentionally) allows
creating freq mode event via ->config interface, which is semantically
wrong as well as detrimental because it can be misused to bypass
perf_event_max_sample_rate checks.

Don't allow freq mode event creation through perf_event_attr->config
interface.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index d9c84f1d530f..3e7ca1e2f25e 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -315,6 +315,9 @@ static int perf_ibs_init(struct perf_event *event)
 	} else {
 		u64 period = 0;
 
+		if (event->attr.freq)
+			return -EINVAL;
+
 		if (perf_ibs == &perf_ibs_op) {
 			period = (config & IBS_OP_MAX_CNT) << 4;
 			if (ibs_caps & IBS_CAPS_OPCNTEXT)
-- 
2.43.0

