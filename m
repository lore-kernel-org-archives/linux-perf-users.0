Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B092C221D87;
	Wed,  5 Feb 2025 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738735598; cv=fail; b=iev+TjUb1xWs+fiKWIsfGVgsayngZcdcxGBLh+PRtGqZtdLZ305N8Fw5nCbRHOqaXQU8XWb3+XDuCI+tfYHjCp0Z7u90XnkYJ951WiI21Ncb92c+5WM5CNR5w/DpcgvVFb0mtlPbCluMsCQAws/us4FKigxXmyJe7aX7Ir5ZlRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738735598; c=relaxed/simple;
	bh=+VjtZVc0lZftn8rygY1z2AsE+iSg3suYjUAiojvr8mw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bv9O7D/Zhazuzre8VWvpA8a0h11cqMFLJdgt8OGqZRdi5EvljZ5zPgMSFXWZTVRVoBA9dIaQrTVXPLaeFvHL/65AfjcFBa4S3bMwx9Z1nKF18A53AR1R8Glej4FpkiwT/1yUw5kL9dyPISPVbAVB3UHrJKW5Hf7Vu3mdkAd+FYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I50wCODS; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I50wCODS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTjcQXlloG5/jy3roUzu2xgFBZUji87mGy1kVU/goM3tyBJr8I4oQAd4w0J6gz8sUi7P3MPQAZEZmSfEzomy3OtL2EcR4ERhXL03mamkSVAvDyI+n941YavKt+bLRX+Ue2UJGFth9Y+vEijnSNADAQOXeOwfVHnrHLoQbgrELE9Be7LVE2cTKREt8C67eaUgsSIHOrpmCpHcg9vh/zg+SaaJEItNrYQ9bamSbgp7eanbVAYrW0mciXBTOIO+qZPGcdNVabkX34sJa1y5LcJEfs/YX2sAHICU0dnSGrJhYHqMGWqZjWXIb944/SWlB+vvkmW7lfrk5qggaJ6ODkfw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmwvAg8UxCNiKkZk2vTiQafUWT/8fxaOyCkOZh8Wdnc=;
 b=m3OPBraQ3rHFH94mz+54+WloTUivNEt+f0rChplVGWkLDM1up0bpEOV8L1f8hNfK07Uu8lnZktmYV9a3ShDSogxtRLVYq/Umuyo8m9IIjNBoccoVH3XPaIc+xf+ODJY8DbjHWnLK9AhN3UK5a/1AVOylAcE0PUJLuGi381HR1njIAjiVluzgDdrJLqdGdreBy22lT3yLbwsAiG9Z3iy/m3Z9FSYMiO+lLAbP5++4O8fNP1lcdISV8isjnHzsBniVH/JtjplScC6FK5AxKt3uKlLz0nzT/MqXlzu+YAJPyLSQwcDS+3cf8t//TpMTmDWw0uJoR0XB3tmwd+YSa9jErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmwvAg8UxCNiKkZk2vTiQafUWT/8fxaOyCkOZh8Wdnc=;
 b=I50wCODSpwnJV+HZza3y5EOWE7pArijqmdhWrITyOkketQGkS5yaxFaX7zXPTMWLD16kW5NGVIdxPGT/FtJnMXVuBE6pIz51K9PK9MdB8OgI1yHqRk9TXd0nwMSTNhmJv4/eIkFSNifcV0OAznqjSKcD6EaKorhlsiM8GV50hCg=
Received: from BYAPR01CA0015.prod.exchangelabs.com (2603:10b6:a02:80::28) by
 MW4PR12MB6974.namprd12.prod.outlook.com (2603:10b6:303:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 06:06:34 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::94) by BYAPR01CA0015.outlook.office365.com
 (2603:10b6:a02:80::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.20 via Frontend Transport; Wed,
 5 Feb 2025 06:06:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 06:06:33 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 00:06:28 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <acme@kernel.org>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <mingo@redhat.com>, <eranian@google.com>,
	<irogers@google.com>, <jolsa@kernel.org>, <bp@alien8.de>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 3/7] perf amd ibs: Sync arch/x86/include/asm/amd-ibs.h header with the kernel
