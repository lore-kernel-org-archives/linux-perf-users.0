Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D4F193438;
	Fri,  6 Dec 2024 05:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462310; cv=fail; b=poDu22W/fj9Xa63Mu2kYVCDf8CZG0lNHAjKCNPqGSWHREfeqgiHknKzFVDHHNO9BpKSj7YvgkcJWcfnqDRH+UcZK01/mfNnyJNipWAfadtxM/R/pV/iYyQsPcElVFszetcpWLkHu0VhEeCz6Mu7CRKRGuIB4z4NQrsKMo/DMpwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462310; c=relaxed/simple;
	bh=OnNEGSXXH29F0O6Mfhr1W5gluH+6mdK7alXk91aW96s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+6/5rRFlLFHRUfslACzpKOlGwVO3oAOxBr8BWfg1CM58xSUn9CUVoue1WMXFsV/A/Do2BtqiXI6mg8rHnR8MBgoWKFfwXjKGA5m29P9P//LaJhTuj0nNVBCbQmdlmI6whtYtWIzbjEiKmcITW0/2m3A/+fDSIlN29lXXbsAsZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BXAv/beI; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BXAv/beI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UljX2YUtI8m0zSUV9q+g/Naab+wAXK9fC+m//p4l1aLPX47aXuZdvqUaU9T4al6/b5IUlJIULXjPdv2YEih5qj12611nuXmvD+rQntEdwd82CuSAXzm8h8y9UFTCbaUOui48Va2KnfXoZJg5/D7LaDx45ICgaFZC1kM7+mECi1WEz/y0qbiP+u81rUB1MCENgvxxUG4OVnARfV3HxmYDe4+jZcdcpb2WvzOX0JUjU53p9Z/X6TguZ9fAlE2V3Fem8HmV9m9bIcTiYUgafGEHyQZ8Tp1AuB8DTMTK0rm727Mqt/ELZhjkNxaToQDczujstKS+LU79Ky/ZnHbDAXMFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxHwCmW2FPaVxpSKN+umKX07ruzJqv3Sd1JyWW/j86o=;
 b=PvXqLLodfKwNgcMihC+JGHhKFObuYDws2DxnOZ75amHrB2PdhatwFtNl6GwVf6vlHy/FBdu5ezdFk3tBKJe/eXws/cFgaIf5F1MQFNoBOClB9lJbAEHjNmvveFh/ovMqIj8PRMQgTn6bUKm0w54JdpPPkBF3qQ6Gh+REidXt0bmrz9eEP0HrgBkSr40NVZDlBM/x3qIPucak3fMt4B3rC/qJyZyiVKqDBw4rhNF8kIc/Ix7tO9ZyXnNwhZQ0h/NXZtcdCuPTXF50KsMgxeL9oHNVM5k52+YeeZNtIVU/51Y52Tr6ePc5PHZgCOTBNW2JGWH809T5fpV+v596X3U2Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxHwCmW2FPaVxpSKN+umKX07ruzJqv3Sd1JyWW/j86o=;
 b=BXAv/beInld8nYsjWWvVUx4Bv7qAhqJHitdZR+lEJxKdWCayhMhe4hEAx4NrHt47bzNKvI+mOhBSVgU1nwUO+/slI6zZKrb/DnM9Qn1dxDTgvDDz8apwr7/k7Rm00njnz7kUXkDUTo89VY7/4068dTB5avVZylXknBlr/IuQXFY=
Received: from SJ0PR05CA0146.namprd05.prod.outlook.com (2603:10b6:a03:33d::31)
 by PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Fri, 6 Dec
 2024 05:18:24 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::c0) by SJ0PR05CA0146.outlook.office365.com
 (2603:10b6:a03:33d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Fri,
 6 Dec 2024 05:18:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 05:18:23 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 23:18:17 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 07/10] perf/amd/ibs: Add ->check_period() callback
