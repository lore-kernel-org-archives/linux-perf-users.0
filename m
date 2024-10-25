Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4192918BC1C;
	Fri, 25 Oct 2024 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729854859; cv=fail; b=HiSl6S42EettBw7WnkD2TXnjLgZTCNOXWiTLYuNToT5M4H6g/WLUE+QpD1O6Y6XVaYXN2HOsSMtM2Rcrv28SAALQslHDMeBXmcLPgE279D8PFrsMYCk5lK284wQxlIx60BObAmt4w4s5fdKYTGfscdS36a77QyWzSEs7eHpUMB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729854859; c=relaxed/simple;
	bh=05lHbJkoGhub4QAGmRvCxFI9+VMnHnjqIVbkfcdAJ+s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=peYWFk+9Y8gAYWZLFSDFXWO8kkiFmPZKQbxGhC5aLq5gylFgLHlihkXRtruUevQf/qXAh52ZT/+YdTq1kbAV2oTb20HCW9235Nmcqk40tQ/Y7vc4qhXEn/ZEqwwFlO6UkCcwYnDhUBHjmZDJZLEMerut52NW2aKAyAcDY1UBHug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mqDhuK8W; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mqDhuK8W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xA7MXzrOTS+6/4QKRkdWJsnwW2v7JYywY2a5Fs3j/GZlO33Ub9VNGccmcrAj054jwxQTrX1rSw3GTygeLla7ThPXexoPfvpKrmlKtKBxfmrhwx7aBjBw2yyqgNhYB9d4FNmpOM32RLichqc3zJ+THPL0KcEW/+/KrZWG1Y9xdpIjncdJ/CEBJpJDYE4fILcaMuONjZdSk+WeFQIHWiKPAaZbNONpoDKf8U7CAiXDtk4mqVtPOpgydGP7+pXUY2s8+VeYjoQeKoRkJNjCt2YH2jUYcbTWY8vNz2pR+v3bH+gBH2awG2wVX0IK2yCiT+5AXsu8pLSCOGUo6FIFbpj7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQVqfhRTK4LpuFcBwlyBFir7QSjMDtCl6PM+bZimQJ4=;
 b=oBjIBZx52geAj50XV2SpIypfU48kt6PwARm/7qQx/fISZh5CcerGVAWp7puSnMLG/5LpexLg9KhkPG3nJsSlDNNDecTJck6ObkJZM6wpvZ2emyaFSMnjpfQbApujZUnT2/Io1D64nbXFPM4cb6jR1osx/pSMB1CO/udH0V0BIqV41J9xjyfOVhgqmPwh46/KX79II87JrJQRkwtdyQ3emgMDOk0xEb6NBLX6oPQCXNiCT844SAfH8lXS8SV+XAkIRmfiabVHS9Q6+xbIYwKquyAbtd//l/mN6mGIGNL0D08MwjoUkTqjj/6hJSUIxV4o0mDxcupI+jxhMQuX+4Tb+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQVqfhRTK4LpuFcBwlyBFir7QSjMDtCl6PM+bZimQJ4=;
 b=mqDhuK8WKot1SJ3XtkvIsY1gIkrZ4erxtFxSs640I5cKOHptzPpehAJf2+OmfhBQFLT8a4GGrMzxHgLcuVBY0tYvL0Rxl9HE+DjJgyNgcI+qJSi6hRISyAV405/YkvUtIw87EvbVnRF78zmEM+RMkofPF21qdQLn3W1gSy9a8u0=
