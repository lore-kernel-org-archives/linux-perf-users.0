Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B40E1862B8;
	Fri, 15 Nov 2024 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731651030; cv=fail; b=pLNOngua4CDieskBdWzpoJYqFH+9vc8UnORphPjFbFJGV5adQQg0WOr2MQYr895fc2MLaOcFYhD2DzRzwTX+UpUmoZsw6J/ezLIbhyHrQbzaJnNpZuJsOwYmatbAkmaEQzUidv+D0IwTvQ/ijqTC5QIDk33jDkju+NwkHAtzpbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731651030; c=relaxed/simple;
	bh=0SEAXqdWOX95JHfOwUwz0yHfCjRT0sRdvOOltauD5/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jE5vUNcKdGctdUxAhV4zgBnOfg5fxcG2EGgN+vZW8PHBLRTc95rbBiznlCkyErft+2YCC43Pry9vKQhRBnrZa7lQIR6LLKzcKKno5nLvTi3tbtdFUre8htzuwKrpPA2U0p/VBsRe4nXsBDRscc1xcW/9Sd2xxBVD6r3LnD+6C1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QpgCeB8M; arc=fail smtp.client-ip=40.107.96.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QpgCeB8M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9THX3PIHC8hR/IkFw3IPxNyaTJvtzGDYCejPTrf3BZTnfNbDGgKHZPkBYhf8Lk1MtlbMCMEym79uBeI/M4izXhOhySLbBZdelso+0gEy/9TCogdc7hDgs9lCsoQ3Ku37TlsYK59diM+bG+YaRpXv4kA7pEW0O/c77BJEGbltlwIr08e1S3LWk4rzpAtma2R7fz1/17RrUIGWN3umhRE/CH6BjUf6uZS9Z9EK/nxnAqXuph8+NJ4tLKbfgFM+MRYx24a7VsI6uFy1e6owRKHuIa3rt9JXZpKzjmQxoHYXs76eM+YPWYgIx3EsUKW+4pajDma6W2ckwuLfaAik9jzow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vRxE+ELAFrrZ4R5XqWDAY1FATjd5AKZcPF1Lma9w90=;
 b=IvK7c37nEPTY3sE6I8mF0x7MCDXdFShzJq3UzSmjsUg+RCq6rDI2pzd79+tOpF5La01++n1AGfxRdTza+fIPylMAGxmiZBx3AO228n2sYTAXz1W4zbtToEA6PtqmXMOIv/YVGLdQJMNvsWC452D8WGDnuAgOn0Z+Ornv6BHSuXiOAe+CmUZNxsUtFfsBRkaxY3qb/20nOd5olTwc2M2LwJ/TJmwtkdhXK6P+3O2DaZV4736Eubt+dmYi4ZmQowbuvGxclOq4ZEkSJdC37S/E+00FGLwtcx4j1MK8T4sYbY3PJ6+0Z41DGdlDQgthjUskRpDzanq23DEu9O7D6jv3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vRxE+ELAFrrZ4R5XqWDAY1FATjd5AKZcPF1Lma9w90=;
 b=QpgCeB8MoGW/R5SDtGx//3cmdl5+eQDAt4M9UoMYA+oAvO/XLEZevV0NaKD8aw2lLlYmNtHZBmpTFvBtjIBSe7EggJ6XZc6gvgbZ67OpZy155XXO4X8WqzDk26MZer7NsXCmE4QkxYMM5aVH622Hq9S2mi4uAp2goUdjwm2MVdA=
