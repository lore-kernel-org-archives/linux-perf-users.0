Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52E61CD219;
	Fri,  6 Dec 2024 05:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462281; cv=fail; b=T5TQ0w5O8sJMEQjxffGPTiqmMmqp9jqtTQsa3srkwAoRulkCLTfdDkQx/4EktBh11PkV1F4INPwX10ySUQiJSzxduQMPj3voL7mmBnTBH07af3xxO3nQUIiDwPHpiuj5k+Q+GsFNFOtKwKK3SjecXFQO8r0RruaDkLgo3zjy6zY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462281; c=relaxed/simple;
	bh=jd5CwZUmIEp6FsdGiDw7zCJ4QzXBCp2k4KcQeKziZfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsKhR04TyXvgltSCDOYI/K0YVB+rEXW84k+QP8W1OTVAqW4PC/Fbnw5IerkUrNtDAZC7Qn/OsFKyaD0BGDMpbjZkp2w46HMDFdH1Pe7b7mteatvJ6NdGu7qiQ8ApsydCEZmYrxQwy38oEpAoVPl/BrSQSWVEz7/n/YF8qY0Vz/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lNdIjVig; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lNdIjVig"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nw9KZlsslqp/2393YcasZ5kvA7cgza4ZIa/06CH/gFjQ1TnIyI6HIZfwywnzAUEttlIQsZ/U/UA/G1A2DE2z2nCGDzZKlyrHvX8kSBKyaQR1cmiUP7n+raM3q18HbLtfPw5zFaWaM+gThK4jLVFHPjwBpAB+s20PpL8Uuidn5b6tiPrYwIOI9c/vcKfy3wBlR3RDW7gv//rxGFNVOw0zaur9A6fPDJI1G9Pq05uPVDpcYiwTULoUMOgq/oFbgoxlpnJZTyFtPtquiZEIzVXIz6rT+qpBN9ZakxkJ4Ld6YXUGUZFqv3AdEnvXLZRFfDNQJOFitw141pjdrIndEnS7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bkfxb3OlBKQWAdnSWe7RZvDSeVLYtDC4gS/P81CckA4=;
 b=bg1ZBinEYYY51a8EZuBfUZkSh4A0v4J+4yhia484n4gKIzi5MYP5c4pQpnIEOf/UgvEEsVQBUIrBhrcVpheop72tx3fF/aLpDUi0YbWCivZ4nBd2g6Pei/yOw4UkhqNw0fBDKOonurAn+m7AZzmoqT+DXGNNc5+Dz2lmvDpBK26M1oNxMHiEJDIGNwak3GWcOTj9O9RsXpXEtP0jIijNgIbUoC8wCfdkkVzctZPIvy4ysGyq++83h5YhqY9rG8wdUt++1UONJb3AkLDdfb+QG8hQQ3hEYQs29iyiGDkZfiBLPpc68HvW2rYJuUk+SOtKqfBoAX727u1dTCkGbWpcoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bkfxb3OlBKQWAdnSWe7RZvDSeVLYtDC4gS/P81CckA4=;
 b=lNdIjVigXeofqlEtN7pzF5wG6b4S2zqNPCql4Hmybq6nW+AVOJ9exBmaueva+qOymtX0G8HoGFxrwNO9E6O2gyG4lM4urAdnSP7j9+Xm5geaI+1ucZrzKT9agZZRsl0fS1G/zg+4WFHWCP/3JLa0wMRpGxDdVl9f0jqReSk3jmM=
