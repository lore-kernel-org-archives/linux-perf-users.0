Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463B322FAF8;
	Wed, 15 Jan 2025 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920031; cv=fail; b=uQGPOZXIdV2Sa6gCQDyJPd7kLR9+Dx1JrFxEsWrJuyPR77MjbqBnYliuFTLH1qrvx0IPGwOkxHHCXnzr000FjdpuKNnxp2UQYZztmayrfO9JJBnbtw7AF8cC5dapCWuwoVz3OmAYiw1qAzMUAdz3V+cMEQrf91jJvhcOyP0KZf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920031; c=relaxed/simple;
	bh=i0A3OCkDuilZk35AaFJGvtjNUXlwAi176YnfoGaTVoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2aTyuSctYLHTNdRTwqq4g+Ibv5pEfvEHHHwvFDHC+ewynGgAuuRGEKLfAtuM0e4wBOu7b8mlC/pvSyNjZV1CdDg5QOsYGWpVGeZEl/Iu0ck+2owSAO1Cvik2f1Kv785KB/gRZNfLsmbUHJ8nKQEncG0N2e7ykmXOCvUxtgzrlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DSapbkyw; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DSapbkyw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJQB97M+8gJ/Fwc3wyJUdAyXUe2cnsLGIpbNbzMDigZtumxBTPiW5QkHHHeVOuWqEI6gbN8MPFzAEkrOWj3p4u3kmRgbIQ2btzU99lCJDC9ZTxyFQYziRvJxkLEkUnWilN8lH7jbQ7mHFCnzz0mPK86xUiOYh0q9+ZIRpC6gvxN/9y8YCm7cHjNlxzwaIVgfUe2efYe0idtAUA5e27i8Sik3ir3mnLG7C0/IxxUoojvFGXjjjaPeZZeaxN0+kdfZn1LV3ghDXrtrNS+8SGXk336YFevdOnr/Ke3fCrX5QlFIoFpnCPNQQVQ1U9XsZcUrFoDekAaBp/fMtCrmpSX4dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yahYhVz4twi48hph3lwzlrT/hp2CKvMmSCu2tdlGwIM=;
 b=tbOL5CP/2Q5A0zZFt0UQowQeiD1k2bgZaE/4IXn10npUo0ocHdSdbtMIwDjF+ZSCExMQGMghX3eG4VXI6UZLbj9HwohvzU0x/F/ASHGFm3HpROXa5MY6nUMUarCqOaE3cFqqmrd+xKuVpxFKR0oeBvNfSxB1T3iikkh3x+mpvYz599Rm9fSenSjl1haok6tRPfwBTtHPKQdyfHIAnlWWMigq1ixposLSxXWqfuooLTTD5VUWWwP+iiGqQTaP8m9BSfjIMBdrrQZr+72D8O7e7aDxRcD/Yla5mOVrEIVr/CdkrV6sJxsQ711IGGhhWE/oBmf644NJcl3pPAfAeocrVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yahYhVz4twi48hph3lwzlrT/hp2CKvMmSCu2tdlGwIM=;
 b=DSapbkywXOJBIWzjFCcU1ueSs6WFMKFM1VTkYAqOI2RFdBgdTxzokx9a/xJemZb701739pp0XBG8NEGV9Fjgwm78i80Ti9fbaIVBjuxFjnBG7rqK0MmKWlc4zZDUSBu5qoQ4jnUScUWOwUKmFh9hR/1axwmIXfpBwev4oWT04Ho=
Received: from SJ0PR05CA0191.namprd05.prod.outlook.com (2603:10b6:a03:330::16)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Wed, 15 Jan
 2025 05:47:07 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::5d) by SJ0PR05CA0191.outlook.office365.com
 (2603:10b6:a03:330::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Wed,
 15 Jan 2025 05:47:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 05:47:06 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 23:47:01 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v4 7/9] perf/amd/ibs: Add ->check_period() callback
