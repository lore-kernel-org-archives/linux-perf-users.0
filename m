Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADE5322B67;
	Fri, 16 Jan 2026 03:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768534568; cv=fail; b=Jw7R7+hHiILrOuEyMu0bG9o+EXXUE1GThODcVLm/e1K5lKtpi+80RbgI5YgdgPxNH2N4VKz+lAHmJrju32NsozikZbukMxgJjt0pKizzR4rXEyQX5uRFtdszkoSlLOCLkMKZ9OtG5qPDUpo8UjSfOx6nPgeKsWfPSdgLVJQuzFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768534568; c=relaxed/simple;
	bh=kPqz5tq45SyTIIGHm+WUe6k2h+IXZC59euz3Wkf56fI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMOFR8J8JvYXaSDYTCHe8ansilbaaAYZXGFRSCR1416U8W9h/6Z4WohINhtD1SzaP6KqU9BkInoRrFN6oDTuZJYice+j31xU4nkAV/Jd4Rij1vbP889ssJmpD8mTPfNxnNFd1Y9pQJFLC/dEuXQfVF0pxGsb8xhWvL5Lij7Uk7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xePFpKEe; arc=fail smtp.client-ip=52.101.46.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xePFpKEe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1CYFrQ0e1zgfM50tXwg00v5PFR+jQ0sB7hdSvnYGYAPRXulu5KoZn4wFf7KzO2LbJpqTrJSYNU6n48nmBRclMCUhkJ6ZVdYTbqCREIc1Jt2JKReZi43ExY+fqxOWD/IXuYBlGmJfbTMX0+r0IrFQom2RPA2yEGw/KNtZrL1qKEZXtNy3zhcBoybAwRCH1UFXatupSI53jghblw/BsVmrR82UCIlg1n1Vey+vvm4clkSglPTOp3dN5rxWqbGKlAj0HvkQnMuZ13l4ODFkdMLQv9MhDspaQfwTpic3Mt0fn7INuod6SUEigJX+vqOWBG3TO6KNBTxlrgKHYCpKYzcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zEk5LLJbF2B6KlJWDQeVcX9foqFbCwJCRKWcAmyK2g=;
 b=maz3fOGRQk+Ca85/ClMmptTuRMGSb58iRfOCNwhUOHkePjF07GPBdsWZWJMwQkNzrwNT5BofQjl5Qw/n+uQ/A992N3vA1b0O+Ge2t9gGYHqS0I3U8YnH+9M8wzjiHPR8Z8a1LLS2mFNRqRrO1izfoNFKvS+Ce5ri2MNKtD2/WIOWxvHTRCmkIaB4q2AxQMwNBJpgPBxJsrOCp/xdybzFmEJKIswEMqjftsWjnEHzEEcnkHhBOO3uYrEulj4dOriVwFIICducKWYeJHq/GxNJsLvBrxsURcf0OFfrnV58BSdnSfSc+JvDBhwPXHNEgOmAKiR32NCsE3Jqm8dCFly7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zEk5LLJbF2B6KlJWDQeVcX9foqFbCwJCRKWcAmyK2g=;
 b=xePFpKEe2HqFjCjZ+m5NQ3WRDAV5zb2VkZ2lWh0oqIG1NMlPqtoCuZLUm7l8bQXQQODGUztdLL4QzvxivpbXtB8rhv4MLLQcjL9mcsXgLtYvFbzYwTnndwBy0AiyY258+lciYZpaAEg5GVWkAuh1uNQ75lxOEkUwqqRrsjFUqdw=
