Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBB4221FBD;
	Thu, 29 May 2025 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748522130; cv=fail; b=aacwrd/tKFUmqTZBKqL2cJ9ZyyxZOSQ70n33TyXZpiVAwbMYUwktedXtejcJ6lYqDQ6X0rGo5Ck54fV0CXTUziknmyZ8ijAIzWVHp/9B4AL6juf082Y/lSZBOYdvcD7vxs5py6g4ZJTeqR7fcd1VVpSXSirRR0+vFgm5BSJuirw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748522130; c=relaxed/simple;
	bh=CDEwa6S6Yy9Dx21xHWoufb/SD4PFv2OVICg5VzjDm/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqmjsmgDR26sOyjiDFfbcBHAYISL9kbaOEnGyiZIgK2JYRSHlLe4Apw4F8PTWL8auiMuAFziinGg9WwDP7xmhrIEzBZ42iCclJvSmppwoRArBC87UVnIl9dDRuOWW908tFzYKpopWPqPeFPP3K1ovn3Z504nNtW3ZGiMm0knrsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OvZ9NsvZ; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OvZ9NsvZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZsbkUT/Rc7MAJeJZS4ImOoGSYCA8TunCX6JEkdwPmINNeRs3TaX3z43G/hdbtvvdsj//auFWoYSD034jh379NRngxlxQwsRuCHNGjLaVRdj/Ailjiwc2PfZW7pEdXcYdJoN1vHlzqQVpSS00SNs7MWyNcvzAyvnTXCqejOFEb2jzSICMNZtq/MsqTF05fAoYqA3lPlsUjMVWilV6LIojv4V0JQseUI2TOFR8etITKhtEw3M3ZfadQWA0mW/aYi1BRxQs06ftD24Ou5/dMQi6txXHltRuFJzvjLMsyhDpSteHdz72TlEL50g5JMHOxR2b/LZnh6WJOY2WL2b8IZCqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsBI23w5tcmycbwOoEAg1O1LjHvswzN2cb8YHXf3Qc0=;
 b=uvHEfF2dwaRvMLab+vAEKfgiOjjGOcsfkjseDl+xRpgLM6ahVTnxoUlKHjHy391Ci5jYo5suCMfFqoxrnY85Utpr0wUDYkYRX36E/OW7AA+49vnqWtspnINIucg0ToV1zOCf42razI1gCOJf2Bb81kcEbjCUrRdpx62yDD3PYubGZw6XHPAqvhuns3IJ+L6O7I8qY2OwulNSmiuzkafnh/5zgvLfFOKVNHzoZaA3QvtUsOW1387qZFiyS4VMg+8ncxrbkddNlOLjRwUhW83z/Q+LYE26+R8Z0Hw3GvjxhjGBazDX3jPlO9bqfpGQTHyh4ogwaJcXlKhpx6wHUDDm0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsBI23w5tcmycbwOoEAg1O1LjHvswzN2cb8YHXf3Qc0=;
 b=OvZ9NsvZw3wLqDVXtJL6hVH1KDUnpSYwzHIHTGwz5D+1bX4XxYH5Hsqpo13LfneVvsPLN3NXWeS8buL0X6nPWPf1uD0WofCsDDV2F+sYMjlu1iBUAbbDYq2+oNqeZkPPJLLKkhV3Sm6V6AS480X3YuL91LE0i+ZIZO/835KZv9c=
