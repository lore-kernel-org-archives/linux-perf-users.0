Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C25745F2;
	Mon,  7 Oct 2024 03:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728272927; cv=fail; b=k7ch1g+dnQDQ6sCxa2ZmCNQPlYoOz9vLWaz1VDTZf1HHKtJZMwrh8oBHavK9SmxDlHB+q24RjJhJm7zUn5UpQcsisa5xrxnpc+YrTzIOSHKuqQj59H86rw88RGapWj75BKH8+p0+feKj+7xclz0aFrS5zOqG52l+4wSGm9RJ9EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728272927; c=relaxed/simple;
	bh=eEZpQ5VBkBDWbdwNztop2NMHMcBjpi5MTSboS7x1UAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUpoV4OOrSWUdgfs1BF0VSUHRGY89QAwacpK9Z0/hCKWwI2hYkr8OuFdsPtaU1mddot4pxyfuWoYX5zCZwtuko2G2Jr5BMQbBWaW/YODOwqjDk4OZXy1w/gwrm0JJl+GqI8z+76+O8spQAj1SnkaeKm2flXK318NHHirNHQ+g3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pb2HcqqP; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pb2HcqqP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBJLfJI9pdQQIio/CRBnsyCgC+MxjK7NNuq6E3t3fMetK1n8U3o+VvQWsiwUhGvCkxKuXBGZgwnSnGZJIaUo0jYgjt/24OjKm0snziJsWrNFX52touFm2LbHuqwDx7CWY6n0KPiWLRFsIq42zkYkpE3Arm1cQhnC5LmXDc17/mozQqBJk5XVnVKaIi5XH5vxfAHNTMIheBUNwcFZv9MrXnNnI6yFgfY4t0hHbqzYU8JREqQlsI4v/klVZhyCRMQy+2Olye4FOHyoeTYi4UIJDCQDpfK+eGvYdUnpksCswr1jU9YGrIrF1epLb78BB1c7sQCkde2W1/+AZ6lZJ25bNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtbbZIXepAZjd2/gsJqN0wWz3KAxGYgcPRfEax2ry9I=;
 b=NCjdD1+UvhkK+yfprGZiHpm6YTgoEqmXAIIlzrt3fLvRtY+WHdh2h3kpmBYcKskiXZOateKW+NGSBbtupriBJZUv6zPfKmi88Jf64ticxkhpXjXye3d7RWqoM5lylapB3XBwulhQQgUVg+5FCHxpPg01yEt4407cv0Vn4s2sT0r03RTE3U8gz9W3TnpkJx9dGbSir2q9metnOxP0buktS6VthbaKDnUozDc3OeyJPajjDV4K1/V8pVHPpQKuNHCzsn9rRvO/EAYSN7q004d3X+LBSlm6XRyYHoW4b1VYsLB3tT4t74wNEheRPkF5CnJSHXuUO7eX5E4c7gyK36o/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtbbZIXepAZjd2/gsJqN0wWz3KAxGYgcPRfEax2ry9I=;
 b=pb2HcqqPMonfX9bx7fsgvuX8CvGAi0CIojQmxZJz4rEs6krvyDBv48KB2mae78IzSLYPUZojmzEVhep86DksmGEHGtfIVxpSjf3DJYcVx8A5Sx76cav0ozHGeFtYSjHOUnytOsZBSAJJWmiLHTb1SGUDoeGENWpCwvpOKvJP4nw=
Received: from SA0PR12CA0028.namprd12.prod.outlook.com (2603:10b6:806:6f::33)
 by SJ2PR12MB9241.namprd12.prod.outlook.com (2603:10b6:a03:57b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 03:48:43 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:6f:cafe::57) by SA0PR12CA0028.outlook.office365.com
 (2603:10b6:806:6f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 03:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 03:48:42 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 22:48:35 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 2/8] perf/amd/ibs: Remove pointless sample period check