Received: from BN9PR03CA0581.namprd03.prod.outlook.com (2603:10b6:408:10d::16)
 by DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 03:36:03 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:10d:cafe::5e) by BN9PR03CA0581.outlook.office365.com
 (2603:10b6:408:10d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 03:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 03:36:02 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 21:35:57 -0600
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
	<irogers@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, <x86@kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Manali
 Shukla" <manali.shukla@amd.com>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH 09/11] perf/amd/ibs: Enable RIP bit63 hardware filtering
Date: Fri, 16 Jan 2026 03:34:48 +0000
Message-ID: <20260116033450.965-10-ravi.bangoria@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|DS2PR12MB9567:EE_
X-MS-Office365-Filtering-Correlation-Id: dae5d174-49ef-4d59-2d47-08de54b05f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SoP57MSGTBd8oAu65z3lsrp3ZKO8fy3F2HxG7QH6RT67/FPXjNV5LO9JHxn2?=
 =?us-ascii?Q?1ud0QKppNLLK2njmTy4UWc32n3yKloMV9l1LTOD5uNRDUPGwPYX7BvKEk+3b?=
 =?us-ascii?Q?gSNRnBApOcSSamEtddU15x1RQE5g7QXWasH1me5zde9MfN+jXwLTr69x0aw5?=
 =?us-ascii?Q?gvFsbqfUNORlTJn4UzB3WwF3u93gzSV8Y0kl3A4kccLSrCIZO39SG38+1Jtz?=
 =?us-ascii?Q?iu2CMGd3WJKDuRUPDdVwJhcUjje/rjlUkDdj3VVv5mJ69VrnfmxKU1ioHQHd?=
 =?us-ascii?Q?HotU8VXRlfya2xSiAc2/Gz+bjWTUEjwRqFIDFOp6LZdR/jUJonlTgs5QEcZa?=
 =?us-ascii?Q?YmAC4+ZHWIcPhPQV/Uh9eikCZuWg1UiR0Da+RjUJERpIm0ewjhC9FzQp1lIE?=
 =?us-ascii?Q?UYmYq6xs49OxToOLRK0+ZTTSrzUlzup1E0eVGiu+32yTZHtv3ecaHLGeC4YK?=
 =?us-ascii?Q?JnrXAXWnHcYO95ekLYnkLRBlskCDqFuZcTnxLuH8m3/VG1jWydfho2IOw9tK?=
 =?us-ascii?Q?fOuKal9pN3R6Ued9t2ueHPmKjBJr0j3XZUuOBWa/GWyvlFurF5dnl+u7oqR6?=
 =?us-ascii?Q?p+pYcjLyZ1rSzt+2+ZYqUWZ302sy/AmbwQhbpoBIEZltGBrkdjioHub5QY5e?=
 =?us-ascii?Q?bETCpYpShvpxk7MiovxWH7ioyZwLHW6P5mrPvcIZTwl/jypDUV/42PckNrDg?=
 =?us-ascii?Q?xCVApjGVCfY2iBNA/mKgiJlrNznja8XsZzEKcp55HPTjLexRxnHpthniLgXd?=
 =?us-ascii?Q?TBaR93YRGsP/U1ElqaHv8l2P7tIZfrPFcb36zWwmfgSAs9XCZRpgjSYb2ysD?=
 =?us-ascii?Q?O1Wx8TwqHPgM5LgSOkkVDERDouJhKbfksVWcei6jUDzpCZuOHMNZx0aBI3+O?=
 =?us-ascii?Q?WMlx9/mMqaVxcU8Jlao75agDlEQytYEco+pgN/wpxYFX19i/gaDBmbJ5U1OO?=
 =?us-ascii?Q?UVFY81u6e/vLd7fDuhte+dE18iwiYkM+8hfdzmEavOETvLw7LGNZK7vEunCX?=
 =?us-ascii?Q?1+klSFiO0YzUa44H8UAEoaaTHCAUyuGpVRtqZtQcukxZPLTG0WFojFBxm5d4?=
 =?us-ascii?Q?g98pHZY4x0/rs4xbpgibaUsIpLwbeYrjOhIq9ho06ucRg8MdOkVLYRK7AP+Q?=
 =?us-ascii?Q?gwElxIb0i1rcwdEOOfXKV8I4F/DJdur/5Xg1uf7Oc9Qp+95I153Wkvuok17c?=
 =?us-ascii?Q?Enz7nFSQgdFpt3etkiHu3Rg7jLcfDjhT1u2KNyJe1HuI6yXEnYVUt2eYU+2W?=
 =?us-ascii?Q?E6T0xT+FYR3308uPNQaBnlZfI1lPP3LeZD4O83n+Qy21I8KvSLct06aK4Ifp?=
 =?us-ascii?Q?wn1Ps918h1R3Nj2SzETDR0LwXDWj9inRvXQ84Hevqao1jKfhH/hFzzZLmSxg?=
 =?us-ascii?Q?KUdIqB2eTC1Py4aOPoAsasQGrhz25CJc4S0iWxIhSuUKniVyLuaCefwsYPtU?=
 =?us-ascii?Q?bfhasCX3S0OEuO+PKUoZbxAA1v7qdXHdlIhcTvEVoIbExycYEfGBuMOp6Xes?=
 =?us-ascii?Q?s3fdcNxGV88J/Cjrw7JPqkrPAuO5Yz1gVeTm0x7/eADt/pjR+mQ8lzbIasAu?=
 =?us-ascii?Q?Hj5JxYibJ/my9zd+9l0adLMgCqc7MtB9gez6PUF6LuVu9BwJedSgxfsOA+iO?=
 =?us-ascii?Q?R2QGpaZOTMZ6P6Odlt0x2XwSQLI6w08ZjU6EQ2rJkLJ6bhCmMVqO4dH+VCNH?=
 =?us-ascii?Q?rxmohg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 03:36:02.6048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dae5d174-49ef-4d59-2d47-08de54b05f81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9567

IBS on future hardware adds the ability to filter IBS events by examining
RIP bit 63. Because Linux kernel addresses always have bit 63 set while
user-space addresses never do, this capability can be used as a privilege
filter.

So far, IBS supports privilege filtering in software (swfilt=1), where
samples are dropped in the NMI handler. The RIP bit63 hardware filter
enables IBS to be usable by unprivileged users without passing swfilt
flag. So, swfilt flag will silently be ignored when the hardware
filtering capability is present.

Example (non-root user):
  $ perf record -e ibs_op//u -- <workload>

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 46 ++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index b2d21026edae..a768a82d7ad2 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -321,11 +321,6 @@ static int perf_ibs_init(struct perf_event *event)
 	    event->attr.exclude_idle)
 		return -EINVAL;
 
