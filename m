Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4190078F37;
	Tue, 10 Dec 2024 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823332; cv=fail; b=Z2sGeZOTCeWFRr8kFAIBKaCmLWpoor79NLpEhog5Oi1444NqDFIFM32Bf11hr+ViWZXMp6G41d9iyxzfKT1Vyjwjm+MHPddN9gjIxsrs9E2wbMxDIICmaXsGGxw1X4Hl8z7lhzqdwXMdK5dDS/vK62M9iEjUJ4ZXNHorAcdwW1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823332; c=relaxed/simple;
	bh=TRB3+hLi+ggudg0JCZ+912Ji1H8WrzYPFfUcdTjovXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSvMGRQyNuc66KVq5EU3VkV33gvV49IblHcM1Kd30xhSZuxC8g1dDAOLSuWn8DAuh6Cg5rfJdnlDzkeb5e2ts68mjOnSvW14l0RAIldXZa7B6iInO/nXpfd9KfNKpcjwu3dkgqE0NO53c+B+/rqaMmyrliPnfgiMzBjEqJmM5As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Umaf0Ana; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Umaf0Ana"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNpOsJQ8rTjQcEHRy6EsQvdk/8EgwyBIGlEC0piETQNx3HJzo1+geV0JP0I8hMbT3/qZE1Mb3lK9RR2PMmoJlQFRHCfS/t7PM1OyxT8iyCe4qWgSwJ90msC+QMsrtuwb3MPAqqPZZTXJD2UCfzkS9WatNfxZpOG8JUVCgzKbFsexgXtemEQLVlLlsqrONUCBe9irKHJysaU+oYmqoLxJFkpUIwI3wI3F+3c8hTx63m2gVbdnrNr0g4uo3jqCmpXwzJDNFFkmbNlZBIVfz9ojvmiJ3JnIw30H72xO75OyWAYSH9p/JfmJI1NH075drzjdKy4J4YaA71C6KoJHLVoc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXcI9ACM3+mQ8XBMssEZPaTlM0c3fPenKr5075P9MAs=;
 b=SkgGUrsBKmjvcBJCX1Q5chfFceGaxcYDzblEXSiMRhnKF1Dp/xmsTI3hYcBD6zvCpL4U8J2QDsMzgrWXhihEn1HVZJGF81i3xQ2g2bpwhqknpoCFIa9xNQa32sn5QqzgD5YmkHNkptXBw0wU6vhIZdW9PHl6or7WsVk437PK/wO7RSZWNEK4luPFX7x3K9CPsrVI9Selki7rtNOny5vnnQp7ecP8K3ogY3ynFFNXLxQ8G4iokLGo1lTVhpRO0Qk25K8WXv/G7xd5cb7vPmOsWTC7O0dxWPWkxCwCvr2qpUCO6DzO6gWEDr6NIzN7tUbnvN7sJ83vmT5614w395cXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXcI9ACM3+mQ8XBMssEZPaTlM0c3fPenKr5075P9MAs=;
 b=Umaf0AnaDM29Zk8VIJk3pNAHJy7yK1U5RBvHXnLe3dQ6XZ7ZJ6m/8fFIUkcaED8uVVo2DFtLPzpHXaSXwEUjNEfMuhquY9BoU8UqUvBFPQ/hBsUUGI1VcYMAK0qitbK5XsTjWv9cVKH4kp+8WH9f2kQz8cGZPyamPOMUnZ4tGIo=
Received: from MN2PR17CA0012.namprd17.prod.outlook.com (2603:10b6:208:15e::25)
 by CY8PR12MB7338.namprd12.prod.outlook.com (2603:10b6:930:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 10 Dec
 2024 09:35:28 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:15e:cafe::c5) by MN2PR17CA0012.outlook.office365.com
 (2603:10b6:208:15e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Tue,
 10 Dec 2024 09:35:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 09:35:27 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 03:35:21 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 02/10] perf/amd/ibs: Remove pointless sample period check
