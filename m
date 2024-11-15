Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8381547CC;
	Fri, 15 Nov 2024 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731650930; cv=fail; b=aBm/gjbzR2h/hJGj+siMjIEHTOFni4lxzk0XlvJQD5e+cy+OIamCenIRgWXj20DD6HqDZBVGKKlSYIoHxzDY+1B0rbkX9FYnQwKPglyTcYXqI4nVC++yBjqU+D2sPo5w7L7/9Tah/KKJicSO+BrMdPwfE1E/ie67BpMkO7nl/nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731650930; c=relaxed/simple;
	bh=HxVh0F7kTiXvGUTNb43UFTIbEMFYOr00iQS5rigb3/0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bL51e+xqH9daX3x5FLsnTgQF/G+H6/qFwgiUJCa4IeV9evBb9JZChcfjsbi5aNcsRyZvj/yvdFp6ncoylsR0x1dgr+AyhUHL73f2RypkafvWRY/7J+dWlRgeJ2wdmO0A/TLiFpScj6lxmzTNoGWCDPEbWm0F+hqK0HSgvGUP7XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qvrCG+FZ; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qvrCG+FZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZ+3WsXVvJErLWPy8jnH2yhza12vNVAhZEyuDm/OWeWqdVKdOIa6J7a1exa1qg7nQE6bHuk28iCcDwafSlHmLZIesTIkx8OSFVBMYXNUkXVkwoeJc32BcmtAkunOg8eb1k410+VlY/sw/e+9mZFuTmFWKqMlU5IjUkzlvEwkqAN+bRA2hsDHSR+NU0gYOpeOewhTv66oFLvUB0Rn4NnAa38wisWZZuUpxFFfG9Q8IfFZOKvF9JD6hEuz0xqx6VpOTTdT6US3mFfMKjT2d3ANZUDrjpMxapcfpuPhzwgEeD1g8urL/mKyKnwX8lP6lmInng9GHc/3U+voFJ76PfUsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tBzDRSLcAWTSmnewDOkB1cZTehHPC0/xcuHGxvASdM=;
 b=p8dZ2GqPTXv00C76R32YRrMeZLsAfmUb4VIQKF+JjtE8OSTVxTUsCE6XHWk1YD/L6uVUatn2FHcacI2LEglvqLxzO2rEm8ZIIYiiDn7+UbfIs4uMjNwliE8k2ZyNzK0YQptNEAReV8KQuAd98qY0SIFRWC4RgfvJD8/9ko9qIMBDE/3IiNcRjb6ZCcINlxCEf8eYw1FkSUJgNed0RjT1LzqOT8QX6Gb3Vaa0dEDDJ0XgBXcaLoEWOkSwGGgaeqBqVqL6PMPIwHUN8YaFNaBfiq7LkMVQBioFXd/PK11eoIMY0JfMNsSzsEGVixO8KN6gQOZr/Qg888Srj0yJL9deaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tBzDRSLcAWTSmnewDOkB1cZTehHPC0/xcuHGxvASdM=;
 b=qvrCG+FZEUAKDV0f8cdQ/XcS/+06XdZHzFjPdsdMlYpTEbqdYSGv5uZF1v+LEdUi5QAE4aWbAq0G/hapM+w0a+ffem1V7xxY2Q1d0uJci6c7PAcRzx9AFjxpxgMMwaY9TDAEJMAJ/9V9HHMGzEwW782Y+PLeCeL6wf2DitYj1Go=
