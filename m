Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1B861FED;
	Mon,  7 Oct 2024 03:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728272960; cv=fail; b=EJWXiLAm04xVX/BKyjAPuWi+7cBjHG0QTw/auEplh/QDlfp14jEbXDlj1VgQaXs2CNeKWhbeMGIzvPBIx3Vq7/SCMJ+zRk018CIg5fMFrNvxM5GIvtLF1ED6TgbssXb1rBShVqsIP0wutWxf+xhlwNAy7eZkmOYqV6R42xFOQjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728272960; c=relaxed/simple;
	bh=NhFpgKhdb+ld1Q8jNhZ7rSvDNSrtNIfxMrqaEQKg8nE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+qoq68/VEqQ7/ITPh8aCgBQtBOseRlXmILCjWRwaks+WN62P3ePAzzxD+jec1+cqzm0bECpUM35Y/fqOqYYFijOrNAbGRxRzW4ngIgTDfu146g+YxpH/NgELhGKXsBrhtyVaOfsA+J80G6H3fEV1DbpJ2pucSQ0zNXIy+fCPYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fAOKTxXD; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fAOKTxXD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gC+WN5H3e52P6g8ctY+BTxnVEOxXpkUfkdS/NK6T2/sU5pia/ZVr71KNCN4onjHdzs1NjXyUqQF0EG2rrPtxwJaJvisvg6+R/q0i3JXkEZxDiAaH6k6BrBhGULwgsfNZeLBRru7Db/DllrNcV8a31FNWo9sGH5pmoR4ZuJME6qFvKUcVLB1PGnD1pXUWSAXkchgHqIbpBsjTi/Tj98Mq1qarks7sBzKFtb45WcpRmzdb78Gz5UvhHY49T4q/9Mb7Ej/ADXQ7cDOyEL1LW93bCTPkfjsCC0C9WXtBWvFw0KQnLPlr/FIZg/nKFbLNnBqSNkZv6bQHZrWpPuuMxiEzRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkIwNnYwdVPheinlfpO8ESVt0EzY5sSiIAql0u3i/uI=;
 b=jqlDHxS95Fa88ZmYM3tfIoHoMdgN0OxyE4zoQTR2OhxZNGgc3auv0KLk296JVEGVn0Px3mppZP+LK42piBghjnd0KJUoaQBsom1cOW1T6Ujbn+PQmflv9OFKZRiZjVMbSLKpCeJgkzHhuucO2nPt4YQiC2w0XnpsaFPJUZT9ugRg2qZqL0Apbfg9Eo4sk5j+cbwt4yY6lc21ps6cn4v19ryzzpep1rv5LPqRis2cGGnqrRqcCxQX8aPhKhwz0hWMMSRADpfIJrnC9P383VBsFBKkGgBEDW8a2haG3ePwutiZrCjK+vQz70+RZ8zjcOf7Kq2UEgfr6e2mmRsyTFpU4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkIwNnYwdVPheinlfpO8ESVt0EzY5sSiIAql0u3i/uI=;
 b=fAOKTxXD5O7UGXkWjsl83azJfvV7+91WuCYyuuoja2m7nOTWnHnXOLIxkUvVfpB3teyeBC1hzdGpV77eDzUbnJwBTEaMOEIa984ScMDx55cSup2XuafwjXxVgR6Cu8nHDJIzcDo8tLS48yz1i1eQEPzOMIjulLfEqf1DPjRgVrY=
Received: from PH7P220CA0090.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::13)
 by SA1PR12MB8641.namprd12.prod.outlook.com (2603:10b6:806:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 03:49:15 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::a0) by PH7P220CA0090.outlook.office365.com
 (2603:10b6:510:32c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21 via Frontend
 Transport; Mon, 7 Oct 2024 03:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 03:49:13 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 22:49:07 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 5/8] perf/amd/ibs: Don't allow freq mode event creation through ->config interface
