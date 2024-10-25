Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A171F818C;
	Fri, 25 Oct 2024 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854919; cv=fail; b=uNXwPCe4f8keroQ8qJwK31ro0Brihp57s/G97cVr+nGhFzKjzPtIROiZqQqfRx5LNBNOghJ0B0rTrolijElP0q0Rcx78zSpFmxla1bW66mAPNfk68W+CR5rIF2vM5HoIgYpi6+LKwSEVRBu3+4q1isx4TyAKcySbt76hLze7R6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854919; c=relaxed/simple;
	bh=151CHlnVgmoq1dJcq0MmTHrTmzg7hsqkM+kg1WYnRNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lrw4kkDhBJhL6OwzM3/iqcfwleBMxo01G4hG2ZFePY+4VIJ1tc2f8FmvBUe6Q143ob1EWpqOSmVxoq6qkuFjWWNm4A7Tc480LxKs9p+SVr6HbYcNKG11DdEVcuF2Ji7ov+vZBa1Y+CAVEs40hFhhzfHwaF9k9aJQ0E2bgT1Xk08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=edosmxUA; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="edosmxUA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dt8DRxZy1NXZGftCWnDr0zN66IKrKAYxLIY7UcuZ/FeL4UqtPPDqFSuyeXHakIuivpmjHr/T48aEi86rgf6/pn5zJouhWr2C0UBfpjGDOrQkEIXWMPQOURi09iMhpgAgzw0YjPdZLQG5rjMgLqinkl1pj63BcWbNTr+wvZ3vyKugrs2ubkgWKRpfCWdiGZJyJtU+KXPhJMLkC2alrw2UlhNzPV1sV7tEiwMQ8QID33T7dHmAHJLosSXcm91z7i+bfHcoxuysuCE1oS4i9ykOvCu20MJDoTrfEVOKcVdvEihi9MAFPyToYzDft1Lv2343AYd31bfnnO2ZuGfNl8Xl5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uA1vtkwWX/GbXoHm6NhyDM1ColKr1CAUZuHE3EdQlO8=;
 b=lUlyJ9/7oZ4TD92q9YaA8gVkD/Orzs1iE7I9B/DuGSSzE80HsWiU8oAajbDu2N9gDz+hYQW8H4ryvmKw9RzQWtT36KqGh/ApFcoU55YjeRvRsQdsmfOVO4jVbYwD7J4GKVMC+lYPIPdIjAySf2wPdvTSWI5eFP8eYTf212gA9SxjqmjGaKayWz51UozVj86qdDoOl/k1AxbH5+VoC0NPE1OsRMSWFIUS1AozsxAQPjfunuLOoF47+pdCgbR7o4IDPfWz5bUxsX1WtAX5j9BOOInpLZGplYFpaygv1ojpFQL+mm06zh6p/m9tlq9swyUDc53pQM/xb4pfzjq572/IMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uA1vtkwWX/GbXoHm6NhyDM1ColKr1CAUZuHE3EdQlO8=;
 b=edosmxUAaqOEgYt0bjgl9/AYxtNnxMtUIONxGXQmMtbW+fPSeqjG2W5lDN3aYxUfDVYCMAYW/zzcDYEtwSfEsX2YH97ICoT3n6M5UZEcCTD6grYM7irRfS0gADVXCaNzEWPQyOJaTxgJbtxNV31NwN5mabswd43gzXTbQN710uE=
Received: from BN0PR08CA0009.namprd08.prod.outlook.com (2603:10b6:408:142::13)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Fri, 25 Oct
 2024 11:15:12 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::d8) by BN0PR08CA0009.outlook.office365.com
 (2603:10b6:408:142::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 11:15:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 11:15:12 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 06:15:06 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <rui.zhang@intel.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
	<kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v6 03/10] perf/x86/rapl: Remove the cpu_to_rapl_pmu() function
