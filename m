Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7301778F37;
	Tue, 10 Dec 2024 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823339; cv=fail; b=eme/G17/5gLNbXk5qxGXLAlpFZi6E91/jrdLrLojW7FyH4r0xNZhEDGT7KhE0Hr5FpqpQ4A6TqqWaFW118S4L7WehewvUF0c65qGyhgkCfeyscF/s4ciFl4vtWROFLE8L7eAl+BedsibRYa4u2uaaySPKlzF6/9ycNl7YPm49n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823339; c=relaxed/simple;
	bh=PkNT6OYwh7m9BoNlFz1q9iFM0Fum02O2rUmZVLxo1mM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vgf57NKOJzJjqq4Ep3iRy+INlBUoqaTZ7nBWh7ofC0jhArJdMnBPoeeyU4DR/xNBRIVFvlo4HkiCuN2OSJMGd6+eR9GL4yr/AufVOKsDJjIrHMVRAGmwkOV/cF/NQKq5g8AV3mgu/mCgQ1TY0AHvB0dPbjl27fml9Q6zGiaW/ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=29lQuODm; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="29lQuODm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qa05ODRVWtF5KsS237kMEidLsHebMt9Q2ULE129qFShrIQUFRgHaaUow1BOVT5UnQ1qQoGUPA0tT+0i5+hDTmcfXv3O2X/SQIa0+Sb/ycZ5zMQKpAbsF8mqrljaZ28/9sC4Lo+Lb68G//emW3k8hdgHR0BBND+Kl2Yuf74VHj7f9tYk50Sngyhp50tlwDzT+y4gLvMb6hOtEAJYqZl7LHHSoAaqcbx30cmNV2eLvdObcfjpWNl8Ghgv6vNQ1jt+1Jut1Smv1nNgWbn1zeLxa8PynV14EQX/I2KAeHUzx72zAQsLdeYqwOnc2Et4ShL/a019x0jUtmY1XpoCTZ+tPag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pg50NUp16WRlTABDwhzW40w51FSZ/eZIlxiNDZUP1eo=;
 b=eZsBjOpRqBCgTCNQ29a92IOzJaodttJYoDPuS1I7M2J88XGxdFmWpsLc+rT6z3fbBHgyBvC/oyqZ9XvuUmSwTiQM3dVzgESVUATx9k3WpusIemUqC4uyKlN29yJKnmSEaj7w9jIikKypFFvxnV9Ax/KUgGuvp6AChJV9k93L3leiEkQApHQFtqH9MrGGYa9SebjHIs+KdC3PM6HG2KVUXlyEo/dA5AqCXKhTdM43BtXlLBox9955ifqlTvezpWuq8uSzc+RACNx8AlbWDs4qIb2nhmT1vSxmQ2AeVRYM65eZqFS1KLY67I7u8Y4BiQ7t9tIsZCHfM56RxDAn3QT4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pg50NUp16WRlTABDwhzW40w51FSZ/eZIlxiNDZUP1eo=;
 b=29lQuODmehgpkA4RaFiFyJ5mHdT7jURPxpChiOYxtdYjZoykvVKpbFX+0qigU82ueLJNqEG1chDYpqn+bsMSxlgIoVyoS3PiiUiKhqoOCY7ewP7GgSqlV3MZIwljc+8YPtfLZISeyL6TxT/c0c5FaxS33nyGSddwbniOZhG8XnQ=
Received: from BLAPR03CA0078.namprd03.prod.outlook.com (2603:10b6:208:329::23)
 by PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Tue, 10 Dec
 2024 09:35:34 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:329:cafe::e6) by BLAPR03CA0078.outlook.office365.com
 (2603:10b6:208:329::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Tue,
 10 Dec 2024 09:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 09:35:33 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 03:35:27 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 03/10] perf/amd/ibs: Fix ->config to sample period calculation for OP PMU