Received: from MW4PR03CA0133.namprd03.prod.outlook.com (2603:10b6:303:8c::18)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 29 May
 2025 12:35:26 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::4e) by MW4PR03CA0133.outlook.office365.com
 (2603:10b6:303:8c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 29 May 2025 12:35:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 12:35:25 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 07:35:20 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Ingo Molnar <mingo@redhat.com>,
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, "Kan
 Liang" <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>,
	"Leo Yan" <leo.yan@arm.com>, Joe Mario <jmario@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, "Santosh
 Shukla" <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 2/4] perf mem/c2c amd: Wire IBS OP PMU load/store SW filter
Date: Thu, 29 May 2025 12:34:54 +0000
Message-ID: <20250529123456.1801-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250529123456.1801-1-ravi.bangoria@amd.com>
References: <20250529123456.1801-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|MN2PR12MB4424:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d5ea6b-c451-4be7-9902-08dd9ead4980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+qGY7q4Ol31UN3zbgx2C945QMiz08qri6yuHTuGeRQp1T7b3LKYJqpXOYJWr?=
 =?us-ascii?Q?lSQIFDuYYNPz7TfHEyzMxu0KnInWYiWI1jeN0o8KYL5tAg/RpeRR2vGTpSvn?=
 =?us-ascii?Q?T2puWVyCseyEmrdlutao785NYL9P3+1JMk4zn50JOlg73Cfa1uj0mdSxpFt4?=
 =?us-ascii?Q?mw88YZdaA+vRHD6CyOU2tCWVpnhZCCdQE2JrMCuWiLi4XUFrnNK2CYt7A8fH?=
 =?us-ascii?Q?gyxhhA9PdsK7FDwtOkNdkYEaHmXIZRhXkfbr/SkEYWzIzleb77AKFiCct/dh?=
 =?us-ascii?Q?SAXi99fMW/wxfHI1FORWADNAjQq04xzaAqxxej6YhPJ48SPDrS2zcM71X/4L?=
 =?us-ascii?Q?yTiKNeIII5UlZZaF/z2gugcuF+VHt8wmvTRkSDrciTXn4UVe6sdEjS7M4Hc5?=
 =?us-ascii?Q?sVqomZ30S1i90BtqK61odRqRR3x12xAo/AAUFmhctdDGgkGwkPUgng/q38OA?=
 =?us-ascii?Q?oyh8MWhlA9FeiDeQliZkdGZO2R2dv83Uu8yVrlae/y5EwG/dqmvIZRQ8Q3xK?=
 =?us-ascii?Q?I0XwXd3ToN+58l+Z2gpeAL8lMvO9l3AbilmydeKXvY4X8Pk65EMuURuMG0Lc?=
 =?us-ascii?Q?Oltu2m2NfIiBg1M65hgfGhDWsyLanpIf9draJSUSvEZUgvnC5tHNw9oOX1h3?=
 =?us-ascii?Q?uCy72DXjAGOgKtrKVqLOt9Meju3EgPZytDkraGIiVZxzjYpDua3gQe0kMo5T?=
 =?us-ascii?Q?sXAUl4hLWtlLY5HSQQRipKu58IYNX4Nx7hG6AdDV/p3eM1LSHcXHczu9BSEa?=
 =?us-ascii?Q?H19xS+zQunSwWb7S6uKTGydHcNOlDZTdcG8TtKaShp5aqwMIOm5+ro6FI0G5?=
 =?us-ascii?Q?GNgg1ypqwjtM3RIW07EN5Inmdi+BNoZ69EIr95tS9lRkaC5VU5w2EixqULA8?=
 =?us-ascii?Q?NYlts/+SwLn/suM89zGZn+sWkiP9QfqQkQCUtc7xMx8JHEP8ixF9sbPb3n7m?=
 =?us-ascii?Q?xEeOccf+LE4Pk+Baa+LoV1a9Co21nFYZqfTia9kQ83zPp+6L/YBzB+0O0bT8?=
 =?us-ascii?Q?4U0eDyg5BD90+Dy46KvVtgwySp2arAqtGg7J129gukVrwXDudOYTcsu7SWam?=
 =?us-ascii?Q?ANyhogzNVzynMUkXmscTQxMdKNQifUVzbfzanMeusQAfJj3n5ZFRv9VS5t8/?=
 =?us-ascii?Q?MjSxfkduz//sYJbkXtyxBhV+x7WDPmFwM23vBKQ9Zpinbt876hdjeyGZXbYd?=
 =?us-ascii?Q?feKEsfuStj5U+agppywNEuhxUmIIPC4cZnFDV+bem+jYBhqVlYOuzpzau9m9?=
 =?us-ascii?Q?72mRrl9rWXlBEpvKsxKqp/62NG0GcTQgYEvb5JQW4VBUVxlFCxHNkGMt90Ki?=
 =?us-ascii?Q?qHDTLkd7K4fpNk+H6ec5LWpTGyTzI5yc+Ead1sNisMa8isnfNXBjTpDX+L7L?=
 =?us-ascii?Q?GUPRaF4bM/EnMej4sBuKiuwi9XPHr9kQEWw0wXlg3IMgbiVKaeSVlil0zKja?=
 =?us-ascii?Q?YJlz4Z67ZbgeMH9dSFC/Y4TUGKeeph7kJXxORBT0rX4+eMWDoqEeOhyCZo+H?=
 =?us-ascii?Q?Ejveszi3E0WpqxJ2YgdL08P/ZydLNKeX5voR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 12:35:25.4915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d5ea6b-c451-4be7-9902-08dd9ead4980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424

Currently, perf mem/c2c tools on AMD records ibs_op// pmu event, which
has no inherent load/store filtering capability. But with the addition
of a SW based load/store filtering capability in IBS OP PMU, perf mem/
c2c tools can now record load-only, store-only and load-store-only
events. Wire them accordingly.

Before:
  $ perf mem record -v -e list
  mem-ldst     ibs_op//          : available

After:
  $ perf mem record -v -e list
  mem-load     ibs_op/swfilt=1,ldop=1/  : available
  mem-store    ibs_op/swfilt=1,stop=1/  : available
  mem-ldst     ibs_op/swfilt=1,ldop=1,stop=1/: available

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/arch/x86/util/mem-events.c      | 12 ++++++++++
 tools/perf/arch/x86/util/mem-events.h      |  2 ++
 tools/perf/arch/x86/util/pmu.c             | 17 +++++++++-----
 tools/perf/tests/shell/test_data_symbol.sh | 26 +++++++++++++---------
 tools/perf/util/mem-events.c               |  2 +-
 5 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index b38f519020ff..0a034317b55c 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -32,3 +32,15 @@ struct perf_mem_event perf_mem_events_amd_ldlat[PERF_MEM_EVENTS__MAX] = {
 	E(NULL,		NULL,		NULL,	false,	0),
 	E("mem-ldst",	"%s/ldlat=%u/",	NULL,	true,	0),
 };
+
+struct perf_mem_event perf_mem_events_amd_swfilt[PERF_MEM_EVENTS__MAX] = {
+	E("mem-load",	"%s/swfilt=1,ldop=1/",		NULL,	false,	0),
+	E("mem-store",	"%s/swfilt=1,stop=1/",		NULL,	false,	0),
+	E("mem-ldst",	"%s/swfilt=1,ldop=1,stop=1/",	NULL,	false,	0),
+};
+
+struct perf_mem_event perf_mem_events_amd_ldlat_swfilt[PERF_MEM_EVENTS__MAX] = {
+	E("mem-load",	"%s/ldlat=%u,swfilt=1,ldop=1/",		NULL,	true,	0),
+	E("mem-store",	"%s/swfilt=1,stop=1/",			NULL,	false,	0),
+	E("mem-ldst",	"%s/ldlat=%u,swfilt=1,ldop=1,stop=1/",	NULL,	true,	0),
+};
diff --git a/tools/perf/arch/x86/util/mem-events.h b/tools/perf/arch/x86/util/mem-events.h
index 11e09a256f5b..bde1e51f639c 100644
--- a/tools/perf/arch/x86/util/mem-events.h
+++ b/tools/perf/arch/x86/util/mem-events.h
@@ -7,5 +7,7 @@ extern struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX];
 
 extern struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX];
 extern struct perf_mem_event perf_mem_events_amd_ldlat[PERF_MEM_EVENTS__MAX];
