Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B5019D895;
	Thu,  5 Sep 2024 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550800; cv=fail; b=rF6ssP4xA9hg6rY6uXKyPlnNl4MO9Yc7VDk3Ql/K6tr/J/8azkYz5IqFowFBA5zex3v6KIQ/rCsgQ7f2BRnoMRp3wYmcI2nn5/Q+ghKjqBYa1cqRZz1CU05h9/Vvc+vmr74ZuG8lNmKxwAjKX9GHmt3xcniV45aMpGhYag1iypc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550800; c=relaxed/simple;
	bh=Rb829x9oQJFdv2OxT0QPNC/s12v70Qs9QhNXSq0R79o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZGMrNYbgN6A5dfYyoY6+MaDATnJtjhROVnHB0SciHzEuqlBa5QPIvAxebVEJQ3z3lcd+H5383H6746msSHqN6Rx29PcRZRHHMiXravh615snx1qadr5ZLrNS1vLsm0+eCkvzIgbx1QYOEbHI8kpBoYifqGaMu0IJQNf1GllVsLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OkqZSa8O; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OkqZSa8O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvkYi2z/m4+I50R5RbcN6rO6YJOBPsuZygJav7nKChvEmk66AQzvHMMe9ym8HVj4Qkn47uOOnAjqEUa5P20eWcSgw9iG0+7j3uniQjwKMLlwAoUYUDXzidkzCHaoG5l+pCe8p2U43uuPqOWPtm7TWwFR83nB0X2nfEYxrbR1XjpBKN2mE8FWEgVTVBnSIHj/reSrQFZ4gwP27lN9BTEWTVxQ6nFF857oPeyhzQ4bFBgWUR+l6u/VawZAROb8OIPgM3BIZNahMLfsM7xerzjiRZ8hJtgV/cSyKiIihOWL6l5fYFV4DpU4lnIOYJ8WYMPYUi6Jq1Yy5OuJIhMsQv7qOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iqIqbZGulQ/uZhRoL9Ek3wyo3CTBfhEY4Xms29MzRk=;
 b=abt8jkHBR/r1QRGguOpCNxthJ3Oq6iIkNyRSKqr+szuxpCRVzg7VY8yxZfef2n4ffPo7UWPIWqJctC8kSpgjMNohYU8XXjJVsn4fIcF7okVUKGslJxXXpSLKXPj8WcGwh/BOCtcr7usY2ZqpffjgvzAQ+gDe93dW0SOnQOjsAnUpgjdJ3Ytx1SfzMBBj5Qiz59I9waLcsEm/FIxpbGyDlMLqaU6WyX2DVA2LUviZZOQlB6kBNnczSQhXit82MuSeGlVhIGSAKYDNmQO7l7+he8NsGTms3fYNDP2ve2PgZuh3RRkdNKv2YRIhTGoIJeDad0+Pi49NnlBfVw0wDwpAgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iqIqbZGulQ/uZhRoL9Ek3wyo3CTBfhEY4Xms29MzRk=;
 b=OkqZSa8OIxtpLtn4qF6rcDmGKbFa5ltE1usSdTymfXjxTzdUBo1Wzlr5yW3z+6Nd82ijUhrVN3n9OWQt3gMmYGgDrAbjEYE5MjpWAUM/GXMoYcIiejDXZTVexzHdWyGw97UwgC9GzezpRUo4rIGq173uXvb0KwTJxm+44zLx0QY=
