Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A313017991;
	Fri,  6 Dec 2024 05:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462259; cv=fail; b=SO+dEXxCO9LmL2o/CYAjwGC6Rc/1Ei63fxj1ZddxMqcvGpF+KRed3YYvHeXJTohWnCRsBcZax7HJ6GyTQ79yiBmrX4dNfpMoc0RVwgSUHG8/NH1g6LaXJXU7HEr4yeNkybXBHbMSXyYriYNzSpn1PYHqb6vtUU8Si8l5Lfi3Spk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462259; c=relaxed/simple;
	bh=/yUzGDwV/isrMA3ryOZJq/+kMPeGw3uzTBTor7SQha0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PacEZIM25NlHfnUG9tvwoxgWs/YoWmCwwmRkcH0HrqRLxFC4tSug8uLCqwL2IbLPR+UDLz7dhzjK06AemOnmtg21kXMN6H8jkNq+RJ9whTy2usNgtE372NYwHZ1XZfkg3hxaJTd41SITwGzbZ/9LiaNQ2SvYxNKQJm9OUZG4JKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gbfiBSPF; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gbfiBSPF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoUMLVxHQzsO8F6E4CEw43x3USS9/LhI1bC6/rGRVoGCVKFLaLMrghdlHEWEySMbMeOALkTkfF4H5ib0dMaRLJ6poEMenbgwQ3PBuNuhXwFUemupJZt7D96dgkh9VgGasTiSnB4nd6tSDtOgG2A2SnzqCldIFj5CJsh1cOfoGn+dirsfhTJrcxaqXVfsrJIFHV2rBuQaM6N1uTg9TtSIEoWk4pbCIkU2VtJcGpTuqbR69dn0tOBOqU/WdVqvUpsxg3wH5wO/W/NKlygJtA3Co4r1u05W1LYLJDAj4rIHee9AmRkXrJ8E5a869RhpT6drjXy599D9jXwKKGWpepWZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nb2ZLR1WHXoIq4/025kn7JXJsB/orhbo0cvCyO7fU0U=;
 b=frZdc+CeSsUBrp+LFPxqqhtPfVdxHHHzTEU2OADqgOCZSAZGt/xsZBfKZ3fU0MgCYV9zUuUNVr/sHLpWgUFFEWhEZYtQ01Wb+GydGv8Lc3dGHccmNlWMqAJsxAENVu3JhCQvtCf5uO/5k1OuDiGpmoT3zxbtKRh0qwyd0doz2199ChYZ9Xx3TUSOsStptzZZQ6ppRnljKdq+2blONbltdq52g98CuooOOIfmtkw0L7bGfxeAMrA9oajFvDU1iMapDKRJ5YGLyB6jw9GdTckCuCz5wS+SmmZc+N0TIWvi8qB/8FEEliFYs99cQVR4rW61sdBrxEmWM3ng4Kmh9oZBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb2ZLR1WHXoIq4/025kn7JXJsB/orhbo0cvCyO7fU0U=;
 b=gbfiBSPFbZ9i3IlzuPUwUXaorIU6QvizMrBSuu9IJ4uj6+uTx6HJegZUMAw86pDYXikq6BZ91GsRijeG+UbbY7jvFMwZ1PG50cGZeRS7jlJ0JKCONGJ6L2BqtvkUrEi2tEAz7UYbOsSYpDbg0t77rR5ZBpB/OSx+nEeYoCkUZCk=
Received: from SJ0PR05CA0138.namprd05.prod.outlook.com (2603:10b6:a03:33d::23)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 05:17:33 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::df) by SJ0PR05CA0138.outlook.office365.com
 (2603:10b6:a03:33d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.11 via Frontend Transport; Fri,
 6 Dec 2024 05:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 05:17:33 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 23:17:26 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 00/10] perf/amd/ibs: Fix sample period computations
