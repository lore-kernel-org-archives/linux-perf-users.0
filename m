Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA61BA33;
	Fri, 13 Sep 2024 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240935; cv=fail; b=sVNL0F23Za1e/nKADlwUr1T5j3QSaLaL5O5TUXgdPSl72qHYEveea6x7ZFj3O1YNgWTNkACgwgeVrCeNv0qCcvID9bid5LZXv3P0scp8Idk6CeMtyDSqVv/xAcL2fa/b9qychH2j6gmjJwTUsWiiDG2pm+q9f+m3tXa6Hfe7zo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240935; c=relaxed/simple;
	bh=gvJwWaH6IOwq95XLGAdiEiZCRXTXEosek/fO1BngySc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g8o3yjJiYh1FznaqVOjoLM3XMMO/koOXpYFuFHbBlIvbwPnUB7N7MkN44lUwX9puz/8diENHxdkSH0Q3ilIqMouVYx3+wN8sxaCnGFlK1J4PPo9BlpU7bGZ9QVsj9BQC+1gia+VvHgP7NkgqmKhjKgIfWUoy96kPAi4z//qvsw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IgUY9bs7; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IgUY9bs7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McwHZR2n88aIZFUuO5tHjkmO/9J0REtvEHMW+hS9r0QGiCopAOmiJbn4UyAMJzhoHZkyrYDS/LrMwW42MmStx8/iXlwgweVv75pgriLMqZYS61dSz9zl98XBaq6oucovTMPYEpuDZaiaAVM0fWSLF1t7242dT9odBPfRXXFr0kKLqaqlU+Hg5BNHHqSpWU0KG2Oq6NRFD+9oX3QPXJ4w1vZ62QJHD8IgS62bgodI8EBwqEb61Si8YDCfa7UNeoTCGev7BRBJqDNvjt+LS9HJ9tjkuBTBBHjKVPx/i2z26q+4YMxZz4WPibrJhAc9yi+Ey84BaKnDm6Q8OtVfnKdDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibNeJYq6YS6TxuhmPlmtNtQkPhqrjlNLkjDDDH2CiTg=;
 b=pKd/mk6vxy5eka6DwCxtFrsBlurk7yDwXUU/ZYQ9y8BmknER1n1H9pftc+ILBA6wv0R5PgfriHi3fgU58r1cXut5os7lG+fU/ZpVoRMCNFk+pC9HrNfQGXXMjP0N46n2VZ3P3JhzkfSwdzg7rzS3xR35AA2/EavUJx0BEiI8zQ1eJ2ZyYqy/+C31PRcW5io4oP/wFiBNb8rqzqZ7rEmJznQhtPnuNTrq1AP85vyX4qD2F3T3KEiuUvc5z2xa9RudoDPFG+croJqB99SqX6SYm4OBwqXqKQrT3hfz38wcwNoKgjIFEUj+lmimjQ3mBhTQ+NCvecKFpRf5JdpQcaCZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibNeJYq6YS6TxuhmPlmtNtQkPhqrjlNLkjDDDH2CiTg=;
 b=IgUY9bs7bVUYuatm/J4EeSzdWJoeXY3/jfJ4wBXEBDgahHninP5O034ZEbWMWjm4sKZ9WLlKiFf7N12F8ZujUMkTXsAZdvX3dnD/GIVt9dtO/Zd7kUgXAV8RyZU+nPuLP85DXtgrUivb8ywFrEHXyKBzGFZk6D6fSoJoXWc4fag=