Received: from BYAPR07CA0013.namprd07.prod.outlook.com (2603:10b6:a02:bc::26)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 06:10:26 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::a9) by BYAPR07CA0013.outlook.office365.com
 (2603:10b6:a02:bc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Fri, 15 Nov 2024 06:10:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 06:10:25 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 00:10:20 -0600
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <rui.zhang@intel.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <tglx@linutronix.de>,
	<bp@alien8.dei>, <gautham.shenoy@amd.com>
CC: <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v7 06/10] perf/x86/rapl: Add arguments to the init and cleanup functions
Date: Fri, 15 Nov 2024 06:08:02 +0000
Message-ID: <20241115060805.447565-7-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
References: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf7d47b-f312-44ea-261e-08dd053c3271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PW/NKN49Nu5J9aYW51oFIcM9gQoLkpykBX1Ja1vd1UO9CQDL0ujSY5QuIORL?=
 =?us-ascii?Q?QgiIFzUSeNFclyyOePxuJU47TAEcGVtmvZngSyrdIkeD2mVtzhE364OnEn0V?=
 =?us-ascii?Q?SPm0unsN5l1n74hIg3VRkPCX9VFYivyvBODSQNeECcLVrrONkf1u+cVVGq8x?=
 =?us-ascii?Q?nn4WZpamXNlm0NJCep6o7CErgMk/JLtBRpvEGkrSYYSM8BEjEVwdhKD2VoOv?=
 =?us-ascii?Q?ghe+agNwEPVahlxoFinoLY4w7MGejYzBepWONapC/1fNsP8yPnJMl0OnWRQo?=
 =?us-ascii?Q?2UOgh2n3iqo3jM3dDzaJTjc6+E0hp5zta7DwErAED48EZDS4VtsYZGj5bIgd?=
 =?us-ascii?Q?/0QiwNvikwMkGBIjIn3QL0tamIANoF5DoTBO77IcDL1o7w5+3rRaOTu2p2FD?=
 =?us-ascii?Q?TLFaa4U0EDuCCT/QeGD9PLCJPcj4Rhk8RG6OkZqjvkhedc0V7iis3RZC1R6h?=
 =?us-ascii?Q?cCG9uJ17+vmhHv7+0xSUq4EIPmy3Y3p9qQQaxrV0PXb/cQjZM/SJA7La94lq?=
 =?us-ascii?Q?qU0WXtOg8tsnKTVrkZT0Xr0fJZP7pswjAq3hDEpXAB7wSfgh/tTI9z9//q1D?=
 =?us-ascii?Q?gem3aqEQDxdhzXgj9TWT869jYrlPjZszkNCi3Bb/JSNxWmiyCpNOMDx1emN1?=
 =?us-ascii?Q?g28gzWE+/O5tlNNisnnbsk+nEvu4IesmB2VgoUFlrCgSK9OACg5ca22hzVwt?=
 =?us-ascii?Q?7gwIe4x7OLQOm/vahVEcjQcOCYxNVCVMxzRwZoGxENyHrU5C8IHyXGHCrcBa?=
 =?us-ascii?Q?Ivtun0Z9Jnm1hIIKMr50502Kmnpin/jxy4+KrD3vCar74nGO9t9QH6cmo8DU?=
 =?us-ascii?Q?VrCP8A22WSxhoLsIY422QgUEUoPPlC0hNNN4i4CoXRVUrDmbf1Bg8d6vkAEK?=
 =?us-ascii?Q?kE3X0NKAoHOGFJ++0HFFuHjnVD7Lacg8lHOXMnTcsvASxLQhccjzEcAJFyDV?=
 =?us-ascii?Q?T20/eEa4ooRH/+vW6Qud8vdz6CXZs2uNdMqKQ89S46U56Ka5pPhAyjylgMjF?=
 =?us-ascii?Q?uXh03bK15idPC1U/Npe8mS6CEDaWdPYKAdRT+XiUQsWtf1ju2HxiNIMZaJs6?=
 =?us-ascii?Q?VgfykDzKxfQmBwUSHbDKo20plyWFsSc6YMPQ1W5XxZHRCOoFOw7784gPEdb2?=
 =?us-ascii?Q?ipCjbNOtJ8cnB/1XCmSGvaxhiBiW/BbuhtesWyrqkEUuv97Ahxz0JmwEEIei?=
 =?us-ascii?Q?u2ucHikb/AHSPhsz4dUn+t2+9/n9P15S9Gj9uVaqzXIaibERuwmczj5/ZhCo?=
 =?us-ascii?Q?yvu4EMXyxBdGnzj3yRynymc6vX4JPNaXDcr94lyHEkO30YKCdGF8eAgApcsi?=
 =?us-ascii?Q?cEiEvGQYddy8H3WeY75lABmtsgBokM3CMWVwBp7RYNBC+DYHbIqNEu9b1PaR?=
 =?us-ascii?Q?KtB2G4ATQiYLhI1+ahqk/sQ0YvucDnJs7usJOUwixEH/o4Kg/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:10:25.7212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf7d47b-f312-44ea-261e-08dd053c3271
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913

