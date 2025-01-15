Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DA422FDEC;
	Wed, 15 Jan 2025 05:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736919973; cv=fail; b=qucNJFtofdzWiwRG2RvZ6wzaFWMlzpfZ/ISNfBva9YFGeBOHRkuuPGNalGoWm1F+2OFA225zzB/y/ajw0MMCIXGvPxCAhExl4O9KQBRjPidupOtY1CQ9Tew/HbBauCfn6YuXGBNrPTlkibUmfu+8MSAil4Qr86eOxD0hIx3MMTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736919973; c=relaxed/simple;
	bh=TRB3+hLi+ggudg0JCZ+912Ji1H8WrzYPFfUcdTjovXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PpnO7/o4omxVnynfe9ZgJwxkF9Pl2gid/xCDWLs2f3nAQsRHiRpN6NW5PeTopTdNrG7BCnan0X8+ngYwNsXBytsFmUz2RXVtHHns5nzL9xV8KTXL1JieL9kkSdzfiS8T/PvtQy7gMBlRISNGbueSa97iheljOer8pY2KXN9gceE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sn3P/v/1; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sn3P/v/1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itkPkHxN6OAdRcqjQwuqJpM3aJtw78z8PTwCYXyCvICe44qpf9l6qnvMiN0Vw2pP33vRtmqM4czmj0iqnbSVInRQ5HIwN/SuKWQPoKmKWXOhGNjXgFFPo9u9D/S+ltuaXgOaOinKgqjm63R/cHGd0hqrJFyjqoZq+qR8BJukCus6h5A6C8kj08awcnNO0vWrOEa4S03wRpaJjI1hSI3PtGoP5IeO7NM4l7Ug95BxJH+ruWdQc9U9vDVphve5iBZzelnARWPRBKtk3sd8i10VOfN1KHEh3APoMq82Lg8nC3pKq9eTscCQ7mfvKmr1xBx1Uq2zzRARFBMemYQxb32oRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXcI9ACM3+mQ8XBMssEZPaTlM0c3fPenKr5075P9MAs=;
 b=GGNL4nyPk10LyZBY/lcDw3g1wBnVychoiUfagKbXToUgF0Xxl03CSRYiXmnnCMXDQChcagpNM5AuY++NrPxaHh3J9ozaHqA1ZSm2ev1CB7iLeCs2fwoCQc2v42mRpZkZF6SlsZqC8uMWIEcd3z6CSXQP2f20e4mjzQJOB338fn1uWOufPvliX02plyms6zU+l9aS2OClDRXcsBuxOxXToO7Q11MiuyVSseKw+ReizScOq0fHVaGD8M+hr8Jf5n316ATOkoMK4Aeij4c+UITAs/1GYm2KTgd6+Vmu3GmSwklEUXgCAU6BlaGDqkwDuOlbsET6JhnxQRkIVfu75/BeoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXcI9ACM3+mQ8XBMssEZPaTlM0c3fPenKr5075P9MAs=;
 b=sn3P/v/1Kg+IvKOpIs+Pu4MrEn7WexDbrpSG0nSiwgPStCod7kIzOuyNsuiL8tyEO3glNJkgWYMI81RjLYGrlNhUqaw6ls3vRUV/U234eezZG0bVr3WHW/tYO5VKs6z2QsMIlNtXxXdwN7Fhs4IsBIkILxqhds9IfUr3ogbaokc=
Received: from MW4PR03CA0088.namprd03.prod.outlook.com (2603:10b6:303:b6::33)
 by PH7PR12MB7456.namprd12.prod.outlook.com (2603:10b6:510:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 05:46:07 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::68) by MW4PR03CA0088.outlook.office365.com
 (2603:10b6:303:b6::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Wed,
 15 Jan 2025 05:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 05:46:06 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 14 Jan
 2025 23:46:02 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<irogers@google.com>, <kan.liang@linux.intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <santosh.shukla@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v4 2/9] perf/amd/ibs: Remove pointless sample period check
