Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813CC18785D;
	Fri, 15 Nov 2024 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731651066; cv=fail; b=P9ISOVKP3e/MndJNMOl6c7S+TZ4RQyj0SN4fsRuDwaYJIdQOV7Qsp6qOEzYt1WmyAprqLNZR5cFJcyGAbYcrTa2qvEZi60+ECLaIWDZLTz1O01P2qtCiq8FQWfMf7rGeXONS4/Yi3SSUO1/YolUO8YYpTtkTbdn407pEToA3eS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731651066; c=relaxed/simple;
	bh=VXuqwJ3HJCMMgTHSEykQvj/cgsoBd6FU2S2AFLaCCQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhMv1qXW29oV7Ptfpco+SGVfeb9EAxljvUkkmPMq74vlqe2RqfixL/PBgV1MGm3MXRW6SVYzBY2LNMgwHBvVtPndQdoY5hG9x37puZCcU/JjP3y3MqzEoirGPU40de0HfU0iS++jY1ZoeRQVAnlr9bVQyPvAjhm8YIjRn9x5cuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=krZQ1WYe; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="krZQ1WYe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGUUOiW4HbthYJDrwYL1PIPRNVWYVVnZjeGLN4xQSUVSUgpwrjyZGUJ1SyyPAICGV2HWT99Dsfri1gsar9XS8nwMNZD3AzflAFj5RgdNOg+mALIAVMZs/vxQ4JstHL9toFXSeetv6v9YrFuKPF6ZSCoKS+wErz7bX0R2Csc92OxEk2ooF2kwYoLyyouew6i9mch5Get4ATfrGdtYtRZzoYxMkSK6z+GR0TuifWTwWpNmzQDAmSDZC0Ps8gTKsN+sMJQyda33NayaKPL7c5GfBIPeNfYnLpQ+ivdaFHbks4C2VgqLgSXWeri2xqSRWpC1oIY79gd7OpPPwOvR2u+HAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrvJ8trO+5TzohBrPW3PR3dQTxn9fj0J/UI/1v3RjVw=;
 b=GGGOFu4Aw5J8DaU7vCDJx4+6YDhYSFpWzqfUtRwXn8eoE/cwKVenWrfLh/XbmqCrDiHOcS4ECBUe5b8nvQJnx3PXLC7IF/yFfx02r1T5/Z+fIXyw5kUXBW+ztWJBEnzgMCaiAX0lDnVrcXVzsaEktav5T6z6EeERUxGqXF3LI/difFwu8eoiE35My7GvBEtqRsV1Di8W30dJYhnmQ9/7s9Oen+slFCzufHNkhooYiWWUbLkd2lxB5/SyEwZYsbB5RWtD9mimXQ02DztOk1gSCQQGPgHmdHCL4db9F1ZY1uy6JAtc4Ak21tL4pkOPqEV/+rmBcn2eOlErWju2EbaFQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrvJ8trO+5TzohBrPW3PR3dQTxn9fj0J/UI/1v3RjVw=;
 b=krZQ1WYe/wU2NpTZInA5G0NFBAuHKwLL2Tg3iHy2use7PdwzZn+xEzUDt2u1KyO0tdeu0GR/osIwgTx0hPDP+F8oB45fBrJDl9JUv2V/N3T9CA3M7wFG6mhFfLWzL6QYx96p6ciQZzA8alXGgnaZchR1awJKpHyZSU10gjmfpYc=