Prepare for the addition of RAPL core energy counter support.

Add arguments to the init and cleanup functions, which will help in
initialization and cleaning up of two separate PMUs.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/events/rapl.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 0585e15caeab..f353008b860b 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -602,7 +602,7 @@ static void __init rapl_advertise(void)
 	}
 }
 
-static void cleanup_rapl_pmus(void)
+static void cleanup_rapl_pmus(struct rapl_pmus *rapl_pmus)
 {
 	int i;
 
@@ -620,7 +620,7 @@ static const struct attribute_group *rapl_attr_update[] = {
 	NULL,
 };
 
-static int __init init_rapl_pmu(void)
+static int __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
 {
 	struct rapl_pmu *rapl_pmu;
 	int idx;
@@ -646,20 +646,20 @@ static int __init init_rapl_pmu(void)
 	return -ENOMEM;
 }
 
-static int __init init_rapl_pmus(void)
+static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope)
 {
 	int nr_rapl_pmu = topology_max_packages();
-	int rapl_pmu_scope = PERF_PMU_SCOPE_PKG;
+	struct rapl_pmus *rapl_pmus;
 
-	if (!rapl_pmu_is_pkg_scope()) {
-		nr_rapl_pmu *= topology_max_dies_per_package();
-		rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
-	}
+	if (rapl_pmu_scope == PERF_PMU_SCOPE_DIE)
+		nr_rapl_pmu	*= topology_max_dies_per_package();
 
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
 
+	*rapl_pmus_ptr = rapl_pmus;
+
 	rapl_pmus->nr_rapl_pmu		= nr_rapl_pmu;
 	rapl_pmus->pmu.attr_groups	= rapl_attr_groups;
 	rapl_pmus->pmu.attr_update	= rapl_attr_update;
@@ -674,7 +674,7 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.module		= THIS_MODULE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
 
-	return init_rapl_pmu();
+	return init_rapl_pmu(rapl_pmus);
 }
 
 static struct rapl_model model_snb = {
@@ -798,8 +798,12 @@ MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
 static int __init rapl_pmu_init(void)
 {
 	const struct x86_cpu_id *id;
+	int rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
 	int ret;
 
+	if (rapl_pmu_is_pkg_scope())
+		rapl_pmu_scope = PERF_PMU_SCOPE_PKG;
+
 	id = x86_match_cpu(rapl_model_match);
 	if (!id)
 		return -ENODEV;
@@ -815,7 +819,7 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		return ret;
 
-	ret = init_rapl_pmus();
+	ret = init_rapl_pmus(&rapl_pmus, rapl_pmu_scope);
 	if (ret)
 		return ret;
 
@@ -828,7 +832,7 @@ static int __init rapl_pmu_init(void)
 
 out:
 	pr_warn("Initialization failed (%d), disabled\n", ret);
-	cleanup_rapl_pmus();
+	cleanup_rapl_pmus(rapl_pmus);
 	return ret;
 }
 module_init(rapl_pmu_init);
@@ -836,6 +840,6 @@ module_init(rapl_pmu_init);
 static void __exit intel_rapl_exit(void)
 {
 	perf_pmu_unregister(&rapl_pmus->pmu);
-	cleanup_rapl_pmus();
+	cleanup_rapl_pmus(rapl_pmus);
 }
 module_exit(intel_rapl_exit);
-- 
2.34.1

