Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0491547E0;
	Wed,  4 Sep 2024 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444676; cv=fail; b=ku4Xq9pomtg4fbOMHUf67pvEQQnsjnjFtiRa92Cr/ryu/wINSEDaQnp8EnCKvlqlY7ATEcT7CLwKZBWxSS7aN/W1gwb1qEiALnrqRc7v81aPHWToUEU4wWiTMfpIO6MFrhHceAv2CUELM+VherY8dcsom2x9f9rMQadwcWlxovY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444676; c=relaxed/simple;
	bh=jzVhRBEHa/tSZ9iJgs6TlRoUtCynLYezo4OWX+AXGfE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uw+lScs9TAMn8jA+8oHj5yCg913uVaab8XYMgWWyDUD/tFuAdyzYUAMVF4hA88ce3T2HEz5CeEx5spQegVfVw5ohTfIuF69Mu+0/I0XeErvXk6BQL38AqEDWfMm8BbgBzkJ1Jv8/Rp2pRcmc+3CEUVDLsUoee+FpjMiQAwvb/MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lZnH8Zbj; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lZnH8Zbj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SazLf7UtmAYVMS9hg06APACTv0tA/jIjZSeTq73t5i82iv+w6q3mcsvfx4DgkS+WygYgJ+xX+/E+liq07lIRBTDctbXBy50kHFBJsoLWQ17DJWrUxG85en9f9OdN1Ne4IMnV0or2QCMhK7LE0PrHza2lm3xf0byLpHK+rl8BwCQVT97KVYnIP4tfacMogybBYIqUrOEqSAjUzxIFbbHD5oTGOYLCNMxFoaJQEXMxKDkH77qiE25uwHgv39n3YDV/HDvfd7RNcajCd3EhgVLdHwlWB1wbZzucWX9RANwC8pDUclQczWmilMZ+/wF0I8hKm8mYewcvxmLePN0VKuqZaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3+KbocuzLw1rLNArlL567qL7mSuPM+1jfeOTdLJZZU=;
 b=uOA5dwzl53ePGFj7qtpGcxHNoju9PQvWu0G/ROwDnd+rb/vogvClQ8PZBhSEajIk08ICAlL+fjagrf3agrLNhHEYWDeMUkjh/i87T0N8+nMYyQVa2VJRAWH0I1f3UtlX21cbDrIRmjZF9e4+Yhc4aqoFcgArSXJWGX6DJBArHQ63Ki/v2UUVomzX8rUlvxhDblDcT3FIaAbb8DoVsoPry9Q7lBHfV8OvFEoaiekhnyPlEbiIlI1ga3BA3GZTNe39IGFpa2wjfkboUo2KolSN/jJJzLngIYf62ScjxxQmmabHisA/NSiy3nZhZgzNx0UQTOP6GkhUvRf5gdFu7cb7bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3+KbocuzLw1rLNArlL567qL7mSuPM+1jfeOTdLJZZU=;
 b=lZnH8ZbjqzeMSOYoNc+17ZzvwMv44Qcz1PCaexV7vGaLxqC8RhEua4I5IIf9NRvYIJU6QAG2oGpsXGAmbUnUK0K+weFVQiEmuYDqd2emrdaXwXsOjAQAfs+qPGMP+t102H3nFXP6r2hEKcB5INeNALPsDmrPJmpu0q32JLABC8Q=
