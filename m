Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A961865FA;
	Fri, 15 Nov 2024 06:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731651084; cv=fail; b=ditMR9jplA8K3gPEqBhVfTYuAPrA8ylqm2+4RL5eF1YLz+q5xdEaj/aqOaPZzLslSiTNOiJIYxaAFACrcLm3y11988QvvmUhwtzfqbyd53MAXHkOYbGhvfKwI2NwIfz7yKuj44JiJU5HsJQnxj/8Zemw/ISALMUBxdeATD2ld4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731651084; c=relaxed/simple;
	bh=Tc9sbqIJ8yTNisb74bXDrbkEWSfYC4Keje5mdCyPDn0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZU7uO8ivIhHEiHGbkaQ0vAdXAX122MEF/3s7CiOLW4/zjyqcl6P6LFX6DASvtoqTaFcjHOxzw9RLVsVMIqQtookRYy33449bKjye56saeJGc9aWni4MX/YGwr1pD4MXJaHp3nTWQXJu/dTaVo30V+OmoQpn8Qr0PwAkEzLsZvdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JbgeCsU+; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JbgeCsU+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhLdA/1M5PxlMH/GCk0TzHX6q6bzXfjJ86qbaXH7vQnE2hRIXnR275jJQQ1GkTPWoCwZMHoZkogse6IwI0qdwXmufS+O9+OsnF7szAVsSKfs71xWnoaFscCmKK2HwYHdjeSOWTLXGC8B9E2/8JoXR4LPrdJj5TPCDvpI7NEnXbOwxj+29gWe6WdVcSd3ETZmZsiJrRfGOen6KDS2B7HAcB1pm3AcDKS7SoIGkcplMOuGBMdXwb7aJtpPuvSYx9raV7ZljtKGAdH8bS0IYgJxyEAxFw1J3JlmAGjhSEHGI8+tpwfUbbhBG1NSUdhzwo+qvToNVNdpNtMnZULWbFwcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ES95l6RJZCSUkSnIvTAFnC1XECklJ4v00bK5xs09YI=;
 b=K6jLPz0sOFIqg6iTluuwzDBDlRzo4V+sFVVeMWo8Ix0pgTXHtMVRexeMnVghfQikADXJN7ckpkJWtttIsxbZfiRrxr0+DE3tKfVAs9LHmb4mf/1BGRAlMaFgknSPxb5B8RK4l6B3neOK+Y+kWLDgk+tJOymhL9dQ3qoHNQun+9o+7RMArzgJ42Qp83YxAu+tSOHnCEg9LLbox9/Dd0481TagbLF3CdvrxOx61qvAabgQCFo3fMQ6Swb9iFXy26xzC/4AdLAvNFNNuG0rdQC2E4Bf7AVxu+euYicYZ/elaRoj13lZt9YTjAnZQh46aXNOqHNQt/5ZqBMq6pIPjfsz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ES95l6RJZCSUkSnIvTAFnC1XECklJ4v00bK5xs09YI=;
 b=JbgeCsU+YSiKEO1SBIygqqW0TyA1ZmErNKHSxG6jL7iy07T26pVJEI4g30mXBTE09GaKSyMkhAdOtWzOoM/kxFsSPl8lVPF6WXYOSkXqh8hGXnrirJAHJ8PlCrD6SC2P/IP+QXWP3E1ZfcgCAM+2uJpB15Qa+yupfLhvZ8PiArA=