Received: from MN2PR01CA0046.prod.exchangelabs.com (2603:10b6:208:23f::15) by
 MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Fri, 25 Oct
 2024 11:14:12 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::7f) by MN2PR01CA0046.outlook.office365.com
 (2603:10b6:208:23f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 11:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 11:14:11 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Oct
 2024 06:14:05 -0500
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
Subject: [PATCH v6 00/10] Add RAPL core energy counter support for AMD CPUs
Date: Fri, 25 Oct 2024 11:13:38 +0000
Message-ID: <20241025111348.3810-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|MW4PR12MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ed5e8c-839b-43cd-1d66-08dcf4e62760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Nfbz4iZWC0VBokFFTjHoyg6rTunJzq9BKayrAd/C7fKxDNs01WtVVtOqe8B?=
 =?us-ascii?Q?9PwPL++dLpHCOPZ5RZqS1pPnWC2Me09t6GKqW4yVPdEWQKu/x5NIL2SvdA8b?=
 =?us-ascii?Q?YSaU6EFQgj+d4pIKbgPdmqopULnmJe2N85ynKPP4aPJwuoci6cUaLvODgimx?=
 =?us-ascii?Q?wZOMVYUc5cIEyPaYUgUMC0fcanB4QQ7ONX1Fp11ip1xISiG5ukBPM7MHTCL6?=
 =?us-ascii?Q?O1xiParH2q+rolRIqarHQmgY6ABgbIM9wOlx0YxgIGol2P7kuSKvzjIqWlNn?=
 =?us-ascii?Q?fFH5L9vel6HGMLMpuBTRO91iAvPAaHBhCK7f3i9gLdsSdCzV0ML4rRBg0dM6?=
 =?us-ascii?Q?bsAis5la1Db6B96hZtcOrx9+ZNWS5Td3lNcpSpS2BfrjfSCEONj6yWbjEgm+?=
 =?us-ascii?Q?+GAiZt/W++MjKfr48j5ziqDYxcRKmTJQu+5ynzBVnDwdxHu+ZrmIL5zBkXy2?=
 =?us-ascii?Q?xMVpJJUiIjMt77BK5ur/rM1Z19Tu2jrmm+qrKy1PYgTXpDtBZ6TQ2mlCJOwQ?=
 =?us-ascii?Q?NloXwiT+C85Afca8rbEMXigVFHeP1XnAaVpxRh4w9DpJpO3MGmY0TeNBTFRG?=
 =?us-ascii?Q?IY44ivr19QkgX1h81pGvYRWs/NkcaN1rLaPbd6aXYEEpjXVFDhgJUSiI60Vl?=
 =?us-ascii?Q?0QG96BgAv0tDeEN2jcyNOHyakhpqionvFAW7oSzKu0NChfyflQKo37iCiBbI?=
 =?us-ascii?Q?mU8MmDq2iAOEZ/UkjIWb7Bd5zh6CC8TMiBoQftZsVRG69Uvl7VYoA6Zehc22?=
 =?us-ascii?Q?Lfhq7qz4MVIB72cePHmw6Yeiewugaq16kXgm29hScGoQ8JdGg/XN2kzhIaEB?=
 =?us-ascii?Q?Xl+ylHkB9+evABq5bTSt11Ybz7BTn3URoi7ONaCJNbojVUwDUVkHmAjBI8C/?=
 =?us-ascii?Q?pSkk8ozbYAHBDMT5aHJkhdZk043rPZwA8NonC7uaT8du6ESwMOn6robCQIxw?=
 =?us-ascii?Q?6wfbjCmwOmAE0MIxy6KnPXWou+JMjS3Y8OKRsFajf0wD9GewVC9c9uFNwi3Y?=
 =?us-ascii?Q?CmWky56240aykBmeKQH/gSWtBVKGaqTT1kSdXik0d27bKAMpvuQj485HEz2R?=
 =?us-ascii?Q?t+lLUtkJc8aDKhTuwRmnWxkviUr5lYX76LDIeNWFpM9a02d8F1wu7MFWjwUB?=
 =?us-ascii?Q?Ame74ELlAR/ELBeuU9OIVZVvHYwNeBcLwty7BhJnZGOIzLvsuLZ8Kqu3FsF+?=
 =?us-ascii?Q?21i6QqoPOejjXMkqUfXSRCUNc+PF4Sx04wV+FCFfjcX03d2YcmTfUc2h06D6?=
 =?us-ascii?Q?oCGwoYG5yIUm28CSg8YlcLXfriD0GSS/IMWJaqhKvE9wcru7qgXo5ws2HfMl?=
 =?us-ascii?Q?71ApFyyBNuQj54mikttVZy2jgvL7AX49AYXTQGdDDKY7tL02TSL27EU1S+1Z?=
 =?us-ascii?Q?g9tAd41p+watWy2EVy15wLCZpRZrH0d7fSdInnhi2afR7A3XZtlpVdSGxoDJ?=
 =?us-ascii?Q?kYJcQ+4MqUQ+5UeeS34cbEDlSJzeokoH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:14:11.9408
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ed5e8c-839b-43cd-1d66-08dcf4e62760
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216

Currently the energy-cores event in the power PMU aggregates energy
consumption data at a package level. On the other hand the core energy
RAPL counter in AMD CPUs has a core scope (which means the energy 
consumption is recorded separately for each core). Earlier efforts to add
the core event in the power PMU had failed [1], due to the difference in 
the scope of these two events. Hence, there is a need for a new core scope
PMU.

This patchset adds a new "power_core" PMU alongside the existing
"power" PMU, which will be responsible for collecting the new
"energy-core" event.

Tested the package level and core level PMU counters with workloads
pinned to different CPUs.

Results with workload pinned to CPU 4 in core 4 on an AMD Zen4 Genoa 
machine:

$ sudo perf stat --per-core -e power_core/energy-core/ -- taskset -c 4 stress-ng --matrix 1 --timeout 5s
stress-ng: info:  [21250] setting to a 5 second run per stressor
stress-ng: info:  [21250] dispatching hogs: 1 matrix
stress-ng: info:  [21250] successful run completed in 5.00s

 Performance counter stats for 'system wide':

S0-D0-C0              1               0.00 Joules power_core/energy-core/
S0-D0-C1              1               0.00 Joules power_core/energy-core/
S0-D0-C2              1               0.00 Joules power_core/energy-core/
S0-D0-C3              1               0.00 Joules power_core/energy-core/
S0-D0-C4              1               8.43 Joules power_core/energy-core/
S0-D0-C5              1               0.00 Joules power_core/energy-core/
S0-D0-C6              1               0.00 Joules power_core/energy-core/
S0-D0-C7              1               0.00 Joules power_core/energy-core/
S0-D1-C8              1               0.00 Joules power_core/energy-core/
S0-D1-C9              1               0.00 Joules power_core/energy-core/
S0-D1-C10             1               0.00 Joules power_core/energy-core/

v5 Link: https://lore.kernel.org/all/20240913152149.6317-1-Dhananjay.Ugwekar@amd.com/

v6 Changes:
* Rebase on top of V2 of Kan Liang's "PMU scope" patchset [2]
* Modify the PMU name from "power_per_core" to "power_core" and event name
  from "event_per_core" to "event_core"

Base: tip/master + [2]
 
[1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@linux.intel.com/
[2]: https://lore.kernel.org/all/20241010142604.770192-1-kan.liang@linux.intel.com/

Dhananjay Ugwekar (9):
  perf/x86/rapl: Remove the unused get_rapl_pmu_cpumask() function
  perf/x86/rapl: Remove the cpu_to_rapl_pmu() function
  perf/x86/rapl: Rename rapl_pmu variables
  perf/x86/rapl: Make rapl_model struct global
  perf/x86/rapl: Add arguments to the init and cleanup functions
  perf/x86/rapl: Modify the generic variable names to *_pkg*
  perf/x86/rapl: Remove the global variable rapl_msrs
  perf/x86/rapl: Move the cntr_mask to rapl_pmus struct
  perf/x86/rapl: Add core energy counter support for AMD CPUs

K Prateek Nayak (1):
  x86/topology: Introduce topology_logical_core_id()

 Documentation/arch/x86/topology.rst   |   4 +
 arch/x86/events/rapl.c                | 412 ++++++++++++++++----------
 arch/x86/include/asm/processor.h      |   1 +
 arch/x86/include/asm/topology.h       |   1 +
 arch/x86/kernel/cpu/debugfs.c         |   1 +
 arch/x86/kernel/cpu/topology_common.c |   1 +
 6 files changed, 268 insertions(+), 152 deletions(-)

-- 
2.34.1

