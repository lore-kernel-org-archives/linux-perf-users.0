Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4621C82E2;
	Fri,  6 Dec 2024 05:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462276; cv=fail; b=Xs8j57fN+/Ta3OmArjHEFCkbSf1on+GLU7l75gNKkoKylGIeL9EN2YCekFoXPYV9lTXeb1bPsdwmD6DM44woGaTLKfHfp7O+oVPMqR+qOXGu7UcGbi3ijqWPYI8wYQPT8CVbY/zhXAouJv28J3ZgJumuTDNZhjVhs1iEetSFZ0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462276; c=relaxed/simple;
	bh=UzwC4VpHnJDDchJLiB7sDHAbMyzsykXLcREdlNClAOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMQZ26tbkUkWStJ27oVd7W35DfJvCI2pevIv58Li6QSVCqepJNr5RqlEuV5CVfkCQTsYIilEp96XyXf4BTr4y92bmsxQaxIPz8ZDBaVeKN36Xh7BFefEPLXinLMc7KroD3h0YxlkJ+sbnkS6N9Kgslvsjm8C+yazm8tys07dbFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yjnDtSc3; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yjnDtSc3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZ3E/TquE2ERNOQtfNBiJNbbwn6IxG6Y8+3T4gV9a+cTmrm43xyFGQGZBJgbcwv23yOqWaDnJg71gDmp/dRG+sG7MD/qjHv4Y6aCrZa2cdetSJZRLv7eix8mXbAsglnb8Tw+gJE5vy3eKx6iMGCjJ+/tvLW8DC8djD8DTi6LeqGQN7O7PA8P3vS0FXt3ZnB5CSeuYlOwop5LxUAaufocJosuO5wcTpA3N43my4akH7zxz1orPsj/GSyWus+tXKfI1KDgpOkRCxz2jg3M2deemoxcQTSK0y2xkO+3eT3d8CWsx9zpyRDP1heS1TGMsFc0+V9NslqGdhdW1CsPeAN0HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU8r1uZxPz14AveNxoIyBB8XrIWkoudRcnM2JEarLEw=;
 b=NMy2IB8LbG4PoiQN3Dt777gUGlBbVLQEzjExfBB1jnAt51FglFUFSCGezlcr9MkwoyalgpN4AsBPlz8A9gGz+tonF7uGMkSJ+tlNwOmF/TMXh4kHTzoY+WvhbcEyfZEHN6KIX+/4JUvdeArNbR5btWK/ZrS6bdhluXxc+UkDZVJ2G5VeYp2mCdQzdScZRl0A6llxzGRUOl16TA6R3FM+I1Ewz9GDhxP35N6zq4xW97ZbEG43xZMVII3PgOC168RJfOpMp2EK5Q4vZ3v8z3qQWO1PZJWgNbiSPe7G48CS0cNcBHOMa8D7ieDL0WizDWtGg9ansjTRXsabugpBH9/U3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU8r1uZxPz14AveNxoIyBB8XrIWkoudRcnM2JEarLEw=;
 b=yjnDtSc3S4DPcZ/sEfnrHT6vVIx1OVIXo0D+qhu1N4/U8GPNwqRy095MnwPbMrYRBy3a7H8ddhmyNM7X+bZ9128sR3fz1GG1AsnFM1QUUj97xZkZ31WLS+7AjxrZY+o0DuNENhkfwQCadmUI2sgCYDqTpYXjI+1EhvIjdCoAHQM=
Received: from SJ0PR05CA0092.namprd05.prod.outlook.com (2603:10b6:a03:334::7)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 05:17:50 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::ee) by SJ0PR05CA0092.outlook.office365.com
 (2603:10b6:a03:334::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.9 via Frontend Transport; Fri, 6
 Dec 2024 05:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 05:17:50 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 23:17:44 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 03/10] perf/amd/ibs: Fix ->config to sample period calculation for OP pmu
