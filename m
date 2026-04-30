Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094EC26A08F;
	Thu, 30 Apr 2026 06:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529502; cv=fail; b=qZOXCsVAhXfgadggv9smOCF5cfr5gwzHbc4pcO4Qw659lDmdWaqy8Oqq5iMpXc6Avn2xkH8LLBGXxSSk6jY7u01O7Q2j6dMJa9zh4GBhpQOBzttWJ8FoCpc3YPRP3MH49Yd1vgsP/RXUKpNRjy9a/43edk9uEXDQZbh1GJAPPk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529502; c=relaxed/simple;
	bh=tgBuxfU4dVZz3lyTU4a4aGZxnNr57ZNJ55jXP9tL+6Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CXcU2QDHIRCucEOrRHyfp+p2dS73NZH+wKSHL8za+BLX2rItMfPwpt5HKEjOAybALAaEaUgq34r7ioHvQz0c+9vb8HvBiumUoDOaqBBLXC+jHMwVpSR0fd3ibU6Hsb1ysWBYbCQylXkq7Oh+DFQkqTRS0pbFNcdktrmh8VlScdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jHajLQuu; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jHajLQuu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMMyTyqf2fC8USoQX2ixZFUfkx4Eev/sZCBTxXZQ1wp4CV/+SCS1YPXXL0ElevbaIZHFBq00LFij6zT7eZ45b62DGBFiuRiPJen5ImkbDK2mKgY8Qr75GZtKHTVLKplkoPntjKYEdLjK88ZgrWhVHWqjy7jo/2TxXAFPE7vMD63JZHxKsM8p/BinpNdJBPpBdrTLuXloB9vwXIT4EZy3io0wmc7zkVbc0TBJIs9Aa3xI9i8t5fuctBm7yqyt63j8nhtg9cHpEDhtiED9kRHUgqQFeJHxoQwvnPnDOyi4B39Y1+j5X2mDn4eaMG+E6+hQWJyJmMxPWo/LwR4YHBg2wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJa6Drze5NeyJ/JUcWZq8wrljOAyKBmziEC1F+SAX8w=;
 b=eJATzYFMA+MX8pgzqD9aeo57tWImVg45ZKg5afsUprcRk5YU8k8rEI2wdY27QXseRrpev6t55pR6sUJ0K7H2x4T3AWjeComJeBD9aXclTdBJfOk5QOsxJq6XDU+FniV7u6DNfF2UVhXY2qDCDBr1kN19FA37BiureOedecok+KPiixWc90Fs5BwFPLaJskOhnhZOJ8vAkK9nQ5wyzh+8OEpCttX8uWltM5Qq0FfCvfhAT+wntPsi620rzuE3cK+2onqgXT3TXlSS2sV50qNmQClLraJ1IKe0kVbo7RkADNCwCJue5hI/4BgUOb00fZJXoUtywE+A8+164VEaPma5Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJa6Drze5NeyJ/JUcWZq8wrljOAyKBmziEC1F+SAX8w=;
 b=jHajLQuuqyClenlVGr7tYMKkCvhGqtByzVuK0XMjyFLnNSJaFZKTe4Gssa9umgWQCcBemKcVbVok1vU4HS4VEcZmBruBmT8lXPrqjuyg1vPsJxJYTpHg3K9oKsWC6S8+vfXSAhDY9WtOjRddTByMkpgxkCqMcW85n8wwvrt/G0U=
Received: from PH7P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::35)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 06:11:37 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::91) by PH7P221CA0030.outlook.office365.com
 (2603:10b6:510:32a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 06:11:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 06:11:37 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 01:11:32 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, James Clark <james.clark@linaro.org>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v2 0/8] perf tools amd ibs: Fixes + Zen6 enhancements
