Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1309D26560B;
	Mon, 16 Feb 2026 04:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771215776; cv=fail; b=ChUUO0uzxnGt3/gik+xw74WsKB0mWEHj6K86reGGsXpnHpzvzmk050Uxj/uwDVZR6coAsNYCt3NTwFBGEuBi5VpmZtPNtjhqMKVlsQAERQuAyezlhmsyYj+DLQGiNvaKFmbiUSPPrCIrxkD8dX3F1CC9Nv0kno35RZoOmSZvBr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771215776; c=relaxed/simple;
	bh=hPP46hSKrcQmjWoPi90xrzdXemWMPs8uW1YUMTg1/4M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TM7FKjhVCGfsGxS6DH5GWE45DY2Sv5290IMkoSfQ93yBUpfUxC3RlY62IP9ZkHbU1wHmtxVC7vocnQdOW2sUCbyHZcQ3BPHTBAwjt2rcIV4aGwTb/n6ZO4VPu+sUGAIMTc8Zd9gbLOu3ulBwrEAMVfKMqd3+LYw8Dm99ibKZOHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WtwTANDO; arc=fail smtp.client-ip=52.101.56.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WtwTANDO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmzgA2EC8j0kVkryFMXnYdnxQJQebnyjcaOlNhTyJj4gLOlC3F3CeOc2fNKEX0U9zf83nKSPIQC4+rZdts4fTHw6iiio60fZ474nnPyJySwynPNPlAzxHjBy8ow2xUFhZ5tTw+9aKtfvWS2MPNuSDAi51dp8bApBfYRErEsHbyQ24gXR0GDvJKhZzey+Rg1Ou6Y1dvvMHuqp9CKjTAqvKhnv9ARfJgZJuH8xQuTWykdSTzF7Dt75XmA3CXjoZMS8D/wIeFIFTgwjIAbdYQc4K9+m3iPcE5zKR1O2cXAm/yf1FobSTEYS1LZ5DfM56NIDpA78hlzVTeR1NG6JTCCNSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TTvnxyLBekPLG0IU1aDIMAqikNjccX1PVBqE8DlaD4=;
 b=eXb2umpd9gvnKGE0mkL9h8IEUXCqnhqKOqu3Sh7aVFwDsd4AUAMOVbDySQQUrMn64DDW32is/ORvCcA0rSxFGQAr83RWPHEJU3o4UUykdUdL7QdVZsTqG4+KFGhQzQCZXhSKNKHTJpC3WatrpF0/pwDu4/IU3sdo1/NNUHAUqCNnkAzDhLyuyJSFhZEDz/z4zmXvp4btU4r9p7rPtT7o3OHtm+IMGI76KRFE6FTy9DkUmfICJvLFwbISEUw1f/avuuAC/kIJw5uZjn8u0fp9SGDJ+jAQAYEI+xxPctPTuqFotrw2C6xzfPVLNLolo1Rjj7VXtgRNBQYD6NWtWF0PPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TTvnxyLBekPLG0IU1aDIMAqikNjccX1PVBqE8DlaD4=;
 b=WtwTANDOHOkSwOUXVq182wGTbQgmi6Th27+I/7j0fSQSXNZFDl35KmZuY2FFheT5s0inbqMwxIggpMgAqK0NForFucuZORE1FCqpml2QD6VcoJHVx5jqJ9KXgRUuEI992NVPOE0zSMuq1GkQ8VUQXxmhRz892srsdcoiL0kBxOw=
Received: from SJ0PR03CA0371.namprd03.prod.outlook.com (2603:10b6:a03:3a1::16)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Mon, 16 Feb
 2026 04:22:51 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::d) by SJ0PR03CA0371.outlook.office365.com
 (2603:10b6:a03:3a1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 04:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 04:22:50 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 15 Feb
 2026 22:22:45 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, Sadasivan Shaiju <sadasivan.shaiju2@amd.com>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v2 3/5] perf/amd/ibs: Preserve PhyAddrVal bit when clearing PhyAddr MSR