Received: from BYAPR02CA0004.namprd02.prod.outlook.com (2603:10b6:a02:ee::17)
 by SN7PR12MB8057.namprd12.prod.outlook.com (2603:10b6:806:34a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Fri, 15 Nov
 2024 06:11:18 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::33) by BYAPR02CA0004.outlook.office365.com
 (2603:10b6:a02:ee::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Fri, 15 Nov 2024 06:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 06:11:17 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 00:11:12 -0600
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <rui.zhang@intel.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <tglx@linutronix.de>,
	<bp@alien8.dei>, <gautham.shenoy@amd.com>
CC: <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v7 09/10] perf/x86/rapl: Move the cntr_mask to rapl_pmus struct
Date: Fri, 15 Nov 2024 06:08:05 +0000
Message-ID: <20241115060805.447565-10-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|SN7PR12MB8057:EE_
X-MS-Office365-Filtering-Correlation-Id: ba428281-7268-4d92-1e95-08dd053c514f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ynbm3aPydbb5Q8WftydCvlkv+pU79w37spi0mo7Nwn/R+m0xHKo/YyrjzYxd?=
 =?us-ascii?Q?WPVaCa6kLTZVGc3HU+/CkGAeky3Yv6XP9Sre4BWn3B8o4NfxX33IlOw4XRL7?=
 =?us-ascii?Q?r641nX13sqXtukRTmcZRZIAtQT2UUAn4JeZ07SWW0k8Zws5XFkS7Tyfa7vnX?=
 =?us-ascii?Q?CBPbwEjijmddJwvDO23ZkBoeprmP+KgWG9xxkTOcudRetVFSLXjxxG7PO4G/?=
 =?us-ascii?Q?cPxrQpfmq/Py3tc75NfE7aTAgtQcQaNF0CH9B9HafKYYKPXqbPWxlH78/XdY?=
 =?us-ascii?Q?LDZDbTdrqH78VrEi5YkyTyr0EZNynq/Im06JEFxvm3b5PVyCxijR2VT9EOxc?=
 =?us-ascii?Q?A30oRzxKJ1Gn8aOvlCuftjvUt8eJlpddMUfYhGfbQlk7nCbBO7cLHcVD5Qc9?=
 =?us-ascii?Q?VZXgcgmq1X6arRLb/GEd/nDeqlNLgAfggDdSj4IPonsBs/hwgfM7yPMrxnkN?=
 =?us-ascii?Q?EiZzn6GEhI3QLt67UvfceJyJdnPQNc015BbeQLhXyLjEl9RxNl2TsoXbayc4?=
 =?us-ascii?Q?ggNcQKq2Xh3DI0Dx165ksYG1vsbvDhstzjU1MkmpS0rT4xS4RBmZYmt5C9FB?=
 =?us-ascii?Q?pP1WDdf9JhUJ8XXfIJQufdwbTfZ0cnoJHR2oCdOxh+YaNDxH7ktjS40HgcsL?=
 =?us-ascii?Q?u+gmw1wbtfp72zRFM48ixbOCS8DuzdrthMV7Ib3LA14aYdTkOhs8ehp9MAKf?=
 =?us-ascii?Q?G+x8xNWyCz8kHl8MA0+t8q530nr6+o9LWpmjte9kwipHi5BvuajsFt6jVcT/?=
 =?us-ascii?Q?5no2bauci2/dWd40X0n6BlYWAxWu9sX9rMzthlRcit4KOOuUrkX9HrPl3gtQ?=
 =?us-ascii?Q?ext+8Q1fdWdJfGnmIEDTv8aRH1QhAqW4zi/cYN3osj3MdKdeQBfk0YRyz5Hf?=
 =?us-ascii?Q?D8uW97LFNNiCIi2uLkUxwtTakBqqVjF3XMgQ/TQwadmZd2kch5vT/uZqadtf?=
 =?us-ascii?Q?FvFynphFj7NsO160KVcnmmPK/MkitXJqMTaU0MP+XqsqErDWodTWanMT7PhP?=
 =?us-ascii?Q?Wa07AtUVV1+lfmor+1IEF+jPGgHkRyOIhpjwpGiADEiqWPeNW7cqHNHIITHf?=
 =?us-ascii?Q?uP+zH+esgtvnNNrOPmunvQUpPaXuugiCcfrcuxSJiD98mlCPUc72no5gaopz?=
 =?us-ascii?Q?NfLrzgardGsdrWAehKGXvfpYSK5YKMKPjLAanr/7TT6ksXpylBsse5/PxsTq?=
 =?us-ascii?Q?NkPY5MFSUo7gm1SgPR03cOs/HqbtbR/lsFE93b9wZoS+K2oFyKOkgk/Ls28d?=
 =?us-ascii?Q?+nFO2ttu+bk37vdwIwzu1kYPDTBpflf27rXYa/v8BXgOiE91sbUHGA569Fqy?=
 =?us-ascii?Q?LhwQwqksAnV2vdMU18sQL1Yhc1Hi+wlHythl94eY7YkGajB+aW9Zb83o7S8Y?=
 =?us-ascii?Q?FrCt73MohI/3i91MK8Hs26/1lDI3B0gD5DMNdXI6jacnegvucw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:11:17.4450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba428281-7268-4d92-1e95-08dd053c514f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8057

