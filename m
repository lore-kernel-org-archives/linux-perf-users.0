Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2B71A23B5;
	Wed, 29 Jan 2025 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738137974; cv=fail; b=iVz6fLVQNwqLZGQ8hBIw8mCH9/jlQGSIU4FMsnOvua184fQB19M3esk5A0vVGFnH7ogpznPKdFPGa2Bc10azaEqP6IvIrGakwwFGaI/ej7ZWQQKK1x61yRqFoKf1bquoLe7sRwg3W7deY1k3+5qCmNqY4991ZRnWQIWys/C9fZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738137974; c=relaxed/simple;
	bh=SYhXLPnpb3Tetw2rTyXBS4mO6s0FChe0QYQIYZzS0WQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xr9VpIOxUWOW4r3LdH6KFbXEeQHJUgawxKaIuX2+zugNhcOv/gA5uagcno5Je+Wo9uszllKRjnJPlvL60dxcqQRIL4rzDKLs0NwgknU5+ErS47zL7q88Mbj90Asb1ERkOzhCejMZW3oEA15X+8te4pCWexo4qyrxQ79vmvoS7sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tYkHp6rB; arc=fail smtp.client-ip=40.107.236.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tYkHp6rB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlqFk5Uhtp+A1vEG4lt+11BOVFCoRD5fBNeIQkEQ9q6ZbTvOTp5ji9DjWLzPtZTy7Msp2520pjLPvo8tj9OnBFMWWbQKpjOt9/Sy0uCBMUHXANHYyfQrWKreioQvNs9TudQrf4np9TtteVV0l0FVddKiN8p02T2pB9Oa5PaVflbZp3F2wfccRF1sQet/fIYkzMo/4OB6Idlilh1FJVb8nW9mf+unjbA6WIENolh1+kJkqydk5XkqfYWJhb4newnuqWk3bnHYtH6K23dnX2jESORBjzmfaVXOlh62GRDLMS5JG/UHsD1B0OaS8YSJWp/gPNccCUMXh99TuaUVLc8L6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lACbu+haTSfhOLoa4RR2QpHOApiJHDjpV7DE2lVP66I=;
 b=eM5rBuxxV6FyrdqKcm4F59VpgKcmQ+8I7NXS6zZNQTF9dQdIZi8ut4jbgzw01Kch7ImNQvs9iag3O/bEtZ1po+CLFSTvuhtfHnuhuRFjDYTjiFlXDzvdUj63XxeuJjYFLAViBex7PTUGLv/evOsYlQjRthavksfFWGgcOo42MmyAm+glu8S4VeAfDWOs6VbZTiRJKk6PIthHPSP9KCMrOuYpErEHoZg/UYvbcaaEaEUPTHwqcfM9RcyaDUwKE+OPBhmCPfs/d8oSkrKlmXguIhxeAp5yI+cgLgk2aybrB8qsmDP7VnzWkjB3jKZHaC2qtKS3uD2lvHZMwA4IOUG90w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lACbu+haTSfhOLoa4RR2QpHOApiJHDjpV7DE2lVP66I=;
 b=tYkHp6rBsoEkGFVO5pB8WlLtycOZGVpox+N9JVuB0IHHzyf0uMzGvYxg9xkJofe9H03mVN5sPgnRdn4zRQsjLFwynRBmiYtUXAhyBDtX7x5+KyajfB8MAAxzutwxC46kwsD8rEvR6T+PJMzACDaIdoVdFU4T4U5TJpi2e3cX2UM=