Date: Mon, 7 Oct 2024 03:48:07 +0000
Message-ID: <20241007034810.754-6-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SA1PR12MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 0780a788-329f-43a1-5928-08dce68302b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PQNjMUoBeFnPOiynFRAGpzZyWcszs+6SVOeJr2c+knCz/6AC8RLm22V22g0C?=
 =?us-ascii?Q?Im1FtyaeIJoWIgfEA5RtnX97+YUvqEkeJa7s/PFRj13V30OX2czXXale/IQg?=
 =?us-ascii?Q?YVQFzUlCxIbpkTYR1ULakmyzsxVPIS2YpxiYZkEyp7rDRszcDsGeeDyEJnDc?=
 =?us-ascii?Q?tOhBMAs/ERZCMEZwJ+gFuepxn5s6nQTww6TvVemoc8em/f21VYZwUytMh0Ra?=
 =?us-ascii?Q?qWQFQMKbINPxoe9RERecRuNC8PxhrUFr0OaTblQqlTwryRk1QpW0DNeSStuc?=
 =?us-ascii?Q?DhDZ5jSpHGKNJsCkqma7cgxT3e54m83Uenmcmnn+XzLR6Kp88VHtafL3M8ft?=
 =?us-ascii?Q?lFvUMoI2acKNJ1mPfsffrEsyRmDz2ONne20fgJduExJBzojI1rI1XDKtpgGy?=
 =?us-ascii?Q?7vy8NknRsu1RwSQDe55lH4ZxW1fJJWoRf8W+IqJzXXhz4/FdRG49chZ0RIr5?=
 =?us-ascii?Q?KkpTbhYizGaB4T4Ffh3+m2vMxy2JT0CwbFk6esRfVbS6xRP2trJ8t1zUi6Ab?=
 =?us-ascii?Q?mdAJ8M9x//dIWm9QgTTuoimIL/DcDwvsyc2iGBDUF1sMC3/ngiKWL4NQOtR5?=
 =?us-ascii?Q?fvByZBu+JmvbWmuxjJGSG6n4ulUG2T+SEMhlOenv4zapHTMLiOygvsxDJkZH?=
 =?us-ascii?Q?qsTH9S7SB+2WDn0SH8nJYaHLYmpZ4uR+roDpKpJ+x5kslFmecYZZDR5dJ+Rw?=
 =?us-ascii?Q?/Qz1kwrakPFyH93tr8jYPx0ZfcQ8rAveYBGg69BlbQjGB+dyADLYosOJTJCw?=
 =?us-ascii?Q?RHh4hj0uG/wna96PG+AkEnhx96Q5Ps1jO9S21gq3zWy9Do2f1QO3rXciU+vc?=
 =?us-ascii?Q?Ax3Z7JlvP7TW1AnWCL7eD17wH8fW4tfEDEPTSCKOBnHxiD3MOBCPGkXMTpcH?=
 =?us-ascii?Q?2RmIa8ViH7YisAqjTYexteLp3n8Nv9W36vBrTsHLt3qssKN0yKJ0GHiv4YaK?=
 =?us-ascii?Q?Le4vzwRPD/johuyN4QxQmoVzYzuwrhgCzSnVf84m885GsAE7s2bRjlZeZSwo?=
 =?us-ascii?Q?ainlZRFfv0AaQ91sVyKo7LC9tvNUIgwm6YIQ0uH13rSzGmiM0r76a4v3jqpD?=
 =?us-ascii?Q?gnZGRWUc5dqR9GHdyWLyzZ/8jjeVApe5CWVBYke9C7J8tkHPz44Oj05ve7/g?=
 =?us-ascii?Q?C8KOZU5inB+uYJ+NeEsaZugC4IhSVXRVhagJUNDnLjl2gi8qXujnQnVr8L6B?=
 =?us-ascii?Q?TMamZIcMH7fHoapSxNyIGq63WZCfapJ0p+YVZCJNcPziQ9Kq+uVPseYKNoQA?=
 =?us-ascii?Q?8Vk1s/1XMI9u+TWiOrftRF3IkkFH/dVuItGy5fL5iP8xbQIMF8ogC+a4BDCh?=
 =?us-ascii?Q?hG0MCalzPDY/quilZM5UngAHEXWEUJR0rJYxmkqj42nhaYRgWC/5Ns4QIa4U?=
 =?us-ascii?Q?eyPdcDtbfaPweMOptOf4jXlX/Dx3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 03:49:13.9792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0780a788-329f-43a1-5928-08dce68302b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8641

Most perf_event_attr->config bits directly maps to IBS_{FETCH|OP}_CTL
MSR. Since the sample period is programmed in these control registers,
IBS PMU driver allows opening an IBS event by setting sample period
value directly in perf_event_attr->config instead of using explicit
perf_event_attr->sample_period interface.

However, this logic is not applicable for freq mode events since the
semantics of control register fields are applicable only to fixed
sample period whereas the freq mode event adjusts sample period after
each and every sample. Currently, IBS driver (unintentionally) allows
creating freq mode event via ->config interface, which is semantically
wrong as well as detrimental because it can be misused to bypass
perf_event_max_sample_rate checks.

Don't allow freq mode event creation through perf_event_attr->config
interface.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 152f9116af1e..368ed839b612 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -302,6 +302,9 @@ static int perf_ibs_init(struct perf_event *event)
 	} else {
 		u64 period = 0;
 
+		if (event->attr.freq)
+			return -EINVAL;
+
 		if (perf_ibs == &perf_ibs_op) {
 			period = (config & IBS_OP_MAX_CNT) << 4;
 			if (ibs_caps & IBS_CAPS_OPCNTEXT)
-- 
2.46.2