Received: from SA1PR04CA0019.namprd04.prod.outlook.com (2603:10b6:806:2ce::26)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 10:11:12 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::fd) by SA1PR04CA0019.outlook.office365.com
 (2603:10b6:806:2ce::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 10:11:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 10:11:11 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 05:11:05 -0500
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
Subject: [PATCH v3] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
Date: Wed, 4 Sep 2024 10:09:35 +0000
Message-ID: <20240904100934.3260-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 27ae8d96-c00f-4dac-41eb-08dcccc9e741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BapVGQrjwe1XmZK461mF/6YKPMX7Ij/bM92tKMHdbFSD0uQl8uPMq33MU1o3?=
 =?us-ascii?Q?FJE+DeopqeWd9J/Bnh42Lsks831iQwlSBo/Q6dHQYUUtaOZjR5tkBkhK1Nf5?=
 =?us-ascii?Q?CR9i5cZKa0YFzZzyGApNIo9MV354MTuQZ4a2yE8AFD8XcndQiNooLWCp2lKY?=
 =?us-ascii?Q?LaoI+UvHSo3qgZFo66tg1k/x0vGFGkFasesfFWjJ3xSfL48+Hry1qpz77hhH?=
 =?us-ascii?Q?e6tjS9JZ3TG2iz4DVjhOTNYoS3+5DWzqsPaYLTxwhocJradSygU4B1lpW3Rb?=
 =?us-ascii?Q?lvP5Be2aESNp03i7jf92Ip+85RuYGxvRIP0y+mqONPvfcz+QhMUtyX5+goXg?=
 =?us-ascii?Q?W/WvyAy5ZHhmhPw1TiYZTQyplwCymHkHw7vIcGmYdBb1bJTIA8PvEd115VU0?=
 =?us-ascii?Q?Qcwo5xeQsfNkkfmiVkeJny52aMW31Oq/gZa8OmO81leXuZSW2U1sz6OJIR7X?=
 =?us-ascii?Q?yjrnQlS2UxxclNsIo3kI/zd8P2IgL2WfoA5/vWbAGxritqNfGK0JNSy/wb2W?=
 =?us-ascii?Q?epjdIFXzRvw2NGpNIk/iPhJnOYqNrKnsGOK69HaiyfOJSdsHrU+4Ef36+5lO?=
 =?us-ascii?Q?XFiyTh5dAAicSvC9rokQ+SNoF3QJwi1TuZHU26wYdWGDAH/3+NlKehspzAzj?=
 =?us-ascii?Q?XS2FwC1xBZSRKQm0OwZy89vAnZOH7n0nC4Ol5v9rL/0R0NK1RzpvY7JhQYxZ?=
 =?us-ascii?Q?WOOiUX+/DjqvJTLJ1F5PKtFwbixFlq1RoCfM21aTnr0+pQI60du2XKpkDaCU?=
 =?us-ascii?Q?fsVT3VN3fTg2Cz8j40BMYyt+ufy44QN8R17b1NxKmZ4tS6P19BrkNzSuDDMi?=
 =?us-ascii?Q?TXEq+35NAVfN8hWmlswWnHpqm5viIEzUONhjrjp4o4erOmbNz/ozmeeyL3GB?=
 =?us-ascii?Q?y2q0mMp468rUXDChRUDYWxNy+pybBNMsqCHqMBz9zesTIB0PzOQwsBE9m9uP?=
 =?us-ascii?Q?9JIUIa/W2gvUw0dph/GutaaLqI83pcAVKpk3vLmIslhpbBNSgnXPWdGbyIyf?=
 =?us-ascii?Q?/mBlmERJ1JLLvAt/+CeqEJZdRh+HFgufpFvi6t1ogiL1Pm4+v4Tk+4zW03jF?=
 =?us-ascii?Q?yiQz0ICs0tCJeTHmauFxIepw2fe+bmTtH8zPW1vV1fgRUZ0NIikXXAjThjjO?=
 =?us-ascii?Q?w08+kwlEhZj8QuA8TmNxgfSj+ta+TJsMpQTlQtvOYIPwnEfhXSoG0tP0i5kD?=
 =?us-ascii?Q?WPg3LNA1rl9PQgWTSSV0yWEfgUlPGj3zO95hSN3GRkEZ/UrRJ6SFhLvIZ6ZB?=
 =?us-ascii?Q?DjKdWFeTMWSJDGuoAeuqn/mH+lB6GIQ02QF4HGdWlbNXH9USH4O5OdE9F1OS?=
 =?us-ascii?Q?Fp1H1Qn5lVwparfxOSj5AE5YU/g3jZKliOD5IFmSj6vzjRJjEvyyU4yhMry/?=
 =?us-ascii?Q?EYsI4WiamgAIEMP+KSIcCRqYmTF/UXpXUjQR5lyYRvtKHmvEBkvOb2laDRrF?=
 =?us-ascii?Q?iRyRG8T0AW68LF9Quo2DGq0eYDr6SV1wD58pL0+M9IViX8npzQLM4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 10:11:11.9292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27ae8d96-c00f-4dac-41eb-08dcccc9e741
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892

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
v2 Link: https://lore.kernel.org/all/20240730044917.4680-2-Dhananjay.Ugwekar@amd.com/

Changes from v2:
* Rebase on top of kan.liang's PMU scope patchset [1]
* Set pmu.scope variable to package for AMD/Hygon CPUs

tip/master + PMU scope patchset [1] to be taken as base for testing this patch. 

[1]: https://lore.kernel.org/all/20240802151643.1691631-1-kan.liang@linux.intel.com/
---
 arch/x86/events/rapl.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index b70ad880c5bc..0c57dd5aa767 100644
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
@@ -646,6 +669,12 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.module		= THIS_MODULE;
 	rapl_pmus->pmu.scope		= PERF_PMU_SCOPE_DIE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
+
+	if (rapl_pmu_is_pkg_scope()) {
+		rapl_pmus->nr_rapl_pmu	= topology_max_packages();
+		rapl_pmus->pmu.scope	= PERF_PMU_SCOPE_PKG;
+	}
+
 	return 0;
 }
 
-- 
2.34.1