Date: Wed, 15 Jan 2025 05:44:31 +0000
Message-ID: <20250115054438.1021-3-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|PH7PR12MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 90479e99-654a-42a3-b40e-08dd3527e81f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DlB3aL5UxUPIQp91ZK+R55HoO4JIOrYvzddf7Wbr/asp1ysyZHffUpp8FMzR?=
 =?us-ascii?Q?cFNbc7tXq++jP9CP2pEdHskuNFZYtZs6hbNMuo+K/CYN9XmaRlZjxTjfeEt2?=
 =?us-ascii?Q?jIhXA+DmQZw7hOc5o3Z1IUklRO6IBJ1xzkwGUihpzBBLiKU3ZuGoT8aw3edP?=
 =?us-ascii?Q?92B7gZU9ETTjXhAOfVZxpzZeeWUidUwCg7GZ+MeF3wvnQAit2gXZIdtQrrK5?=
 =?us-ascii?Q?vKocXYXJ8eqoedtcG30LOut2hl4YDxOurXrM4hY/LBZbU05iPaj9QXsvP4KJ?=
 =?us-ascii?Q?7Z0ieyCJo9EpEl/DNEhTXsad8OOJzmxw/tVeqX2U8HVS1O1+Wiq6fKAJM0+6?=
 =?us-ascii?Q?LHSuj45Hec7xFEDNwyEvg8yujLjh7ianYYADHD0Wb8n50Ur7nXlg7WObKpur?=
 =?us-ascii?Q?Ybntvnnn9DFFTlANU4beqDtPIlEqGviH6s24WiSkcvoah9vUtDOQC/qfsk1n?=
 =?us-ascii?Q?YHWIwoehuHAdGdiflPiSDz4OUiRhkv8zBLwyzv7ZRaQBnBFbF+/8c4z80u9a?=
 =?us-ascii?Q?WdIRvvX1PTBpdg6Wild0/2w0AacBeA34KxvBYhkoevRyTblBlO4a0m+aL9pk?=
 =?us-ascii?Q?ugwGOzhxyFG+Deq7brknO+lAbaS0y1IOnA3ynQlStoT5RvCWK2WnjZ4qjKQ1?=
 =?us-ascii?Q?T2Cqog5LFHh0JpFiCE2VbVYdVOhdzGzM4i15So0koAAXgMoBCcFoOs06LJ1J?=
 =?us-ascii?Q?v/v0kybaHOmC55YcdlFz/lifZHL7dE1drXrC55lNFNqYOJv1zA9LlaisNBB1?=
 =?us-ascii?Q?GMqUfUmKtPVkakfjx2NS/S2kh9zp+yRjTIqy9TFJAXLkYsxv+fGfFQqhdloX?=
 =?us-ascii?Q?p3NvF/p5r9upbh12yN+5roveV7RNgT4/gr0qFfe1UKyLthv9covPpW9vO7ON?=
 =?us-ascii?Q?QiBk+Qz3hnxleamHRRSIxDyOkazHHRliYuW/CHDRM4zZ5CWmX1lvjSELfn2s?=
 =?us-ascii?Q?Qdt400IE9uXf3HN/mLiZxoEZP20x3k2a41ePCRHUTxQM7imRofWa/8HimFNI?=
 =?us-ascii?Q?iuNzt9cNoRflOMwVWhobVZ8zngUtm4Fl8ZCW1dhx+cvLMReW69UjUoWjoGcr?=
 =?us-ascii?Q?vAO6H/Y3ibwEhIdB/BJ0nolr3hO1cBM5XbwAr4S0DUQOxiMe9Sj9R5N9SKfv?=
 =?us-ascii?Q?FgS2EunSdWgZLsi72ECm/BhU6P8hTYUJXEavtjQ9L18zPm6S1BTZViGks/69?=
 =?us-ascii?Q?BE4EgwOz6qSgRyOb9ZoAs9NODIbhI0u42cnoj/xDP+N+Pl7/mDpUhUb4hqrx?=
 =?us-ascii?Q?D2Pv3aBGsEHTWWZMIYNASqQJ5u4mMrddSteOJUqxMra32x4Db/jyXXuBuIoh?=
 =?us-ascii?Q?rOZNuB7XjdV3ZD4sR4cqbqLYHk9pZU4SmFMRI0evauV5kmrWnO09Zq2SgQes?=
 =?us-ascii?Q?IqvseBJOjS/+8R9r0PUZTNkUwV1uaRm0x0pQ+VCXVLN6rTNgp5OTPN/5prwg?=
 =?us-ascii?Q?RmteB/cs9l0bPRReJq5ceTW9o7vzRCdqd19ggTSPAMWoAWdZLK1/ew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 05:46:06.9304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90479e99-654a-42a3-b40e-08dd3527e81f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7456

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

