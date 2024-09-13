Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A466F2E2;
	Fri, 13 Sep 2024 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242596; cv=fail; b=ew3zE5jBdWN0WftVbgtUzeCUxYg3ipnbfFyV91J43t8eJDqrmHSoxnGwvq7r3WEom8T2XPJFi5UUxRwQsO182cteJcC24fM/vzMFx/CPoPNtguqUVcqDuRbVqpmo78v9JB1ixgPKSCNn7Nxrk0ST1XVMuuhUOrVQXLHx/Dp3QQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242596; c=relaxed/simple;
	bh=asA4Q+vezACrilQ/AO09MuJg/tQByCS/Yw0Rh7ch5iw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlLXEYvkmb+iNKjFoGxVcrDKS/2APYywIdI6ojbhTgOKY0Qq7VYFB66tdCcDFXbpCl6slp6/Umkp+6EwRzLk2KXIP0XJlochGcIFRC1CSrBXaNl4ScRv6d6nSrpo+dVYW5WvnGJNJH2d6FNobc5Sz0wDrOWDNfXK4gayeGC42SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R6x9ctnD; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R6x9ctnD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOCvN8PLnzqMDccOgWOVp3AVJiuVExJzbJPrXITdAGVsUE5lId7wwSFd9tsWkEPM68nwm5gquFU3F2F8enUORtNEzU1MUFt39h96yzUI2DsYVepbmWME8xNXKbLqEefWSRxtDgYcz+2G6ylq901iwln68uL/9JvdrQRRbUIJp5G98942AfoTcNsUHeAiNurO3PSwTp1UGmszXFX1CtvWFLYyS1WOTYe70jKoDW12kZyNXAeb76zOu6H0Lqtc0hPudGrEGSo25SnDR5YWw2xL+QfAgtVWf7+gtX0RgzPIoKYt76QeTQ3qZWV2pzKxShZJFtYJfGxUStyejsGbLASW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4AOCj45eYDbUSHZqNjBSyiv12RWQWqJlVuRcT68lnw=;
 b=tDgk/FBOH7pISJMEKxQpD++C7c7f5HBYtmqGe6Pnr8qBa3uYet7LQgZZ07klDGbOFpRhF190FcoqqPYKgIEhrqc6/xMvpFmAhki54sp+Pxu2CzywN+6r6UoykrrG+Yf2jnZf2BubEgpC7d6Bk5R67R5+C1C0YDESW+/NBapeqVoe9frqWKP+Bwl/fkmxnJkRh1K49+hnMGuXIgzqv5IWWL7QbXF/DKFeK6oksZvU6WwoVn2VPTEUB8VoZb94Bq+2Fh/xIzdtLFL4susFtH6UJ5ruPjR4tcOSBJ3Iu/efT2fwl72RwsGHSgEJYswVKzu0v5af2h8NLrbLuw1da4b0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4AOCj45eYDbUSHZqNjBSyiv12RWQWqJlVuRcT68lnw=;
 b=R6x9ctnDNCi+K9EWwffN7G9TQMWkkL3xGlYgxwW2OYeT0M3igppE9QEvPO34yVGIY7ggt4LM4v67uGib5q5o8SdqHwfNj4kOqRY/kD4TKDLIRVXL0jN2LO2xiKJf6d2pB5RhxrdiBrWA/kYCswVzon2mWgT49/UlNPN9fSunbaE=
