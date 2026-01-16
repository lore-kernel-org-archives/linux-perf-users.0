Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94AC322B67;
	Fri, 16 Jan 2026 03:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768534542; cv=fail; b=CIUTJkxh4+Y5WsjTK2F6Sd9qqxyR/VYcNOVHOKx3EUmnTs7gte3q1xt8dlHAemHMgNcdlIcH06l4BdJ2CEC9sX9sR3X683EsiVQldOGXQTlwHREHjRFv3FIKirKp6l6MO/ujSK0z7SkVfn+JzDwwNgekE7/l4b6/g6V17q5cYSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768534542; c=relaxed/simple;
	bh=nysQo5q9byMFbV3h9F2QoNsIcpBCZy8kbtCCYqXGN5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYTEi4YbS+uYq+4N+lC1HuPAjm+4/cwARgHql6k5xTn1dMgZaW5CFEC+wn+s6fRVf5xenAsWr0gv+UMfnGkCeFPx9b+FdrKpuOYOQzDeqfxqtOKk/0lJVjpuApVVhvodolNXEwpCBg0hpvAQJUX9LMGantDM2YfCvb8caS9aQNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HwFVYwH3; arc=fail smtp.client-ip=52.101.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HwFVYwH3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgfWL0SfYOQ32PT6J3zxvg70gUqBcL5rfeUvfeZaqWys61YHG5lScKY0HXD/S+rVdcCR2qllRPDco6q/dbjhldog1GI/03AL+bwm+OxZozvdP/v07j5evexWoGi7O7TwfY42ohi4SZeADWGFyJol6Sb+6gqVAHsG4d8RI8306BwLq0+Tei6vEC1v1MsOfAhFeq2T0pb3nuEKQ4wDMI71MuX7BRAaRT4zCGAH4XWBwUpLPyERWOHHpTQPwsTFm3xmjsleNniekZstIm9SDTC5o8EQZPxqOmf32Ma47EOh0ITuSsPmXVJ17YYqGz3HcpmDPVsCcRpoxVbDUL4Kh4Bjkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYzp02tdOWSeW/zCmbdmHqcwPbZ5dOaBXSiPUJt/PPM=;
 b=uJvPtC4x7pN+aAVPUrTuS3FJ1EKzLtw/C6CM64/FruGppUQhXVwdHeyJSlowkuGll6ZEnBvPHgnmNydN+o59MeIy+svqIGA43tYVGLuTYT07GiMJsCyud5ndUbYgU3kV5w+hyZFdoikXobPm9RQDoUCcIqaM9hln7GFy0wb0moeN5gvkZMRTgpK7xVoA3LPRRFyOl5wApefX9iiFeB9JbgHer/6t3invvpWj3/l//vK+AGBjWeKo2NtzoflJ9LIEAEedZggp9c1JTYPv5OLMK7BsnaoXbPuY4x0YEjz/+GQusirPdqge8otNkd+VEkJgj9jyaFkyjdxqFuc1ShlQkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYzp02tdOWSeW/zCmbdmHqcwPbZ5dOaBXSiPUJt/PPM=;
 b=HwFVYwH3jbdlrYkFE4v/4wM9e0K6kgTnUtQ9Ta4/sP8pryMum2SBYrlfsHKGuL+0omXXkaqmjmXwwZyZAKA5Wmhec19rRp7KbYIavsGb32fJ0/8BosGIc2/UcPSntIrbx0lgHXd9vVysEO9qhQfXQZFvG8Y88eUBc+MphNeAfnc=
Received: from BN9PR03CA0075.namprd03.prod.outlook.com (2603:10b6:408:fc::20)
 by MN6PR12MB8543.namprd12.prod.outlook.com (2603:10b6:208:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 03:35:35 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::ee) by BN9PR03CA0075.outlook.office365.com
 (2603:10b6:408:fc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Fri,
 16 Jan 2026 03:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 03:35:34 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 21:35:30 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 03/11] perf/amd/ibs: Preserve PhyAddrVal bit when clearing PhyAddr MSR