Date: Fri, 6 Dec 2024 05:17:06 +0000
Message-ID: <20241206051713.991-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206051713.991-1-ravi.bangoria@amd.com>
References: <20241206051713.991-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: adb10e14-d604-4252-dca1-08dd15b55461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j75kUdDFS/GbRmsavgHD4taMtbFtc7wPFBQQ7uapqr5sUp3k+c7378I8kuGe?=
 =?us-ascii?Q?8E+8PQMqf8PqCQ1QtGCSd0a07E2EyhT9OT+7QmiKFAbqF6c2iGE/z8TnRToe?=
 =?us-ascii?Q?H8a5hmtGuYdvekkbK7IogtV9qjDnYX1KgVyyigHw6tg3vv6gy+vu1uG7vvz4?=
 =?us-ascii?Q?KyoHT4JqopaL8LR/KQI8mvJHmqqJT8wIfDrCQwOXu7Fli0m/U9bxGW8F++QB?=
 =?us-ascii?Q?Cim7PtefmLyuVsrCkgOIyNY1nz0FbvSlYqzuQzIjSR+wle4D7+eTiAGbRMW0?=
 =?us-ascii?Q?899okXeM5s7L/ZHAY2daqpeTsikpj1MvzjKghi6X3ptShFzSiUkiytFtCFuB?=
 =?us-ascii?Q?fdbSBwzFx/ridjzQUQ4lLcoYmhqGHF74H8PvVnBxOo0PfT2IHYmMkqy309Y4?=
 =?us-ascii?Q?7WKQS4fvKxh7CpN+E+82uxLaDZhVFYeL5f95r7eKfQSby0qp35zYKXHcahGh?=
 =?us-ascii?Q?7J15OP3QNNMVvKKnK5XdvCJeh1LxjVWRsnb616tqc2nQ8HO8tOU6P1LaUU1w?=
 =?us-ascii?Q?oQoUEyaPWpX7kA602CygQvikIyODMuyZ8VT8vH3epAHZR+iNOunxuofF4vWK?=
 =?us-ascii?Q?7Qcs5v0VnECkOY4tXFCjsIf9EMYWII+cj96WZgile04OWPjjYqEOopAKASme?=
 =?us-ascii?Q?jIJoL7eccP/B+hP7CEOemHXMozXHmWbVQLuy8By46qiRJWPlPIMWiw8z5hBz?=
 =?us-ascii?Q?ZmmgA8egaBbtUCT9lOGnLn28OqRVKZrM5b6MKRVc8xfu6XiHX/2avd7j52x5?=
 =?us-ascii?Q?zNxV3Ee0AbFuSCM0aM0o1ZzEuS4PMq//imKJjHxLeet2i3dwPYIyzGF/QZVX?=
 =?us-ascii?Q?4kYIuFW38WsDKrjB89UyVQmmOPov00kN93QdhMSpQftEnwV9KSePxqBmA3Si?=
 =?us-ascii?Q?CR3vFjwamZwi2fWVKWP50oN6OnDX78SEmVyhbC7U0FcsStmJm8UAI4wkKkR5?=
 =?us-ascii?Q?bqi46XtufvV1JZBUppBzmt70CKyPvN6lw6o1hleq8+TPdxTPwUyYxVJYv89g?=
 =?us-ascii?Q?IBnSv6vI8REZHXzDWZxTT2eW6/nDTdEvIViyhzDKd1U8Df2LVrHGl/BHCk/t?=
 =?us-ascii?Q?MLQ5p68ceY/lI5DGSMcJek9FNbkduT2d9auc6pHvW7RWXokUjL+RzDU06eyR?=
 =?us-ascii?Q?6H7/0wyle5KbgOWRcDQhwLEdouyODBz7+I6slEakqGoWIC8ovU0aMNockbrB?=
 =?us-ascii?Q?FLIWzEl2g35UggOhvhZBDPEmvoQKZoUcsOpf1qHWK0gAQQ6xGEmkJbvno1vG?=
 =?us-ascii?Q?CLaDZpeSEbjI6scvInOsHy0LpYQWxmFfrKgsendUCPGpbb4seqQN3CZ8p+9v?=
 =?us-ascii?Q?C0bNvMyBjsrtX7rfpDUUKj77w4974fkkGDEpuoK9ZYBAu+WXKB3qdp4Rms/o?=
 =?us-ascii?Q?eDQ044CGfh488RsC5nsLQJVq199qM1uVCD5PhOytDqyfcx+71iQk9PBZP4Nk?=
 =?us-ascii?Q?O0UuX1ut/EDLgkzBNTb9OTGEfJfb+6p4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 05:17:50.3879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adb10e14-d604-4252-dca1-08dd15b55461
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239

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
index 484606a9bf6b..63e1c1c11727 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -268,7 +268,7 @@ static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_ibs *perf_ibs;
-	u64 max_cnt, config;
+	u64 config;
 	int ret;
 
 	perf_ibs = get_ibs_pmu(event->attr.type);
@@ -300,10 +300,19 @@ static int perf_ibs_init(struct perf_event *event)
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
2.47.0