Date: Fri, 6 Dec 2024 05:17:10 +0000
Message-ID: <20241206051713.991-8-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|PH8PR12MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 91189fc0-668c-45e8-6c06-08dd15b56867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o3eL+jF4kZF3mT/sKU/ivYmgpvIZn/kcm85cRoBDF2GXxc8+C0lgTQM8SNLi?=
 =?us-ascii?Q?e74LpL0F6yVSTDGf8LxlfLvakaOq4Thfl0OAtQvJ2kCfXV3LtHAjEu32+ml2?=
 =?us-ascii?Q?1erbjxR1PI7adQokz5uV9/G9FWzWDzGZanpCeotA8IiwHYF+ws/MY3cwfw+g?=
 =?us-ascii?Q?JSGNWPrtd6ids8NEcOvU9WHZyJsJxzl8OnX+qR80dqmDzPxQtX9DA7b9mvCM?=
 =?us-ascii?Q?3Aldas/QLg+Jz88lZOU2BFFpF5oqYzMT9Zqio5yP+63U8GiRNy6aTaHxoM1K?=
 =?us-ascii?Q?ndoXg+eVBXZQht84aG9aGFfDhDWuXJxMTWAkPJ0gOkQpuWm5shqRSuFlU+zg?=
 =?us-ascii?Q?3Kt58mNZ78lKyIs5DtDj3M8dOSYO6/GeUt//dqi5WTNgmJsFTUbgKS/OnCmn?=
 =?us-ascii?Q?KUlkjUV0LNydxQchzTvKLctE6lyGwni9UD9dZmN8s8H9Ode6qOduyzpZn758?=
 =?us-ascii?Q?K+Kf/G1P4PDjyKuuZhyUYs9q2dqiuxQlgz2/kgwSxaddncCOmet4JOITmwe6?=
 =?us-ascii?Q?JsddrRexotTtmWIakkDEUCKNZt1yQJSxd0pZN9RQXj6bSv33f+mznjkceXnp?=
 =?us-ascii?Q?K94mNjNDL98pSZZ8d7f9p21het/gSZCbLEpXLMUgzd86znHBFJi0pRsPsKmB?=
 =?us-ascii?Q?z8MqMZFhPfGr4J96ESopug1FUXDzIh7zjP4v0QsjCFFuXrgPBphKMGqkgWBp?=
 =?us-ascii?Q?Q2AdpUw1w6nx5Oed9gJiBCZg/B0PyRVUDLuZBGC2558Ju98rmYpkxncBPUU8?=
 =?us-ascii?Q?IK3WMZAUML57XxMdGhOGKvTiLPILi8GZMAq0jyuTq7KD7dWN/x+w4Qvx/iKA?=
 =?us-ascii?Q?quEKHE6fN5LohbMy8i5RGznz9000s8paQy6MeNXis/ShW9OtWkRgAg/cOo3e?=
 =?us-ascii?Q?8RI5bsPlDKW1anhp7B5HaWMgEKmgdze/SsCZyYnad1vqOIR00E3o/tLaATMB?=
 =?us-ascii?Q?45v4tFx3oQ5mmhhgEy0n98+8dhy24dJU9pZIjU9fEYuEpcW1kzIyGU8QDNPD?=
 =?us-ascii?Q?hwEK5fJkUfAWCTHTz3wSBF5CaPoycwaBKaTrYf7UZ7ie79ifqGSPZPrwxrKS?=
 =?us-ascii?Q?gLx62K71rBw2v2posQ2UCa+JpP4R3a0o0DVrk/3rkx6sYN81ppY9Oe32Zrz9?=
 =?us-ascii?Q?RyoYRxjCu6/eb0b3LMb+FsfAaxeG6R94DzOZmLkc2Ixv9cynm9851eRpAx4C?=
 =?us-ascii?Q?uJeuetgk/DO1dUDOhIJhYYv7mYrdPxhkVMGpsZTFIC3C828WTmaElrvwz4Ou?=
 =?us-ascii?Q?A8xKQ391Q1XPqNaj2a5DCDHGTe0E+WHiXsPR0L5xJXTR5/czB3deOWzE9IGw?=
 =?us-ascii?Q?iqr1l163cnLS6YaxFcI8QtXxCmGDyAz5ZNlLJMR67Qb23naGjoecxeyW3QLY?=
 =?us-ascii?Q?/K8U51gldkg+URRBniWtOIgLDdejj2OFZSlMrB6D1zD4D7UMmPCIuNlV27i4?=
 =?us-ascii?Q?Z6lxKshUxfW5aiS0g+0xX7kgTM+sLFoH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 05:18:23.9788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91189fc0-668c-45e8-6c06-08dd15b56867
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868

IBS Fetch and IBS Op pmus have constraints on sample period. The sample
period is verified at the time of opening an event but not at the ioctl()
interface. Hence, a user can open an event with valid period but change
it later with ioctl(). Add a ->check_period() callback to verify the
period provided at ioctl() is also valid.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index cc58ef4d8de3..54a434722c79 100644
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
2.47.0

