Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F0411A18;
	Thu, 15 Oct 2026 06:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792044304; cv=fail; b=DNJhW1MeHINmWRflYxCKWaMgsNYVaPQHR19Y4WH+cHxWnsRTzEAjuFS1ty0RsyCY4osPf9GUSEKGoXyHUlqJ1Qr82O6zvUHGbtmvMNuP1qKPRzFRCXmX/HIYsZZsllQqn2kxVSxJRHdDZQUl6seLHPo94JIJdlCyejPgECblPws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792044304; c=relaxed/simple;
	bh=poDyk0eCEIpXc8US3kSyaRezGyfMbYs7Xyf5TNG0Xco=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fTZddFGTjReX1sxVymxgyU1WXT2fr9RuOgecCK0PlK2Y50cKSDkM+/hViCqEsNB7uVgrjfdHIp9MFp2Ur45Dmqbx0pAM8s2TRuWkBKQbUXCH/KZCH1mwYPvvO6OoQueFc3lCoDXfVxtGDQVycuH9yatvhhqusuBHvFjdWexXhj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KfGKOZNz; arc=fail smtp.client-ip=52.101.61.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KfGKOZNz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wS1a1fEWuyr89ePPUIj1XULkuOYQ6EUPC05NeVOnMvrThfpFXpMPCtDckb24thDGdZ29g2gS13sBjOoZCj2R+e8g6VhpIxo3+xceRO4NnpEKFUY/feg6nWuFTZXdslAUSC+i2HiZlCs7hG+J2T3noseLrN2A/vFefivNhNpdT+qVApdnZ8fIhmR/9qFkSE20LYaq8zikmyd/ICIKPOrvVwQ+mB8LFLeF+IKnwjtksEz2ACehGaDq7AdozqR1OvJCnOLXaIPtLnq9DZ9QqaHszA7DiLNfBIwfUXaANobiufHz25GrNqnNTz7hl4Xqg4xxB3rKcU5Fe1zYW3xNuqqg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ijo1hp2kj+i2VKroMtWMtnN5EsD+gupa0Cxl6UC+It0=;
 b=j6ncCriw4w0lkrvwy38cxErzH22IvGkrEAhLxZ/TAlGPFp5cKYY8/o1ARatReAiJDnyk0yRT2LzwyzyVtNwPeWkYaUq+TWd6c2W7xm5qaMiyXNquFj5q1RL+ZCpMz/hil/XdgonbiUlHxXqy+GfsQz6vtZiMeWOfY3Lb9TMrz/1mz+KqSc8CfFbnOatM2E7B80Iwd/lLlpCEFy9Eh1VKwy/7DAakNTuVBBZl+Vt82pkIfXwoc4Kff62gSD+5xb/sVBJkbcJ+vCnLD7vceSTnhXFtffps0/1SEFR/6E/+dyxSebUk8KCx/F35imngJRWCd54bOp98UjwudVrJLMPz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ijo1hp2kj+i2VKroMtWMtnN5EsD+gupa0Cxl6UC+It0=;
 b=KfGKOZNzMCd7vy79M0E2QBJL3Qi3Cyhs50L7006Xr0kAipVPZUnUslmAo+HuMBwjOBM91jlzpYRkRlFW/jHW80ryHG4liWZ+nfdU4lMt30IgkjeNzKwFuHF433kltyBX9b/tDUdOKNGPfIHkHWfj3GWae3uS36v8evJP8oaeRPA=
Received: from DS7PR03CA0258.namprd03.prod.outlook.com (2603:10b6:5:3b3::23)
 by LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 06:04:49 +0000
