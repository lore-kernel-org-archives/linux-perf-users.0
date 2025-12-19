Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EBB2D24B7;
	Fri, 19 Dec 2025 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766186036; cv=fail; b=fwwvtzNqQE5xYI0sutsMG++pPHvhywzklcG7MzOTjlB86Y68hF9wC3SoPd5l8IYwoclO8usazNxMMC6b+xZ53hOC/bKdNGlB65qnQ2LN5KQl4jCDEWBtDVzlD927yce2NQuL1jBZAJbKr0V5fd7YG9/B927etWqpsD4FqSdB+vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766186036; c=relaxed/simple;
	bh=AkIJNh5U/YiNjhIIPQ0wBOJiKobXQ0qoR2CtBnRxHv8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CieJYeVwjya33SE/R8e0nAzLognKw39ahoGTc4U7ewcQNmFz6NPQO6QCa25D0+QrGSQEgIG/Bl2Cf5RFiWHorkkRPV1m+B9xT2Y1ohepn7hGMmuXXSzicyUu1hIqQS/bhSKha107z832gi9sb3HRk1LeZ67qKV6Sy1UK/FouC/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F/8NWbz4; arc=fail smtp.client-ip=52.101.62.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F/8NWbz4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVM0P5VHcyo8lCvIVMwsPLjtxCTGZ9o6CCxPEtiH5ER/Q96L4wLdeq4Z9SmkmxhhEmNltv8pOuqQA5l7Xg3uSsC+AKv3+56crXO11sTY1AUYYUJq5FizWQKY19cod3aH6lvFox/b70q4qSYA5rr8DWPbvwbbYGRsaFeS2BuSKG8z3HQzmGuluC5xn6FffXCJZCCbhbfbk8axistxISi8wB2VgCTPZRVqbhK5ZbVQC1AxnRu0nVozWg1mKQDbO9kxqAbVF6D4t6zBnSbp9C/MF46Ud0/7KcLZ+9hZ6uDV6vhKjYArfhu8quitKJ4oDqy+5bZOTiOyqR+ka20VmoRMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/MZCrX/Qu0kIJenTHZbSgiA4wGP09pCaf3KwrNptGo=;
 b=Guxm9CBI5TJ+qyYUTMcXL0o66Zh8/s6t6v0TPRXTT/MWor7tF7bo6p9wkLYZ1SU7GBVc40/F21Mh6yJ9a0XWjhIBSkorHc49H2rQ5iox1oHN1mXISo8+gdsB86OHQ4S5EXdJKpuvEVlO1t2LgtPwe4UmEpGzGbplLjnhqhrCWaQLE41umJFgIOvfmoKpvOOi0JgyBC9soBcYYgiZoKLMXXjKQ8E3aa1cI+fJ1xxwOaZ6mPYF++H5p7toXv/bv5cUO1PkduA6R7+HfAqf96Pyqlup8+K3Q+mApacnqWrWu5+/BDiLS93QoIvq8zmcgCPFBquoPhHO5Ss40Kb+jSBFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/MZCrX/Qu0kIJenTHZbSgiA4wGP09pCaf3KwrNptGo=;
 b=F/8NWbz4NwpcN6W9bCG+g2Eq4w5Eo3srO0i/V8R8f4oMzUQGsmIwzUSHLowg8b7JnjbRj46Q/tubtMiMrrsm42ZS7giuJEM8nbUki2hHEWkRpRKCZt7iRqzS/1PVKQnaDAr9oJn/40cNDWqnm/+JC+BhqFCpTApGC3dh5cnhhrv4i5yfLPDUQR8wvGL7lgfYGS97OFDOv3gWfT5YEhE2OACMVlq2oFvMRh179YexSxmGqsxCRqL31x0cYAdsOX+j3Hny3AWdgjKz3Vuh1onCKCcOrVn6QbCSgROolDp9ag/TFsPXiGrYDUNDbXd0+w45tiEb4hMCmOFWxTTtVNVpXQ==
