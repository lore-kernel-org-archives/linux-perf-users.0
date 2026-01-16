Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AA018B0A;
	Fri, 16 Jan 2026 03:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768534536; cv=fail; b=An2mnmSNWDrqAooMsFp7Z7dEC2OEYIVkRaHIVM6gTgW1dR86Er2YsJ0RaUGz7pC6lsjf1qg1ohJ6+GMJGIFy7Ms03N7innMOHK+B3r3XooslzzgdurXnTcRUfoTqxPnDt69fFugsCBMLqfIcS3rPqufx8fx22XU7IfTpPGGBJKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768534536; c=relaxed/simple;
	bh=3sVhLqIteFcjmmgd5YL+Pd75cwiwSS5/u7DX8jVcehw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpxuWxr+vI8CMVWHyuP6P9XxfyyuFDp4yH3LucUESx1or11cybcQsEosfwmH8qKa4dsVWkIB8rfVQEqnGcQDgHFdSzfH3t0YVQTiUfuhmB/wtC+4qNLw9mkbgWQ65yTBjS29Y4ULEtTndRaDZK+NSaDtfmiam5lSqBuU+7TD+G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kYoUzWdn; arc=fail smtp.client-ip=52.101.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kYoUzWdn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqDb9yCoEOk2u0rbst2x9j07L5dMDYP4JNRKp4lVqOU25HJiPMqXPtcVJK38RXLCXiRz3TugInhGqmt7nK9ZpY7J6d6VZmaEPaNlHiT6ZO4GcG+YI3l57xIDeGZEJbcUNTSbaQRkoTxz37H8KeWIRa3IvB8XE/0TdvIUCulSou1GxCrcv0u6ORFgAOOdJLsHdOeIPcxrjw+TiJSyQlrTdta6JQFH2lm40RDR0iPabdrXhPySgr2PyezmDi8OFA3s6qOZjTLODm0O080oBZN66Uy+bBruKjhX32CJ5ORNtzP0hwAPaoSrveVDWu1v/qKIYE4j56UPBY4COMjLyXoq5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7c+kjyBQd9QZ3emhSk9detYtlsPyvsg1/AfUmGAtE4=;
 b=YfmqAIEHto39mgcxD8F4fIzFOivQhoLzxjp2oo7TcKzMyChGkRV/PIYXsrnebvDVMqjUzEDcX7rOTubHhpNSXb1Z6von7daLyPGDdHgtCuZMM2b7lNldYDAgc+l52Cj8uS2+miXpsASYQCdjusTYop7rK1Qs5qpsO/BB8FYKmKX6j/Fz7maIMHsYpW/LYWCFboXTaOArqlyflBxKQhAHmcSgTQJRgA4l27o4HDReBBW6vkQIkpU7dXgiYMUZ9LkoymJ0XSF0AGfJ6hYnTs+zV1aPYIfKx+BpzWT/NLHUhAxggduUo6aWqfNrqLt0sdUIVojKvAHJA3LCKceJs3+yww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7c+kjyBQd9QZ3emhSk9detYtlsPyvsg1/AfUmGAtE4=;
 b=kYoUzWdn21mRSFh5RvQWsAX+PfuX9EAcoJ9FBY2xC0Uf4Z5mnO54vJNf0G+Ti4RjRbhkzvZTpeXHVdYhfBsashJV37MptjXNunzbsEnDfY3k1PKpy/EqNeGoYTgdNV9J5QzJyip4wswB2VVqzmIheHxlVjDUJuuMiZH0vKmJMV4=
Received: from BN9PR03CA0653.namprd03.prod.outlook.com (2603:10b6:408:13b::28)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 03:35:30 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::eb) by BN9PR03CA0653.outlook.office365.com
 (2603:10b6:408:13b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Fri,
 16 Jan 2026 03:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 03:35:30 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 21:35:25 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 02/11] perf/amd/ibs: Limit ldlat->l3missonly dependency to Zen5