Received: from DS8PEPF000000E4.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::9f) by DS7PR03CA0258.outlook.office365.com
 (2603:10b6:5:3b3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 15
 Oct 2026 06:04:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS8PEPF000000E4.mail.protection.outlook.com (10.167.23.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 06:04:49 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 01:04:38 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	"Jim Mattson" <jmattson@google.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Jayapal Ashwin Nair
	<janair@amd.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Ian Rogers <irogers@google.com>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Santosh
 Shukla" <santosh.shukla@amd.com>, Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>, Manali Shukla <manali.shukla@amd.com>
Subject: [PATCH 0/3] perf/amd/ibs: Assorted fixes
Date: Thu, 15 Oct 2026 06:04:27 +0000
Message-ID: <20261015060430.5877-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS8PEPF000000E4:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: a84af0f1-966a-4a85-876d-08df2a82389f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uJPl39en8ZI0j2qj/vdnl9shQcKQto8el0xcJ+i1n0ESCpvjzGXxeypRTyHcGSR/1A1pnEod5dFy6Zj1ldhdu2o3HUEHFVs4MTpnlmM6tPT48j2fWY7AyA6kOd/iE5Kv/rlAerG/lEu8Tzv6VcRtzL0ulzdVC8QAOF8SNqbOf4pr7fV4FBI7cpmG43dYS5kGMF/tcaLGSw6Y2iAcz7mmDW/ejIhy1FiIO7JppdWurdw6rp90utrRJYVHwZEcBdeXu0Tn1+g9UdqyPDrJrE0CKZetxXGHHQshpZSDYj11ZJVs/vR9dN3RsM1pXIlAnK2sn8NV5sC95ALs61vk50q5YrR3aeC74kAkATnDhOYN4cSvTewCqvjjJj7tlSU5ce21Vv9CNZtV4BBdCZxNO03yacry+2rRxXGDSpwKcBqo1R3394VqdKsS1D0j5Ikkt7SFX/r9J72oO38KB/qtpfJJ4BSceaKban5X8OQQ+8sB7ZJTPVea0wk61yIGyq8wTyMcbhhs4qAgpuV/00Jsfhrd9oyUSmcMUHNSxBfgH5K/nq8D9MkxuiS0Fon8/cB9+yc3JIJpdpa9Sf8jwFk5FL+DcV1qsYrGM/9AzNyJcVQHqXAzlOyZ7UJmSdT5SXrGjpzMKhgCC5eitF89+wbQ2Su+m2n8Alx41l20Z5WYC0O+sw36S87Em/q5j4JB7AJTjorTI5ISo1NlcEeQyzH1eJ8ZuA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vfxGozuw9ITUO9vm6wHpmzS0CBvhiMOF71PjzwD6FJCuHquK8mMM5t5Kni6b1GtKJ+aI0IgbGmK0Dsyt3j5KPAvEx+Mf9/Kj4GHnebQ1+9an3cvoioBQAseHKKhGtoP8eEowOEo18sSjCHHbEewqzKtQ1Psztg7xnE7+LTz/W/qEn1YSaiErMqbYMU0R7cMZfTlM1WS2ovX1XEoa+gJ0ZF0McMPo6Ee+FdnrKR5a2mPHcIoKbk6uf/kTtQOLcN11Faa2XCWmQhc/+QxCiW89puzOB3v0AfbmqkdG5h2uZbShkdoOM2H7YAQr+70kcVeTLsrFKZZJjh9ilxR9sLwp49or8j5ANucT9VRXmF3/F6SQ1V+pAXtT/+/Bfxp36el8Bnl5B3Go36yHidgG0jk4mnWzEld12lsV/YizkSNgT7KdFkztsIavqGhZuYZUZZYN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 06:04:49.3580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a84af0f1-966a-4a85-876d-08df2a82389f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS8PEPF000000E4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208

#1 Set IBS MSRs in syscore->resume() callback
#2 Fix kernel address leaking through REGS_USER
#3 Fix races by reducing SW states when IBS_CAPS_DIS is present

Ravi Bangoria (3):
  perf/amd/ibs: Reset CPU0 IBS state on syscore resume
  perf/amd/ibs: Fix kernel address leak via REGS_USER
  perf/amd/ibs: Simplify event state handling with IBS_CAPS_DIS

 arch/x86/events/amd/ibs.c | 156 +++++++++++++++++++++++++++++++-------
 1 file changed, 129 insertions(+), 27 deletions(-)

-- 
2.55.0