Date: Mon, 16 Feb 2026 04:22:14 +0000
Message-ID: <20260216042216.1440-4-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216042216.1440-1-ravi.bangoria@amd.com>
References: <20260216042216.1440-1-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: fef3a4a2-8a5d-4567-8688-08de6d130bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nkn6VfVKjfOkUaBREYRRwsDDaAwpjQnf651aOn2JgoG5ocz2nskINkmxo4v2?=
 =?us-ascii?Q?/aA9Et9amk3tRRML9wD+mS62kkPJV2/M+4p9jvCQOYvIpOzcPTGGGkZztXzj?=
 =?us-ascii?Q?CW9rP5z6PlSRsbmavAE45nchApkGK0os+73G3z0bXQllfawvHnCfz5hFmj+g?=
 =?us-ascii?Q?mEYSldstsaep83+KHAAg1eCvwbkmpXyD0eKI8BW2qbcMPXg4EXV9czfq/C86?=
 =?us-ascii?Q?rEMx2cy7DkCFLWjVmD/y6WpJqOJcOaCJDjExF0BYcusxEJenwozSij4GNPl9?=
 =?us-ascii?Q?KUqQvZ5VuvEjzf9PviEHRf31cTPM6UmaxOfo0/Sg28UqSVT/yzCZhizXkKJb?=
 =?us-ascii?Q?O8p3wUPGsOe85RQdIcxVY/05P1cO4wl7OLPJcteikiaswsn1bRJYXXRh5l/h?=
 =?us-ascii?Q?AhQSlcMi4Lvo/K1Z2cpzBO1hj2MRO5SRcby7JQgKRvwdsUKZU1JIld2tosib?=
 =?us-ascii?Q?+uHfyqjQ3/tzd1SNgJuFudkPwiPn2eHGN6AoeSCMe+i7JVYcskDYHMa2Z5Qn?=
 =?us-ascii?Q?vETt84RW2vrW8TVaXyvlVOfww2NvifdC5oqhgFIOfIL9eWc/Eg9p0RXO2ZEk?=
 =?us-ascii?Q?HPfZ8tLh5rkun7A5jwDQTMUz8c9bbO+R2C0qsj0p5Sivfq5Z/txTUoATmugo?=
 =?us-ascii?Q?65ZwRO2GQLIkFIyqz+/gMRvFqxlYPZsZNzD69gXhgoZpwcIfxj4fAj1uzkcS?=
 =?us-ascii?Q?QjwzVyTWdzoMKMtubB3lBoJNwwCGOKQ7FY+x+sssq3RkVVux0G+9MhSt9eFu?=
 =?us-ascii?Q?WbOjZav2zfCds7pmJh69vvI6jx6B9QzGNYsylM54oySFsc+m19KY3Qwcgb0f?=
 =?us-ascii?Q?pwaweGSjjRmKTuTZB72nA6uxQaKP6gBJlepT+0ed+WTSvgue+B8vdxyd0UrS?=
 =?us-ascii?Q?eyb5m5HLmkWJzXGr9otpe+S3jKoyWfKjOq4avrp1xXxRtZSK3O9vnKMwaq3L?=
 =?us-ascii?Q?pv+cMr+qjUcHHKAWk8ESGIjBOuGBVMptZlUy2yfHC9IgyriGouWRwYJDCpm7?=
 =?us-ascii?Q?bjFOwaQpoyUFhYmXKqblcfZORl5sdNt/RzvxnWQ+qOaHnMYQYutw9Shzf5fw?=
 =?us-ascii?Q?VIYqhntpLJPaDnVCvDgenRn+bR4rCtw9lZQDB4R1nB4M0HMDDIKew8v0le6y?=
 =?us-ascii?Q?8T7ZUtHCu87Sy8Fsa4RwkyQnp46epKbE3637xWzqUIxhs4IHjBDYKgRkl2U9?=
 =?us-ascii?Q?9gLr9UrulGJiX1UH4uFDqKfdv4aSP+egFmEKl5xZc9I9VyKZq/rGnv4yeFTG?=
 =?us-ascii?Q?hYqltxRQLZXcgguDD4e2VdLN3UYfs3M5k/k2ff8aZrdZO0k8DHXLRpc5mtYE?=
 =?us-ascii?Q?KlkJLhw5oj8akO8yRrBDcw7Hct51bVeVqqG8yv4E6a8n72Z2mFs0kolh/tFL?=
 =?us-ascii?Q?RbjlC2Bu7QKVIiu2b+GyAbYtkQvkRV4wwBkqn0DMqGA8V9is7pfvp9pN8Aq4?=
 =?us-ascii?Q?ItAaw1kWF8sxRHeSKwP/woipFCo6IHvxadLdrlHkfgd/0jcStCH9sfVgvFuB?=
 =?us-ascii?Q?zWwJ404F3Mb+XEznrqS+UmJVX/wAR/MsWAowBmf7OGWvsOSzNdsz0yKEGTrj?=
 =?us-ascii?Q?myi4Nw/ectFkjBFG0b/OfLdTaMpviF1ABHV2EEMKNz7zkGCeXpAlg8+FUaah?=
 =?us-ascii?Q?q4QHIo1adb/AlyRFoq+IrDtDIZGmL7hxYsQciGR/rIYVGS8lnoFGv0jElqGp?=
 =?us-ascii?Q?ZidbdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ql7ReMblVK6nZxenoayvtGzR2aWcMbQvYVDaHFG2aPO7jT+U8vj+t1NWsdD2CXrhzIQx/BuhnNI8kS3BwozJlM5dz4fZPkrhgd2XwMgVP0fkNSD9+DcMkDy6bargs9D4aLtAeDEVPMBLegO5pbKXSOKdZZvRXF7j0SuRSyTwLtV/kk4R1ZOpnj1WPZNU+cJJ4bxgeWIbT0Pewp8R9pP46Zgpio4M7ugat8a6inlgl58fV+PHWDa+x4T1IwyBEx3L4mH26GMYWGjdactiruRf0zhDyaf5goCcuSdXvI7cH6NzpX0gBHam8R42MugVaJaMD0iLCUS35/xR8R7iPh7GFJO4Gtru3e2E4MtTg/VRFypdSDzxi+6lCsqOj5gB8zQVyM/3yCTafWJLewgg+S82MXLippTbo7pNoDPuNUAUjojq4TCCl3Ikd8TBi26NDmRZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 04:22:50.1338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef3a4a2-8a5d-4567-8688-08de6d130bc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240

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
index e0b64cb13bf9..05b7c9f2ec33 100644
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