Date: Fri, 16 Jan 2026 03:34:41 +0000
Message-ID: <20260116033450.965-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033450.965-1-ravi.bangoria@amd.com>
References: <20260116033450.965-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f77d37d-0e33-496a-c268-08de54b04c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eEJ5IqoKL7NgcbYRYX7hYH7lQ09FJm1fC1SdqZ8PyVtngrFhYk2Q3TJMVB2W?=
 =?us-ascii?Q?xsBOxywvbhXsCzp0DWNpeCP/VsoIC1MHHsKQYZdJoX+Gg4o5rK5DjWKOxUqm?=
 =?us-ascii?Q?4OVXn4ErGu1lShmHCrp2hI2sAtntZBC+6hCPLDcQpJthgR6f+MWVgeVSy6cs?=
 =?us-ascii?Q?QUIzNHbKzcnZXMiktc7+QpYv3vQIeKWa+A8Cy591+aHzZevFeajIJu4iIzgI?=
 =?us-ascii?Q?Hob8qK7/67sH87VfNp1KUQgfZ3i1IX96iAn6F135K+Tw9BT4XxSalCsS6CVM?=
 =?us-ascii?Q?B3uli0e1xfR9zGuKsSWDzBAXIXjtqBgExmm6h5125tPukwchAtQHHSAVUdE/?=
 =?us-ascii?Q?Eq0yUh2eDscgDrzKGJoy2A6b7VachC2pHx6EXTS/l5lfFHj7gBeS+/o9T0lN?=
 =?us-ascii?Q?Hk1zj0FIC5D1EdI1PAIu1SeKpiO8y1+8wbf9pMtO8UHRWWi7H0uRwCDQ3JLH?=
 =?us-ascii?Q?y0yrgF7A2ufjX9dwPPnMafQhZHIS8PlK9d3RO3Z7mJqlnLo0AUg5v4KbNvwY?=
 =?us-ascii?Q?0awRXRHwl0DKw7Ci6b9E4xSx33psB1qULW0PT5yCqZOfHSzEJLpyr05YDaPD?=
 =?us-ascii?Q?E0JLCS2etbjPJFXwSwWI3Efc0+MUbhvsyh3CGID/yKRdoX+8DrdBWvdHQApe?=
 =?us-ascii?Q?47oSLzoDZIU2utfY3u5OM+N3phfR0L2Ldxrtq4lDuCAa20e4yfIy9o42QnU/?=
 =?us-ascii?Q?kolMxUlxycVg5ymtJjmPPtuh/9hUaMFOLUa5pHHi0oqoHJePChxEg4UhSFoU?=
 =?us-ascii?Q?p/AjMoesZWRUL9RtBeZ4sGDr1ZC0iT7lZuCki/j4HVL+9tDoscp1I+JvI35K?=
 =?us-ascii?Q?k3NSmIl6X0JP8AWCPpDYFS1Xo4w8gplepibnHvl5iKpIwyUrdw30mNxgp7YD?=
 =?us-ascii?Q?o8V2OcpJOsfX7gzG0beiYgTpUD+0e2QyfmHVXd9RqRyTmTPSWlnkyUchldS7?=
 =?us-ascii?Q?iHXqbgQHPBuEcb31lMAQGqxKmHp/vATIykHnG2bPYZNv8lfw/v2s1mXXlQHJ?=
 =?us-ascii?Q?oNPHFi4eKNkKwdRqVPAkkQH4Wjdj0Lla3S4q143UC4ssx3N0iyVDzfUBYbdn?=
 =?us-ascii?Q?ZqtsugVXiX3KJ5+yGL0kJft5IpsjV6v/BBHc8waAqli/5u79qrU13bNP/aOT?=
 =?us-ascii?Q?fQUFFzB0XJQyWmG/ZbRADfI3ybv5MzSKzkITnArZo7F/KxEOHhiW+Ph+mn6v?=
 =?us-ascii?Q?17KFJIQp4bvRWKTroaaPFzlOypUyHiF++ThTEYhg/rvUBp+fwT3NKLnhmbS2?=
 =?us-ascii?Q?54Qoi/prsQ9otCkYEIdiMIH/nRH4FZ5/Xxkqcq/3HiodkTRNCuC551OEKJj0?=
 =?us-ascii?Q?WhBh+fueeJbDB/h/8ovEVOmmK454G5G/muezIjqpaINe4rfbVmMTJxXtNguT?=
 =?us-ascii?Q?VBdz0e3mmiQBBuoxmogu48aJ21AOdD389+b9jBI2LIvlrC3YmBW8XmVwVeIp?=
 =?us-ascii?Q?rsoyxRou8AMuJxhQ+jvQZ5culXQXzcs2ObZaAR2T79yVpHmqeHL14vxsjmkv?=
 =?us-ascii?Q?BSmyf15x0osOXaokQBunvA36xmqpptEst8aGMrwyJjkTJ6SEmMnEtJM4BQ4r?=
 =?us-ascii?Q?6071S1JweCVhiryxh8/zPeHXktJOggbkFZflv54V5O8xu35BRdGe6jFkutb1?=
 =?us-ascii?Q?oE7jgWUh0fmYhZuek4j7B5xf/fPQUWDQU3Xm8zMxQVP1O+2kuTBWUZtHuhYW?=
 =?us-ascii?Q?jHpc/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 03:35:30.2517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f77d37d-0e33-496a-c268-08de54b04c38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173

The ldlat dependency on l3missonly is specific to Zen 5; newer generations
are not affected. This quirk is documented as an erratum in the following
Revision Guide.

  Erratum: 1606 IBS (Instruction Based Sampling) OP Load Latency Filtering
           May Capture Unwanted Samples When L3Miss Filtering is Disabled

  Revision Guide for AMD Family 1Ah Models 00h-0Fh Processors,
  Pub. 58251 Rev. 1.30 July 2025
  https://bugzilla.kernel.org/attachment.cgi?id=309193

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 96bb0974057f..dc8cc173cdf5 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -356,7 +356,10 @@ static int perf_ibs_init(struct perf_event *event)
 		ldlat >>= 7;
 
 		config |= (ldlat - 1) << 59;
-		config |= IBS_OP_L3MISSONLY | IBS_OP_LDLAT_EN;
+
+		config |= IBS_OP_LDLAT_EN;
+		if (cpu_feature_enabled(X86_FEATURE_ZEN5))
+			config |= IBS_OP_L3MISSONLY;
 	}
 
 	/*
-- 
2.43.0

