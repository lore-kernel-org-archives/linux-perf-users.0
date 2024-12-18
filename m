Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFAC1ACEC6;
	Wed, 18 Dec 2024 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734524287; cv=fail; b=nJqxkjgXdWxveYz/DpQ0furqvxohhSkuKdgNdVfgiUaLMDgfbaT3wbBJ+OvSWRnfihpbLggACjVxM9KD7FXHMBCj2/OHsvYBEQE7aCf2vZi+Mj15t9Kzfn0CDXXaKL+mc0EQ61EesMPg9XqqJxn7trpH5FBsDBNyFiv46tuhN3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734524287; c=relaxed/simple;
	bh=+VjtZVc0lZftn8rygY1z2AsE+iSg3suYjUAiojvr8mw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5tdpBmE8r7w4SeBN0N5sRXxWvLS0J0S2Jy2xCdQenQsscLrMCHEPG/G1YoLmSPh4YjweC2YlWzGqZqcLMJAU+DS4Yq/fiNKSha3LU0Tr8n7xDN/YLkdxJQct1yY58PuQUDVm9gVT27tioJtjkGGodvaE/mivErZEYQsJJGzQTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zW3vFBNT; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zW3vFBNT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKbCgp7fgVytuRn6UY4zwK1ovSYZuc5DYOqxtzOakbIyStlSVcaUIGQ3kKL5lIBSj2CpwI8C7sgjalO4duVzqOa5oamyhGWAle7WugfJcnERKlDDYf/Yeg2+xMVsgDfFQ+08VY/EWbIWTZNlg7eNeNe53iSsN9iuLwNcJwgFdyu9ZL5oalK1nG0Bexq0vvoQ+G/+xoooFEt7o6MA2tyUE8vSinqEPRD3WIIsN7LzxnY7Z3XjRWXqO+nzB+86G251ooThPfV3k0tGNY/IA0glF2h+s2QQsZe1RRAOdBMqT3V3FoAKHvj5L//dDh+Z2zFiTanJlxyCe5iS2VVJAzekGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmwvAg8UxCNiKkZk2vTiQafUWT/8fxaOyCkOZh8Wdnc=;
 b=Wwq8KQGeiF8tgcdOoe/wbkm9f4UiFk1APNDRu2dCEEc3JE1VbDRouPgsUI+wA75VfJjjOnK8+z+/i4oEs0e+qBIRSfSYOmjqbzKbrHp5M034L3IPJoM2PejA6HRqF95enxeDOvTfaEu7O3B3UuCT/Z/3bxR/cgQp50sj4QGV8KKAPcu1CO1PvPa8+FU3VlrWC+Iem97hXrtHfQv7eHKYDUntJ5RD/0Ffxp/t7XhGqLJdR4n6L9SChXsJuw3eVQWaemNpvA/ylVVCCHGYZ08HL7797k2qkA6Hn1vWVi21Zch3s6Rk/q4+bLm6u4MfBQfalj30Zw6Q9GhdDdoexD5e7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmwvAg8UxCNiKkZk2vTiQafUWT/8fxaOyCkOZh8Wdnc=;
 b=zW3vFBNTIr51S74zuRsRnxq9SehobDS4cgr0X5YayW36K6MWyLfpYnnp0eltUZxbHi7mmas2B/+eX9ZQ29DW1/92ACo/KPeMveZqr+Wh5QfHzsskxWo2Ktx1e+eugI/FBosYt7ZWI6mKy8xl8vUouWZglvFyZ2X5JkANErJJH8k=
Received: from PH7PR13CA0017.namprd13.prod.outlook.com (2603:10b6:510:174::13)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 12:18:01 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::8f) by PH7PR13CA0017.outlook.office365.com
 (2603:10b6:510:174::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.7 via Frontend Transport; Wed,
 18 Dec 2024 12:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 12:18:00 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 06:17:56 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <kan.liang@linux.intel.com>,
	<bp@alien8.de>, <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 3/6] perf amd ibs: Sync arch/x86/include/asm/amd-ibs.h header with the kernel