Date: Fri, 25 Oct 2024 11:13:41 +0000
Message-ID: <20241025111348.3810-4-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
References: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: 8555701b-a369-48cf-d1b6-08dcf4e64b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R82REK5B9aaR+us3OlbIslS+09aj8HiCny76A7wT6Nlg9/Cp38zCn+qBTTXo?=
 =?us-ascii?Q?5RFtGpKxSjC0pfm2UZ7/tM7cA+twZZMzBSNoHpyyfxNYvzzTxzj7tbIguTHK?=
 =?us-ascii?Q?OZIfyCY9D2p7ifV3hq5PH5f1QNcpoL3I1jQFq/9Lz0dxvNwMvRIX8IBaQHfT?=
 =?us-ascii?Q?7YEaPMh6WDrvGRTsr+hAP/SYl75vOgFwYFkNgX0W75qLSs4zf/niuE92IGfQ?=
 =?us-ascii?Q?P3kijeANq0Ujj9NjJ8fOfVybZ3OUzYh/tDKBJ/oqrwZhMKFzDN65vjPrvuzU?=
 =?us-ascii?Q?K+uP+9CZbAqgtdEdqkFc+jsnAr9+f5dQ683uKKQvK3ZzLlVoOmRjW1LnYoyV?=
 =?us-ascii?Q?KT64yZBh+klsRB2iakA8uFgm6uknIW2E83TxTgx8n1UopMYceOnCKGb0S9bF?=
 =?us-ascii?Q?ftP+o8TV041uY7SJUZbs2S2IMQTwZtnhLoPQnBye3UNRc9Dc2emXB8fUGPRF?=
 =?us-ascii?Q?Ha14ciYEMcDXgNoFUGYQsFbpnQO372OxqCboK63yo58zNxQVIYuI3HzrjZjH?=
 =?us-ascii?Q?NBSVeRSwr1L4pkc3KFRTYKY4EPRNyZfyx4/KeMAw8dSzPMadTSzeE7hltOPH?=
 =?us-ascii?Q?eZttWeBksFAj9uRMaCiEAa89yt9i9Z05MweO+Ze9t0IrWZ4O9qbCaHoWkbFl?=
 =?us-ascii?Q?nWf0rmlj8upsZgRs/eL6Q7c2lULKKitcLERKatvUhUbbsVcaiqCSZxyeh927?=
 =?us-ascii?Q?F7i3E0oSm/BVPzAGzVqj2tWTDVt1HRLObpycqmDCmQuFtxj7zRH+lypXI5v/?=
 =?us-ascii?Q?JKTzN1ku2TibMW1r+pdM+dhdEhWJy+ZD+K+dLlcAAlRa6f4DFOVYxWk3EW0+?=
 =?us-ascii?Q?cW8zzbyES3pYSNuhWfUp0/HQ326YsFJBigfcquOG9gKiAq0DTRGdJOv/VvLW?=
 =?us-ascii?Q?YxzPaJaUIEwIL7iWl1VAX+1xZFvsW5f/lnAGQNuruu7LLr0I23mmYcEC0nOc?=
 =?us-ascii?Q?v7ndpOe8BdiXXM/svivZoa7Ik5uQ/h1cACrv+f5/RHYcVpksWfLziw6zY98v?=
 =?us-ascii?Q?Ebp+34sw0cbLIGA096AssNjguQxAab5/EIHbX5+OIzSZiGOMnewelhy9GTVO?=
 =?us-ascii?Q?+xM8NoonGQCoubygO7olFdbdAPx8oVYYzRbMCnjMRr6cb9KXMqsT3L2oyNQq?=
 =?us-ascii?Q?UMDzqTRtaRpBp7ZA5OG2wnPpUxNIRoz0+5oimKaJbrRCYuYNXKwJK0EEpPE7?=
 =?us-ascii?Q?j2Opm3aQDBZ6RcCivyieAO0xxzyMGFDZ+0Fxpkmt39MJ2j1AOGNQ9b+EVkB0?=
 =?us-ascii?Q?KmAjyUekFuK40hO2P68fSUynEKLGvlWE8s1jdVikGy6oFSQ9XgDRjqFTbb6W?=
 =?us-ascii?Q?1nn3k+9r1wZI6iBVMh+hw+/1Lh6vv1/CwWeEBXfHjT+YwikL+nh4nywdoF27?=
 =?us-ascii?Q?Tl3cZyjLjDU6zXNCWw6BepArHoLQULrFwGcaGKqoDeCPKWVrwN+VTtV2b99t?=
 =?us-ascii?Q?OrWgMSM8I8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:15:12.5072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8555701b-a369-48cf-d1b6-08dcf4e64b79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243

Prepare for the addition of RAPL core energy counter support.
Post which, one CPU might be mapped to more than one rapl_pmu
(package/die one and a core one). So, remove the cpu_to_rapl_pmu()
function.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index f70c49ca0ef3..d20c5b1dd0ad 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -162,17 +162,6 @@ static inline unsigned int get_rapl_pmu_idx(int cpu)
 					 topology_logical_die_id(cpu);
 }
 
-static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
-{
-	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
-
-	/*
-	 * The unsigned check also catches the '-1' return value for non
-	 * existent mappings in the topology map.
-	 */
-	return rapl_pmu_idx < rapl_pmus->nr_rapl_pmu ? rapl_pmus->pmus[rapl_pmu_idx] : NULL;
-}
-
 static inline u64 rapl_read_counter(struct perf_event *event)
 {
 	u64 raw;
@@ -348,7 +337,7 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
 static int rapl_pmu_event_init(struct perf_event *event)
 {
 	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
-	int bit, ret = 0;
+	int bit, rapl_pmu_idx, ret = 0;
 	struct rapl_pmu *pmu;
 
 	/* only look at RAPL events */
@@ -376,8 +365,12 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	if (event->attr.sample_period) /* no sampling */
 		return -EINVAL;
 
+	rapl_pmu_idx = get_rapl_pmu_idx(event->cpu);
+	if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)
+		return -EINVAL;
+
 	/* must be done before validate_group */
-	pmu = cpu_to_rapl_pmu(event->cpu);
+	pmu = rapl_pmus->pmus[rapl_pmu_idx];
 	if (!pmu)
 		return -EINVAL;
 	event->pmu_private = pmu;
-- 
2.34.1