Date: Tue, 10 Dec 2024 09:34:42 +0000
Message-ID: <20241210093449.1662-4-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|PH7PR12MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 06fbe83a-5266-426b-d44b-08dd18fdfe8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jXIXlraSbYrzkfZgKRQtU/CxjARy3VNBKbzshomkK6Adw2KIe71iBEfIPsE+?=
 =?us-ascii?Q?jvglaWH/SxueIbcLjHmRpvDPQOxUly3ihH/P91xwckSbpHNdirfKYbwvNaCq?=
 =?us-ascii?Q?zBFpSQtYk2QMWu2rJA5Dz3fa7lgQYJmjAZ4BiF/I6hPpxJpMItM2RQmKiDgR?=
 =?us-ascii?Q?G3ddTPdTuDvJwMb0Jf2D53AbiPorzAjZl5K96mpeMYN4GY4LddsZr62l3bq7?=
 =?us-ascii?Q?TK4jcGQT82QU5xhIHopW0MWidB6E9piU4U4bD8Kovv2lzTLse/fbKCFGfU6Q?=
 =?us-ascii?Q?UfC/V42Tw05So9mqi1GvL2dFpin7C/unxfCIeNMQB3BhWRdZtcCGr7iSx+DL?=
 =?us-ascii?Q?TS8h70GnUaRlRIgp9Aysb6suD1OtmRvFwNtpKkQ17VBAo1ZLavCuhS2klocw?=
 =?us-ascii?Q?V99GNVQO/7HiqV8F5VoFVj4qk6YROgJ4HgRmO1wRdTEFUGT1AbKJPageXEoK?=
 =?us-ascii?Q?yU4Gskv8e5ZiInc0kJfuHIWO5BzGXqhMXhDnr4IKc4/EdIW51aVmzTtJeVR+?=
 =?us-ascii?Q?Y9BkR19ZPEJSvuzmCpgpDNK3FCzQq6emyJ5ocw3wpP1c9RfU8Z+mu42mAu4Y?=
 =?us-ascii?Q?johoGS6b9EaJyx5wLntRiTaK+JVfp9Q/JMmoKV/jjUE75gNQqLUJ+BitXJzx?=
 =?us-ascii?Q?wnRtI6lC2CEEvuPN54czFR+NRMALWJvsctAZ52jJaFhNV8Pjd80GbplDXiKA?=
 =?us-ascii?Q?g9qvWAj/qF/PZtGRzWo0Kv0/4//GTl3NFgqtxp1HF1PAnXG8OchlO5EYHP+0?=
 =?us-ascii?Q?ioWypPChohpeBqTag7uT4Bv6XR9k0nnovLDCQXnTAWOkzZJ5OU9ac11g7TJn?=
 =?us-ascii?Q?jHSTcX3hwFOE6XlpEcZw3Gmia9W8vOc802hDR5DlUYPRQgio2LmLz76EehxS?=
 =?us-ascii?Q?t8cNPm8qCEypjduPyRYA69Dkeql1pTvJlWVuLliguWBY/QimB7sYxK+Xjel7?=
 =?us-ascii?Q?oabd3Gst0K+9cyc/wL0keLe6Ym2eJ9eJrxc5wvcYlbEWix5PS9Z61czQuyJM?=
 =?us-ascii?Q?oTlrufAeAv/p07ZgzX7g5osz3i05j5ckG32cBFHV92Mgxou7oq/bdIDsNZYr?=
 =?us-ascii?Q?INKojEQFqkp7f9b6lMrd090uLdvXqysXotIXLS1aWbi6Rj3qbckgMrl/aTWd?=
 =?us-ascii?Q?6ccyEsW9Nc0q5WsuIsEIyWzLYjGsBvr7iIWUF17I7hUnaoDJZS1BoSVY79IS?=
 =?us-ascii?Q?WvZVyAPRZ2CuYCXmKcok1XGxV6PLBkea47Ff9a/lksW6P0Sat+A1e9T7P26t?=
 =?us-ascii?Q?jq8m5QbrToNV5pc9bhmJF1Wdybo32inPHI5obyodrtBKonB6Qb5QPa5Efyc+?=
 =?us-ascii?Q?gCpjSXQ1YRx1I8RyPo1JWw5whPxssO4Fh3J1yJC8AvLgdpCrcSFfLH9FffHy?=
 =?us-ascii?Q?zpQHV6BWRoYuJG/FckxQQLTRSEqnkHs/WhK+rZfP2tE49sEwpA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 09:35:33.2066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fbe83a-5266-426b-d44b-08dd18fdfe8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8596

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