Date: Tue, 10 Dec 2024 09:34:41 +0000
Message-ID: <20241210093449.1662-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210093449.1662-1-ravi.bangoria@amd.com>
References: <20241210093449.1662-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|CY8PR12MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c57a2b-cd40-4ece-9b11-08dd18fdfaff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WUV0B3h/WiHwvgMBVr8rpEOGmSOFuUq2JhSI+EtRBsXehSWPLrtF5VVwGbu7?=
 =?us-ascii?Q?6wzYitiyX8MB1M71aSCdGaKELxUmU78GbKCfRGGFlk8naGrumwnHze9kuq7i?=
 =?us-ascii?Q?nSCY0VZb1GE0hWRsEhCtMOsAJmpZJJWFYjaHu4k8EUMoR6KEZpF2g0SHFxOd?=
 =?us-ascii?Q?tn9RHZUNEkpnn1yZ5KXlw+EjbJgtXIYxnzUOyhecVbRM2YgKpttC/PzeWmr/?=
 =?us-ascii?Q?7iCf1bM/OZBW5PcQHD0MhcdtMQRZAdKI4H0ksMcaUYOAQCQexDN7dUFgmcrn?=
 =?us-ascii?Q?+kCd6cUwrtjZNnt9nxlIUTJF3x1v0TmxIPcz6tbR6O/9wUKuNd86rNvw6yzB?=
 =?us-ascii?Q?jBcMlWXDCf2eHVwhOh3yVptDIqDHjt7suubNVrkMlUN65d4eYsYFaVLhLym5?=
 =?us-ascii?Q?Oph9sMTcvSWXgMghfRHff6NC80PSlcbXGHkhIXGnTbosOytLUN6dGK8XgT4o?=
 =?us-ascii?Q?hLJhIU0iAGjYrURBLNKf5wlDAYA30Om2/1hkiPSN3Sfev8T7K62o22+/NjVm?=
 =?us-ascii?Q?AUl5uxdyT9ujprTO+XCtfRRhXdfW5X21Qeyc78Sqychc6Kfcej2Yeb9VkD2/?=
 =?us-ascii?Q?oMFihfcHoPbCT12Or4chiVRlmHgyHtqkfFusrUH6RrmXu4crrxeC2RsNtyS3?=
 =?us-ascii?Q?UNxdQE9/7UuEM3h0eoPU7+hUATTDYZmvxoqZHKmWC9G9v4GwL0YN5eiTPns4?=
 =?us-ascii?Q?sglhmEWiPR0Nlht9gmWDWnTQ+im0oO6TOgqn9Ij8FQGRMIUSnmH93yJmLkfp?=
 =?us-ascii?Q?gVNEBzM4KMMZLdwg8pTF/NbHVjqsvwVpZeR6gzhOZoaLnBgnhVbBY+kO4JLl?=
 =?us-ascii?Q?hDUnZQGLacPbkL80UFrxP/FLHoGjKCg1Fry3N5tPMxIq6b7of8DuZTXnkmZk?=
 =?us-ascii?Q?9xGDm1JbDwYxxqCCinDs/nLqislPA/cYpSrOBsJ6N0wWivszgYzU2F5nqCZR?=
 =?us-ascii?Q?cEple5pZUfwQHju+csBPVNheCe1vezCxYTiaANmgz/y4Bs5Ch13NXFV8manE?=
 =?us-ascii?Q?j6L2htYmv14VxKc/mdONFmp9zbS6/C5I57pXDVUdTsxHOUGkYV0Pc0xbBhU4?=
 =?us-ascii?Q?dpTTbT/0ZG8CjQ2NnwO44mjwpTUaUZzytWkmYZWhJ+cs41zM7eOT7NMqtLXN?=
 =?us-ascii?Q?W6tzdbfFUvw7aFCL+zQk6Ec0+Rjx6J9jvQtYGj+WH7c1rfJ16KVMOg235azX?=
 =?us-ascii?Q?UdYHidVdNtctEEDfLwN+OWdffWs8cUgfT0ekz+wQ9XSvjgzkmRl+B/sRy3lj?=
 =?us-ascii?Q?9+FBtjDhGGiKTdG5cqKkZ57PoxbWCPtYbA1+gik+iGG8aoOFCR8/TO2lCnik?=
 =?us-ascii?Q?qWYnVYpyhPWad/mgVKjZjJi0lvIqWv5agwJtyF42ldD/HiZsL7rjv9dpcj0Y?=
 =?us-ascii?Q?jOI5KK+1dspV3b5rcCBZWed2oOH5jzdFgKEkAOuLJzxtBc5ZEK2kV0570ALI?=
 =?us-ascii?Q?TWQ0+NKeoTNww6uc8gJhcXIcUTOI/Gym?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 09:35:27.2701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c57a2b-cd40-4ece-9b11-08dd18fdfaff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7338

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

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 4ca8006d2221..bd8919e7c3b1 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -307,13 +307,8 @@ static int perf_ibs_init(struct perf_event *event)
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
2.43.0

