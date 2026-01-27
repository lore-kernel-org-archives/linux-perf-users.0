Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013027.outbound.protection.outlook.com [40.93.196.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624C9329370;
	Tue, 27 Jan 2026 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539891; cv=fail; b=kU89O+qxEvRgqx72rTM5UdstyrvVgTMZsvVRCItkCo3YTaeIhRwc6yY85r0OZ+g6M5k9ZDYwheALfKMgyeO7TZanzvcQWMzzcy9hQuMjNUARIQ1xpWa6lHGhr6S4epThUdjdtm6LAd+Ud+oDGic3hSw+gChdsZmf9q172Am/zUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539891; c=relaxed/simple;
	bh=h8TjIrID0Y/ovI6BCM63hwDBqaPgqIkMi4BMb5Xviws=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHTsB9NTmTLg95/0zl+VGW49a5Wd4/ukoMT6LgMKBg0RWOQ5EYvTQla505/aRxiPcP4DtJthzPl9WIeB0ooyvjNiaY0JR08P3hr5M9HIVH8hlrL+bwUSSvVP/RVZzsigu80q7PfslQ7VNiS3GAreeGVZhZfwpa6hHpEWjM3WuKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r1O8yusA; arc=fail smtp.client-ip=40.93.196.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r1O8yusA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1xvI8HDEe0FsL4usG1hduP7KL57CMu8ULlB3iAB5+TPUy6P6x1NGpAhMzxWj2Qk9M/Sq26RUQ597SurouLXqyVx9vM1X643O5sHWZJYv1Wn8/5A1N2mbHsG7KMMEvaTVv5paADdiunAMkP+dfxAWffTGM9sfmKiNfI7kfUoA4x6k/lorNUXqXwxa4nMVatkK7r8jbUUJrjtseXRuqgblWE+vRviZiSz3Z3l/roP31rBUNxfKJCumt/HgIWRqGj0tEmAZWZ1CfUsuqfxxvCWos32C3fCq8fOtw/mX9EzQ9RM+DS0WNEIDu+2jAVQQicudL5pm0RgIKaO82777IDNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYnMg6B+D7OUtXZeIi6Za8H1CRsKSRddXN8lLMMa7FA=;
 b=Eyf54yPGLulUPd4IwmDdmTYqJhMHMygdE/yUPCTvDI7L+NVccdKaoM4R1qdgRGzxVA6n0WQE1zSp0dM9zyVkeEpKhtRTlo9UpZ8WahyC4mzyI9UkktW4ki2NMtcdJhx0xv1c7vCUDvshMma1LKOBifH4VJHc8it/TOLii3SPH7oMhq/fcQxbYtZX91z45HEhQkiwb0TsmZIAT038hsMj0OFQsbS/w73SCXevZa5PHIzhBeXspKBD/yTy06lYaK/Bnv3oofy5D5TlsU80TjG6FvZm6m5b+G4dvAZL/i60qLz0FHfQC4VRJK5QJn3B7HsNTc3/V6iLLhddd+5UTo/vOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYnMg6B+D7OUtXZeIi6Za8H1CRsKSRddXN8lLMMa7FA=;
 b=r1O8yusAOKDL6iq0BOH8/pAJkYOK1qMpqoqKrVES3VJ0E97RKdckVxIHa6igKY3lb13FN/wwJgFYh8gdKIkMHiCmBtQjpI8NiK2zYNTGtbOE22eRGxGUNRIPXD+CSWjWvAND/xswYGokX/iFSSAyuxojK/hGinkIwLIsKosASYI=
Received: from BY5PR20CA0004.namprd20.prod.outlook.com (2603:10b6:a03:1f4::17)
 by LV5PR12MB9802.namprd12.prod.outlook.com (2603:10b6:408:2f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Tue, 27 Jan
 2026 18:51:27 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::16) by BY5PR20CA0004.outlook.office365.com
 (2603:10b6:a03:1f4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 18:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 18:51:26 +0000
Received: from tapi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 12:51:20 -0600
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <irogers@google.com>, <james.clark@arm.com>
CC: <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <adrian.hunter@intel.com>, <thomas.falcon@intel.com>,
	<ashelat@redhat.com>, <yu.c.chen@intel.com>, <sshegde@linux.ibm.com>,
	<gautham.shenoy@amd.com>, <ravi.bangoria@amd.com>, <swapnil.sapkal@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH v1 3/6] perf sched stats: Add NULL check for cd_map
Date: Tue, 27 Jan 2026 18:49:57 +0000
Message-ID: <20260127185000.431884-4-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127185000.431884-1-swapnil.sapkal@amd.com>
References: <20260127185000.431884-1-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|LV5PR12MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1973c0-5d7f-4da9-332d-08de5dd51384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?26r3irxUwt1LOMmeSALO2LfEngp7L6Kyfmb5rIFFS9R9AS1NCqmM9olS0odY?=
 =?us-ascii?Q?C4az3egB8uSszHgf85bLS5N4UkfNX6dFsSelHDJVQNXg75m2m5+lGfPbGtXd?=
 =?us-ascii?Q?N+gmXN2+A+YQPwwYalTn9ZBfcUZV3M4dlBASqumNTugyBHQWmpjpAo78+RBz?=
 =?us-ascii?Q?/shu6UUYQx1dyHN0QQL8o4wnUbsoGexTIKW2EoWplZtKPi4esRBy4kL0L25p?=
 =?us-ascii?Q?Vnx6yNR4phBRmNIeyD+5+uZWw4WV6OZxGNCcAdcDWM5mG1JBKnFFAiMLZ2aX?=
 =?us-ascii?Q?xoE1POGBmQwLWVU2eO0fy0dDqBV+aLjwsmI2MFPIRRpxE7xN0H9KEKvauhsa?=
 =?us-ascii?Q?nKo4tSsDAe4TooRj6Vmp/UdHuVPdvPQIDZpWi5fnXD766yuhz5/BqIMOhJWa?=
 =?us-ascii?Q?CeRGtNa5juwxx4C167APDxOdYykG8eTr52KqXtu93mhm/8yN19R71X+VPvv9?=
 =?us-ascii?Q?lLrErhPmqmpCoftx5NOJz/Zfx4W/mFN+nEMw6UqDEMjSgdumBPaZJ7k1nZMj?=
 =?us-ascii?Q?4uZB/A5bh6snt5z0odUF0/4m+BL1fmxMSTa4ohgu4F6i5Px6ABgYssoMOtuo?=
 =?us-ascii?Q?FWvYEKXegvfIWjyQHRsf+/muijJQro8g3Kqe1VSSr6zysxZSFLRolA+w9T9T?=
 =?us-ascii?Q?2PuLCNOU91rQbquEVCj/RnAIcUall/t+am/akpedQrReIVy6Awol+jTUQX+n?=
 =?us-ascii?Q?1RDr3dBIv8baKK49HU1kZYflSp9vbGPqSGsbDKuBl3jykH5ciHXx1FBcn4fT?=
 =?us-ascii?Q?4tKBx1+dXK2RY0QGJBzIzFYDRQanjJcu6IP3cuT0cm4+39ANH+pzQjZzOWqg?=
 =?us-ascii?Q?ARBkA2v7NbbED+NrbRSYORIGS+UEeQiifM+qkUtRYc8j+L7pANu5SdnW+i3W?=
 =?us-ascii?Q?M17ZalEUlNqHh3xpuHKClwwscGjpBlpxmnqYW3R7sKQAFe6rJcQc8wI67ZmP?=
 =?us-ascii?Q?dk+B3+rJCDw/tjSdxAKnTIf403jIDBFCDBT6KTF+YNjMPtPoWj0Jgpm781JW?=
 =?us-ascii?Q?q9i+hwArKOKZZ/wCAY0xfO6y/5hRrfnBzUh+6tKkoI/6bLTRtmxYaIxqkt6L?=
 =?us-ascii?Q?IT6l8XTl1J7vDiGaH7dPr4ZKQFDk/3vbwoZAgurQnAcpR/AML+hGD72Q496i?=
 =?us-ascii?Q?DwvAayPaQVuS96dufZYUzBX7GtfMpcwQzZOKQPE9OV2bqywPWAPzwzW9ObWW?=
 =?us-ascii?Q?cUYlVy95kPe+j8bp96D0FTwg6nz4RmDqnqWDpTtNb9RPS0CC7mcD4BpjVLZd?=
 =?us-ascii?Q?9mV5PoDDsz0YIrIn2RzV5uv1ln9H6JlCmyFAntfWzKZ0t9Ies1mOHjBDsrES?=
 =?us-ascii?Q?YPIbYdOO4VGs+Nb2Yqqqma2QzYp+yjI/M1pUVbyD6pYKP1KCikvjfAIp81Fi?=
 =?us-ascii?Q?ywViB+ZO8thYmKe3bkc3S7Y2YHgmnGVqb/0ZyeiEy9ghTh/1lcDyh5zSwnxD?=
 =?us-ascii?Q?G6nPtwr8KA1k1DSk2OWzzAEdUSyUURDE8EU0oBkahyFhQLVRi8TwDLx+SYqW?=
 =?us-ascii?Q?qaZWQFP6JkIoNhRU3Hk78/LJ2yEXlW0onpoNnWfr+r7kevFn5jPYPxrSFsL4?=
 =?us-ascii?Q?5FE9Jg5OjT0oa15l+VO4Xd8w7e6hqSZW4DlvMgwiH8DxBOj9WV23fgsIz8wT?=
 =?us-ascii?Q?x9ghgj/7ZQduPxmGMqnd/f6Yq/Q2ahJea7yFk2ITnuHQIGEyuXYXpOYrruic?=
 =?us-ascii?Q?l+5DnA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 18:51:26.8692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1973c0-5d7f-4da9-332d-08de5dd51384
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9802

In perf_sched__schedstat_live(), build_cpu_domain_map() returns the
pointer to cpu_domain_map which can also be NULL. Add NULL check for the
same to avoid NULL pointer dereference.

Fixes: 00093b313398 ("perf sched stats: Add support for live mode")
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
---
 tools/perf/builtin-sched.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index b190e928117c..f5e449bd6823 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4714,6 +4714,11 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 
 	nr = cpu__max_present_cpu().cpu;
 	cd_map = build_cpu_domain_map(&sv, &md, nr);
+	if (!cd_map) {
+		pr_err("Unable to generate cpu-domain relation info");
+		goto out;
+	}
+
 	show_schedstat_data(&cpu_head, cd_map, NULL, NULL, false);
 	free_cpu_domain_info(cd_map, sv, nr);
 out:
-- 
2.43.0