Prepare for the addition of RAPL core energy counter support.

Move cntr_mask to rapl_pmus struct instead of adding a new global
cntr_mask for the new RAPL power_core PMU. This will also ensure that
the second "core_cntr_mask" is only created if needed (i.e. in case of
AMD CPUs).

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/events/rapl.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 46ad20b5e7c5..6e51386ff91f 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -129,6 +129,7 @@ struct rapl_pmu {
 struct rapl_pmus {
 	struct pmu		pmu;
 	unsigned int		nr_rapl_pmu;
+	unsigned int		cntr_mask;
 	struct rapl_pmu		*rapl_pmu[] __counted_by(nr_rapl_pmu);
 };
 
@@ -148,7 +149,6 @@ struct rapl_model {
  /* 1/2^hw_unit Joule */
 static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
 static struct rapl_pmus *rapl_pmus_pkg;
-static unsigned int rapl_pkg_cntr_mask;
 static u64 rapl_timer_ms;
 static struct rapl_model *rapl_model;
 
@@ -363,7 +363,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	bit = cfg - 1;
 
 	/* check event supported */
-	if (!(rapl_pkg_cntr_mask & (1 << bit)))
+	if (!(rapl_pmus_pkg->cntr_mask & (1 << bit)))
 		return -EINVAL;
 
 	/* unsupported modes and filters */
@@ -591,10 +591,10 @@ static void __init rapl_advertise(void)
 	int i;
 
 	pr_info("API unit is 2^-32 Joules, %d fixed counters, %llu ms ovfl timer\n",
-		hweight32(rapl_pkg_cntr_mask), rapl_timer_ms);
+		hweight32(rapl_pmus_pkg->cntr_mask), rapl_timer_ms);
 
 	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++) {
-		if (rapl_pkg_cntr_mask & (1 << i)) {
+		if (rapl_pmus_pkg->cntr_mask & (1 << i)) {
 			pr_info("hw unit of domain %s 2^-%d Joules\n",
 				rapl_pkg_domain_names[i], rapl_pkg_hw_unit[i]);
 		}
@@ -809,9 +809,6 @@ static int __init rapl_pmu_init(void)
 
 	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_pkg_cntr_mask = perf_msr_probe(rapl_model->rapl_pkg_msrs, PERF_RAPL_PKG_EVENTS_MAX,
-					false, (void *) &rapl_model->pkg_events);
-
 	ret = rapl_check_hw_unit();
 	if (ret)
 		return ret;
@@ -820,6 +817,10 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		return ret;
 
+	rapl_pmus_pkg->cntr_mask = perf_msr_probe(rapl_model->rapl_pkg_msrs,
+						  PERF_RAPL_PKG_EVENTS_MAX, false,
+						  (void *) &rapl_model->pkg_events);
+
 	ret = perf_pmu_register(&rapl_pmus_pkg->pmu, "power", -1);
 	if (ret)
 		goto out;
-- 
2.34.1