Date: Wed, 5 Feb 2025 06:05:43 +0000
Message-ID: <20250205060547.1337-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205060547.1337-1-ravi.bangoria@amd.com>
References: <20250205060547.1337-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|MW4PR12MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: 677e4025-9841-42aa-364c-08dd45ab3de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iFZTboKPzRHUu0wLn7pbpBys1YHT3mFegKVYOvx6vEznEk7q/qxp+I2nFsGj?=
 =?us-ascii?Q?GKIntVnTdm+DzzPpMIBE2WwcjZwoMxSH6eNFVmLOGIKLXqWyE+A3o7Qa1niN?=
 =?us-ascii?Q?grLxXDGVvBWs9DHGEllUgKWNMdoRAqiTOPSncEHKTWOHYhaKZY2ln9n1DFt4?=
 =?us-ascii?Q?G/2HvWS6vMtZLn1Au9OjADCHy9lQn0nXJEU7NIM2lL8ahPEiQ/JVIdT891TE?=
 =?us-ascii?Q?64lZOAGsLtDdO+fp0XmI2IlGmCCn4lTXydidGumJYXv72ir9XA8U99nVcZZS?=
 =?us-ascii?Q?6fQgATnLWvwQEOFf7d/FSaRHPqw79bsXZKpqebl1a2/KKJkj0Aigj+MtoAjT?=
 =?us-ascii?Q?3URqeRVbhtOpRnZqAlEsPMGyunqcYdqxZytLYDJ+Kb7Imw/qNgPBbUdvY6h4?=
 =?us-ascii?Q?X9qEkz00L4E2YrPvmq9MMVSqhZ8gRvjFTqaQUm42+9/NREBaAysnm1oRChhx?=
 =?us-ascii?Q?uN5tEHwu6oDFFuZy3GyUEsQcYAzX/UUGP1bNPFO3BCd2U/KbAWnVCOmtmjXP?=
 =?us-ascii?Q?RBtuChGNcXDAiSXfO7gKC3WpEs1XN8Jm9m5PLtABfSHfjyN4/MPePgPRVaIQ?=
 =?us-ascii?Q?KsfDeJLW5N71Th+Y0qybmRoDTuWKtTNmeBeUwQUlWsag/zMb8f6mlmVIOrXe?=
 =?us-ascii?Q?YHKiYoDBdm8YgzsqfM6JWi1BbAkijV6SD2gCX/1JrE18N11Y3FheDpw37Uww?=
 =?us-ascii?Q?KI0tVQNV85XUqd824H/HH5loF8e4g1sM2Lw3/aKn1Z5babsstGaX2aZq5m5F?=
 =?us-ascii?Q?uaDSZ13kvt8z/I+LbxMj15CpPWPlXKuHbq4u8z1ZzVTGlEO+PPKAzvC2KOe/?=
 =?us-ascii?Q?3svU4SvxivWztQlyUqPtIbTfVUtSpJgp+mHlKWIi5QpGfrkIgnLPGh5im6hA?=
 =?us-ascii?Q?StrdprynHwftpknyPDt+RhajTBlamXSGy8KlH32G5UisO7dBemqsXQnJOJeq?=
 =?us-ascii?Q?8SBsRmVS72Jkd/GRUJbWeXAb+SQyJZr++jPSO2QoGHzbg2hfR/AXPCZaH8m1?=
 =?us-ascii?Q?tdnh3bfKnvOoPeAoj27ABV9BaprkgPxPeApywrjhWcYqhcbRief/fZGjmAqH?=
 =?us-ascii?Q?BecynI69+ykciFRPPJe9a04W0iK3AHE1brKdmcKhaTddmJwumzJsr+1FBmKx?=
 =?us-ascii?Q?Ciyk8+9YJrk1Hd1p0R5NZJmIyAjJVdDJKe2pp9vnc7h1W6EHdDupJ8+Wi3jF?=
 =?us-ascii?Q?zNXAvG9TLYBY+CmWLzMEaY6WzlLLU7PbZ4zx5tgTesVL9lMKtFWvHR0xyjvm?=
 =?us-ascii?Q?IRXD318YJxfPXlVd0uJzIzkM8XM+Y+1N9B9cdO4STWEL4DshDrDW9mKns1+g?=
 =?us-ascii?Q?msGkIeP60HY2XrlYdWGVFj1W7IYjolkx5vHIzFI+q5DoNxhsejGAoiCmkGxi?=
 =?us-ascii?Q?2CD/hc8G4CixHXvFwoWbfZHjSW/S6c3VtYD+cZp0opbicB8Nd+fXw39uNC0T?=
 =?us-ascii?Q?K2IMHgpBfFZu2ZNWGWJlvolLBSYHfAAT7i4Fp+430laHORT+81I1NQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 06:06:33.5177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 677e4025-9841-42aa-364c-08dd45ab3de9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6974

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