-	if (!(event->attr.config2 & IBS_SW_FILTER_MASK) &&
-	    (event->attr.exclude_kernel || event->attr.exclude_user ||
-	     event->attr.exclude_hv))
-		return -EINVAL;
-
 	ret = validate_group(event);
 	if (ret)
 		return ret;
@@ -335,6 +330,32 @@ static int perf_ibs_init(struct perf_event *event)
 		hwc->extra_reg.reg = perf_ibs->msr2;
 	}
 
+	if (ibs_caps & IBS_CAPS_BIT63_FILTER) {
+		if (perf_ibs == &perf_ibs_fetch) {
+			if (event->attr.exclude_kernel) {
+				hwc->extra_reg.config |= IBS_FETCH_2_EXCL_RIP_63_EQ_1;
+				hwc->extra_reg.reg = perf_ibs->msr2;
+			}
+			if (event->attr.exclude_user) {
+				hwc->extra_reg.config |= IBS_FETCH_2_EXCL_RIP_63_EQ_0;
+				hwc->extra_reg.reg = perf_ibs->msr2;
+			}
+		} else {
+			if (event->attr.exclude_kernel) {
+				hwc->extra_reg.config |= IBS_OP_2_EXCL_RIP_63_EQ_1;
+				hwc->extra_reg.reg = perf_ibs->msr2;
+			}
+			if (event->attr.exclude_user) {
+				hwc->extra_reg.config |= IBS_OP_2_EXCL_RIP_63_EQ_0;
+				hwc->extra_reg.reg = perf_ibs->msr2;
+			}
+		}
+	} else if (!(event->attr.config2 & IBS_SW_FILTER_MASK) &&
+		   (event->attr.exclude_kernel || event->attr.exclude_user ||
+		    event->attr.exclude_hv)) {
+		return -EINVAL;
+	}
+
 	if (hwc->sample_period) {
 		if (config & perf_ibs->cnt_mask)
 			/* raw max_cnt may not be set */
@@ -1277,7 +1298,7 @@ static bool perf_ibs_is_kernel_br_target(struct perf_event *event,
 			op_data.op_brn_ret && kernel_ip(br_target));
 }
 
-static bool perf_ibs_swfilt_discard(struct perf_ibs *perf_ibs, struct perf_event *event,
+static bool perf_ibs_discard_sample(struct perf_ibs *perf_ibs, struct perf_event *event,
 				    struct pt_regs *regs, struct perf_ibs_data *ibs_data,
 				    int br_target_idx)
 {
@@ -1430,8 +1451,9 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		regs.flags |= PERF_EFLAGS_EXACT;
 	}
 
-	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
-	    perf_ibs_swfilt_discard(perf_ibs, event, &regs, &ibs_data, br_target_idx)) {
+	if (((ibs_caps & IBS_CAPS_BIT63_FILTER) ||
+	     (event->attr.config2 & IBS_SW_FILTER_MASK)) &&
+	    perf_ibs_discard_sample(perf_ibs, event, &regs, &ibs_data, br_target_idx)) {
 		throttle = perf_event_account_interrupt(event);
 		goto out;
 	}
@@ -1894,6 +1916,14 @@ static __init int amd_ibs_init(void)
 
 	perf_ibs_pm_init();
 
+#ifdef CONFIG_X86_32
+	/*
+	 * IBS_CAPS_BIT63_FILTER is used for exclude_kernel/user filtering,
+	 * which obviously won't work for 32 bit kernel.
+	 */
+	caps &= ~IBS_CAPS_BIT63_FILTER;
+#endif
+
 	ibs_caps = caps;
 	/* make ibs_caps visible to other cpus: */
 	smp_mb();
-- 
2.43.0