Received: from CH2PR20CA0021.namprd20.prod.outlook.com (2603:10b6:610:58::31)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 13 Sep
 2024 15:22:09 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::1b) by CH2PR20CA0021.outlook.office365.com
 (2603:10b6:610:58::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Fri, 13 Sep 2024 15:22:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 13 Sep 2024 15:22:09 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 10:22:02 -0500
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
Subject: [PATCH v5 0/9] Add per-core RAPL energy counter support for AMD CPUs
Date: Fri, 13 Sep 2024 15:21:40 +0000
Message-ID: <20240913152149.6317-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|SA1PR12MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c66938-d91e-4a91-713a-08dcd407d57a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VDCNv6wdofJVVE7kUU2SS2utOOlNX8lav/VuuNvJnLwOSLSZn9dbSSphY/el?=
 =?us-ascii?Q?SEtEkEb1/nXlbqOUlvwaB84ekXXFQIYMq0IHARN3/0V7bvilZzk7yuywujX0?=
 =?us-ascii?Q?VTOnLMYhxIdRFf0RjeRjCq5ityiqVHKdnigx1B4IHjNjJcCNPQ9XwEPDf4we?=
 =?us-ascii?Q?cj8/LziZgm9AI3kN+HWxryS4tskQlxDLdadVEWiKCQ+j+kZS3Uhp8QZkMAo0?=
 =?us-ascii?Q?IM3qp5/G84AZoSOakPtR3+JRNfhdBYZcgCK5ndaRCXRE2aemVbTONPujupOK?=
 =?us-ascii?Q?17HsRf3fjm19HrGvKVf7rg5jnxPchlwb4aIlm/7ztpB8XOUUmEeRWaw29+Pu?=
 =?us-ascii?Q?doJGmjonYpXWZFh3umKwBbZCVS/mFoXnMQjYg8Yw1uNJ0Zn7EFInkUqi1P6E?=
 =?us-ascii?Q?tNnRxCoa9M6sTBflDWrAwh45SjBb6p4mFb+UmsRtrYGi/PeYzGtWHY52wE6r?=
 =?us-ascii?Q?v8bZnzOnPFSRKeEL/JziPn2xzyAKTz+UPM60TtW9KYlOcRaldNT6VSORo8Os?=
 =?us-ascii?Q?hVOfC4WkWJJ3mQ1Gj4TNBsh8gJFIQbFOgZbkIt9spsSux6mW4lxc0J9eGg7Q?=
 =?us-ascii?Q?PNAAfNWWBggG0dA+bhWkrJy6+I4rtlEnUIyT2pH0Ocjx401wlfceXGMigy/b?=
 =?us-ascii?Q?9dUHGZzRxoCucJGmJjJ/hmVZIotFKPiYWYUieccdEkUkke4uRCUO9CDdN4yT?=
 =?us-ascii?Q?IIY2auTr9kdo7oCKdnha79mHcJX8ijvA7SgEJWFNKlHjs35loJJJuK39q16a?=
 =?us-ascii?Q?AF6/9U6mHHgDjUX3ke2tdS2d9uuirXvCoMYIstZa7hQ1HfkgEGE+L4bpshR8?=
 =?us-ascii?Q?LNw61W4odybUcuBwDB8cSjPEi80RDUR8gSo6qSIqFGcDafRHbwLw6A5VIyBR?=
 =?us-ascii?Q?jWiiQMr2NXDZ56EL4AABMGXcVpNSUSZE5Hl0A7zT7srPokRY26wSk8NtVtG+?=
 =?us-ascii?Q?flZn44qQ7CpaxwFwVQqxzZRfrldY05YsEBVCCv/z99FiSMwC9ks0UO/1eILe?=
 =?us-ascii?Q?HxTmubq8our6fBh0gP78BQw/rbrQgH2OIOlPiV9q2E3I6OkIqRpeWox5SL57?=
 =?us-ascii?Q?ea9KgVyV3/ZNOZIpxxONi0yhMF3fEj25dbs9ce5TTGN8lCx90Z6qoiV239Ui?=
 =?us-ascii?Q?A6/hdt9Q/qbtYdzPc955iZJi4MBcAqW4rs+Mo0TZpDYaG+9r+5covcsp4Jch?=
 =?us-ascii?Q?EMjm8R8KnlZEZc6lr7XiLMcqDJjsMF5COVy6/gQXF7lcIgZZA1Z70rxXLKCL?=
 =?us-ascii?Q?6WjEE28MuN9FujlQFWr0NDYAYbt+UJbtmM8vtnGXc0CsdNWaxV6nERhRlfO/?=
 =?us-ascii?Q?MECilPpfQMV9GMT6CNCFTVXBKTyAZjKI4IKzOT7kTLGbeR8IGNqhxfAjlyBx?=
 =?us-ascii?Q?I8+gJawIuXBy6WUuEaiJ/7f809Ddue7YLDrzPoCXQDyhYm09iQPYy9Y6W2MO?=
 =?us-ascii?Q?wa7iockQhEjk0kBghhzCQLWFBP9rs8bjFHwErD+bOF+BmZgj/cyzhA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:22:09.0261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c66938-d91e-4a91-713a-08dcd407d57a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821

Currently the energy-cores event in the power PMU aggregates energy
consumption data at a package level. On the other hand the core energy
RAPL counter in AMD CPUs has a core scope (which means the energy 
consumption is recorded separately for each core). Earlier efforts to add
the core event in the power PMU had failed [1], due to the difference in 
the scope of these two events. Hence, there is a need for a new core scope
PMU.

This patchset adds a new "power_per_core" PMU alongside the existing
"power" PMU, which will be responsible for collecting the new
"energy-per-core" event.

Tested the package level and core level PMU counters with workloads
pinned to different CPUs.

Results with workload pinned to CPU 1 in Core 1 on an AMD Zen4 Genoa 
machine:

$ perf stat -a --per-core -e power_per_core/energy-per-core/ -- sleep 1

 Performance counter stats for 'system wide':

S0-D0-C0         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C1         1          5.72 Joules power_per_core/energy-per-core/
S0-D0-C2         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C3         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C4         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C5         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C6         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C7         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C8         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C9         1          0.02 Joules power_per_core/energy-per-core/
S0-D0-C10        1          0.02 Joules power_per_core/energy-per-core/

v4 Link: https://lore.kernel.org/all/20240711102436.4432-1-Dhananjay.Ugwekar@amd.com/

v5 changes:
* Rebase on top of Kan Liang's "PMU scope" patchset [2]
* rapl_cntr_mask moved to rapl_pmus struct in patch 8
* Patch 1 from v4 is merged separately, so removed from this series
* Add an extra argument "scope" in patch 5 to the init functions
* Add an new patch 2, which removes the cpu_to_rapl_pmu() function

Base: tip/perf/core(currently has just 1-5 patches from [2]) + patch 6 from [2] + 
      diff [3] + patch 7 from [2] + revert [4] + apply [5] 

[1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@linux.intel.com/
[2]: https://lore.kernel.org/all/20240802151643.1691631-1-kan.liang@linux.intel.com/
[3]: https://lore.kernel.org/all/8c09633c-5bf2-48a2-91a6-a0af9b9f2e8c@linux.intel.com/
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=perf/core&id=8d72eba1cf8cecd76a2b4c1dd7673c2dc775f514
[5]: https://lore.kernel.org/all/20240910085504.204814-1-Dhananjay.Ugwekar@amd.com/

Dhananjay Ugwekar (8):
  perf/x86/rapl: Remove the cpu_to_rapl_pmu() function
  perf/x86/rapl: Rename rapl_pmu variables
  perf/x86/rapl: Make rapl_model struct global
  perf/x86/rapl: Add arguments to the cleanup and init functions
  perf/x86/rapl: Modify the generic variable names to *_pkg*
  perf/x86/rapl: Remove the global variable rapl_msrs
  perf/x86/rapl: Move the cntr_mask to rapl_pmus struct
  perf/x86/rapl: Add per-core energy counter support for AMD CPUs

K Prateek Nayak (1):
  x86/topology: Introduce topology_logical_core_id()

 Documentation/arch/x86/topology.rst   |   4 +
 arch/x86/events/rapl.c                | 406 ++++++++++++++++----------
 arch/x86/include/asm/processor.h      |   1 +
 arch/x86/include/asm/topology.h       |   1 +
 arch/x86/kernel/cpu/debugfs.c         |   1 +
 arch/x86/kernel/cpu/topology_common.c |   1 +
 6 files changed, 266 insertions(+), 148 deletions(-)

-- 
2.34.1

