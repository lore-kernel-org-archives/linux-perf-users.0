Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF4143C72;
	Wed, 15 Jan 2025 05:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736919976; cv=fail; b=iPJvRsXiEkZ8XU3mOB1MxVbxb31su0Rj+voVtKHD2avO7zdkRSXcrPikmkDWz0usxXJoGQ3ZVYgKFdqWo+6QGgmD3DrFSWznLPItl+0BWxzh9LC4clxxNKM7o9vjz1G7bCo6eYgSKc1KyOZcdwh1Id4qiA7zdAcIRwqaYFKyQQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736919976; c=relaxed/simple;
	bh=PkNT6OYwh7m9BoNlFz1q9iFM0Fum02O2rUmZVLxo1mM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geF3UzoeTWcrYIucxbfXjM+uoajHfbu+sgxU4Xe0HuyIDoM0+c3lNICQpUWcXaAY6pZSE76MC8ZQ/8ZSRizuLfMppIfjEPhWW8TCbk2RteDjs46XQ2u8NRmovUTGACQWllua5sF65K/ZT9jRWD4Z+PRsS0fnNdpAYdilgKzASOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5iT2B3XM; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5iT2B3XM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WU+0Ra7aVa+mKgiwVkcZZ1dGzCNInD46na3W4kl52piIkKYTqC/EMeF6txe5jlQoQRqKGFuiWCGJHPsK6qejTAb8mnX32leneMipl5lHX2wVv4VAJNj+UOuYI0OamDtPewOEqvfa2O8KTKugSb9JoxrZo9W47528aZO5VpoBjwqskAP9O/Ds0RX3Bjy1I4bl7WcdUzLrM57+qDXxK4MuNyu37diwRtQi0qjin9jN6gnSZJkwii3Sbzh9n+beCqdhXqkUWmFGxTxFwkSS3OXKRDeQtWA42OeACbTVvSSASYo/NB6rPvESZDZ+Hc22gRB3IJqGoGW0+76ATm0y4QwW6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pg50NUp16WRlTABDwhzW40w51FSZ/eZIlxiNDZUP1eo=;
 b=M84JJhVtomwzqhmFHlvgpFzjVrIpU1Y2QO5lt9gAIQvfQtoaMklaDig0B4aenActC9MwHWqGfvx3GIu7nLaaNugUnuBdH+fiTkg7VDftgfpMlzijkBllYuwnCDqmxHtr1pr7tSsC4wYHN/UdX2Imx7WbJnqIAJhApNHHzch4CCgWmd8G/9LloewFCvXBXuRv1/6DG5j9a2fImx3YSHfQEos9J06PXmTVfR9CH6xWAOjYePlHNnKQ+Ma778Ds/9DrQBPyeXx9PoSVozNmZ2JlS923sb81bJ1ehnvtVO4HJlLzPDpnEIOSuKTcBYwOyBoeKqg7I3PVHQtw/I7fRPk/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg50NUp16WRlTABDwhzW40w51FSZ/eZIlxiNDZUP1eo=;
 b=5iT2B3XMMwLIa1/ymCE9kzR5t5qpIo5UbEl+HYSJ25ryaksnVnnDGKOcpG6ZU49jZ5BNFXpo5K3bX3ROuLrhLvChUTMUjpH8NiPXTOtcw1YGQhymfFw/Qht3vm0Bhg2IgpBpNHkOkH14rXVIPc1fJQ5nUp9BOP59vX7BXhLFFeA=
Received: from SJ0PR13CA0228.namprd13.prod.outlook.com (2603:10b6:a03:2c1::23)
 by CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 05:46:12 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::71) by SJ0PR13CA0228.outlook.office365.com
 (2603:10b6:a03:2c1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.9 via Frontend Transport; Wed,
 15 Jan 2025 05:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 05:46:11 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 23:46:06 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v4 3/9] perf/amd/ibs: Fix ->config to sample period calculation for OP PMU