Received: from SJ0PR05CA0107.namprd05.prod.outlook.com (2603:10b6:a03:334::22)
 by PH8PR12MB7254.namprd12.prod.outlook.com (2603:10b6:510:225::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 05:17:56 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::d5) by SJ0PR05CA0107.outlook.office365.com
 (2603:10b6:a03:334::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Fri, 6
 Dec 2024 05:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 05:17:56 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 23:17:49 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <namhyung@kernel.org>
CC: <ravi.bangoria@amd.com>, <acme@kernel.org>, <eranian@google.com>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<santosh.shukla@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 04/10] perf/amd/ibs: Fix perf_ibs_op.cnt_mask for CurCnt
Date: Fri, 6 Dec 2024 05:17:07 +0000
Message-ID: <20241206051713.991-5-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|PH8PR12MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa98b0a-c6a3-4855-2a12-08dd15b557db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NSWEVPRzQHgQtiG1fzEz3Ay81bigoFybJR5L3hp2DO0jFhltSaGthyZS3RfE?=
 =?us-ascii?Q?XH7BghuczJjFJXIvvGoSY2QEVfR+HNYgRjTKL3Os83UnxVP8dDM4bkt/8EB0?=
 =?us-ascii?Q?k/Z/dj9T8txA05CBIFMiHvq0BB8eHnXOAFdbofHMd+176plOHmVyF9J+mUOO?=
 =?us-ascii?Q?LAW8h1UX4H1eazF5TV1kFmcwEzuzMB8JhCTX6R4Hhl0eQR4kpQ7zsUguQn4p?=
 =?us-ascii?Q?4j/HJmKTQUCaRogZee0AahGtsrwku10atbsbRbV/ttpU2jzKHk/0EzKsULHw?=
 =?us-ascii?Q?ZmuuELOCGu7YazyJy5U0uB+AOSkkoMgM4RLOOMg1qvjXvJQVkYaCaXMniVXH?=
 =?us-ascii?Q?7UeQU1yaElJ4RSv4lc8BD1nE2Y9+MICsUb8lPTn586ammEOeyDb1DtHNb5h+?=
 =?us-ascii?Q?usaVXxr4ARfm1xgZT0adPDr2cUr7I69uFk7x5LIPXM0jsD1bRNGz4BB+xkCl?=
 =?us-ascii?Q?UFIW1u2+/3JNUsCy416+ydAPqGXVGxkkPfMfxQRf/Z6TCgxuSaGioMQme2Yu?=
 =?us-ascii?Q?7uYKkEkJARUhAqrtWRDjt93F1EIzGHtmI6+6/aB7T3Mv13KfuHsQxX0LWi0S?=
 =?us-ascii?Q?u8vPtNWdRmvV4s9EyFDotRze+2cqM2bfs0K74KJDtTppw5ydZJ75un9coYlN?=
 =?us-ascii?Q?rHU9L4HAeTIc1GPLGcWfCtmk24Gh7bsUDV9BBHBFvU0UGhjT8XEj+EbtGoy7?=
 =?us-ascii?Q?ADT7CZjwjuLg38WkpBf7EN1nXMFLXD9HosqWZNDly0gYtCjGU9BDNiPQMki3?=
 =?us-ascii?Q?/2Uk3++zR17zXtGn3bm5OeTPLFuhGoCmEtGmfb5/EkhEDzIKuz6XsQauZugn?=
 =?us-ascii?Q?OpuU9L3yeZVQal+KQ1kpVh2R/giWzQ7rxsMX6YEihDu9o5PRnalikBUSXaol?=
 =?us-ascii?Q?cHZjFMlP9oBK+zsFTMEJ53dTYC0aSTDR4SHwIZ9awZfVTtzSeEibSE8gPA3f?=
 =?us-ascii?Q?NSJPEk4dKPqiM+PByoO1cTLkhkK6hJAl5GpO3jJQ9zw7/fX8woz+//4EfSMq?=
 =?us-ascii?Q?TLjAZJwDvf0jY1MsGnm/+vSGQv52m3IPs7xNtHLOzqLGmXvOGqWeVBEoW4uR?=
 =?us-ascii?Q?qz31HBY4IqsMtbE7D2QwUvjGj7xIvP8ZU4HeOAnxc7M6XnIPBnxBnRoYG2eT?=
 =?us-ascii?Q?LYSN7HT+/HSvIW3EW1tv3qJyG2O0zcWbFw0EEi2wbG8pZLv480Gz4ADOgWWx?=
 =?us-ascii?Q?OYV+VFydyF3yQaLhPnSetla2zvR61rHge4T0CpsTaeEwNwGHWHYZ5sZMpxdO?=
 =?us-ascii?Q?bLUjhppUIj+5iieeAqzXFyceWjVK1QV05922cg7SxaZh9SyprOjHekQ4AyDV?=
 =?us-ascii?Q?L2jyVCxfb1IZzL9j5iVaQLcF03Cy4YCy58FZj3IGpt5cOll0Cv7J3pn+a5qH?=
 =?us-ascii?Q?4SG3yIgnPzisUxnG+TRoodw9MHRyCX6OwYQZaDHb5ze6MfL9xTN9jeLVv9DQ?=
 =?us-ascii?Q?wfrbeX9Bxb8MZtnYlEgYX9j1rthSdvUw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 05:17:56.2160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa98b0a-c6a3-4855-2a12-08dd15b557db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7254

IBS Op uses two counters: MaxCnt and CurCnt. MaxCnt is programmed with
the desired sample period. IBS hw generates sample when CurCnt reaches
to MaxCnt. The size of these counter used to be 20 bits but later they
were extended to 27 bits. The 7 bit extension is indicated by CPUID
Fn8000_001B_EAX[6 / OpCntExt].

perf_ibs->cnt_mask variable contains bit masks for MaxCnt and CurCnt.
But IBS driver does not set upper 7 bits of CurCnt in cnt_mask even
when OpCntExt CPUID bit is set. Fix this.

IBS driver uses cnt_mask[CurCnt] bits only while disabling an event.
Fortunately, CurCnt bits are not read from MSR while re-enabling the
event, instead MaxCnt is programmed with desired period and CurCnt is
set to 0. Hence, we did not see any issues so far.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c         | 3 ++-
 arch/x86/include/asm/perf_event.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 63e1c1c11727..11123c174a3b 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1221,7 +1221,8 @@ static __init int perf_ibs_op_init(void)
 	if (ibs_caps & IBS_CAPS_OPCNTEXT) {
 		perf_ibs_op.max_period  |= IBS_OP_MAX_CNT_EXT_MASK;
 		perf_ibs_op.config_mask	|= IBS_OP_MAX_CNT_EXT_MASK;
-		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
+		perf_ibs_op.cnt_mask    |= (IBS_OP_MAX_CNT_EXT_MASK |
+					    IBS_OP_CUR_CNT_EXT_MASK);
 	}
 
 	if (ibs_caps & IBS_CAPS_ZEN4)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index cb9c4679f45c..aff9fc693b11 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -510,6 +510,7 @@ struct pebs_xmm {
  */
 #define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
 #define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
+#define IBS_OP_CUR_CNT_EXT_MASK	(0x7FULL<<52)
 #define IBS_OP_CNT_CTL		(1ULL<<19)
 #define IBS_OP_VAL		(1ULL<<18)
 #define IBS_OP_ENABLE		(1ULL<<17)
-- 
2.47.0