+extern struct perf_mem_event perf_mem_events_amd_swfilt[PERF_MEM_EVENTS__MAX];
+extern struct perf_mem_event perf_mem_events_amd_ldlat_swfilt[PERF_MEM_EVENTS__MAX];
 
 #endif /* _X86_MEM_EVENTS_H */
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 58113482654b..34f25ec9cca6 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -271,7 +271,7 @@ static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool
 
 void perf_pmu__arch_init(struct perf_pmu *pmu)
 {
-	struct perf_pmu_caps *ldlat_cap;
+	struct perf_pmu_caps *ldlat_cap, *swfilt_ldst_cap;
 
 #ifdef HAVE_AUXTRACE_SUPPORT
 	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
@@ -295,11 +295,18 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
 			return;
 
 		ldlat_cap = perf_pmu__get_cap(pmu, "ldlat");
-		if (!ldlat_cap || strcmp(ldlat_cap->value, "1"))
-			return;
+		swfilt_ldst_cap = perf_pmu__get_cap(pmu, "swfilt_ldst");
+
+		if (ldlat_cap && !strcmp(ldlat_cap->value, "1")) {
+			perf_mem_events__loads_ldlat = 0;
 
-		perf_mem_events__loads_ldlat = 0;
-		pmu->mem_events = perf_mem_events_amd_ldlat;
+			if (swfilt_ldst_cap && !strcmp(swfilt_ldst_cap->value, "1"))
+				pmu->mem_events = perf_mem_events_amd_ldlat_swfilt;
+			else
+				pmu->mem_events = perf_mem_events_amd_ldlat;
+		} else if (swfilt_ldst_cap && !strcmp(swfilt_ldst_cap->value, "1")) {
+			pmu->mem_events = perf_mem_events_amd_swfilt;
+		}
 	} else {
 		if (pmu->is_core) {
 			if (perf_pmu__have_event(pmu, "mem-loads-aux"))
diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
index d61b5659a46d..e2156c9a4bc9 100755
--- a/tools/perf/tests/shell/test_data_symbol.sh
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -57,7 +57,7 @@ echo "Recording workload..."
 is_amd=$(grep -E -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo)
 if (($is_amd >= 1)); then
 	mem_events="$(perf mem record -v -e list 2>&1)"
-	if ! [[ "$mem_events" =~ ^mem\-ldst.*ibs_op/(.*)/.*available ]]; then
+	if ! [[ "$mem_events" =~ mem\-ldst.*ibs_op/(.*)/.*available ]]; then
 		echo "ERROR: mem-ldst event is not matching"
 		exit 1
 	fi
@@ -65,18 +65,22 @@ if (($is_amd >= 1)); then
 	# --ldlat on AMD:
 	# o Zen4 and earlier uarch does not support ldlat
 	# o Even on supported platforms, it's disabled (--ldlat=0) by default.
-	ldlat=${BASH_REMATCH[1]}
-	if [[ -n $ldlat ]]; then
-		if ! [[ "$ldlat" =~ ldlat=0 ]]; then
-			echo "ERROR: ldlat not initialized to 0?"
-			exit 1
+	format=${BASH_REMATCH[1]}
+	if [[ $format =~ ldlat=(\d*) ]]; then
+		ldlat=${BASH_REMATCH[1]}
+		if [[ -n $ldlat ]]; then
+			if ! [[ "$ldlat" =~ ldlat=0 ]]; then
+				echo "ERROR: ldlat not initialized to 0?"
+				exit 1
+			fi
+
+			mem_events="$(perf mem record -v --ldlat=150 -e list 2>&1)"
+			if ! [[ "$mem_events" =~ ^mem-ldst.*ibs_op/ldlat=150/.*available ]]; then
+				echo "ERROR: --ldlat not honored?"
+				exit 1
+			fi
 		fi
 
-		mem_events="$(perf mem record -v --ldlat=150 -e list 2>&1)"
-		if ! [[ "$mem_events" =~ ^mem-ldst.*ibs_op/ldlat=150/.*available ]]; then
-			echo "ERROR: --ldlat not honored?"
-			exit 1
-		fi
 	fi
 
 	# perf mem/c2c internally uses IBS PMU on AMD CPU which doesn't
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 80b3069427bc..24afdd12bed2 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -93,7 +93,7 @@ static const char *perf_pmu__mem_events_name(struct perf_pmu *pmu, int i,
 	if (i == PERF_MEM_EVENTS__LOAD || i == PERF_MEM_EVENTS__LOAD_STORE) {
 		if (e->ldlat) {
 			if (!e->aux_event) {
-				/* ARM and Most of Intel */
+				/* ARM, AMD and Most of Intel */
 				scnprintf(buf, buf_size,
 					  e->name, pmu->name,
 					  perf_mem_events__loads_ldlat);
-- 
2.43.0