Received: from SJ0PR13CA0184.namprd13.prod.outlook.com (2603:10b6:a03:2c3::9)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 06:11:00 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::1e) by SJ0PR13CA0184.outlook.office365.com
 (2603:10b6:a03:2c3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Fri, 15 Nov 2024 06:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 06:11:00 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 00:10:55 -0600
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <rui.zhang@intel.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <tglx@linutronix.de>,
	<bp@alien8.dei>, <gautham.shenoy@amd.com>
CC: <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v7 08/10] perf/x86/rapl: Remove the global variable rapl_msrs
Date: Fri, 15 Nov 2024 06:08:04 +0000
Message-ID: <20241115060805.447565-9-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: f262d2a0-bcdc-411a-fe4f-08dd053c4713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bvksXg8c9zzgp06pF0q8DlLLSBQLKN4Lz5g8W8w26ufQriHrUumXoUWuKJOS?=
 =?us-ascii?Q?wIwqzPXky7fW14JHR1i2W1Rg3gM06rc47kaHU+jkpnMji4mvhQ9DumVDXc3J?=
 =?us-ascii?Q?Gp2LvPc0A+wDP49qB2WyD43uSwS0gS/m0KfcvrYfj4cyWBS9Wboc+abo4A8w?=
 =?us-ascii?Q?FHY9n8vBnaAd1+tzVXTGtjinvjjViiztS6i+KlOKnXVtw8f+F6llYQgBzen8?=
 =?us-ascii?Q?rEBmCdHmF+WGWH6kgJQbt/sdC5vNGtvCgEIqHWEg6ukLKegvzWrd2oKo/pM6?=
 =?us-ascii?Q?sRCwSH1Y0oD5+rMhSCjcht0SOh09FRy8tn5tNNiFYv5czvs9ZxrNWssjY0WU?=
 =?us-ascii?Q?zH3BxIDW//yJ5b4GnktbZRXcCybBlsA7hRtHk4NBVGEnnf8L6FUGYE6tQ7Gu?=
 =?us-ascii?Q?dDWB+P5NIE5J4oF7mUpEUnPMHjvqlp4pGTXZKexWMUtc3xfNlTVfb92dbxJw?=
 =?us-ascii?Q?2d3kgD0gb1XQMneNG2mFe2/GtNGjs1RkQd8Lilz/U2gkN0lOaEn3tvcuBXVp?=
 =?us-ascii?Q?+GDqFsUSr1jXLDniKBZpHQjP8MCMjDIVrYI+xz0ieYsDY3J0CEXNRF8domnZ?=
 =?us-ascii?Q?Bjz+oJMX0PK6g6AKvZ33wjnTnFYG160ZGKP022AgrRYqCTvzWfUilRTHO8qd?=
 =?us-ascii?Q?n+miEUL8QRwtsXhYQa3R4JdG4cOtexI9uMUmvQBUWPiYXkQEmNk/C27kDQbr?=
 =?us-ascii?Q?fdHS92fhXqWolBWujz7Qb36CvF3nYKytroFtjiCvfK3yU3/YuZbbQOuFrkMD?=
 =?us-ascii?Q?LpKMLK7oO+0xiANmVUD+vwo8RhV4cd/8PCMXpUH2q6AkcPptF+r0pZ67rIUr?=
 =?us-ascii?Q?FEj/DSQ50GSHKS0SlgrIuSHJrP02x01rnuyOkDHbfeWyLzAqgmbfYB4p2NyC?=
 =?us-ascii?Q?rpdHJIvt4lukZOIUPnLSucEigr3Bfb3hWGi3mnHdVXh8NR4WQltYHbmnQWBa?=
 =?us-ascii?Q?R1w3EmBSAYH3JuAoFZuMpiaPtRYfzwSpNUszMMmbJFNTWSLDUQ/pWU03e1S7?=
 =?us-ascii?Q?RaL+XrapNQ25TG6gsNivhEpN3bMfAvh392GbdDzTwZn/38h11fuqysbBPNMO?=
 =?us-ascii?Q?XhDh7bWIwmyraIYdsI/PzOXV1ghRV1gOa3eZIKVJ1ZRnWK6V9jV+tptOiz0+?=
 =?us-ascii?Q?Azi9ncZ+C5/K1iuU69Wnf8dqOrVUW/vnwrWZRCxU2RYVdcoOijDoBhW/36KS?=
 =?us-ascii?Q?Dnd+P/e06CWdOxUoyZbRMAgMG9m4sjsbDcaxBWVuZfrkJ6mGU5U3y7F1ditI?=
 =?us-ascii?Q?xXnoB52SHmZd1qUpsmvYb32pV4mgd53PCR6BE+Yw4grd/qJfP+iByXtsReBC?=
 =?us-ascii?Q?MN2wLn2JC+8ClsDvorLqzs6Z4bLtL8DyD7ATBQnjR6k24omJqm6vP34adOel?=
 =?us-ascii?Q?kIZFFv/Z6AqtFbANT9VLjY2lg7+zugyK4nTJbRCF5Wz512+QEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:11:00.2647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f262d2a0-bcdc-411a-fe4f-08dd053c4713
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045

Prepare for the addition of RAPL core energy counter support.

After making the rapl_model struct global, the rapl_msrs global
variable isn't needed, so remove it.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/events/rapl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 2398a8452709..46ad20b5e7c5 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -150,7 +150,6 @@ static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
 static struct rapl_pmus *rapl_pmus_pkg;
 static unsigned int rapl_pkg_cntr_mask;
 static u64 rapl_timer_ms;
-static struct perf_msr *rapl_msrs;
 static struct rapl_model *rapl_model;
 
 /*
@@ -381,7 +380,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	event->pmu_private = rapl_pmu;
-	event->hw.event_base = rapl_msrs[bit].msr;
+	event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
 	event->hw.config = cfg;
 	event->hw.idx = bit;
 
@@ -810,9 +809,7 @@ static int __init rapl_pmu_init(void)
 
 	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_msrs = rapl_model->rapl_pkg_msrs;
-
-	rapl_pkg_cntr_mask = perf_msr_probe(rapl_msrs, PERF_RAPL_PKG_EVENTS_MAX,
+	rapl_pkg_cntr_mask = perf_msr_probe(rapl_model->rapl_pkg_msrs, PERF_RAPL_PKG_EVENTS_MAX,
 					false, (void *) &rapl_model->pkg_events);
 
 	ret = rapl_check_hw_unit();
-- 
2.34.1