Date: Thu, 30 Apr 2026 06:11:07 +0000
Message-ID: <20260430061115.10266-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dcac0a3-7307-4e93-9b70-08dea67f564b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	kj3FuRdlFiC2aJoCIFLy+xUWjIfWfp36/Q5ffVGyDJP1TcKLLjyxEZb5BK1F4NHyI88t/0F4d0tdZ33bzB3t0IdVNMAsoS2jy7sWYMUdSpk/4gSTtghHfyUq0T2QkoalBSfGbqPK88T0NGbDnZvDs9bdGKINT+3KppbGox/S4Pz2YFHs+1AWMJI6A8t9Dq70yVb1lujykaCWqV6kCaWU92RXRp5RbxV3T2UgHg71hCI7cxCHJXmzVFz4G6cmOTZhRxfYybjqa8jmJZItkrB1bTxKDgVMF/hCbzgIldUrqwQqFU2N7TQrm74I/kxINakVsw49yZ0+/WkGVgBPIm8F5TZxO5Ht8g7JUuFl4/B8jMhAF7erQ60xjsIuf6sZhcqgQQx82/rIWRk9ofbtlBLdxYRFZWItf77k49gB3rkS+s3F/EuNt4vh/TMnh2I9Xo0guEGsRlFmO+hj9c24Mnkb25mmET/za8Yu05BJCAqpXLqYLH6xqnso/TIoSH2wnDoWLufu+U55rLfkogTQOKLHT5CPcBHXdcnJtKzlYpTQreBebM1MVlPCSkc9BY0d1Bkg041S+0UA+fSxThcJNa1x29DSvc/2ccz8O/4E40OSro01zM2dozdgOrxdZ61QtDf34Hl7MmO/e1J7iBwtzAGq/DIZlW1GQmmcsqkZnGiLAY3NI+w7IKyhZSsb86PYk85NzAo0hmj7gGjA0ygkI+F25ZP6YHBY3qKXCHBlccLnZq4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Lhm842RZ0EiFYCVvH9L5MIa8WvOfqWtftdpoTPZfzIbEF5dCJ202DfIYIASaZTVh7NA7LeTyeQLidJfgWUnAL1ELqN8eR7wE9/A6KUzmQjGeMFembByydudHPXVo/9rfSN9QuZyr89Iw4n/ELmm2zI6l2GxFyWYgx+JDQ8KOQmW0PpWJfRrocnPvis+5cxP0m0SSbdMLWRcZ6qPH2l4Y/H6zB4CoQZlu92ikPiiJvo3/zUQ8d+v3A9hK89JBgdtUlnn+JagS1noQiHRdQHnzE5SPpOLJKfHDMLHzevDg/2ITl0PzQuicptWir9y/7TpRE2QhgsmHjTC45wBXje7omFZbMOuutgJ1A6l6Q6Ut7I9TxzEovUv9Gxot4bxFQowvwvsRdnK1/3n0xei+jGGWZdhbTWvQjP75nrfpMyzrxdKjotpW7rVARp6mr1XqmWyU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 06:11:37.1165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcac0a3-7307-4e93-9b70-08dea67f564b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011

o Fix kernel version check in perf IBS unit test.
o Drop perf unit test that assumes IBS don't have hardware-assisted
  privilege filter. This is now supported.
o Starting with Zen4, the validity of several IBS fields changes. Add
  the required dependency checks when decoding IBS MSRs.
o Zen6 and future platforms extends IBS OP with Streaming-Store and
  Remote-Socket indicators for load/store instructions. Add decoding
  support for these new bits.
o Document new IBS features in perf-amd-ibs man page 

IBS Zen6 enhancements doc:
  AMD64 Zen6 Instruction Based Sampling (IBS) Extensions and Features,
  Pub. 69205 Rev. 1.00 March 2026 
  https://bugzilla.kernel.org/attachment.cgi?id=310002

Patches are prepared on perf-tools-next/perf-tools-next (841dbf4871c5).

v1: https://lore.kernel.org/r/20260119024328.897-1-ravi.bangoria@amd.com 
v1->v2:
 - Patch #1 (kernel version check) and #8 (perf doc update) are new.
 - Rebased the series on latest perf-tools-next/perf-tools-next.

Ravi Bangoria (8):
  perf test amd ibs: Fix incorrect kernel version check
  perf tool ibs: Sync AMD IBS header file
  perf test ibs: Remove obsolete privilege test
  perf amd ibs: Suppress bogus TlbRefillLat and DCPhysAd on Zen4+
  perf amd ibs: Make Fetch status bits dependent on PhyAddrValid for
    newer platforms
  perf amd ibs: Decode Remote-Socket flag in IBS OP raw dump
  perf amd ibs: Decode Streaming-store flag in IBS OP raw dump
  perf doc: Document new IBS capabilities in man page

 tools/arch/x86/include/asm/amd/ibs.h       |  4 +-
 tools/perf/Documentation/perf-amd-ibs.txt  | 39 ++++++++++
 tools/perf/arch/x86/tests/amd-ibs-period.c |  2 +-
 tools/perf/tests/shell/amd-ibs-swfilt.sh   |  7 --
 tools/perf/util/amd-sample-raw.c           | 87 ++++++++++++++++++++--
 5 files changed, 123 insertions(+), 16 deletions(-)

-- 
2.43.0