Date: Wed, 18 Dec 2024 12:14:34 +0000
Message-ID: <20241218121437.1717-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218121437.1717-1-ravi.bangoria@amd.com>
References: <20241218121437.1717-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: 8329d820-7708-48ab-7243-08dd1f5e03f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z6xlo6omEd2B9AWvR9XLQiuFk0LDyPXv9mStulhtn489P0fqFpOM+PJqi+QU?=
 =?us-ascii?Q?tR8mGaFvRxHbsz1mSHVbNVA7Ir+uFu9JIZjhdguhwnO6CzyObdRVvJ8T967A?=
 =?us-ascii?Q?7dd87qf+sVlqaVryAeLHXa4FBFWrxPUO51YxYRPaH1FlGh2oNVDlR5gSWlb7?=
 =?us-ascii?Q?0BozkRHq55GNVaVHPjLKJEY0EUgTIWLFH52klgR5kySH2lwba7EDbi/1FM7A?=
 =?us-ascii?Q?TmwR62oMW9DqONALw04B9f+0lSvEr5rgsoxbe9zci98XALLQJuNHk4dst+Pd?=
 =?us-ascii?Q?8cH9WyTy64B9eFWAO827k6/HDQ7SIGl91+DnicZnQ3TML6ojHiEJcJMFIxTm?=
 =?us-ascii?Q?VbX7JyjxDd1IxTtd9WLbedSFut1PoggbWVCGajWDmDKmCu1hVai8frc+grFg?=
 =?us-ascii?Q?wh50s+AiAJgC+QxO1imyTfxPvP81yJlErkFCz5zHxjwohYrGXxswlL/FZZ9h?=
 =?us-ascii?Q?JRAiq/yCDV0+EbVcywyvi91Jtp+MVpbyNeRiqeQ38Z/I1vySrkYL+UhWAEcE?=
 =?us-ascii?Q?QnTpM5A1umC67+6H89wXvRGmCAqYGHg3ZdDL99eA07QUcLyaMm8HhXpT8Tv3?=
 =?us-ascii?Q?yiZtwsG81m32LEVUZPBI8uF9sEhZBC5oxiHIPokDTaOWlz3jD0dRYkWYVw48?=
 =?us-ascii?Q?FYTbBeZk1BO+4MmpB2aTuZ1qLy/7umk43i+9w84vjR6/HaNDRauzu6tNiOQd?=
 =?us-ascii?Q?XxYOyRi0JUHZjK369+34ZMAsxf7k7qujwxRuD3PR/g8T5oBgbdh8fiiapwdZ?=
 =?us-ascii?Q?9oX35jovSLs+yx8typyjhDxIwTcrDd8hC7S3CwvquSJxU/lQqrfUSsJIjx+J?=
 =?us-ascii?Q?5vdhehJu+IUNg0Xn8VNno9uKc0fp2bVRvx+5jzH5ze2/32jeTx4/gplLbLbv?=
 =?us-ascii?Q?Y6lb9IMrxnFyfPLADZRMNMomTIUUYF56iNT6QB2D4CRaftO/WswNnju76opQ?=
 =?us-ascii?Q?4M+J7xzM2RiZtXNX3+M09E6Zt8qOKQodxPU/X0HPaPaxUdLI8dKTKNdvvJPr?=
 =?us-ascii?Q?/znlHiBRkkMQbbF+zWk5+tGin/saU8I5kc7c79/WM93DfhgV/Z7A7Jfw4YB8?=
 =?us-ascii?Q?OHc9Z8HMsAEMWGF+GEh2BhpNIKgNyd8SyhVNhQwgdTZ6nMwH+HyR75S/gBYt?=
 =?us-ascii?Q?Dp7Ogj+TBrnZeU3atQQakOliEWcL1oGa3ux4xfl6a7Y3WfbYROdLau45YLgs?=
 =?us-ascii?Q?17TnIYzI9MNpiwA1I89CEyRjc9W0lNXsidpZaID4fSjSUFo4wX1TQ9wkvlnn?=
 =?us-ascii?Q?V3Saal/0zqZK6VBecsS+83JJuF4cFsVaRgpg7VRc2CtVNY52e8H0/cHuckGs?=
 =?us-ascii?Q?qnn6qNZJF7VYjOFA1zGQN7szytF20vuqqRgmrNa9q0LoBhYslYv8ZeuUdV8W?=
 =?us-ascii?Q?GrhMuKZBr5BWJbJWiEEPsDN1C8Rn7W2CGBY99YRHupap1rPvNHCjghipsSAx?=
 =?us-ascii?Q?CQaZrr8qqUi9Dk/sO1Uaw6+necfHssZQfC+4D9jjGGeGBSIR6/UpOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 12:18:00.8760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8329d820-7708-48ab-7243-08dd1f5e03f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040

Sync load latency related bit fields into the tool's header copy

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/arch/x86/include/asm/amd-ibs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/asm/amd-ibs.h b/tools/arch/x86/include/asm/amd-ibs.h
index 93807b437e4d..cb1740bc3da2 100644
--- a/tools/arch/x86/include/asm/amd-ibs.h
+++ b/tools/arch/x86/include/asm/amd-ibs.h
@@ -64,7 +64,8 @@ union ibs_op_ctl {
 			opmaxcnt_ext:7,	/* 20-26: upper 7 bits of periodic op maximum count */
 			reserved0:5,	/* 27-31: reserved */
 			opcurcnt:27,	/* 32-58: periodic op counter current count */
-			reserved1:5;	/* 59-63: reserved */
+			ldlat_thrsh:4,	/* 59-62: Load Latency threshold */
+			ldlat_en:1;	/* 63: Load Latency enabled */
 	};
 };
 
-- 
2.43.0