Date: Fri, 16 Jan 2026 03:34:42 +0000
Message-ID: <20260116033450.965-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033450.965-1-ravi.bangoria@amd.com>
References: <20260116033450.965-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|MN6PR12MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: a78dc43c-dd67-45ff-fd66-08de54b04ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m+tG2LdKhzF2ksGC4HP2M2sW+CL7W7T89QfggKT3CULK9BBPOWzSSpQTk6Zi?=
 =?us-ascii?Q?ns9pLy0exGFdEo4/CS8AQMWsHxMDqhQ5EUO9OpzUeRUF5VjSck5AYf0896UG?=
 =?us-ascii?Q?2xxBQudYgqsj01Jl9f31Rby52hQWLGwPaUG91sGeeB3RpPsujEfCao5edM9c?=
 =?us-ascii?Q?hRCSH9iGV/MIC6mjD+4KaHn6pcZ+ZHlMqQI/mTvh/DHf/t6K6FqHVmxC1EMb?=
 =?us-ascii?Q?ex/Ro85t3RA81wkBWgxfcjZQ3Ezb4kQcp3NgAAu4S2ltYjJ1/0AvePQxFDq/?=
 =?us-ascii?Q?pfRlIGU0WqJVrhsAEruoB/yT1IHZAT0sbXl2bNw9R5XMAhnIa4Symz8pZAB4?=
 =?us-ascii?Q?J8tfYJv7xuxXRfioeD7FGbvjw51+KmVRxUrtZQQG8avsAD07PtwTjePIN5St?=
 =?us-ascii?Q?arGzJsG2l051qQtb8+y2P7hwVELJN6yOft06aACpJQuqS+7cXeiFhgR1h4Ty?=
 =?us-ascii?Q?z7fZVBlxDRUrruSurlQBN6ZWeSKljKEPmlCXQLzdCPwDG7v6bhPzYKC000Bc?=
 =?us-ascii?Q?kMDeX5PmWP5j6+VhP2jo/QP2RvwectLemREdLkRnLz7+T7HUHO+iudxDMmB8?=
 =?us-ascii?Q?YeORJfreWa3BUmY1TH5Ki3PntYvE+e91oihqmnfeCuTyk+RE9Ig8GnysfKN/?=
 =?us-ascii?Q?/kJIDY1EbY+ecXopi1UiMFzfiijJSVppzrTPK4zC2RIxM8bZo2TPzui9I3zV?=
 =?us-ascii?Q?oL80FvcD6hjISooXKFMCiIyaX8Xr9OPWekxoYE3NA0vJ8xOJIkmzmql4V1Is?=
 =?us-ascii?Q?uZhQhCsNNP2yFtmDV4Ky2+bcQM+P9rxdoGgQCc0HrBfOnDsMcumcxd66nRQl?=
 =?us-ascii?Q?3HGBBRNSNR906a6tZcCKqgdF5An/MzeEWiOmBHdEbYUz1eRneSfGSNXx/V+N?=
 =?us-ascii?Q?MdUQZUoLPUlAr3qJiYa2lVEMPrLM3eSkU91QsQM74LoP5wPOjPCOBP8VhwIq?=
 =?us-ascii?Q?sYElkz6WSNi5CIku1YR07XWu94fSzE1otGh+1oUR2Kd+N8h2FcITda1gjVg3?=
 =?us-ascii?Q?TEsyyT3axQer8M9ZPgHn5WX/UQlpBLO0xkEdJKMsowkbNRJ8Al1yrvTPXRIt?=
 =?us-ascii?Q?cDGyy9RWvFAlcBcw4M8eSbaP2KaSvupEcwWwHfVl+UyZvu79LWPPVBgQvpd6?=
 =?us-ascii?Q?h7kxhMSxjxQXVtiOZIu8/RZ2oSazHTm5yta0H+JiCgJjzmsNDmK7QjXtNaal?=
 =?us-ascii?Q?dLa3U9GjwnGEFEzZrZezIUApjwDitfV2c1k7X5OjSNJ7GBxvEHn9WHKrONT3?=
 =?us-ascii?Q?xDH+8n9dLno5XTA2+SKdUFmkXt7+Z+sev4MI39c7Tc5NsInX+5MmBnK6ie1o?=
 =?us-ascii?Q?wCE5ZujMN0cZoELcfJjbQVQVsJDrtj0NB8H8IP72PLyPdi3m6ogVwk9SKH0+?=
 =?us-ascii?Q?zhsvF9BY4DHC7/81vdA4swdAeBxt/HDigY3L+9iYGci6epoR4oUjxjNP+iyq?=
 =?us-ascii?Q?1PZVOSyJDakDQbS5Vi6FKytnMk0RGYi7Ni0aJcurfPyu0MLTVU+7nUMkfR03?=
 =?us-ascii?Q?9pBhN7AlHvTPCynVNGOb0iHYurMH19CCg4DjuSoz08Zk6atB9O+8nKqgyH2P?=
 =?us-ascii?Q?K4lmmH6U1/4yjXXhZIdtbpafp/lztGf3IsL2D8Gv/vhS4WYQRZlxzEQtUv6o?=
 =?us-ascii?Q?NrIqs/FT3h7tothUX6zJpDjvXNu0XoivwSZDouI6etOsBfz5fFaWNSIf7aj3?=
 =?us-ascii?Q?X2OHXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 03:35:34.7656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a78dc43c-dd67-45ff-fd66-08de54b04ee8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8543

Commit 50a53b60e141 ("perf/amd/ibs: Prevent leaking sensitive data to
userspace") zeroed the physical address and also cleared the PhyAddrVal
flag before copying the value into a perf sample to avoid exposing
physical addresses to unprivileged users.

Clearing PhyAddrVal, however, has an unintended side-effect: several
other IBS fields are considered valid only when this bit is set. As a
result, those otherwise correct fields are discarded, reducing IBS
functionality.

Continue to zero the physical address, but keep the PhyAddrVal bit
intact so the related fields remain usable while still preventing any
address leak.

Fixes: 50a53b60e141 ("perf/amd/ibs: Prevent leaking sensitive data to userspace")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index dc8cc173cdf5..72abc474ec23 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1217,12 +1217,10 @@ static void perf_ibs_phyaddr_clear(struct perf_ibs *perf_ibs,
 				   struct perf_ibs_data *ibs_data)
 {
 	if (perf_ibs == &perf_ibs_op) {
-		ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSOPDATA3)] &= ~(1ULL << 18);
 		ibs_data->regs[ibs_op_msr_idx(MSR_AMD64_IBSDCPHYSAD)] = 0;
 		return;
 	}
 
-	ibs_data->regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHCTL)] &= ~(1ULL << 52);
 	ibs_data->regs[ibs_fetch_msr_idx(MSR_AMD64_IBSFETCHPHYSAD)] = 0;
 }
 
-- 
2.43.0

