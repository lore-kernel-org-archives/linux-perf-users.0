Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C5C26FA5B;
	Mon,  9 Mar 2026 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773025113; cv=fail; b=qsxQnzxv4DQIT0xa9sGiTr4BOTVBngvE1ESIt/JxS+GwKr2JZK8/Mlkr6vEdAFMMEYJXzmDWE6IioiTWYE4DaGycV5SDqbggtUwma4HDhoWtyU896clJvIvxcBoek3bfKGZigOcdjXGAvnIgBCQ0tZz7N/IJ46z9m3r6VDOwXRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773025113; c=relaxed/simple;
	bh=erYGmpCDpC+j/bCE1rWgu/bAW5QKxJeDc/FcgYhcYSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qj14hB+GUVzb8nEhOCqZw1lYMMdjNbtMJ2Qcw+hGQR4BZo0buehe1qNxsGFTVuf/zLR/KwHwq34YU4qC75JaGQhXOvMb1RQ6689TkuXe5JD9B8Izodaj6rhMsAE60JVqCW4+gJMTFstpG6Up2aLPKX//uLIshHG5/iLRUYK9zj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w5OHIaO3; arc=fail smtp.client-ip=40.107.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w5OHIaO3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTB3uQeTFuXt1O4QinrgAMzGwVvywEhOqpEGBGa5Kd3lrZZZhs/2beQYVA1inbNz6huDis6x6iAhupNnloqmUBvIR4qOW/vl+4Oe/uIEp10ayhxNillX3eRx9RG4sPygvwFRsS4C4073EoF8ujCvhhdhroGc1tSNXM95RE3VjjvUk9bpfzHk8ocAy9gPnrFtPBoDrRyWQnqPZEyCwoEsETb1pdvdDU+S/y7fAK81xDp/XtAQW8bx7Y2063eeDkvDAPCbGwQ5NWYmB1hlhU6wA0d91V49PzdKm+JMSR2a7jyw9DgbHMQXXCBHhS10MkE2mcQu8Tje9kL/vSOkzoD45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8duVZr6p/2PnW3s58D7oeXe7iX+x22vgsYGlCuaudNI=;
 b=fIIky1fKx7UOji0Tf0goycwDFmU1pQP87pRvlhadYiPLowgk2K1Poy4loDWBKWxDfInuaD4Z/GKZUPv4ZD9tKjh2YxoMQ08Fv54axjducCKBVsE5P9sgwDIrVOPVj/T17kNSmGFwG5Aam8IpdfnisMmJeazq2G58bHNmFCODvr3U7jgtPpSVwOxRore3xfx5VXi247usMuXxL3oOB+5n0A/5Yw9cE+KW2DtdtPi9rJM+UZGz2YF76joxLKhpd2rWhlR+wwh/Bicrk97awvMO+Nhs5Rx4D4dM3k21Cx2euAJFIym1kcPJUv8A1LlMN4b76Wl53OUnSvnXoHFlIJX1lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8duVZr6p/2PnW3s58D7oeXe7iX+x22vgsYGlCuaudNI=;
 b=w5OHIaO3E0scRW4rc0b0GYw6+oWtLFbHxwlQIF1rCtavOQiBJ71OzfSUpFxIjTfTQDbIaiqy4odKutPJXONox9C9Q13dAHCp/Y/4lTZCd0Lv9C3XOggwbK6gTcoTzm6+s91DU0Bmfq4WPy7NFX448xrwf4imwJTzHC0CESkDvKg=