Received: from BL1PR13CA0430.namprd13.prod.outlook.com (2603:10b6:208:2c3::15)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 08:06:06 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::f1) by BL1PR13CA0430.outlook.office365.com
 (2603:10b6:208:2c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.16 via Frontend Transport; Wed,
 29 Jan 2025 08:06:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 08:06:06 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Jan
 2025 02:06:02 -0600
From: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <rui.zhang@intel.com>,
	<irogers@google.com>, <bp@alien8.de>
CC: <gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <dhananjay.ugwekar@amd.com>, Koichiro Den
	<koichiro.den@canonical.com>
Subject: [PATCH] perf/x86/rapl: Fix the error checking order
Date: Wed, 29 Jan 2025 08:05:14 +0000
Message-ID: <20250129080513.30353-1-dhananjay.ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|IA0PR12MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b921330-8fec-4fe8-b6a8-08dd403bc829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vgVKwcbXusSDSQ/9aSDyd+EacxwwxRmE0yXAPO4YuvnADmwhNV8PRbMnJ5TA?=
 =?us-ascii?Q?e3H+H/THqDDTq/hOnTg4VwzEt+Uv4i4plTxGlLoY2yHev3JRbsWjrq0BALgh?=
 =?us-ascii?Q?8g+fUsEHc/sgD5g5uWp3za+m8CGHHUx3+9WidkryFfkOxKCIc3VQMunt/K+E?=
 =?us-ascii?Q?JscwZ8f7Eog5R+tiTOULLAQdxbdGG3Dq+QUsEIj+1tA6Z6pVdJXoKzuFL8Am?=
 =?us-ascii?Q?4XKpOh8uVJ3z8CPt4Ek1sd/018jS/Z1NPuUtQT79d0AmyQ5EbombuYHCwKoJ?=
 =?us-ascii?Q?XoGmDGFo+CSIiAMg7CzA0oof6O2WDD5faKZe0XRVUFFwkmGCQXcL73dX6NQi?=
 =?us-ascii?Q?FoHQ44zffT4nJvzky+A4VSrA8F7+aV3GvOQZPgtF209iDuxLgEYumoqnzAJn?=
 =?us-ascii?Q?xOFq1v+lKpqOsNh19SNHIqdygQ4X7tfLIut9UtoQL/cs6DwKUo8rHbp/e1h+?=
 =?us-ascii?Q?+uiMb6bb7O7cWx8fSF3Mg1uAy95Lrz8H90Tf1yIv5/v/4VS1gWCGVvc/Nutc?=
 =?us-ascii?Q?65c/UCDhlBmESWbbNes/sz7MNxD5VxHxf/odeJMEkqTi5fBLkl8eiVRdU9ZH?=
 =?us-ascii?Q?mzl63Yc/aiB/6rcQbIuY7ZtHvw4Ozr4yKLzqlW/Bf813HJeUts8d1WqC+srU?=
 =?us-ascii?Q?HmtMG2BzwU7d+0DRVnRkDq7eJpWUKh/WX/JMIo/XCBSquiRwuHzaho5lQOnr?=
 =?us-ascii?Q?d7j4wtQTixbPKRrJj3Zyx9Jpe7tnJ3eVugJ7FEVkDOJzIKmeXNSHfYeZTHNf?=
 =?us-ascii?Q?cYUSaNIsn7GGsEDAzB+aRSe5vSJBAZ26lEqqVZrodR6XPW52bAkdzyU3zAL5?=
 =?us-ascii?Q?CaUMc9Ui8GltwlUcHp3aahA9YYRXKkUGybH4KmBOc0jQn9yPPL2VEfUOgB6n?=
 =?us-ascii?Q?y7AGAnq0iK9Ipdi38EiNiwdGsZ9PvMdkDncO0noMy8PglF2Zk6zMlCdfZDgy?=
 =?us-ascii?Q?EuDsdjioZlF9o+U4rz6tk/JviIk7xTsPV0SjpAKOUTQBhPhltA6apPaBMvpN?=
 =?us-ascii?Q?aumo3/5aHT8h2jiyYVQ4h//e8Y3681CiQyZCB7t2D2RoZpWfIRVRudPVfD1s?=
 =?us-ascii?Q?SDU1PmWnXjirkTMTW9U117y0Qc1cW5l31Sd+U7dJX8LVkky26Ot1H3QT8VS5?=
 =?us-ascii?Q?g5JslslR+QKZ/BmfNrpiG28dwddN2WYfnkHBQrNbnIjWef1qT7vFgq0y9Jhg?=
 =?us-ascii?Q?cOuyUL0SMD9PJuij+7lzZoscAfmSnRdUE7xTwKQzIJgs2qJT40xG1gqHFric?=
 =?us-ascii?Q?Z7zw6m8qSS7m1npktIYwq0H7VW7J26HT+2+GiLKeezs8/9egGDO6dmaFy6a2?=
 =?us-ascii?Q?84BbBi/v+HqTEi2yzUVQ/KFFPo3+fT+M3W2Ev1Tj3OU0qmiGPJzn1Nl9t/xx?=
 =?us-ascii?Q?PKk+QwN5nHMcgwn3ng5UUGIKSRtiKRynoi0zvCI5ljYVIK0gMV3cPXSiYMxN?=
 =?us-ascii?Q?jzOa5BNEW8s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 08:06:06.1122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b921330-8fec-4fe8-b6a8-08dd403bc829
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745

After the commit b4943b8bfc41 ("perf/x86/rapl: Add core energy counter
support for AMD CPUs"), the default "perf record"/"perf top" command is
broken in systems where there isn't a PMU registered for type
PERF_TYPE_RAW.

This is due to the change in order of error checks in rapl_pmu_event_init()
Due to which we return -EINVAL instead of -ENOENT, when we reach here from
the fallback loop in perf_init_event().

Move the "PMU and event type match" back to the beginning of the function
so that we return -ENOENT early on.

Reported-by: Koichiro Den <koichiro.den@canonical.com>
Closes: https://lore.kernel.org/all/uv7mz6vew2bzgre5jdpmwldxljp5djzmuiksqdcdwipfm4zm7w@ribobcretidk/
Fixes: b4943b8bfc41 ("perf/x86/rapl: Add core energy counter support for AMD CPUs")
Signed-off-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index d3bb3865c1b1..4952faf03e82 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -370,6 +370,10 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	unsigned int rapl_pmu_idx;
 	struct rapl_pmus *rapl_pmus;
 
+	/* only look at RAPL events */
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
 	/* unsupported modes and filters */
 	if (event->attr.sample_period) /* no sampling */
 		return -EINVAL;
@@ -387,10 +391,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	rapl_pmus_scope = rapl_pmus->pmu.scope;
 
 	if (rapl_pmus_scope == PERF_PMU_SCOPE_PKG || rapl_pmus_scope == PERF_PMU_SCOPE_DIE) {
-		/* only look at RAPL package events */
-		if (event->attr.type != rapl_pmus_pkg->pmu.type)
-			return -ENOENT;
-
 		cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
 		if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
 			return -EINVAL;
@@ -398,10 +398,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		bit = cfg - 1;
 		event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
 	} else if (rapl_pmus_scope == PERF_PMU_SCOPE_CORE) {
-		/* only look at RAPL core events */
-		if (event->attr.type != rapl_pmus_core->pmu.type)
-			return -ENOENT;
-
 		cfg = array_index_nospec((long)cfg, NR_RAPL_CORE_DOMAINS + 1);
 		if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
 			return -EINVAL;
-- 
2.34.1