Date: Mon, 7 Oct 2024 03:48:04 +0000
Message-ID: <20241007034810.754-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007034810.754-1-ravi.bangoria@amd.com>
References: <20241007034810.754-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|SJ2PR12MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f946cd0-eb8e-47c8-2c78-08dce682f01b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C7Jmi3rP3gU8Ikr+8TTRrJ+/HBM/0mas2bpUK9GwwxUgtgHzpB8XvhTcCqnK?=
 =?us-ascii?Q?D3TwRdMlmOGK5EhwIku5IJJ5RSDYSHKTYuyIN1yyGSDYn0FRNtPF+ersFjNa?=
 =?us-ascii?Q?4Eb84VZy7p9KLtKtxL1T+7HtdVVyEohhQkYlyoFNGvIwzGmqMt0J5CBo6qcd?=
 =?us-ascii?Q?AckDS7CtrN4SLtRZXWMyucgk4VPSoZYXaIEP7XgrNcyVdLj0hysajMnNBqbB?=
 =?us-ascii?Q?Bf6ZhrcRvZPtwFetz1zQZ7nEt2cc2bjUlFRwilyHUj2KXVe8AeM+meF0Wh1c?=
 =?us-ascii?Q?d+8BKCpy7oPeOUehExBX2RjNes1OPMCQeGdmFI2eeT9DsoApmYh5+bWbMkBI?=
 =?us-ascii?Q?aWi57yEGHTkqc5QmfVET9IMkMo0ImvO/rBY7VbL+U2gB4T0UZeGKrufzBHcL?=
 =?us-ascii?Q?IJ+YbLMaqy0LLGFpzAIWzyD5y9d/WEMQHY731CzuNhFFSX0qvPUb8vh/Vs6m?=
 =?us-ascii?Q?3/qoEtvgVoS8coOtx67A15FC5O7JLWMY+XK6fJH9dCzlURR9kNlH4EBxFFvh?=
 =?us-ascii?Q?CY/Aq7X7DrEYu1PKwuU5hx71Tgo23ZOmFiePoXh7OSblgrYuhvBpFga3WP/D?=
 =?us-ascii?Q?lil7xPBL3cLzkpVp52ep4aCISGG0oA79S+9LhfpbN/GlZxTZA1U+CMnZq+Jp?=
 =?us-ascii?Q?G3G62QfFf54ECFchYZHp7mFFVl/XtSX6ZeHdFvHfDCQmWjkXhJfMiwnUTvkU?=
 =?us-ascii?Q?tVFxd0ppxXfRCmCELKaB0ByLf0DAm7SYbBjjox/yJKXM5pMyhdbBPL5SfEJG?=
 =?us-ascii?Q?xkXVT/7cmjUq2NZVqEZhl0iOf/wt4TPJUiMgzZTKd1H8w48r5BN0kX4DNC5F?=
 =?us-ascii?Q?KoBKr/I9CS8JyP8cnzOW/IkNOp5UI3W90IgNtE+eCngs8YTwicsaGFhLSScx?=
 =?us-ascii?Q?EAKdcs8BGLFl2szY2pBI1D4f21wNC48vZxRrT89yXTu1rCRRxZgfo5L2A0Mx?=
 =?us-ascii?Q?LwTr7T1/IUApiq9dMIy7JfENDwMi9EjbKjJTQ7U10sA/1jmWczBaXGc4vFJA?=
 =?us-ascii?Q?1Lx00gFuUhTdAU7FZdmGJwClG9YcLGcfsSIy/a7GLqynXnk4aTgMOXivDdDe?=
 =?us-ascii?Q?2a7NqvgBEesJ4hYH35cxqcFdSOb5kzZbt4UaYCxYon/CJsCvKVxgkbn7eZ5A?=
 =?us-ascii?Q?yAjWuV19CbJB8R5YhQVGi8LVttxc/83h46utZxGWKqynVE1D+GRb6fSrvWgr?=
 =?us-ascii?Q?JfGhIvmktPiCYt0Czlwkc+yt4zImDKsv0fhZLZ7Vwckq2LyCWsEnwU84Q0fH?=
 =?us-ascii?Q?odtYBvyIcHZvOzAOtim7YsuK+ZdUI63T7Ia8G12rSh7R5lBJRQJzzNcqc3di?=
 =?us-ascii?Q?PvBqDX/UwngV3R3cKKCuZaG0jXlQQB4mJn4XTEtyCEJ1grShfD0gXOs3u4OD?=
 =?us-ascii?Q?GmF0gQQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 03:48:42.7436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f946cd0-eb8e-47c8-2c78-08dce682f01b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9241

Valid perf event sample period value for IBS PMUs (Fetch and Op both)
is limited to multiple of 0x10. perf_ibs_init() has this check:

  if (!event->attr.sample_freq && hwc->sample_period & 0x0f)
          return -EINVAL;

But it's broken since hwc->sample_period will always be 0 when
event->attr.sample_freq is 0 (irrespective of event->attr.freq value.)

One option to fix this is to change the condition:

  - if (!event->attr.sample_freq && hwc->sample_period & 0x0f)
  + if (!event->attr.freq && hwc->sample_period & 0x0f)

However, that will break all userspace tools which have been using IBS
event with sample_period not multiple of 0x10.

Another option is to remove the condition altogether and mask lower
nibble _silently_, same as what current code is inadvertently doing.
I'm preferring this approach as it keeps the existing behavior.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 347353b9eb70..6b55a8520166 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -294,13 +294,8 @@ static int perf_ibs_init(struct perf_event *event)
 		if (config & perf_ibs->cnt_mask)
 			/* raw max_cnt may not be set */
 			return -EINVAL;
-		if (!event->attr.sample_freq && hwc->sample_period & 0x0f)
-			/*
-			 * lower 4 bits can not be set in ibs max cnt,
-			 * but allowing it in case we adjust the
-			 * sample period to set a frequency.
-			 */
-			return -EINVAL;
+
+		/* Silently mask off lower nibble. IBS hw mandates it. */
 		hwc->sample_period &= ~0x0FULL;
 		if (!hwc->sample_period)
 			hwc->sample_period = 0x10;
-- 
2.46.2