Received: from CH0PR03CA0405.namprd03.prod.outlook.com (2603:10b6:610:11b::15)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 02:58:26 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::ce) by CH0PR03CA0405.outlook.office365.com
 (2603:10b6:610:11b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 02:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 02:58:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 8 Mar
 2026 21:58:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 8 Mar
 2026 21:58:25 -0500
Received: from [172.31.177.127] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 8 Mar 2026 21:58:21 -0500
Message-ID: <3b6ff125-4110-4fbd-9da9-c510b3d43106@amd.com>
Date: Mon, 9 Mar 2026 08:28:20 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] perf/amd/ibs: Enable RIP bit63 hardware filtering
To: Ian Rogers <irogers@google.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, James Clark
	<james.clark@linaro.org>, Sadasivan Shaiju <sadasivan.shaiju2@amd.com>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>, Ananth Narayan
	<ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>, "Stephane
 Eranian" <eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20260216042530.1546-1-ravi.bangoria@amd.com>
 <20260216042530.1546-6-ravi.bangoria@amd.com>
 <CAP-5=fV_cJskvLRZhQQXMGAcPUb_Rg_b30PDJNXzxL49JK4B5g@mail.gmail.com>
 <8b99652d-155a-444e-8395-d461714bf4b8@amd.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <8b99652d-155a-444e-8395-d461714bf4b8@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: 22193b55-c9fe-4985-9752-08de7d87bbda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	ZHk+xBirjrmsDquk/mlO2Em+urNVy9kXSkyqRm3vff8k4NevKS75c9t9VcKhqh3/RBKfUO0xu73RT18xNHg2LRio4/mNi1eV1lZNP+xL5yFazTepC2HJwhROR+6qenb8P/nnQoEukDitwbZfHjb8Ulso3piof/4KX51gOcoRiqbVnMNnCKEGM7S8Vk0eiHSqCOuuA6G6TNoB+QrAyLk412sjC/htkG5ai3hjBu37xyXGRdSqoV+JXvrHhY6hd9wvXV2kqxJOJTxN1Nd5S6m/9YYhtXKMsoE9ICwphedJzuasZM7Xk31v9/QxQo/W7ErbaMnrJGBQVVH3W4xOvozItt5muJxnsR5+QzUNoekytDMZdZlrCk4ptBRSMNuDeDRbAeOaSK7eFskcfVgZnzRQu+lTMhNE6lEYg/IgEwRPxbUXNhx1JE27wm2TI93gkESMUuFprUgsJZHb1eKF3xWrKf4qI0MufljsNCEjj4Zbs8tUN5oGBCGvEvdFa2VJg8C17T60FtNQAob7QZw1HpFQBKp35RJzdPVOIZpXmTuN8RUtvMXHM0g/CIsOskCb3+ZsoUKQ8TfBLONzrCeR+uBxytfQ9QcaTZtHaQnHn8M25d+c999d6GDK0kDahmUshaEuJ08PRMrJqq7JSDEHIP618IgMoOUTlZZ3lYELZva2Wc8GJ2GhogIkNXyTZNqrdWS5TqY/8gcS/7gJFqT1c0g8epOTB7fNpqkdoUl62Pw0RYQmNpqdpa5LFUzi4SsL3dvqBHHTUvHvJqu9/Ys+STuvnA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/IghP9thR1gfjz9o9hY9zrTy0RdmfBaXpBumCFWYwZmwnBpQ+l857L3g+1I12+fayefEdOXnmnUSwS2gMb1dhKkS5AFVJZeiXhO9GudNCAAR03VcA3qeZx6sMppIPT9PREDUBuTJdLK4XbFU/7ohiIV5q94vV7i0M5TbKGGH4WMCmej1hWiaJeAIei0tvy9WBaJ0Kpt4GkuMgp3XOvXbEtCc/EIJEdj0w5abgzBNqwPLtWDvxJL6g2O0+hr4LvV4v1bgmyV5AT0wKk1zuOy9CkJ3NyqNgl/2LnFrCKufP5zAW2x8HO//pbR0Ifgj1w5TQRrpFZjhGbqjxCQqCTEFUwZcBU3YlJDwzFBO+FSZ91YzwmE6y6vePh95B8yvPLT9mVU5EdUUeaHLxTNKPcn8mXcPIwhawRxmFT5v86kt/qxYEQ7GLVL+l+/P5sLCKvm/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 02:58:25.8372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22193b55-c9fe-4985-9752-08de7d87bbda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590

Hi Ian,

>> Does the bit 63 assumption hold for guest operating systems?
> 
> Yes, this seems to be an issue, even with current swfilt approach. Let
> me inspect the code and get back.