Received: from BYAPR02CA0003.namprd02.prod.outlook.com (2603:10b6:a02:ee::16)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 06:08:44 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::16) by BYAPR02CA0003.outlook.office365.com
 (2603:10b6:a02:ee::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Fri, 15 Nov 2024 06:08:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 06:08:43 +0000
Received: from shatadru.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 00:08:38 -0600
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <rui.zhang@intel.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <tglx@linutronix.de>,
	<bp@alien8.dei>, <gautham.shenoy@amd.com>
CC: <kprateek.nayak@amd.com>, <ravi.bangoria@amd.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Dhananjay Ugwekar" <Dhananjay.Ugwekar@amd.com>
Subject: [PATCH v7 00/10] Add RAPL core energy counter support for AMD CPUs
Date: Fri, 15 Nov 2024 06:07:56 +0000
Message-ID: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d13f9c3-3f4b-4c07-1dbb-08dd053bf5cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EnmVU/lcmmRTe4Fc/irQjFLpdXJuXXrBsqnifaiOSqds8dl2uzoaah6O9Sgv?=
 =?us-ascii?Q?nBf6zE24lObF2jCRT6Wznajdl2oWKO0AbE+3XFcUWuvgX5z0u83rpIaQTQPe?=
 =?us-ascii?Q?Q2GUfuWGEKKe6z3Q9YqkB04nu8ZqcipkzF3Kgkm8eHiNfLp1MWjgAm1g6pQl?=
 =?us-ascii?Q?ktIF0hCWfpUj+5xySZ49Wd6nqtsRFKJjS3CyTAnevgsbJltC/WhL2IUna4/W?=
 =?us-ascii?Q?GTXT964L53rAozHz2ESc5V+m7uJk9DwYu0W6hlt2ISu/LfMPPPyJ9bm8v/+q?=
 =?us-ascii?Q?kV0goxvg/lta+A/hvAoZssfpB2YXMwUZzGPvg2EYRqepE8zy6RpLSzRf7W9Y?=
 =?us-ascii?Q?37ccsWxlvCekYVqfb46IA5/hbsa4iTw55j4wztKoRa48BSpmMrXECzIhL1mr?=
 =?us-ascii?Q?fBbhnCTwSnGTZHHHOVQ6hqj1lcNVqqIwQRbJ0gjCkGTPx19B6lftVg0IC3zk?=
 =?us-ascii?Q?7Kh1aYLP5B4R804w8iLzya0TDsxKf59PHpf6PiImvKhUFR24TozYKkfTxeqc?=
 =?us-ascii?Q?4LWzB5PdYp4rlKrpdL9afAmvOyYUnDhvGav2kcS3Ra/j5hHlKM9cfd0tHzjR?=
 =?us-ascii?Q?Imuk4m/8tf1gBCq1v1O0BZlruwqBTEURtpR5l8U+dD4E/00J75tlxFE/gDQB?=
 =?us-ascii?Q?mJpRJ50/0iQQou6QdxCV+Q5cOxv6AB2EAvDqQdkPwZaB7ljuFsYTH44qxiEU?=
 =?us-ascii?Q?dzk28OAS8xGx73J4pA0CiUxzly6FGJkR0KHK4BucQLdKzTHa3yRP7ymnQhVo?=
 =?us-ascii?Q?sk0HiANK4Yx9CoP4r2+mUlTdBnxmstaiDTJJbTecLbj3ZzHzGCSqRb6VBtOb?=
 =?us-ascii?Q?wLwafQUTSyYNTkDn+Kl0CF6+/rmM7jNZ3ZQI6ggoc3fKyM+HcOm53cS+uUkO?=
 =?us-ascii?Q?i8SW0nnd3Xpw6QDlIYquAaQB4b5/snBabzI+cIzYdnpazpX5Xxfoft/4mxtk?=
 =?us-ascii?Q?gP4owgGff181VPy0YcUSFlcrjK/EMKrfJ2C1t/DS0NftjTIgYRR1txpYVpoA?=
 =?us-ascii?Q?RqXAiudet/rOtX0GIC/SdE+SyxcbxSt8xsefgsJ6VdJhFJR0tmit/p95/DCq?=
 =?us-ascii?Q?E5HB/1M6qVPXDlFe5ac586G32hmrGG/GBuDvKnTSxcNmQAgAhuXmWlZAwmze?=
 =?us-ascii?Q?Yc51kmgkjmoqQjmwTmSGcJVlVXlYvzSM8lO+VNQ8loDs566QwhDHz9fGnWaP?=
 =?us-ascii?Q?WWUB8prexidAX4K9YI7+X3a3YVnFj4ieDUoxAYc72f3ZnsQlivKxe4mHvOr/?=
 =?us-ascii?Q?3F/fiQgHC8l8VuVMTQBuw50tF+d8jfw3EownB70nBNNJ0LqT7huE69XOLGwO?=
 =?us-ascii?Q?Tek5oyiBN05mbXvqKfN02cFECBTS8/YFIuLjYRudyPOX0Xr/SldulaNRn27N?=
 =?us-ascii?Q?ONJXITjdo2ezU3N1SLnz0giHUyztb1JXZgNaWaOzdrar1xEf6hR4IuFkpbIG?=
 =?us-ascii?Q?y6d3Zh/eLhg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:08:43.8357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d13f9c3-3f4b-4c07-1dbb-08dd053bf5cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819

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

v6 Link: https://lore.kernel.org/linux-perf-users/20241025111348.3810-1-Dhananjay.Ugwekar@amd.com/

v6 Changes:
* Pickup rb, tb tags by Rui and Gautham
* Modify the rapl_pmu_idx variable to unsigned int, and modify 
  the comment in get_rapl_pmu_idx() in patch 3 (Gautham)
* Modified commit msg in patch 1 (Gautham)

Base: tip/perf/core
 
[1]: https://lore.kernel.org/lkml/3e766f0e-37d4-0f82-3868-31b14228868d@linux.intel.com/

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
 arch/x86/events/rapl.c                | 414 ++++++++++++++++----------
 arch/x86/include/asm/processor.h      |   1 +
 arch/x86/include/asm/topology.h       |   1 +
 arch/x86/kernel/cpu/debugfs.c         |   1 +
 arch/x86/kernel/cpu/topology_common.c |   1 +
 6 files changed, 272 insertions(+), 150 deletions(-)

-- 
2.34.1