Received: from MW4PR03CA0279.namprd03.prod.outlook.com (2603:10b6:303:b5::14)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 15:39:52 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::32) by MW4PR03CA0279.outlook.office365.com
 (2603:10b6:303:b5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 15:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 15:39:52 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 10:39:45 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<tglx@linutronix.de>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>
CC: <gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v4] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
Date: Thu, 5 Sep 2024 15:38:22 +0000
Message-ID: <20240905153821.3822-1-Dhananjay.Ugwekar@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 0037439a-752a-45f6-cf78-08dccdc0fbfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qJQ/70a3GB6imH1k09JuHA3kXnlzKCoD/8hG69QLu991MQ2OisNu/OV6cbCX?=
 =?us-ascii?Q?yRTNttpBqTH1WlX/ihYBVOTmVgUFB1DCjz2sTFgs/JCALO0VD8U969QqnK3B?=
 =?us-ascii?Q?qPr/0hn7nfs62/xRbrPZw9DqF3f/hKAsi8zN8sOqcJEotNr5HoHlRSgtVZ4Y?=
 =?us-ascii?Q?fJG722yZfFa6vK5/S8m+oNHsq/jbqrqdu/HSSpCdG6Xdrkkbq4og5BrWbZiU?=
 =?us-ascii?Q?Nu315q0GnM5JeoskmL5SN6uMHHFQ5hNQ25GCK0ONkQzM8xtOQWhX3aUcn5Ux?=
 =?us-ascii?Q?Q//lMq3+58aQ9NuUBxEpiFuQHIikiCamz3mK4rrXfS9yt28XNvT2a9HKsFh9?=
 =?us-ascii?Q?97dcpvDMP2QwchoZ6CoeneAxHNwlPkCrwuYq9CpsWreAVnc7sy536cg4cvfi?=
 =?us-ascii?Q?0/8d8u5Mwe45I9DDDy7m9hQAOFQExXQU8iS7BEfe57eq8Fx50pWk6/p9oarU?=
 =?us-ascii?Q?gyh8opTgdDLl6xmXnUNPs9Xxaa3B/uIuGiKC85lRKXY1m2zeQRzB2gCUKwDo?=
 =?us-ascii?Q?vgNwPxM8YI7r4uX4uIc7mCKGx21bsu9B6borKjxKVDnuTtsCB5sdVhSvnbqY?=
 =?us-ascii?Q?e2HscJmjGS9LCIpuoLF3o3fqkulPHHR8rkfCmVEMOZld+qR8IA6bRD3xCKm/?=
 =?us-ascii?Q?g3+yg/1ZzMIkfYhdV/c2u9gRgUHwii1DD6+a7DazzdFzjxRG7LlR2FnRO3/r?=
 =?us-ascii?Q?YB2am/l3Vnn1pPAhawtHtcxFzvJ43FK2/8nmfjWSPWOr+tx3kRcIPREQwg2F?=
 =?us-ascii?Q?mbsmRqpPn1HeN7BPc6cGAU4zSekXOjNdPBLIGVXW+2v2OxaW3xqw+IpbaIuL?=
 =?us-ascii?Q?0qNXzCPbOo2iJwZJQqk3CNY7xBjnHYQWqeaR2nVKZNB+ZjUCQYG2mvz2Rnir?=
 =?us-ascii?Q?TjtbNVeBWX7g6h3NgeE3WufIeOA0ItBEyG7QwzOKlfTGbQjKZRikYQY9TSB9?=
 =?us-ascii?Q?1PX96G88xCqJY3hjGULGBuwswGUg8rG8ZWOoP46VsYM4rwrI6u0rMaX2ng14?=
 =?us-ascii?Q?sdxuKM9KaSxdSjo5DLPUSMDPLRCDi9d3EdrDBCnv3MR6pkxh+Vf4eIPD/oec?=
 =?us-ascii?Q?fQKNuxPQ0TtAYnOWhEmQE8Trr5ulmtMdqz6B9qSnqhHZaVqmzY+fbjucKZ/P?=
 =?us-ascii?Q?VyzfdmroQzqOD53fYgIm+28cuY9oU1g7qqduwIiTBeBx2DVDUlKIBorJGBZF?=
 =?us-ascii?Q?SFhkzCIrRxfSbsT/TCiG6/vbJbaOAX23d9c29qxzAOkmcfGuJetYHtq/BRqb?=
 =?us-ascii?Q?efWhpAj4LMRYXV5D5I0lQFOv7tje2m06c/s6TQyIveDe4Dwzbq4Y8xkcmKhI?=
 =?us-ascii?Q?nR3jUXtP23c5R+q0DBsGXMhq8FMjOfgfIIbUV1gyN2WxzppWNYQrXBjdxB4J?=
 =?us-ascii?Q?c8+5K6a+CwBl+Oj+Oax9O8jiWNelgt5TTz3dp/VpQUgoKl2gxbMy99TX5g92?=
 =?us-ascii?Q?PLTIiGAkCsLTiuJ6j3u3dmTZPTILgKC5wM94bCgjqe7El0rw9B/uLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:39:52.3204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0037439a-752a-45f6-cf78-08dccdc0fbfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573

