Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792988359;
	b=Chm354fVsNApFKXS8GoO3CT/tIEwg6eitYIHoApTDLUDXLGIRl6e4TjkSdZQWlGNujs2
	 KEOsu2GAL2AEpyuD4e9rcZ47IChZ8XR0TGLqzcX9+vQ+Tulqt2kSc+oj/38wnjvyqYDvf
	 BOi3/kHXvlXG50FoZxIQNRl3skI0w/LmhsjQeaAb3UIaLcC8zxmncY+olocBH/YNcawzl
	 8Pp1FFfbU/E9d6duqlIdvDhB2xCN7spT3nzG2TcLsdvx/rGNShZu4O1pqEGexJE5N+NIs
	 0y23pIWo2tnWeT6K0T0jC6lSL9VyWiGp5cRt21/GkLzKwk5bn20ukpslbqzwXSnw9vQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792988359;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=CBOa4pgC3dNBlpUinxHZnLe+/WVFqJ5XuLeHUANe2N0=;
	b=DchUFr1BLSdTOHhijSnyrgmMQY4PENt4qCt+iGmeGRKrF5YU1kacYM0L7qarod9VTa8X
	 zoenRATjgoVnY+VnbPCHbDsvkSZPvbG2dMeQjIT0a1g/IrX8lNLVGTsJrllXMcTECPDeB
	 RXGfxW7/Y8ynlmXL0Gyrsu49u7S3Ch2O8YpbIRlX0oYo+Zqf/vzZmanjOWa/i2RhyBuYh
	 2esbEA1nDYUnsBnUZxMJ/onLXaP4v+TUu6gmIDC6GP8mEn5f+2iiap+iECTpzemr7xVMx
	 VT3YL4YCzJdBpc4USBGph0uMkAXa8rUxExaJSJrNfEto4/btvDUWGvp73aZdzPiEWsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NvXXV1dl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.71
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBD2606A31F;
	Mon, 26 Oct 2026 04:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFBD2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NvXXV1dl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFQpqXlSeS1QzUFIB/tgUEpqbU5+ThY8t8SffbMD4cblUl3rtSsbZZfKUc/CbQJtCvezCC+igDYww3Wb0QxbPv2mTSzDa3WDAeEKKj36DaiVwu0UE9yZpjbgmpl/Fbq2p+V1s1ZJH+H3PoCr2ubB1D65Kyd1zuO/u24bHJpjB/8W3TNi8w/vrnyoLnhAzAFW6+hyB0KQnM3Ieu+hcFbG+oBzoUGJs2h3D818YlnLK1qljXTsCMaKnpZoVJf1U7ZFoY3OAbWCVw6YSl+Zp8mDuKawwp4CA/PBbgt0BTyXWryszjEf8AsgwCXy3FLUm/kz5J6UbWoVf+DbWWdEYwdQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBOa4pgC3dNBlpUinxHZnLe+/WVFqJ5XuLeHUANe2N0=;
 b=JmtJWFeXTi8grxPlKrwxfIFB0ft7fceADfPQxx33ZLl32XQ+g2aIGIm/pcObj+d+bu3yreobpvrqeITsyYDpUdYK5aShcBavKW8K05k1taHEwoJiStCbpg3txzOc7KoZR3CFKoXZfL21psLiYQVVSRBaxSHgj1kxbCjHqC0Xa9a7czFNoDVuhfCgHq0w4mUoCCUK/CJaZI2afR19mYsT452PQthlLQp0bMpt16JblWWDnMiiVn8Ri51RhtBjA/eD/U/TY6E3XphRtGd76fgle3J8MvsezF7E+BbuW7u2paslEv47mU1Re2llCSP4v+qqkhxdsOKXRFk9WBdjykzL7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBOa4pgC3dNBlpUinxHZnLe+/WVFqJ5XuLeHUANe2N0=;
 b=NvXXV1dlPtQQk5lNCNoDgVlkSQZGR1pqRD9UsOcxbE2RZY4h9YvdVYxy9w1aatkAHitMMla30qiTy0RlsJTWeou4gLr8cfnic8jtoG5MRSiCHA02orEubtFOTszcbNvH+hsMc8yn1MPJ//dYc4YD2zLUfOsiQT8boWDkPtR+hzQ=