Received: from DS7PR05CA0096.namprd05.prod.outlook.com (2603:10b6:8:56::28) by
 DS0PR12MB7876.namprd12.prod.outlook.com (2603:10b6:8:148::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Fri, 19 Dec 2025 23:13:51 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::8) by DS7PR05CA0096.outlook.office365.com
 (2603:10b6:8:56::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.7 via Frontend Transport; Fri,
 19 Dec 2025 23:13:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Fri, 19 Dec 2025 23:13:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 19 Dec
 2025 15:13:38 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 19 Dec
 2025 15:13:38 -0800
Received: from build-bwicaksono-noble-20251018.internal (10.127.8.11) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 19 Dec 2025 15:13:37 -0800
From: Besar Wicaksono <bwicaksono@nvidia.com>
To: <acme@redhat.com>, <leo.yan@arm.com>, <james.clark@arm.com>,
	<namhyung@kernel.org>, <irogers@google.com>, <mark.rutland@arm.com>,
	<jolsa@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<vsethi@nvidia.com>, <rwiley@nvidia.com>, <skelley@nvidia.com>,
	<ywan@nvidia.com>, <treding@nvidia.com>, <jonathanh@nvidia.com>, "Besar
 Wicaksono" <bwicaksono@nvidia.com>
Subject: [PATCH 1/2] tools headers arm64: Add NVIDIA Olympus part
Date: Fri, 19 Dec 2025 23:13:24 +0000
Message-ID: <20251219231325.2742580-2-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219231325.2742580-1-bwicaksono@nvidia.com>
References: <20251219231325.2742580-1-bwicaksono@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|DS0PR12MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e509511-416c-4a8f-66b8-08de3f5445a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r9aXxNXNv6bPtcHrwW8omRrruwqcUrB21SLuxzkeCbCHdWhY+tga2hDzHu2d?=
 =?us-ascii?Q?fajJ4iE+Rwk9o55llFCZCaeJIbebEbLq+Gxfq4xsOQ5hmDCAQhUUH05ZUEpA?=
 =?us-ascii?Q?MVJw1sOsEHAayMnpclhYnHfoP+q7dopq4DfrZSDqyjiaeTtpVmXH78/zXUXa?=
 =?us-ascii?Q?dXmidaG6rs5oRxVODxE50u2wwsbW+RDm5sKZy/Va8zh1s8qqJCpTDNCFdRaB?=
 =?us-ascii?Q?nGecp3MyaTUs3SDvUeeMtiR9JsJVALf0P4oNsFODUZV3G1KyKg4AJSUReABH?=
 =?us-ascii?Q?BygMPfzaGq0xYl2g1U+DBNEsfM6SCQ5FoTbqZvl9GUVNUVKDLn8LIbVM98fL?=
 =?us-ascii?Q?yvo4hiR19+aiWIbAixhh9jvz0ZWjNJv17xOuLEI/urFf3xbIf+QCT4Kiqpjv?=
 =?us-ascii?Q?Wk5CNl7xx/SA5shl3PzelXZAHtSvUTaxY44EQIBP+H1p/iqkCbapKHaz/DBv?=
 =?us-ascii?Q?l3u+/obK4wz4zIH6oWM4cXiagSiTk/vfagQIHRzo/RIoCo8EzAgSgxDTqVQY?=
 =?us-ascii?Q?0/MlFLugVAzsnUpE1WjW+ouGsKsTFjqwvgrGEiqzVcIS009TzaYmkSWoW+2B?=
 =?us-ascii?Q?5zfoGtJwa1FM6xF0XqSVkpc6BwalUnOTm97w7z3ac3BDMJashQh1Orhnuij2?=
 =?us-ascii?Q?fe/+iZsRODOUhQLWQ93t5z91boZga2ZjYcX9zqLaoR/A2ourF7DCO2Qh+wUu?=
 =?us-ascii?Q?AfdCoRe69LfPALB6Ar4xAvMC/KkXWKiHqTxlGfHtuC4KTelRrBbVKaRU/sVv?=
 =?us-ascii?Q?urZrlAIzw8ntYtNBRE1V7JT9USrKRTYdKY9BF+KIYMlpdaLeMuRelkQ2SLAK?=
 =?us-ascii?Q?lxQX44LhcDoQJs0VtkyG9r4lcK8fCadA0NbY540vo9ZlcmzlTau/icu8b3Zb?=
 =?us-ascii?Q?ZtXjYIDFm69nNbu+636SD6JL2RPUwPvpSY3BO6glZOdMWd4AtcVZDTnh8xKS?=
 =?us-ascii?Q?NwtzPbgfJuKCqozMDvWyeAe4MN7eCTvdcEd/fDES8r6WJYOZR5b/JGZslPmR?=
 =?us-ascii?Q?fJvHBk4FfzW1/mkJf2FvN/9l/Zej5v6sbG/9ZJ5aC9nrnWbFBt7beTAu4lpJ?=
 =?us-ascii?Q?5lxHrwge5ZNu9Mn/R2JG+9U1hlwXD+DmTO3fhjX5qijmJNd/cDVN3EOpNKdu?=
 =?us-ascii?Q?bA9Ug1Q7/dChkhOdIfEUahKjdowuASityDBJa0zhc/N5FfPS11B1wZYTQGxc?=
 =?us-ascii?Q?uRvpuEwDzVYEfVRKaS50fvXinanXpXMtUPYNnTZYoFKEfUr6PyePiHlYEXWP?=
 =?us-ascii?Q?uQPFqq6yQKPXvBlRj3E90JKIdlG1ele9oMZ/Q/X8Ziy2DQg9tDrUfTYofXpB?=
 =?us-ascii?Q?/DDGmNN8HQfwhCTHQ+zC93mqtJ/nwNpHS+tRZ6/Ogs1/7FVge0OEyx2jo2xU?=
 =?us-ascii?Q?wOHzZqeYr+1tRO0zpbykuiowEDDXKsIUGc4f4yKMYWPyr83w8FUBiW+nXhEP?=
 =?us-ascii?Q?4PUkOB2nspW60/prNomyR1L+03GFQwcLuLNCu3V5bSaSS3NQRUdyvfx9ZZFT?=
 =?us-ascii?Q?FN9geiWoVy2cdGCGWsf2WRY09FTs+qBkyRVxlPbXV2rqSRtEhGLnQDVFsaza?=
 =?us-ascii?Q?TbEda1/MrUIEeSJl9hQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 23:13:50.9826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e509511-416c-4a8f-66b8-08de3f5445a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7876

Add the part number and MIDR for NVIDIA Olympus.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 tools/arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
index 139d5e87dc95..45ec0d4fba71 100644
--- a/tools/arch/arm64/include/asm/cputype.h
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -129,6 +129,7 @@
 
 #define NVIDIA_CPU_PART_DENVER		0x003
 #define NVIDIA_CPU_PART_CARMEL		0x004
+#define NVIDIA_CPU_PART_OLYMPUS		0x010
 
 #define FUJITSU_CPU_PART_A64FX		0x001
 
@@ -220,6 +221,7 @@
 
 #define MIDR_NVIDIA_DENVER MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_DENVER)
 #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
+#define MIDR_NVIDIA_OLYMPUS MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_OLYMPUS)
 #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
 #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
 #define MIDR_HISI_HIP09 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP09)
-- 
2.43.0