After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
on AMD processors that support extended CPUID leaf 0x80000026, the
topology_die_cpumask() and topology_logical_die_id() macros, no longer
return the package cpumask and package id, instead they return the CCD
(Core Complex Die) mask and id respectively. This leads to the energy-pkg
event scope to be modified to CCD instead of package.

So, change the PMU scope for AMD and Hygon back to package.

On a 12 CCD 1 Package AMD Zen4 Genoa machine:

Before:
$ cat /sys/devices/power/cpumask
0,8,16,24,32,40,48,56,64,72,80,88.

The expected cpumask here is supposed to be just "0", as it is a package
scope event, only one CPU will be collecting the event for all the CPUs in
the package.

After:
$ cat /sys/devices/power/cpumask
0

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
v3 Link: https://lore.kernel.org/all/20240904100934.3260-1-Dhananjay.Ugwekar@amd.com/

Changes from v3:
* Move the rapl_pmu_is_pkg_scope() check before the memory allocation for rapl_pmus

tip/master + PMU scope patchset [1] to be taken as base for testing this patch. 

[1]: https://lore.kernel.org/all/20240802151643.1691631-1-kan.liang@linux.intel.com/
---
 arch/x86/events/rapl.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index b70ad880c5bc..b13db61fc256 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -139,9 +139,32 @@ static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
 
+/*
+ * RAPL Package energy counter scope:
+ * 1. AMD/HYGON platforms have a per-PKG package energy counter
+ * 2. For Intel platforms
+ *	2.1. CLX-AP is multi-die and its RAPL MSRs are die-scope
+ *	2.2. Other Intel platforms are single die systems so the scope can be
+ *	     considered as either pkg-scope or die-scope, and we are considering
+ *	     them as die-scope.
+ */
+#define rapl_pmu_is_pkg_scope()				\
+	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
+	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+
+/*
+ * Helper function to get the correct topology id according to the
+ * RAPL PMU scope.
+ */
+static inline unsigned int get_rapl_pmu_idx(int cpu)
+{
+	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
+					 topology_logical_die_id(cpu);
+}
+
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
-	unsigned int rapl_pmu_idx = topology_logical_die_id(cpu);
+	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
 
 	/*
 	 * The unsigned check also catches the '-1' return value for non
@@ -617,7 +640,7 @@ static void __init init_rapl_pmu(void)
 		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
 		rapl_hrtimer_init(pmu);
 
-		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
+		rapl_pmus->pmus[get_rapl_pmu_idx(cpu)] = pmu;
 	}
 
 	cpus_read_unlock();
@@ -626,6 +649,12 @@ static void __init init_rapl_pmu(void)
 static int __init init_rapl_pmus(void)
 {
 	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
+	int rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
+
+	if (rapl_pmu_is_pkg_scope()) {
+		nr_rapl_pmu		= topology_max_packages();
+		rapl_pmu_scope		= PERF_PMU_SCOPE_PKG;
+	}
 
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
@@ -643,9 +672,10 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.start		= rapl_pmu_event_start;
 	rapl_pmus->pmu.stop		= rapl_pmu_event_stop;
 	rapl_pmus->pmu.read		= rapl_pmu_event_read;
+	rapl_pmus->pmu.scope		= rapl_pmu_scope;
 	rapl_pmus->pmu.module		= THIS_MODULE;
-	rapl_pmus->pmu.scope		= PERF_PMU_SCOPE_DIE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
+
 	return 0;
 }
 
-- 
2.34.1