Date: Wed, 15 Jan 2025 05:44:36 +0000
Message-ID: <20250115054438.1021-8-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: d1009d58-cdcf-4152-471f-08dd35280bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jpjbV6Qt52zrgZdII8qAnDgv7Y8Qs1OUxZFD+iqCkXoEiexgjzEgSW8t1jyM?=
 =?us-ascii?Q?kf+1Kr1vLZEspvej3RKkyxza9dVQI4nPgGtOt46TExYv7LGv7T8r7Qb3iabw?=
 =?us-ascii?Q?d7shPqdG8JnVg0UAC8d8qnTTCyjB4ulM3i4rJ+r0pX+8T4FTk1R9BAati1aA?=
 =?us-ascii?Q?vfCvE5Xk75Xwlr3biwf1WHqNXvJMYfiMXtO2ALOYKGypbVbWdUbKYsJpCpPX?=
 =?us-ascii?Q?SZwNE+6upuAA1EgkCbUzUkLvmvGztZVjVcarkGjZTiE89Pb8IOxgUDhQsTxQ?=
 =?us-ascii?Q?k+tw26DCCS0gtl0xEapZI/xoSp/IaXgIDdWVEna9Lvpj1/UOHpYECZyV6yl/?=
 =?us-ascii?Q?+ABMz0sHi22WbGjNjyjru9CLinmKUlV2TQWuHSHU0lxQ/VDJGihY/YAoQUL/?=
 =?us-ascii?Q?Rc0/8SGo4vuJcEeShgzSS5uDCIADTgf59cAF30V3qjrDZ6khagWMkq/kaOKR?=
 =?us-ascii?Q?BnWDl+vmsOKuQiDZ9LJoCLlKeg8Z9gFIZERlQ5N8ZgJQGilZZiNkiPGaKmxb?=
 =?us-ascii?Q?9Vx1wIxiy2lIR4YKuTSlXkcDzp+7RNnYSOjaAuexhUzc1Qf/1peuR0blm19I?=
 =?us-ascii?Q?OHoAU+fFlVJ9LjTtzBNk1w9f65G1/3BxSbjJStohY70PjT9mgRz8JgbwMA26?=
 =?us-ascii?Q?9BMWyCBq9M1DWdso2cT3PudmOSEBlaJ46yQw5VesnT0M+bEs8Y4PeXV8JYLP?=
 =?us-ascii?Q?sIXZlQo/HoaI+17UXmNEM2E4+sFOO2Fr46x0+iLtseJv15vPP3u8qt7azhiy?=
 =?us-ascii?Q?y8TlVDY4TMFMNfynCTKSsw37R7w7sTHkPv4DJhaQW33AhBC87JrZ9uQEo43A?=
 =?us-ascii?Q?VXH6kRbMsZv/OreDyYQnPITjsf46AiB4TgljW8QHKLlr4foJnw2dnkSCj8AR?=
 =?us-ascii?Q?lnPYc7cD0yINC+cR4an2fuVpnZWo7uVj8mruxZiWDGWy4zNI49da1BNaM4sU?=
 =?us-ascii?Q?tXPU4AZ5dWzJHYMUzVvTjiae9lKRxzXafnod7PtncBm3+zewprrKSDnDW9LY?=
 =?us-ascii?Q?HRqRokXWSjt6y3mq/zpYqW5vNkygX/WEwf4FJAIUw0COfIW+kqep/gk1k3Ym?=
 =?us-ascii?Q?YigUrd3Pq4pC1J8/jtD7Dzsdos3yNZpxbOTHhQJyoQyr1uydjY5RRqH/5k76?=
 =?us-ascii?Q?qReEGb8m/HY7LCRrhGGteWNszQalHloNSpX7mIH2n36uFs0UqhmTk9p4uZBI?=
 =?us-ascii?Q?9mXh/hBA2NNS4gSWjRUJAW9azMLaqVeBNTnEH/O4bGqSDHC7VLpK8veg1n9X?=
 =?us-ascii?Q?EDsDwSDAubkJSfDZlYnsW4As/Y6+209jViT1XZfYeiYXI2Q3mg7amgRY5vmf?=
 =?us-ascii?Q?QLBzMaP3SrLfK2IUm/CUedlThBjZ0I6Kc8jyUzviwQZlpvrOrPcfERAl2LOJ?=
 =?us-ascii?Q?Rqtr93LVIiTDQdQHmmKu5RbbhjwpW8OuqkjT6vr7n2KBH6NlwjBda8OlX4wd?=
 =?us-ascii?Q?1abDAMEPKU2Rz1aAsNu4f5LvrR3eTL5Vwv4YPQA6P4B74XA1QFxghvhvB5f1?=
 =?us-ascii?Q?lo8SpjXVO2XrM6U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 05:47:06.6571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1009d58-cdcf-4152-471f-08dd35280bb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520

IBS Fetch and IBS Op PMUs have constraints on sample period. The sample
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
index 7b54b76d39f5..aea893a971b6 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -564,6 +564,28 @@ static void perf_ibs_del(struct perf_event *event, int flags)
 
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
@@ -696,6 +718,7 @@ static struct perf_ibs perf_ibs_fetch = {
 		.start		= perf_ibs_start,
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
+		.check_period	= perf_ibs_check_period,
 	},
 	.msr			= MSR_AMD64_IBSFETCHCTL,
 	.config_mask		= IBS_FETCH_MAX_CNT | IBS_FETCH_RAND_EN,
@@ -720,6 +743,7 @@ static struct perf_ibs perf_ibs_op = {
 		.start		= perf_ibs_start,
 		.stop		= perf_ibs_stop,
 		.read		= perf_ibs_read,
+		.check_period	= perf_ibs_check_period,
 	},
 	.msr			= MSR_AMD64_IBSOPCTL,
 	.config_mask		= IBS_OP_MAX_CNT,
-- 
2.43.0