Date: Wed, 15 Jan 2025 05:44:32 +0000
Message-ID: <20250115054438.1021-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250115054438.1021-1-ravi.bangoria@amd.com>
References: <20250115054438.1021-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d0e02e-e4a1-4c60-0719-08dd3527eb24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UsO3+4BPMCMHVJZ44ojdDhCb2BG8eY6zbPRB2BM7BxuhbEYdzSQZ67tDWWew?=
 =?us-ascii?Q?iRoohyLCxqd2i9Tty6oM2bwb3mdoBGg2JHeumiYCLZbJHuAhc91wxx48z8vT?=
 =?us-ascii?Q?HbewDFZiX3/VFfS9skKkIArf1aB8NcUISfTp4p3RPXoy+MhnbVswcVDOqMsS?=
 =?us-ascii?Q?we2ebfD6K/blCdBtdP38+7Zskd4NIpfv+Z9WZX3r7/1KSWRzfVlGxfB8JKMA?=
 =?us-ascii?Q?Fr6nFlq8FTKBRk1MIyeNtVFlgOSUc9ZGV43pZdSy6EiqYCLvyvtovStYJ4Up?=
 =?us-ascii?Q?nYRYHE3sYVsYTXgwQDnFgDQMkt8qzEShZxWVI7kzdvUWcEqWz+EFK6N6fVeB?=
 =?us-ascii?Q?ndodKNYxbiMs8bhtmIOVt5EHHqTYL0NtigiuY4PtmlS0BziaL37zAc6bHp3s?=
 =?us-ascii?Q?yFoCX+B0yD7KsWKVsZpNgrLx+OjnlYpmo96CDVrNCd4wb5z7RAeFy7kqTCmX?=
 =?us-ascii?Q?GxOwRZj3EGmQaT1MRM6KNv2Sxc+TmLwipF7ABFpJq5kkbJideqjc6iT675fx?=
 =?us-ascii?Q?HQQ6lbFImvCwXin+wTueiNsIRVyA279Qrsr0ufLQPVDQcDtYSB60+TxHsO8v?=
 =?us-ascii?Q?3HNFMkQNO+6wah/J7QhCYDPuqjmEUeO+tb6UeVr0EUuBDqw1WOCVpQB4Ka88?=
 =?us-ascii?Q?0yprUXdg0hRhFExt/U7eD2YPGVu1Nh749SiqefVsLuoYWqUA0YKBaMXgZPzk?=
 =?us-ascii?Q?iTM5pmTc6xWk9LTG+Pvkw1730K+cMk+pfNvjJSI8pVoqKTO5tC++q8JXbVDV?=
 =?us-ascii?Q?VD34IdF/HKPvLyN3Mq71OHzwwDdJLCpyX2tHR+7mSIWYnMxM6yQ8ZmIyHbuN?=
 =?us-ascii?Q?ZJ+wCTFMMYeXt3m38/6oshLcQzVSuGKupfR7pGrWelde/Korx43y72zP2Iok?=
 =?us-ascii?Q?d9fSnK1rli492xDMtemYKrxaK5QtYcTbU/u7aXFZvrdpJVl2oVMsHE2wJf3L?=
 =?us-ascii?Q?djaTx/ISMDMyJQPK1jucVYiE1GGkhkxGws2QbwuRfFIHAQPegRWlH5FfqYpZ?=
 =?us-ascii?Q?3ONUl2ngEQx1VAqwm75aNA+QVt6xcfsNmGw5pScHIGB4Fo9ewJTTtFaoLiN4?=
 =?us-ascii?Q?8JnKYJ8agfjB6aFVvMD7OGM5ocgEsVrI99dXVIZywy5/JghXfvK1RIz2FRT6?=
 =?us-ascii?Q?4uFHgRbTBMrQEgTc/KOh+6z4M35BmkZKTLdrFIS5i9Nf6o7k6BpoGiMHlyZw?=
 =?us-ascii?Q?teqJcj+1X0H0bBC11XYRoS1aVa6pkA7eCAxnkKktxlXBXLk/GGxXJA3464oR?=
 =?us-ascii?Q?6ArBack++mgDSct5//DdvB4C7kxBQwKlLBEyNpAYDQi4yycAOnrUoxV5vFU0?=
 =?us-ascii?Q?lBgWMVhORje35iPXY5ciKKJr1zfjcFyeJHLHcpY7oD5KgLP/olJWtyo40pYS?=
 =?us-ascii?Q?ki0/6OcJyPFn91KzH8kMnF94RWYCanfU4bbCnbxf81ehFO4F9UyjBEBUFUqj?=
 =?us-ascii?Q?h0hiWbutSuvgzsabTkcPx5Hs9+cpTWd2LEEDXocV79Y2A8Z2BZ0T4X8sUoFM?=
 =?us-ascii?Q?KaD832S77lOY7+w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 05:46:11.9919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d0e02e-e4a1-4c60-0719-08dd3527eb24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364

Instead of using standard perf_event_attr->freq=0 and ->sample_period
fields, IBS event in 'sample period mode' can also be opened by setting
period value directly in perf_event_attr->config in a MaxCnt bit-field
format.

IBS OP MaxCnt bits are defined as:

  (high bits) IbsOpCtl[26:20] = IbsOpMaxCnt[26:20]
  (low bits)  IbsOpCtl[15:0]  = IbsOpMaxCnt[19:4]

Perf event sample period can be derived from MaxCnt bits as:

  sample_period = (high bits) | ((low_bits) << 4);

However, current code just masks MaxCnt bits and shifts all of them,
including high bits, which is incorrect. Fix it.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index bd8919e7c3b1..f95542b75b91 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -271,7 +271,7 @@ static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_ibs *perf_ibs;
-	u64 max_cnt, config;
+	u64 config;
 	int ret;
 
 	perf_ibs = get_ibs_pmu(event->attr.type);
@@ -313,10 +313,19 @@ static int perf_ibs_init(struct perf_event *event)
 		if (!hwc->sample_period)
 			hwc->sample_period = 0x10;
 	} else {
-		max_cnt = config & perf_ibs->cnt_mask;
+		u64 period = 0;
+
+		if (perf_ibs == &perf_ibs_op) {
+			period = (config & IBS_OP_MAX_CNT) << 4;
+			if (ibs_caps & IBS_CAPS_OPCNTEXT)
+				period |= config & IBS_OP_MAX_CNT_EXT_MASK;
+		} else {
+			period = (config & IBS_FETCH_MAX_CNT) << 4;
+		}
+
 		config &= ~perf_ibs->cnt_mask;
-		event->attr.sample_period = max_cnt << 4;
-		hwc->sample_period = event->attr.sample_period;
+		event->attr.sample_period = period;
+		hwc->sample_period = period;
 	}
 
 	if (!hwc->sample_period)
-- 
2.43.0

