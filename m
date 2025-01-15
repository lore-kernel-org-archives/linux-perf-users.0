Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C58143725;
	Wed, 15 Jan 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956213; cv=fail; b=rNxm1phepwKXNkJeTR1wfjrL0L/hkw2e1y5nml4dVuRifeZ1pscbAtSMxUoVBHzp0pQlmkqPl7MafaeNvRIIYSywKNL8dlDJ267IQwCmFKAYzZuLFYFAU186DO33dhn0x+sdxzRJeLk4zgKZEyqT41XCWnqiafVZ2oJ8Q+6GRKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956213; c=relaxed/simple;
	bh=FpPmzEXC9Bi572CVCBMkv6I2N5slVK77WhdhQtJjdFc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BTqd4mI16fJVK28rNEZfSmBgF2+H7JWnemFaSF6fLcen8VbI5tOFk7cSIiJuSQEWIIzZ32rD7mOBK1h3+GIP7dER6xeFNmaUtV5RcSvDxDkJWdMaGXl9iFQwb0SkWLk2DRcsFMnjj/FKH0rg8oR8zhdZ9/bfjKK9aRNLPFUwS5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T+RZZvve; arc=fail smtp.client-ip=40.107.101.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T+RZZvve"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfcFZycsygL4givaHWQg6HmNHcjNQF+LUYI9VZtXSdT59N0Tlw66a6Xyy4+tZuVhrnfnlBJ8MrAxQGyBKoABjreaedMCHiIpu3B1Hdb/oo7rXh0QWiw0db7ly1gu7ptR6JETWWFN+hnDufUsVtAD9CUFtJwHThLSx70b8CyRHFpG3EkC3SblmYk6tgcVnPNsVOFYs154NHTKpsB98okGYG3lVrdlBY2d6+zFRKhfKPEBeIZ3GvgGjqKwVmN5aiPz9YNq+4++mBKzCiwsM7uvVAWbjjs7LzuFYpUMsnuiWF9QCbhRHOLLLC37klJ7PDMgK3ZAK0dnmKLRrJghWl+QwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlMEqJI+ArK5iOWEClJ2DG6Jjpt0SMz5C9/7Bi/VRZg=;
 b=TIKPTbqiXwm4DTUGY9+TDHpmk4w9mfuuapgFNMiiazCRmwpK2lv26HxdYU0HNhrOhA/9gts4h7ztNxFP7GQHXvhEU8/U2cb64PadHFpDNDWx0uJlNL1vZzoQIae/2pxg5i8DZlFDp0frAWRLvu3bC3WvGcimAeCIfgAZFr93ayEVTOMA1eekR5pPHkooOi+OSZF86TR88IFaqjOFNdrUGqxejSmk/kekYGLHa+Oy7JsFn+Qeg+BWh+0gb0nUBP3Xd1ViqkY/e0eo/0tZHwOeCsau4CMhrqgPxeLPyVYjYp/nOg2wwhuL+keC1Y+YB6oqWH20Eg55GyaUFt2s6Hb1Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlMEqJI+ArK5iOWEClJ2DG6Jjpt0SMz5C9/7Bi/VRZg=;
 b=T+RZZvveihd70ctXQLobLrafQTCvU6TdXufahmJUOq1vrPXXWE53xUF7WPmN9T6V/K8HgNq4MoiRlFSy5J0Xg1bsDycUEZWStE2eofQIiUaF3nz4kIVcTfdHfD8KJLWjyEzlCHSuCmiTzyPriSTWa/x+BMbYpShZyJrZGEMpv4c=