Date: Fri, 6 Dec 2024 05:17:03 +0000
Message-ID: <20241206051713.991-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4ada41-cd13-49b3-4af4-08dd15b54a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cKK0zT6SOhut0gLllgF9pO7EYIUgPCY9bTYuzlX/BTHLfsvaB+SjsOiH3ssp?=
 =?us-ascii?Q?M24nJf+MiYdWla7VtHOI99O6fJE1RzuZYk59bycSYiSBF33SQ8P4HSVxG26W?=
 =?us-ascii?Q?S9WDIG+dz4vbrrW5smsRsdkQ3pbE5acIKsfh+ZrNnn2BCsF343mPSKpam+OG?=
 =?us-ascii?Q?/BhMde6Dc9O+nndNvBdycE+1qmSn2+KsQlZckxMDPtbei5gGaXQoAr4QVKHJ?=
 =?us-ascii?Q?a2A95RDMV9RxMhsdCQIhi9h/UFor4MRVj9ANgRdoRZnFw3NL81xekbWgrW0w?=
 =?us-ascii?Q?CYV+8a6O63veRUPHufN/bbMCBec6Hkzb/EqW10pdngyEB+mIKALHH6udbsju?=
 =?us-ascii?Q?RtKL0MhL/T4JC1j6GxXyKijBYZNe3wIb+EMK5ZPpXAwXiKaY9SNVEZgOybTm?=
 =?us-ascii?Q?CjiEK5IOf+/Bw8mSveCELST1vRZZxAsntt4rEoYZUA9p+m/ySLjIvtL8xqny?=
 =?us-ascii?Q?qSoc8JMwr21xo1fALvTA2gYKCgqHEVairq4c1a7TGol9cEn7Q5dMT47EYEE6?=
 =?us-ascii?Q?nyyuTUMxbfzKAwhKt5jtRNU/QI5AaNCVPt0Q6ZLWlUx4XGgvjoZBpuJc8vOR?=
 =?us-ascii?Q?rMjpHMfdRYAAnW+jyQ67Z8s8V5gJ4PLPI8Yzm7ZuviSfQlm4pvmeXQedfkxQ?=
 =?us-ascii?Q?gqZ2mgM29UmtX6DgZTfj3uWiJKXhhjWhzhRJ2+VzW6LJOHUdK3GJm9+wXmGA?=
 =?us-ascii?Q?O62jXH943/CoY7FGIg4L2LkYoAg65NnkLgCQWb+9ogQZjeVSrKAEfuZd9Bd6?=
 =?us-ascii?Q?S6FwhYrAlZ36lybgx3pT98bCzTqZTixvJICv3P+9XR2dqAZj5WNkUvF8+JpU?=
 =?us-ascii?Q?5Ye9lFoJ+8jDpmDd1WYxtHz1FUfxBJEDiy45Zvkz/QFvmW/M357gjpTSnDQ5?=
 =?us-ascii?Q?Duhl4Q7VrdBWqRSjwlT9Ru10cpZSl2ZfpHmCLbsX7XdfhqF14dpwlu4UXffX?=
 =?us-ascii?Q?1NKEMjLleu3bOfGJcPwjtn9ChlIdi3fewtI9zVyOkaji/13mMMRGJjKWXlHQ?=
 =?us-ascii?Q?sEJYbrbd8gAbrZOdfIUA1lHopc74t6Q+srmp0vhUJkSONsmr7aM5YGT6viH6?=
 =?us-ascii?Q?dkBz2xwMby4Wz3xUk8T8Arfleql7xzXELtlRzl0StBp4+0qU5k9pxr6AQJCV?=
 =?us-ascii?Q?y1dbugW2IUCgF15h6va3OAxClh4bmu86FDC/RUC02+hjcOqG3jQ8+/U28/HC?=
 =?us-ascii?Q?buvvJWhg2+zP0VTUu+JU3jnyXWpsSJ6P+Nv8WqHs8YvP0M7ruJLJLooGIeOZ?=
 =?us-ascii?Q?P2Joltot2Ttp5UtdSoXtmjiyJETn5hHLnkMg7f08eKQ6DPAlWQRI6uZ3HvEz?=
 =?us-ascii?Q?qFc+vnuD3OdwagcB1cWLVd67VEWCMKeIWdX74cgnqh9mwZydmZsK0A16/0z/?=
 =?us-ascii?Q?UGg3OoQhmL3QUVs/ojpBi1mhFp54m1e9MMsMXUY2AD03Iyb1r2Tr8tTj+TOZ?=
 =?us-ascii?Q?soqfaDzh51oOfMG7BXHnmCfOsGnEyRYa?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 05:17:33.1351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4ada41-cd13-49b3-4af4-08dd15b54a19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324

IBS Fetch and IBS Op pmus have constraints on supported sample period
values. The IBS hw behavior could be undefined if they are not followed.
Currently, IBS driver does not honor them correctly and thus a malicious
event could cause issues to the system. Fortunately, the IBS hw is very
resilient so far and IBS pmus are restricted to root only, so the attack
vector is minimal. In any case, these are genuine bugs and must be fixed.

Patches are rebased to peterz/queue/perf/core (f7372965c41d).

v1: https://lore.kernel.org/r/20241007034810.754-1-ravi.bangoria@amd.com
v1->v2:
- Patch #1 to #8: No code changes. Include Acked-by from Namhyung.
- Patch #9 and #10: Add perf test to test IBS pmus with various valid
  and invalid sample periods.

Ravi Bangoria (10):
  perf/amd/ibs: Remove IBS_{FETCH|OP}_CONFIG_MASK macros
  perf/amd/ibs: Remove pointless sample period check
  perf/amd/ibs: Fix ->config to sample period calculation for OP pmu
  perf/amd/ibs: Fix perf_ibs_op.cnt_mask for CurCnt
  perf/amd/ibs: Don't allow freq mode event creation through ->config
    interface
  perf/amd/ibs: Add pmu specific minimum period
  perf/amd/ibs: Add ->check_period() callback
  perf/core: Introduce pmu->adjust_period() callback
  perf test: Introduce DEFINE_SUITE_EXCLUSIVE()
  perf test amd ibs: Add sample period unit test

 arch/x86/events/amd/ibs.c                  |  97 ++-
 arch/x86/include/asm/perf_event.h          |   1 +
 include/linux/perf_event.h                 |   5 +
 kernel/events/core.c                       |  12 +-
 tools/perf/arch/x86/include/arch-tests.h   |   1 +
 tools/perf/arch/x86/tests/Build            |   1 +
 tools/perf/arch/x86/tests/amd-ibs-period.c | 953 +++++++++++++++++++++
 tools/perf/arch/x86/tests/arch-tests.c     |   2 +
 tools/perf/tests/tests.h                   |  10 +
 9 files changed, 1055 insertions(+), 27 deletions(-)
 create mode 100644 tools/perf/arch/x86/tests/amd-ibs-period.c

-- 
2.47.0