All mainstream 64 bit OSes use the bit-63 set for kernel addresses and zero
for userspace addresses. This norm does not apply to 32 bit guests, but
those are rare, and profiling them with IBS would be even rarer. So, I'll
document this limitation in the perf-amd-ibs man page.

While looking at this, I found some issues in IBS. Below patch fixes it:

---

From deb6cdcbc60778b57a6eef60b2b7bd1b8e3cea74 Mon Sep 17 00:00:00 2001
From: Ravi Bangoria <ravi.bangoria@amd.com>
Date: Fri, 6 Mar 2026 04:52:00 +0000
Subject: [PATCH] perf/amd/ibs: Improve guest profiling

IBS captures the RIP but not its privilege level. Since the NMI is
delivered with delay, CPL can change between the IBS tag and NMI
delivery. Add a check to catch and discard invalid guest samples
using CPL stored in vCPU save area. This will work when there is
user/kernel CPL change in between IBS tag and NMI delivery within
the guest boundary. But it won't work when there is a guest entry
or exit in between IBS tag and NMI delivery.

When profiling a guest and the IBS RIP is valid, assign the sample
IP from the IBS-captured RIP and set PERF_SAMPLE_IP in sample_flags
so that perf_prepare_sample() do not overwrite the RIP with
perf_guest_get_ip() from the vCPU save area. This keeps the perf
sample IP consistent with IBS raw data, data_src, weight, phy_addr
etc. The privilege level in the perf "misc" field can now go out
of sync, as it is taken from the vCPU save area.

Reported-by: Ian Rogers <irogers@google.com>
Closes: https://lore.kernel.org/r/CAP-5=fV_cJskvLRZhQQXMGAcPUb_Rg_b30PDJNXzxL49JK4B5g@mail.gmail.com
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index eeb607b84dda..70408b0b1597 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1415,6 +1415,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	unsigned int msr;
 	u64 *buf, *config, period, new_config = 0;
 	int br_target_idx = -1;
+	unsigned int guest_state;
 
 	if (!test_bit(IBS_STARTED, pcpu->state)) {
 fail:
@@ -1526,6 +1527,42 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		regs.flags |= PERF_EFLAGS_EXACT;
 	}
 
+	guest_state = perf_guest_state();
+	if (!event->attr.exclude_guest && guest_state & PERF_GUEST_ACTIVE) {
+		/*
+		 * IBS captures the RIP but not its privilege level. Since
+		 * NMI arrives delayed, CPL might change in between IBS tag
+		 * and the NMI delivery. Below checks can identify and filter
+		 * out invalid samples when the CPL changes are within the
+		 * guest boundary. However, these checks fail to handle cases
+		 * where the CPU performs a guest entry or exit in between
+		 * the IBS tag and the NMI delivery.
+		 */
+		if (event->attr.exclude_kernel && !(guest_state & PERF_GUEST_USER)) {
+			throttle = perf_event_account_interrupt(event);
+			goto out;
+		}
+		if (event->attr.exclude_user && guest_state & PERF_GUEST_USER) {
+			throttle = perf_event_account_interrupt(event);
+			goto out;
+		}
+
+		/*
+		 * Assign the IBS RIP value directly in the perf sample here
+		 * to prevent perf_prepare_sample() from retrieving it from
+		 * the vCPU save-area. With this, rest of the perf sample
+		 * fields (raw data, data_src, weight, phy_addr, etc.) will
+		 * remain in sync with sample IP. However, privilege level
+		 * captured as part of perf sample "misc" field could now
+		 * go out of sync since privilege level is fetched from the
+		 * vCPU save area.
+		 */
+		if (regs.flags & PERF_EFLAGS_EXACT) {
+			data.ip = regs.ip;
+			data.sample_flags |= PERF_SAMPLE_IP;
+		}
+	}
+
 	if (((ibs_caps & IBS_CAPS_BIT63_FILTER) ||
 	     (event->attr.config2 & IBS_SW_FILTER_MASK)) &&
 	    perf_ibs_discard_sample(perf_ibs, event, &regs, &ibs_data, br_target_idx)) {
-- 
2.43.0