Received: from MN0P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::27)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 15:50:09 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::a4) by MN0P220CA0023.outlook.office365.com
 (2603:10b6:208:52e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Wed,
 15 Jan 2025 15:50:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 15:50:08 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 15 Jan
 2025 09:50:03 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <kan.liang@linux.intel.com>
CC: <ravi.bangoria@amd.com>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <eranian@google.com>, <irogers@google.com>,
	<bp@alien8.de>, <x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [UNTESTED][PATCH] perf/x86: Fix limit_period() for 'freq mode events'
Date: Wed, 15 Jan 2025 15:49:49 +0000
Message-ID: <20250115154949.3147-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b2e73f0-dd79-48e4-d8f6-08dd357c49f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2QoLSj1arHCx0k7tKoW1n0cyeEdk/M4NYVMIhvdzZZHy5qdeTyn25XfVr2BL?=
 =?us-ascii?Q?NhOkeeaT+uVhVeFSjGmsIbntG0Gh1f3UIcfvki1M/B5PbHc+iuVRoi+OOsro?=
 =?us-ascii?Q?agdoQVXfYIzX7E1jPIZ3cEW++Yc946dXQkptBGp592gcthBnro1xqbSXY6RL?=
 =?us-ascii?Q?auQOA+YHCEKW1v/f0i7QYD3Tu27VORJVHW4kw2Qi/piGbuYcV49r2/mHNLSq?=
 =?us-ascii?Q?p7uwxVy/s1jQ6A4b1qE1cGxU/63rTy86wYHNIoHHwOSL5H19jq/Ji6TeTY+a?=
 =?us-ascii?Q?rrwUmiCDnd7mtZllc7PrnLiYANy2x326TajL0MprkaIpc1w7UB2gVvbr2VXk?=
 =?us-ascii?Q?hAWSI3IQq93KM/GW8prvGvJh/Jv7NPOLYX17wgX/DZ2A7ek5JoOXt+IZI0zb?=
 =?us-ascii?Q?MB8UfEG+RDe+9w8faT+m5Jns8uEBcZBvO1v7emm3sbUBt7Kbg70ip2DryxGP?=
 =?us-ascii?Q?PoZWuGZGWeLRw0p3YISToEjI7SYpbXY8Rtw7d8mvXZ0Gkll0XkFO3tx5jZar?=
 =?us-ascii?Q?5H3VxjaSS3v6d7bjJW4+Cw7JRDfzlZQ/j56K8WLYB16Yhb62hacgzSOwPX6b?=
 =?us-ascii?Q?gjSQJO9ma4IPOphMWHa2zBBA/iT+I22Q3Msgm/+aMw419KZVYQ437SaGu1Sq?=
 =?us-ascii?Q?aHG1gAeq4c545EyGcoAvEWbBIlLeR9Htn6wHI3+vGhDQhRij4uDwGKvqLKJK?=
 =?us-ascii?Q?7Va13gUq2Xx9KkNIbFtMwBYtdAistqb1sU9wniIqXwydWmTijZITWhUb5lWc?=
 =?us-ascii?Q?3uHWCV8hHvWr7GI8aKLAQdyXm3t4eTTPL+L/6pCPrcjMIKqb0PUVOOV86JLZ?=
 =?us-ascii?Q?5FG7NCGu/szxRp5rRPS6dL4ShnqIUCvRH0toIXaEm7tbvPVIXWFqZ96s1HyN?=
 =?us-ascii?Q?gDMcqF1n7StjzYg4R8UR+FGXWN5hcwQPNKgB/+hIOktzqlysTPEo/yDQVv8h?=
 =?us-ascii?Q?hw7sdskWfRJkYtrXpl6qNmCv3Pc4cj5+uiACHCJBLMFoambywy45q3BEm2cP?=
 =?us-ascii?Q?qt/uotbR4P32aUi0uU089AMT4U24mY/uRUMfk0pDd3tXUps04VzN9miI74Fc?=
 =?us-ascii?Q?4ZHJT1/poezs2Zb0OqZ4Eo4XyKgec/Yyy0gDZu/4aFiYqhJOxTFHl/77aUHz?=
 =?us-ascii?Q?aqikL3GYoUNrrrYo3kSV2ix6ij48KPtHtTF9n7D3kWEcWcL21CwcFpByC1+N?=
 =?us-ascii?Q?JiiyAJnh2MG4K2oVN+YrGCG3MH2SXT1yM5/yaPkl4iq1do23slChnqRsgjDe?=
 =?us-ascii?Q?JGhJenoxYw4RejkxoDWzDEe0q5gdu8UYNc+Skz0Ps4ml0hALJk4SBTOtDud1?=
 =?us-ascii?Q?TCo9+phWTuOaXpSpXlg4xcd2Z6s3S1Yeg3QruXTF7X9z3iXB5ULgCp3Ng87x?=
 =?us-ascii?Q?3YDH6ppFQUHk8MHm0nYJ+oTu+Xz1JvneODoku+x1hRG/VvODIqwWUBS3lLef?=
 =?us-ascii?Q?zAugVWJKt2b20Tx7Vcxy7iYN2yneAKVc8wEawaqIX+ve+COw6z6ZakZ1jabr?=
 =?us-ascii?Q?OuaasIvI4wa/Ae0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 15:50:08.9049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2e73f0-dd79-48e4-d8f6-08dd357c49f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202

For the freq mode event ...

event->attr.sample_period contains sampling freq, not the sample period.
So, use actual sample period (event->hw.sample_period) while calling
limit_period().

Kernel dynamically adjusts event sample period after every sample to meet
the desire sampling freq. For this, kernel starts with sample period = 1
and gradually increase it. Instead of simply returning error, start
calibrating freq with the minimum sample period provided by limit_period().

Similarly, value provided along with ioctl(PERF_EVENT_IOC_PERIOD) contains
new freq not the sample period. Avoid calling limit_period() for freq mode
event in the ioctl() code path.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
UNTESTED: limit_period() is mostly defined by Intel PMUs and I don't have
any of those test machines.

 arch/x86/events/core.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c75c482d4c52..924aa35676d3 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -629,10 +629,22 @@ int x86_pmu_hw_config(struct perf_event *event)
 		event->hw.config |= x86_pmu_get_event_config(event);
 
 	if (event->attr.sample_period && x86_pmu.limit_period) {
-		s64 left = event->attr.sample_period;
-		x86_pmu.limit_period(event, &left);
-		if (left > event->attr.sample_period)
-			return -EINVAL;
+		if (event->attr.freq) {
+			s64 left = event->hw.sample_period;
+
+			x86_pmu.limit_period(event, &left);
+			if (left != event->hw.sample_period) {
+				event->hw.sample_period = left;
+				event->hw.last_period = left;
+				local64_set(&event->hw.period_left, left);
+			}
+		} else {
+			s64 left = event->attr.sample_period;
+
+			x86_pmu.limit_period(event, &left);
+			if (left > event->attr.sample_period)
+				return -EINVAL;
+		}
 	}
 
 	/* sample_regs_user never support XMM registers */
@@ -2648,6 +2660,9 @@ static int x86_pmu_check_period(struct perf_event *event, u64 value)
 	if (x86_pmu.check_period && x86_pmu.check_period(event, value))
 		return -EINVAL;
 
+	if (event->attr.freq)
+		return 0;
+
 	if (value && x86_pmu.limit_period) {
 		s64 left = value;
 		x86_pmu.limit_period(event, &left);
-- 
2.34.1