Received: from BY5PR13CA0027.namprd13.prod.outlook.com (2603:10b6:a03:180::40)
 by SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Fri, 13 Sep
 2024 15:49:51 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::67) by BY5PR13CA0027.outlook.office365.com
 (2603:10b6:a03:180::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Fri, 13 Sep 2024 15:49:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 15:49:50 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 10:49:44 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <rui.zhang@intel.com>,
	<oleksandr@natalenko.name>
CC: <eranian@google.com>, <gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v5 8/9] perf/x86/rapl: Move the cntr_mask to rapl_pmus struct
Date: Fri, 13 Sep 2024 15:48:00 +0000
Message-ID: <20240913154801.6446-5-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913154801.6446-1-Dhananjay.Ugwekar@amd.com>
References: <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
 <20240913154801.6446-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: a3999072-2be0-4cb3-1cc1-08dcd40bb420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/kUp/wqGbqq3bER7lVpKnjYT+oHRGKluetPZUYqb2RHduYAL4YpZtgeVoel+?=
 =?us-ascii?Q?tW+dQo8q5u++tOw7JkeZBEXfWreWGkuQ7p6XObJtGFO6e4CwJqMhof2RgDyC?=
 =?us-ascii?Q?IT+BTWtScIpbGCfmRTrICtiPaOLOvv18bqJWZ+Ep7e34uKOAxjoEisv+B5lx?=
 =?us-ascii?Q?GHJcXwW0PSf0GXTGutnDjbHSa4q+jgNba6+5YN86JnYWSqPfRLWT0lEM3MMW?=
 =?us-ascii?Q?M5NQ8FRpoxik7gRi8eGotXCz4EUmaZmvLPkEK2Rm/59ZXAPEyQfh/eizoy20?=
 =?us-ascii?Q?+w+WTVRnSXqx1LRiqJ2DIm52nEuT+qbGzMPenveMiZ0XuY3C6CGTcnS50bZn?=
 =?us-ascii?Q?dbWe83ExAhK1ZY447BmYih9mAwqP3vHI2HrdVQ9ki9zqhthjbnl1F0KkVF5h?=
 =?us-ascii?Q?GspaY4A/nAwJrMLAO8PA4u4dtGaGbo84NlFMYbo98O0hsnjVrYqx5fYqmmMh?=
 =?us-ascii?Q?VRDflhbSBP+vA8SMtkbT6gXxIfijhgpI6MxO29i96rMrMm0pXYoWVcHC8DTf?=
 =?us-ascii?Q?gS4CV4FNCH7J06mTZyxHm/drMGPFMXet7tA+WEFgww5lFvjWf7i4YNjwZ/WJ?=
 =?us-ascii?Q?oEkykBOqQ0JPlOSlm3wF4t3/Kp5PF9mavqo4Qq0lEobTIkWQOWDG5AeGU2yi?=
 =?us-ascii?Q?c1FNdqn+Qzi7OirhBDgvJn8Ta+wlVg5aJ/GmH6AG9J4NZF4dALGtW4OCGKLE?=
 =?us-ascii?Q?GLafvE49wVIK1HmTLs2pcdocaHM+RUfM59DX8PTCo7l+qYZD1/gvgLdipqqW?=
 =?us-ascii?Q?BEaLS+oG0ljtKK7Q+r8V7xft00Oq1+zWAw5ykBE1jhzP005K8I7IRbgiXWre?=
 =?us-ascii?Q?wcYamYkuh05nm8MDdPsC1rVNpmXlSuxjf2mzFgcQaY407dpLBcAkdNA8PfnS?=
 =?us-ascii?Q?WknGbojyPpVexT3PIyrnEEFdfKHIqK/6OWbPcecwEbLz/fhzrCCOx6gNRK4D?=
 =?us-ascii?Q?6GD7IYsxaAaf5MkycyR1cIJXWbo0XerSJGu6SJKu0Y/ywiAVk3ENYeqafr4G?=
 =?us-ascii?Q?rPEDafFhObAxsjfqkHofrminsjzhy9OYgK1MKACwvsPi8MQLCOCzfEGkwpvT?=
 =?us-ascii?Q?Pg2/g7MmugZL9pkmbWloMLmDsFPZmOoL4/ltinoUgvn87fbL6cNv+c8g7MqN?=
 =?us-ascii?Q?o8Rb3YqNjUP+QzAy11yxfLj9YpXe+G5jP/uKNyFASaxvt1HmFgeUQG0t7Smb?=
 =?us-ascii?Q?KY/tSpEfXINJfCrhtrhEburTZHyBplmUgcoVjG1/O1BdE3cI+lvuEPmLabLr?=
 =?us-ascii?Q?AeikChlN78SLm7rj+hy4+pYfshmka46VmRh2z0uQKY/dQWmj2KeIP+0GBVM6?=
 =?us-ascii?Q?wVOT+w4xR4SA6pgy9dPF3MTApuofW6ngsNA3GLYnPe6EFja4cPzd31yNvDvc?=
 =?us-ascii?Q?MW5KLsDP40XQ6Lt9vdSEiPIkpFCXaKrPwzzTtWZi8DXCccYgof6zv7k4S7y/?=
 =?us-ascii?Q?sO/4qj73yelkmQr7kd4mNFXdBJ0Jh9b70RCe44pgY69t67Rn3v7RIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:49:50.9937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3999072-2be0-4cb3-1cc1-08dcd40bb420
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888

Preparation for the addition of per-core RAPL energy counter for AMD
CPUs.

Moving cntr_mask to rapl_pmus struct instead of adding a new global
cntr_mask for the per-core RAPL energy counter, will ensure that the
"per_core_cntr_mask" is only created if needed (i.e. in case of AMD
CPUs).

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 arch/x86/events/rapl.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index bfd8bbcc1421..7e9cb01f749a 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -116,6 +116,7 @@ struct rapl_pmu {
 struct rapl_pmus {
 	struct pmu		pmu;
 	unsigned int		nr_rapl_pmu;
+	unsigned int		cntr_mask;
 	struct rapl_pmu		*rapl_pmu[] __counted_by(nr_rapl_pmu);
 };
 
@@ -135,7 +136,6 @@ struct rapl_model {
  /* 1/2^hw_unit Joule */
 static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
 static struct rapl_pmus *rapl_pmus_pkg;
-static unsigned int rapl_pkg_cntr_mask;
 static u64 rapl_timer_ms;
 static struct rapl_model *rapl_model;
 
@@ -358,7 +358,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	bit = cfg - 1;
 
 	/* check event supported */
-	if (!(rapl_pkg_cntr_mask & (1 << bit)))
+	if (!(rapl_pmus_pkg->cntr_mask & (1 << bit)))
 		return -EINVAL;
 
 	/* unsupported modes and filters */
@@ -586,10 +586,10 @@ static void __init rapl_advertise(void)
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
@@ -812,9 +812,6 @@ static int __init rapl_pmu_init(void)
 
 	rapl_model = (struct rapl_model *) id->driver_data;
 
-	rapl_pkg_cntr_mask = perf_msr_probe(rapl_model->rapl_pkg_msrs, PERF_RAPL_PKG_EVENTS_MAX,
-					false, (void *) &rapl_model->pkg_events);
-
 	ret = rapl_check_hw_unit();
 	if (ret)
 		return ret;
@@ -823,6 +820,10 @@ static int __init rapl_pmu_init(void)
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