Received: from SJ0PR03CA0058.namprd03.prod.outlook.com (2603:10b6:a03:33e::33)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 04:19:12 +0000
Received: from SJ1PEPF000037B4.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::29) by SJ0PR03CA0058.outlook.office365.com
 (2603:10b6:a03:33e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 04:19:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037B4.mail.protection.outlook.com (10.167.244.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 04:19:12 +0000
Received: from BLR-L-RBANGORI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 25 Oct
 2026 23:19:07 -0500
From: Ravi Bangoria <ravi.bangoria@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	"Jim Mattson" <jmattson@google.com>
CC: Ravi Bangoria <ravi.bangoria@amd.com>, Jayapal Ashwin Nair
	<janair@amd.com>, Gennady Kupava <gennady.kupava@gmail.com>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	<x86@kernel.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>,
	Manali Shukla <manali.shukla@amd.com>
Subject: [PATCH v2 2/3] perf/amd/ibs: Fix kernel address leak via REGS_USER and REGS_INTR
Date: Mon, 26 Oct 2026 04:18:36 +0000
Message-ID: <20261026041838.941-3-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026041838.941-1-ravi.bangoria@amd.com>
References: <20261026041838.941-1-ravi.bangoria@amd.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B4:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e86d8fa-ad70-44bd-87d4-08df33184a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700016|1800799024|23010399003|6133799003|22082099003|18002099003|3023799007|56012099006|11063799006|261022075727099003|261021121427099003|10067099003|261009223027099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	EF70RGmb8bVt+PbVoN++oKGH4DTZNBs/2ISSl+M6jq4LK4KCmOfdhYqZ5jA4cMy5V5C2ybL0o8XBf6UB33TAf9otpc0XbxssUq4RP1dKsxJRpqcTHsqisWAm0T7VjXiptjNqsSY/S7YVyPjmCgiRWzV9gxhVJ2LN0GowB1Hxm1aZywXJEUTdPmPyiK+HMRsvvO4efVmY81mIUXsQPmkmHOWQVxKe90pPrjUOu5aLglUCMFwUU9SSVnTbeFgbJNbo7qJdBqKcDsdExCBPZq4QQsyUrEXCm3GUGuH7BOArCbCy4qhQEe4pEM9OHvh47dzN76IwIdXRNeva0alAiCvWYDxJRyTXlsr+YvjDYKSsKfxo6aX8YdJyNUtC/CIniBwPJ+K5D32/sK/bA/OKJD/OuHZNGxydqwvLtKKk4ykNuuMyTCyVEiSCYTsqM+DWcCR1lV0VtBeZu2QNWUQ6fw5o9IPw6sw+VSS6Y9dJxVA7TBNGETMp0YrsO5DjJ4Xhd6/G0+aaVK2U2OGDZIemzlzehi07I6Rf+0NQxjHNz6dYeernem/6BSLkA70mRPsgW02ln/hdjILiyegqjitimyF7BdEkpur+8UhV+dL9D16jziFMlMFAXL76XuLEILpn2VSsibJx/wde447kPDGS7iSPVQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(261022075727099003)(261021121427099003)(10067099003)(261009223027099003)(261022105027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wdcjGfJZcP1WBGML8LaT5uji8bhQIoFh9IwsZ5b2+Xn9862uiqN5TD79Z6qlw4B2/XvLcqjPHLm2KcsWutOJQPBdlj4nBt11Dp3cdKcHpHNN/Y1G9wt0AOwLZtU1/4NMJ3fCwPl3CPwVrfbO5M1squblfwgTzHxI7FJ2zKnKFqxi4jsR66AGtHwqtnb20SFnXV4dEHDtCocSucUCilrYAwg8BuqO/BHJJ9Z8mjzDbz/UXQhK3Ek351cBRxe2jFx1gl0l4nXuIzUvh3jxoyI408bmAyn2cTBH/znk2Hx7/xWE4C/mEzgnmIt4uC3VmOWpe4MoAlBUD07pIUx2PuEEPb6gElVloiq1jjl/uF4P5zSiM9/iN0X0yoc6RWi4A8UjRiaHEF3+ud343SDvl72+MtpFqFJ22c5AAX1mxgbt1NoU3WjVqdHkDcyuY7rCl99c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 04:19:12.5411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e86d8fa-ad70-44bd-87d4-08df33184a2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

IBS hardware captures a sample and raises an NMI. Since the NMI can be
delivered with a delay, a privilege change may occur between sample
capture and NMI delivery. Because IBS only provides the sample RIP, the
kernel records GPRs from the NMI pt_regs, which may reflect kernel mode
if a privilege switch occurred in the interim. This can leak kernel
addresses to unprivileged users through PERF_SAMPLE_REGS_USER and/or
PERF_SAMPLE_REGS_INTR.

Fix this by using interrupt regs while preparing PERF_SAMPLE_REGS_USER
and PERF_SAMPLE_REGS_INTR. With the change, when IBS samples a user mode
instruction but the NMI is delivered in kernel mode, PERF_SAMPLE_REGS_USER
will source its register state from task_pt_regs(current) and
PERF_SAMPLE_REGS_INTR will be omitted from the data sent to userspace.

In addition to fixing the kernel address leak, this change also ensures
GPR snapshot consistency, which resolves the DWARF unwinding issue with
IBS.

Reported-by: Gennady Kupava <gennady.kupava@gmail.com>
Closes: https://lore.kernel.org/r/CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com
Reported-by: Jayapal Ashwin Nair <janair@amd.com>
Fixes: d29e744c7167 ("perf/x86: Relax privilege filter restriction on AMD IBS")
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 arch/x86/events/amd/ibs.c  | 50 ++++++++++++++++++++++++++++++++++++++
 include/linux/perf_event.h |  6 +++++
 kernel/events/core.c       | 10 ++++----
 3 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index bfb51f8e184f..78a36ebf2d23 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1533,6 +1533,56 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 		throttle = perf_event_account_interrupt(event);
 		goto out;
 	}
+
+	/*
+	 * IBS captured RIP is out of sync with NMI pt_regs due to NMI
+	 * delivery latency. Use NMI pt_regs for PERF_SAMPLE_REGS_USER.
+	 *
+	 * Note: Valid user regs are required for PERF_SAMPLE_STACK_USER.
+	 */
+	if (event->attr.sample_type & (PERF_SAMPLE_REGS_USER |
+				       PERF_SAMPLE_STACK_USER)) {
+		perf_sample_regs_user(&data.regs_user, iregs);
+
+		/*
+		 * Don't update dyn_size if user has not requrested for
+		 * PERF_SAMPLE_REGS_USER.
+		 */
+		if (event->attr.sample_type & PERF_SAMPLE_REGS_USER) {
+			/* regs dump ABI info */
+			int size = sizeof(u64);
+
+			if (data.regs_user.regs) {
+				u64 mask = event->attr.sample_regs_user;
+				size += hweight64(mask) * sizeof(u64);
+			}
+
+			data.dyn_size += size;
+		}
+
+		data.sample_flags |= PERF_SAMPLE_REGS_USER;
+	}
+
+	/*
+	 * IBS captured RIP is out of sync with NMI pt_regs due to NMI
+	 * delivery latency. Use NMI pt_regs for PERF_SAMPLE_REGS_INTR.
+	 */
+	if (event->attr.sample_type & PERF_SAMPLE_REGS_INTR) {
+		/* regs dump ABI info */
+		int size = sizeof(u64);
+
+		perf_sample_regs_intr(&data.regs_intr, iregs,
+				      event->attr.exclude_kernel);
+
+		if (data.regs_intr.regs) {
+			u64 mask = event->attr.sample_regs_intr;
+			size += hweight64(mask) * sizeof(u64);
+		}
+
+		data.dyn_size += size;
+		data.sample_flags |= PERF_SAMPLE_REGS_INTR;
+	}
+
 	/*
 	 * Prevent leaking physical addresses to unprivileged users. Skip
 	 * PERF_SAMPLE_PHYS_ADDR check since generic code prevents it for
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2d5e7687875b..ca495f6b03c4 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1791,6 +1791,12 @@ extern unsigned long perf_misc_flags(struct perf_event *event, struct pt_regs *r
 extern unsigned long perf_instruction_pointer(struct perf_event *event,
 					      struct pt_regs *regs);
 
+extern void perf_sample_regs_user(struct perf_regs *regs_user,
+				  struct pt_regs *regs);
+extern void perf_sample_regs_intr(struct perf_regs *regs_intr,
+				  struct pt_regs *regs,
+				  bool exclude_kernel);
+
 #ifndef perf_arch_misc_flags
 # define perf_arch_misc_flags(regs) \
 		(user_mode(regs) ? PERF_RECORD_MISC_USER : PERF_RECORD_MISC_KERNEL)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7846d70be57f..69b767ace309 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7846,8 +7846,8 @@ perf_output_sample_regs(struct perf_output_handle *handle,
 	}
 }
 
-static void perf_sample_regs_user(struct perf_regs *regs_user,
-				  struct pt_regs *regs)
+void perf_sample_regs_user(struct perf_regs *regs_user,
+			   struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		regs_user->abi = perf_reg_abi(current);
@@ -7860,9 +7860,9 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
 	}
 }
 
-static void perf_sample_regs_intr(struct perf_regs *regs_intr,
-				  struct pt_regs *regs,
-				  bool exclude_kernel)
+void perf_sample_regs_intr(struct perf_regs *regs_intr,
+			   struct pt_regs *regs,
+			   bool exclude_kernel)
 {
 	/*
 	 * Hardware skid can lead to a scenario where a PMI is
-- 
2.55.0

